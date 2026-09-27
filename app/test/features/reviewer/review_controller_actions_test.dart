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
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('question entry autoplays question media and TTS in tag order', () async {
    final audio = _FakeAudioService();
    final tts = _FakeTtsService();
    final controller = _controller(
      settings: _settings(autoplay: true),
      content: _content(),
      audio: audio,
      tts: tts,
    );

    await controller.start(42);

    expect(tts.materializedTexts, ['question tts']);
    expect(audio.queues, [
      [
        Uri.parse('http://media.local/q.mp3'),
        Uri.parse('file:///tts/question.wav'),
      ],
    ]);
  });

  test('autoplay disabled does not play question or answer audio', () async {
    final audio = _FakeAudioService();
    final tts = _FakeTtsService();
    final controller = _controller(
      settings: _settings(autoplay: false),
      content: _content(),
      audio: audio,
      tts: tts,
    );

    await controller.start(42);
    await controller.showAnswer();

    expect(tts.materializedTexts, isEmpty);
    expect(audio.queues, isEmpty);
  });

  test('answer entry plays answer tags only when replay-question is skipped', () async {
    final audio = _FakeAudioService();
    final controller = _controller(
      settings: _settings(
        autoplay: true,
        skipQuestionWhenReplayingAnswer: true,
      ),
      content: _content(),
      audio: audio,
      tts: _FakeTtsService(),
    );

    await controller.start(42);
    audio.queues.clear();
    await controller.showAnswer();

    expect(audio.queues, [
      [Uri.parse('http://media.local/a.mp3')],
    ]);
  });

  test('answer entry prepends question tags when official replay setting requires it', () async {
    final audio = _FakeAudioService();
    final tts = _FakeTtsService();
    final controller = _controller(
      settings: _settings(
        autoplay: true,
        skipQuestionWhenReplayingAnswer: false,
      ),
      content: _content(),
      audio: audio,
      tts: tts,
    );

    await controller.start(42);
    audio.queues.clear();
    tts.materializedTexts.clear();
    await controller.showAnswer();

    expect(tts.materializedTexts, ['question tts']);
    expect(audio.queues, [
      [
        Uri.parse('http://media.local/q.mp3'),
        Uri.parse('file:///tts/question.wav'),
        Uri.parse('http://media.local/a.mp3'),
      ],
    ]);
  });

  test('enabling auto advance schedules current question and reveals on timeout', () async {
    final timers = _FakeTimerFactory();
    final controller = _controller(
      settings: _settings(
        autoplay: false,
        secondsToShowQuestion: 2.5,
        secondsToShowAnswer: 4,
      ),
      content: _content(),
      audio: _FakeAudioService(),
      tts: _FakeTtsService(),
      timerFactory: timers.call,
    );

    await controller.start(42);
    expect(timers.timers, isEmpty);

    await controller.toggleAutoAdvance();

    expect(timers.timers, hasLength(1));
    expect(timers.timers.single.delay, const Duration(milliseconds: 2500));

    await timers.timers.single.fire();

    expect(controller.state, isA<ReviewAnswer>());
    expect(timers.timers, hasLength(2));
    expect(timers.timers.last.delay, const Duration(seconds: 4));
  });

  test('answer timeout applies configured answer action through scheduler', () async {
    final timers = _FakeTimerFactory();
    final repository = _Repository(
      _settings(
        autoplay: false,
        secondsToShowAnswer: 3,
        answerAction: ReviewAnswerAction.answerGood,
      ),
    );
    final controller = _controller(
      repository: repository,
      settings: repository.settings,
      content: _content(),
      audio: _FakeAudioService(),
      tts: _FakeTtsService(),
      timerFactory: timers.call,
    );

    await controller.start(42);
    await controller.toggleAutoAdvance();
    await controller.showAnswer();

    expect(timers.timers, hasLength(1));
    expect(timers.timers.single.delay, const Duration(seconds: 3));

    await timers.timers.single.fire();

    expect(repository.answerRatings, [ReviewRating.good]);
    expect(controller.state, isA<ReviewFinished>());
  });

  test('wait for audio defers expired answer action until playback becomes idle once', () async {
    final timers = _FakeTimerFactory();
    final audio = _FakeAudioService()..setPlaying(true);
    final repository = _Repository(
      _settings(
        autoplay: false,
        secondsToShowAnswer: 1,
        waitForAudio: true,
        answerAction: ReviewAnswerAction.answerGood,
      ),
    );
    final controller = _controller(
      repository: repository,
      settings: repository.settings,
      content: _content(),
      audio: audio,
      tts: _FakeTtsService(),
      timerFactory: timers.call,
    );

    await controller.start(42);
    await controller.toggleAutoAdvance();
    await controller.showAnswer();
    await timers.timers.single.fire();

    expect(repository.answerRatings, isEmpty);
    expect(controller.state, isA<ReviewAnswer>());

    audio.setPlaying(false);
    await _flushMicrotasks();

    expect(repository.answerRatings, [ReviewRating.good]);
    expect(controller.state, isA<ReviewFinished>());

    audio.setPlaying(false);
    await _flushMicrotasks();
    expect(repository.answerRatings, [ReviewRating.good]);
  });

  test('disabling auto advance cancels pending timeout action', () async {
    final timers = _FakeTimerFactory();
    final controller = _controller(
      settings: _settings(
        autoplay: false,
        secondsToShowQuestion: 5,
      ),
      content: _content(),
      audio: _FakeAudioService(),
      tts: _FakeTtsService(),
      timerFactory: timers.call,
    );

    await controller.start(42);
    await controller.toggleAutoAdvance();
    final pending = timers.timers.single;

    await controller.toggleAutoAdvance();

    expect(pending.cancelled, isTrue);
    await pending.fire();
    expect(controller.state, isA<ReviewQuestion>());
  });
}

