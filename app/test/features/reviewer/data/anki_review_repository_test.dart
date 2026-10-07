import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards_pb;
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection_pb;
import 'package:anki_flutter/core/backend/generated/anki/deck_config.pb.dart'
    as deck_config_pb;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
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

  test('answer serializes exact queued states rating and timing', () async {
    final current = scheduler_pb.SchedulingState(customData: 'ignored-by-queue');
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
            id: Int64(404),
            customData: 'card-custom-data',
          ),
          states: states,
        ),
      ],
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
    backend.calls.clear();

    await repository.answer(
      card!,
      ReviewRating.good,
      answeredAtMillis: 1800000000123,
      millisecondsTaken: 4321,
    );

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.answerCard);
    final answer = scheduler_pb.CardAnswer.fromBuffer(backend.calls.single.request);
    expect(answer.cardId.toInt(), 404);
    expect(
      answer.currentState.writeToBuffer(),
      orderedEquals(card.currentStateBytes),
    );
    expect(answer.newState.writeToBuffer(), orderedEquals(good.writeToBuffer()));
    expect(answer.rating, scheduler_pb.CardAnswer_Rating.GOOD);
    expect(answer.answeredAtMillis.toInt(), 1800000000123);
    expect(answer.millisecondsTaken, 4321);
  });

  test('settingsForDeck maps matching Anki deck config exactly', () async {
    final config = deck_config_pb.DeckConfig_Config(
      disableAutoplay: true,
      capAnswerTimeToSecs: 17,
      showTimer: true,
      skipQuestionWhenReplayingAnswer: true,
      questionAction:
          deck_config_pb.DeckConfig_Config_QuestionAction.QUESTION_ACTION_SHOW_REMINDER,
      stopTimerOnAnswer: true,
      secondsToShowQuestion: 3.5,
      secondsToShowAnswer: 4.25,
      answerAction:
          deck_config_pb.DeckConfig_Config_AnswerAction.ANSWER_ACTION_ANSWER_GOOD,
      waitForAudio: true,
    );
    final response = deck_config_pb.DeckConfigsForUpdate(
      allConfig: [
        deck_config_pb.DeckConfigsForUpdate_ConfigWithExtra(
          config: deck_config_pb.DeckConfig(
            id: Int64(11),
            config: deck_config_pb.DeckConfig_Config(),
          ),
        ),
        deck_config_pb.DeckConfigsForUpdate_ConfigWithExtra(
          config: deck_config_pb.DeckConfig(id: Int64(22), config: config),
        ),
      ],
      currentDeck:
          deck_config_pb.DeckConfigsForUpdate_CurrentDeck(configId: Int64(22)),
      defaults: deck_config_pb.DeckConfig(
        config: deck_config_pb.DeckConfig_Config(disableAutoplay: false),
      ),
    );
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getDeckConfigsForUpdate:
            Uint8List.fromList(response.writeToBuffer()),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    final settings = await repository.settingsForDeck(303);

    expect(backend.calls, hasLength(1));
    expect(
      backend.calls.single.operation,
      BackendOperation.getDeckConfigsForUpdate,
    );
    final request = decks_pb.DeckId.fromBuffer(backend.calls.single.request);
    expect(request.did.toInt(), 303);
    expect(settings.autoplay, isFalse);
    expect(settings.showTimer, isTrue);
    expect(settings.stopTimerOnAnswer, isTrue);
    expect(settings.answerTimeLimitSeconds, 17);
    expect(settings.secondsToShowQuestion, 3.5);
    expect(settings.secondsToShowAnswer, 4.25);
    expect(settings.waitForAudio, isTrue);
    expect(settings.skipQuestionWhenReplayingAnswer, isTrue);
    expect(settings.questionAction, ReviewQuestionAction.showReminder);
    expect(settings.answerAction, ReviewAnswerAction.answerGood);
  });

  test('settingsForDeck falls back to Anki returned defaults', () async {
    final defaults = deck_config_pb.DeckConfig_Config(
      disableAutoplay: false,
      capAnswerTimeToSecs: 42,
      showTimer: false,
      skipQuestionWhenReplayingAnswer: false,
      questionAction:
          deck_config_pb.DeckConfig_Config_QuestionAction.QUESTION_ACTION_SHOW_ANSWER,
      stopTimerOnAnswer: false,
      secondsToShowQuestion: 1.25,
      secondsToShowAnswer: 6.5,
      answerAction:
          deck_config_pb.DeckConfig_Config_AnswerAction.ANSWER_ACTION_BURY_CARD,
      waitForAudio: false,
    );
    final response = deck_config_pb.DeckConfigsForUpdate(
      allConfig: [
        deck_config_pb.DeckConfigsForUpdate_ConfigWithExtra(
          config: deck_config_pb.DeckConfig(
            id: Int64(11),
            config: deck_config_pb.DeckConfig_Config(disableAutoplay: true),
          ),
        ),
      ],
      currentDeck:
          deck_config_pb.DeckConfigsForUpdate_CurrentDeck(configId: Int64(99)),
      defaults: deck_config_pb.DeckConfig(config: defaults),
    );
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getDeckConfigsForUpdate:
            Uint8List.fromList(response.writeToBuffer()),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    final settings = await repository.settingsForDeck(404);

    expect(settings.autoplay, isTrue);
    expect(settings.showTimer, isFalse);
    expect(settings.stopTimerOnAnswer, isFalse);
    expect(settings.answerTimeLimitSeconds, 42);
    expect(settings.secondsToShowQuestion, 1.25);
    expect(settings.secondsToShowAnswer, 6.5);
    expect(settings.waitForAudio, isFalse);
    expect(settings.skipQuestionWhenReplayingAnswer, isFalse);
    expect(settings.questionAction, ReviewQuestionAction.showAnswer);
    expect(settings.answerAction, ReviewAnswerAction.buryCard);
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

  test('buryCard sends manual user bury for the current card only', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);
    final card = _mutationCard();

    await repository.buryCard(card);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.buryOrSuspendCards);
    final request = scheduler_pb.BuryOrSuspendCardsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.cardIds.map((id) => id.toInt()), [101]);
    expect(request.noteIds, isEmpty);
    expect(
      request.mode,
      scheduler_pb.BuryOrSuspendCardsRequest_Mode.BURY_USER,
    );
  });

  test('buryNote sends manual user bury for the current note only', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);
    final card = _mutationCard();

    await repository.buryNote(card);

    expect(backend.calls, hasLength(1));
    final request = scheduler_pb.BuryOrSuspendCardsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.cardIds, isEmpty);
    expect(request.noteIds.map((id) => id.toInt()), [202]);
    expect(
      request.mode,
      scheduler_pb.BuryOrSuspendCardsRequest_Mode.BURY_USER,
    );
  });

  test('suspendCard sends suspend for the current card only', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);
    final card = _mutationCard();

    await repository.suspendCard(card);

    expect(backend.calls, hasLength(1));
    final request = scheduler_pb.BuryOrSuspendCardsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.cardIds.map((id) => id.toInt()), [101]);
    expect(request.noteIds, isEmpty);
    expect(
      request.mode,
      scheduler_pb.BuryOrSuspendCardsRequest_Mode.SUSPEND,
    );
  });

  test('suspendNote sends suspend for the current note only', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);
    final card = _mutationCard();

    await repository.suspendNote(card);

    expect(backend.calls, hasLength(1));
    final request = scheduler_pb.BuryOrSuspendCardsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.cardIds, isEmpty);
    expect(request.noteIds.map((id) => id.toInt()), [202]);
    expect(
      request.mode,
      scheduler_pb.BuryOrSuspendCardsRequest_Mode.SUSPEND,
    );
  });

  test('isCardSuspended reads the answered card queue from Anki', () async {
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getCard: Uint8List.fromList(
          cards_pb.Card(
            id: Int64(101),
            noteId: Int64(202),
            deckId: Int64(303),
            queue: -1,
          ).writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);
    final card = _mutationCard();

    expect(await repository.isCardSuspended(card), isTrue);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.getCard);
    final request = cards_pb.CardId.fromBuffer(backend.calls.single.request);
    expect(request.cid.toInt(), card.cardId);
  });

  test('canUndo reflects Anki GetUndoStatus instead of local state', () async {
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getUndoStatus: Uint8List.fromList(
          collection_pb.UndoStatus(undo: 'Answer Card').writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    expect(await repository.canUndo(), isTrue);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.getUndoStatus);
    expect(
      backend.calls.single.request,
      orderedEquals(generic_pb.Empty().writeToBuffer()),
    );
  });

  test('undo checks upstream status then invokes Anki Undo', () async {
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getUndoStatus: Uint8List.fromList(
          collection_pb.UndoStatus(undo: 'Answer Card').writeToBuffer(),
        ),
        BackendOperation.undo: Uint8List.fromList(
          collection_pb.OpChangesAfterUndo().writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    await repository.undo();

    expect(
      backend.calls.map((call) => call.operation),
      [BackendOperation.getUndoStatus, BackendOperation.undo],
    );
  });

  test('undo is a no-op when upstream has no undo entry', () async {
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getUndoStatus: Uint8List.fromList(
          collection_pb.UndoStatus().writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    await repository.undo();

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.getUndoStatus);
  });
}

ReviewCard _mutationCard() {
  return ReviewCard(
    cardId: 101,
    noteId: 202,
    deckId: 303,
    counts: const ReviewCounts(
      newCount: 0,
      learningCount: 0,
      reviewCount: 0,
    ),
    currentStateBytes: Uint8List(0),
    choices: const [],
    deckName: 'Default',
  );
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
