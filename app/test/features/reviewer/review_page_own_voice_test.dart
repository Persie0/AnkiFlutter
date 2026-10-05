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
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('own voice actions appear without card media when supported', (
    tester,
  ) async {
    final recorder = _VoiceRecorder();
    final controller = await _controller(recorder: recorder, audio: _Audio());
    addTearDown(controller.dispose);

    await _pumpPage(tester, controller);
    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();

    expect(find.text('Record Own Voice'), findsOneWidget);
    expect(find.text('Replay Own Voice'), findsOneWidget);
    expect(find.text('Replay audio'), findsNothing);
  });

  testWidgets('plain V reports empty own-voice state', (tester) async {
    final controller = await _controller(
      recorder: _VoiceRecorder(),
      audio: _Audio(),
    );
    addTearDown(controller.dispose);
    await _pumpPage(tester, controller);

    await tester.sendKeyEvent(LogicalKeyboardKey.keyV);
    await tester.pumpAndSettle();

    expect(find.text("You haven't recorded your voice yet."), findsOneWidget);
  });

  testWidgets('Shift+V opens preparing state then recording state once', (
    tester,
  ) async {
    final permission = Completer<bool>();
    final recorder = _VoiceRecorder(permissionFuture: permission.future);
    final controller = await _controller(recorder: recorder, audio: _Audio());
    addTearDown(controller.dispose);
    await controller.toggleAutoAdvance();
    expect(controller.autoAdvanceEnabled, isTrue);
    await _pumpPage(tester, controller);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyV);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.pump();

    expect(find.text('Preparing microphone…'), findsOneWidget);
    expect(controller.autoAdvanceEnabled, isFalse);
    expect(recorder.permissionCalls, 1);
    expect(recorder.startCalls, 0);

    permission.complete(true);
    await tester.pumpAndSettle();

    expect(find.text('Recording your voice'), findsOneWidget);
    expect(find.text('Stop'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(recorder.startCalls, 1);

    recorder.emitElapsed(const Duration(seconds: 3));
    await tester.pump();
    expect(find.text('0:03'), findsOneWidget);
  });

  testWidgets('Stop finalizes once, closes dialog, replays, and restores auto advance', (
    tester,
  ) async {
    final voice = Uri.file('/tmp/reviewer-page-voice.wav');
    final recorder = _VoiceRecorder(stopResult: voice);
    final audio = _Audio();
    final controller = await _controller(recorder: recorder, audio: audio);
    addTearDown(controller.dispose);
    await controller.toggleAutoAdvance();
    await _pumpPage(tester, controller);

    await _pressShiftV(tester);
    await tester.pumpAndSettle();
    expect(find.text('Recording your voice'), findsOneWidget);

    await tester.tap(find.text('Stop'));
    await tester.pumpAndSettle();

    expect(find.text('Recording your voice'), findsNothing);
    expect(recorder.stopCalls, 1);
    expect(audio.oneShots, [voice]);
    expect(controller.autoAdvanceEnabled, isTrue);
  });

  testWidgets('Cancel cancels once and restores auto advance', (tester) async {
    final recorder = _VoiceRecorder();
    final controller = await _controller(recorder: recorder, audio: _Audio());
    addTearDown(controller.dispose);
    await controller.toggleAutoAdvance();
    await _pumpPage(tester, controller);

    await _pressShiftV(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(recorder.cancelCalls, 1);
    expect(controller.autoAdvanceEnabled, isTrue);
  });

  testWidgets('system back cancels recording exactly once', (tester) async {
    final recorder = _VoiceRecorder();
    final controller = await _controller(recorder: recorder, audio: _Audio());
    addTearDown(controller.dispose);
    await _pumpPage(tester, controller);

    await _pressShiftV(tester);
    await tester.pumpAndSettle();
    expect(find.text('Recording your voice'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Recording your voice'), findsNothing);
    expect(recorder.cancelCalls, 1);
  });

  testWidgets('permission denial closes dialog, explains permission, and restores auto advance', (
    tester,
  ) async {
    final recorder = _VoiceRecorder(permission: false);
    final controller = await _controller(recorder: recorder, audio: _Audio());
    addTearDown(controller.dispose);
    await controller.toggleAutoAdvance();
    await _pumpPage(tester, controller);

    await _pressShiftV(tester);
    await tester.pumpAndSettle();

    expect(find.text('Preparing microphone…'), findsNothing);
    expect(
      find.text('Microphone permission is required to record your voice.'),
      findsOneWidget,
    );
    expect(recorder.startCalls, 0);
    expect(controller.autoAdvanceEnabled, isTrue);
  });

  testWidgets('typed-answer focus suppresses V and Shift+V shortcuts', (
    tester,
  ) async {
    final recorder = _VoiceRecorder();
    final audio = _Audio();
    final controller = ReviewController(
      repository: _Repository(),
      renderer: _Renderer(question: 'Answer [[type:Front]]'),
      wallClockMillis: () => 100,
      stopwatchFactory: Stopwatch.new,
      voiceRecorder: recorder,
      audio: audio,
    );
    addTearDown(controller.dispose);
    await controller.start(7);
    await _pumpPage(tester, controller);

    final input = find.byKey(const ValueKey('typed-answer-input'));
    expect(input, findsOneWidget);
    await tester.tap(input);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.keyV);
    await _pressShiftV(tester);
    await tester.pumpAndSettle();

    expect(recorder.permissionCalls, 0);
    expect(audio.oneShots, isEmpty);
    expect(find.text('Preparing microphone…'), findsNothing);
    expect(find.text("You haven't recorded your voice yet."), findsNothing);
  });
}

Future<ReviewController> _controller({
  required _VoiceRecorder recorder,
  required _Audio audio,
}) async {
  final controller = ReviewController(
    repository: _Repository(),
    renderer: _Renderer(),
    wallClockMillis: () => 100,
    stopwatchFactory: Stopwatch.new,
    voiceRecorder: recorder,
    audio: audio,
  );
  await controller.start(7);
  return controller;
}

Future<void> _pumpPage(WidgetTester tester, ReviewController controller) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ReviewPage(
        controller: controller,
        onFinished: () {},
        cardSurfaceBuilder: (_, _) => const Text('Card'),
      ),
    ),
  );
  await tester.pump();
}

