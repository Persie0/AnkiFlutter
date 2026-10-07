import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('deep-link note query overrides saved browser query once',
      (tester) async {
    final repository = _Repository();
    final store = _Store(
      state: const CardBrowserState(
        query: 'deck:Saved',
        sortColumn: null,
        reverse: false,
      ),
    );

    await tester.pumpWidget(_app(repository, store, initialQuery: 'nid:42 or nid:91'));
    await tester.pumpAndSettle();

    expect(repository.queries, ['nid:42 or nid:91']);
    final field = tester.widget<TextField>(
      find.byKey(const ValueKey('card-browser-search')),
    );
    expect(field.controller!.text, 'nid:42 or nid:91');
    expect(store.writes, isEmpty);
  });

  testWidgets('entry-point query works without previous state', (tester) async {
    final repository = _Repository();
    final store = _Store();

    await tester.pumpWidget(_app(repository, store, initialQuery: 'nid:42'));
    await tester.pumpAndSettle();

    expect(repository.queries, ['nid:42']);
    expect(store.writes, isEmpty);
  });

  testWidgets('ordinary browser still restores saved query', (tester) async {
    final repository = _Repository();
    final store = _Store(
      state: const CardBrowserState(
        query: 'tag:review',
        sortColumn: null,
        reverse: false,
      ),
    );

    await tester.pumpWidget(_app(repository, store));
    await tester.pumpAndSettle();

    expect(repository.queries, ['tag:review']);
  });

  testWidgets('user-submitted query after deep link persists normally',
      (tester) async {
    final repository = _Repository();
    final store = _Store(
      state: const CardBrowserState(
        query: 'deck:Saved',
        sortColumn: null,
        reverse: false,
      ),
    );

    await tester.pumpWidget(_app(repository, store, initialQuery: 'nid:42'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'deck:German',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(repository.queries, ['nid:42', 'deck:German']);
    expect(store.writes.last.query, 'deck:German');
  });
}

Widget _app(_Repository repo, _Store store, {String? initialQuery}) =>
    MaterialApp(
      home: CardBrowserPage(
        repository: repo,
        noteRepository: _NoNotes(),
        stateStore: store,
        initialQuery: initialQuery,
      ),
    );

class _Repository implements CardBrowserRepository {
  final queries = <String>[];

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

  @override
  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  }) async {
    queries.add(query);
    return const CardBrowserSearchResult(totalCount: 0, cards: []);
  }

  @override
  Future<int> noteIdForCard(int cardId) async => 42;

  @override
  Future<void> applyBulkAction(
    List<int> cardIds,
    CardBulkAction action,
  ) async {}
}

class _Store implements BrowserStateStore {
  _Store({this.state});
  final CardBrowserState? state;
  final writes = <CardBrowserState>[];

  @override
  Future<CardBrowserState?> load() async => state;

  @override
  Future<void> save(CardBrowserState state) async => writes.add(state);
}

class _NoNotes extends Fake implements NoteEntryRepository {}
