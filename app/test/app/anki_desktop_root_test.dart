import 'dart:typed_data';

import 'package:anki_flutter/app/anki_desktop_root.dart';
import 'package:anki_flutter/app/anki_flutter_app.dart';
import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pb.dart';
import 'package:anki_flutter/core/backend/native/native_anki_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('root initializes one backend with locale and owns its lifetime', (
    tester,
  ) async {
    final bindings = _RecordingBindings();

    await tester.pumpWidget(
      AnkiFlutterApp(
        home: AnkiDesktopRoot(
          bindingsLoader: () => bindings,
          pickCollection: () async => null,
        ),
      ),
    );

    expect(find.text('Open Anki Collection'), findsOneWidget);
    expect(bindings.createCount, 1);
    final init = bindings.init!;
    expect(init.server, isFalse);
    expect(
      init.preferredLangs,
      [tester.binding.platformDispatcher.locale.toLanguageTag()],
    );

    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
    await tester.pump();
    expect(bindings.destroyCount, 1);
  });

  testWidgets('root turns native startup failures into actionable UI', (
    tester,
  ) async {
    await tester.pumpWidget(
      AnkiFlutterApp(
        home: AnkiDesktopRoot(
          bindingsLoader: () => throw const AnkiBridgeException(
            'native bridge missing',
          ),
          pickCollection: () async => null,
        ),
      ),
    );

    expect(find.text('Anki backend unavailable'), findsOneWidget);
    expect(find.textContaining('native bridge missing'), findsOneWidget);
  });
}

class _Handle implements NativeAnkiHandle {}

class _Buffer implements NativeAnkiBuffer {}

class _CreateResult implements NativeAnkiCreateResult {
  _CreateResult(this.handle);

  @override
  final NativeAnkiHandle? handle;

  @override
  int get status => 0;

  @override
  NativeAnkiBuffer get buffer => _Buffer();
}

class _CallResult implements NativeAnkiCallResult {
  @override
  int get status => 0;

  @override
  NativeAnkiBuffer get buffer => _Buffer();
}

class _RecordingBindings implements NativeAnkiBindings {
  int createCount = 0;
  int destroyCount = 0;
  BackendInit? init;

  @override
  NativeAnkiCreateResult create(Uint8List bytes) {
    createCount += 1;
    init = BackendInit.fromBuffer(bytes);
    return _CreateResult(_Handle());
  }

  @override
  NativeAnkiCallResult invoke(
    NativeAnkiHandle handle,
    int operation,
    Uint8List request,
  ) => _CallResult();

  @override
  Uint8List copyBuffer(NativeAnkiBuffer buffer) => Uint8List(0);

  @override
  void freeBuffer(NativeAnkiBuffer buffer) {}

  @override
  void destroy(NativeAnkiHandle handle) {
    destroyCount += 1;
  }
}
