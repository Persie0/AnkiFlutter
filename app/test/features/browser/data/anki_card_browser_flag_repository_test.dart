import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sets an Anki card flag on unique selected card IDs', () async {
    final backend = _RecordingBackend();
    final repository = AnkiCardBrowserRepository(backend: backend);

    await repository.setCardsFlag([10, 10, 20], 3);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.setFlag);
    final request = cards.SetFlagRequest.fromBuffer(backend.calls.single.request);
    expect(request.cardIds, [Int64(10), Int64(20)]);
    expect(request.flag, 3);
  });

  test('clears selected card flags with Anki flag zero', () async {
    final backend = _RecordingBackend();

    await AnkiCardBrowserRepository(backend: backend)
        .setCardsFlag([11, 12], 0);

    final request = cards.SetFlagRequest.fromBuffer(backend.calls.single.request);
    expect(request.cardIds, [Int64(11), Int64(12)]);
    expect(request.flag, 0);
  });

  test('rejects flags outside the official 0-7 range without backend calls', () async {
    final backend = _RecordingBackend();
    final repo = AnkiCardBrowserRepository(backend: backend);

    await expectLater(repo.setCardsFlag([1], -1), throwsArgumentError);
    await expectLater(repo.setCardsFlag([1], 8), throwsArgumentError);
    await repo.setCardsFlag([], 2);

    expect(backend.calls, isEmpty);
  });

  test('propagates native backend failure instead of reporting success', () async {
    final backend = _RecordingBackend(fail: true);

    await expectLater(
      AnkiCardBrowserRepository(backend: backend).setCardsFlag([10], 1),
      throwsStateError,
    );
    expect(backend.calls.single.operation, BackendOperation.setFlag);
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _RecordingBackend implements BackendInvoker {
  _RecordingBackend({this.fail = false});
  final bool fail;
  final List<_Call> calls = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    if (fail) throw StateError('setFlag failed');
    return Uint8List(0);
  }
}
