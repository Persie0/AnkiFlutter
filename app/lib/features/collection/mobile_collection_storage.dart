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
          environment['XDG_DATA_HOME'] ?? '$home$separator.local${separator}share';
      return Directory('$data${separator}ankiflutter');
    }

    final appRoot = Directory.systemTemp.parent.path;
    final appSupport = Platform.isIOS
        ? 'Library${separator}Application Support'
        : 'files';
    return Directory(
      '$appRoot$separator$appSupport${separator}AnkiFlutter',
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
      throw FileSystemException(
        'The selected collection could not be read.',
        source.path,
      );
    }

    await _rejectActiveSqliteJournal(source);
    final sourceStat = await source.stat();
    final basename = source.path.split(RegExp(r'[/\\]')).last;
    final name = basename.replaceFirst(
      RegExp(r'\.anki2$', caseSensitive: false),
      '',
    );
    final stem = '${name}_${_timestampMicros()}';
    final destinationPath =
        '${collectionsDirectory.path}${Platform.pathSeparator}$stem.anki2';
    final destinationLocation = CollectionLocation.fromCollectionPath(
      destinationPath,
    );
    final sourceLocation = CollectionLocation.fromCollectionPath(source.path);

    await collectionsDirectory.create(recursive: true);

    // Never replace another previously imported collection or its media.
    if (await File(destinationPath).exists() ||
        await File(destinationLocation.mediaDbPath).exists() ||
        await Directory(destinationLocation.mediaFolderPath).exists()) {
      throw StateError('Collection import destination already exists.');
    }

    // Stage all three parts on the destination filesystem. The collection
    // filename is made visible only after its companion media was copied.
    // On any failure, delete only files created by this import.
    final staging = await collectionsDirectory.createTemp('.anki-import-');
    final separator = Platform.pathSeparator;
    final stagedCollection = File('${staging.path}$separator$stem.anki2');
    final stagedMediaDb = File('${staging.path}$separator$stem.media.db2');
    final stagedMediaDir = Directory('${staging.path}$separator$stem.media');
    var promotedMediaDb = false;
    var promotedMediaDirectory = false;
    var promotedCollection = false;

    try {
      await source.copy(stagedCollection.path);
      await _copyFileIfPresent(sourceLocation.mediaDbPath, stagedMediaDb.path);
      await _copyDirectoryIfPresent(
        Directory(sourceLocation.mediaFolderPath),
        stagedMediaDir,
      );

      // Anki uses SQLite WAL mode. A raw .anki2 copy taken while changes
      // remain in a WAL/journal omits data, even when the copy succeeded.
      await _rejectActiveSqliteJournal(source);
      final currentStat = await source.stat();
      if (currentStat.size != sourceStat.size ||
          currentStat.modified != sourceStat.modified) {
        throw StateError(
          'The selected Anki collection changed during import. '
          'Close it in the other application and try again.',
        );
      }

      // Destination can have appeared while staging. Refuse to overwrite it.
      if (await File(destinationPath).exists() ||
          await File(destinationLocation.mediaDbPath).exists() ||
          await Directory(destinationLocation.mediaFolderPath).exists()) {
        throw StateError('Collection import destination already exists.');
      }

      if (await stagedMediaDb.exists()) {
        await stagedMediaDb.rename(destinationLocation.mediaDbPath);
        promotedMediaDb = true;
      }
      if (await stagedMediaDir.exists()) {
        await stagedMediaDir.rename(destinationLocation.mediaFolderPath);
        promotedMediaDirectory = true;
      }
      await stagedCollection.rename(destinationPath);
      promotedCollection = true;
      return destinationPath;
    } catch (_) {
      if (promotedCollection) {
        await File(destinationPath).delete();
      }
      if (promotedMediaDirectory) {
        await Directory(destinationLocation.mediaFolderPath)
            .delete(recursive: true);
      }
      if (promotedMediaDb) {
        await File(destinationLocation.mediaDbPath).delete();
      }
      rethrow;
    } finally {
      if (await staging.exists()) {
        await staging.delete(recursive: true);
      }
    }
  }

  Future<void> _rejectActiveSqliteJournal(File source) async {
    for (final suffix in const ['-wal', '-journal']) {
      final companion = File('${source.path}$suffix');
      if (await companion.exists() && await companion.length() > 0) {
        throw StateError(
          'The selected Anki collection has an active SQLite journal. '
          'Close Anki before importing the collection.',
        );
      }
    }
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
