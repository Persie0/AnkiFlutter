class CollectionLocation {
  const CollectionLocation({
    required this.collectionPath,
    required this.mediaFolderPath,
    required this.mediaDbPath,
  });

  factory CollectionLocation.fromCollectionPath(String collectionPath) {
    final mediaFolderPath = collectionPath.replaceFirst(
      RegExp(r'\.anki2$', caseSensitive: false),
      '.media',
    );
    return CollectionLocation(
      collectionPath: collectionPath,
      mediaFolderPath: mediaFolderPath,
      mediaDbPath: '$mediaFolderPath.db2',
    );
  }

  final String collectionPath;
  final String mediaFolderPath;
  final String mediaDbPath;
}
