import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/reviewer.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('tracks current and immediately previous displayed card', () async {
    final repository = _Repository([_card(1), _card(2), _card(3)]);
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    expect(controller.currentCardId, 1);
    expect(controller.previousCardId, isNull);

    await controller.showAnswer();
    await controller.rate(ReviewRating.good);
    expect(controller.currentCardId, 2);
    expect(controller.previousCardId, 1);

    await controller.showAnswer();
    await controller.rate(ReviewRating.good);
    expect(controller.currentCardId, 3);
    expect(controller.previousCardId, 2);
  });

  test('advancing manual actions use the same previous-card semantics', () async {
    final repository = _Repository([_card(10), _card(20)]);
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.buryCurrentCard();

    expect(controller.currentCardId, 20);
    expect(controller.previousCardId, 10);
  });

  test('starting a new reviewer session clears old previous-card state', () async {
    final repository = _Repository([_card(1), _card(2), _card(3)]);
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.good);
    expect(controller.previousCardId, 1);

    await controller.start(9);

    expect(controller.currentCardId, 3);
    expect(controller.previousCardId, isNull);
  });

  test('secondary surface pauses and restores auto advance on same card', () async {
    final timers = _Timers();
    final controller = _controller(
      _Repository([_card(1)], questionSeconds: 5),
      timers: timers,
    );
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.toggleAutoAdvance();
    final originalTimer = timers.last;

    final token = controller.pauseForSecondarySurface();

    expect(token, isNotNull);
    expect(token!.cardId, 1);
    expect(token.restoreAutoAdvance, isTrue);
    expect(controller.autoAdvanceEnabled, isFalse);
    expect(originalTimer.cancelled, isTrue);

    controller.resumeAfterSecondarySurface(token);

    expect(controller.autoAdvanceEnabled, isTrue);
    expect(timers.timers, hasLength(2));
    expect(timers.last.cancelled, isFalse);
  });

  test('secondary surface does not enable auto advance that was off', () async {
    final timers = _Timers();
    final controller = _controller(_Repository([_card(1)]), timers: timers);
    addTearDown(controller.dispose);

    await controller.start(7);
    final token = controller.pauseForSecondarySurface();

    expect(token, isNotNull);
    expect(token!.restoreAutoAdvance, isFalse);
    controller.resumeAfterSecondarySurface(token);
    expect(controller.autoAdvanceEnabled, isFalse);
    expect(timers.timers, isEmpty);
  });

  test('stale secondary surface cannot re-enable a newer session', () async {
    final timers = _Timers();
    final repository = _Repository([_card(1), _card(2)], questionSeconds: 5);
    final controller = _controller(repository, timers: timers);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.toggleAutoAdvance();
    final token = controller.pauseForSecondarySurface()!;

    await controller.start(8);
    expect(controller.currentCardId, 2);
    expect(controller.autoAdvanceEnabled, isFalse);

    controller.resumeAfterSecondarySurface(token);

    expect(controller.currentCardId, 2);
    expect(controller.autoAdvanceEnabled, isFalse);
  });

  test('secondary-surface pause is unavailable outside a visible card', () {
    final controller = _controller(_Repository(const []));
    addTearDown(controller.dispose);

    expect(controller.pauseForSecondarySurface(), isNull);
  });
}

ReviewController _controller(
  _Repository repository, {
  _Timers? timers,
}) => ReviewController(
  repository: repository,
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
  timerFactory: timers?.call,
);

ReviewCard _card(int id) => ReviewCard(
  cardId: id,
  noteId: id + 100,
  deckId: 7,
  deckName: 'Deck',
  counts: const ReviewCounts(newCount: 1, learningCount: 0, reviewCount: 0),
  currentStateBytes: Uint8List(0),
  choices: [
    for (final rating in ReviewRating.values)
      ReviewAnswerChoice(
        rating: rating,
        intervalLabel: '1d',
        schedulingStateBytes: Uint8List(0),
      ),
  ],
);

class _Repository implements ReviewRepository {
  _Repository(this.cards, {this.questionSeconds = 0});

  final List<ReviewCard> cards;
  final double questionSeconds;
  var index = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async => index < cards.length ? cards[index++] : null;

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async =>
      ReviewDeckSettings(
        autoplay: false,
        showTimer: false,
        stopTimerOnAnswer: false,
        answerTimeLimitSeconds: 60,
        secondsToShowQuestion: questionSeconds,
        secondsToShowAnswer: 0,
        waitForAudio: false,
        skipQuestionWhenReplayingAnswer: false,
        questionAction: ReviewQuestionAction.showAnswer,
        answerAction: ReviewAnswerAction.answerGood,
      );

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {}

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

class _Renderer implements CardRenderRepository {
  @override
  Future<ReviewCardContent> render(int cardId) async => ReviewCardContent(
    questionHtml: 'Question $cardId',
    answerHtml: 'Answer $cardId',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}

class _Timers {
  final timers = <_Timer>[];

  _Timer get last => timers.last;

  ReviewTimerHandle call(Duration delay, Future<void> Function() callback) {
    final timer = _Timer(delay, callback);
    timers.add(timer);
    return timer;
  }
}

class _Timer implements ReviewTimerHandle {
  _Timer(this.delay, this.callback);

  final Duration delay;
  final Future<void> Function() callback;
  bool cancelled = false;

  @override
  bool get isActive => !cancelled;

  @override
  void cancel() => cancelled = true;
}
