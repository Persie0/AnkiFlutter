import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final fileName in const [
    'DebugProfile.entitlements',
    'Release.entitlements',
  ]) {
    test('macOS $fileName allows read-write access to selected collections', () {
      final entitlements = File('macos/Runner/$fileName').readAsStringSync();

      expect(
        entitlements,
        contains('com.apple.security.files.user-selected.read-write'),
      );
      expect(
        entitlements,
        isNot(contains('com.apple.security.files.user-selected.read-only')),
      );
    });
  }
}
