import 'dart:io';

import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory tempDirectory;
  late File stateFile;

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp(
      'anki_flutter_browser_state_test_',
    );
    stateFile = File('${tempDirectory.path}/browser-state.json');
  });

  tearDown(() async {
    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  test('persists and restores query and sort state', () async {
    final store = FileBrowserStateStore(file: stateFile);
    const state = CardBrowserState(
      query: 'deck:Travel tag:lesson-1',
      sortColumn: 'noteFld',
      reverse: true,
    );

    await store.save(state);
    final restored = await store.load();

    expect(restored?.query, state.query);
    expect(restored?.sortColumn, state.sortColumn);
    expect(restored?.reverse, isTrue);
  });

  test('named search round trips with Anki query and sort preferences', () async {
    final store = FileBrowserStateStore(file: stateFile);
    const saved = BrowserSavedSearch(
      name: 'Due French',
      query: 'deck:French is:due',
      sortColumn: 'noteFld',
      reverse: true,
    );

    await store.save(const CardBrowserState(
      query: 'is:new',
      sortColumn: null,
      reverse: false,
      savedSearches: [saved],
    ));
    final restored = await store.load();

    expect(restored?.query, 'is:new');
    expect(restored?.savedSearches, hasLength(1));
    expect(restored!.savedSearches.single.name, 'Due French');
    expect(restored.savedSearches.single.query, 'deck:French is:due');
    expect(restored.savedSearches.single.sortColumn, 'noteFld');
    expect(restored.savedSearches.single.reverse, isTrue);
  });

  test('legacy JSON without saved searches restores with an empty list', () async {
    await stateFile.writeAsString(
      '{"query":"is:due","sortColumn":null,"reverse":false}',
    );
    final restored = await FileBrowserStateStore(file: stateFile).load();
    expect(restored?.query, 'is:due');
    expect(restored?.savedSearches, isEmpty);
  });

  test('invalid saved entries are ignored, deduplicated case insensitively', () async {
    await stateFile.writeAsString(
      '{"query":"is:new","sortColumn":null,"reverse":false,'
      '"savedSearches":['
      '{"name":"Daily","query":"is:due","sortColumn":null,"reverse":false},'
      '{"name":"DAILY","query":"is:new","sortColumn":null,"reverse":true},'
      '{"name":" ","query":"is:due","sortColumn":null,"reverse":false},'
      '{"name":"bad","query":42,"sortColumn":null,"reverse":false},'
      '{"name":"good","query":"tag:x","sortColumn":null,"reverse":true}'
      ']}',
    );
    final restored = await FileBrowserStateStore(file: stateFile).load();

    expect(restored?.savedSearches.map((item) => item.name), ['Daily', 'good']);
    expect(restored?.savedSearches.map((item) => item.query), ['is:due', 'tag:x']);
  });

  test('malformed state is ignored', () async {
    await stateFile.writeAsString('{broken-json');
    final store = FileBrowserStateStore(file: stateFile);

    expect(await store.load(), isNull);
  });
}
