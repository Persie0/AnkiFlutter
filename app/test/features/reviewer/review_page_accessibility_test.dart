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
  testWidgets('question exposes meaningful remaining counts and show-answer shortcut', (
    tester,
  ) async {
    final controller = _controller();
    await controller.start(4);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Question surface'),
        ),
      ),
    );

    expect(
      _semanticsWithLabel('1 new, 2 learning, 3 review cards remaining'),
      findsOneWidget,
    );
    expect(
      _semanticsWithLabel(
        'Show answer, keyboard shortcut Space or Enter',
        button: true,
      ),
      findsOneWidget,
    );
  });

  testWidgets('answer ratings expose interval and numeric shortcut', (tester) async {
    final controller = _controller();
    await controller.start(4);
    await controller.showAnswer();

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Answer surface'),
        ),
      ),
    );

    expect(
      _semanticsWithLabel(
        'Again, next interval 1m, keyboard shortcut 1',
        button: true,
      ),
      findsOneWidget,
    );
    expect(
      _semanticsWithLabel(
        'Hard, next interval 6m, keyboard shortcut 2',
        button: true,
      ),
      findsOneWidget,
    );
    expect(
      _semanticsWithLabel(
        'Good, next interval 1d, keyboard shortcut 3',
        button: true,
      ),
      findsOneWidget,
    );
    expect(
      _semanticsWithLabel(
        'Easy, next interval 4d, keyboard shortcut 4',
        button: true,
      ),
      findsOneWidget,
    );
  });
}

Finder _semanticsWithLabel(String label, {bool button = false}) =>
    find.byWidgetPredicate(
      (widget) =>
          widget is Semantics &&
          widget.properties.label == label &&
          (!button || widget.properties.button == true),
      description: 'Semantics(label: $label, button: $button)',
    );

ReviewController _controller() => ReviewController(
  repository: _Repository(),
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
);

class _Repository implements ReviewRepository {
  bool _returned = false;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (_returned) return null;
    _returned = true;
    return ReviewCard(
      cardId: 1,
      noteId: 2,
      deckId: 4,
      deckName: 'Deck',
      counts: const ReviewCounts(
        newCount: 1,
        learningCount: 2,
        reviewCount: 3,
      ),
      currentStateBytes: Uint8List(0),
      choices: [
        ReviewAnswerChoice(
          rating: ReviewRating.again,
          intervalLabel: '1m',
          schedulingStateBytes: Uint8List(0),
        ),
        ReviewAnswerChoice(
          rating: ReviewRating.hard,
          intervalLabel: '6m',
          schedulingStateBytes: Uint8List(0),
        ),
        ReviewAnswerChoice(
          rating: ReviewRating.good,
          intervalLabel: '1d',
          schedulingStateBytes: Uint8List(0),
        ),
        ReviewAnswerChoice(
          rating: ReviewRating.easy,
          intervalLabel: '4d',
          schedulingStateBytes: Uint8List(0),
        ),
      ],
    );
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async =>
      const ReviewDeckSettings(
        autoplay: false,
        showTimer: true,
        stopTimerOnAnswer: true,
        answerTimeLimitSeconds: 0,
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
