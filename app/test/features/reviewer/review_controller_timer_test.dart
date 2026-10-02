import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recorded review time is capped by Anki maximum answer seconds', () async {
    final stopwatch = _Stopwatch(milliseconds: 9500);
    final repository = _Repository(
      _settings(
        stopTimerOnAnswer: false,
        answerTimeLimitSeconds: 3,
      ),
    );
    final controller = _controller(repository, stopwatch);

    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.good);

    expect(repository.recordedMilliseconds, [3000]);
  });

  test(
    'stop on answer freezes visible timer but not recorded review time',
    () async {
      final stopwatch = _Stopwatch(milliseconds: 1200);
      final repository = _Repository(
        _settings(
          stopTimerOnAnswer: true,
          answerTimeLimitSeconds: 60,
        ),
      );
      final controller = _controller(repository, stopwatch);

      await controller.start(7);
      expect(controller.reviewTimerElapsed, const Duration(milliseconds: 1200));

      await controller.showAnswer();
      stopwatch.milliseconds = 4500;

      expect(controller.reviewTimerElapsed, const Duration(milliseconds: 1200));
      await controller.rate(ReviewRating.good);
      expect(repository.recordedMilliseconds, [4500]);
    },
  );

  test('visible timer stops at the maximum answer seconds cap', () async {
    final stopwatch = _Stopwatch(milliseconds: 8500);
    final repository = _Repository(
      _settings(
        stopTimerOnAnswer: false,
        answerTimeLimitSeconds: 3,
      ),
    );
    final controller = _controller(repository, stopwatch);

    await controller.start(7);

    expect(controller.reviewTimerElapsed, const Duration(seconds: 3));
  });
}

ReviewController _controller(_Repository repository, _Stopwatch stopwatch) =>
    ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: () => stopwatch,
    );

ReviewDeckSettings _settings({
  required bool stopTimerOnAnswer,
  required int answerTimeLimitSeconds,
}) =>
    ReviewDeckSettings(
      autoplay: false,
      showTimer: true,
      stopTimerOnAnswer: stopTimerOnAnswer,
      answerTimeLimitSeconds: answerTimeLimitSeconds,
      secondsToShowQuestion: 0,
      secondsToShowAnswer: 0,
      waitForAudio: false,
      skipQuestionWhenReplayingAnswer: false,
      questionAction: ReviewQuestionAction.showAnswer,
      answerAction: ReviewAnswerAction.answerGood,
    );

class _Repository implements ReviewRepository {
  _Repository(this.settings);

  final ReviewDeckSettings settings;
  final recordedMilliseconds = <int>[];
  var served = false;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (served) return null;
    served = true;
    return ReviewCard(
      cardId: 1,
      noteId: 2,
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
    recordedMilliseconds.add(millisecondsTaken);
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

class _Stopwatch implements Stopwatch {
  _Stopwatch({required this.milliseconds});

  int milliseconds;
  bool running = false;

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
  bool get isRunning => running;

  @override
  void reset() => milliseconds = 0;

  @override
  void start() => running = true;

  @override
  void stop() => running = false;
}
