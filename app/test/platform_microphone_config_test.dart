import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android declares microphone permission', () {
    final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(manifest, contains('android.permission.RECORD_AUDIO'));
  });

  test('iOS declares microphone usage description', () {
    final plist = File('ios/Runner/Info.plist').readAsStringSync();

    expect(plist, contains('NSMicrophoneUsageDescription'));
    expect(plist, contains('Record Own Voice'));
  });

  test('macOS declares microphone usage description and audio input entitlements', () {
    final plist = File('macos/Runner/Info.plist').readAsStringSync();
    final debugEntitlements = File('macos/Runner/DebugProfile.entitlements').readAsStringSync();
    final releaseEntitlements = File('macos/Runner/Release.entitlements').readAsStringSync();

    expect(plist, contains('NSMicrophoneUsageDescription'));
    expect(plist, contains('Record Own Voice'));
    expect(debugEntitlements, contains('com.apple.security.device.audio-input'));
    expect(releaseEntitlements, contains('com.apple.security.device.audio-input'));
  });
}
