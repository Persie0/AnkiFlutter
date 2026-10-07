import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:anki_flutter/features/import_export/native_package_file_transfer.dart';

/// The browser owns only selection and user-visible options; package creation
/// and platform saving stay in the shared native Anki export adapters.
abstract interface class BrowserCardExporter {
  /// Returns false when the platform save dialog was canceled.
  Future<bool> exportCards(
    List<int> cardIds, {
    required bool withScheduling,
    required bool withMedia,
  });
}

class NativeBrowserCardExporter implements BrowserCardExporter {
  const NativeBrowserCardExporter({
    required this.repository,
    required this.fileTransfer,
  });

  final CardScopedPackageRepository repository;
  final CardScopedPackageFileTransfer fileTransfer;

  @override
  Future<bool> exportCards(
    List<int> cardIds, {
    required bool withScheduling,
    required bool withMedia,
  }) async {
    if (cardIds.isEmpty || cardIds.any((id) => id <= 0)) {
      throw ArgumentError.value(cardIds, 'cardIds', 'No valid cards selected.');
    }
    final result = await fileTransfer.exportSelectedCards(
      repository,
      cardIds: List.unmodifiable(cardIds.toSet()),
      withScheduling: withScheduling,
      withMedia: withMedia,
    );
    return result != null;
  }
}
