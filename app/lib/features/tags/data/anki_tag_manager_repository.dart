import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/tags.pb.dart'
    as tags;

/// Tag changes are performed by Anki's native backend, preserving its
/// hierarchical name handling, note updates, sync metadata, and undo history.
abstract interface class TagManagerRepository {
  Future<List<String>> allTags();

  Future<int> rename(String oldName, String newName);

  Future<int> remove(String name);

  Future<int> clearUnused();
}

class AnkiTagManagerRepository implements TagManagerRepository {
  const AnkiTagManagerRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<List<String>> allTags() async {
    final bytes = await backend.invoke(
      BackendOperation.allTags,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return List.unmodifiable(generic.StringList.fromBuffer(bytes).vals);
  }

  @override
  Future<int> rename(String oldName, String newName) async {
    final oldTag = _validateTag(oldName);
    final newTag = _validateTag(newName);
    if (oldTag == newTag) {
      throw ArgumentError('Choose a different tag name');
    }
    final bytes = await backend.invoke(
      BackendOperation.tagManagerRenameTags,
      Uint8List.fromList(tags.RenameTagsRequest(
        currentPrefix: oldTag,
        newPrefix: newTag,
      ).writeToBuffer()),
    );
    return collection.OpChangesWithCount.fromBuffer(bytes).count;
  }

  @override
  Future<int> remove(String name) async {
    final tag = _validateTag(name);
    final bytes = await backend.invoke(
      BackendOperation.tagManagerRemoveTags,
      Uint8List.fromList(generic.String(val: tag).writeToBuffer()),
    );
    return collection.OpChangesWithCount.fromBuffer(bytes).count;
  }

  @override
  Future<int> clearUnused() async {
    final bytes = await backend.invoke(
      BackendOperation.tagManagerClearUnusedTags,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return collection.OpChangesWithCount.fromBuffer(bytes).count;
  }

  String _validateTag(String name) {
    final tag = name.trim();
    if (tag.isEmpty || RegExp(r'\s').hasMatch(tag) ||
        tag.startsWith('::') || tag.endsWith('::') ||
        tag.contains('::::')) {
      throw ArgumentError.value(name, 'tag', 'Enter a valid tag name');
    }
    return tag;
  }
}
