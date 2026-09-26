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
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('start selects deck loads one card and enters question state', () async {
    final card = _card();
    final content = ReviewCardContent(
      questionHtml: '<div>question</div>',
      answerHtml: '<div>answer</div>',
      css: '.card { font-size: 20px; }',
      questionAudio: const [],
      answerAudio: const [],
    );
    const settings = ReviewDeckSettings(
      autoplay: true,
      showTimer: true,
      stopTimerOnAnswer: false,
      answerTimeLimitSeconds: 60,
      secondsToShowQuestion: 0,
      secondsToShowAnswer: 0,
      waitForAudio: true,
      skipQuestionWhenReplayingAnswer: false,
      questionAction: ReviewQuestionAction.showAnswer,
      answerAction: ReviewAnswerAction.answerGood,
    );
    final repository = _FakeReviewRepository(
      nextCards: [card],
      settings: settings,
    );
    final renderer = _FakeCardRenderRepository(content);
    var stopwatchFactoryCalls = 0;
    final controller = ReviewController(
      repository: repository,
      renderer: renderer,
      wallClockMillis: () => 123456789,
      stopwatchFactory: () {
        stopwatchFactoryCalls += 1;
        return Stopwatch();
      },
    );

    await controller.start(42);

    expect(repository.selectedDecks, [42]);
    expect(repository.nextCardCalls, 1);
    expect(repository.settingsDecks, [card.deckId]);
    expect(renderer.renderedCardIds, [card.cardId]);
    expect(stopwatchFactoryCalls, 1);

    final state = controller.state;
    expect(state, isA<ReviewQuestion>());
    final question = state as ReviewQuestion;
    expect(question.card, same(card));
    expect(question.content, same(content));
    expect(question.settings, same(settings));
    expect(question.generationId, greaterThan(0));
  });

  test('start enters finished state when Anki queue is empty', () async {
    const settings = ReviewDeckSettings(
      autoplay: true,
      showTimer: true,
      stopTimerOnAnswer: false,
      answerTimeLimitSeconds: 60,
      secondsToShowQuestion: 0,
      secondsToShowAnswer: 0,
      waitForAudio: true,
      skipQuestionWhenReplayingAnswer: false,
      questionAction: ReviewQuestionAction.showAnswer,
      answerAction: ReviewAnswerAction.answerGood,
    );
    final repository = _FakeReviewRepository(
      nextCards: [null],
      settings: settings,
    );
    final renderer = _FakeCardRenderRepository(
      ReviewCardContent(
        questionHtml: '<div>unused</div>',
        answerHtml: '<div>unused</div>',
        css: '',
        questionAudio: const [],
        answerAudio: const [],
      ),
    );
    var stopwatchFactoryCalls = 0;
    final controller = ReviewController(
      repository: repository,
      renderer: renderer,
      wallClockMillis: () => 123456789,
      stopwatchFactory: () {
        stopwatchFactoryCalls += 1;
        return Stopwatch();
      },
    );

    await controller.start(42);

    expect(controller.state, isA<ReviewFinished>());
    expect(repository.selectedDecks, [42]);
    expect(repository.nextCardCalls, 1);
    expect(repository.settingsDecks, isEmpty);
    expect(renderer.renderedCardIds, isEmpty);
    expect(stopwatchFactoryCalls, 0);
  });
}

ReviewCard _card() {
  return ReviewCard(
    cardId: 1001,
    noteId: 2001,
    deckId: 42,
    counts: const ReviewCounts(
      newCount: 3,
      learningCount: 2,
      reviewCount: 7,
    ),
    currentStateBytes: Uint8List.fromList([1, 2, 3]),
    choices: [
      ReviewAnswerChoice(
        rating: ReviewRating.again,
        intervalLabel: '<1m',
        schedulingStateBytes: Uint8List.fromList([4]),
      ),
      ReviewAnswerChoice(
        rating: ReviewRating.hard,
        intervalLabel: '6m',
        schedulingStateBytes: Uint8List.fromList([5]),
      ),
      ReviewAnswerChoice(
        rating: ReviewRating.good,
        intervalLabel: '10m',
        schedulingStateBytes: Uint8List.fromList([6]),
      ),
      ReviewAnswerChoice(
        rating: ReviewRating.easy,
        intervalLabel: '4d',
        schedulingStateBytes: Uint8List.fromList([7]),
      ),
    ],
    deckName: 'Deck',
  );
}

class _FakeReviewRepository implements ReviewRepository {
  _FakeReviewRepository({
    required List<ReviewCard?> nextCards,
    required this.settings,
  }) : _nextCards = List<ReviewCard?>.of(nextCards);

  final List<ReviewCard?> _nextCards;
  final ReviewDeckSettings settings;
  final List<int> selectedDecks = [];
  final List<int> settingsDecks = [];
  int nextCardCalls = 0;

  @override
  Future<void> selectDeck(int deckId) async {
    selectedDecks.add(deckId);
  }

  @override
  Future<ReviewCard?> nextCard() async {
    nextCardCalls += 1;
    return _nextCards.removeAt(0);
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async {
    settingsDecks.add(deckId);
    return settings;
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
}

class _FakeCardRenderRepository implements CardRenderRepository {
  _FakeCardRenderRepository(this.content);

  final ReviewCardContent content;
  final List<int> renderedCardIds = [];

  @override
  Future<ReviewCardContent> render(int cardId) async {
    renderedCardIds.add(cardId);
    return content;
  }
}
