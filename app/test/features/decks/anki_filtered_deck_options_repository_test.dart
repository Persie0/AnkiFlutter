import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart'
    as decks;
import 'package:anki_flutter/features/decks/data/anki_filtered_deck_options_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('new filtered deck loads zero-ID defaults and saves with ID zero',
      () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckOptionsRepository(backend: backend);
    final draft = await repository.load(0);
    expect(draft.id.toInt(), 0);
    expect(decks.DeckId.fromBuffer(backend.requests.single).did.toInt(), 0);
    draft.name = 'New filtered deck';
    draft.config.searchTerms.single.search = 'is:due';
    final newId = await repository.save(draft);
    expect(newId, 98);
    final saved = decks.FilteredDeckForUpdate.fromBuffer(backend.requests.last);
    expect(saved.id.toInt(), 0);
    expect(saved.name, 'New filtered deck');
    expect(saved.config.searchTerms.single.search, 'is:due');
  });

  test('load requests exact deck and parses scheduler default settings', () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckOptionsRepository(backend: backend);
    final loaded = await repository.load(98);
    expect(loaded.id.toInt(), 98);
    expect(loaded.config.searchTerms.single.search, 'deck:French');
    expect(backend.operations, [BackendOperation.getOrCreateFilteredDeck]);
    expect(decks.DeckId.fromBuffer(backend.requests.single).did.toInt(), 98);
  });

  test('save preserves Anki-specific settings and both original search terms',
      () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckOptionsRepository(backend: backend);
    final original = await repository.load(98);
    original.name = 'French practice';
    original.config.searchTerms.first.search = 'deck:French is:due';
    original.config.reschedule = false;
    expect(await repository.save(original), 98);

    expect(backend.operations.last, BackendOperation.addOrUpdateFilteredDeck);
    final sent = decks.FilteredDeckForUpdate.fromBuffer(backend.requests.last);
    expect(sent.id.toInt(), 98);
    expect(sent.name, 'French practice');
    expect(sent.allowEmpty, isTrue);
    expect(sent.config.reschedule, isFalse);
    expect(sent.config.previewAgainSecs, 120);
    expect(sent.config.previewGoodSecs, 600);
    expect(sent.config.searchTerms.single.search, 'deck:French is:due');
    expect(sent.config.searchTerms.single.limit, 150);
    expect(sent.config.searchTerms.single.order,
        decks.Deck_Filtered_SearchTerm_Order.RANDOM);
  });

  test('rejects invalid deck IDs, names, searches and card limits', () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckOptionsRepository(backend: backend);
    await expectLater(repository.load(0), throwsArgumentError);

    final good = await repository.load(98);
    final invalidId = good.deepCopy()..id = Int64.ZERO;
    final invalidName = good.deepCopy()..name = ' ';
    final noQueries = good.deepCopy()..config.searchTerms.clear();
    final missingQuery = good.deepCopy()
      ..config.searchTerms.single.search = ' ';
    final badLimit = good.deepCopy()
      ..config.searchTerms.single.limit = 0;
    for (final invalid in [invalidId, invalidName, noQueries, missingQuery, badLimit]) {
      await expectLater(repository.save(invalid), throwsArgumentError);
    }
    expect(backend.operations, [BackendOperation.getOrCreateFilteredDeck]);
  });

  test('rejects mismatched deck IDs returned by backend', () async {
    final backend = _Backend()..mismatched = true;
    await expectLater(
      AnkiFilteredDeckOptionsRepository(backend: backend).load(98),
      throwsStateError,
    );
  });

  test('native errors propagate and never return fabricated success', () async {
    final backend = _Backend();
    final repository = AnkiFilteredDeckOptionsRepository(backend: backend);
    final config = await repository.load(98);
    backend.fail = true;
    await expectLater(repository.save(config), throwsStateError);
  });
}

class _Backend implements BackendInvoker {
  final operations = <BackendOperation>[];
  final requests = <Uint8List>[];
  bool mismatched = false;
  bool fail = false;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    operations.add(operation);
    requests.add(request);
    if (fail) throw StateError('Native call failed');
    if (operation == BackendOperation.getOrCreateFilteredDeck) {
      return Uint8List.fromList(decks.FilteredDeckForUpdate(
        id: Int64(mismatched ? 99 :
            decks.DeckId.fromBuffer(request).did.toInt()),
        name: 'French',
        allowEmpty: true,
        config: decks.Deck_Filtered(
          reschedule: true,
          previewAgainSecs: 120,
          previewGoodSecs: 600,
          searchTerms: [
            decks.Deck_Filtered_SearchTerm(
              search: 'deck:French',
              limit: 150,
              order: decks.Deck_Filtered_SearchTerm_Order.RANDOM,
            ),
          ],
        ),
      ).writeToBuffer());
    }
    if (operation == BackendOperation.addOrUpdateFilteredDeck) {
      return Uint8List.fromList(
        collection.OpChangesWithId(id: Int64(98)).writeToBuffer(),
      );
    }
    throw UnimplementedError('$operation');
  }
}
