import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:anki_flutter/features/import_export/native_package_file_transfer.dart';
import 'package:anki_flutter/features/import_export/package_transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cleans the staged package after a successful native import',
      (tester) async {
    final repo = _Repository();
    final transfer = _Transfer();
    await tester.pumpWidget(_app(repo, transfer));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('import-apkg')));
    await tester.pumpAndSettle();

    expect(repo.importedPaths, ['/tmp/ankiflutter-stage/import.apkg']);
    expect(transfer.cleanedPaths, ['/tmp/ankiflutter-stage/import.apkg']);
    expect(find.textContaining('Import complete'), findsOneWidget);
  });

  testWidgets('cleans the staged package when the Anki backend rejects it',
      (tester) async {
    final repo = _Repository()..failImport = true;
    final transfer = _Transfer();
    await tester.pumpWidget(_app(repo, transfer));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('import-apkg')));
    await tester.pumpAndSettle();

    expect(transfer.cleanedPaths, ['/tmp/ankiflutter-stage/import.apkg']);
    expect(find.textContaining('Could not import package'), findsOneWidget);
    expect(find.textContaining('Import complete'), findsNothing);
  });

  testWidgets('canceling the picker unlocks actions and needs no cleanup',
      (tester) async {
    final repo = _Repository();
    final transfer = _Transfer()..selectedPath = null;
    await tester.pumpWidget(_app(repo, transfer));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('import-apkg')));
    await tester.pumpAndSettle();

    expect(transfer.cleanedPaths, isEmpty);
    expect(repo.importedPaths, isEmpty);
    expect(
      tester.widget<FilledButton>(find.byKey(const ValueKey('import-apkg')))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('picker failure displays an error and leaves import retryable',
      (tester) async {
    final repo = _Repository();
    final transfer = _Transfer()..failPicker = true;
    await tester.pumpWidget(_app(repo, transfer));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('import-apkg')));
    await tester.pumpAndSettle();

    expect(transfer.cleanedPaths, isEmpty);
    expect(find.textContaining('picker failed'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byKey(const ValueKey('import-apkg')))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('native package picker locks out concurrent import requests',
      (tester) async {
    final repo = _Repository();
    final transfer = _Transfer();
    final pending = Completer<String?>();
    transfer.pendingPicker = pending;
    await tester.pumpWidget(_app(repo, transfer));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('import-apkg')));
    await tester.pump();
    expect(transfer.pickCount, 1);
    expect(
      tester.widget<FilledButton>(find.byKey(const ValueKey('import-apkg')))
          .onPressed,
      isNull,
    );

    pending.complete(null);
    await tester.pumpAndSettle();
    expect(transfer.pickCount, 1);
    expect(transfer.cleanedPaths, isEmpty);
    expect(
      tester.widget<FilledButton>(find.byKey(const ValueKey('import-apkg')))
          .onPressed,
      isNotNull,
    );
  });
}

Widget _app(_Repository repository, _Transfer transfer) => MaterialApp(
  home: PackageTransferPage(repository: repository, fileTransfer: transfer),
);

class _Repository implements PackageRepository {
  bool failImport = false;
  final List<String> importedPaths = [];

  @override
  Future<import_export.ImportAnkiPackageOptions> getImportPresets() async =>
      import_export.ImportAnkiPackageOptions();

  @override
  Future<import_export.ImportResponse> importPackage(
    String packagePath,
    import_export.ImportAnkiPackageOptions options,
  ) async {
    importedPaths.add(packagePath);
    if (failImport) throw StateError('backend rejected import');
    return import_export.ImportResponse(
      log: import_export.ImportResponse_Log(foundNotes: 1),
    );
  }

  @override
  Future<int> exportPackage(
    String outPath, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async => 0;
}

class _Transfer implements PackageFileTransfer, TemporaryPackageImportCleanup {
  String? selectedPath = '/tmp/ankiflutter-stage/import.apkg';
  bool failPicker = false;
  int pickCount = 0;
  Completer<String?>? pendingPicker;
  final List<String> cleanedPaths = [];

  @override
  Future<String?> pickImportPackage() async {
    pickCount++;
    if (failPicker) throw StateError('picker failed');
    if (pendingPicker case final pending?) return pending.future;
    return selectedPath;
  }

  @override
  Future<void> releasePickedPackage(String path) async {
    cleanedPaths.add(path);
  }

  @override
  Future<PackageExportResult?> exportPackage(
    PackageRepository repository, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async => null;
}
