import 'dart:convert';
import 'dart:io';

import 'package:anki_flutter/features/collection/mobile_collection_storage.dart';

class CardBrowserState {
  const CardBrowserState({
    required this.query,
    required this.sortColumn,
    required this.reverse,
  });

  final String query;
  final String? sortColumn;
  final bool reverse;

  Map<String, Object?> toJson() => {
    'query': query,
    'sortColumn': sortColumn,
    'reverse': reverse,
  };

  static CardBrowserState? fromJson(Object? value) {
    if (value is! Map<String, dynamic>) return null;
    final query = value['query'];
    final sortColumn = value['sortColumn'];
    final reverse = value['reverse'];
    if (query is! String || reverse is! bool) return null;
    if (sortColumn != null && sortColumn is! String) return null;
    return CardBrowserState(
      query: query,
      sortColumn: sortColumn as String?,
      reverse: reverse,
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
