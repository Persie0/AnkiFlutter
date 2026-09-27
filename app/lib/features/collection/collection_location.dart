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

  static String collectionPathInProfile(
    String profileDirectory, {
    required String pathSeparator,
  }) {
    final normalizedDirectory = profileDirectory.endsWith(pathSeparator)
        ? profileDirectory.substring(
            0,
            profileDirectory.length - pathSeparator.length,
          )
        : profileDirectory;
    return '$normalizedDirectory${pathSeparator}collection.anki2';
  }

  final String collectionPath;
  final String mediaFolderPath;
  final String mediaDbPath;
}
