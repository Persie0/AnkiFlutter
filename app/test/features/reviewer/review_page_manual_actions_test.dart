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
  testWidgets('reviewer exposes bury suspend undo and auto advance actions', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
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

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();

    expect(find.text('Undo'), findsOneWidget);
    expect(find.text('Bury card'), findsOneWidget);
    expect(find.text('Bury note'), findsOneWidget);
    expect(find.text('Suspend card'), findsOneWidget);
    expect(find.text('Suspend note'), findsOneWidget);
    expect(find.text('Auto advance'), findsOneWidget);
  });

  testWidgets('bury card action delegates to the controller and advances', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
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

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bury card'));
    await tester.pumpAndSettle();

    expect(repository.buriedCardIds, [1]);
    expect(find.text('Second deck card'), findsOneWidget);
  });

  testWidgets('auto advance action toggles checked state', (tester) async {
    final repository = _Repository();
    final controller = _controller(repository);
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

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Auto advance'));
    await tester.pumpAndSettle();
    expect(controller.autoAdvanceEnabled, isTrue);

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    final checked = tester.widget<CheckedPopupMenuItem<dynamic>>(
      find.ancestor(
        of: find.text('Auto advance'),
        matching: find.byType(CheckedPopupMenuItem<dynamic>),
      ),
    );
    expect(checked.checked, isTrue);
  });
}

ReviewController _controller(_Repository repository) => ReviewController(
  repository: repository,
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
);

ReviewCard _card(int id, String deckName) => ReviewCard(
  cardId: id,
  noteId: id + 100,
  deckId: 7,
  deckName: deckName,
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

class _Repository implements ReviewRepository {
  final cards = <ReviewCard>[
    _card(1, 'First deck card'),
    _card(2, 'Second deck card'),
  ];
  int nextIndex = 0;
  final buriedCardIds = <int>[];

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (nextIndex >= cards.length) return null;
    return cards[nextIndex++];
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async =>
      const ReviewDeckSettings(
        autoplay: false,
        showTimer: false,
        stopTimerOnAnswer: false,
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
  Future<bool> canUndo() async => true;

  @override
  Future<void> undo() async {
    nextIndex = 0;
  }

  @override
  Future<void> buryCard(ReviewCard card) async {
    buriedCardIds.add(card.cardId);
  }

  @override
  Future<void> buryNote(ReviewCard card) async {}

  @override
  Future<void> suspendCard(ReviewCard card) async {}

  @override
  Future<void> suspendNote(ReviewCard card) async {}
}
