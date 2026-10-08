import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/tags.pb.dart'
    as tags;
import 'package:anki_flutter/features/tags/data/anki_tag_manager_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lists original native tag spellings without changing their names', () async {
    final backend = _Backend();
    final manager = AnkiTagManagerRepository(backend: backend);
    expect(await manager.allTags(), ['French', 'French::verbs', 'Exam']);
    expect(backend.operations.single, BackendOperation.allTags);
    expect(generic.Empty.fromBuffer(backend.requests.single), isA<generic.Empty>());
  });

  test('rename delegates exact tag prefixes to native Anki', () async {
    final backend = _Backend();
    final manager = AnkiTagManagerRepository(backend: backend);
    expect(await manager.rename('French', 'Languages::French'), 3);
    expect(backend.operations, [BackendOperation.tagManagerRenameTags]);
    final request = tags.RenameTagsRequest.fromBuffer(backend.requests.single);
    expect(request.currentPrefix, 'French');
    expect(request.newPrefix, 'Languages::French');
  });

  test('removing a tag never calls remove notes/cards', () async {
    final backend = _Backend();
    final manager = AnkiTagManagerRepository(backend: backend);
    expect(await manager.remove('Exam'), 3);
    expect(backend.operations, [BackendOperation.tagManagerRemoveTags]);
    expect(generic.String.fromBuffer(backend.requests.single).val, 'Exam');
  });

  test('unused tag cleanup passes native empty protobuf', () async {
    final backend = _Backend();
    final manager = AnkiTagManagerRepository(backend: backend);
    expect(await manager.clearUnused(), 3);
    expect(backend.operations, [BackendOperation.tagManagerClearUnusedTags]);
    expect(generic.Empty.fromBuffer(backend.requests.single), isA<generic.Empty>());
  });

  test('invalid names and case-only rename do not invoke native operations',
      () async {
    final backend = _Backend();
    final manager = AnkiTagManagerRepository(backend: backend);
    for (final invalid in ['', '  ', 'two words', '::head', 'tail::',
      'a::::b']) {
      await expectLater(manager.remove(invalid), throwsArgumentError);
    }
    await expectLater(manager.rename('French', 'french'), throwsArgumentError);
    await expectLater(manager.rename('', 'OK'), throwsArgumentError);
    expect(backend.operations, isEmpty);
  });

  test('native failures propagate without fabricated changes', () async {
    final backend = _Backend()..fail = true;
    final manager = AnkiTagManagerRepository(backend: backend);
    await expectLater(manager.rename('One', 'Two'), throwsStateError);
    await expectLater(manager.remove('Two'), throwsStateError);
    await expectLater(manager.clearUnused(), throwsStateError);
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
    if (fail) throw StateError('Native call failed');
    if (operation == BackendOperation.allTags) {
      return Uint8List.fromList(
        generic.StringList(vals: ['French', 'French::verbs', 'Exam'])
            .writeToBuffer(),
      );
    }
    return Uint8List.fromList(
      collection.OpChangesWithCount(count: 3).writeToBuffer(),
    );
  }
}
