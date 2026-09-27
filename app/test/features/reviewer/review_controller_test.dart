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
  test('start selects deck loads one card and enters question state', () async {
    final card = _card();
    final content = _content();
    final repository = _FakeReviewRepository(
      nextCards: [card],
      settings: _settings,
    );
    final renderer = _FakeCardRenderRepository(content);
    var stopwatchFactoryCalls = 0;
    final controller = ReviewController(
      repository: repository,
      renderer: renderer,
      wallClockMillis: () => 123456789,
      stopwatchFactory: () {
        stopwatchFactoryCalls += 1;
        return Stopwatch();
      },
    );

    await controller.start(42);

    expect(repository.selectedDecks, [42]);
    expect(repository.nextCardCalls, 1);
    expect(repository.settingsDecks, [card.deckId]);
    expect(renderer.renderedCardIds, [card.cardId]);
    expect(stopwatchFactoryCalls, 1);

    final state = controller.state;
    expect(state, isA<ReviewQuestion>());
    final question = state as ReviewQuestion;
    expect(question.card, same(card));
    expect(question.content, same(content));
    expect(question.settings, same(_settings));
    expect(question.generationId, greaterThan(0));
  });

  test('start enters finished state when Anki queue is empty', () async {
    final repository = _FakeReviewRepository(
      nextCards: [null],
      settings: _settings,
    );
    final renderer = _FakeCardRenderRepository(_content());
    var stopwatchFactoryCalls = 0;
    final controller = ReviewController(
      repository: repository,
      renderer: renderer,
      wallClockMillis: () => 123456789,
      stopwatchFactory: () {
        stopwatchFactoryCalls += 1;
        return Stopwatch();
      },
    );

    await controller.start(42);

    expect(controller.state, isA<ReviewFinished>());
    expect(repository.selectedDecks, [42]);
    expect(repository.nextCardCalls, 1);
    expect(repository.settingsDecks, isEmpty);
    expect(renderer.renderedCardIds, isEmpty);
    expect(stopwatchFactoryCalls, 0);
  });

  test('showAnswer preserves current review data without refetching', () async {
    final card = _card();
    final content = _content();
    final repository = _FakeReviewRepository(
      nextCards: [card],
      settings: _settings,
    );
    final renderer = _FakeCardRenderRepository(content);
    final controller = ReviewController(
      repository: repository,
      renderer: renderer,
      wallClockMillis: () => 123456789,
      stopwatchFactory: Stopwatch.new,
    );

    await controller.start(42);
    final question = controller.state as ReviewQuestion;
    final callsBeforeReveal = (
      nextCard: repository.nextCardCalls,
      settings: repository.settingsDecks.length,
      render: renderer.renderedCardIds.length,
    );

    await controller.showAnswer();

    final state = controller.state;
    expect(state, isA<ReviewAnswer>());
    final answer = state as ReviewAnswer;
    expect(answer.card, same(question.card));
    expect(answer.content, same(question.content));
    expect(answer.settings, same(question.settings));
    expect(answer.generationId, question.generationId);
    expect(repository.nextCardCalls, callsBeforeReveal.nextCard);
    expect(repository.settingsDecks.length, callsBeforeReveal.settings);
    expect(renderer.renderedCardIds.length, callsBeforeReveal.render);
  });

  test('rating is ignored while question is showing', () async {
    final card = _card();
    final repository = _FakeReviewRepository(
      nextCards: [card],
      settings: _settings,
    );
    final controller = ReviewController(
      repository: repository,
      renderer: _FakeCardRenderRepository(_content()),
      wallClockMillis: () => 123456789,
      stopwatchFactory: () => _FakeStopwatch(milliseconds: 3210),
    );

    await controller.start(42);
    await controller.rate(ReviewRating.good);

    expect(controller.state, isA<ReviewQuestion>());
    expect(repository.answerCalls, isEmpty);
    expect(repository.nextCardCalls, 1);
  });

  test('rating transitions immediately and submits exact timing once', () async {
    final card = _card();
    final answerCompleter = Completer<void>();
    final repository = _FakeReviewRepository(
      nextCards: [card, null],
      settings: _settings,
      answerCompleter: answerCompleter,
    );
    final stopwatch = _FakeStopwatch(milliseconds: 3210);
    final controller = ReviewController(
      repository: repository,
      renderer: _FakeCardRenderRepository(_content()),
      wallClockMillis: () => 123456789,
      stopwatchFactory: () => stopwatch,
    );

    await controller.start(42);
    await controller.showAnswer();

    final firstRating = controller.rate(ReviewRating.good);
    final duplicateRating = controller.rate(ReviewRating.easy);
    await Future<void>.delayed(Duration.zero);

    expect(controller.state, isA<ReviewTransition>());
    expect(repository.answerCalls, hasLength(1));
    final call = repository.answerCalls.single;
    expect(call.card, same(card));
    expect(call.rating, ReviewRating.good);
    expect(call.answeredAtMillis, 123456789);
    expect(call.millisecondsTaken, 3210);
    expect(repository.nextCardCalls, 1);

    answerCompleter.complete();
    await Future.wait([firstRating, duplicateRating]);

    expect(repository.answerCalls, hasLength(1));
    expect(repository.nextCardCalls, 2);
    expect(controller.state, isA<ReviewFinished>());
  });

  test('backend answer failure restores same answer with error', () async {
    final card = _card();
    final content = _content();
    final error = StateError('answer failed');
    final repository = _FakeReviewRepository(
      nextCards: [card],
      settings: _settings,
      answerError: error,
    );
    final controller = ReviewController(
      repository: repository,
      renderer: _FakeCardRenderRepository(content),
      wallClockMillis: () => 123456789,
      stopwatchFactory: () => _FakeStopwatch(milliseconds: 3210),
    );

    await controller.start(42);
    await controller.showAnswer();
    final before = controller.state as ReviewAnswer;

    await controller.rate(ReviewRating.good);

    expect(repository.nextCardCalls, 1);
    expect(controller.state, isA<ReviewAnswer>());
    final recovered = controller.state as ReviewAnswer;
    expect(recovered.card, same(before.card));
    expect(recovered.content, same(before.content));
    expect(recovered.settings, same(before.settings));
    expect(recovered.generationId, before.generationId);
    expect(recovered.error, same(error));
  });
}

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

