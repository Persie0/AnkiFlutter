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

  test('malformed state is ignored', () async {
    await stateFile.writeAsString('{broken-json');
    final store = FileBrowserStateStore(file: stateFile);

    expect(await store.load(), isNull);
  });
}
