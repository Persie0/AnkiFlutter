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
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('filtered card loads reviewer settings from original current deck', () async {
    final card = ReviewCard(
      cardId: 101,
      noteId: 202,
      deckId: 999,
      originalDeckId: 303,
      counts: const ReviewCounts(
        newCount: 0,
        learningCount: 0,
        reviewCount: 1,
      ),
      currentStateBytes: Uint8List(0),
      choices: const [],
      deckName: 'Filtered',
    );
    final repository = _Repository(card);
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 0,
      stopwatchFactory: Stopwatch.new,
    );

    await controller.start(999);

    expect(repository.settingsDecks, [303]);
  });
}

const _settings = ReviewDeckSettings(
  autoplay: true,
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

class _Repository implements ReviewRepository {
  _Repository(this.card);

  final ReviewCard card;
  final List<int> settingsDecks = [];
  var _served = false;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (_served) {
      return null;
    }
    _served = true;
    return card;
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async {
    settingsDecks.add(deckId);
    return _settings;
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
  Future<ReviewCardContent> render(int cardId) async {
    return ReviewCardContent(
      questionHtml: 'q',
      answerHtml: 'a',
      css: '',
      questionAudio: const [],
      answerAudio: const [],
    );
  }
}
