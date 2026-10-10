import 'dart:io';

import 'package:anki_flutter/features/collection/mobile_collection_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'anki_flutter_mobile_collection_test_',
    );
  });

  tearDown(() async {
    if (await temporaryDirectory.exists()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('copies a collection and available media into durable app storage', () async {
    final sourceDirectory = Directory('${temporaryDirectory.path}/picker');
    await sourceDirectory.create();
    final source = File('${sourceDirectory.path}/French.anki2');
    await source.writeAsBytes([1, 2, 3]);
    await File('${sourceDirectory.path}/French.media.db2').writeAsBytes([4, 5]);
    await File('${sourceDirectory.path}/French.media/card.mp3').create(
      recursive: true,
    );
    await File('${sourceDirectory.path}/French.media/card.mp3').writeAsBytes([
      6,
      7,
    ]);

    final storage = MobileCollectionStorage(
      collectionsDirectory: Directory('${temporaryDirectory.path}/app/collections'),
      timestampMicros: () => 123,
    );

    final copiedPath = await storage.copySelectedCollection(source);

    expect(copiedPath, endsWith('French_123.anki2'));
    expect(await File(copiedPath).readAsBytes(), [1, 2, 3]);
    expect(await File('${temporaryDirectory.path}/app/collections/French_123.media.db2').readAsBytes(), [4, 5]);
    expect(await File('${temporaryDirectory.path}/app/collections/French_123.media/card.mp3').readAsBytes(), [6, 7]);
  });

  test('existing import destination is never overwritten', () async {
    final sourceDir = Directory('${temporaryDirectory.path}/source');
    await sourceDir.create();
    final source = File('${sourceDir.path}/Existing.anki2');
    await source.writeAsBytes([1, 2, 3]);

    final destination = Directory('${temporaryDirectory.path}/collections');
    await destination.create();
    final original = File('${destination.path}/Existing_123.anki2');
    await original.writeAsBytes([9, 9, 9]);
    final storage = MobileCollectionStorage(
      collectionsDirectory: destination,
      timestampMicros: () => 123,
    );
    await expectLater(
      storage.copySelectedCollection(source),
      throwsStateError,
    );
    expect(await original.readAsBytes(), [9, 9, 9]);
    expect(
      destination.listSync().where(
        (entity) => entity.path.contains('.anki-import-'),
      ),
      isEmpty,
    );
  });

  test('existing companion media is preserved if collection is missing', () async {
    final sourceDir = Directory('${temporaryDirectory.path}/source');
    await sourceDir.create();
    final source = File('${sourceDir.path}/French.anki2');
    await source.writeAsBytes([1, 2, 3]);

    final destination = Directory('${temporaryDirectory.path}/collections');
    await destination.create();
    final existingMedia = File('${destination.path}/French_123.media.db2');
    await existingMedia.writeAsBytes([4, 5, 6]);
    final storage = MobileCollectionStorage(
      collectionsDirectory: destination,
      timestampMicros: () => 123,
    );
    await expectLater(
      storage.copySelectedCollection(source),
      throwsStateError,
    );
    expect(await existingMedia.readAsBytes(), [4, 5, 6]);
    expect(File('${destination.path}/French_123.anki2').existsSync(), isFalse);
    expect(destination.listSync(), hasLength(1));
  });

  test('successful copy commits collection last with no temporary files', () async {
    final sourceDir = Directory('${temporaryDirectory.path}/source');
    await sourceDir.create();
    final source = File('${sourceDir.path}/German.anki2');
    await source.writeAsBytes([1]);
    await File('${sourceDir.path}/German.media/pictures/one.png')
        .create(recursive: true);
    await File('${sourceDir.path}/German.media/pictures/one.png')
        .writeAsBytes([4, 5]);
    final destination = Directory('${temporaryDirectory.path}/collections');
    final storage = MobileCollectionStorage(
      collectionsDirectory: destination,
      timestampMicros: () => 321,
    );

    final result = await storage.copySelectedCollection(source);
    expect(await File(result).readAsBytes(), [1]);
    expect(
      await File('${destination.path}/German_321.media/pictures/one.png')
          .readAsBytes(),
      [4, 5],
    );
    expect(
      destination.listSync().where(
        (entity) => entity.path.contains('.anki-import-'),
      ),
      isEmpty,
    );
  });

  test('rejects a nonempty SQLite WAL without leaving an import', () async {
    final source = File('${temporaryDirectory.path}/French.anki2');
    await source.writeAsBytes([1, 2, 3]);
    final wal = File('${source.path}-wal');
    await wal.writeAsBytes([4, 5, 6]);
    final destination = Directory('${temporaryDirectory.path}/collections');
    final storage = MobileCollectionStorage(
      collectionsDirectory: destination,
      timestampMicros: () => 42,
    );

    await expectLater(
      storage.copySelectedCollection(source),
      throwsA(isA<StateError>().having(
        (error) => error.message,
        'message',
        contains('active SQLite journal'),
      )),
    );
    expect(File('${destination.path}/French_42.anki2').existsSync(), isFalse);
    expect(await wal.readAsBytes(), [4, 5, 6]);
    if (await destination.exists()) {
      expect(destination.listSync(), isEmpty);
    }
  });

  test('rejects nonempty rollback journals without modifying source', () async {
    final source = File('${temporaryDirectory.path}/Test.anki2');
    await source.writeAsBytes([9, 8, 7]);
    await File('${source.path}-journal').writeAsBytes([1]);
    final destination = Directory('${temporaryDirectory.path}/collections');
    final storage = MobileCollectionStorage(
      collectionsDirectory: destination,
    );

    await expectLater(
      storage.copySelectedCollection(source),
      throwsStateError,
    );
    expect(await source.readAsBytes(), [9, 8, 7]);
    if (await destination.exists()) {
      expect(destination.listSync(), isEmpty);
    }
  });

  test('allows empty residual SQLite WAL alongside a closed database',
      () async {
    final source = File('${temporaryDirectory.path}/Closed.anki2');
    await source.writeAsBytes([3, 2, 1]);
    await File('${source.path}-wal').writeAsBytes([]);
    final destination = Directory('${temporaryDirectory.path}/collections');
    final storage = MobileCollectionStorage(
      collectionsDirectory: destination,
      timestampMicros: () => 77,
    );

    final imported = await storage.copySelectedCollection(source);
    expect(await File(imported).readAsBytes(), [3, 2, 1]);
    expect(File('${destination.path}/Closed_77.anki2').existsSync(), isTrue);
  });

  test('rejects files that are not Anki collection databases', () async {
    final source = File('${temporaryDirectory.path}/notes.txt');
    await source.writeAsString('not a collection');
    final storage = MobileCollectionStorage(
      collectionsDirectory: Directory('${temporaryDirectory.path}/app/collections'),
    );

    await expectLater(storage.copySelectedCollection(source), throwsFormatException);
  });
}
