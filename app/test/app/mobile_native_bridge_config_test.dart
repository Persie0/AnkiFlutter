import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Android build creates packaged Rust bridge libraries for arm64 and x64',
    () {
      final gradle = File('android/app/build.gradle.kts').readAsStringSync();

      expect(gradle, contains('cargo-ndk'));
      expect(gradle, contains('arm64-v8a'));
      expect(gradle, contains('x86_64'));
      expect(gradle, contains('src/main/jniLibs'));
      expect(gradle, contains('native/anki_bridge/Cargo.toml'));
      expect(gradle, contains('workingDir = rustBridgeManifest.parentFile'));
    },
  );

  test('iOS build links the static bridge into the sandboxed app process', () {
    final project = File('ios/Runner.xcodeproj/project.pbxproj')
        .readAsStringSync();
    final debug = File('ios/Flutter/Debug.xcconfig').readAsStringSync();
    final release = File('ios/Flutter/Release.xcconfig').readAsStringSync();

    expect(project, contains('Build Anki Rust static bridge'));
    expect(project, contains('aarch64-apple-ios-sim'));
    expect(debug, contains('-force_load'));
    expect(release, contains('-force_load'));
    expect(debug, contains('libanki_flutter_bridge.a'));
    expect(release, contains('libanki_flutter_bridge.a'));
    expect(project, contains(r'cat \"$CARGO_LOG\" >&2'));
    expect(project, contains(r'MACOS_SDKROOT=\"$(xcrun --sdk macosx --show-sdk-path)\"'));
    expect(project, contains(r'SDKROOT=\"$MACOS_SDKROOT\"'));
  });
}
