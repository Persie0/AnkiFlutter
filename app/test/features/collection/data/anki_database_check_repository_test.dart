import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as anki_collection;
import 'package:anki_flutter/features/collection/data/anki_database_check_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses native collection database check and returns exact Anki messages',
      () async {
    final backend = _Backend(
      messages: ['Orphaned cards corrected', 'Collection optimized'],
    );
    final result = await AnkiDatabaseCheckRepository(backend: backend)
        .checkDatabase();
    expect(result, ['Orphaned cards corrected', 'Collection optimized']);
    expect(backend.calls, [BackendOperation.checkDatabase]);
    expect(backend.requests.single, isEmpty);
    expect(() => result.add('fabricated'), throwsUnsupportedError);
  });

  test('empty native message list signals no reported issues', () async {
    final backend = _Backend(messages: []);
    expect(
      await AnkiDatabaseCheckRepository(backend: backend).checkDatabase(),
      isEmpty,
    );
  });

  test('upstream Anki failure propagates without claiming a clean collection',
      () async {
    final backend = _Backend(messages: [])..fail = true;
    await expectLater(
      AnkiDatabaseCheckRepository(backend: backend).checkDatabase(),
      throwsStateError,
    );
    expect(backend.calls, [BackendOperation.checkDatabase]);
  });
}

class _Backend implements BackendInvoker {
  _Backend({required this.messages});
  final List<String> messages;
  bool fail = false;
  final calls = <BackendOperation>[];
  final requests = <Uint8List>[];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(operation);
    requests.add(request);
    if (fail) throw StateError('native check failed');
    return Uint8List.fromList(
      anki_collection.CheckDatabaseResponse(problems: messages).writeToBuffer(),
    );
  }
}
