import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart';
import 'package:fixnum/fixnum.dart';

/// Runs deck mutations through Anki's native backend operations.
class DeckMutationRepository {
  const DeckMutationRepository({required this.backend});

  final BackendInvoker backend;

  Future<int> addDeck(String name) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Deck name must not be blank.');
    }

    final deckBytes = await backend.invoke(
      BackendOperation.newDeck,
      Uint8List.fromList(Empty().writeToBuffer()),
    );
    final deck = Deck.fromBuffer(deckBytes)..name = trimmedName;
    final changesBytes = await backend.invoke(
      BackendOperation.addDeck,
      Uint8List.fromList(deck.writeToBuffer()),
    );
    return OpChangesWithId.fromBuffer(changesBytes).id.toInt();
  }

  Future<void> renameDeck(int deckId, String newName) async {
    final request = RenameDeckRequest(deckId: Int64(deckId), newName: newName);
    await backend.invoke(
      BackendOperation.renameDeck,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  Future<void> removeDecks(Iterable<int> deckIds) async {
    final request = DeckIds(dids: deckIds.map(Int64.new));
    await backend.invoke(
      BackendOperation.removeDecks,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }
}
