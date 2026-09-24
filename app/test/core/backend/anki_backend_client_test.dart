import 'dart:convert';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_client.dart';
import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pb.dart';
import 'package:anki_flutter/core/backend/native/native_anki_bindings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeNativeAnkiBindings bindings;
  late AnkiBackendClient client;

  setUp(() {
    bindings = FakeNativeAnkiBindings();
    client = AnkiBackendClient.create(
      bindings: bindings,
      init: Uint8List.fromList(const [1, 2, 3]),
    );
  });

  tearDown(() {
    if (!client.isDisposed) {
      client.dispose();
    }
  });

  test('status 0 copies result bytes before freeing exactly once', () async {
    bindings.nextCall = FakeCallResult(0, Uint8List.fromList([4, 5, 6]));

    final bytes = await client.invoke(BackendOperation.deckTree, Uint8List(0));

    expect(bytes, [4, 5, 6]);
    expect(bindings.copyCount, 1);
    expect(bindings.freeCount, 1);
    expect(bindings.events, containsAllInOrder(['copy', 'free']));
  });

  test('status 1 frees once and throws stable AnkiBackendException', () async {
    final backendError = BackendError(
      message: 'cannot open collection',
      kind: BackendError_Kind.IO_ERROR,
      context: 'collection.anki2',
    );
    bindings.nextCall = FakeCallResult(
      1,
      Uint8List.fromList(backendError.writeToBuffer()),
    );

    await expectLater(
      client.invoke(BackendOperation.openCollection, Uint8List(0)),
      throwsA(
        isA<AnkiBackendException>()
            .having((e) => e.kind, 'kind', BackendError_Kind.IO_ERROR.value)
            .having((e) => e.message, 'message', 'cannot open collection')
            .having((e) => e.context, 'context', 'collection.anki2'),
      ),
    );
    expect(bindings.freeCount, 1);
  });

  test('status 2 frees once and throws UTF-8 AnkiBridgeException', () async {
    bindings.nextCall = FakeCallResult(
      2,
      Uint8List.fromList(utf8.encode('native bridge failed')),
    );

    await expectLater(
      client.invoke(BackendOperation.deckTree, Uint8List(0)),
      throwsA(
        isA<AnkiBridgeException>().having(
          (e) => e.message,
          'message',
          'native bridge failed',
        ),
      ),
    );
    expect(bindings.freeCount, 1);
  });

  test('dispose destroys native handle exactly once', () {
    client.dispose();
    client.dispose();

    expect(bindings.destroyCount, 1);
    expect(client.isDisposed, isTrue);
  });

  test('invoke after dispose throws StateError', () async {
    client.dispose();

    await expectLater(
      client.invoke(BackendOperation.deckTree, Uint8List(0)),
      throwsStateError,
    );
  });
}

final class FakeNativeHandle implements NativeAnkiHandle {}

final class FakeNativeBuffer implements NativeAnkiBuffer {
  FakeNativeBuffer(this.bytes);
  final Uint8List bytes;
}

final class FakeCallResult implements NativeAnkiCallResult {
  FakeCallResult(this.status, Uint8List bytes)
      : buffer = FakeNativeBuffer(bytes);

  @override
  final int status;

  @override
  final NativeAnkiBuffer buffer;
}

final class FakeCreateResult implements NativeAnkiCreateResult {
  FakeCreateResult(this.status, this.handle, Uint8List bytes)
      : buffer = FakeNativeBuffer(bytes);

  @override
  final int status;

  @override
  final NativeAnkiHandle? handle;

  @override
  final NativeAnkiBuffer buffer;
}

final class FakeNativeAnkiBindings implements NativeAnkiBindings {
  final FakeNativeHandle handle = FakeNativeHandle();
  FakeCallResult nextCall = FakeCallResult(0, Uint8List(0));
  int copyCount = 0;
  int freeCount = 0;
  int destroyCount = 0;
  final List<String> events = [];

  @override
  NativeAnkiCreateResult create(Uint8List init) =>
      FakeCreateResult(0, handle, Uint8List(0));

  @override
  NativeAnkiCallResult invoke(
    NativeAnkiHandle handle,
    int operation,
    Uint8List request,
  ) => nextCall;

  @override
  Uint8List copyBuffer(NativeAnkiBuffer buffer) {
    copyCount++;
    events.add('copy');
    return Uint8List.fromList((buffer as FakeNativeBuffer).bytes);
  }

  @override
  void freeBuffer(NativeAnkiBuffer buffer) {
    freeCount++;
    events.add('free');
  }

  @override
  void destroy(NativeAnkiHandle handle) {
    destroyCount++;
  }
}
