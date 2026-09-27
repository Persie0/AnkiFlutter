import 'package:anki_flutter/features/reviewer/audio/media_kit_review_audio_player_adapter.dart';
import 'package:media_kit/media_kit.dart';

final class NativeMediaKitPlayerPort implements MediaKitPlayerPort {
  NativeMediaKitPlayerPort() : _player = Player();

  final Player _player;

  @override
  bool get isPlaying => _player.state.playing;

  @override
  Stream<bool> get playingChanges => _player.stream.playing;

  @override
  Duration get currentPosition => _player.state.position;

  @override
  Future<void> openSources(List<String> sources, {required bool play}) {
    return _player.open(
      Playlist(
        sources.map(Media.new).toList(growable: false),
      ),
      play: play,
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> dispose() => _player.dispose();
}
