import 'dart:io';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/card_rendering.pb.dart'
    as card_rendering_pb;
import 'package:anki_flutter/features/reviewer/audio/review_tts_service.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory tempRoot;

  setUp(() async {
    tempRoot = await Directory.systemTemp.createTemp('anki_flutter_tts_test_');
  });

  tearDown(() async {
    if (await tempRoot.exists()) {
      await tempRoot.delete(recursive: true);
    }
  });

  test('requested voice order wins after Anki-compatible normalization', () async {
    card_rendering_pb.AllTtsVoicesRequest? voicesRequest;
    card_rendering_pb.WriteTtsStreamRequest? writeRequest;
    final backend = _FakeBackend((operation, request) async {
      switch (operation) {
        case BackendOperation.allTtsVoices:
          voicesRequest = card_rendering_pb.AllTtsVoicesRequest.fromBuffer(request);
          return _bytes(
            card_rendering_pb.AllTtsVoicesResponse(
              voices: [
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'second-id',
                  name: 'Second Voice',
                  language: 'en-US',
                  available: true,
                ),
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'first-id',
                  name: 'First Voice',
                  language: 'en-US',
                  available: true,
                ),
              ],
            ),
          );
        case BackendOperation.writeTtsStream:
          writeRequest = card_rendering_pb.WriteTtsStreamRequest.fromBuffer(request);
          File(writeRequest!.path).writeAsBytesSync([1, 2, 3]);
          return Uint8List(0);
        default:
          fail('unexpected operation $operation');
      }
    });
    final service = AnkiReviewTtsService(
      backend: backend,
      tempDirectoryProvider: () async => tempRoot,
    );
    final tag = ReviewTtsTag(
      text: 'hello world',
      language: 'en_US',
      voices: ['First_Voice', 'Second_Voice'],
      speed: 1.25,
      otherArgs: const [],
    );

    final uri = await service.materialize(tag);

    expect(voicesRequest, isNotNull);
    expect(voicesRequest!.validate, isTrue);
    expect(writeRequest, isNotNull);
    expect(writeRequest!.voiceId, 'first-id');
    expect(writeRequest!.speed, closeTo(1.25, 0.0001));
    expect(writeRequest!.text, 'hello world');
    expect(uri, isNotNull);
    expect(uri!.scheme, 'file');
    expect(File.fromUri(uri).existsSync(), isTrue);
    expect(_isInside(tempRoot.path, File.fromUri(uri).path), isTrue);

    await service.dispose();
  });

  test('falls back to first available voice for the requested language', () async {
    String? selectedVoiceId;
    final backend = _FakeBackend((operation, request) async {
      switch (operation) {
        case BackendOperation.allTtsVoices:
          return _bytes(
            card_rendering_pb.AllTtsVoicesResponse(
              voices: [
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'french-id',
                  name: 'French Voice',
                  language: 'fr-FR',
                  available: true,
                ),
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'english-id',
                  name: 'English Voice',
                  language: 'en-US',
                  available: true,
                ),
              ],
            ),
          );
        case BackendOperation.writeTtsStream:
          final input = card_rendering_pb.WriteTtsStreamRequest.fromBuffer(request);
          selectedVoiceId = input.voiceId;
          File(input.path).writeAsBytesSync([4]);
          return Uint8List(0);
        default:
          fail('unexpected operation $operation');
      }
    });
    final service = AnkiReviewTtsService(
      backend: backend,
      tempDirectoryProvider: () async => tempRoot,
    );

    final uri = await service.materialize(
      ReviewTtsTag(
        text: 'fallback',
        language: 'en_US',
        voices: const ['Missing_Voice'],
        speed: 1,
        otherArgs: const [],
      ),
    );

    expect(uri, isNotNull);
    expect(selectedVoiceId, 'english-id');
    await service.dispose();
  });

  test('unavailable or wrong-language voices return null without writing', () async {
    var writeCalls = 0;
    final backend = _FakeBackend((operation, request) async {
      switch (operation) {
        case BackendOperation.allTtsVoices:
          return _bytes(
            card_rendering_pb.AllTtsVoicesResponse(
              voices: [
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'unavailable-id',
                  name: 'Requested Voice',
                  language: 'en-US',
                  available: false,
                ),
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'other-id',
                  name: 'Other Voice',
                  language: 'de-DE',
                  available: true,
                ),
              ],
            ),
          );
        case BackendOperation.writeTtsStream:
          writeCalls += 1;
          return Uint8List(0);
        default:
          fail('unexpected operation $operation');
      }
    });
    final service = AnkiReviewTtsService(
      backend: backend,
      tempDirectoryProvider: () async => tempRoot,
    );

    final uri = await service.materialize(
      ReviewTtsTag(
        text: 'hello',
        language: 'en_US',
        voices: const ['Requested_Voice'],
        speed: 1,
        otherArgs: const [],
      ),
    );

    expect(uri, isNull);
    expect(writeCalls, 0);
    await service.dispose();
  });

  test('backend TTS unavailability is non-fatal', () async {
    final backend = _FakeBackend((operation, request) async {
      throw const AnkiBackendException(
        kind: 1,
        message: 'not implemented for this OS',
        context: 'AllTtsVoices',
      );
    });
    final service = AnkiReviewTtsService(
      backend: backend,
      tempDirectoryProvider: () async => tempRoot,
    );

    final uri = await service.materialize(
      ReviewTtsTag(
        text: 'hello',
        language: 'en_US',
        voices: const [],
        speed: 1,
        otherArgs: const [],
      ),
    );

    expect(uri, isNull);
    await service.dispose();
  });

  test('write failure is non-fatal and does not leak generated temp files', () async {
    final backend = _FakeBackend((operation, request) async {
      switch (operation) {
        case BackendOperation.allTtsVoices:
          return _bytes(
            card_rendering_pb.AllTtsVoicesResponse(
              voices: [
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'voice-id',
                  name: 'Voice',
                  language: 'en-US',
                  available: true,
                ),
              ],
            ),
          );
        case BackendOperation.writeTtsStream:
          throw const AnkiBackendException(
            kind: 1,
            message: 'tts runtime error',
            context: 'WriteTtsStream',
          );
        default:
          fail('unexpected operation $operation');
      }
    });
    final service = AnkiReviewTtsService(
      backend: backend,
      tempDirectoryProvider: () async => tempRoot,
    );

    final uri = await service.materialize(
      ReviewTtsTag(
        text: 'hello',
        language: 'en_US',
        voices: const ['Voice'],
        speed: 1,
        otherArgs: const [],
      ),
    );

    expect(uri, isNull);
    expect(tempRoot.listSync(), isEmpty);
    await service.dispose();
  });

  test('dispose deletes generated TTS files and is idempotent', () async {
    final backend = _FakeBackend((operation, request) async {
      switch (operation) {
        case BackendOperation.allTtsVoices:
          return _bytes(
            card_rendering_pb.AllTtsVoicesResponse(
              voices: [
                card_rendering_pb.AllTtsVoicesResponse_TtsVoice(
                  id: 'voice-id',
                  name: 'Voice',
                  language: 'en-US',
                  available: true,
                ),
              ],
            ),
          );
        case BackendOperation.writeTtsStream:
          final input = card_rendering_pb.WriteTtsStreamRequest.fromBuffer(request);
          File(input.path).writeAsBytesSync([9]);
          return Uint8List(0);
        default:
          fail('unexpected operation $operation');
      }
    });
    final service = AnkiReviewTtsService(
      backend: backend,
      tempDirectoryProvider: () async => tempRoot,
    );

    final uri = await service.materialize(
      ReviewTtsTag(
        text: 'cleanup',
        language: 'en_US',
        voices: const ['Voice'],
        speed: 1,
        otherArgs: const [],
      ),
    );
    expect(uri, isNotNull);
    final generatedFile = File.fromUri(uri!);
    expect(generatedFile.existsSync(), isTrue);

    await service.dispose();
    await service.dispose();

    expect(generatedFile.existsSync(), isFalse);
    expect(tempRoot.existsSync(), isTrue);
    expect(tempRoot.listSync(), isEmpty);
  });
}

Uint8List _bytes(card_rendering_pb.AllTtsVoicesResponse response) {
  return Uint8List.fromList(response.writeToBuffer());
}

bool _isInside(String root, String child) {
  final rootWithSeparator = root.endsWith(Platform.pathSeparator)
      ? root
      : '$root${Platform.pathSeparator}';
  return child.startsWith(rootWithSeparator);
}

class _FakeBackend implements BackendInvoker {
  _FakeBackend(this.handler);

  final Future<Uint8List> Function(
    BackendOperation operation,
    Uint8List request,
  ) handler;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) {
    return handler(operation, request);
  }
}