Future<void> _pressShiftV(WidgetTester tester) async {
  await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
  await tester.sendKeyEvent(LogicalKeyboardKey.keyV);
  await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
  await tester.pump();
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
  _Renderer({this.question = 'Question'});

  final String question;

  @override
  Future<ReviewCardContent> render(int cardId) async => ReviewCardContent(
    questionHtml: question,
    answerHtml: 'Answer',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}

class _Audio implements ReviewAudioService {
  final oneShots = <Uri>[];
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
  }

  @override
  Future<void> dispose() async {}
}

class _VoiceRecorder implements ReviewVoiceRecorder {
  _VoiceRecorder({
    this.permission = true,
    this.permissionFuture,
    this.stopResult,
  });

  bool permission;
  Future<bool>? permissionFuture;
  Uri? stopResult;
  final elapsedController = StreamController<Duration>.broadcast();
  bool recording = false;
  int permissionCalls = 0;
  int startCalls = 0;
  int stopCalls = 0;
  int cancelCalls = 0;

  void emitElapsed(Duration elapsed) => elapsedController.add(elapsed);

  @override
  bool get isRecording => recording;

  @override
  Stream<Duration> get elapsedChanges => elapsedController.stream;

  @override
  Future<bool> ensurePermission() async {
    permissionCalls++;
    final pending = permissionFuture;
    if (pending != null) return pending;
    return permission;
  }

  @override
  Future<void> start() async {
    startCalls++;
    recording = true;
  }

  @override
  Future<Uri?> stop() async {
    stopCalls++;
    recording = false;
    return stopResult;
  }

  @override
  Future<void> cancel() async {
    cancelCalls++;
    recording = false;
  }

  @override
  Future<void> dispose() async {
    recording = false;
    await elapsedController.close();
  }
}
