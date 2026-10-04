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
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Options menu opens matching study deck directly', (tester) async {
    final harness = await _pumpReviewer(
      tester,
      card: _card(deckId: 7, deckName: 'Study Deck'),
      studyDeckId: 7,
    );

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    expect(find.text('Options'), findsOneWidget);

    await tester.tap(find.text('Options'));
    await tester.pumpAndSettle();

    expect(harness.targets, hasLength(1));
    expect(harness.targets.single.deckId, 7);
    expect(harness.targets.single.filtered, isFalse);
    expect(harness.repository.nextCardCalls, 1);
    expect(harness.repository.settingsDecks, [7, 7]);
  });

  testWidgets('O shortcut opens reviewer Options', (tester) async {
    final harness = await _pumpReviewer(
      tester,
      card: _card(deckId: 7, deckName: 'Study Deck'),
      studyDeckId: 7,
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.keyO);
    await tester.pumpAndSettle();

    expect(harness.targets, hasLength(1));
    expect(harness.targets.single.deckId, 7);
    expect(harness.targets.single.filtered, isFalse);
  });

  testWidgets('Options can target the current card deck when it differs', (
    tester,
  ) async {
    final harness = await _pumpReviewer(
      tester,
      card: _card(deckId: 9, deckName: 'Card Deck'),
      studyDeckId: 7,
    );

    await _openOptionsMenu(tester);

    expect(find.text('Study Options'), findsOneWidget);
    expect(find.text('Card Deck Options'), findsOneWidget);

    await tester.tap(find.text('Card Deck Options'));
    await tester.pumpAndSettle();

    expect(harness.targets, hasLength(1));
    expect(harness.targets.single.deckId, 9);
    expect(harness.targets.single.filtered, isFalse);
  });

  testWidgets('Options can target the selected study deck', (tester) async {
    final harness = await _pumpReviewer(
      tester,
      card: _card(deckId: 9, deckName: 'Card Deck'),
      studyDeckId: 7,
    );

    await _openOptionsMenu(tester);
    await tester.tap(find.text('Study Options'));
    await tester.pumpAndSettle();

    expect(harness.targets, hasLength(1));
    expect(harness.targets.single.deckId, 7);
    expect(harness.targets.single.filtered, isFalse);
  });

  testWidgets('cancelling deck choice does not open options', (tester) async {
    final harness = await _pumpReviewer(
      tester,
      card: _card(deckId: 9, deckName: 'Card Deck'),
      studyDeckId: 7,
    );

    await _openOptionsMenu(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(harness.targets, isEmpty);
    expect(harness.repository.settingsDecks, [9]);
  });

  testWidgets('filtered cards route to filtered deck configuration target', (
    tester,
  ) async {
    final harness = await _pumpReviewer(
      tester,
      card: _card(
        deckId: 99,
        originalDeckId: 9,
        deckName: 'Filtered Deck',
      ),
      studyDeckId: 99,
    );

    await _openOptionsMenu(tester);
    await tester.pumpAndSettle();

    expect(find.text('Study Options'), findsNothing);
    expect(harness.targets, hasLength(1));
    expect(harness.targets.single.deckId, 99);
    expect(harness.targets.single.filtered, isTrue);
    expect(harness.repository.settingsDecks, [9, 9]);
  });
}

Future<void> _openOptionsMenu(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Review actions'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Options'));
  await tester.pumpAndSettle();
}

Future<_Harness> _pumpReviewer(
  WidgetTester tester, {
  required ReviewCard card,
  required int studyDeckId,
}) async {
  final repository = _Repository(card);
  final controller = ReviewController(
    repository: repository,
    renderer: _Renderer(),
    wallClockMillis: () => 100,
    stopwatchFactory: Stopwatch.new,
  );
  addTearDown(controller.dispose);
  await controller.start(studyDeckId);

  final targets = <ReviewDeckOptionsTarget>[];
  await tester.pumpWidget(
    MaterialApp(
      home: ReviewPage(
        controller: controller,
        studyDeckId: studyDeckId,
        onOpenDeckOptions: (target) async => targets.add(target),
        onFinished: () {},
        cardSurfaceBuilder: (_, _) => const Text('Card'),
      ),
    ),
  );
  await tester.pump();

  return _Harness(
    repository: repository,
    controller: controller,
    targets: targets,
  );
}

class _Harness {
  const _Harness({
    required this.repository,
    required this.controller,
    required this.targets,
  });

  final _Repository repository;
  final ReviewController controller;
  final List<ReviewDeckOptionsTarget> targets;
}

class _Repository implements ReviewRepository {
  _Repository(this.card);

  final ReviewCard card;
  final settingsDecks = <int>[];
  var nextCardCalls = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    nextCardCalls++;
    return nextCardCalls == 1 ? card : null;
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async {
    settingsDecks.add(deckId);
    return _settings;
  }

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

ReviewCard _card({
  required int deckId,
  required String deckName,
  int originalDeckId = 0,
}) => ReviewCard(
  cardId: 1,
  noteId: 101,
  deckId: deckId,
  originalDeckId: originalDeckId,
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

const _settings = ReviewDeckSettings(
  autoplay: false,
  showTimer: false,
  stopTimerOnAnswer: false,
  answerTimeLimitSeconds: 60,
  secondsToShowQuestion: 0,
  secondsToShowAnswer: 0,
  waitForAudio: false,
  skipQuestionWhenReplayingAnswer: false,
  questionAction: ReviewQuestionAction.showAnswer,
  answerAction: ReviewAnswerAction.answerGood,
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
