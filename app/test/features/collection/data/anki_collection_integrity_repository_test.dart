import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/features/collection/data/anki_collection_integrity_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses upstream collection check and returns immutable problem list', () async {
    final backend = _Backend();
    final result = await AnkiCollectionIntegrityRepository(
      backend: backend,
    ).checkDatabase();
    expect(result, ['Invalid card scheduling', 'Orphan note']);
    expect(() => result.add('untrusted'), throwsUnsupportedError);
    expect(backend.operations, [BackendOperation.checkDatabase]);
    expect(generic.Empty.fromBuffer(backend.requests.single), isA<generic.Empty>());
  });

  test('empty upstream report is not confused with a failed check', () async {
    final backend = _Backend()..problems = [];
    final result = await AnkiCollectionIntegrityRepository(
      backend: backend,
    ).checkDatabase();
    expect(result, isEmpty);
    expect(backend.operations, [BackendOperation.checkDatabase]);
  });

  test('native errors are propagated rather than falsely reporting health',
      () async {
    final backend = _Backend()..fail = true;
    await expectLater(
      AnkiCollectionIntegrityRepository(backend: backend).checkDatabase(),
      throwsStateError,
    );
    expect(backend.operations, [BackendOperation.checkDatabase]);
  });
}

class _Backend implements BackendInvoker {
  List<String> problems = ['Invalid card scheduling', 'Orphan note'];
  bool fail = false;
  final operations = <BackendOperation>[];
  final requests = <Uint8List>[];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    operations.add(operation);
    requests.add(request);
    if (fail) throw StateError('native database checker failed');
    return Uint8List.fromList(
      collection.CheckDatabaseResponse(problems: problems).writeToBuffer(),
    );
  }
}
