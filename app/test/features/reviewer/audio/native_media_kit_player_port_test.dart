import 'package:anki_flutter/features/reviewer/audio/media_kit_review_audio_player_adapter.dart';
import 'package:anki_flutter/features/reviewer/audio/native_media_kit_player_port.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('production media-kit port satisfies the reviewer player contract', () {
    final MediaKitPlayerPort Function() factory = NativeMediaKitPlayerPort.new;

    expect(factory, isNotNull);
  });
}
