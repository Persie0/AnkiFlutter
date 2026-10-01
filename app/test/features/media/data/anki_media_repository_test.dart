import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds bytes through Anki and returns collision-safe filename', () async {
    final backend = _BackendQueue([
      generic.String(val: 'image_1.png').writeToBuffer(),
    ]);
    final repository = AnkiMediaRepository(backend: backend);

    final filename = await repository.addFile(
      desiredName: 'image.png',
      bytes: Uint8List.fromList([1, 2, 3]),
    );

    expect(filename, 'image_1.png');
    expect(backend.calls.single.operation, BackendOperation.addMediaFile);
    final request = media.AddMediaFileRequest.fromBuffer(backend.calls.single.request);
    expect(request.desiredName, 'image.png');
    expect(request.data, [1, 2, 3]);
  });

  test('adds media from URL and surfaces backend error', () async {
    final backend = _BackendQueue([
      media.AddMediaFromUrlResponse(error: 'download failed').writeToBuffer(),
    ]);
    final repository = AnkiMediaRepository(backend: backend);

    expect(
      () => repository.addFromUrl('https://example.invalid/image.png'),
      throwsA(isA<StateError>()),
    );
  });

  test('checks collection media and resolves absolute path', () async {
    final backend = _BackendQueue([
      media.CheckMediaResponse(
        unused: ['old.png'],
        missing: ['missing.mp3'],
        report: '1 missing, 1 unused',
      ).writeToBuffer(),
      generic.String(val: '/collection.media/pic.png').writeToBuffer(),
    ]);
    final repository = AnkiMediaRepository(backend: backend);

    final check = await repository.checkMedia();
    final path = await repository.absolutePath('pic.png');

    expect(check.missing, ['missing.mp3']);
    expect(check.unused, ['old.png']);
    expect(path, '/collection.media/pic.png');
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _BackendQueue implements BackendInvoker {
  _BackendQueue(this.responses);
  final List<Uint8List> responses;
  final calls = <_Call>[];
  var _index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    return responses[_index++];
  }
}
