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
  test('burying the current card advances to the next scheduler card', () async {
    final repository = _Repository([_card(1), _card(2)]);
    final controller = _controller(repository);
    await controller.start(7);

    await controller.buryCurrentCard();

    expect(repository.buriedCardIds, [1]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('suspending the current note advances to the next scheduler card', () async {
    final repository = _Repository([_card(1), _card(2)]);
    final controller = _controller(repository);
    await controller.start(7);

    await controller.suspendCurrentNote();

    expect(repository.suspendedNoteIds, [101]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('undo asks Anki to undo then reloads the scheduler queue', () async {
    final repository = _Repository([_card(1), _card(2)]);
    final controller = _controller(repository);
    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.good);
    expect((controller.state as ReviewQuestion).card.cardId, 2);

    await controller.undo();

    expect(repository.undoCalls, 1);
    expect((controller.state as ReviewQuestion).card.cardId, 1);
  });

  test('canUndo and auto advance state are exposed for the reviewer UI', () async {
    final repository = _Repository([_card(1)])..undoAvailable = true;
    final controller = _controller(repository);
    await controller.start(7);

    expect(await controller.canUndo(), isTrue);
    expect(controller.autoAdvanceEnabled, isFalse);

    await controller.toggleAutoAdvance();
    expect(controller.autoAdvanceEnabled, isTrue);

    await controller.toggleAutoAdvance();
    expect(controller.autoAdvanceEnabled, isFalse);
  });
}

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
  Future<ReviewCardContent> render(int cardId) async => const ReviewCardContent(
    questionHtml: 'Question',
    answerHtml: 'Answer',
    css: '',
    questionAudio: [],
    answerAudio: [],
  );
}

class _Repository implements ReviewRepository {
  _Repository(this.cards);

  final List<ReviewCard> cards;
  int nextIndex = 0;
  int undoCalls = 0;
  bool undoAvailable = true;
  final buriedCardIds = <int>[];
  final buriedNoteIds = <int>[];
  final suspendedCardIds = <int>[];
  final suspendedNoteIds = <int>[];

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (nextIndex >= cards.length) return null;
    return cards[nextIndex++];
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
  Future<bool> canUndo() async => undoAvailable;

  @override
  Future<void> undo() async {
    undoCalls++;
    nextIndex = 0;
  }

  @override
  Future<void> buryCard(ReviewCard card) async {
    buriedCardIds.add(card.cardId);
  }

  @override
  Future<void> buryNote(ReviewCard card) async {
    buriedNoteIds.add(card.noteId);
  }

  @override
  Future<void> suspendCard(ReviewCard card) async {
    suspendedCardIds.add(card.cardId);
  }

  @override
  Future<void> suspendNote(ReviewCard card) async {
    suspendedNoteIds.add(card.noteId);
  }
}
