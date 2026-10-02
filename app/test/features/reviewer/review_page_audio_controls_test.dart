import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';
import 'package:anki_flutter/features/reviewer/audio/review_tts_service.dart';
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
  testWidgets('review actions expose manual audio replay pause and seeking', (
    tester,
  ) async {
    final audio = _Audio();
    final controller = ReviewController(
      repository: _Repository(),
      renderer: _Renderer(),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
      audio: audio,
      tts: _Tts(),
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

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();

    expect(find.text('Replay audio'), findsOneWidget);
    expect(find.text('Play / pause audio'), findsOneWidget);
    expect(find.text('Back 5 seconds'), findsOneWidget);
    expect(find.text('Forward 5 seconds'), findsOneWidget);

    await tester.tap(find.text('Replay audio'));
    await tester.pumpAndSettle();
    expect(audio.queues, [
      [
        Uri.parse('http://media.local/question.mp3'),
        Uri.parse('file:///tts/question.wav'),
      ],
    ]);

    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back 5 seconds'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forward 5 seconds'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Play / pause audio'));
    await tester.pumpAndSettle();

    expect(audio.seeks, const [Duration(seconds: -5), Duration(seconds: 5)]);
    expect(audio.togglePauseCalls, 1);
  });
}

class _Repository implements ReviewRepository {
  var served = false;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (served) return null;
    served = true;
    return ReviewCard(
      cardId: 1,
      noteId: 2,
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
    questionHtml: 'Question',
    answerHtml: 'Answer',
    css: '',
    questionAudio: [
      const ReviewMediaTag('question.mp3'),
      ReviewTtsTag(
        text: 'question tts',
        language: 'en-US',
        voices: const ['Voice'],
        speed: 1,
        otherArgs: const [],
      ),
    ],
    answerAudio: const [ReviewMediaTag('answer.mp3')],
  );
}

class _Audio implements ReviewAudioService {
  final queues = <List<Uri>>[];
  final seeks = <Duration>[];
  final _playing = StreamController<bool>.broadcast();
  int togglePauseCalls = 0;

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

class _Tts implements ReviewTtsService {
  @override
  Future<Uri?> materialize(ReviewTtsTag tag) async =>
      Uri.parse('file:///tts/question.wav');

  @override
  Future<void> dispose() async {}
}
