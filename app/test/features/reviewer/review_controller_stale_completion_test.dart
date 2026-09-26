import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stale card render completion cannot replace a newer generation', () async {
    final cardA = _card(cardId: 1001, noteId: 2001, deckName: 'A');
    final cardB = _card(cardId: 1002, noteId: 2002, deckName: 'B');
    final repository = _ControlledReviewRepository(nextCards: [cardA, cardB]);
    final renderer = _ControlledRenderer();
    final controller = ReviewController(
      repository: repository,
      renderer: renderer,
      wallClockMillis: () => 123456789,
      stopwatchFactory: Stopwatch.new,
    );

    final firstStart = controller.start(42);
    await _flushMicrotasks();
    expect(renderer.renderedCardIds, [cardA.cardId]);

    final secondStart = controller.start(42);
    await _flushMicrotasks();
    expect(renderer.renderedCardIds, [cardA.cardId, cardB.cardId]);

    final contentB = _content('B');
    renderer.complete(cardB.cardId, contentB);
    await secondStart;

    final newerState = controller.state as ReviewQuestion;
    expect(newerState.card, same(cardB));
    expect(newerState.content, same(contentB));

    renderer.complete(cardA.cardId, _content('A'));
    await firstStart;

    final finalState = controller.state as ReviewQuestion;
    expect(finalState.card, same(cardB));
    expect(finalState.content, same(contentB));
    expect(finalState.generationId, newerState.generationId);
  });

  test('stale successful answer cannot advance or replace newer generation', () async {
    final cardA = _card(cardId: 1001, noteId: 2001, deckName: 'A');
    final cardB = _card(cardId: 1002, noteId: 2002, deckName: 'B');
    final answerCompleter = Completer<void>();
    final repository = _ControlledReviewRepository(
      nextCards: [cardA, cardB, null],
      answerCompleter: answerCompleter,
    );
    final controller = ReviewController(
      repository: repository,
      renderer: _ImmediateRenderer(),
      wallClockMillis: () => 123456789,
      stopwatchFactory: Stopwatch.new,
    );

    await controller.start(42);
    await controller.showAnswer();
    final oldAnswer = controller.rate(ReviewRating.good);
    await _flushMicrotasks();
    expect(repository.answerCalls, 1);

    await controller.start(42);
    final newerState = controller.state as ReviewQuestion;
    expect(newerState.card, same(cardB));
    expect(repository.nextCardCalls, 2);

    answerCompleter.complete();
    await oldAnswer;

    final finalState = controller.state as ReviewQuestion;
    expect(finalState.card, same(cardB));
    expect(finalState.generationId, newerState.generationId);
    expect(repository.nextCardCalls, 2);
  });

  test('stale failed answer cannot restore an older answer state', () async {
    final cardA = _card(cardId: 1001, noteId: 2001, deckName: 'A');
    final cardB = _card(cardId: 1002, noteId: 2002, deckName: 'B');
    final answerCompleter = Completer<void>();
    final repository = _ControlledReviewRepository(
      nextCards: [cardA, cardB],
      answerCompleter: answerCompleter,
      answerError: StateError('late failure'),
    );
    final controller = ReviewController(
      repository: repository,
      renderer: _ImmediateRenderer(),
      wallClockMillis: () => 123456789,
      stopwatchFactory: Stopwatch.new,
    );

    await controller.start(42);
    await controller.showAnswer();
    final oldAnswer = controller.rate(ReviewRating.good);
    await _flushMicrotasks();

    await controller.start(42);
    final newerState = controller.state as ReviewQuestion;
    expect(newerState.card, same(cardB));

    answerCompleter.complete();
    await oldAnswer;

    final finalState = controller.state as ReviewQuestion;
    expect(finalState.card, same(cardB));
    expect(finalState.generationId, newerState.generationId);
  });
}

Future<void> _flushMicrotasks() => Future<void>.delayed(Duration.zero);

const _settings = ReviewDeckSettings(
  autoplay: true,
  showTimer: true,
  stopTimerOnAnswer: false,
  answerTimeLimitSeconds: 60,
  secondsToShowQuestion: 0,
  secondsToShowAnswer: 0,
  waitForAudio: true,
  skipQuestionWhenReplayingAnswer: false,
  questionAction: ReviewQuestionAction.showAnswer,
  answerAction: ReviewAnswerAction.answerGood,
);

ReviewCardContent _content(String label) {
  return ReviewCardContent(
    questionHtml: '<div>$label question</div>',
    answerHtml: '<div>$label answer</div>',
    css: '.card { font-size: 20px; }',
    questionAudio: const [],
    answerAudio: const [],
  );
}

ReviewCard _card({
  required int cardId,
  required int noteId,
  required String deckName,
}) {
  return ReviewCard(
    cardId: cardId,
    noteId: noteId,
    deckId: 42,
    counts: const ReviewCounts(
      newCount: 3,
      learningCount: 2,
      reviewCount: 7,
    ),
    currentStateBytes: Uint8List.fromList([1, 2, 3]),
    choices: [
      ReviewAnswerChoice(
        rating: ReviewRating.again,
        intervalLabel: '<1m',
        schedulingStateBytes: Uint8List.fromList([4]),
      ),
      ReviewAnswerChoice(
        rating: ReviewRating.hard,
        intervalLabel: '6m',
        schedulingStateBytes: Uint8List.fromList([5]),
      ),
      ReviewAnswerChoice(
        rating: ReviewRating.good,
        intervalLabel: '10m',
        schedulingStateBytes: Uint8List.fromList([6]),
      ),
      ReviewAnswerChoice(
        rating: ReviewRating.easy,
        intervalLabel: '4d',
        schedulingStateBytes: Uint8List.fromList([7]),
      ),
    ],
    deckName: deckName,
  );
}

class _ControlledReviewRepository implements ReviewRepository {
  _ControlledReviewRepository({
    required List<ReviewCard?> nextCards,
    this.answerCompleter,
    this.answerError,
  }) : _nextCards = List<ReviewCard?>.of(nextCards);

  final List<ReviewCard?> _nextCards;
  final Completer<void>? answerCompleter;
  final Object? answerError;
  int nextCardCalls = 0;
  int answerCalls = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    nextCardCalls += 1;
    return _nextCards.removeAt(0);
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async => _settings;

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {
    answerCalls += 1;
    if (answerCompleter != null) {
      await answerCompleter!.future;
    }
    if (answerError != null) {
      throw answerError!;
    }
  }

  @override
  Future<bool> stateIsLeech(ReviewAnswerChoice choice) async => false;
}

class _ControlledRenderer implements CardRenderRepository {
  final List<int> renderedCardIds = [];
  final Map<int, Completer<ReviewCardContent>> _completers = {};

  @override
  Future<ReviewCardContent> render(int cardId) {
    renderedCardIds.add(cardId);
    return _completers
        .putIfAbsent(cardId, Completer<ReviewCardContent>.new)
        .future;
  }

  void complete(int cardId, ReviewCardContent content) {
    _completers[cardId]!.complete(content);
  }
}

class _ImmediateRenderer implements CardRenderRepository {
  @override
  Future<ReviewCardContent> render(int cardId) async => _content('$cardId');
}
