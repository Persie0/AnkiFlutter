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
  testWidgets('Edit note action uses current note ID and refreshes saved edits', (
    tester,
  ) async {
    final renderer = _Renderer('Old question');
    final controller = ReviewController(
      repository: _Repository(),
      renderer: renderer,
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    await controller.start(7);
    final editedNoteIds = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          onEditNote: (noteId) async {
            editedNoteIds.add(noteId);
            renderer.question = 'Updated question';
            return true;
          },
          cardSurfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );

    expect(find.textContaining('Old question'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyE);
    await tester.pumpAndSettle();

    expect(editedNoteIds, [101]);
    expect(find.textContaining('Updated question'), findsOneWidget);

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    expect(find.text('Edit note'), findsOneWidget);
  });

  testWidgets('cancelled edit does not rerender the current card', (tester) async {
    final renderer = _Renderer('Original question');
    final controller = ReviewController(
      repository: _Repository(),
      renderer: renderer,
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    await controller.start(7);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          onEditNote: (_) async => false,
          cardSurfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.keyE);
    await tester.pumpAndSettle();

    expect(renderer.calls, [1]);
    expect(find.textContaining('Original question'), findsOneWidget);
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

class _Renderer implements CardRenderRepository {
  _Renderer(this.question);

  String question;
  final calls = <int>[];

  @override
  Future<ReviewCardContent> render(int cardId) async {
    calls.add(cardId);
    return ReviewCardContent(
      questionHtml: question,
      answerHtml: 'Answer',
      css: '',
      questionAudio: const [],
      answerAudio: const [],
    );
  }
}
