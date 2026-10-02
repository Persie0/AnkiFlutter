import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart' as notetypes;
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('restores the last query and sort before the first search', (
    tester,
  ) async {
    final store = _StateStore(
      const CardBrowserState(
        query: 'deck:Travel',
        sortColumn: 'noteFld',
        reverse: false,
      ),
    );
    final repository = _Repository();

    await tester.pumpWidget(
      MaterialApp(
        home: CardBrowserPage(
          repository: repository,
          noteRepository: _NoteRepository(),
          stateStore: store,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(repository.queries, ['deck:Travel']);
    expect(repository.sorts.single?.column, 'noteFld');
    expect(repository.sorts.single?.reverse, isFalse);
    expect(
      tester
          .widget<TextField>(find.byKey(const ValueKey('card-browser-search')))
          .controller
          ?.text,
      'deck:Travel',
    );
  });

  testWidgets('saves query, sort column and direction after changes', (
    tester,
  ) async {
    final store = _StateStore(null);
    final repository = _Repository();

    await tester.pumpWidget(
      MaterialApp(
        home: CardBrowserPage(
          repository: repository,
          noteRepository: _NoteRepository(),
          stateStore: store,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'tag:lesson-1',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('card-browser-sort-column')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sort field').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('card-browser-sort-direction')));
    await tester.pumpAndSettle();

    expect(store.saved?.query, 'tag:lesson-1');
    expect(store.saved?.sortColumn, 'noteFld');
    expect(store.saved?.reverse, isFalse);
  });
}

class _StateStore implements BrowserStateStore {
  _StateStore(this.initial);

  final CardBrowserState? initial;
  CardBrowserState? saved;

  @override
  Future<CardBrowserState?> load() async => initial;

  @override
  Future<void> save(CardBrowserState state) async {
    saved = state;
  }
}

class _Repository implements CardBrowserRepository {
  final queries = <String>[];
  final sorts = <CardBrowserSort?>[];

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => const [
    CardBrowserSortOption(
      column: 'noteFld',
      label: 'Sort field',
      reverseByDefault: true,
    ),
  ];

  @override
  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  }) async {
    queries.add(query);
    sorts.add(sort);
    return const CardBrowserSearchResult(totalCount: 0, cards: []);
  }

  @override
  Future<int> noteIdForCard(int cardId) async => 42;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}
}

class _NoteRepository implements NoteEntryRepository {
  @override
  Future<notes.Note> getNote(int noteId) async => throw UnimplementedError();

  @override
  Future<void> updateNote(notes.Note note) async => throw UnimplementedError();

  @override
  Future<int> addNote({required int deckId, required notes.Note note}) async =>
      throw UnimplementedError();

  @override
  Future<notes.DeckAndNotetype> defaultsForAdding(int selectedDeckId) async =>
      throw UnimplementedError();

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async =>
      throw UnimplementedError();

  @override
  Future<notetypes.NotetypeUseCounts> getNotetypeNamesAndCounts() async =>
      throw UnimplementedError();

  @override
  Future<notes.Note> newNote(int notetypeId) async => throw UnimplementedError();
}
