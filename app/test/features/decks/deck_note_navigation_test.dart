import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:anki_flutter/features/notes/add_note_page.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Add note action opens note entry for the selected deck', (
    tester,
  ) async {
    const deck = DeckNode(
      id: 72,
      name: 'Language',
      newCount: 0,
      learnCount: 0,
      reviewCount: 0,
      filtered: false,
      children: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => DeckOverviewPage(
            deck: deck,
            onAddNote: () async {
              await Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => AddNotePage(
                    deck: deck,
                    repository: _EmptyNoteRepository(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Add note'));
    await tester.pumpAndSettle();

    expect(find.text('Add note to Language'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Study'), findsOneWidget);
  });
}

class _EmptyNoteRepository implements NoteEntryRepository {
  @override
  Future<int> addNote({required int deckId, required notes.Note note}) async =>
      1;

  @override
  Future<notes.DeckAndNotetype> defaultsForAdding(int selectedDeckId) async =>
      throw UnimplementedError();

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async =>
      throw UnimplementedError();

  @override
  Future<notetypes.NotetypeUseCounts> getNotetypeNamesAndCounts() async =>
      notetypes.NotetypeUseCounts();

  @override
  Future<notes.Note> newNote(int notetypeId) async => throw UnimplementedError();
}
