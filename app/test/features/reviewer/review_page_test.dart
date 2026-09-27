import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('question renders card and only show answer', (tester) async {
    final controller = _controller();
    await controller.start(4);
    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Fake surface'),
        ),
      ),
    );
    expect(find.text('Show Answer'), findsOneWidget);
    expect(find.textContaining('Again'), findsNothing);
  });

  testWidgets('answer renders all four ratings and sends selected rating', (
    tester,
  ) async {
    final controller = _controller();
    await controller.start(4);
    await controller.showAnswer();
    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Fake surface'),
        ),
      ),
    );
    expect(find.textContaining('Again'), findsOneWidget);
    expect(find.textContaining('Hard'), findsOneWidget);
    expect(find.textContaining('Good'), findsOneWidget);
    expect(find.textContaining('Easy'), findsOneWidget);
    await tester.tap(find.textContaining('Good'));
    await tester.pumpAndSettle();
    expect(controller.state, isA<ReviewFinished>());
  });

  testWidgets('backend failure offers retry and can recover', (tester) async {
    final repository = _Repository()..failNextCard = true;
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    await controller.start(4);
    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Fake surface'),
        ),
      ),
    );
    expect(find.text('Retry'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Show Answer'), findsOneWidget);
  });
}

ReviewController _controller() => ReviewController(
  repository: _Repository(),
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
);

class _Repository implements ReviewRepository {
  bool _returned = false;
  bool failNextCard = false;
  @override
  Future<void> selectDeck(int deckId) async {}
  @override
  Future<ReviewCard?> nextCard() async {
    if (failNextCard) {
      failNextCard = false;
      throw StateError('temporary failure');
    }
    if (_returned) return null;
    _returned = true;
    return _card();
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

ReviewCard _card() => ReviewCard(
  cardId: 1,
  noteId: 2,
  deckId: 4,
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
