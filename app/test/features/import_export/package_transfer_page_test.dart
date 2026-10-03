import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:anki_flutter/features/import_export/native_package_file_transfer.dart';
import 'package:anki_flutter/features/import_export/package_transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('imports a picked package and reports Anki counts', (tester) async {
    final repository = _Repository();
    final transfer = _Transfer();
    await tester.pumpWidget(
      MaterialApp(
        home: PackageTransferPage(
          repository: repository,
          fileTransfer: transfer,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('import-apkg')));
    await tester.pumpAndSettle();

    expect(repository.importedPath, '/tmp/import.apkg');
    expect(find.textContaining('3 found, 1 new, 1 updated'), findsOneWidget);
  });

  testWidgets('exports through the platform transfer adapter', (tester) async {
    final repository = _Repository();
    final transfer = _Transfer();
    await tester.pumpWidget(
      MaterialApp(
        home: PackageTransferPage(
          repository: repository,
          fileTransfer: transfer,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final exportButton = find.byKey(const ValueKey('export-apkg'));
    await tester.scrollUntilVisible(exportButton, 300);
    await tester.tap(exportButton);
    await tester.pumpAndSettle();

    expect(transfer.exportCalled, isTrue);
    expect(find.textContaining('2 media files included'), findsOneWidget);
  });
}

class _Repository implements PackageRepository {
  String? importedPath;

  @override
  Future<import_export.ImportAnkiPackageOptions> getImportPresets() async =>
      import_export.ImportAnkiPackageOptions(
        mergeNotetypes: true,
        updateNotes: import_export.ImportAnkiPackageUpdateCondition
            .IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER,
        updateNotetypes: import_export.ImportAnkiPackageUpdateCondition
            .IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER,
        withScheduling: true,
        withDeckConfigs: true,
      );

  @override
  Future<import_export.ImportResponse> importPackage(
    String packagePath,
    import_export.ImportAnkiPackageOptions options,
  ) async {
    importedPath = packagePath;
    return import_export.ImportResponse(
      log: import_export.ImportResponse_Log(
        foundNotes: 3,
        new_1: [import_export.ImportResponse_Note()],
        updated: [import_export.ImportResponse_Note()],
        duplicate: [import_export.ImportResponse_Note()],
      ),
    );
  }

  @override
  Future<int> exportPackage(
    String outPath, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async => 2;
}

class _Transfer implements PackageFileTransfer {
  bool exportCalled = false;

  @override
  Future<String?> pickImportPackage() async => '/tmp/import.apkg';

  @override
  Future<PackageExportResult?> exportPackage(
    PackageRepository repository, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async {
    exportCalled = true;
    return PackageExportResult(
      mediaFiles: 2,
      savedUri: Uri.file('/tmp/export.apkg'),
    );
  }
}
