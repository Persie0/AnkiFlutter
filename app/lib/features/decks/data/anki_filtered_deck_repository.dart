import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart'
    as decks;
import 'package:fixnum/fixnum.dart';

/// Native filtered-deck scheduling operations. No card scheduling is performed
/// in Flutter: Anki's backend owns the return-to-original-deck and rebuild rules.
abstract interface class FilteredDeckRepository {
  /// Return cards to their original decks using Anki's native scheduler.
  Future<void> empty(int deckId);

  /// Rebuild the filtered deck and return Anki's count of gathered cards.
  Future<int> rebuild(int deckId);
}

class AnkiFilteredDeckRepository implements FilteredDeckRepository {
  const AnkiFilteredDeckRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<void> empty(int deckId) async {
    await backend.invoke(
      BackendOperation.emptyFilteredDeck,
      _deckRequest(deckId),
    );
  }

  @override
  Future<int> rebuild(int deckId) async {
    final bytes = await backend.invoke(
      BackendOperation.rebuildFilteredDeck,
      _deckRequest(deckId),
    );
    return collection.OpChangesWithCount.fromBuffer(bytes).count;
  }

  Uint8List _deckRequest(int deckId) {
    if (deckId <= 0) {
      throw ArgumentError.value(deckId, 'deckId', 'Deck ID must be positive');
    }
    return Uint8List.fromList(
      decks.DeckId(did: Int64(deckId)).writeToBuffer(),
    );
  }
}
