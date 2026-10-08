import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as anki_collection;
import 'package:anki_flutter/features/collection/data/anki_collection_history_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reports native undo and redo labels without inventing history', () async {
    final backend = _Backend(
      state: anki_collection.UndoStatus(undo: 'Delete cards', redo: 'Edit note'),
    );
    final status = await AnkiCollectionHistoryRepository(backend: backend).status();
    expect(status.canUndo, isTrue);
    expect(status.canRedo, isTrue);
    expect(status.undoLabel, 'Delete cards');
    expect(status.redoLabel, 'Edit note');
    expect(backend.calls, [BackendOperation.getUndoStatus]);
  });

  test('native undo result returns updated Anki status', () async {
    final backend = _Backend(
      state: anki_collection.UndoStatus(undo: 'Delete note'),
    )..afterUndo = anki_collection.UndoStatus(redo: 'Delete note');
    final status = await AnkiCollectionHistoryRepository(backend: backend).undo();
    expect(status.canUndo, isFalse);
    expect(status.redoLabel, 'Delete note');
    expect(backend.calls, [
      BackendOperation.getUndoStatus,
      BackendOperation.undo,
      BackendOperation.getUndoStatus,
    ]);
  });

  test('redo uses upstream Anki redo operation and status', () async {
    final backend = _Backend(
      state: anki_collection.UndoStatus(redo: 'Change deck'),
    )..afterRedo = anki_collection.UndoStatus(undo: 'Change deck');
    final status = await AnkiCollectionHistoryRepository(backend: backend).redo();
    expect(status.undoLabel, 'Change deck');
    expect(backend.calls, [
      BackendOperation.getUndoStatus,
      BackendOperation.redo,
      BackendOperation.getUndoStatus,
    ]);
  });

  test('unavailable undo or redo never invokes mutating operation', () async {
    final backend = _Backend(state: anki_collection.UndoStatus());
    final repository = AnkiCollectionHistoryRepository(backend: backend);
    expect((await repository.undo()).canUndo, isFalse);
    expect((await repository.redo()).canRedo, isFalse);
    expect(backend.calls,
        [BackendOperation.getUndoStatus, BackendOperation.getUndoStatus]);
  });

  test('authoritative refresh runs even when response omits updated status', () async {
    final backend = _Backend(
      state: anki_collection.UndoStatus(undo: 'Add cards'),
    )..omitReturnStatus = true;
    final status = await AnkiCollectionHistoryRepository(backend: backend).undo();
    expect(status.canUndo, isTrue);
    expect(backend.calls, [
      BackendOperation.getUndoStatus,
      BackendOperation.undo,
      BackendOperation.getUndoStatus,
    ]);
  });

  test('native operation error propagates for retry rather than reporting success',
      () async {
    final backend = _Backend(
      state: anki_collection.UndoStatus(undo: 'Add cards'),
    )..failUndo = true;
    final repository = AnkiCollectionHistoryRepository(backend: backend);
    await expectLater(repository.undo(), throwsStateError);
    expect(backend.calls, [BackendOperation.getUndoStatus, BackendOperation.undo]);
  });
}

class _Backend implements BackendInvoker {
  _Backend({required this.state});
  anki_collection.UndoStatus state;
  anki_collection.UndoStatus? afterUndo;
  anki_collection.UndoStatus? afterRedo;
  bool omitReturnStatus = false;
  bool failUndo = false;
  final calls = <BackendOperation>[];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(operation);
    if (operation == BackendOperation.getUndoStatus) {
      return Uint8List.fromList(state.writeToBuffer());
    }
    if (operation == BackendOperation.undo || operation == BackendOperation.redo) {
      if (failUndo) throw StateError('native history failed');
      final result = operation == BackendOperation.undo ? afterUndo : afterRedo;
      if (result != null) state = result;
      return Uint8List.fromList(
        anki_collection.OpChangesAfterUndo(
          newStatus: omitReturnStatus ? null : result,
        ).writeToBuffer(),
      );
    }
    throw StateError('unexpected backend operation $operation');
  }
}
