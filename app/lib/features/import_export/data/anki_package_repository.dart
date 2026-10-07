import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks;
import 'package:fixnum/fixnum.dart';
import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;

abstract interface class PackageRepository {
  Future<import_export.ImportAnkiPackageOptions> getImportPresets();

  Future<import_export.ImportResponse> importPackage(
    String packagePath,
    import_export.ImportAnkiPackageOptions options,
  );

  Future<int> exportPackage(
    String outPath, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  });
}

/// Optional capability for exporting one regular deck without changing the
/// existing package repository contract used by platform-specific callers.
abstract interface class DeckScopedPackageRepository {
  Future<List<PackageExportDeck>> exportDeckTargets();

  Future<int> exportDeckPackage(
    String outPath, {
    required int deckId,
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  });
}

class PackageExportDeck {
  const PackageExportDeck({required this.id, required this.name});

  final int id;
  final String name;
}

class AnkiPackageRepository implements PackageRepository, DeckScopedPackageRepository {
  const AnkiPackageRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<import_export.ImportAnkiPackageOptions> getImportPresets() async {
    final response = await backend.invoke(
      BackendOperation.getImportAnkiPackagePresets,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return import_export.ImportAnkiPackageOptions.fromBuffer(response);
  }

  @override
  Future<import_export.ImportResponse> importPackage(
    String packagePath,
    import_export.ImportAnkiPackageOptions options,
  ) async {
    final trimmedPath = packagePath.trim();
    if (trimmedPath.isEmpty) {
      throw ArgumentError.value(packagePath, 'packagePath', 'Package path is empty');
    }
    final response = await backend.invoke(
      BackendOperation.importAnkiPackage,
      Uint8List.fromList(
        import_export.ImportAnkiPackageRequest(
          packagePath: trimmedPath,
          options: options,
        ).writeToBuffer(),
      ),
    );
    return import_export.ImportResponse.fromBuffer(response);
  }

  @override
  Future<List<PackageExportDeck>> exportDeckTargets() async {
    // Skip deck-tree due counts; only names/identifiers are required.
    final response = await backend.invoke(
      BackendOperation.deckTree,
      Uint8List.fromList(decks.DeckTreeRequest().writeToBuffer()),
    );
    final tree = decks.DeckTreeNode.fromBuffer(response);
    final targets = <PackageExportDeck>[];

    void visit(decks.DeckTreeNode node, String parent) {
      // Filtered decks are temporary views, not permanent deck exports.
      if (node.filtered) return;
      final path = parent.isEmpty ? node.name : '$parent::${node.name}';
      if (node.deckId.toInt() > 0) {
        targets.add(PackageExportDeck(id: node.deckId.toInt(), name: path));
      }
      for (final child in node.children) {
        visit(child, path);
      }
    }

    for (final child in tree.children) {
      visit(child, '');
    }
    return List.unmodifiable(targets);
  }

  @override
  Future<int> exportDeckPackage(
    String outPath, {
    required int deckId,
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async {
    if (deckId <= 0) {
      throw ArgumentError.value(deckId, 'deckId', 'Choose a valid deck.');
    }
    return await _exportPackage(
      outPath,
      limit: import_export.ExportLimit(deckId: Int64(deckId)),
      withScheduling: withScheduling,
      withDeckConfigs: withDeckConfigs,
      withMedia: withMedia,
      legacy: legacy,
    );
  }

  @override
  Future<int> exportPackage(
    String outPath, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) => _exportPackage(
        outPath,
        limit: import_export.ExportLimit(wholeCollection: generic.Empty()),
        withScheduling: withScheduling,
        withDeckConfigs: withDeckConfigs,
        withMedia: withMedia,
        legacy: legacy,
      );

  Future<int> _exportPackage(
    String outPath, {
    required import_export.ExportLimit limit,
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async {
    final trimmedPath = outPath.trim();
    if (trimmedPath.isEmpty) {
      throw ArgumentError.value(outPath, 'outPath', 'Export path is empty');
    }
    final request = import_export.ExportAnkiPackageRequest(
      outPath: trimmedPath,
      options: import_export.ExportAnkiPackageOptions(
        withScheduling: withScheduling,
        withDeckConfigs: withDeckConfigs,
        withMedia: withMedia,
        legacy: legacy,
      ),
      limit: limit,
    );
    final response = await backend.invoke(
      BackendOperation.exportAnkiPackage,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return generic.UInt32.fromBuffer(response).val;
  }
}
