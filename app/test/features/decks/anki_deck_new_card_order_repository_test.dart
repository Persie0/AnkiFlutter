import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler;
import 'package:anki_flutter/features/decks/data/anki_deck_new_card_order_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sorts new cards natively with exactly the requested deck and mode',
      () async {
    final backend = _Backend();
    final repository = AnkiDeckNewCardOrderRepository(backend: backend);

    expect(await repository.reorder(1234, randomize: true), 19);
    expect(await repository.reorder(1234, randomize: false), 19);
    expect(backend.operations, [
      BackendOperation.sortDeck,
      BackendOperation.sortDeck,
    ]);
    final shuffled = scheduler.SortDeckRequest.fromBuffer(backend.requests[0]);
    final ordered = scheduler.SortDeckRequest.fromBuffer(backend.requests[1]);
    expect(shuffled.deckId.toInt(), 1234);
    expect(shuffled.randomize, isTrue);
    expect(ordered.deckId.toInt(), 1234);
    expect(ordered.randomize, isFalse);
  });

  test('rejects invalid deck IDs without touching native scheduling', () async {
    final backend = _Backend();
    final repository = AnkiDeckNewCardOrderRepository(backend: backend);
    await expectLater(repository.reorder(0, randomize: true), throwsArgumentError);
    await expectLater(repository.reorder(-1, randomize: false), throwsArgumentError);
    expect(backend.operations, isEmpty);
  });

  test('native scheduler errors propagate', () async {
    final backend = _Backend()..fail = true;
    await expectLater(
      AnkiDeckNewCardOrderRepository(backend: backend)
          .reorder(7, randomize: true),
      throwsStateError,
    );
  });
}

class _Backend implements BackendInvoker {
  final operations = <BackendOperation>[];
  final requests = <Uint8List>[];
  bool fail = false;

  @override
  Future<Uint8List> invoke(BackendOperation op, Uint8List request) async {
    operations.add(op);
    requests.add(request);
    if (fail) throw StateError('native sorting failed');
    return Uint8List.fromList(
      collection.OpChangesWithCount(count: 19).writeToBuffer(),
    );
  }
}
