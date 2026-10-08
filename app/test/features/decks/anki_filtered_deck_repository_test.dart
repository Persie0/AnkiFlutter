import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart'
    as decks;
import 'package:anki_flutter/features/decks/data/anki_filtered_deck_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rebuild uses native scheduler and returns gathered card count', () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckRepository(backend: backend);

    expect(await repository.rebuild(12345), 17);
    expect(backend.operations, [BackendOperation.rebuildFilteredDeck]);
    expect(decks.DeckId.fromBuffer(backend.requests.single).did.toInt(), 12345);
  });

  test('empty uses native scheduler with exact deck ID', () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckRepository(backend: backend);

    await repository.empty(42);
    expect(backend.operations, [BackendOperation.emptyFilteredDeck]);
    expect(decks.DeckId.fromBuffer(backend.requests.single).did.toInt(), 42);
  });

  test('invalid deck ID never invokes backend', () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckRepository(backend: backend);

    await expectLater(repository.rebuild(0), throwsArgumentError);
    await expectLater(repository.empty(-1), throwsArgumentError);
    expect(backend.operations, isEmpty);
  });

  test('native operation errors are propagated without fabricated success', () async {
    final backend = _Backend()..fail = true;
    final repository = AnkiFilteredDeckRepository(backend: backend);

    await expectLater(repository.rebuild(42), throwsStateError);
    await expectLater(repository.empty(42), throwsStateError);
    expect(backend.operations, [
      BackendOperation.rebuildFilteredDeck,
      BackendOperation.emptyFilteredDeck,
    ]);
  });
}

class _Backend implements BackendInvoker {
  final operations = <BackendOperation>[];
  final requests = <Uint8List>[];
  bool fail = false;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    operations.add(operation);
    requests.add(request);
    if (fail) throw StateError('native error');
    return switch (operation) {
      BackendOperation.rebuildFilteredDeck => Uint8List.fromList(
        collection.OpChangesWithCount(count: 17).writeToBuffer(),
      ),
      _ => Uint8List.fromList(collection.OpChanges().writeToBuffer()),
    };
  }
}
