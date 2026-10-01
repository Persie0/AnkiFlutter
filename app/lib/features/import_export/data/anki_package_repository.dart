import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
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

class AnkiPackageRepository implements PackageRepository {
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
  Future<int> exportPackage(
    String outPath, {
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
      limit: import_export.ExportLimit(wholeCollection: generic.Empty()),
    );
    final response = await backend.invoke(
      BackendOperation.exportAnkiPackage,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return generic.UInt32.fromBuffer(response).val;
  }
}
