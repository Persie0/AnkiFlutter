import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';
import 'package:anki_flutter/features/reviewer/audio/review_voice_recorder.dart';
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
  test('own voice capability requires recorder and audio service', () async {
    final unsupported = _controller();
    addTearDown(unsupported.dispose);
    expect(unsupported.canRecordOwnVoice, isFalse);
    expect(unsupported.hasRecordedOwnVoice, isFalse);
    expect(await unsupported.ownVoiceRecordingElapsed.toList(), isEmpty);

    final recorderOnly = _controller(voiceRecorder: _VoiceRecorder());
    addTearDown(recorderOnly.dispose);
    expect(recorderOnly.canRecordOwnVoice, isFalse);

    final supported = _controller(
      voiceRecorder: _VoiceRecorder(),
      audio: _Audio(),
    );
    addTearDown(supported.dispose);
    expect(supported.canRecordOwnVoice, isTrue);
  });

  test('begin stops audio before permission and recorder start', () async {
    final events = <String>[];
    final recorder = _VoiceRecorder(events: events);
    final audio = _Audio(events: events);
    final controller = _controller(voiceRecorder: recorder, audio: audio);
    addTearDown(controller.dispose);

    final result = await controller.beginOwnVoiceRecording();

    expect(result, ReviewOwnVoiceStartResult.started);
    expect(events, ['audio.stop', 'permission', 'start']);
    expect(recorder.startCalls, 1);
  });

  test('permission denial does not start recording', () async {
    final recorder = _VoiceRecorder(permission: false);
    final audio = _Audio();
    final controller = _controller(voiceRecorder: recorder, audio: audio);
    addTearDown(controller.dispose);

    final result = await controller.beginOwnVoiceRecording();

    expect(result, ReviewOwnVoiceStartResult.permissionDenied);
    expect(audio.stopCalls, 1);
    expect(recorder.startCalls, 0);
  });

  test('start failure cancels best-effort and rethrows', () async {
    final recorder = _VoiceRecorder(startError: StateError('start failed'));
    final controller = _controller(voiceRecorder: recorder, audio: _Audio());
    addTearDown(controller.dispose);

    await expectLater(controller.beginOwnVoiceRecording(), throwsStateError);

    expect(recorder.cancelCalls, 1);
    expect(controller.hasRecordedOwnVoice, isFalse);
  });

  test('recording elapsed stream forwards recorder values', () async {
    final recorder = _VoiceRecorder();
    final controller = _controller(voiceRecorder: recorder, audio: _Audio());
    addTearDown(controller.dispose);
    final values = <Duration>[];
    final subscription = controller.ownVoiceRecordingElapsed.listen(values.add);

    recorder.emitElapsed(const Duration(seconds: 2));
    await Future<void>.delayed(Duration.zero);

    expect(values, [const Duration(seconds: 2)]);
    await subscription.cancel();
  });

  test('successful stop adopts and immediately replays recording', () async {
    final voice = Uri.file('/tmp/voice-1.wav');
    final recorder = _VoiceRecorder(stopResults: [Future.value(voice)]);
    final audio = _Audio();
    final controller = _controller(voiceRecorder: recorder, audio: audio);
    addTearDown(controller.dispose);

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();

    expect(controller.hasRecordedOwnVoice, isTrue);
    expect(audio.oneShots, [voice]);
  });

  test('replay returns false before success and true afterwards', () async {
    final voice = Uri.file('/tmp/voice-1.wav');
    final recorder = _VoiceRecorder(stopResults: [Future.value(voice)]);
    final audio = _Audio();
    final controller = _controller(voiceRecorder: recorder, audio: audio);
    addTearDown(controller.dispose);

    expect(await controller.replayOwnVoice(), isFalse);
    expect(audio.oneShots, isEmpty);

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    audio.oneShots.clear();

    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots, [voice]);
  });

  test('successful replacement adopts new URI before deleting old URI', () async {
    final first = Uri.file('/tmp/voice-1.wav');
    final second = Uri.file('/tmp/voice-2.wav');
    final recorder = _VoiceRecorder(
      stopResults: [Future.value(first), Future.value(second)],
    );
    final audio = _Audio();
    final deleted = <Uri>[];
    final controller = _controller(
      voiceRecorder: recorder,
      audio: audio,
      deleter: (uri) async => deleted.add(uri),
    );
    addTearDown(controller.dispose);

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();

    expect(audio.oneShots, [first, second]);
    expect(deleted, [first]);
    audio.oneShots.clear();
    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots, [second]);
  });

  test('null finalization preserves previous successful recording', () async {
    final first = Uri.file('/tmp/voice-1.wav');
    final recorder = _VoiceRecorder(
      stopResults: [Future.value(first), Future<Uri?>.value(null)],
    );
    final audio = _Audio();
    final deleted = <Uri>[];
    final controller = _controller(
      voiceRecorder: recorder,
      audio: audio,
      deleter: (uri) async => deleted.add(uri),
    );
    addTearDown(controller.dispose);

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    await controller.beginOwnVoiceRecording();
    await expectLater(controller.stopOwnVoiceRecording(), throwsStateError);

    expect(deleted, isEmpty);
    audio.oneShots.clear();
    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots, [first]);
  });

  test('stop exception preserves previous successful recording', () async {
    final first = Uri.file('/tmp/voice-1.wav');
    final failingStop = Completer<Uri?>();
    final recorder = _VoiceRecorder(
      stopResults: [Future.value(first), failingStop.future],
    );
    final audio = _Audio();
    final controller = _controller(voiceRecorder: recorder, audio: audio);
    addTearDown(controller.dispose);

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    await controller.beginOwnVoiceRecording();
    final stop = controller.stopOwnVoiceRecording();
    failingStop.completeError(StateError('stop failed'));
    await expectLater(stop, throwsStateError);

    audio.oneShots.clear();
    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots, [first]);
  });

  test('playback failure keeps newly finalized recording for retry', () async {
    final voice = Uri.file('/tmp/voice-1.wav');
    final recorder = _VoiceRecorder(stopResults: [Future.value(voice)]);
    final audio = _Audio(oneShotError: StateError('playback failed'));
    final controller = _controller(voiceRecorder: recorder, audio: audio);
    addTearDown(controller.dispose);

    await controller.beginOwnVoiceRecording();
    await expectLater(controller.stopOwnVoiceRecording(), throwsStateError);

    expect(controller.hasRecordedOwnVoice, isTrue);
    audio.oneShotError = null;
    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots.last, voice);
  });

  test('cancel preserves previous successful recording', () async {
    final voice = Uri.file('/tmp/voice-1.wav');
    final recorder = _VoiceRecorder(stopResults: [Future.value(voice)]);
    final audio = _Audio();
    final controller = _controller(voiceRecorder: recorder, audio: audio);
    addTearDown(controller.dispose);

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    await controller.beginOwnVoiceRecording();
    await controller.cancelOwnVoiceRecording();

    expect(recorder.cancelCalls, 1);
    audio.oneShots.clear();
    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots, [voice]);
  });

  test('successful recording survives normal card transition', () async {
    final voice = Uri.file('/tmp/voice-1.wav');
    final recorder = _VoiceRecorder(stopResults: [Future.value(voice)]);
    final audio = _Audio();
    final repository = _Repository(cards: [_card(1), _card(2)]);
    final controller = _controller(
      repository: repository,
      voiceRecorder: recorder,
      audio: audio,
    );
    addTearDown(controller.dispose);

    await controller.start(7);
    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    await controller.showAnswer();
    await controller.rate(ReviewRating.good);

    audio.oneShots.clear();
    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots, [voice]);
  });

  test('dispose cancels active recording, deletes final file and disposes recorder', () async {
    final voice = Uri.file('/tmp/voice-1.wav');
    final recorder = _VoiceRecorder(stopResults: [Future.value(voice)]);
    final audio = _Audio();
    final deleted = <Uri>[];
    final controller = _controller(
      voiceRecorder: recorder,
      audio: audio,
      deleter: (uri) async => deleted.add(uri),
    );

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    await controller.beginOwnVoiceRecording();

    controller.dispose();
    await Future<void>.delayed(Duration.zero);

    expect(recorder.cancelCalls, 1);
    expect(recorder.disposeCalls, 1);
    expect(deleted, [voice]);
  });

  test('disposed permission completion cannot start recording', () async {
    final permission = Completer<bool>();
    final recorder = _VoiceRecorder(permissionFuture: permission.future);
    final controller = _controller(voiceRecorder: recorder, audio: _Audio());

    final begin = controller.beginOwnVoiceRecording();
    await Future<void>.delayed(Duration.zero);
    controller.dispose();
    permission.complete(true);
    await begin;
    await Future<void>.delayed(Duration.zero);

    expect(recorder.startCalls, 0);
  });

  test('late stop output after disposal is cleaned and not adopted', () async {
    final lateStop = Completer<Uri?>();
    final late = Uri.file('/tmp/late.wav');
    final recorder = _VoiceRecorder(stopResults: [lateStop.future]);
    final deleted = <Uri>[];
    final controller = _controller(
      voiceRecorder: recorder,
      audio: _Audio(),
      deleter: (uri) async => deleted.add(uri),
    );

    await controller.beginOwnVoiceRecording();
    final stop = controller.stopOwnVoiceRecording();
    await Future<void>.delayed(Duration.zero);
    controller.dispose();
    lateStop.complete(late);
    await stop;
    await Future<void>.delayed(Duration.zero);

    expect(controller.hasRecordedOwnVoice, isFalse);
    expect(deleted, [late]);
  });

  test('older stop completion cannot replace a newer successful recording', () async {
    final firstStop = Completer<Uri?>();
    final stale = Uri.file('/tmp/stale.wav');
    final latest = Uri.file('/tmp/latest.wav');
    final recorder = _VoiceRecorder(
      stopResults: [firstStop.future, Future.value(latest)],
    );
    final audio = _Audio();
    final deleted = <Uri>[];
    final controller = _controller(
      voiceRecorder: recorder,
      audio: audio,
      deleter: (uri) async => deleted.add(uri),
    );
    addTearDown(controller.dispose);

    await controller.beginOwnVoiceRecording();
    final oldStop = controller.stopOwnVoiceRecording();
    await Future<void>.delayed(Duration.zero);

    await controller.beginOwnVoiceRecording();
    await controller.stopOwnVoiceRecording();
    firstStop.complete(stale);
    await oldStop;

    audio.oneShots.clear();
    expect(await controller.replayOwnVoice(), isTrue);
    expect(audio.oneShots, [latest]);
    expect(deleted, contains(stale));
  });
}

