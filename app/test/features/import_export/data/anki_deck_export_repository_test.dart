import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lists nested normal decks as export targets, omitting filtered decks', () async {
    final backend = _Backend([
      decks.DeckTreeNode(children: [
        decks.DeckTreeNode(deckId: Int64(1), name: 'Default'),
        decks.DeckTreeNode(
          deckId: Int64(2),
          name: 'Languages',
          children: [
            decks.DeckTreeNode(deckId: Int64(3), name: 'French'),
          ],
        ),
        decks.DeckTreeNode(
          deckId: Int64(4),
          name: 'Filtered',
          filtered: true,
          children: [decks.DeckTreeNode(deckId: Int64(5), name: 'Hidden')],
        ),
      ]).writeToBuffer(),
    ]);

    final result = await AnkiPackageRepository(backend: backend).exportDeckTargets();

    expect(result.map((deck) => deck.id), [1, 2, 3]);
    expect(result.map((deck) => deck.name), [
      'Default',
      'Languages',
      'Languages::French',
    ]);
    expect(backend.calls.single.operation, BackendOperation.deckTree);
    expect(decks.DeckTreeRequest.fromBuffer(backend.calls.single.request).now.toInt(), 0);
  });

  test('exports chosen deck with official Anki ExportLimit.deckId', () async {
    final backend = _Backend([generic.UInt32(val: 11).writeToBuffer()]);
    final repository = AnkiPackageRepository(backend: backend);

    final mediaCount = await repository.exportDeckPackage(
      '/tmp/french.apkg',
      deckId: 3,
      withScheduling: false,
      withDeckConfigs: true,
      withMedia: true,
      legacy: false,
    );

    expect(mediaCount, 11);
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.exportAnkiPackage);
    final request = import_export.ExportAnkiPackageRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.outPath, '/tmp/french.apkg');
    expect(request.limit.hasDeckId(), isTrue);
    expect(request.limit.hasWholeCollection(), isFalse);
    expect(request.limit.deckId, Int64(3));
    expect(request.options.withScheduling, isFalse);
    expect(request.options.withDeckConfigs, isTrue);
    expect(request.options.withMedia, isTrue);
    expect(request.options.legacy, isFalse);
  });

  test('rejects invalid deck and output paths without invoking backend', () async {
    final backend = _Backend([]);
    final repository = AnkiPackageRepository(backend: backend);

    await expectLater(
      repository.exportDeckPackage('/tmp/a.apkg', deckId: 0, withScheduling: true,
          withDeckConfigs: true, withMedia: true, legacy: false),
      throwsArgumentError,
    );
    await expectLater(
      repository.exportDeckPackage('  ', deckId: 1, withScheduling: true,
          withDeckConfigs: true, withMedia: true, legacy: false),
      throwsArgumentError,
    );
    expect(backend.calls, isEmpty);
  });

  test('propagates export failures without claiming a saved package', () async {
    final backend = _Backend([], fail: true);
    await expectLater(
      AnkiPackageRepository(backend: backend).exportDeckPackage(
        '/tmp/a.apkg', deckId: 1, withScheduling: true,
        withDeckConfigs: true, withMedia: true, legacy: false,
      ),
      throwsStateError,
    );
    expect(backend.calls.single.operation, BackendOperation.exportAnkiPackage);
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.responses, {this.fail = false});
  final List<Uint8List> responses;
  final bool fail;
  final List<_Call> calls = [];
  var _index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    if (fail) throw StateError('Anki export failed');
    return responses[_index++];
  }
}
