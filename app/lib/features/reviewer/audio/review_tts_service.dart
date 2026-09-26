import 'dart:io';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/card_rendering.pb.dart'
    as card_rendering_pb;
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';

typedef ReviewTtsTempDirectoryProvider = Future<Directory> Function();

abstract interface class ReviewTtsService {
  Future<Uri?> materialize(ReviewTtsTag tag);

  Future<void> dispose();
}

class AnkiReviewTtsService implements ReviewTtsService {
  AnkiReviewTtsService({
    required BackendInvoker backend,
    required ReviewTtsTempDirectoryProvider tempDirectoryProvider,
  })  : _backend = backend,
        _tempDirectoryProvider = tempDirectoryProvider;

  final BackendInvoker _backend;
  final ReviewTtsTempDirectoryProvider _tempDirectoryProvider;
  final Set<String> _generatedPaths = <String>{};

  int _sequence = 0;
  bool _disposed = false;

  @override
  Future<Uri?> materialize(ReviewTtsTag tag) async {
    if (_disposed) {
      return null;
    }

    final card_rendering_pb.AllTtsVoicesResponse response;
    try {
      final bytes = await _backend.invoke(
        BackendOperation.allTtsVoices,
        Uint8List.fromList(
          card_rendering_pb.AllTtsVoicesRequest(validate: true).writeToBuffer(),
        ),
      );
      response = card_rendering_pb.AllTtsVoicesResponse.fromBuffer(bytes);
    } on AnkiBackendException {
      return null;
    }

    final voice = _selectVoice(response.voices, tag);
    if (voice == null) {
      return null;
    }

    final directory = await _tempDirectoryProvider();
    await directory.create(recursive: true);
    final path = _nextPath(directory);

    try {
      await _backend.invoke(
        BackendOperation.writeTtsStream,
        Uint8List.fromList(
          card_rendering_pb.WriteTtsStreamRequest(
            path: path,
            voiceId: voice.id,
            speed: tag.speed,
            text: tag.text,
          ).writeToBuffer(),
        ),
      );
    } on AnkiBackendException {
      await _deleteIfPresent(path);
      return null;
    }

    final file = File(path);
    if (!await file.exists()) {
      return null;
    }

    _generatedPaths.add(path);
    return file.uri;
  }

  @override
  Future<void> dispose() async {
    if (_disposed) {
      return;
    }
    _disposed = true;

    final paths = _generatedPaths.toList(growable: false);
    _generatedPaths.clear();
    for (final path in paths) {
      await _deleteIfPresent(path);
    }
  }

  card_rendering_pb.AllTtsVoicesResponse_TtsVoice? _selectVoice(
    Iterable<card_rendering_pb.AllTtsVoicesResponse_TtsVoice> voices,
    ReviewTtsTag tag,
  ) {
    final language = _normalizeLanguage(tag.language);
    final availableForLanguage = voices
        .where(
          (voice) =>
              (!voice.hasAvailable() || voice.available) &&
              _normalizeLanguage(voice.language) == language,
        )
        .toList(growable: false);

    for (final requested in tag.voices) {
      final normalizedRequested = _normalizeVoiceName(requested);
      for (final voice in availableForLanguage) {
        if (_normalizeVoiceName(voice.name) == normalizedRequested) {
          return voice;
        }
      }
    }

    if (language == 'en_US') {
      for (final voice in availableForLanguage) {
        if (_normalizeVoiceName(voice.name).startsWith('Apple_Samantha')) {
          return voice;
        }
      }
    }

    if (availableForLanguage.isEmpty) {
      return null;
    }
    return availableForLanguage.first;
  }

  String _nextPath(Directory directory) {
    _sequence += 1;
    return '${directory.path}${Platform.pathSeparator}'
        'anki-review-tts-$_sequence.wav';
  }

  Future<void> _deleteIfPresent(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

String _normalizeLanguage(String language) => language.replaceAll('-', '_');

String _normalizeVoiceName(String name) => name.replaceAll(' ', '_');
