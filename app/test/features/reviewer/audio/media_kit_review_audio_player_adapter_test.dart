import 'dart:async';

import 'package:anki_flutter/features/reviewer/audio/media_kit_review_audio_player_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('openQueue preserves URI order and starts the media-kit playlist', () async {
    final player = _FakeMediaKitPlayerPort();
    final adapter = MediaKitReviewAudioPlayerAdapter(player: player);

    await adapter.openQueue([
      Uri.parse('file:///tmp/question.mp3'),
      Uri.parse('http://127.0.0.1:1234/token/media/answer.ogg'),
    ]);

    expect(player.openedSources, [
      'file:///tmp/question.mp3',
      'http://127.0.0.1:1234/token/media/answer.ogg',
    ]);
    expect(player.openPlay, isTrue);
  });

  test('openOneShot opens exactly one source and starts immediately', () async {
    final player = _FakeMediaKitPlayerPort();
    final adapter = MediaKitReviewAudioPlayerAdapter(player: player);

    await adapter.openOneShot(Uri.parse('file:///tmp/reviewer-own-voice.wav'));

    expect(player.openedSources, ['file:///tmp/reviewer-own-voice.wav']);
    expect(player.openPlay, isTrue);
  });

  test('seekRelative uses current position and clamps before zero', () async {
    final player = _FakeMediaKitPlayerPort()
      ..position = const Duration(seconds: 3);
    final adapter = MediaKitReviewAudioPlayerAdapter(player: player);

    await adapter.seekRelative(const Duration(seconds: 5));
    expect(player.seekTargets, [const Duration(seconds: 8)]);

    player.position = const Duration(seconds: 2);
    await adapter.seekRelative(const Duration(seconds: -5));
    expect(player.seekTargets.last, Duration.zero);
  });

  test('playing state stream and transport controls delegate exactly', () async {
    final player = _FakeMediaKitPlayerPort()..playing = true;
    final adapter = MediaKitReviewAudioPlayerAdapter(player: player);
    final changes = <bool>[];
    final subscription = adapter.playingChanges.listen(changes.add);

    expect(adapter.isPlaying, isTrue);
    player.playingController.add(false);
    await Future<void>.delayed(Duration.zero);
    await adapter.play();
    await adapter.pause();
    await adapter.stop();
    await adapter.dispose();
    await subscription.cancel();

    expect(changes, [false]);
    expect(player.playCalls, 1);
    expect(player.pauseCalls, 1);
    expect(player.stopCalls, 1);
    expect(player.disposeCalls, 1);
  });
}

class _FakeMediaKitPlayerPort implements MediaKitPlayerPort {
  final playingController = StreamController<bool>.broadcast();
  List<String> openedSources = const [];
  bool? openPlay;
  bool playing = false;
  Duration position = Duration.zero;
  final seekTargets = <Duration>[];
  int playCalls = 0;
  int pauseCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;

  @override
  bool get isPlaying => playing;

  @override
  Stream<bool> get playingChanges => playingController.stream;

  @override
  Duration get currentPosition => position;

  @override
  Future<void> openSources(List<String> sources, {required bool play}) async {
    openedSources = List.unmodifiable(sources);
    openPlay = play;
  }

  @override
  Future<void> play() async {
    playCalls += 1;
  }

  @override
  Future<void> pause() async {
    pauseCalls += 1;
  }

  @override
  Future<void> seek(Duration position) async {
    seekTargets.add(position);
  }

  @override
  Future<void> stop() async {
    stopCalls += 1;
  }

  @override
  Future<void> dispose() async {
    disposeCalls += 1;
    await playingController.close();
  }
}
