import 'dart:async';

import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakePlayerAdapter player;
  late PlayerBackedReviewAudioService service;

  setUp(() {
    player = _FakePlayerAdapter();
    service = PlayerBackedReviewAudioService(player: player);
  });

  tearDown(() async {
    if (!player.disposed) {
      await service.dispose();
    }
  });

  test('playQueue preserves media order and starts the supplied queue', () async {
    final items = [
      Uri.parse('file:///tmp/one.mp3'),
      Uri.parse('file:///tmp/two.mp3'),
      Uri.parse('http://127.0.0.1:1234/token/three.ogg'),
    ];

    await service.playQueue(items);

    expect(player.openedQueues, hasLength(1));
    expect(player.openedQueues.single, orderedEquals(items));
  });

  test('replay restarts the current logical queue from its beginning', () async {
    final items = [
      Uri.parse('file:///tmp/one.mp3'),
      Uri.parse('file:///tmp/two.mp3'),
    ];
    await service.playQueue(items);
    player.openedQueues.clear();

    await service.replay();

    expect(player.openedQueues, hasLength(1));
    expect(player.openedQueues.single, orderedEquals(items));
  });

  test('playOneShot preserves the current logical queue for replay', () async {
    final queue = [
      Uri.parse('file:///tmp/card-question.mp3'),
      Uri.parse('file:///tmp/card-answer.mp3'),
    ];
    final voice = Uri.parse('file:///tmp/reviewer-own-voice.wav');
    await service.playQueue(queue);
    player.openedQueues.clear();

    await service.playOneShot(voice);

    expect(player.openedOneShots, orderedEquals([voice]));
    expect(player.openedQueues, isEmpty);

    await service.replay();

    expect(player.openedQueues, hasLength(1));
    expect(player.openedQueues.single, orderedEquals(queue));
    expect(player.openedOneShots, orderedEquals([voice]));
  });

  test('replay without a queue is a no-op', () async {
    await service.replay();

    expect(player.openedQueues, isEmpty);
  });

  test('togglePause pauses while playing and resumes while paused', () async {
    player.playing = true;

    await service.togglePause();
    expect(player.pauseCalls, 1);
    expect(player.playCalls, 0);

    player.playing = false;
    await service.togglePause();
    expect(player.playCalls, 1);
  });

  test('seekRelative forwards reviewer seek deltas exactly', () async {
    await service.seekRelative(const Duration(seconds: -5));
    await service.seekRelative(const Duration(seconds: 5));

    expect(
      player.seekDeltas,
      orderedEquals([
        const Duration(seconds: -5),
        const Duration(seconds: 5),
      ]),
    );
  });

  test('playing state and changes are exposed from the player adapter', () async {
    expect(service.isPlaying, isFalse);

    final emitted = <bool>[];
    final subscription = service.playingChanges.listen(emitted.add);
    player.emitPlaying(true);
    player.emitPlaying(false);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, orderedEquals([true, false]));
    await subscription.cancel();
  });

  test('stop and dispose delegate exactly once and clear replay state', () async {
    await service.playQueue([Uri.parse('file:///tmp/one.mp3')]);

    await service.stop();
    expect(player.stopCalls, 1);

    await service.dispose();
    expect(player.disposeCalls, 1);

    player.openedQueues.clear();
    await service.replay();
    expect(player.openedQueues, isEmpty);
  });
}

class _FakePlayerAdapter implements ReviewAudioPlayerAdapter {
  final _playingController = StreamController<bool>.broadcast();
  final List<List<Uri>> openedQueues = [];
  final List<Uri> openedOneShots = [];
  final List<Duration> seekDeltas = [];

  bool playing = false;
  bool disposed = false;
  int playCalls = 0;
  int pauseCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;

  @override
  bool get isPlaying => playing;

  @override
  Stream<bool> get playingChanges => _playingController.stream;

  void emitPlaying(bool value) {
    playing = value;
    _playingController.add(value);
  }

  @override
  Future<void> openQueue(List<Uri> items) async {
    openedQueues.add(List<Uri>.from(items));
  }

  @override
  Future<void> openOneShot(Uri item) async {
    openedOneShots.add(item);
  }

  @override
  Future<void> pause() async {
    pauseCalls++;
    playing = false;
  }

  @override
  Future<void> play() async {
    playCalls++;
    playing = true;
  }

  @override
  Future<void> seekRelative(Duration delta) async {
    seekDeltas.add(delta);
  }

  @override
  Future<void> stop() async {
    stopCalls++;
    playing = false;
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
    disposed = true;
    await _playingController.close();
  }
}
