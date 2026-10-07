import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('moves precisely the unique unused filenames to native Anki trash',
      () async {
    final backend = _Backend();
    final repo = AnkiMediaRepository(backend: backend);

    await repo.trashMediaFiles(['old.png', 'old.png', 'unlinked.mp3']);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.trashMediaFiles);
    final request = media.TrashMediaFilesRequest.fromBuffer(
      backend.calls.single.bytes,
    );
    expect(request.fnames, ['old.png', 'unlinked.mp3']);
  });

  test('restores media trash through Anki rather than filesystem copies',
      () async {
    final backend = _Backend();
    await AnkiMediaRepository(backend: backend).restoreMediaTrash();

    expect(backend.calls.single.operation, BackendOperation.restoreMediaTrash);
    expect(
      generic.Empty.fromBuffer(backend.calls.single.bytes),
      generic.Empty(),
    );
  });

  test('empty or invalid trash selection never reaches native backend',
      () async {
    final backend = _Backend();
    final repo = AnkiMediaRepository(backend: backend);
    await repo.trashMediaFiles([]);
    await expectLater(repo.trashMediaFiles(['   ']), throwsArgumentError);
    expect(backend.calls, isEmpty);
  });

  test('trash backend failure is propagated and never reports success',
      () async {
    final backend = _Backend()..fail = true;
    await expectLater(
      AnkiMediaRepository(backend: backend).trashMediaFiles(['old.png']),
      throwsStateError,
    );
    expect(backend.calls.single.operation, BackendOperation.trashMediaFiles);
  });
}

class _Call {
  const _Call(this.operation, this.bytes);
  final BackendOperation operation;
  final Uint8List bytes;
}

class _Backend implements BackendInvoker {
  final calls = <_Call>[];
  bool fail = false;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    if (fail) throw StateError('native media service failure');
    return Uint8List(0);
  }
}
