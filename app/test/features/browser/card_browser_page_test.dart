import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart'
    as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('submits Anki search text and renders configured row cells', (
    tester,
  ) async {
    final repository = _SequenceRepository([
      _result('Front preview', 'Language'),
      _result('Norwegian', 'Travel'),
    ]);

    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    expect(find.text('Front preview'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'deck:Travel',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(repository.queries, ['', 'deck:Travel']);
    expect(find.text('Norwegian'), findsOneWidget);
    expect(find.text('Travel'), findsOneWidget);
  });

  testWidgets('shows an empty-search message when Anki finds no cards', (
    tester,
  ) async {
    final repository = _SequenceRepository([
      const CardBrowserSearchResult(totalCount: 0, cards: []),
    ]);

    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.text('No cards match this search.'), findsOneWidget);
  });

  testWidgets('explains when results are limited to the first 50 rows', (
    tester,
  ) async {
    final repository = _SequenceRepository([
      CardBrowserSearchResult(
        totalCount: 51,
        cards: [
          for (var id = 0; id < 50; id++)
            CardBrowserResult(cardId: id, cells: ['Card $id']),
        ],
      ),
    ]);

    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    final message = find.text('Showing 50 of 51 matches. Refine your search.');
    await tester.scrollUntilVisible(
      message,
      400,
      scrollable: find.descendant(
        of: find.byType(ListView),
        matching: find.byType(Scrollable),
      ),
    );

    expect(message, findsOneWidget);
    expect(find.text('Card 49'), findsOneWidget);
  });

  testWidgets('allows retry after a search failure', (tester) async {
    final repository = _SequenceRepository([
      StateError('backend is busy'),
      _result('Recovered card'),
    ]);

    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    expect(find.textContaining('backend is busy'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(repository.queries, ['', '']);
    expect(find.text('Recovered card'), findsOneWidget);
  });

  testWidgets(
    'confirms selected cards before suspending and refreshes the current query',
    (tester) async {
      final filtered = _cards(10, 20);
      final repository = _SequenceRepository([
        _result('All cards'),
        filtered,
        filtered,
      ]);

      await tester.pumpWidget(_app(repository));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('card-browser-search')),
        'deck:Language',
      );
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('select-card-10')));
      await tester.tap(find.byKey(const ValueKey('select-card-20')));
      await tester.pumpAndSettle();

      expect(find.text('2 cards selected'), findsOneWidget);
      await tester.tap(find.text('Suspend selected'));
      await tester.pumpAndSettle();

      expect(find.text('Suspend 2 cards?'), findsOneWidget);
      expect(repository.bulkActions, isEmpty);
      await tester.tap(find.byKey(const ValueKey('confirm-card-bulk-action')));
      await tester.pumpAndSettle();

      expect(repository.bulkActions, hasLength(1));
      expect(repository.bulkActions.single.key, [10, 20]);
      expect(repository.bulkActions.single.value, CardBulkAction.suspend);
      expect(repository.queries, ['', 'deck:Language', 'deck:Language']);
      expect(find.text('2 cards selected'), findsNothing);
    },
  );

  testWidgets('canceling a bulk action keeps the selection', (tester) async {
    final repository = _SequenceRepository([_cards(10, 20)]);
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bury selected'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.bulkActions, isEmpty);
    expect(find.text('1 card selected'), findsOneWidget);
  });

  testWidgets('retains the selection after a backend action fails', (
    tester,
  ) async {
    final repository = _SequenceRepository([_cards(10, 20)])
      ..bulkActionError = StateError('backend unavailable');
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Suspend selected'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-card-bulk-action')));
    await tester.pumpAndSettle();

    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('backend unavailable'), findsOneWidget);
    expect(repository.queries, ['']);
  });

  testWidgets('clears selection when a new search is submitted', (
    tester,
  ) async {
    final repository = _SequenceRepository([_cards(10, 20), _cards(30, 40)]);
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    expect(find.text('1 card selected'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'tag:new-search',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(find.text('1 card selected'), findsNothing);
    expect(repository.queries, ['', 'tag:new-search']);
  });
}

Widget _app(CardBrowserRepository repository) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _EmptyNoteRepository(),
  ),
);

CardBrowserSearchResult _result(String first, [String second = '']) =>
    CardBrowserSearchResult(
      totalCount: 1,
      cards: [
        CardBrowserResult(cardId: 123, cells: [first, second]),
      ],
    );

CardBrowserSearchResult _cards(int firstId, int secondId) =>
    CardBrowserSearchResult(
      totalCount: 2,
      cards: [
        CardBrowserResult(cardId: firstId, cells: ['Card $firstId']),
        CardBrowserResult(cardId: secondId, cells: ['Card $secondId']),
      ],
    );

class _SequenceRepository implements CardBrowserRepository {
  _SequenceRepository(this.outcomes);
  final List<Object> outcomes;
  final queries = <String>[];
  final bulkActions = <MapEntry<List<int>, CardBulkAction>>[];
  Object? bulkActionError;

  @override
  Future<int> noteIdForCard(int cardId) async => 42;

  @override
  Future<CardBrowserSearchResult> search(String query) async {
    queries.add(query);
    final outcome = outcomes[queries.length - 1];
    if (outcome is Error) throw outcome;
    return outcome as CardBrowserSearchResult;
  }

  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {
    bulkActions.add(MapEntry(List.of(cardIds), action));
    if (bulkActionError case final error?) throw error;
  }
}

class _EmptyNoteRepository implements NoteEntryRepository {
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
  Future<notes.Note> newNote(int notetypeId) async =>
      throw UnimplementedError();
}
