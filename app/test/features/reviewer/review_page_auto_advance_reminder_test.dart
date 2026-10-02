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
  testWidgets('question reminder is visible and clears when answer is shown', (
    tester,
  ) async {
    final timers = _Timers();
    final controller = ReviewController(
      repository: _Repository(),
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
      timerFactory: timers.call,
    );
    await controller.start(7);
    await controller.toggleAutoAdvance();

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Card'),
        ),
      ),
    );

    await timers.last.fire();
    await tester.pump();
    expect(find.byKey(const ValueKey('auto-advance-reminder')), findsOneWidget);
    expect(find.text('Question time elapsed'), findsOneWidget);

    await tester.tap(find.text('Show Answer'));
    await tester.pump();
    expect(find.byKey(const ValueKey('auto-advance-reminder')), findsNothing);
  });
}

class _Repository implements ReviewRepository {
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
      const ReviewDeckSettings(
        autoplay: false,
        showTimer: false,
        stopTimerOnAnswer: false,
        answerTimeLimitSeconds: 60,
        secondsToShowQuestion: 1,
        secondsToShowAnswer: 0,
        waitForAudio: false,
        skipQuestionWhenReplayingAnswer: false,
        questionAction: ReviewQuestionAction.showReminder,
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

class _Timers {
  final timers = <_Timer>[];

  _Timer get last => timers.last;

  ReviewTimerHandle call(Duration delay, Future<void> Function() callback) {
    final timer = _Timer(callback);
    timers.add(timer);
    return timer;
  }
}

class _Timer implements ReviewTimerHandle {
  _Timer(this.callback);

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
