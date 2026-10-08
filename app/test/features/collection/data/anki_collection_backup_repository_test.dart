import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/features/collection/data/anki_collection_backup_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('forces and awaits Anki native database-only backup', () async {
    final backend = _Backend(result: true);
    final created = await AnkiCollectionBackupRepository(backend: backend)
        .createBackup('  /tmp/anki backups  ');
    expect(created, isTrue);
    expect(backend.calls, [BackendOperation.createBackup]);
    final request = collection.CreateBackupRequest.fromBuffer(backend.payload!);
    expect(request.backupFolder, '/tmp/anki backups');
    expect(request.force, isTrue);
    expect(request.waitForCompletion, isTrue);
  });

  test('native skipped backup never implies success', () async {
    final created = await AnkiCollectionBackupRepository(
      backend: _Backend(result: false),
    ).createBackup('/tmp/backups');
    expect(created, isFalse);
  });

  test('rejects blank or URI paths before invoking native code', () async {
    final backend = _Backend(result: true);
    final repo = AnkiCollectionBackupRepository(backend: backend);
    await expectLater(repo.createBackup('  '), throwsArgumentError);
    await expectLater(
      repo.createBackup('content://android.provider/folder'),
      throwsArgumentError,
    );
    expect(backend.calls, isEmpty);
  });

  test('native failures propagate without false success', () async {
    final backend = _Backend(result: false)..fail = true;
    await expectLater(
      AnkiCollectionBackupRepository(backend: backend)
          .createBackup('/tmp/backups'),
      throwsStateError,
    );
    expect(backend.calls, [BackendOperation.createBackup]);
  });
}

class _Backend implements BackendInvoker {
  _Backend({required this.result});

  final bool result;
  bool fail = false;
  Uint8List? payload;
  final List<BackendOperation> calls = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(operation);
    payload = request;
    if (fail) throw StateError('backup failed');
    return Uint8List.fromList(generic.Bool(val: result).writeToBuffer());
  }
}
