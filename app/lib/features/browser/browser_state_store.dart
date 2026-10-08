import 'dart:convert';
import 'dart:io';

import 'package:anki_flutter/features/collection/mobile_collection_storage.dart';

/// A named, local browser search preset. Search syntax is interpreted by
/// Anki's native collection backend when the preset is applied.
class BrowserSavedSearch {
  const BrowserSavedSearch({
    required this.name,
    required this.query,
    required this.sortColumn,
    required this.reverse,
  });

  final String name;
  final String query;
  final String? sortColumn;
  final bool reverse;

  Map<String, Object?> toJson() => {
    'name': name,
    'query': query,
    'sortColumn': sortColumn,
    'reverse': reverse,
  };

  static BrowserSavedSearch? fromJson(Object? value) {
    if (value is! Map<String, dynamic>) return null;
    final name = value['name'];
    final query = value['query'];
    final sortColumn = value['sortColumn'];
    final reverse = value['reverse'];
    if (name is! String ||
        name.trim().isEmpty ||
        query is! String ||
        query.trim().isEmpty ||
        reverse is! bool ||
        (sortColumn != null && sortColumn is! String)) {
      return null;
    }
    return BrowserSavedSearch(
      name: name.trim(),
      query: query,
      sortColumn: sortColumn as String?,
      reverse: reverse,
    );
  }
}

class CardBrowserState {
  const CardBrowserState({
    required this.query,
    required this.sortColumn,
    required this.reverse,
    this.savedSearches = const [],
  });

  final String query;
  final String? sortColumn;
  final bool reverse;
  final List<BrowserSavedSearch> savedSearches;

  Map<String, Object?> toJson() => {
    'query': query,
    'sortColumn': sortColumn,
    'reverse': reverse,
    'savedSearches': savedSearches.map((entry) => entry.toJson()).toList(),
  };

  static CardBrowserState? fromJson(Object? value) {
    if (value is! Map<String, dynamic>) return null;
    final query = value['query'];
    final sortColumn = value['sortColumn'];
    final reverse = value['reverse'];
    if (query is! String || reverse is! bool) return null;
    if (sortColumn != null && sortColumn is! String) return null;

    // Older browser-state files have no savedSearches property. Malformed
    // individual entries must not invalidate an otherwise usable state.
    final presets = <BrowserSavedSearch>[];
    final knownNames = <String>{};
    final raw = value['savedSearches'];
    if (raw is List) {
      for (final item in raw) {
        final preset = BrowserSavedSearch.fromJson(item);
        if (preset != null &&
            knownNames.add(preset.name.toLowerCase())) {
          presets.add(preset);
        }
      }
    }
    return CardBrowserState(
      query: query,
      sortColumn: sortColumn as String?,
      reverse: reverse,
      savedSearches: List.unmodifiable(presets),
    );
  }
}

abstract interface class BrowserStateStore {
  Future<CardBrowserState?> load();

  Future<void> save(CardBrowserState state);
}

class FileBrowserStateStore implements BrowserStateStore {
  FileBrowserStateStore({File? file}) : _file = file ?? _defaultFile();

  final File _file;

  @override
  Future<CardBrowserState?> load() async {
    try {
      return CardBrowserState.fromJson(jsonDecode(await _file.readAsString()));
    } on FileSystemException {
      return null;
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> save(CardBrowserState state) async {
    await _file.parent.create(recursive: true);
    await _file.writeAsString(jsonEncode(state.toJson()), flush: true);
  }

  static File _defaultFile() => File(
    '${ApplicationDataPaths.applicationSupportDirectory.path}'
    '${Platform.pathSeparator}browser-state.json',
  );
}
