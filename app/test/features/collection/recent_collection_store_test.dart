import 'dart:io';

import 'package:anki_flutter/features/collection/recent_collection_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory tempDirectory;

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp(
      'anki_flutter_recents_test_',
    );
  });

  tearDown(() async {
    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  test(
    'remembers recent collections newest first and keeps unique paths',
    () async {
      final store = FileRecentCollectionStore(
        file: File('${tempDirectory.path}/recent.json'),
        maxEntries: 3,
      );

      await store.remember('/collections/first.anki2');
      await store.remember('/collections/second.anki2');
      await store.remember('/collections/third.anki2');
      await store.remember('/collections/first.anki2');

      expect(await store.load(), [
        '/collections/first.anki2',
        '/collections/third.anki2',
        '/collections/second.anki2',
      ]);
    },
  );

  test('remember and forget preserve corrupted recent collections', () async {
    final file = File('${tempDirectory.path}/recent.json');
    await file.writeAsString('{broken');
    final store = FileRecentCollectionStore(file: file);
    expect(await store.load(), isEmpty);
    await expectLater(store.remember('/new.anki2'), throwsStateError);
    await expectLater(store.forget('/old.anki2'), throwsStateError);
    expect(await file.readAsString(), '{broken');
  });

  test('invalid or future-format registry cannot be overwritten', () async {
    final file = File('${tempDirectory.path}/recent.json');
    final store = FileRecentCollectionStore(file: file);
    for (final original in [
      '{"version":2,"paths":["/future.anki2"]}',
      '["/valid.anki2", 42]',
      '[""]',
    ]) {
      await file.writeAsString(original);
      await expectLater(store.remember('/new.anki2'), throwsStateError);
      expect(await file.readAsString(), original);
    }
  });

  test('ignores malformed data and can forget a recent collection', () async {
    final file = File('${tempDirectory.path}/recent.json');
    await file.writeAsString('{not-json');
    final store = FileRecentCollectionStore(file: file);

    expect(await store.load(), isEmpty);
    await expectLater(
      store.remember('/collections/old.anki2'),
      throwsStateError,
    );
    await file.delete();
    await store.remember('/collections/old.anki2');
    await store.forget('/collections/old.anki2');

    expect(await store.load(), isEmpty);
  });
}
