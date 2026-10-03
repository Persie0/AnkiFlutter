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
  testWidgets('Ctrl+1 through Ctrl+7 sets current Anki card flag', (tester) async {
    final repository = _Repository();
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
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

    expect(find.byTooltip('Flag 2'), findsOneWidget);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit3);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();

    expect(repository.setFlags, [3]);
    expect(controller.currentFlag, 3);
    expect(find.byTooltip('Flag 3'), findsOneWidget);
  });

  testWidgets('review actions can clear the current flag', (tester) async {
    final repository = _Repository();
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
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

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set flag…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear flag'));
    await tester.pumpAndSettle();

    expect(repository.setFlags, [0]);
    expect(controller.currentFlag, 0);
    expect(find.byTooltip('Flag 2'), findsNothing);
  });
}

class _Repository implements ReviewRepository, ReviewFlagRepository {
  final setFlags = <int>[];
  var served = false;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (served) return null;
    served = true;
    return ReviewCard(
      cardId: 1,
      noteId: 101,
      deckId: 7,
      flag: 2,
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
  Future<void> setFlag(ReviewCard card, int flag) async {
    setFlags.add(flag);
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async =>
      const ReviewDeckSettings(
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
