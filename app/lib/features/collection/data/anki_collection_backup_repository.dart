import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;

/// Creates Anki's database-only backup in a user-specified native directory.
/// It is not an .apkg export and does not contain media files.
abstract interface class CollectionBackupRepository {
  /// True means Anki confirmed that a backup was created.
  Future<bool> createBackup(String backupDirectory);
}

class AnkiCollectionBackupRepository implements CollectionBackupRepository {
  const AnkiCollectionBackupRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<bool> createBackup(String backupDirectory) async {
    final directory = backupDirectory.trim();
    if (directory.isEmpty) {
      throw ArgumentError.value(
        backupDirectory,
        'backupDirectory',
        'Choose a backup directory.',
      );
    }
    // The bridge expects a native filesystem path, not a document URI.
    if (Uri.tryParse(directory)?.hasScheme == true &&
        !RegExp(r'^[A-Za-z]:[\\/]').hasMatch(directory)) {
      throw ArgumentError.value(
        backupDirectory,
        'backupDirectory',
        'A native filesystem directory is required.',
      );
    }
    final bytes = await backend.invoke(
      BackendOperation.createBackup,
      Uint8List.fromList(collection.CreateBackupRequest(
        backupFolder: directory,
        force: true,
        waitForCompletion: true,
      ).writeToBuffer()),
    );
    return generic.Bool.fromBuffer(bytes).val;
  }
}
