import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_typed_answer_prompt.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('type marker becomes a native answer input instead of raw text', (
    tester,
  ) async {
    final controller = ReviewController(
      repository: _Repository(),
      renderer: _Renderer('Capital: [[type:Front]]'),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    await controller.start(7);

    String? cardHtml;
    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, html) {
            cardHtml = html;
            return const SizedBox.expand();
          },
        ),
      ),
    );

    expect(find.byKey(const ValueKey('typed-answer-input')), findsOneWidget);
    expect(cardHtml, isNot(contains('[[type:Front]]')));
  });

  testWidgets('typed answer uses Anki comparison HTML when answer is revealed', (
    tester,
  ) async {
    final repository = _TypedRepository();
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer('Capital: [[type:Front]]'),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    await controller.start(7);

    String? cardHtml;
    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, html) {
            cardHtml = html;
            return const SizedBox.expand();
          },
        ),
      ),
    );

    final input = find.byKey(const ValueKey('typed-answer-input'));
    expect(input, findsOneWidget);
    await tester.enterText(input, 'Pari');
    await tester.tap(find.text('Show Answer'));
    await tester.pump();

    expect(repository.lastProvided, 'Pari');
    expect(repository.lastExpected, 'Paris');
    expect(repository.lastCombining, isTrue);
    expect(cardHtml, contains('<code id=typeans>'));
    expect(cardHtml, contains('typeGood'));
    expect(cardHtml, contains("font-family: 'Arial'"));
    expect(cardHtml, contains('font-size: 24px'));
    expect(cardHtml, isNot(contains('[[type:Front]]')));
    expect(input, findsNothing);
  });

  testWidgets('ordinary cards do not show a typed-answer input', (tester) async {
    final controller = ReviewController(
      repository: _Repository(),
      renderer: _Renderer('Capital of France?'),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    await controller.start(7);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const SizedBox.expand(),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('typed-answer-input')), findsNothing);
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
      noteId: 101,
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

class _TypedRepository extends _Repository
    implements ReviewTypedAnswerRepository {
  String? lastExpected;
  String? lastProvided;
  bool? lastCombining;

  @override
  Future<ReviewTypedAnswerPrompt?> prepareTypedAnswer(
    ReviewCard card,
    String pattern,
  ) async =>
      const ReviewTypedAnswerPrompt(
        pattern: 'Front',
        fieldName: 'Front',
        expected: 'Paris',
        combining: true,
        fontName: 'Arial',
        fontSize: 24,
      );

  @override
  Future<String> compareTypedAnswer({
    required String expected,
    required String provided,
    required bool combining,
  }) async {
    lastExpected = expected;
    lastProvided = provided;
    lastCombining = combining;
    return '<code id=typeans><span class=typeGood>Paris</span></code>';
  }
}

class _Renderer implements CardRenderRepository {
  _Renderer(this.question);

  final String question;

  @override
  Future<ReviewCardContent> render(int cardId) async => ReviewCardContent(
    questionHtml: question,
    answerHtml: 'Answer [[type:Front]]',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}
