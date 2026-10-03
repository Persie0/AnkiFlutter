import 'dart:async';
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
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('forget-card capability exposes Reviewer defaults', () async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);

    expect(controller.supportsForgetCard, isTrue);
    expect(
      await controller.forgetCurrentCardDefaults(),
      const ReviewForgetCardOptions(
        restoreOriginalPosition: true,
        resetRepetitionAndLapseCounts: false,
      ),
    );
    expect(repository.defaultsCalls, 1);
  });

  test('forgetting current card advances to the next scheduler card', () async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    const options = ReviewForgetCardOptions(
      restoreOriginalPosition: false,
      resetRepetitionAndLapseCounts: true,
    );

    await controller.forgetCurrentCard(options);

    expect(repository.forgotten, [(1, options)]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('failed forget preserves current card and can be retried', () async {
    final repository = _Repository()..forgetError = StateError('forget failed');
    final controller = _controller(repository);
    await controller.start(7);
    const options = ReviewForgetCardOptions(
      restoreOriginalPosition: true,
      resetRepetitionAndLapseCounts: false,
    );

    await expectLater(controller.forgetCurrentCard(options), throwsStateError);
    expect((controller.state as ReviewQuestion).card.cardId, 1);

    repository.forgetError = null;
    await controller.forgetCurrentCard(options);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('stale forget completion cannot advance a newer review session', () async {
    final completer = Completer<void>();
    final repository = _Repository()..forgetCompleter = completer;
    final controller = _controller(repository);
    await controller.start(7);
    const options = ReviewForgetCardOptions(
      restoreOriginalPosition: true,
      resetRepetitionAndLapseCounts: true,
    );

    final forgetting = controller.forgetCurrentCard(options);
    await Future<void>.delayed(Duration.zero);
    await controller.start(8);
    expect((controller.state as ReviewQuestion).card.cardId, 2);

    completer.complete();
    await forgetting;

    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  testWidgets('Forget card menu uses defaults and Cancel makes no mutation', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    expect(find.text('Forget card…'), findsOneWidget);
    await tester.tap(find.text('Forget card…'));
    await tester.pumpAndSettle();

    expect(repository.defaultsCalls, 1);
    expect(find.text('Restore original position where possible'), findsOneWidget);
    expect(find.text('Reset repetition and lapse counts'), findsOneWidget);
    final checkboxes = tester.widgetList<Checkbox>(find.byType(Checkbox)).toList();
    expect(checkboxes, hasLength(2));
    expect(checkboxes[0].value, isTrue);
    expect(checkboxes[1].value, isFalse);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.forgotten, isEmpty);
    expect((controller.state as ReviewQuestion).card.cardId, 1);
  });

  testWidgets('Forget card confirmation delegates edited options and advances', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forget card…'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Reset repetition and lapse counts'));
    await tester.pump();
    await tester.tap(find.text('Forget'));
    await tester.pumpAndSettle();

    expect(
      repository.forgotten,
      [
        (
          1,
          const ReviewForgetCardOptions(
            restoreOriginalPosition: true,
            resetRepetitionAndLapseCounts: true,
          ),
        ),
      ],
    );
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  testWidgets('Ctrl+Alt+N opens Forget card dialog', (tester) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));
    await tester.pumpAndSettle();

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.altLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyN);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.altLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();

    expect(repository.defaultsCalls, 1);
    expect(find.text('Restore original position where possible'), findsOneWidget);
    expect(find.text('Reset repetition and lapse counts'), findsOneWidget);
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

class _Repository implements ReviewRepository, ReviewForgetCardRepository {
  final cards = <ReviewCard>[_card(1), _card(2), _card(3)];
  int nextIndex = 0;
  int defaultsCalls = 0;
  final forgotten = <(int, ReviewForgetCardOptions)>[];
  Object? forgetError;
  Completer<void>? forgetCompleter;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (nextIndex >= cards.length) return null;
    return cards[nextIndex++];
  }

  @override
  Future<ReviewForgetCardOptions> forgetCardDefaults() async {
    defaultsCalls++;
    return const ReviewForgetCardOptions(
      restoreOriginalPosition: true,
      resetRepetitionAndLapseCounts: false,
    );
  }

  @override
  Future<void> forgetCard(
    ReviewCard card,
    ReviewForgetCardOptions options,
  ) async {
    forgotten.add((card.cardId, options));
    final pending = forgetCompleter;
    if (pending != null) await pending.future;
    final error = forgetError;
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
