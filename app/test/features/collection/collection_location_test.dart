import 'package:anki_flutter/features/collection/collection_location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('derives Anki media paths from lowercase collection extension', () {
    final location = CollectionLocation.fromCollectionPath(
      '/tmp/collection.anki2',
    );

    expect(location.collectionPath, '/tmp/collection.anki2');
    expect(location.mediaFolderPath, '/tmp/collection.media');
    expect(location.mediaDbPath, '/tmp/collection.media.db2');
  });

  test('derives Anki media paths case-insensitively', () {
    final location = CollectionLocation.fromCollectionPath(
      '/tmp/COLLECTION.ANKI2',
    );

    expect(location.collectionPath, '/tmp/COLLECTION.ANKI2');
    expect(location.mediaFolderPath, '/tmp/COLLECTION.media');
    expect(location.mediaDbPath, '/tmp/COLLECTION.media.db2');
  });
}
