import 'dart:async';
import 'dart:io';

import 'package:anki_flutter/features/reviewer/audio/record_review_voice_recorder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:record/record.dart';

void main() {
  late _FakeRecorderPort port;
  late _FakeClock clock;
  late _FakeTimerFactory timers;
  late RecordReviewVoiceRecorder recorder;

  setUp(() {
    port = _FakeRecorderPort();
    clock = _FakeClock(DateTime.utc(2026, 10, 5, 12));
    timers = _FakeTimerFactory();
    recorder = RecordReviewVoiceRecorder(
      recorder: port,
      tempDirectoryProvider: () async => Directory('/tmp/reviewer-voice-test'),
      now: clock.call,
      timerFactory: timers.call,
    );
  });

  test('permission delegates to the recorder port', () async {
    port.permission = false;
    expect(await recorder.ensurePermission(), isFalse);
    expect(port.permissionCalls, 1);

    port.permission = true;
    expect(await recorder.ensurePermission(), isTrue);
    expect(port.permissionCalls, 2);
  });

  test('start uses unique WAV paths and WAV encoder', () async {
    await recorder.start();

    expect(recorder.isRecording, isTrue);
    expect(port.starts, hasLength(1));
    expect(port.starts.single.config.encoder, AudioEncoder.wav);
    expect(port.starts.single.path, startsWith('/tmp/reviewer-voice-test/'));
    expect(port.starts.single.path, endsWith('.wav'));
    final firstPath = port.starts.single.path;

    port.stopResult = firstPath;
    await recorder.stop();
    clock.advance(const Duration(microseconds: 1));
    await recorder.start();

    expect(port.starts, hasLength(2));
    expect(port.starts.last.path, isNot(firstPath));
  });

  test('second concurrent start is rejected deterministically', () async {
    await recorder.start();

    await expectLater(recorder.start(), throwsStateError);
    expect(port.starts, hasLength(1));
  });

  test('start is rejected while stop finalization is pending', () async {
    await recorder.start();
    final stopGate = Completer<String?>();
    port.stopFuture = stopGate.future;

    final stop = recorder.stop();
    await _flush();

    await expectLater(recorder.start(), throwsStateError);
    expect(port.starts, hasLength(1));

    stopGate.complete(port.starts.single.path);
    await stop;
  });

  test('cancel waits for an in-flight start and cancels it once active', () async {
    final startGate = Completer<void>();
    port.startFuture = startGate.future;

    final start = recorder.start();
    await _flush();
    expect(port.starts, hasLength(1));

    var cancelCompleted = false;
    final cancel = recorder.cancel().whenComplete(() => cancelCompleted = true);
    await _flush();
    final completedBeforeStartSettled = cancelCompleted;

    startGate.complete();
    await start;
    await cancel;

    expect(completedBeforeStartSettled, isFalse);
    expect(port.cancelCalls, 1);
    expect(recorder.isRecording, isFalse);
  });

  test('elapsed stream resets to zero and advances only while active', () async {
    final elapsed = <Duration>[];
    final subscription = recorder.elapsedChanges.listen(elapsed.add);

    await recorder.start();
    await _flush();
    expect(elapsed, [Duration.zero]);

    clock.advance(const Duration(seconds: 3));
    timers.active.single.fire();
    await _flush();
    expect(elapsed.last, const Duration(seconds: 3));

    port.stopResult = port.starts.single.path;
    await recorder.stop();
    clock.advance(const Duration(seconds: 2));
    timers.fireAll();
    await _flush();
    expect(elapsed.last, const Duration(seconds: 3));

    await recorder.start();
    await _flush();
    expect(elapsed.last, Duration.zero);

    await subscription.cancel();
  });

  test('stop returns finalized file URI and clears active state', () async {
    await recorder.start();
    port.stopResult = '/tmp/reviewer-voice-test/final.wav';

    final result = await recorder.stop();

    expect(result, Uri.file('/tmp/reviewer-voice-test/final.wav'));
    expect(recorder.isRecording, isFalse);
    expect(port.stopCalls, 1);
    expect(timers.created.single.cancelled, isTrue);
  });

  test('stop without active recording returns null without touching plugin', () async {
    expect(await recorder.stop(), isNull);
    expect(port.stopCalls, 0);
  });

  test('cancel abandons active recording and stops elapsed updates', () async {
    await recorder.start();
    final timer = timers.created.single;

    await recorder.cancel();

    expect(port.cancelCalls, 1);
    expect(recorder.isRecording, isFalse);
    expect(timer.cancelled, isTrue);
  });

  test('dispose cancels active work and is idempotent', () async {
    await recorder.start();

    await recorder.dispose();
    await recorder.dispose();

    expect(port.cancelCalls, 1);
    expect(port.disposeCalls, 1);
    expect(recorder.isRecording, isFalse);
  });

  test('start failure does not leave recorder active', () async {
    port.startError = StateError('start failed');

    await expectLater(recorder.start(), throwsStateError);

    expect(recorder.isRecording, isFalse);
    expect(port.cancelCalls, 1);
  });

  test('stop failure does not leave recorder active', () async {
    await recorder.start();
    port.stopError = StateError('stop failed');

    await expectLater(recorder.stop(), throwsStateError);

    expect(recorder.isRecording, isFalse);
    expect(timers.created.single.cancelled, isTrue);
  });

  test('null stop result removes abandoned temporary output', () async {
    await recorder.start();
    final output = File(port.starts.single.path);
    await output.parent.create(recursive: true);
    await output.writeAsString('partial');

    port.stopResult = null;
    expect(await recorder.stop(), isNull);

    expect(await output.exists(), isFalse);
  });

  test('stop failure removes abandoned temporary output', () async {
    await recorder.start();
    final output = File(port.starts.single.path);
    await output.parent.create(recursive: true);
    await output.writeAsString('partial');
    port.stopError = StateError('stop failed');

    await expectLater(recorder.stop(), throwsStateError);

    expect(await output.exists(), isFalse);
  });

  test('cancel failure still clears local active state', () async {
    await recorder.start();
    port.cancelError = StateError('cancel failed');

    await expectLater(recorder.cancel(), throwsStateError);

    expect(recorder.isRecording, isFalse);
    expect(timers.created.single.cancelled, isTrue);
  });
}

