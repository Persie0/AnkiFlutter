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
  test('answer advances before probing leech state', () async {
    final repository = _Repository(
      cards: [_card(1), _card(2)],
      leech: false,
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.showAnswer();
    repository.events.clear();

    await controller.rate(ReviewRating.good);

    expect(repository.events, ['answer', 'nextCard', 'stateIsLeech']);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('successful answer checks selected state and publishes suspended leech notice after advancing', () async {
    final first = _card(1);
    final second = _card(2);
    final repository = _Repository(
      cards: [first, second],
      leech: true,
      suspended: true,
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.good);

    expect(repository.leechChoices, hasLength(1));
    expect(repository.leechChoices.single.rating, ReviewRating.good);
    expect(repository.suspensionChecks, [first.cardId]);
    expect((controller.state as ReviewQuestion).card.cardId, second.cardId);
    expect(controller.leechNoticeVersion, 1);
    expect(
      controller.leechNotice,
      'Card was a leech. It has been suspended.',
    );
  });

  test('leech without auto-suspension publishes base notice', () async {
    final repository = _Repository(
      cards: [_card(1), _card(2)],
      leech: true,
      suspended: false,
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.again);

    expect(controller.leechNoticeVersion, 1);
    expect(controller.leechNotice, 'Card was a leech.');
  });

  test('non-leech answer advances without notice or suspension lookup', () async {
    final repository = _Repository(
      cards: [_card(1), _card(2)],
      leech: false,
      suspended: true,
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.easy);

    expect((controller.state as ReviewQuestion).card.cardId, 2);
    expect(repository.suspensionChecks, isEmpty);
    expect(controller.leechNoticeVersion, 0);
    expect(controller.leechNotice, isNull);
  });

  test('leech-state probe failure never turns a successful answer into a failure', () async {
    final repository = _Repository(
      cards: [_card(1), _card(2)],
      leechError: StateError('state probe failed'),
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.good);

    expect((controller.state as ReviewQuestion).card.cardId, 2);
    expect(controller.leechNotice, isNull);
  });

  test('suspension probe failure still reports the leech and advances', () async {
    final repository = _Repository(
      cards: [_card(1), _card(2)],
      leech: true,
      suspensionError: StateError('card reload failed'),
    );
    final controller = _controller(repository);
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.showAnswer();
    await controller.rate(ReviewRating.good);

    expect((controller.state as ReviewQuestion).card.cardId, 2);
    expect(controller.leechNotice, 'Card was a leech.');
  });
}

ReviewController _controller(_Repository repository) => ReviewController(
  repository: repository,
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
);

class _Repository implements ReviewRepository, ReviewLeechRepository {
  _Repository({
    required List<ReviewCard> cards,
    this.leech = false,
    this.suspended = false,
    this.leechError,
    this.suspensionError,
  }) : _cards = List<ReviewCard>.of(cards);

  final List<ReviewCard> _cards;
  final bool leech;
  final bool suspended;
  final Object? leechError;
  final Object? suspensionError;
  final List<ReviewAnswerChoice> leechChoices = [];
  final List<int> suspensionChecks = [];
  final List<String> events = [];
  var index = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    events.add('nextCard');
    return index < _cards.length ? _cards[index++] : null;
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async => _settings;

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {
    events.add('answer');
  }

  @override
  Future<bool> stateIsLeech(ReviewAnswerChoice choice) async {
    events.add('stateIsLeech');
    leechChoices.add(choice);
    if (leechError != null) throw leechError!;
    return leech;
  }

  @override
  Future<bool> isCardSuspended(ReviewCard card) async {
    events.add('isCardSuspended');
    suspensionChecks.add(card.cardId);
    if (suspensionError != null) throw suspensionError!;
    return suspended;
  }

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
