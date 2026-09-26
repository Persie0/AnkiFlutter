abstract interface class ReviewAudioPlayerAdapter {
  bool get isPlaying;

  Stream<bool> get playingChanges;

  Future<void> openQueue(List<Uri> items);

  Future<void> play();

  Future<void> pause();

  Future<void> seekRelative(Duration delta);

  Future<void> stop();

  Future<void> dispose();
}

abstract interface class ReviewAudioService {
  bool get isPlaying;

  Stream<bool> get playingChanges;

  Future<void> playQueue(List<Uri> items);

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
  bool get isPlaying => _player.isPlaying;

  @override
  Stream<bool> get playingChanges => _player.playingChanges;

  @override
  Future<void> playQueue(List<Uri> items) async {
    _ensureUsable();
    _currentQueue = List<Uri>.unmodifiable(items);
    if (_currentQueue.isEmpty) {
      await _player.stop();
      return;
    }
    await _player.openQueue(_currentQueue);
  }

  @override
  Future<void> replay() async {
    _ensureUsable();
    if (_currentQueue.isEmpty) {
      return;
    }
    await _player.openQueue(_currentQueue);
  }

  @override
  Future<void> togglePause() async {
    _ensureUsable();
    if (_player.isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  @override
  Future<void> seekRelative(Duration delta) async {
    _ensureUsable();
    await _player.seekRelative(delta);
  }

  @override
  Future<void> stop() async {
    _ensureUsable();
    await _player.stop();
  }

  @override
  Future<void> dispose() async {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _currentQueue = const [];
    await _player.dispose();
  }

  void _ensureUsable() {
    if (_disposed) {
      throw StateError('ReviewAudioService has been disposed');
    }
  }
}