Future<void> _flush() => Future<void>.delayed(Duration.zero);

class _StartCall {
  const _StartCall(this.config, this.path);

  final RecordConfig config;
  final String path;
}

class _FakeRecorderPort implements ReviewVoiceRecorderPort {
  bool permission = true;
  int permissionCalls = 0;
  int stopCalls = 0;
  int cancelCalls = 0;
  int disposeCalls = 0;
  final starts = <_StartCall>[];
  String? stopResult;
  Future<String?>? stopFuture;
  Future<void>? startFuture;
  Object? startError;
  Object? stopError;
  Object? cancelError;

  @override
  Future<bool> hasPermission() async {
    permissionCalls++;
    return permission;
  }

  @override
  Future<void> start(RecordConfig config, {required String path}) async {
    starts.add(_StartCall(config, path));
    final pending = startFuture;
    if (pending != null) await pending;
    final error = startError;
    if (error != null) throw error;
  }

  @override
  Future<String?> stop() async {
    stopCalls++;
    final error = stopError;
    if (error != null) throw error;
    final pending = stopFuture;
    if (pending != null) return pending;
    return stopResult;
  }

  @override
  Future<void> cancel() async {
    cancelCalls++;
    final error = cancelError;
    if (error != null) throw error;
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
  }
}

class _FakeClock {
  _FakeClock(this.value);

  DateTime value;

  DateTime call() => value;

  void advance(Duration duration) {
    value = value.add(duration);
  }
}

class _FakeTimerFactory {
  final created = <_FakeTimer>[];

  List<_FakeTimer> get active =>
      created.where((timer) => !timer.cancelled).toList(growable: false);

  ReviewVoiceTimerHandle call(Duration interval, void Function() callback) {
    final timer = _FakeTimer(callback);
    created.add(timer);
    return timer;
  }

  void fireAll() {
    for (final timer in List<_FakeTimer>.of(created)) {
      timer.fire();
    }
  }
}

class _FakeTimer implements ReviewVoiceTimerHandle {
  _FakeTimer(this.callback);

  final void Function() callback;
  bool cancelled = false;

  void fire() {
    if (!cancelled) callback();
  }

  @override
  void cancel() {
    cancelled = true;
  }
}
