import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';
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
  testWidgets('desktop reviewer shortcuts drive existing review actions', (
    tester,
  ) async {
    final repository = _Repository();
    final audio = _Audio();
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
      audio: audio,
      mediaUriFor: (filename) => Uri.parse('http://media.local/$filename'),
    );
    await controller.start(7);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Card'),
        ),
      ),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.keyR);
    await tester.pump();
    expect(audio.queues.single, [Uri.parse('http://media.local/q.mp3')]);

    await tester.sendKeyEvent(LogicalKeyboardKey.digit5);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit6);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit7);
    await tester.pump();
    expect(audio.togglePauseCalls, 1);
    expect(audio.seeks, const [Duration(seconds: -5), Duration(seconds: 5)]);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyA);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.pump();
    expect(controller.autoAdvanceEnabled, isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.minus);
    await tester.pumpAndSettle();
    expect(repository.buriedCardIds, [1]);
    expect(find.text('Second'), findsOneWidget);
  });

  testWidgets('undo bury-note and suspend shortcuts are wired', (tester) async {
    final repository = _Repository();
    final controller = ReviewController(
      repository: repository,
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
    );
    await controller.start(7);

    await tester.pumpWidget(
      MaterialApp(
        home: ReviewPage(
          controller: controller,
          onFinished: () {},
          cardSurfaceBuilder: (_, _) => const Text('Card'),
        ),
      ),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.equal);
    await tester.pumpAndSettle();
    expect(repository.buriedNoteIds, [101]);

    repository.rewindToFirst();
    await controller.start(7);
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit1);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.pumpAndSettle();
    expect(repository.suspendedNoteIds, [101]);

    repository.rewindToFirst();
    await controller.start(7);
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit2);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.pumpAndSettle();
    expect(repository.suspendedCardIds, [1]);

    repository.rewindToFirst();
    await controller.start(7);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.keyU);
    await tester.pumpAndSettle();
    expect(repository.undoCalls, 1);
  });
}

class _Repository implements ReviewRepository {
  final cards = <ReviewCard>[_card(1, 'First'), _card(2, 'Second')];
  final buriedCardIds = <int>[];
  final buriedNoteIds = <int>[];
  final suspendedCardIds = <int>[];
  final suspendedNoteIds = <int>[];
  var undoCalls = 0;
  var index = 0;

  void rewindToFirst() => index = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (index >= cards.length) return null;
    return cards[index++];
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
  Future<bool> canUndo() async => true;

  @override
  Future<void> undo() async {
    undoCalls++;
    index = 0;
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

ReviewCard _card(int id, String name) => ReviewCard(
  cardId: id,
  noteId: id + 100,
  deckId: 7,
  deckName: name,
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
    questionHtml: 'Question',
    answerHtml: 'Answer',
    css: '',
    questionAudio: const [ReviewMediaTag('q.mp3')],
    answerAudio: const [],
  );
}

class _Audio implements ReviewAudioService {
  final queues = <List<Uri>>[];
  final seeks = <Duration>[];
  final _playing = StreamController<bool>.broadcast();
  var togglePauseCalls = 0;

  @override
  bool get isPlaying => false;

  @override
  Stream<bool> get playingChanges => _playing.stream;

  @override
  Future<void> playQueue(List<Uri> items) async {
    queues.add(List.of(items));
  }

  @override
  Future<void> replay() async {}

  @override
  Future<void> togglePause() async {
    togglePauseCalls++;
  }

  @override
  Future<void> seekRelative(Duration delta) async {
    seeks.add(delta);
  }

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {
    await _playing.close();
  }
}
