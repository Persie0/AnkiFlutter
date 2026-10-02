import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('release metadata has no template identifiers or debug signing', () async {
    final androidGradle = await File('android/app/build.gradle.kts').readAsString();
    final androidManifest = await File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsString();
    final linuxCmake = await File('linux/CMakeLists.txt').readAsString();
    final macAppInfo = await File(
      'macos/Runner/Configs/AppInfo.xcconfig',
    ).readAsString();
    final windowsResources = await File(
      'windows/runner/Runner.rc',
    ).readAsString();
    final iosInfo = await File('ios/Runner/Info.plist').readAsString();

    expect(androidManifest, contains('android:label="AnkiFlutter"'));
    expect(
      androidGradle,
      isNot(contains('signingConfig = signingConfigs.getByName("debug")')),
    );
    expect(androidGradle, contains('ANKIFLUTTER_KEYSTORE_PATH'));
    expect(androidGradle, contains('key.properties'));

    expect(linuxCmake, isNot(contains('com.example.anki_flutter')));
    expect(
      linuxCmake,
      contains('set(APPLICATION_ID "dev.persie0.anki_flutter")'),
    );

    expect(macAppInfo, contains('PRODUCT_NAME = AnkiFlutter'));
    expect(macAppInfo, contains('PRODUCT_COPYRIGHT = Copyright © 2026 Persie0.'));

    expect(windowsResources, contains('VALUE "CompanyName", "Persie0"'));
    expect(windowsResources, contains('VALUE "ProductName", "AnkiFlutter"'));
    expect(windowsResources, contains('VALUE "FileDescription", "AnkiFlutter"'));

    expect(iosInfo, contains('<string>AnkiFlutter</string>'));
    expect(iosInfo, isNot(contains('<string>anki_flutter</string>')));
  });
}