Future<void> _flushMicrotasks() => Future<void>.delayed(Duration.zero);

ReviewController _controller({
  _Repository? repository,
  required ReviewDeckSettings settings,
  required ReviewCardContent content,
  required ReviewAudioService audio,
  required ReviewTtsService tts,
  ReviewTimerFactory? timerFactory,
}) {
  return ReviewController(
    repository: repository ?? _Repository(settings),
    renderer: _Renderer(content),
    wallClockMillis: () => 0,
    stopwatchFactory: Stopwatch.new,
    audio: audio,
    tts: tts,
    mediaUriFor: (filename) => Uri.parse('http://media.local/$filename'),
    timerFactory: timerFactory,
  );
}

ReviewDeckSettings _settings({
  required bool autoplay,
  bool skipQuestionWhenReplayingAnswer = false,
  double secondsToShowQuestion = 0,
  double secondsToShowAnswer = 0,
  bool waitForAudio = false,
  ReviewQuestionAction questionAction = ReviewQuestionAction.showAnswer,
  ReviewAnswerAction answerAction = ReviewAnswerAction.answerGood,
}) {
  return ReviewDeckSettings(
    autoplay: autoplay,
    showTimer: false,
    stopTimerOnAnswer: false,
    answerTimeLimitSeconds: 60,
    secondsToShowQuestion: secondsToShowQuestion,
    secondsToShowAnswer: secondsToShowAnswer,
    waitForAudio: waitForAudio,
    skipQuestionWhenReplayingAnswer: skipQuestionWhenReplayingAnswer,
    questionAction: questionAction,
    answerAction: answerAction,
  );
}

ReviewCardContent _content() {
  return ReviewCardContent(
    questionHtml: 'question',
    answerHtml: 'answer',
    css: '',
    questionAudio: [
      const ReviewMediaTag('q.mp3'),
      ReviewTtsTag(
        text: 'question tts',
        language: 'en-US',
        voices: const ['Voice'],
        speed: 1,
        otherArgs: const [],
      ),
    ],
    answerAudio: const [ReviewMediaTag('a.mp3')],
  );
}

ReviewCard _card() {
  return ReviewCard(
    cardId: 1001,
    noteId: 2001,
    deckId: 42,
    counts: const ReviewCounts(newCount: 1, learningCount: 0, reviewCount: 0),
    currentStateBytes: Uint8List(0),
    choices: const [],
    deckName: 'Deck',
  );
}

class _Repository implements ReviewRepository {
  _Repository(this.settings);

  final ReviewDeckSettings settings;
  final List<ReviewRating> answerRatings = [];
  var served = false;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (served) {
      return null;
    }
    served = true;
    return _card();
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async => settings;

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {
    answerRatings.add(rating);
  }

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
  _Renderer(this.content);

  final ReviewCardContent content;

  @override
  Future<ReviewCardContent> render(int cardId) async => content;
}

class _FakeAudioService implements ReviewAudioService {
  final List<List<Uri>> queues = [];
  final StreamController<bool> _playingController =
      StreamController<bool>.broadcast();
  bool _playing = false;

  @override
  bool get isPlaying => _playing;

  @override
  Stream<bool> get playingChanges => _playingController.stream;

  void setPlaying(bool value) {
    _playing = value;
    _playingController.add(value);
  }

  @override
  Future<void> playQueue(List<Uri> items) async {
    queues.add(List<Uri>.of(items));
  }

  @override
  Future<void> replay() async {}

  @override
  Future<void> togglePause() async {}

  @override
  Future<void> seekRelative(Duration delta) async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {
    await _playingController.close();
  }
}

class _FakeTtsService implements ReviewTtsService {
  final List<String> materializedTexts = [];

  @override
  Future<Uri?> materialize(ReviewTtsTag tag) async {
    materializedTexts.add(tag.text);
    if (tag.text == 'question tts') {
      return Uri.parse('file:///tts/question.wav');
    }
    return null;
  }

  @override
  Future<void> dispose() async {}
}

class _FakeTimerFactory {
  final List<_FakeReviewTimer> timers = [];

  ReviewTimerHandle call(
    Duration delay,
    Future<void> Function() callback,
  ) {
    final timer = _FakeReviewTimer(delay, callback);
    timers.add(timer);
    return timer;
  }
}

class _FakeReviewTimer implements ReviewTimerHandle {
  _FakeReviewTimer(this.delay, this._callback);

  final Duration delay;
  final Future<void> Function() _callback;
  bool cancelled = false;

  @override
  bool get isActive => !cancelled;

  @override
  void cancel() {
    cancelled = true;
  }

  Future<void> fire() async {
    if (!cancelled) {
      await _callback();
    }
  }
}