ReviewController _controller({
  _Repository? repository,
  ReviewVoiceRecorder? voiceRecorder,
  ReviewAudioService? audio,
  Future<void> Function(Uri uri)? deleter,
}) {
  return ReviewController(
    repository: repository ?? _Repository(cards: [_card(1)]),
    renderer: _Renderer(),
    wallClockMillis: () => 100,
    stopwatchFactory: Stopwatch.new,
    voiceRecorder: voiceRecorder,
    audio: audio,
    ownVoiceFileDeleter: deleter,
  );
}

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

class _Repository implements ReviewRepository {
  _Repository({required List<ReviewCard> cards}) : _cards = List.of(cards);

  final List<ReviewCard> _cards;
  int index = 0;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (index >= _cards.length) return null;
    return _cards[index++];
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async => _settings;

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
    questionAudio: const [],
    answerAudio: const [],
  );
}

class _Audio implements ReviewAudioService {
  _Audio({this.events, this.oneShotError});

  final List<String>? events;
  final List<Uri> oneShots = [];
  Object? oneShotError;
  int stopCalls = 0;

  @override
  bool get isPlaying => false;

  @override
  Stream<bool> get playingChanges => const Stream<bool>.empty();

  @override
  Future<void> playQueue(List<Uri> items) async {}

