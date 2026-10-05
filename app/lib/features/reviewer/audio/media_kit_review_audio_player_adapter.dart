import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';

abstract interface class MediaKitPlayerPort {
  bool get isPlaying;

  Stream<bool> get playingChanges;

  Duration get currentPosition;

  Future<void> openSources(List<String> sources, {required bool play});

  Future<void> play();

  Future<void> pause();

  Future<void> seek(Duration position);

  Future<void> stop();

  Future<void> dispose();
}

class MediaKitReviewAudioPlayerAdapter implements ReviewAudioPlayerAdapter {
  MediaKitReviewAudioPlayerAdapter({required this._player});

  final MediaKitPlayerPort _player;

  @override
  bool get isPlaying => _player.isPlaying;

  @override
  Stream<bool> get playingChanges => _player.playingChanges;

  @override
  Future<void> openQueue(List<Uri> items) {
    return _player.openSources(
      items.map((uri) => uri.toString()).toList(growable: false),
      play: true,
    );
  }

  @override
  Future<void> openOneShot(Uri item) {
    return _player.openSources([item.toString()], play: true);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seekRelative(Duration delta) {
    final requested = _player.currentPosition + delta;
    return _player.seek(requested.isNegative ? Duration.zero : requested);
  }

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> dispose() => _player.dispose();
}
