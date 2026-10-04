import 'dart:async';

import 'package:anki_flutter/features/card_info/card_info_page.dart';
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
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('review menu exposes current and previous Card Info targets', (
    tester,
  ) async {
    final harness = await _pumpReviewer(tester);

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();

    expect(find.text('Card Info'), findsOneWidget);
    expect(find.text('Previous Card Info'), findsOneWidget);

    await tester.tap(find.text('Card Info'));
    await tester.pumpAndSettle();

    expect(harness.targets, hasLength(1));
    expect(harness.targets.single.kind, CardInfoKind.current);
    expect(harness.targets.single.cardId, 1);
    expect(harness.repository.nextCardCalls, 1);
    expect(harness.repository.answerCalls, 0);
    expect(harness.controller.state, isA<ReviewQuestion>());
  });

  testWidgets('I opens current Card Info and Ctrl+Alt+I opens empty previous target', (
    tester,
  ) async {
    final harness = await _pumpReviewer(tester);

    await tester.sendKeyEvent(LogicalKeyboardKey.keyI);
    await tester.pumpAndSettle();

    expect(harness.targets, hasLength(1));
    expect(harness.targets[0].kind, CardInfoKind.current);
    expect(harness.targets[0].cardId, 1);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.altLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyI);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.altLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();

    expect(harness.targets, hasLength(2));
    expect(harness.targets[1].kind, CardInfoKind.previous);
    expect(harness.targets[1].cardId, isNull);
    expect(harness.repository.nextCardCalls, 1);
  });

  testWidgets('previous Card Info keeps outgoing deleted card id unchanged', (
    tester,
  ) async {
    final harness = await _pumpReviewer(tester);

    await harness.controller.deleteCurrentNote();
    await tester.pumpAndSettle();
    expect((harness.controller.state as ReviewQuestion).card.cardId, 2);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.altLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyI);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.altLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();

    expect(harness.targets.single.kind, CardInfoKind.previous);
    expect(harness.targets.single.cardId, 1);
    expect(harness.repository.deletedNoteIds, [101]);
  });

  testWidgets('Card Info pauses and restores enabled auto advance', (tester) async {
    final block = Completer<void>();
    final harness = await _pumpReviewer(tester, openerBlock: block);
    await harness.controller.toggleAutoAdvance();
    expect(harness.controller.autoAdvanceEnabled, isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.keyI);
    await tester.pump();

    expect(harness.targets, hasLength(1));
    expect(harness.controller.autoAdvanceEnabled, isFalse);
    expect(harness.repository.nextCardCalls, 1);
    expect(harness.repository.answerCalls, 0);
    expect(harness.controller.state, isA<ReviewQuestion>());

    block.complete();
    await tester.pumpAndSettle();

    expect(harness.controller.autoAdvanceEnabled, isTrue);
    expect(harness.repository.nextCardCalls, 1);
  });

  testWidgets('stale Card Info return cannot restore auto advance on newer session', (
    tester,
  ) async {
    final block = Completer<void>();
    final harness = await _pumpReviewer(tester, openerBlock: block);
    await harness.controller.toggleAutoAdvance();

    await tester.sendKeyEvent(LogicalKeyboardKey.keyI);
    await tester.pump();
    expect(harness.controller.autoAdvanceEnabled, isFalse);

    await harness.controller.start(8);
    await tester.pump();
    expect((harness.controller.state as ReviewQuestion).card.cardId, 2);

    block.complete();
    await tester.pumpAndSettle();

    expect(harness.controller.autoAdvanceEnabled, isFalse);
    expect((harness.controller.state as ReviewQuestion).card.cardId, 2);
    expect(harness.repository.nextCardCalls, 2);
  });

  testWidgets('Card Info opener error stays in Reviewer and does not mutate card', (
    tester,
  ) async {
    final harness = await _pumpReviewer(tester, openerError: StateError('boom'));

    await tester.sendKeyEvent(LogicalKeyboardKey.keyI);
    await tester.pumpAndSettle();

    expect(find.textContaining('Could not apply review action'), findsOneWidget);
    expect(find.textContaining('boom'), findsOneWidget);
    expect((harness.controller.state as ReviewQuestion).card.cardId, 1);
    expect(harness.repository.nextCardCalls, 1);
    expect(harness.repository.answerCalls, 0);
    expect(harness.repository.deletedNoteIds, isEmpty);
  });
}

Future<_Harness> _pumpReviewer(
  WidgetTester tester, {
  Completer<void>? openerBlock,
  Object? openerError,
}) async {
  final repository = _Repository();
  final controller = ReviewController(
    repository: repository,
    renderer: _Renderer(),
    wallClockMillis: () => 100,
    stopwatchFactory: Stopwatch.new,
  );
  addTearDown(controller.dispose);
  await controller.start(7);

  final targets = <ReviewCardInfoTarget>[];
  await tester.pumpWidget(
    MaterialApp(
      home: ReviewPage(
        controller: controller,
        onOpenCardInfo: (target) async {
          targets.add(target);
          if (openerError != null) throw openerError;
          final block = openerBlock;
          if (block != null) await block.future;
        },
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

final class _Harness {
  const _Harness({
    required this.repository,
    required this.controller,
    required this.targets,
  });

  final _Repository repository;
  final ReviewController controller;
  final List<ReviewCardInfoTarget> targets;
}

final class _Repository implements ReviewRepository, ReviewDeleteNoteRepository {
  final cards = <ReviewCard>[_card(1), _card(2), _card(3)];
  final deletedNoteIds = <int>[];
  var nextCardCalls = 0;
  var answerCalls = 0;
  var _index = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    nextCardCalls++;
    if (_index >= cards.length) return null;
    return cards[_index++];
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async => _settings;

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {
    answerCalls++;
  }

  @override
  Future<void> deleteNote(ReviewCard card) async {
    deletedNoteIds.add(card.noteId);
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

final class _Renderer implements CardRenderRepository {
  @override
  Future<ReviewCardContent> render(int cardId) async => ReviewCardContent(
    questionHtml: 'Question $cardId',
    answerHtml: 'Answer $cardId',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}
