import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads regular nested deck destinations while excluding filtered decks', () async {
    final backend = _Backend([
      decks.DeckTreeNode(children: [
        decks.DeckTreeNode(
          deckId: Int64(1),
          name: 'Default',
        ),
        decks.DeckTreeNode(
          deckId: Int64(2),
          name: 'Languages',
          children: [
            decks.DeckTreeNode(
              deckId: Int64(3),
              name: 'French',
            ),
          ],
        ),
        decks.DeckTreeNode(
          deckId: Int64(4),
          name: 'Filtered',
          filtered: true,
          children: [
            decks.DeckTreeNode(deckId: Int64(5), name: 'Hidden'),
          ],
        ),
      ]).writeToBuffer(),
    ]);

    final result = await AnkiCardBrowserRepository(backend: backend)
        .moveTargets();

    expect(result.map((deck) => deck.id), [1, 2, 3]);
    expect(result.map((deck) => deck.label), [
      'Default',
      'Languages',
      'Languages::French',
    ]);
    expect(backend.calls.single.operation, BackendOperation.deckTree);
    final request = decks.DeckTreeRequest.fromBuffer(backend.calls.single.request);
    expect(request.now.toInt(), greaterThan(0));
  });

  test('moves unique card IDs using Anki native setDeck request', () async {
    final backend = _Backend([Uint8List(0)]);
    final repository = AnkiCardBrowserRepository(backend: backend);

    await repository.moveCardsToDeck([10, 10, 20], 99);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.setDeck);
    final request = cards.SetDeckRequest.fromBuffer(backend.calls.single.request);
    expect(request.cardIds, [Int64(10), Int64(20)]);
    expect(request.deckId, Int64(99));
  });

  test('ignores empty selection and rejects invalid target without backend writes', () async {
    final backend = _Backend([]);
    final repository = AnkiCardBrowserRepository(backend: backend);

    await repository.moveCardsToDeck([], 1);
    await expectLater(repository.moveCardsToDeck([10], 0), throwsArgumentError);

    expect(backend.calls, isEmpty);
  });

  test('propagates Anki move failures to preserve browser selection', () async {
    final backend = _Backend([], failureAt: 0);
    await expectLater(
      AnkiCardBrowserRepository(backend: backend).moveCardsToDeck([10], 20),
      throwsStateError,
    );
    expect(backend.calls.single.operation, BackendOperation.setDeck);
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.responses, {this.failureAt});
  final List<Uint8List> responses;
  final int? failureAt;
  final List<_Call> calls = [];
  var _index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    final index = _index++;
    if (index == failureAt) throw StateError('backend rejected move');
    return responses[index];
  }
}
