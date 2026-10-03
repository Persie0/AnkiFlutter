import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic_pb;
import 'package:anki_flutter/features/decks/data/deck_mutation_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('addDeck uses Anki defaults and returns the new deck id', () async {
    final backend = _Backend();
    final repository = DeckMutationRepository(backend: backend);

    final id = await repository.addDeck('Language::Norwegian');

    expect(id, 73);
    expect(
      backend.calls.map((call) => call.operation),
      [BackendOperation.newDeck, BackendOperation.addDeck],
    );
    expect(
      generic_pb.Empty.fromBuffer(backend.calls.first.request),
      generic_pb.Empty(),
    );
    final deck = Deck.fromBuffer(backend.calls.last.request);
    expect(deck.name, 'Language::Norwegian');
    expect(deck.hasCommon(), isTrue);
    expect(deck.hasNormal(), isTrue);
  });

  test('addDeck rejects a blank name without calling Anki', () async {
    final backend = _Backend();
    final repository = DeckMutationRepository(backend: backend);

    await expectLater(repository.addDeck('  \n'), throwsArgumentError);

    expect(backend.calls, isEmpty);
  });

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
  final calls = <_Invocation>[];

  BackendOperation? get operation => calls.isEmpty ? null : calls.last.operation;
  Uint8List? get request => calls.isEmpty ? null : calls.last.request;

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Invocation(operation, request));
    if (operation == BackendOperation.newDeck) {
      return Deck(common: Deck_Common(), normal: Deck_Normal()).writeToBuffer();
    }
    if (operation == BackendOperation.addDeck) {
      return OpChangesWithId(id: Int64(73)).writeToBuffer();
    }
    return Uint8List(0);
  }
}

class _Invocation {
  const _Invocation(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}
