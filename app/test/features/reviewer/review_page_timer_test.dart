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
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('on-screen review timer ticks and stops on answer when configured', (
    tester,
  ) async {
    final stopwatch = _Stopwatch(milliseconds: 1200);
    final controller = ReviewController(
      repository: _Repository(showTimer: true, stopTimerOnAnswer: true),
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: () => stopwatch,
    );
    await controller.start(7);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Card'),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('review-timer')), findsOneWidget);
    expect(find.text('0:01'), findsOneWidget);

    stopwatch.milliseconds = 2200;
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('0:02'), findsOneWidget);

    await tester.tap(find.text('Show Answer'));
    await tester.pump();
    stopwatch.milliseconds = 5900;
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('0:02'), findsOneWidget);
  });

  testWidgets('review timer is hidden when Anki show-timer setting is off', (
    tester,
  ) async {
    final controller = ReviewController(
      repository: _Repository(showTimer: false, stopTimerOnAnswer: false),
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: () => _Stopwatch(milliseconds: 1200),
    );
    await controller.start(7);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Card'),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('review-timer')), findsNothing);
  });
}

class _Repository implements ReviewRepository {
  _Repository({required this.showTimer, required this.stopTimerOnAnswer});

  final bool showTimer;
  final bool stopTimerOnAnswer;
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
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async =>
      ReviewDeckSettings(
        autoplay: false,
        showTimer: showTimer,
        stopTimerOnAnswer: stopTimerOnAnswer,
        answerTimeLimitSeconds: 60,
        secondsToShowQuestion: 0,
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
