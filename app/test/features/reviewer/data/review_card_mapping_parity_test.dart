import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normal queued card uses its storage deck as current deck', () async {
    final repository = AnkiReviewRepository(
      backend: _QueueBackend(
        _queueFor(
          cards_pb.Card(
            id: Int64(101),
            noteId: Int64(202),
            deckId: Int64(303),
            originalDeckId: Int64.ZERO,
            templateIdx: 2,
          ),
        ),
      ),
    );

    final card = await repository.nextCard();

    expect(card, isNotNull);
    expect(card!.storageDeckId, 303);
    expect(card.originalDeckId, 0);
    expect(card.currentDeckId, 303);
    expect(card.templateOrdinal, 2);
  });

  test('filtered queued card uses original deck as current deck', () async {
    final repository = AnkiReviewRepository(
      backend: _QueueBackend(
        _queueFor(
          cards_pb.Card(
            id: Int64(404),
            noteId: Int64(505),
            deckId: Int64(999),
            originalDeckId: Int64(303),
            templateIdx: 0,
          ),
        ),
      ),
    );

    final card = await repository.nextCard();

    expect(card, isNotNull);
    expect(card!.storageDeckId, 999);
    expect(card.originalDeckId, 303);
    expect(card.currentDeckId, 303);
    expect(card.templateOrdinal, 0);
  });
}

scheduler_pb.QueuedCards _queueFor(cards_pb.Card card) {
  final states = scheduler_pb.SchedulingStates(
    current: scheduler_pb.SchedulingState(),
    again: scheduler_pb.SchedulingState(),
    hard: scheduler_pb.SchedulingState(),
    good: scheduler_pb.SchedulingState(),
    easy: scheduler_pb.SchedulingState(),
  );
  return scheduler_pb.QueuedCards(
    cards: [
      scheduler_pb.QueuedCards_QueuedCard(
        card: card,
        states: states,
        context: scheduler_pb.SchedulingContext(deckName: 'Deck'),
      ),
    ],
  );
}

class _QueueBackend implements BackendInvoker {
  _QueueBackend(this.queue);

  final scheduler_pb.QueuedCards queue;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    switch (operation) {
      case BackendOperation.getQueuedCards:
        return Uint8List.fromList(queue.writeToBuffer());
      case BackendOperation.describeNextStates:
        return Uint8List.fromList(
          generic_pb.StringList(vals: ['Again', 'Hard', 'Good', 'Easy'])
              .writeToBuffer(),
        );
      default:
        throw StateError('Unexpected operation: $operation');
    }
  }
}
