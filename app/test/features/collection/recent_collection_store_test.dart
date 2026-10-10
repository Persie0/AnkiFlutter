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

  test('ignores malformed data and can forget a recent collection', () async {
    final file = File('${tempDirectory.path}/recent.json');
    await file.writeAsString('{not-json');
    final store = FileRecentCollectionStore(file: file);

    expect(await store.load(), isEmpty);
    await store.remember('/collections/old.anki2');
    await store.forget('/collections/old.anki2');

    expect(await store.load(), isEmpty);
  });
  test('concurrent store instances preserve ordered recent changes', () async {
    final file = File('${tempDirectory.path}/parallel.json');
    final first = FileRecentCollectionStore(file: file, maxEntries: 12);
    final second = FileRecentCollectionStore(file: file, maxEntries: 12);
    await Future.wait([
      first.remember('/collections/first.anki2'),
      second.remember('/collections/second.anki2'),
      first.remember('/collections/third.anki2'),
      second.forget('/collections/first.anki2'),
    ]);
    expect(await first.load(), [
      '/collections/third.anki2',
      '/collections/second.anki2',
    ]);
  });

}
