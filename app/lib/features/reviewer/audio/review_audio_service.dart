import 'dart:async';

abstract interface class ReviewAudioPlayerAdapter {
  bool get isPlaying;
  Stream<bool> get playingChanges;

  Future<void> openQueue(List<Uri> items);
  Future<void> openOneShot(Uri item);
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seekRelative(Duration delta);
  Future<void> dispose();
}

abstract interface class ReviewAudioService {
  bool get isPlaying;
  Stream<bool> get playingChanges;

  Future<void> playQueue(List<Uri> items);
  Future<void> playOneShot(Uri item);
  Future<void> replay();
  Future<void> togglePause();
  Future<void> seekRelative(Duration delta);
  Future<void> stop();
  Future<void> dispose();
}

class PlayerBackedReviewAudioService implements ReviewAudioService {
  PlayerBackedReviewAudioService({required ReviewAudioPlayerAdapter player})
    : _player = player;

  final ReviewAudioPlayerAdapter _player;
  List<Uri> _currentQueue = const [];
  bool _disposed = false;

  @override
  bool get isPlaying => _disposed ? false : _player.isPlaying;

  @override
  Stream<bool> get playingChanges =>
      _disposed ? const Stream<bool>.empty() : _player.playingChanges;

  @override
  Future<void> playQueue(List<Uri> items) async {
    if (_disposed) return;
    _currentQueue = List<Uri>.unmodifiable(items);
    if (_currentQueue.isEmpty) {
      await _player.stop();
      return;
    }
    await _player.openQueue(_currentQueue);
  }

  @override
  Future<void> playOneShot(Uri item) async {
    if (_disposed) return;
    await _player.openOneShot(item);
  }

  @override
  Future<void> replay() async {
    if (_disposed || _currentQueue.isEmpty) return;
    await _player.openQueue(_currentQueue);
  }

  @override
  Future<void> togglePause() async {
    if (_disposed) return;
    if (_player.isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  @override
  Future<void> seekRelative(Duration delta) async {
    if (_disposed) return;
    await _player.seekRelative(delta);
  }

  @override
  Future<void> stop() async {
    if (_disposed) return;
    await _player.stop();
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _currentQueue = const [];
    await _player.dispose();
  }
}
