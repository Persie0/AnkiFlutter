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
  test('refreshCurrentDeckSettings reloads settings without advancing', () async {
    final repository = _RefreshRepository(
      firstCard: _card(
        cardId: 1,
        deckId: 99,
        originalDeckId: 9,
        deckName: 'Filtered',
      ),
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(99);
    expect(repository.nextCardCalls, 1);
    expect(repository.settingsDecks, [9]);

    repository.nextSettings = _settings(showTimer: true);
    await controller.refreshCurrentDeckSettings();

    expect(repository.nextCardCalls, 1);
    expect(repository.settingsDecks, [9, 9]);
    final state = controller.state as ReviewQuestion;
    expect(state.card.cardId, 1);
    expect(state.settings.showTimer, isTrue);
  });

  test('stale settings refresh cannot overwrite a newer review session', () async {
    final staleRefresh = Completer<ReviewDeckSettings>();
    final repository = _RefreshRepository(
      firstCard: _card(
        cardId: 1,
        deckId: 99,
        originalDeckId: 9,
        deckName: 'Filtered',
      ),
      secondCard: _card(cardId: 2, deckId: 7, deckName: 'New Session'),
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(99);
    repository.delayedRefresh = staleRefresh;
    final refreshFuture = controller.refreshCurrentDeckSettings();
    await Future<void>.delayed(Duration.zero);

    repository.delayedRefresh = null;
    repository.nextSettings = _settings(showTimer: true);
    await controller.start(7);

    staleRefresh.complete(_settings(showTimer: false, answerTimeLimitSeconds: 1));
    await refreshFuture;

    final state = controller.state as ReviewQuestion;
    expect(state.card.cardId, 2);
    expect(state.settings.showTimer, isTrue);
    expect(state.settings.answerTimeLimitSeconds, 60);
    expect(repository.nextCardCalls, 2);
  });
}

ReviewController _controller(ReviewRepository repository) => ReviewController(
  repository: repository,
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
);

class _RefreshRepository implements ReviewRepository {
  _RefreshRepository({required this.firstCard, this.secondCard});

  final ReviewCard firstCard;
  final ReviewCard? secondCard;
  final settingsDecks = <int>[];
  var nextCardCalls = 0;
  var selectedDeckId = 0;
  ReviewDeckSettings nextSettings = _settings();
  Completer<ReviewDeckSettings>? delayedRefresh;

  @override
  Future<void> selectDeck(int deckId) async => selectedDeckId = deckId;

  @override
  Future<ReviewCard?> nextCard() async {
    nextCardCalls++;
    if (nextCardCalls == 1) return firstCard;
    if (nextCardCalls == 2) return secondCard;
    return null;
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async {
    settingsDecks.add(deckId);
    final delayed = delayedRefresh;
    if (delayed != null) return delayed.future;
    return nextSettings;
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

ReviewCard _card({
  required int cardId,
  required int deckId,
  required String deckName,
  int originalDeckId = 0,
}) => ReviewCard(
  cardId: cardId,
  noteId: cardId + 100,
  deckId: deckId,
  originalDeckId: originalDeckId,
  deckName: deckName,
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

ReviewDeckSettings _settings({
  bool showTimer = false,
  int answerTimeLimitSeconds = 60,
}) => ReviewDeckSettings(
  autoplay: false,
  showTimer: showTimer,
  stopTimerOnAnswer: false,
  answerTimeLimitSeconds: answerTimeLimitSeconds,
  secondsToShowQuestion: 0,
  secondsToShowAnswer: 0,
  waitForAudio: false,
  skipQuestionWhenReplayingAnswer: false,
  questionAction: ReviewQuestionAction.showAnswer,
  answerAction: ReviewAnswerAction.answerGood,
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
