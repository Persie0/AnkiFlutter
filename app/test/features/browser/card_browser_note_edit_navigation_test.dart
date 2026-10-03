import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart'
    as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fixnum/fixnum.dart';

void main() {
  testWidgets('edits a browser note and refreshes the retained query', (
    tester,
  ) async {
    final browser = _BrowserRepository([
      _result('Original row'),
      _result('Original row'),
      _result('Updated row'),
    ]);
    final notes = _NoteRepository();
    await tester.pumpWidget(_app(browser, notes));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'tag:lesson',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit note'));
    await tester.pumpAndSettle();

    expect(browser.requestedNoteCards, [77]);
    expect(notes.loadedNoteIds, [42]);
    await tester.enterText(
      find.byKey(const ValueKey('note-field-0')),
      'changed in browser',
    );
    await tester.tap(find.text('Save note'));
    await tester.pumpAndSettle();

    expect(notes.savedNote?.fields.first, 'changed in browser');
    expect(browser.queries, ['', 'tag:lesson', 'tag:lesson']);
    expect(find.text('Updated row'), findsOneWidget);
  });

  testWidgets('shows a retryable missing-note error and keeps the browser', (
    tester,
  ) async {
    final browser = _BrowserRepository([_result('Still usable row')]);
    final notes = _NoteRepository()..missingNote = true;
    await tester.pumpWidget(_app(browser, notes));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit note'));
    await tester.pumpAndSettle();

    expect(find.textContaining('note was deleted'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Still usable row'), findsOneWidget);
    expect(
      tester
          .widget<TextField>(find.byKey(const ValueKey('card-browser-search')))
          .controller
          ?.text,
      isEmpty,
    );
  });
}

Widget _app(_BrowserRepository browser, _NoteRepository notes) => MaterialApp(
  home: CardBrowserPage(
    repository: browser,
    noteRepository: notes,
    stateStore: _StateStore(),
  ),
);

CardBrowserSearchResult _result(String cell) => CardBrowserSearchResult(
  totalCount: 1,
  cards: [
    CardBrowserResult(cardId: 77, cells: [cell]),
  ],
);

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _BrowserRepository implements CardBrowserRepository {
  _BrowserRepository(this.results);

  final List<CardBrowserSearchResult> results;
  final queries = <String>[];
  final requestedNoteCards = <int>[];

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => const [];

  @override
  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  }) async {
    queries.add(query);
    return results[queries.length - 1];
  }

  @override
  Future<int> noteIdForCard(int cardId) async {
    requestedNoteCards.add(cardId);
    return 42;
  }

  @override
  Future<void> applyBulkAction(
    List<int> cardIds,
    CardBulkAction action,
  ) async {}
}

class _NoteRepository implements NoteEntryRepository {
  bool missingNote = false;
  final loadedNoteIds = <int>[];
  notes.Note? savedNote;

  @override
  Future<notes.Note> getNote(int noteId) async {
    loadedNoteIds.add(noteId);
    if (missingNote) throw StateError('note was deleted');
    return notes.Note(
      id: Int64(noteId),
      notetypeId: Int64(5),
      fields: ['front', 'back'],
      tags: ['lesson'],
    );
  }

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async =>
      notetypes.Notetype(
        id: Int64(notetypeId),
        name: 'Basic',
        fields: [
          notetypes.Notetype_Field(name: 'Front'),
          notetypes.Notetype_Field(name: 'Back'),
        ],
      );

  @override
  Future<void> updateNote(notes.Note note) async {
    savedNote = notes.Note.fromBuffer(note.writeToBuffer());
  }

  @override
  Future<int> addNote({required int deckId, required notes.Note note}) async =>
      throw UnimplementedError();

  @override
  Future<notes.DeckAndNotetype> defaultsForAdding(int selectedDeckId) async =>
      throw UnimplementedError();

  @override
  Future<notetypes.NotetypeUseCounts> getNotetypeNamesAndCounts() async =>
      throw UnimplementedError();

  @override
  Future<notes.Note> newNote(int notetypeId) async =>
      throw UnimplementedError();
}
