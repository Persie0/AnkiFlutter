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

  test('rejects files that are not Anki collection databases', () async {
    final source = File('${temporaryDirectory.path}/notes.txt');
    await source.writeAsString('not a collection');
    final storage = MobileCollectionStorage(
      collectionsDirectory: Directory('${temporaryDirectory.path}/app/collections'),
    );

    await expectLater(storage.copySelectedCollection(source), throwsFormatException);
  });
}
