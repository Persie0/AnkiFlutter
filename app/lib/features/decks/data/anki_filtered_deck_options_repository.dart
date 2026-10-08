import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart'
    as decks;
import 'package:fixnum/fixnum.dart';

/// Keep the complete native message when editing. Anki may store preview
/// timing and scheduler-specific fields not exposed by the Flutter form.
abstract interface class FilteredDeckOptionsRepository {
  Future<decks.FilteredDeckForUpdate> load(int deckId);

  Future<int> save(decks.FilteredDeckForUpdate draft);
}

class AnkiFilteredDeckOptionsRepository
    implements FilteredDeckOptionsRepository {
  const AnkiFilteredDeckOptionsRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<decks.FilteredDeckForUpdate> load(int deckId) async {
    if (deckId <= 0) {
      throw ArgumentError.value(deckId, 'deckId', 'Must be positive');
    }
    final response = await backend.invoke(
      BackendOperation.getOrCreateFilteredDeck,
      Uint8List.fromList(
        decks.DeckId(did: Int64(deckId)).writeToBuffer(),
      ),
    );
    final snapshot = decks.FilteredDeckForUpdate.fromBuffer(response);
    if (snapshot.id.toInt() != deckId) {
      throw StateError('Anki returned settings for a different filtered deck');
    }
    return snapshot;
  }

  @override
  Future<int> save(decks.FilteredDeckForUpdate draft) async {
    if (draft.id <= Int64.ZERO) {
      throw ArgumentError.value(draft.id, 'deckId', 'Must be positive');
    }
    if (draft.name.trim().isEmpty) {
      throw ArgumentError.value(draft.name, 'name', 'Name cannot be empty');
    }
    if (draft.config.searchTerms.isEmpty ||
        draft.config.searchTerms.length > 2) {
      throw ArgumentError('A filtered deck requires one or two search terms');
    }
    for (final term in draft.config.searchTerms) {
      if (term.search.trim().isEmpty || term.limit < 1) {
        throw ArgumentError('Each search needs a query and positive card limit');
      }
    }

    final bytes = await backend.invoke(
      BackendOperation.addOrUpdateFilteredDeck,
      Uint8List.fromList(draft.writeToBuffer()),
    );
    return collection.OpChangesWithId.fromBuffer(bytes).id.toInt();
  }
}
