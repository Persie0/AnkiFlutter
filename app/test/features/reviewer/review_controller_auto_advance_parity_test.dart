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
  test('question reminder stays on question and exposes elapsed notice', () async {
    final timers = _Timers();
    final repository = _Repository(
      _settings(
        questionSeconds: 1,
        questionAction: ReviewQuestionAction.showReminder,
      ),
    );
    final controller = _controller(repository, timers);

    await controller.start(7);
    await controller.toggleAutoAdvance();
    await timers.last.fire();

    expect(controller.state, isA<ReviewQuestion>());
    expect(controller.autoAdvanceReminder, 'Question time elapsed');
  });

  test('answer reminder stays on answer and exposes elapsed notice', () async {
    final timers = _Timers();
    final repository = _Repository(
      _settings(
        answerSeconds: 1,
        answerAction: ReviewAnswerAction.showReminder,
      ),
    );
    final controller = _controller(repository, timers);

    await controller.start(7);
    await controller.toggleAutoAdvance();
    await controller.showAnswer();
    await timers.last.fire();

    expect(controller.state, isA<ReviewAnswer>());
    expect(controller.autoAdvanceReminder, 'Answer time elapsed');
  });

  test('answer timeout can grade Again', () async {
    final timers = _Timers();
    final repository = _Repository(
      _settings(
        answerSeconds: 1,
        answerAction: ReviewAnswerAction.answerAgain,
      ),
    );
    final controller = _controller(repository, timers);

    await controller.start(7);
    await controller.toggleAutoAdvance();
    await controller.showAnswer();
    await timers.last.fire();

    expect(repository.ratings, [ReviewRating.again]);
  });

  test('answer timeout can grade Hard', () async {
    final timers = _Timers();
    final repository = _Repository(
      _settings(
        answerSeconds: 1,
        answerAction: ReviewAnswerAction.answerHard,
      ),
    );
    final controller = _controller(repository, timers);

    await controller.start(7);
    await controller.toggleAutoAdvance();
    await controller.showAnswer();
    await timers.last.fire();

    expect(repository.ratings, [ReviewRating.hard]);
  });

  test('answer timeout can bury the current card and advance', () async {
    final timers = _Timers();
    final repository = _Repository(
      _settings(
        answerSeconds: 1,
        answerAction: ReviewAnswerAction.buryCard,
      ),
      cards: [_card(1, 'First'), _card(2, 'Second')],
    );
    final controller = _controller(repository, timers);

    await controller.start(7);
    await controller.toggleAutoAdvance();
    await controller.showAnswer();
    await timers.last.fire();

    expect(repository.buriedCardIds, [1]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });
}

ReviewController _controller(_Repository repository, _Timers timers) =>
    ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
      timerFactory: timers.call,
    );

ReviewDeckSettings _settings({
  double questionSeconds = 0,
  double answerSeconds = 0,
  ReviewQuestionAction questionAction = ReviewQuestionAction.showAnswer,
  ReviewAnswerAction answerAction = ReviewAnswerAction.answerGood,
}) =>
    ReviewDeckSettings(
      autoplay: false,
      showTimer: false,
      stopTimerOnAnswer: false,
      answerTimeLimitSeconds: 60,
      secondsToShowQuestion: questionSeconds,
      secondsToShowAnswer: answerSeconds,
      waitForAudio: false,
      skipQuestionWhenReplayingAnswer: false,
      questionAction: questionAction,
      answerAction: answerAction,
    );

ReviewCard _card(int id, String name) => ReviewCard(
  cardId: id,
  noteId: id + 100,
  deckId: 7,
  deckName: name,
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
  _Repository(this.settings, {List<ReviewCard>? cards})
    : cards = cards ?? [_card(1, 'Deck')];

  final ReviewDeckSettings settings;
  final List<ReviewCard> cards;
  final ratings = <ReviewRating>[];
  final buriedCardIds = <int>[];
  var index = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (index >= cards.length) return null;
    return cards[index++];
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async => settings;

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {
    ratings.add(rating);
  }

  @override
  Future<void> buryCard(ReviewCard card) async {
    buriedCardIds.add(card.cardId);
  }

  @override
  Future<bool> stateIsLeech(ReviewAnswerChoice choice) async => false;

  @override
  Future<bool> canUndo() async => false;

  @override
  Future<void> undo() async {}

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
    questionHtml: 'Question',
    answerHtml: 'Answer',
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

  Future<void> fire() async {
    if (!cancelled) await callback();
  }
}
