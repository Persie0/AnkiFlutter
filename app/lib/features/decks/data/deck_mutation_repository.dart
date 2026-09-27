import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:fixnum/fixnum.dart';

/// Runs deck mutations through Anki's native backend operations.
class DeckMutationRepository {
  const DeckMutationRepository({required this.backend});

  final BackendInvoker backend;

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
