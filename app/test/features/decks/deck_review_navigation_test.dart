import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Study starts the reviewer for the selected deck', (
    tester,
  ) async {
    final repository = _ReviewRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: DeckOverviewPage(
          deck: const DeckNode(
            id: 42,
            name: 'Norwegian',
            newCount: 1,
            learnCount: 0,
            reviewCount: 0,
            filtered: false,
            children: [],
          ),
          reviewControllerBuilder: () => ReviewController(
            repository: repository,
            renderer: _Renderer(),
            wallClockMillis: () => 0,
            stopwatchFactory: Stopwatch.new,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();

    expect(repository.selectedDecks, [42]);
    expect(find.textContaining('queue not ready'), findsOneWidget);
  });
}

class _ReviewRepository implements ReviewRepository {
  final selectedDecks = <int>[];

  @override
  Future<void> selectDeck(int deckId) async => selectedDecks.add(deckId);

  @override
  Future<ReviewCard?> nextCard() async => throw StateError('queue not ready');

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
    questionHtml: '',
    answerHtml: '',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}
