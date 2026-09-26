import 'dart:ffi';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/native/ffi_native_anki_bindings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('missing bridge symbols report an actionable Anki backend error', () {
    expect(
      () => FfiNativeAnkiBindings.fromLibrary(DynamicLibrary.process()),
      throwsA(
        isA<AnkiBridgeException>().having(
          (error) => error.message,
          'message',
          allOf(contains('Anki backend'), contains('anki_bridge_create')),
        ),
      ),
    );
  });
}
