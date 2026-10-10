import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler;
import 'package:fixnum/fixnum.dart';

/// Uses Anki's own new-card insertion order logic. This does not alter
/// intervals, grades, or review scheduling; only new-card order is changed.
abstract interface class DeckNewCardOrderRepository {
  Future<int> reorder(int deckId, {required bool randomize});
}

class AnkiDeckNewCardOrderRepository implements DeckNewCardOrderRepository {
  const AnkiDeckNewCardOrderRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<int> reorder(int deckId, {required bool randomize}) async {
    if (deckId <= 0) {
      throw ArgumentError.value(deckId, 'deckId', 'Must be positive');
    }
    final request = scheduler.SortDeckRequest(
      deckId: Int64(deckId),
      randomize: randomize,
    );
    final response = await backend.invoke(
      BackendOperation.sortDeck,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return collection.OpChangesWithCount.fromBuffer(response).count;
  }
}
