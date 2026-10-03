import 'dart:async';
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
  test('start loads current note marked state from Anki', () async {
    final repository = _Repository([_card(1)])
      ..markedByNote[101] = true;
    final controller = _controller(repository);

    await controller.start(7);

    expect(controller.supportsMarking, isTrue);
    expect(controller.currentMarked, isTrue);
    expect(repository.markReads, [101]);
  });

  test('toggleCurrentMarked persists and updates current note state', () async {
    final repository = _Repository([_card(1)]);
    final controller = _controller(repository);
    await controller.start(7);

    expect(controller.currentMarked, isFalse);

    await controller.toggleCurrentMarked();
    expect(controller.currentMarked, isTrue);
    expect(repository.markWrites, [(101, true)]);

    await controller.toggleCurrentMarked();
    expect(controller.currentMarked, isFalse);
    expect(repository.markWrites, [(101, true), (101, false)]);
  });

  test('failed mark mutation leaves local marked state unchanged', () async {
    final repository = _Repository([_card(1)])..failMarkWrite = true;
    final controller = _controller(repository);
    await controller.start(7);

    await expectLater(controller.toggleCurrentMarked(), throwsStateError);

    expect(controller.currentMarked, isFalse);
  });

  test('stale mark completion cannot change the next card state', () async {
    final repository = _Repository([_card(1), _card(2)]);
    final controller = _controller(repository);
    await controller.start(7);

    final pending = Completer<void>();
    repository.pendingMarkWrite = pending;
    final toggle = controller.toggleCurrentMarked();

    await controller.buryCurrentCard();
    expect((controller.state as ReviewQuestion).card.cardId, 2);
    expect(controller.currentMarked, isFalse);

    pending.complete();
    await toggle;

    expect((controller.state as ReviewQuestion).card.cardId, 2);
    expect(controller.currentMarked, isFalse);
  });

  test('refreshCurrentCard reloads marked state after note tag edits', () async {
    final repository = _Repository([_card(1)]);
    final controller = _controller(repository);
    await controller.start(7);
    expect(controller.currentMarked, isFalse);

    repository.markedByNote[101] = true;
    await controller.refreshCurrentCard();

    expect(controller.currentMarked, isTrue);
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
  Future<ReviewCardContent> render(int cardId) async => ReviewCardContent(
    questionHtml: 'Question $cardId',
    answerHtml: 'Answer $cardId',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}

class _Repository implements ReviewRepository, ReviewMarkRepository {
  _Repository(this.cards);

  final List<ReviewCard> cards;
  final Map<int, bool> markedByNote = {};
  final List<int> markReads = [];
  final List<(int, bool)> markWrites = [];
  int nextIndex = 0;
  bool failMarkWrite = false;
  Completer<void>? pendingMarkWrite;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (nextIndex >= cards.length) return null;
    return cards[nextIndex++];
  }

  @override
  Future<bool> isMarked(ReviewCard card) async {
    markReads.add(card.noteId);
    return markedByNote[card.noteId] ?? false;
  }

  @override
  Future<void> setMarked(ReviewCard card, bool marked) async {
    markWrites.add((card.noteId, marked));
    if (failMarkWrite) throw StateError('mark failed');
    final pending = pendingMarkWrite;
    if (pending != null) {
      await pending.future;
      pendingMarkWrite = null;
    }
    markedByNote[card.noteId] = marked;
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
