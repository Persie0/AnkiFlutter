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

  test('rejects files that are not Anki collection databases', () async {
    final source = File('${temporaryDirectory.path}/notes.txt');
    await source.writeAsString('not a collection');
    final storage = MobileCollectionStorage(
      collectionsDirectory: Directory('${temporaryDirectory.path}/app/collections'),
    );

    await expectLater(storage.copySelectedCollection(source), throwsFormatException);
  });
  test('simultaneous imports with the same name and timestamp never clobber',
      () async {
    final firstFolder = Directory('${temporaryDirectory.path}/first');
    final secondFolder = Directory('${temporaryDirectory.path}/second');
    await firstFolder.create();
    await secondFolder.create();
    final firstSource = File('${firstFolder.path}/Same.anki2');
    final secondSource = File('${secondFolder.path}/Same.anki2');
    await firstSource.writeAsBytes([1, 2, 3]);
    await secondSource.writeAsBytes([9, 8, 7]);
    await File('${firstFolder.path}/Same.media/a.wav').create(recursive: true);
    await File('${secondFolder.path}/Same.media/a.wav').create(recursive: true);
    await File('${firstFolder.path}/Same.media/a.wav').writeAsBytes([1]);
    await File('${secondFolder.path}/Same.media/a.wav').writeAsBytes([9]);

    final destination = Directory('${temporaryDirectory.path}/destination');
    MobileCollectionStorage store() => MobileCollectionStorage(
      collectionsDirectory: destination,
      timestampMicros: () => 555,
    );
    final outcomes = await Future.wait<Object>([
      store().copySelectedCollection(firstSource).then<Object>((value) => value,
          onError: (Object error) => error),
      store().copySelectedCollection(secondSource).then<Object>((value) => value,
          onError: (Object error) => error),
    ]);
    expect(outcomes.whereType<String>(), hasLength(1));
    expect(outcomes.whereType<StateError>(), hasLength(1));
    final winnerBytes = outcomes[0] is String ? [1, 2, 3] : [9, 8, 7];
    final winnerMedia = outcomes[0] is String ? [1] : [9];
    expect(await File('${destination.path}/Same_555.anki2').readAsBytes(),
        winnerBytes);
    expect(await File('${destination.path}/Same_555.media/a.wav').readAsBytes(),
        winnerMedia);
    expect(destination.listSync().where((entry) =>
        entry.path.contains('.anki-import-')), isEmpty);
  });

  test('linked media is rejected instead of silently losing attachments',
      () async {
    final sourceDirectory = Directory('${temporaryDirectory.path}/source');
    await sourceDirectory.create();
    final source = File('${sourceDirectory.path}/Linked.anki2');
    await source.writeAsBytes([3, 4, 5]);
    final media = Directory('${sourceDirectory.path}/Linked.media');
    await media.create();
    final actual = File('${temporaryDirectory.path}/outside.wav');
    await actual.writeAsBytes([8, 8]);
    await Link('${media.path}/linked.wav').create(actual.path);
    final destination = Directory('${temporaryDirectory.path}/collections');
    final storage = MobileCollectionStorage(
      collectionsDirectory: destination,
      timestampMicros: () => 777,
    );
    await expectLater(storage.copySelectedCollection(source),
        throwsA(isA<FileSystemException>()));
    expect(await actual.readAsBytes(), [8, 8]);
    expect(await source.readAsBytes(), [3, 4, 5]);
    expect(destination.listSync(), isEmpty);
  }, skip: Platform.isWindows);

}
