import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart' as search;
import 'package:fixnum/fixnum.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens browser filtered to notes reported by Anki media audit', (tester) async {
    final backend = _Backend(withMissingNotes: true);
    await tester.pumpWidget(MaterialApp(
      home: DeckListPage(
        controller: DeckListController(repository: _EmptyDeckRepository()),
        pickCollection: () async => '/tmp/a.anki2',
        openCollection: (_) async {},
        backend: backend,
        browserStateStore: _StateStore(),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Check media'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    final browse = find.byKey(const ValueKey('media-browse-affected-notes'));
    await tester.ensureVisible(browse);
    await tester.pumpAndSettle();
    await tester.tap(browse);
    await tester.pumpAndSettle();

    expect(find.text('Browse cards'), findsOneWidget);
    expect(backend.searchQueries, ['nid:42 or nid:91']);
  });

  testWidgets('opened collection exposes read-only Check media action', (tester) async {
    final backend = _Backend();
    await tester.pumpWidget(
      MaterialApp(
        home: DeckListPage(
          controller: DeckListController(repository: _EmptyDeckRepository()),
          pickCollection: () async => '/tmp/a.anki2',
          openCollection: (_) async {},
          backend: backend,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Check media'));
    await tester.pumpAndSettle();

    expect(find.text('Collection media audit'), findsOneWidget);
    expect(backend.operations, [BackendOperation.getUndoStatus]);
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    expect(backend.operations, [BackendOperation.getUndoStatus, BackendOperation.checkMedia]);
    expect(find.text('Missing files: 1'), findsOneWidget);
    expect(find.text('lost.mp3'), findsOneWidget);
  });
}

class _EmptyDeckRepository implements DeckRepository {
  @override
  Future<List<DeckNode>> loadDeckTree() async => const [];
}

class _Backend implements BackendInvoker {
  _Backend({this.withMissingNotes = false});
  final bool withMissingNotes;
  final List<BackendOperation> operations = [];
  final List<String> searchQueries = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    operations.add(operation);
    if (operation == BackendOperation.checkMedia) {
      return Uint8List.fromList(
        media.CheckMediaResponse(
          missing: ['lost.mp3'],
          missingMediaNotes: withMissingNotes ? [Int64(42), Int64(91)] : [],
        ).writeToBuffer(),
      );
    }
    if (operation == BackendOperation.searchCards) {
      searchQueries.add(search.SearchRequest.fromBuffer(request).search);
      return Uint8List.fromList(search.SearchResponse().writeToBuffer());
    }
    return Uint8List(0);
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}
