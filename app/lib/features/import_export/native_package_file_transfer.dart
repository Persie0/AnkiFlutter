import 'dart:io';

import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:file_picker/file_picker.dart';

class PackageExportResult {
  const PackageExportResult({required this.mediaFiles, required this.savedUri});

  final int mediaFiles;
  final Uri savedUri;
}

abstract interface class PackageFileTransfer {
  Future<String?> pickImportPackage();

  Future<PackageExportResult?> exportPackage(
    PackageRepository repository, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  });
}

/// Optional platform adapter for exporting only one regular deck.
abstract interface class DeckScopedPackageFileTransfer {
  Future<PackageExportResult?> exportDeckPackage(
    DeckScopedPackageRepository repository, {
    required int deckId,
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  });
}

class NativePackageFileTransfer
    implements PackageFileTransfer, DeckScopedPackageFileTransfer {
  const NativePackageFileTransfer();

  @override
  Future<String?> pickImportPackage() async {
    final file = await FilePicker.pickFile(
      dialogTitle: 'Choose an Anki package',
      type: FileType.custom,
      allowedExtensions: const ['apkg'],
    );
    if (file == null) return null;

    final path = file.path;
    if (path != null && path.isNotEmpty) return path;

    final bytes = await file.readAsBytes();
    final directory = await Directory.systemTemp.createTemp('ankiflutter-import-');
    final fallback = File('${directory.path}${Platform.pathSeparator}${file.name}');
    await fallback.writeAsBytes(bytes, flush: true);
    return fallback.path;
  }

  @override
  Future<PackageExportResult?> exportPackage(
    PackageRepository repository, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) => _savePackage(
    (path) => repository.exportPackage(
      path,
      withScheduling: withScheduling,
      withDeckConfigs: withDeckConfigs,
      withMedia: withMedia,
      legacy: legacy,
    ),
  );

  @override
  Future<PackageExportResult?> exportDeckPackage(
    DeckScopedPackageRepository repository, {
    required int deckId,
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) => _savePackage(
    (path) => repository.exportDeckPackage(
      path,
      deckId: deckId,
      withScheduling: withScheduling,
      withDeckConfigs: withDeckConfigs,
      withMedia: withMedia,
      legacy: legacy,
    ),
  );

  Future<PackageExportResult?> _savePackage(
    Future<int> Function(String path) export,
  ) async {
    final directory = await Directory.systemTemp.createTemp('ankiflutter-export-');
    final package = File(
      '${directory.path}${Platform.pathSeparator}AnkiFlutter-export.apkg',
    );
    try {
      final mediaFiles = await export(package.path);
      final bytes = await package.readAsBytes();
      final savedUri = await FilePicker.saveFile(
        dialogTitle: 'Save Anki package',
        fileName: 'AnkiFlutter-export.apkg',
        bytes: bytes,
        mimeType: 'application/zip',
        type: FileType.custom,
        allowedExtensions: const ['apkg'],
      );
      if (savedUri == null) return null;
      return PackageExportResult(mediaFiles: mediaFiles, savedUri: savedUri);
    } finally {
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    }
  }

}
