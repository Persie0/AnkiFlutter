import 'dart:io';

/// Owns only the temporary files AnkiFlutter creates for imports when a
/// platform file picker cannot provide a readable filesystem path.
///
/// A fixed filename prevents any untrusted picker display name from escaping
/// the private temporary directory.
class StagedPackageImportStore {
  StagedPackageImportStore({Directory? temporaryRoot})
    : _temporaryRoot = temporaryRoot ?? Directory.systemTemp;

  final Directory _temporaryRoot;
  final Map<String, Directory> _ownedDirectories = {};

  Future<String> stage(List<int> bytes) async {
    final directory = await _temporaryRoot.createTemp('ankiflutter-import-');
    final file = File(
      '${directory.path}${Platform.pathSeparator}import.apkg',
    );
    try {
      await file.writeAsBytes(bytes, flush: true);
      _ownedDirectories[file.path] = directory;
      return file.path;
    } catch (_) {
      // Never leave partial temporary imports behind on a failed write.
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
      rethrow;
    }
  }

  /// Safe for repeated calls; never touches user-selected, external files.
  Future<void> release(String path) async {
    final directory = _ownedDirectories[path];
    if (directory == null) return;
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
    _ownedDirectories.remove(path);
  }
}
