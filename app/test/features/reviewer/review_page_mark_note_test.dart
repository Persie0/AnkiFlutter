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
  testWidgets('asterisk toggles marked note and shows marked indicator', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(4);
    await tester.pumpWidget(_app(controller));
    await tester.pumpAndSettle();

    expect(controller.currentMarked, isFalse);
    expect(find.byIcon(Icons.star), findsNothing);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit8);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.pumpAndSettle();

    expect(repository.markWrites, [true]);
    expect(controller.currentMarked, isTrue);
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('review action menu exposes Mark note and Unmark note', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(4);
    await tester.pumpWidget(_app(controller));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Mark note'), findsOneWidget);

    await tester.tap(find.text('Mark note'));
    await tester.pumpAndSettle();
    expect(controller.currentMarked, isTrue);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Unmark note'), findsOneWidget);
  });
}

Widget _app(ReviewController controller) => MaterialApp(
  home: ReviewPage(
    controller: controller,
    onFinished: () {},
    cardSurfaceBuilder: (_, _) => const Text('Fake surface'),
  ),
);

ReviewController _controller(_Repository repository) => ReviewController(
  repository: repository,
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
);

class _Repository implements ReviewRepository, ReviewMarkRepository {
  bool _returned = false;
  bool marked = false;
  final List<bool> markWrites = [];

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (_returned) return null;
    _returned = true;
    return _card();
  }

  @override
  Future<bool> isMarked(ReviewCard card) async => marked;

  @override
  Future<void> setMarked(ReviewCard card, bool value) async {
    markWrites.add(value);
    marked = value;
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
