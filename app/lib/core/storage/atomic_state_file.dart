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

// Atomic replacement protects an individual write, not a read-modify-write
// cycle. This queue is shared across store instances in one Dart isolate;
// it is not a cross-process or cross-isolate filesystem lock.
final Map<String, Future<void>> _stateMutationTails = <String, Future<void>>{};

/// Serialize a complete read-modify-write operation for the same state file.
///
/// An error is propagated to its caller, but does not block later mutations.
Future<T> runSerializedStateMutation<T>(
  File destination,
  Future<T> Function() mutation,
) {
  final key = destination.absolute.path;
  final previous = _stateMutationTails[key] ?? Future<void>.value();
  final result = previous.then<T>((_) => mutation());
  final tail = result.then<void>(
    (_) {},
    onError: (Object error, StackTrace stackTrace) {},
  );
  _stateMutationTails[key] = tail;
  tail.then((_) {
    if (identical(_stateMutationTails[key], tail)) {
      _stateMutationTails.remove(key);
    }
  });
  return result;
}
