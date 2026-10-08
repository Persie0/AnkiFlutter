import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as anki_collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;

/// Native collection-level operation history. Anki is the sole authority for
/// which operation can be undone or redone.
abstract interface class CollectionHistoryRepository {
  Future<CollectionHistoryStatus> status();
  Future<CollectionHistoryStatus> undo();
  Future<CollectionHistoryStatus> redo();
}

class CollectionHistoryStatus {
  const CollectionHistoryStatus({required this.undoLabel, required this.redoLabel});

  final String undoLabel;
  final String redoLabel;

  bool get canUndo => undoLabel.isNotEmpty;
  bool get canRedo => redoLabel.isNotEmpty;
}

class AnkiCollectionHistoryRepository implements CollectionHistoryRepository {
  const AnkiCollectionHistoryRepository({required this.backend});

  final BackendInvoker backend;

  static CollectionHistoryStatus _decode(anki_collection.UndoStatus status) =>
      CollectionHistoryStatus(
        undoLabel: status.undo,
        redoLabel: status.redo,
      );

  @override
  Future<CollectionHistoryStatus> status() async {
    final response = await backend.invoke(
      BackendOperation.getUndoStatus,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return _decode(anki_collection.UndoStatus.fromBuffer(response));
  }

  Future<CollectionHistoryStatus> _apply({
    required BackendOperation operation,
    required bool Function(CollectionHistoryStatus) available,
  }) async {
    // Guard against stale UI labels after reviewing or editing a collection
    // elsewhere; never send an undo/redo when Anki reports no such step.
    final current = await status();
    if (!available(current)) return current;

    final response = await backend.invoke(
      operation,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    // Anki's UndoOutput.new_undo_status is captured *inside* the transaction,
    // before end_step() records the opposite redo/undo step. Refresh after
    // completion so that redo is immediately available in the UI.
    anki_collection.OpChangesAfterUndo.fromBuffer(response);
    return status();
  }

  @override
  Future<CollectionHistoryStatus> undo() => _apply(
    operation: BackendOperation.undo,
    available: (state) => state.canUndo,
  );

  @override
  Future<CollectionHistoryStatus> redo() => _apply(
    operation: BackendOperation.redo,
    available: (state) => state.canRedo,
  );
}
