import 'dart:async';
import 'dart:io';

import 'package:anki_flutter/features/reviewer/audio/record_review_voice_recorder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:record/record.dart';

void main() {
  test('dispose waits for an in-flight start before disposing native recorder', () async {
    final port = _ControlledRecorderPort(startPending: true);
    final recorder = RecordReviewVoiceRecorder(
      recorder: port,
      tempDirectoryProvider: () async => Directory('/tmp/reviewer-voice-dispose'),
      timerFactory: (_, _) => _TimerHandle(),
    );

    final start = recorder.start();
    await _flush();
    expect(port.startCalls, 1);

    final dispose = recorder.dispose();
    await _flush();
    expect(port.disposeCalls, 0);

    port.completeStart();
    await expectLater(start, throwsStateError);
    await dispose;

    expect(port.cancelCalls, 1);
    expect(port.disposeCalls, 1);
  });

  test('dispose waits for an in-flight stop before disposing native recorder', () async {
    final port = _ControlledRecorderPort(stopPending: true);
    final recorder = RecordReviewVoiceRecorder(
      recorder: port,
      tempDirectoryProvider: () async => Directory('/tmp/reviewer-voice-dispose'),
      timerFactory: (_, _) => _TimerHandle(),
    );

    await recorder.start();
    final stop = recorder.stop();
    await _flush();
    expect(port.stopCalls, 1);

    final dispose = recorder.dispose();
    await _flush();
    expect(port.disposeCalls, 0);

    const output = '/tmp/reviewer-voice-dispose/final.wav';
    port.completeStop(output);
    expect(await stop, Uri.file(output));
    await dispose;

    expect(port.disposeCalls, 1);
  });
}

Future<void> _flush() => Future<void>.delayed(Duration.zero);

class _ControlledRecorderPort implements ReviewVoiceRecorderPort {
  _ControlledRecorderPort({this.startPending = false, this.stopPending = false});

  final bool startPending;
  final bool stopPending;
  final Completer<void> _startCompleter = Completer<void>();
  final Completer<String?> _stopCompleter = Completer<String?>();
  int startCalls = 0;
  int stopCalls = 0;
  int cancelCalls = 0;
  int disposeCalls = 0;

  void completeStart() {
    if (!_startCompleter.isCompleted) _startCompleter.complete();
  }

  void completeStop(String? path) {
    if (!_stopCompleter.isCompleted) _stopCompleter.complete(path);
  }

  @override
  Future<bool> hasPermission() async => true;

  @override
  Future<void> start(RecordConfig config, {required String path}) async {
    startCalls++;
    if (startPending) await _startCompleter.future;
  }

  @override
  Future<String?> stop() async {
    stopCalls++;
    if (stopPending) return _stopCompleter.future;
    return '/tmp/reviewer-voice-dispose/immediate.wav';
  }

  @override
  Future<void> cancel() async {
    cancelCalls++;
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
  }
}

class _TimerHandle implements ReviewVoiceTimerHandle {
  @override
  void cancel() {}
}
