import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sandboxed macOS app embeds the bridge in its signed bundle', () {
    final project = File('macos/Runner.xcodeproj/project.pbxproj')
        .readAsStringSync();

    expect(project, contains('Embed Anki backend bridge'));
    expect(
      project,
      contains('Contents/Frameworks/libanki_flutter_bridge.dylib'),
    );
    expect(project, contains('cargo build --locked --manifest-path'));
  });

  for (final fileName in const [
    'DebugProfile.entitlements',
    'Release.entitlements',
  ]) {
    test(
      'macOS $fileName allows read-write access to selected collections',
      () {
        final entitlements = File('macos/Runner/$fileName').readAsStringSync();

        expect(
          entitlements,
          contains('com.apple.security.files.user-selected.read-write'),
        );
        expect(
          entitlements,
          isNot(contains('com.apple.security.files.user-selected.read-only')),
        );
      },
    );

    test('macOS $fileName allows reviewer loopback networking', () {
      final entitlements = File('macos/Runner/$fileName').readAsStringSync();

      expect(entitlements, contains('com.apple.security.app-sandbox'));
      expect(entitlements, contains('com.apple.security.network.client'));
      expect(entitlements, contains('com.apple.security.network.server'));
    });
  }
}
