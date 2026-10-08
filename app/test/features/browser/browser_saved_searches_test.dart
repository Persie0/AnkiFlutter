import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('save and reload preset preserves native query and current cards', (
    tester,
  ) async {
    final browser = _BrowserRepository();
    final stateStore = _StateStore();
    await tester.pumpWidget(_app(browser, stateStore));
    await tester.pumpAndSettle();

    await _search(tester, 'deck:French is:due');
    await tester.tap(find.byKey(const ValueKey('select-card-77')));
    await tester.pumpAndSettle();
    await _save(tester, 'French due');

    expect(browser.queries, ['', 'deck:French is:due']);
    expect(stateStore.state!.savedSearches.single.name, 'French due');
    expect(stateStore.state!.savedSearches.single.query, 'deck:French is:due');

    await _search(tester, 'is:new');
    await tester.tap(find.byKey(const ValueKey('browser-saved-search-picker')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('French due').last);
    await tester.pumpAndSettle();

    expect(browser.queries, ['', 'deck:French is:due', 'is:new', 'deck:French is:due']);
    expect(_query(tester), 'deck:French is:due');
    expect(find.text('French due'), findsWidgets);
    expect(find.text('1 card selected'), findsNothing);
    expect(stateStore.state!.query, 'deck:French is:due');
  });

  testWidgets('a saved preset persists across closing and reopening browser', (
    tester,
  ) async {
    final stateStore = _StateStore();
    final browser = _BrowserRepository();
    await tester.pumpWidget(_app(browser, stateStore));
    await tester.pumpAndSettle();
    await _search(tester, 'tag:chemistry');
    await _save(tester, 'Chemistry');

    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
    await tester.pumpAndSettle();
    final reopened = _BrowserRepository();
    await tester.pumpWidget(_app(reopened, stateStore));
    await tester.pumpAndSettle();

    expect(_query(tester), 'tag:chemistry');
    expect(reopened.queries, ['tag:chemistry']);
    expect(find.text('Chemistry'), findsOneWidget);
  });

  testWidgets('overwriting requires confirmation and preserves unique names', (
    tester,
  ) async {
    final stateStore = _StateStore();
    await tester.pumpWidget(_app(_BrowserRepository(), stateStore));
    await tester.pumpAndSettle();
    await _search(tester, 'is:due');
    await _save(tester, 'Daily');
    await _search(tester, 'is:new');
    await _save(tester, 'DAILY', confirmOverwrite: false);
    expect(stateStore.state!.savedSearches.single.query, 'is:due');

    await _save(tester, 'DAILY', confirmOverwrite: true);
    expect(stateStore.state!.savedSearches, hasLength(1));
    expect(stateStore.state!.savedSearches.single.query, 'is:new');
    expect(stateStore.state!.savedSearches.single.name, 'DAILY');
  });

  testWidgets('deleting a saved preset leaves active query unchanged', (
    tester,
  ) async {
    final store = _StateStore();
    final browser = _BrowserRepository();
    await tester.pumpWidget(_app(browser, store));
    await tester.pumpAndSettle();
    await _search(tester, 'tag:math');
    await _save(tester, 'Math');

    await tester.tap(find.byKey(const ValueKey('browser-delete-saved-search')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(store.state!.savedSearches, hasLength(1));

    await tester.tap(find.byKey(const ValueKey('browser-delete-saved-search')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-delete-saved-search')));
    await tester.pumpAndSettle();

    expect(store.state!.savedSearches, isEmpty);
    expect(_query(tester), 'tag:math');
    expect(browser.queries, ['', 'tag:math']);
  });

  testWidgets('empty query cannot be saved and empty name cannot be submitted', (
    tester,
  ) async {
    await tester.pumpWidget(_app(_BrowserRepository(), _StateStore()));
    await tester.pumpAndSettle();
    final save = tester.widget<IconButton>(
      find.byKey(const ValueKey('browser-save-search')),
    );
    expect(save.onPressed, isNull);

    await _search(tester, 'is:due');
    await tester.tap(find.byKey(const ValueKey('browser-save-search')));
    await tester.pumpAndSettle();
    expect(
      tester.widget<FilledButton>(
        find.byKey(const ValueKey('browser-confirm-save-search')),
      ).onPressed,
      isNull,
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });
}

Widget _app(_BrowserRepository repository, _StateStore stateStore) =>
    MaterialApp(
      home: CardBrowserPage(
        repository: repository,
        noteRepository: _NoNotes(),
        stateStore: stateStore,
      ),
    );

String _query(WidgetTester tester) => tester
    .widget<TextField>(find.byKey(const ValueKey('card-browser-search')))
    .controller!
    .text;

Future<void> _search(WidgetTester tester, String query) async {
  await tester.enterText(
    find.byKey(const ValueKey('card-browser-search')),
    query,
  );
  await tester.testTextInput.receiveAction(TextInputAction.search);
  await tester.pumpAndSettle();
}

Future<void> _save(
  WidgetTester tester,
  String name, {
  bool? confirmOverwrite,
}) async {
  await tester.tap(find.byKey(const ValueKey('browser-save-search')));
  await tester.pumpAndSettle();
  await tester.enterText(
    find.byKey(const ValueKey('browser-saved-search-name')),
    name,
  );
  await tester.tap(find.byKey(const ValueKey('browser-confirm-save-search')));
  await tester.pumpAndSettle();

  if (confirmOverwrite != null) {
    expect(find.text('Overwrite saved search?'), findsOneWidget);
    if (confirmOverwrite) {
      await tester.tap(
        find.byKey(const ValueKey('browser-confirm-overwrite-saved-search')),
      );
    } else {
      await tester.tap(find.text('Cancel'));
    }
    await tester.pumpAndSettle();
  }
}

class _StateStore implements BrowserStateStore {
  CardBrowserState? state;

  @override
  Future<CardBrowserState?> load() async => state;

  @override
  Future<void> save(CardBrowserState newState) async {
    state = newState;
  }
}

class _BrowserRepository implements CardBrowserRepository {
  final queries = <String>[];

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

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
  Future<void> applyBulkAction(
    List<int> cardIds,
    CardBulkAction action,
  ) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