ReviewCardContent _content() {
  return ReviewCardContent(
    questionHtml: '<div>question</div>',
    answerHtml: '<div>answer</div>',
    css: '.card { font-size: 20px; }',
    questionAudio: const [],
    answerAudio: const [],
  );
}

ReviewCard _card() {
  return ReviewCard(
    cardId: 1001,
    noteId: 2001,
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
    deckName: 'Deck',
  );
}

class _AnswerCall {
  const _AnswerCall({
    required this.card,
    required this.rating,
    required this.answeredAtMillis,
    required this.millisecondsTaken,
  });

  final ReviewCard card;
  final ReviewRating rating;
  final int answeredAtMillis;
  final int millisecondsTaken;
}

class _FakeReviewRepository implements ReviewRepository {
  _FakeReviewRepository({
    required List<ReviewCard?> nextCards,
    required this.settings,
    this.answerCompleter,
    this.answerError,
  }) : _nextCards = List<ReviewCard?>.of(nextCards);

  final List<ReviewCard?> _nextCards;
  final ReviewDeckSettings settings;
  final Completer<void>? answerCompleter;
  final Object? answerError;
  final List<int> selectedDecks = [];
  final List<int> settingsDecks = [];
  final List<_AnswerCall> answerCalls = [];
  int nextCardCalls = 0;

  @override
  Future<void> selectDeck(int deckId) async {
    selectedDecks.add(deckId);
  }

  @override
  Future<ReviewCard?> nextCard() async {
    nextCardCalls += 1;
    return _nextCards.removeAt(0);
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async {
    settingsDecks.add(deckId);
    return settings;
  }

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {
    answerCalls.add(
      _AnswerCall(
        card: card,
        rating: rating,
        answeredAtMillis: answeredAtMillis,
        millisecondsTaken: millisecondsTaken,
      ),
    );
    if (answerCompleter != null) {
      await answerCompleter!.future;
    }
    if (answerError != null) {
      throw answerError!;
    }
  }

  @override
  Future<bool> stateIsLeech(ReviewAnswerChoice choice) async => false;

  @override
  Future<bool> canUndo() async => false;

  @override
  Future<void> undo() async {}

  @override
  Future<void> buryCard(ReviewCard card) async {}

  @override
  Future<void> buryNote(ReviewCard card) async {}

  @override
  Future<void> suspendCard(ReviewCard card) async {}

  @override
  Future<void> suspendNote(ReviewCard card) async {}
}

class _FakeCardRenderRepository implements CardRenderRepository {
  _FakeCardRenderRepository(this.content);

  final ReviewCardContent content;
  final List<int> renderedCardIds = [];

  @override
  Future<ReviewCardContent> render(int cardId) async {
    renderedCardIds.add(cardId);
    return content;
  }
}

class _FakeStopwatch implements Stopwatch {
  _FakeStopwatch({required this.milliseconds});

  int milliseconds;
  bool _isRunning = false;

  @override
  Duration get elapsed => Duration(milliseconds: milliseconds);

  @override
  int get elapsedMicroseconds => milliseconds * 1000;

  @override
  int get elapsedMilliseconds => milliseconds;

  @override
  int get elapsedTicks => milliseconds;

  @override
  int get frequency => 1000;

  @override
  bool get isRunning => _isRunning;

  @override
  void reset() {
    milliseconds = 0;
  }

  @override
  void start() {
    _isRunning = true;
  }

  @override
  void stop() {
    _isRunning = false;
  }
}