  @override
  Future<void> playOneShot(Uri item) async {
    oneShots.add(item);
    final error = oneShotError;
    if (error != null) throw error;
  }

  @override
  Future<void> replay() async {}

  @override
  Future<void> togglePause() async {}

  @override
  Future<void> seekRelative(Duration delta) async {}

  @override
  Future<void> stop() async {
    stopCalls++;
    events?.add('audio.stop');
  }

  @override
  Future<void> dispose() async {}
}

class _VoiceRecorder implements ReviewVoiceRecorder {
  _VoiceRecorder({
    this.permission = true,
    this.permissionFuture,
    this.startError,
    List<Future<Uri?>>? stopResults,
    this.events,
  }) : stopResults = stopResults ?? <Future<Uri?>>[];

  bool permission;
  Future<bool>? permissionFuture;
  Object? startError;
  final List<Future<Uri?>> stopResults;
  final List<String>? events;
  final elapsedController = StreamController<Duration>.broadcast();
  bool recording = false;
  int startCalls = 0;
  int cancelCalls = 0;
  int disposeCalls = 0;
  int stopIndex = 0;

  void emitElapsed(Duration value) => elapsedController.add(value);

  @override
  bool get isRecording => recording;

  @override
  Stream<Duration> get elapsedChanges => elapsedController.stream;

  @override
  Future<bool> ensurePermission() async {
    events?.add('permission');
    final future = permissionFuture;
    if (future != null) return future;
    return permission;
  }

  @override
  Future<void> start() async {
    startCalls++;
    events?.add('start');
    final error = startError;
    if (error != null) throw error;
    recording = true;
  }

  @override
  Future<Uri?> stop() async {
    recording = false;
    if (stopIndex >= stopResults.length) return null;
    return stopResults[stopIndex++];
  }

  @override
  Future<void> cancel() async {
    cancelCalls++;
    recording = false;
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
    recording = false;
    await elapsedController.close();
  }
}
