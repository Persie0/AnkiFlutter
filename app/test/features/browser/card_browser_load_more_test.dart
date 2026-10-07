import 'dart:async';

import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('loads remaining rows without repeating native search', (tester) async {
    final repository = _PagingRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.text('Showing 2 of 5 matches.'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-load-more')));
    await tester.pumpAndSettle();

    expect(repository.pageRequests, [[30, 40]]);
    expect(repository.searchQueries, ['']);
    expect(find.text('Card 30'), findsOneWidget);
    expect(find.text('Card 40'), findsOneWidget);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.text('Showing 4 of 5 matches.'), findsOneWidget);

    final button = find.byKey(const ValueKey('browser-load-more'));
    await tester.scrollUntilVisible(button, 220);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(repository.pageRequests, [[30, 40], [50]]);
    expect(find.text('Card 50'), findsOneWidget);
    expect(find.byKey(const ValueKey('browser-load-more')), findsNothing);
    expect(repository.searchQueries, ['']);
  });

  testWidgets('failed page rendering preserves existing rows and allows retry', (tester) async {
    final repository = _PagingRepository()..failNextPage = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-load-more')));
    await tester.pumpAndSettle();

    expect(find.text('Card 10'), findsOneWidget);
    expect(find.text('Card 30'), findsNothing);
    expect(find.textContaining('temporary render error'), findsOneWidget);
    expect(find.byKey(const ValueKey('browser-load-more')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('browser-load-more')));
    await tester.pumpAndSettle();
    expect(find.text('Card 30'), findsOneWidget);
    expect(repository.searchQueries, ['']);
  });

  testWidgets('stale page completion cannot overwrite a newer search', (tester) async {
    final repository = _PagingRepository();
    repository.pendingPage = Completer<List<CardBrowserResult>>();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-load-more')));
    await tester.pump();
    expect(repository.pageRequests, [[30, 40]]);

    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'deck:Other',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    repository.pendingPage!.complete([
      const CardBrowserResult(cardId: 30, cells: ['Stale card']),
      const CardBrowserResult(cardId: 40, cells: ['Stale card']),
    ]);
    await tester.pumpAndSettle();

    expect(repository.searchQueries, ['', 'deck:Other']);
    expect(find.text('New search result'), findsOneWidget);
    expect(find.text('Stale card'), findsNothing);
  });
}

Widget _app(_PagingRepository repository) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _UnusedNoteRepository(),
    stateStore: _StateStore(),
  ),
);

class _PagingRepository implements CardBrowserRepository, CardBrowserPagingRepository {
  final List<String> searchQueries = [];
  final List<List<int>> pageRequests = [];
  bool failNextPage = false;
  Completer<List<CardBrowserResult>>? pendingPage;

  @override
  int get pageSize => 2;

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

  @override
  Future<CardBrowserSearchResult> search(String query, {CardBrowserSort? sort}) async {
    searchQueries.add(query);
    if (query.isNotEmpty) {
      return const CardBrowserSearchResult(
        totalCount: 1,
        matchingCardIds: [99],
        cards: [CardBrowserResult(cardId: 99, cells: ['New search result'])],
      );
    }
    return const CardBrowserSearchResult(
      totalCount: 5,
      matchingCardIds: [10, 20, 30, 40, 50],
      cards: [
        CardBrowserResult(cardId: 10, cells: ['Card 10']),
        CardBrowserResult(cardId: 20, cells: ['Card 20']),
      ],
    );
  }

  @override
  Future<List<CardBrowserResult>> renderMore(List<int> cardIds) async {
    pageRequests.add(List.of(cardIds));
    if (failNextPage) {
      failNextPage = false;
      throw StateError('temporary render error');
    }
    if (pendingPage case final completer?) return completer.future;
    return cardIds
        .map((id) => CardBrowserResult(cardId: id, cells: ['Card $id']))
        .toList(growable: false);
  }

  @override
  Future<int> noteIdForCard(int cardId) async => 10;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _UnusedNoteRepository extends Fake implements NoteEntryRepository {}
