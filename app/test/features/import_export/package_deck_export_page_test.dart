import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:anki_flutter/features/import_export/native_package_file_transfer.dart';
import 'package:anki_flutter/features/import_export/package_transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exports a selected nested deck through the scoped native adapter',
      (tester) async {
    final repository = _Repository();
    final transfer = _Transfer();
    await tester.pumpWidget(_app(repository, transfer));
    await tester.pumpAndSettle();

    await _showExportControls(tester);
    expect(find.text('Whole collection'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('export-scope-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Languages::French').last);
    await tester.pumpAndSettle();

    final exportButton = find.byKey(const ValueKey('export-apkg'));
    await tester.ensureVisible(exportButton);
    await tester.pumpAndSettle();
    await tester.tap(exportButton);
    await tester.pumpAndSettle();

    expect(transfer.deckExportIds, [3]);
    expect(transfer.wholeExportCount, 0);
    await tester.drag(find.byType(ListView), const Offset(0, 1200));
    await tester.pumpAndSettle();
    expect(find.textContaining('Export complete (Languages::French)'), findsOneWidget);
    expect(find.textContaining('2 media files included'), findsOneWidget);
  });

  testWidgets('whole collection remains the default scope', (tester) async {
    final repository = _Repository();
    final transfer = _Transfer();
    await tester.pumpWidget(_app(repository, transfer));
    await tester.pumpAndSettle();

    final exportButton = find.byKey(const ValueKey('export-apkg'));
    await tester.scrollUntilVisible(exportButton, 280);
    await tester.tap(exportButton);
    await tester.pumpAndSettle();

    expect(transfer.wholeExportCount, 1);
    expect(transfer.deckExportIds, isEmpty);
  });

  testWidgets('failed deck discovery does not disable whole collection export',
      (tester) async {
    final repository = _Repository()..failDeckDiscovery = true;
    final transfer = _Transfer();
    await tester.pumpWidget(_app(repository, transfer));
    await tester.pumpAndSettle();

    await _showExportControls(tester);
    expect(find.textContaining('Could not list decks for export'), findsOneWidget);
    expect(find.byKey(const ValueKey('export-scope-dropdown')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('export-apkg')));
    await tester.pumpAndSettle();

    expect(transfer.wholeExportCount, 1);
    expect(transfer.deckExportIds, isEmpty);
  });

  testWidgets('canceling a chosen deck export never reports success',
      (tester) async {
    final repository = _Repository();
    final transfer = _Transfer()..cancel = true;
    await tester.pumpWidget(_app(repository, transfer));
    await tester.pumpAndSettle();

    await _showExportControls(tester);
    await tester.tap(find.byKey(const ValueKey('export-scope-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Default').last);
    await tester.pumpAndSettle();

    final exportButton = find.byKey(const ValueKey('export-apkg'));
    await tester.ensureVisible(exportButton);
    await tester.pumpAndSettle();
    await tester.tap(exportButton);
    await tester.pumpAndSettle();

    expect(transfer.deckExportIds, [1]);
    expect(find.textContaining('Export complete'), findsNothing);
  });
}

Future<void> _showExportControls(WidgetTester tester) async {
  await tester.drag(find.byType(ListView), const Offset(0, -750));
  await tester.pumpAndSettle();
  final finder = find.byKey(const ValueKey('export-scope-dropdown'));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
}

Widget _app(_Repository repository, _Transfer transfer) => MaterialApp(
  home: PackageTransferPage(
    repository: repository,
    fileTransfer: transfer,
  ),
);

class _Repository implements PackageRepository, DeckScopedPackageRepository {
  bool failDeckDiscovery = false;

  @override
  Future<List<PackageExportDeck>> exportDeckTargets() async {
    if (failDeckDiscovery) throw StateError('deck lookup failed');
    return const [
      PackageExportDeck(id: 1, name: 'Default'),
      PackageExportDeck(id: 2, name: 'Languages'),
      PackageExportDeck(id: 3, name: 'Languages::French'),
    ];
  }

  @override
  Future<import_export.ImportAnkiPackageOptions> getImportPresets() async =>
      import_export.ImportAnkiPackageOptions();

  @override
  Future<import_export.ImportResponse> importPackage(
    String packagePath,
    import_export.ImportAnkiPackageOptions options,
  ) async => import_export.ImportResponse();

  @override
  Future<int> exportPackage(
    String outPath, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async => 0;

  @override
  Future<int> exportDeckPackage(
    String outPath, {
    required int deckId,
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async => 0;
}

class _Transfer implements PackageFileTransfer, DeckScopedPackageFileTransfer {
  int wholeExportCount = 0;
  final List<int> deckExportIds = [];
  bool cancel = false;

  @override
  Future<String?> pickImportPackage() async => null;

  @override
  Future<PackageExportResult?> exportPackage(
    PackageRepository repository, {
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async {
    wholeExportCount++;
    return cancel ? null : _result;
  }

  @override
  Future<PackageExportResult?> exportDeckPackage(
    DeckScopedPackageRepository repository, {
    required int deckId,
    required bool withScheduling,
    required bool withDeckConfigs,
    required bool withMedia,
    required bool legacy,
  }) async {
    deckExportIds.add(deckId);
    return cancel ? null : _result;
  }

  PackageExportResult get _result => PackageExportResult(
    mediaFiles: 2,
    savedUri: Uri.file('/tmp/deck.apkg'),
  );
}
