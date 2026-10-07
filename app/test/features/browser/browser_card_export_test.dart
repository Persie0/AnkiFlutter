import 'package:anki_flutter/features/browser/browser_card_export.dart';
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:anki_flutter/features/import_export/native_package_file_transfer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('passes a deduplicated immutable card selection to the platform exporter',
      () async {
    final transfer = _Transfer();
    final exporter = NativeBrowserCardExporter(
      repository: _Repository(),
      fileTransfer: transfer,
    );

    final saved = await exporter.exportCards(
      [12, 12, 20],
      withScheduling: false,
      withMedia: true,
    );

    expect(saved, isTrue);
    expect(transfer.ids, [12, 20]);
    expect(transfer.scheduling, isFalse);
    expect(transfer.media, isTrue);
    expect(() => transfer.ids.add(99), throwsUnsupportedError);
  });

  test('returns false for canceled system save operation', () async {
    final transfer = _Transfer()..cancel = true;
    final exporter = NativeBrowserCardExporter(
      repository: _Repository(),
      fileTransfer: transfer,
    );

    expect(
      await exporter.exportCards(
        [1],
        withScheduling: true,
        withMedia: false,
      ),
      isFalse,
    );
  });

  test('invalid or empty selection never reaches file transfer', () async {
    final transfer = _Transfer();
    final exporter = NativeBrowserCardExporter(
      repository: _Repository(),
      fileTransfer: transfer,
    );
    await expectLater(
      exporter.exportCards([], withScheduling: true, withMedia: true),
      throwsArgumentError,
    );
    await expectLater(
      exporter.exportCards([0], withScheduling: true, withMedia: true),
      throwsArgumentError,
    );
    expect(transfer.calls, 0);
  });
}

class _Repository implements CardScopedPackageRepository {
  @override
  Future<int> exportSelectedCards(
    String outPath, {
    required List<int> cardIds,
    required bool withScheduling,
    required bool withMedia,
  }) async => 0;
}

class _Transfer implements CardScopedPackageFileTransfer {
  int calls = 0;
  bool cancel = false;
  List<int> ids = [];
  bool? scheduling;
  bool? media;

  @override
  Future<PackageExportResult?> exportSelectedCards(
    CardScopedPackageRepository repository, {
    required List<int> cardIds,
    required bool withScheduling,
    required bool withMedia,
  }) async {
    calls++;
    ids = cardIds;
    scheduling = withScheduling;
    media = withMedia;
    return cancel
        ? null
        : PackageExportResult(
            mediaFiles: 0,
            savedUri: Uri.file('/tmp/selection.apkg'),
          );
  }
}
