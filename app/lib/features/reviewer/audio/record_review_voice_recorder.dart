import 'dart:async';
import 'dart:io';

import 'package:anki_flutter/features/reviewer/audio/review_voice_recorder.dart';
import 'package:record/record.dart';

abstract interface class ReviewVoiceRecorderPort {
  Future<bool> hasPermission();
  Future<void> start(RecordConfig config, {required String path});
  Future<String?> stop();
  Future<void> cancel();
  Future<void> dispose();
}

abstract interface class ReviewVoiceTimerHandle {
  void cancel();
}

typedef ReviewVoiceTimerFactory =
    ReviewVoiceTimerHandle Function(Duration interval, void Function() callback);

class AudioRecorderReviewVoicePort implements ReviewVoiceRecorderPort {
  AudioRecorderReviewVoicePort({AudioRecorder? recorder})
    : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;

  @override
  Future<bool> hasPermission() => _recorder.hasPermission();

  @override
  Future<void> start(RecordConfig config, {required String path}) =>
      _recorder.start(config, path: path);

  @override
  Future<String?> stop() => _recorder.stop();

  @override
  Future<void> cancel() => _recorder.cancel();

  @override
  Future<void> dispose() => _recorder.dispose();
}

class RecordReviewVoiceRecorder implements ReviewVoiceRecorder {
  RecordReviewVoiceRecorder({
    ReviewVoiceRecorderPort? recorder,
    Future<Directory> Function()? tempDirectoryProvider,
    DateTime Function()? now,
    ReviewVoiceTimerFactory? timerFactory,
  }) : _recorder = recorder ?? AudioRecorderReviewVoicePort(),
       _tempDirectoryProvider =
           tempDirectoryProvider ?? (() async => Directory.systemTemp),
       _now = now ?? DateTime.now,
       _timerFactory = timerFactory ?? _defaultTimerFactory;

  static const _elapsedInterval = Duration(seconds: 1);

  final ReviewVoiceRecorderPort _recorder;
  final Future<Directory> Function() _tempDirectoryProvider;
  final DateTime Function() _now;
  final ReviewVoiceTimerFactory _timerFactory;
  final StreamController<Duration> _elapsedController =
      StreamController<Duration>.broadcast();

  ReviewVoiceTimerHandle? _elapsedTimer;
  DateTime? _recordingStartedAt;
  bool _recording = false;
  bool _disposed = false;
  int _pathSequence = 0;

  @override
  bool get isRecording => _recording;

  @override
  Stream<Duration> get elapsedChanges => _elapsedController.stream;

  @override
  Future<bool> ensurePermission() async {
    _ensureUsable();
    return _recorder.hasPermission();
  }

  @override
  Future<void> start() async {
    _ensureUsable();
    if (_recording) {
      throw StateError('A Reviewer voice recording is already active.');
    }

    final directory = await _tempDirectoryProvider();
    final path = _nextRecordingPath(directory);
    try {
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.wav),
        path: path,
      );
    } catch (_) {
      try {
        await _recorder.cancel();
      } catch (_) {
        // Preserve the original start failure.
      }
      rethrow;
    }

    if (_disposed) {
      try {
        await _recorder.cancel();
      } catch (_) {
        // Disposal has already won the lifecycle race.
      }
      throw StateError('The Reviewer voice recorder has been disposed.');
    }

    _recording = true;
    _recordingStartedAt = _now();
    _elapsedController.add(Duration.zero);
    _elapsedTimer = _timerFactory(_elapsedInterval, _emitElapsed);
  }

  @override
  Future<Uri?> stop() async {
    _ensureUsable();
    if (!_recording) return null;

    _clearActiveState();
    final path = await _recorder.stop();
    if (path == null || path.isEmpty) return null;
    return Uri.file(path);
  }

  @override
  Future<void> cancel() async {
    _ensureUsable();
    if (!_recording) return;

    _clearActiveState();
    await _recorder.cancel();
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;

    final wasRecording = _recording;
    _clearActiveState();
    if (wasRecording) {
      try {
        await _recorder.cancel();
      } catch (_) {
        // Cleanup is best-effort during disposal.
      }
    }

    try {
      await _recorder.dispose();
    } finally {
      await _elapsedController.close();
    }
  }

  String _nextRecordingPath(Directory directory) {
    _pathSequence += 1;
    final timestamp = _now().microsecondsSinceEpoch;
    final filename = 'review-own-voice-$timestamp-$_pathSequence.wav';
    return '${directory.path}${Platform.pathSeparator}$filename';
  }

  void _emitElapsed() {
    if (_disposed || !_recording) return;
    final startedAt = _recordingStartedAt;
    if (startedAt == null) return;
    final elapsed = _now().difference(startedAt);
    _elapsedController.add(elapsed.isNegative ? Duration.zero : elapsed);
  }

  void _clearActiveState() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
    _recordingStartedAt = null;
    _recording = false;
  }

  void _ensureUsable() {
    if (_disposed) {
      throw StateError('The Reviewer voice recorder has been disposed.');
    }
  }

  static ReviewVoiceTimerHandle _defaultTimerFactory(
    Duration interval,
    void Function() callback,
  ) {
    return _DartReviewVoiceTimer(
      Timer.periodic(interval, (_) => callback()),
    );
  }
}

class _DartReviewVoiceTimer implements ReviewVoiceTimerHandle {
  _DartReviewVoiceTimer(this._timer);

  final Timer _timer;

  @override
  void cancel() => _timer.cancel();
}
