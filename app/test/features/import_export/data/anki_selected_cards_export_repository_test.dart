import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart' as packages;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exports exactly the distinct selected card IDs through Anki', () async {
    final backend = _Backend([generic.UInt32(val: 3).writeToBuffer()]);
    final repository = AnkiPackageRepository(backend: backend);

    final media = await repository.exportSelectedCards(
      '/tmp/selection.apkg',
      cardIds: [12, 12, 25, 39],
      withScheduling: false,
      withMedia: true,
    );

    expect(media, 3);
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.exportAnkiPackage);
    final request = packages.ExportAnkiPackageRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.outPath, '/tmp/selection.apkg');
    expect(request.limit.hasCardIds(), isTrue);
    expect(request.limit.cardIds.cids, [Int64(12), Int64(25), Int64(39)]);
    expect(request.limit.hasDeckId(), isFalse);
    expect(request.limit.hasWholeCollection(), isFalse);
    expect(request.options.withScheduling, isFalse);
    expect(request.options.withMedia, isTrue);
    expect(request.options.withDeckConfigs, isTrue);
    expect(request.options.legacy, isFalse);
  });

  test('rejects missing or nonpositive card IDs without a backend call', () async {
    final backend = _Backend([]);
    final repository = AnkiPackageRepository(backend: backend);

    await expectLater(
      repository.exportSelectedCards('/tmp/a.apkg', cardIds: [],
          withScheduling: true, withMedia: false),
      throwsArgumentError,
    );
    await expectLater(
      repository.exportSelectedCards('/tmp/a.apkg', cardIds: [1, 0],
          withScheduling: true, withMedia: false),
      throwsArgumentError,
    );
    await expectLater(
      repository.exportSelectedCards('  ', cardIds: [1],
          withScheduling: true, withMedia: false),
      throwsArgumentError,
    );
    expect(backend.calls, isEmpty);
  });

  test('preserves native export errors for the save workflow', () async {
    final backend = _Backend([], fail: true);
    await expectLater(
      AnkiPackageRepository(backend: backend).exportSelectedCards(
        '/tmp/a.apkg', cardIds: [22],
        withScheduling: true, withMedia: false,
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
  final calls = <_Call>[];
  var index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    if (fail) throw StateError('native export failed');
    return responses[index++];
  }
}
