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
  testWidgets('leech feedback is shown once after answer advances', (tester) async {
    final repository = _Repository();
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    addTearDown(controller.dispose);
    await controller.start(7);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );

    await controller.showAnswer();
    await tester.pump();
    await controller.rate(ReviewRating.good);
    await tester.pump();
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Card was a leech.'), findsOneWidget);

    controller.notifyListeners();
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Card was a leech.'), findsOneWidget);
  });
}

class _Repository implements ReviewRepository, ReviewLeechRepository {
  var index = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    index += 1;
    if (index > 2) return null;
    return _card(index);
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async => _settings;

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {}

  @override
  Future<bool> stateIsLeech(ReviewAnswerChoice choice) async => true;

  @override
  Future<bool> isCardSuspended(ReviewCard card) async => false;

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
    questionHtml: 'Question $cardId',
    answerHtml: 'Answer $cardId',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}

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

ReviewCard _card(int id) => ReviewCard(
  cardId: id,
  noteId: id + 100,
  deckId: 7,
  deckName: 'Deck',
  counts: const ReviewCounts(newCount: 0, learningCount: 0, reviewCount: 2),
  currentStateBytes: Uint8List.fromList([1]),
  choices: [
    for (final rating in ReviewRating.values)
      ReviewAnswerChoice(
        rating: rating,
        intervalLabel: '1d',
        schedulingStateBytes: Uint8List.fromList([rating.index + 2]),
      ),
  ],
);
