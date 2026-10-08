import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as search;
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'open collection deck screen can navigate to shared card browser',
    (tester) async {
      final backend = _Backend();
      final controller = DeckListController(repository: _DeckRepository());
      await tester.pumpWidget(
        MaterialApp(
          home: DeckListPage(
            controller: controller,
            backend: backend,
            pickCollection: () async => '/collection.anki2',
            openCollection: (_) async {},
          ),
        ),
      );

      await tester.tap(find.text('Open Anki Collection'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Browse cards'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Browse cards'), findsOneWidget);
      controller.dispose();
    },
  );
  testWidgets(
    'deck overview Browse due opens the shared browser with native deck filter',
    (tester) async {
      const deck = DeckNode(
        id: 42,
        name: 'Japanese::N5',
        newCount: 5,
        learnCount: 2,
        reviewCount: 12,
        filtered: false,
        children: [],
      );
      final backend = _Backend();
      final controller = DeckListController(
        repository: _DeckRepository(decks: const [deck]),
      );
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          home: DeckListPage(
            controller: controller,
            backend: backend,
            browserStateStore: _MemoryBrowserStateStore(),
            pickCollection: () async => '/collection.anki2',
            openCollection: (_) async {},
          ),
        ),
      );

      await tester.tap(find.text('Open Anki Collection'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Japanese::N5'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('deck-browse-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Due cards in deck'));
      await tester.pumpAndSettle();

      expect(find.text('Browse cards'), findsOneWidget);
      expect(backend.searchQueries, ['deck:"Japanese::N5" is:due']);
      expect(
        tester
            .widget<TextField>(find.byKey(const ValueKey('card-browser-search')))
            .controller
            ?.text,
        'deck:"Japanese::N5" is:due',
      );

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Japanese::N5'), findsOneWidget);
    },
  );
}

class _Backend implements BackendInvoker {
  final operations = <BackendOperation>[];
  final searchQueries = <String>[];

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    operations.add(operation);
    if (operation == BackendOperation.searchCards) {
      searchQueries.add(search.SearchRequest.fromBuffer(request).search);
    }
    return switch (operation) {
      BackendOperation.allBrowserColumns =>
        Uint8List.fromList(search.BrowserColumns().writeToBuffer()),
      BackendOperation.searchCards =>
        Uint8List.fromList(search.SearchResponse().writeToBuffer()),
      _ => Uint8List(0),
    };
  }
}

class _DeckRepository implements DeckRepository {
  _DeckRepository({this.decks = const []});

  final List<DeckNode> decks;

  @override
  Future<List<DeckNode>> loadDeckTree() async => decks;
}

class _MemoryBrowserStateStore implements BrowserStateStore {
  CardBrowserState? current;

  @override
  Future<CardBrowserState?> load() async => current;

  @override
  Future<void> save(CardBrowserState state) async {
    current = state;
  }
}
