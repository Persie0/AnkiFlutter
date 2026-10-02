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
  test('refresh current card rerenders question without advancing queue', () async {
    final repository = _Repository();
    final renderer = _Renderer('Old question');
    final controller = _controller(repository, renderer);
    await controller.start(7);
    final before = controller.state as ReviewQuestion;

    renderer.question = 'Updated question';
    await controller.refreshCurrentCard();

    final after = controller.state as ReviewQuestion;
    expect(after.card, same(before.card));
    expect(after.content.questionHtml, 'Updated question');
    expect(after.generationId, before.generationId);
    expect(repository.nextCardCalls, 1);
    expect(renderer.calls, [1, 1]);
  });

  test('refresh current card preserves the answer side', () async {
    final repository = _Repository();
    final renderer = _Renderer('Old question');
    final controller = _controller(repository, renderer);
    await controller.start(7);
    await controller.showAnswer();
    final before = controller.state as ReviewAnswer;

    renderer.question = 'Updated question';
    await controller.refreshCurrentCard();

    final after = controller.state as ReviewAnswer;
    expect(after.card, same(before.card));
    expect(after.content.questionHtml, 'Updated question');
    expect(after.generationId, before.generationId);
    expect(repository.nextCardCalls, 1);
  });
}

ReviewController _controller(_Repository repository, _Renderer renderer) =>
    ReviewController(
      repository: repository,
      renderer: renderer,
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );

class _Repository implements ReviewRepository {
  var nextCardCalls = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    nextCardCalls++;
    if (nextCardCalls > 1) return null;
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
