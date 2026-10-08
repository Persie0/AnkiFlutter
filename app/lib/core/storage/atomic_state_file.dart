import 'dart:io';

/// Write small application-state files without truncating their live copy.
///
/// The staged file is flushed in a sibling directory on the destination
/// filesystem before the final rename. Failed staging cleans up, preserving
/// the previous file. Never use this for an already-open SQLite collection.
Future<void> writeAtomicState(File destination, String content) async {
  await destination.parent.create(recursive: true);
  final staging = await destination.parent.createTemp('.ankiflutter-state-');
  try {
    final temporary = File(
      '${staging.path}${Platform.pathSeparator}state.json',
    );
    await temporary.writeAsString(content, flush: true);
    await temporary.rename(destination.path);
  } finally {
    if (await staging.exists()) {
      await staging.delete(recursive: true);
    }
  }
}
