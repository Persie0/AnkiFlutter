import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards_pb;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('selectDeck sends the selected deck id through the stable bridge', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);

    await repository.selectDeck(123456789);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.setCurrentDeck);
    final request = decks_pb.DeckId.fromBuffer(backend.calls.single.request);
    expect(request.did.toInt(), 123456789);
  });

  test('maps first queued card and preserves scheduler states as opaque bytes', () async {
    final current = scheduler_pb.SchedulingState();
    final again = scheduler_pb.SchedulingState(customData: 'again-state');
    final hard = scheduler_pb.SchedulingState(customData: 'hard-state');
    final good = scheduler_pb.SchedulingState(customData: 'good-state');
    final easy = scheduler_pb.SchedulingState(customData: 'easy-state');
    final states = scheduler_pb.SchedulingStates(
      current: current,
      again: again,
      hard: hard,
      good: good,
      easy: easy,
    );
    final queue = scheduler_pb.QueuedCards(
      cards: [
        scheduler_pb.QueuedCards_QueuedCard(
          card: cards_pb.Card(
            id: Int64(101),
            noteId: Int64(202),
            deckId: Int64(303),
            customData: 'persist-me',
          ),
          states: states,
          context: scheduler_pb.SchedulingContext(deckName: 'Languages::Norwegian'),
        ),
      ],
      newCount: 7,
      learningCount: 8,
      reviewCount: 9,
    );
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getQueuedCards: Uint8List.fromList(queue.writeToBuffer()),
        BackendOperation.describeNextStates: Uint8List.fromList(
          generic_pb.StringList(vals: ['10m', '1d', '3d', '5d']).writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    final card = await repository.nextCard();

    expect(card, isNotNull);
    expect(card!.cardId, 101);
    expect(card.noteId, 202);
    expect(card.deckId, 303);
    expect(card.deckName, 'Languages::Norwegian');
    expect(card.counts.newCount, 7);
    expect(card.counts.learningCount, 8);
    expect(card.counts.reviewCount, 9);

    final expectedCurrent = scheduler_pb.SchedulingState(customData: 'persist-me');
    expect(card.currentStateBytes, orderedEquals(expectedCurrent.writeToBuffer()));

    expect(
      card.choices.map((choice) => choice.rating),
      orderedEquals(ReviewRating.values),
    );
    expect(
      card.choices[0].schedulingStateBytes,
      orderedEquals(again.writeToBuffer()),
    );
    expect(
      card.choices[1].schedulingStateBytes,
      orderedEquals(hard.writeToBuffer()),
    );
    expect(
      card.choices[2].schedulingStateBytes,
      orderedEquals(good.writeToBuffer()),
    );
    expect(
      card.choices[3].schedulingStateBytes,
      orderedEquals(easy.writeToBuffer()),
    );

    expect(backend.calls, hasLength(2));
    expect(backend.calls.first.operation, BackendOperation.getQueuedCards);
    final request = scheduler_pb.GetQueuedCardsRequest.fromBuffer(
      backend.calls.first.request,
    );
    expect(request.fetchLimit, 1);
    expect(request.intradayLearningOnly, isFalse);
    expect(backend.calls.last.operation, BackendOperation.describeNextStates);
    expect(backend.calls.last.request, orderedEquals(states.writeToBuffer()));
  });

  test('uses Anki interval descriptions in Again Hard Good Easy order', () async {
    final states = scheduler_pb.SchedulingStates(
      current: scheduler_pb.SchedulingState(),
      again: scheduler_pb.SchedulingState(customData: 'again'),
      hard: scheduler_pb.SchedulingState(customData: 'hard'),
      good: scheduler_pb.SchedulingState(customData: 'good'),
      easy: scheduler_pb.SchedulingState(customData: 'easy'),
    );
    final queue = scheduler_pb.QueuedCards(
      cards: [
        scheduler_pb.QueuedCards_QueuedCard(
          card: cards_pb.Card(id: Int64(1)),
          states: states,
        ),
      ],
    );
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getQueuedCards: Uint8List.fromList(queue.writeToBuffer()),
        BackendOperation.describeNextStates: Uint8List.fromList(
          generic_pb.StringList(
            vals: ['Again upstream', 'Hard upstream', 'Good upstream', 'Easy upstream'],
          ).writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    final card = await repository.nextCard();

    expect(
      card!.choices.map((choice) => choice.intervalLabel),
      orderedEquals([
        'Again upstream',
        'Hard upstream',
        'Good upstream',
        'Easy upstream',
      ]),
    );
  });

  test('returns null when Anki has no queued cards', () async {
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getQueuedCards: Uint8List.fromList(
          scheduler_pb.QueuedCards().writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    expect(await repository.nextCard(), isNull);
  });
}

class _BackendCall {
  _BackendCall(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _FakeBackend implements BackendInvoker {
  _FakeBackend({Map<BackendOperation, Uint8List>? responses})
      : responses = responses ?? <BackendOperation, Uint8List>{};

  final Map<BackendOperation, Uint8List> responses;
  final List<_BackendCall> calls = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_BackendCall(operation, request));
    return responses[operation] ?? Uint8List(0);
  }
}
