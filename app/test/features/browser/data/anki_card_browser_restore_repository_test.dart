import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('restores distinct selected IDs with native Anki CardIds payload', () async {
    final backend = _Backend();
    await AnkiCardBrowserRepository(backend: backend)
        .restoreCards([11, 11, 22, 33]);
    expect(backend.calls, hasLength(1));
    expect(
      backend.calls.single.operation,
      BackendOperation.restoreBuriedAndSuspendedCards,
    );
    final request = cards.CardIds.fromBuffer(backend.calls.single.payload);
    expect(request.cids, [Int64(11), Int64(22), Int64(33)]);
  });

  test('rejects non-positive card IDs before invoking backend', () async {
    final backend = _Backend();
    final repository = AnkiCardBrowserRepository(backend: backend);
    await repository.restoreCards([]);
    await expectLater(repository.restoreCards([-1, 5]), throwsArgumentError);
    await expectLater(repository.restoreCards([0]), throwsArgumentError);
    expect(backend.calls, isEmpty);
  });

  test('propagates native scheduler errors for browser failure handling', () async {
    final backend = _Backend()..fail = true;
    await expectLater(
      AnkiCardBrowserRepository(backend: backend).restoreCards([123]),
      throwsStateError,
    );
    expect(backend.calls.single.operation,
        BackendOperation.restoreBuriedAndSuspendedCards);
  });
}

class _Call {
  const _Call(this.operation, this.payload);
  final BackendOperation operation;
  final Uint8List payload;
}

class _Backend implements BackendInvoker {
  bool fail = false;
  final calls = <_Call>[];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    if (fail) throw StateError('Anki restore failed');
    return Uint8List(0);
  }
}
