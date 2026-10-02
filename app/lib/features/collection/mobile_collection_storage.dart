import 'dart:io';

import 'package:anki_flutter/features/collection/collection_location.dart';

class ApplicationDataPaths {
  static Directory get applicationSupportDirectory {
    final separator = Platform.pathSeparator;
    final environment = Platform.environment;
    final home = environment['HOME'] ?? Directory.systemTemp.path;

    if (Platform.isWindows) {
      final appData = environment['APPDATA'] ?? '$home${separator}AppData${separator}Roaming';
      return Directory('$appData${separator}AnkiFlutter');
    }
    if (Platform.isMacOS) {
      return Directory(
        '$home${separator}Library${separator}Application Support'
        '${separator}AnkiFlutter',
      );
    }
    if (Platform.isLinux) {
      final data =
          environment['XDG_DATA_HOME'] ?? '$home${separator}.local${separator}share';
      return Directory('$data${separator}ankiflutter');
    }

    final appRoot = Directory.systemTemp.parent.path;
    final appSupport = Platform.isIOS
        ? 'Library${separator}Application Support'
        : 'files';
    return Directory(
      '$appRoot${separator}$appSupport${separator}AnkiFlutter',
    );
  }

  static Directory get collectionsDirectory => Directory(
    '${applicationSupportDirectory.path}${Platform.pathSeparator}collections',
  );

  static Directory get profilesDirectory => Directory(
    '${applicationSupportDirectory.path}${Platform.pathSeparator}profiles',
  );

  static File get profileRegistryFile => File(
    '${applicationSupportDirectory.path}${Platform.pathSeparator}'
    'profiles.json',
  );

  static File get recentCollectionsFile => File(
    '${applicationSupportDirectory.path}${Platform.pathSeparator}'
    'recent-collections.json',
  );
}

/// Copies mobile file-picker selections into app storage before Anki opens them.
class MobileCollectionStorage {
  MobileCollectionStorage({
    required this.collectionsDirectory,
    int Function()? timestampMicros,
  }) : _timestampMicros =
           timestampMicros ?? (() => DateTime.now().microsecondsSinceEpoch);

  final Directory collectionsDirectory;
  final int Function() _timestampMicros;

  Future<String> copySelectedCollection(File source) async {
    if (!RegExp(r'\.anki2$', caseSensitive: false).hasMatch(source.path)) {
      throw FormatException('Select an Anki .anki2 collection file.');
    }
    if (!await source.exists()) {
      throw FileSystemException('The selected collection could not be read.', source.path);
    }

    final basename = source.path.split(RegExp(r'[/\\]')).last;
    final name = basename.replaceFirst(RegExp(r'\.anki2$', caseSensitive: false), '');
    final destinationPath =
        '${collectionsDirectory.path}${Platform.pathSeparator}'
        '${name}_${_timestampMicros()}.anki2';
    final destination = File(destinationPath);
    await collectionsDirectory.create(recursive: true);
    await source.copy(destinationPath);

    final sourceLocation = CollectionLocation.fromCollectionPath(source.path);
    final destinationLocation = CollectionLocation.fromCollectionPath(
      destinationPath,
    );
    await _copyFileIfPresent(
      sourceLocation.mediaDbPath,
      destinationLocation.mediaDbPath,
    );
    await _copyDirectoryIfPresent(
      Directory(sourceLocation.mediaFolderPath),
      Directory(destinationLocation.mediaFolderPath),
    );
    return destination.path;
  }

  Future<void> _copyFileIfPresent(String source, String destination) async {
    final file = File(source);
    if (await file.exists()) {
      await file.copy(destination);
    }
  }

  Future<void> _copyDirectoryIfPresent(
    Directory source,
    Directory destination,
  ) async {
    if (!await source.exists()) {
      return;
    }
    await destination.create(recursive: true);
    await for (final entity in source.list(followLinks: false)) {
      final name = entity.path.split(RegExp(r'[/\\]')).last;
      final childPath = '${destination.path}${Platform.pathSeparator}$name';
      if (entity is File) {
        await entity.copy(childPath);
      } else if (entity is Directory) {
        await _copyDirectoryIfPresent(entity, Directory(childPath));
      }
    }
  }
}
