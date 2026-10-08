import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('submitted searches support back/forward and clear bulk selection', (
    tester,
  ) async {
    final repository = _Repository();
    final store = _Store();
    await tester.pumpWidget(_app(repository, store));
    await tester.pumpAndSettle();

    expect(_navButton(tester, 'browser-search-history-back').onPressed, isNull);
    expect(_navButton(tester, 'browser-search-history-forward').onPressed, isNull);

    await _search(tester, 'is:due');
    await _search(tester, 'is:new');
    await tester.tap(find.byKey(const ValueKey('select-card-77')));
    await tester.pumpAndSettle();
    expect(find.text('1 card selected'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('browser-search-history-back')));
    await tester.pumpAndSettle();
    expect(_query(tester), 'is:due');
    expect(find.text('1 card selected'), findsNothing);
    expect(store.state!.query, 'is:due');
    expect(_navButton(tester, 'browser-search-history-forward').onPressed, isNotNull);

    await tester.tap(find.byKey(const ValueKey('browser-search-history-forward')));
    await tester.pumpAndSettle();
    expect(_query(tester), 'is:new');
    expect(repository.queries, ['', 'is:due', 'is:new', 'is:due', 'is:new']);
    expect(store.state!.query, 'is:new');
  });

  testWidgets('new search after back drops obsolete forward searches', (
    tester,
  ) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository, _Store()));
    await tester.pumpAndSettle();

    await _search(tester, 'A');
    await _search(tester, 'B');
    await tester.tap(find.byKey(const ValueKey('browser-search-history-back')));
    await tester.pumpAndSettle();
    expect(_query(tester), 'A');

    await _search(tester, 'C');
    expect(_navButton(tester, 'browser-search-history-forward').onPressed, isNull);
    await tester.tap(find.byKey(const ValueKey('browser-search-history-back')));
    await tester.pumpAndSettle();
    expect(_query(tester), 'A');
    await tester.tap(find.byKey(const ValueKey('browser-search-history-forward')));
    await tester.pumpAndSettle();
    expect(_query(tester), 'C');
    expect(repository.queries, ['', 'A', 'B', 'A', 'C', 'A', 'C']);
  });

  testWidgets('applying saved search enters history, without changing preset', (
    tester,
  ) async {
    final repository = _Repository();
    final store = _Store()
      ..state = const CardBrowserState(
        query: 'is:due',
        sortColumn: null,
        reverse: false,
        savedSearches: [
          BrowserSavedSearch(
            name: 'Learning',
            query: 'is:learn',
            sortColumn: null,
            reverse: false,
          ),
        ],
      );
    await tester.pumpWidget(_app(repository, store));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-saved-search-picker')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Learning').last);
    await tester.pumpAndSettle();
    expect(_query(tester), 'is:learn');

    await tester.tap(find.byKey(const ValueKey('browser-search-history-back')));
    await tester.pumpAndSettle();
    expect(_query(tester), 'is:due');
    expect(store.state!.savedSearches.single.name, 'Learning');
    expect(store.state!.savedSearches.single.query, 'is:learn');

    await tester.tap(find.byKey(const ValueKey('browser-search-history-forward')));
    await tester.pumpAndSettle();
    expect(_query(tester), 'is:learn');
    expect(repository.queries, ['is:due', 'is:learn', 'is:due', 'is:learn']);
  });

  testWidgets('narrow browser exposes searchable history in compact menu', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repository = _Repository();
    await tester.pumpWidget(_app(repository, _Store()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byKey(const ValueKey('browser-compact-actions')), findsOneWidget);
    expect(find.byKey(const ValueKey('browser-search-history-back')), findsNothing);

    await _search(tester, 'is:due');
    await _search(tester, 'is:new');

    await tester.tap(find.byKey(const ValueKey('browser-compact-actions')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Previous search'));
    await tester.pumpAndSettle();
    expect(_query(tester), 'is:due');

    await tester.tap(find.byKey(const ValueKey('browser-compact-actions')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next search'));
    await tester.pumpAndSettle();
    expect(_query(tester), 'is:new');

    await tester.tap(find.byKey(const ValueKey('browser-compact-actions')));
    await tester.pumpAndSettle();
    expect(find.text('Save current search'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sort changes and refresh do not append search history', (
    tester,
  ) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository, _Store()));
    await tester.pumpAndSettle();
    await _search(tester, 'tag:math');

    // Resubmitting the same query should not create a duplicate step.
    await _search(tester, 'tag:math');
    await tester.tap(find.byKey(const ValueKey('card-browser-sort-column')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sort field').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('card-browser-sort-direction')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-search-history-back')));
    await tester.pumpAndSettle();
    expect(_query(tester), '');
    expect(_navButton(tester, 'browser-search-history-back').onPressed, isNull);
    expect(repository.queries, ['', 'tag:math', 'tag:math', 'tag:math', 'tag:math', '']);
  });
}

Widget _app(_Repository repository, _Store store) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _NoNotes(),
    stateStore: store,
  ),
);

IconButton _navButton(WidgetTester tester, String key) =>
    tester.widget<IconButton>(find.byKey(ValueKey(key)));

String _query(WidgetTester tester) => tester
    .widget<TextField>(find.byKey(const ValueKey('card-browser-search')))
    .controller!
    .text;

Future<void> _search(WidgetTester tester, String query) async {
  await tester.enterText(find.byKey(const ValueKey('card-browser-search')), query);
  await tester.testTextInput.receiveAction(TextInputAction.search);
  await tester.pumpAndSettle();
}

class _Store implements BrowserStateStore {
  CardBrowserState? state;

  @override
  Future<CardBrowserState?> load() async => state;

  @override
  Future<void> save(CardBrowserState newState) async {
    state = newState;
  }
}

class _Repository implements CardBrowserRepository {
  final queries = <String>[];

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => const [
    CardBrowserSortOption(
      column: 'noteFld',
      label: 'Sort field',
      reverseByDefault: false,
    ),
  ];

  @override
  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  }) async {
    queries.add(query);
    return const CardBrowserSearchResult(
      totalCount: 1,
      cards: [CardBrowserResult(cardId: 77, cells: ['Card 77'])],
      matchingCardIds: [77],
    );
  }

  @override
  Future<int> noteIdForCard(int cardId) async => cardId + 100;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
