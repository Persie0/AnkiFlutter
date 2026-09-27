import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:anki_flutter/features/decks/data/deck_mutation_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rename sends Anki RenameDeckRequest through the backend', () async {
    final backend = _Backend();
    final repository = DeckMutationRepository(backend: backend);

    await repository.renameDeck(42, 'Language::Advanced');

    expect(backend.operation, BackendOperation.renameDeck);
    expect(
      RenameDeckRequest.fromBuffer(backend.request!),
      RenameDeckRequest(deckId: Int64(42), newName: 'Language::Advanced'),
    );
  });

  test('remove sends the requested deck ids through the backend', () async {
    final backend = _Backend();
    final repository = DeckMutationRepository(backend: backend);

    await repository.removeDecks([9, 14]);

    expect(backend.operation, BackendOperation.removeDecks);
    expect(DeckIds.fromBuffer(backend.request!).dids, [Int64(9), Int64(14)]);
  });
}

class _Backend implements BackendInvoker {
  BackendOperation? operation;
  Uint8List? request;

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    this.operation = operation;
    this.request = request;
    return Uint8List(0);
  }
}
