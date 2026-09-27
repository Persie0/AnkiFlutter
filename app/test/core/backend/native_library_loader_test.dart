import 'dart:ffi';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/native/native_library_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses platform-specific Anki bridge file names', () {
    expect(
      nativeLibraryFileName(TargetPlatform.linux),
      'libanki_flutter_bridge.so',
    );
    expect(
      nativeLibraryFileName(TargetPlatform.macOS),
      'libanki_flutter_bridge.dylib',
    );
    expect(
      nativeLibraryFileName(TargetPlatform.windows),
      'anki_flutter_bridge.dll',
    );
  });

  test('dart-define override wins over executable-directory default', () {
    final resolved = resolveNativeLibraryPath(
      platform: TargetPlatform.linux,
      executablePath: '/opt/ankiflutter/anki_flutter',
      environmentOverride: '/tmp/custom/libanki_flutter_bridge.so',
    );

    expect(resolved, '/tmp/custom/libanki_flutter_bridge.so');
  });

  test('defaults to executable directory', () {
    final resolved = resolveNativeLibraryPath(
      platform: TargetPlatform.linux,
      executablePath: '/opt/ankiflutter/anki_flutter',
      environmentOverride: '',
    );

    expect(resolved, '/opt/ankiflutter/libanki_flutter_bridge.so');
  });

  test('missing native library reports Anki backend and attempted path', () {
    const attempted = '/missing/libanki_flutter_bridge.so';

    expect(
      () => openNativeLibrary(
        attempted,
        opener: (_) => throw ArgumentError('not found'),
      ),
      throwsA(
        isA<AnkiBridgeException>()
            .having((error) => error.message, 'message', contains('Anki backend'))
            .having((error) => error.message, 'message', contains(attempted)),
      ),
    );
  });

  test('openNativeLibrary delegates to provided opener', () {
    var attempted = '';
    expect(
      () => openNativeLibrary(
        '/test/path.so',
        opener: (path) {
          attempted = path;
          throw UnsupportedError('sentinel');
        },
      ),
      throwsA(isA<AnkiBridgeException>()),
    );
    expect(attempted, '/test/path.so');
  });
}

typedef DynamicLibraryOpener = DynamicLibrary Function(String path);
