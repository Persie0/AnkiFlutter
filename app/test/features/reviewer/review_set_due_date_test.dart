import 'dart:async';

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
  test('set-due-date capability exposes the Reviewer default', () async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);

    expect(controller.supportsSetDueDate, isTrue);
    expect(await controller.currentCardDueDateDefault(), '3-7');
    expect(repository.defaultCalls, 1);
  });

  test('setting current due date advances to the next scheduler card', () async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);

    await controller.setCurrentCardDueDate('1!');

    expect(repository.dueDates, [(1, '1!')]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('failed set due date preserves current card and can be retried', () async {
    final repository = _Repository()..setDueDateError = StateError('set due failed');
    final controller = _controller(repository);
    await controller.start(7);

    await expectLater(controller.setCurrentCardDueDate('0'), throwsStateError);
    expect((controller.state as ReviewQuestion).card.cardId, 1);

    repository.setDueDateError = null;
    await controller.setCurrentCardDueDate('0');
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('stale set-due-date completion cannot advance a newer session', () async {
    final completer = Completer<void>();
    final repository = _Repository()..setDueDateCompleter = completer;
    final controller = _controller(repository);
    await controller.start(7);

    final settingDueDate = controller.setCurrentCardDueDate('3-7');
    await Future<void>.delayed(Duration.zero);
    await controller.start(8);
    expect((controller.state as ReviewQuestion).card.cardId, 2);

    completer.complete();
    await settingDueDate;

    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  testWidgets('Set Due Date dialog uses Reviewer default and Cancel does nothing', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    expect(find.text('Set Due Date…'), findsOneWidget);
    await tester.tap(find.text('Set Due Date…'));
    await tester.pumpAndSettle();

    expect(repository.defaultCalls, 1);
    expect(find.text('Set Due Date'), findsOneWidget);
    expect(find.text('Show card in how many days?'), findsOneWidget);
    expect(find.textContaining('0 = today'), findsOneWidget);
    expect(find.textContaining('1! = tomorrow + change interval to 1'), findsOneWidget);
    expect(find.textContaining('3-7 = random choice of 3-7 days'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, '3-7');

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.dueDates, isEmpty);
    expect((controller.state as ReviewQuestion).card.cardId, 1);
  });

  testWidgets('blank Set Due Date confirmation makes no mutation', (tester) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set Due Date…'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.text('Set'));
    await tester.pumpAndSettle();

    expect(repository.dueDates, isEmpty);
    expect((controller.state as ReviewQuestion).card.cardId, 1);
    expect(find.text('Set Due Date'), findsNothing);
  });

  testWidgets('Set Due Date confirmation preserves input and advances', (tester) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set Due Date…'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), ' 1! ');
    await tester.tap(find.text('Set'));
    await tester.pumpAndSettle();

    expect(repository.dueDates, [(1, ' 1! ')]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  testWidgets('Ctrl+Shift+D opens Set Due Date dialog', (tester) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));
    await tester.pumpAndSettle();

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyD);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();

    expect(repository.defaultCalls, 1);
    expect(find.text('Set Due Date'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, '3-7');
  });
}

Widget _app(ReviewController controller) => MaterialApp(
  home: ReviewPage(
    controller: controller,
    onFinished: () {},
    cardSurfaceBuilder: (_, _) => const Text('Card'),
  ),
);

ReviewController _controller(_Repository repository) => ReviewController(
  repository: repository,
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
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

class _Repository implements ReviewRepository, ReviewSetDueDateRepository {
  final cards = <ReviewCard>[_card(1), _card(2), _card(3)];
  int nextIndex = 0;
  int defaultCalls = 0;
  final dueDates = <(int, String)>[];
  Object? setDueDateError;
  Completer<void>? setDueDateCompleter;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (nextIndex >= cards.length) return null;
    return cards[nextIndex++];
  }

  @override
  Future<String> dueDateDefault() async {
    defaultCalls++;
    return '3-7';
  }

  @override
  Future<void> setDueDate(ReviewCard card, String days) async {
    dueDates.add((card.cardId, days));
    final pending = setDueDateCompleter;
    if (pending != null) await pending.future;
    final error = setDueDateError;
    if (error != null) throw error;
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
