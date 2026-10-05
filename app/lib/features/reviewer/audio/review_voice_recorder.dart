abstract interface class ReviewVoiceRecorder {
  bool get isRecording;
  Stream<Duration> get elapsedChanges;

  Future<bool> ensurePermission();
  Future<void> start();
  Future<Uri?> stop();
  Future<void> cancel();
  Future<void> dispose();
}
