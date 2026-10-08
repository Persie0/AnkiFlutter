import 'dart:convert';
import 'dart:io';

import 'package:anki_flutter/features/collection/mobile_collection_storage.dart';
import 'package:anki_flutter/core/storage/atomic_state_file.dart';

abstract interface class RecentCollectionStore {
  Future<List<String>> load();

  Future<void> remember(String collectionPath);

  Future<void> forget(String collectionPath);
}

/// Stores recently opened collection paths in the user's application config.
class FileRecentCollectionStore implements RecentCollectionStore {
  FileRecentCollectionStore({File? file, this.maxEntries = 8})
    : _file = file ?? _defaultFile() {
    if (maxEntries < 1) {
      throw ArgumentError.value(maxEntries, 'maxEntries', 'Must be positive.');
    }
  }

  final File _file;
  final int maxEntries;

  @override
  Future<List<String>> load() async {
    try {
      final decoded = jsonDecode(await _file.readAsString());
      if (decoded is! List) {
        return const [];
      }
      return decoded
          .whereType<String>()
          .where((path) => path.isNotEmpty)
          .take(maxEntries)
          .toList(growable: false);
    } on FileSystemException {
      return const [];
    } on FormatException {
      return const [];
    }
  }

  @override
  Future<void> remember(String collectionPath) async {
    final path = collectionPath.trim();
    if (path.isEmpty) {
      throw ArgumentError.value(
        collectionPath,
        'collectionPath',
        'Collection path must not be blank.',
      );
    }
    final paths = await load();
    await _write([
      path,
      ...paths.where((recentPath) => recentPath != path),
    ].take(maxEntries));
  }

  @override
  Future<void> forget(String collectionPath) async {
    final paths = await load();
    await _write(paths.where((path) => path != collectionPath).toList());
  }

  Future<void> _write(Iterable<String> paths) async {
    await _file.parent.create(recursive: true);
    await writeAtomicState(_file, jsonEncode(paths.toList()));
  }

  static File _defaultFile() {
    return ApplicationDataPaths.recentCollectionsFile;
  }
}
