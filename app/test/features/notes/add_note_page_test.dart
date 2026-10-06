import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/notes/add_note_page.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const deck = DeckNode(
    id: 72,
    name: 'Language',
    newCount: 0,
    learnCount: 0,
    reviewCount: 0,
    filtered: false,
    children: [],
  );

  testWidgets('renders Anki field labels in the note type order', (tester) async {
    final repository = _NoteRepository();
    await _showPage(tester, repository, deck);

    expect(find.text('Front'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(
      tester
          .widgetList<TextField>(find.byType(TextField))
          .map((field) => field.decoration?.labelText),
      ['Front', 'Back', 'Tags'],
    );
    expect(repository.defaultsDeckId, 72);
  });

  testWidgets('uses Anki default note type for the selected deck', (tester) async {
    final repository = _NoteRepository(
      notetypeChoices: [_typeChoice(1, 'Basic'), _typeChoice(2, 'Cloze')],
      defaultNotetypeId: 2,
    );
    await _showPage(tester, repository, deck);

    expect(repository.loadedNotetypeIds, [2]);
    expect(find.text('Text'), findsOneWidget);
  });

  testWidgets('changing note type loads its fields and note values', (tester) async {
    final repository = _NoteRepository(
      notetypeChoices: [
        _typeChoice(1, 'Basic'),
        _typeChoice(2, 'Cloze'),
      ],
    );
    await _showPage(tester, repository, deck);
    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cloze').last);
    await tester.pumpAndSettle();

    expect(find.text('Text'), findsOneWidget);
    expect(find.text('Extra'), findsOneWidget);
    expect(repository.loadedNotetypeIds, contains(2));
  });

  testWidgets('saves to the selected deck and resets after success', (tester) async {
    final repository = _NoteRepository();
    await _showPage(tester, repository, deck);

    await tester.enterText(find.byKey(const ValueKey('note-field-0')), 'hola');
    await tester.enterText(find.byKey(const ValueKey('note-field-1')), 'hello');
    await tester.enterText(find.byKey(const ValueKey('note-tags')), 'lesson-1');
    await tester.tap(find.text('Add note'));
    await tester.pumpAndSettle();

    expect(repository.validatedNote!.fields, ['hola', 'hello']);
    expect(repository.savedDeckId, 72);
    expect(repository.savedNote!.fields, ['hola', 'hello']);
    expect(repository.savedNote!.tags, ['lesson-1']);
    expect(
      tester.widget<TextField>(
        find.byKey(const ValueKey('note-field-0')),
      ).controller!.text,
      isEmpty,
    );
    expect(find.text('Note added'), findsOneWidget);
  });

  testWidgets('duplicate note requires explicit confirmation', (tester) async {
    final repository = _NoteRepository()
      ..validationState = notes.NoteFieldsCheckResponse_State.DUPLICATE;
    await _showPage(tester, repository, deck);

    await tester.enterText(find.byKey(const ValueKey('note-field-0')), 'same');
    await tester.enterText(find.byKey(const ValueKey('note-field-1')), 'answer');
    await tester.tap(find.text('Add note'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Duplicate note'), findsOneWidget);
    expect(repository.savedNote, isNull);
    await tester.tap(find.text('Add anyway'));
    await tester.pumpAndSettle();

    expect(repository.savedNote!.fields.first, 'same');
  });

  testWidgets('hard note validation errors block add', (tester) async {
    final repository = _NoteRepository()
      ..validationState = notes.NoteFieldsCheckResponse_State.EMPTY;
    await _showPage(tester, repository, deck);

    await tester.enterText(find.byKey(const ValueKey('note-field-1')), 'answer');
    await tester.tap(find.text('Add note'));
    await tester.pumpAndSettle();

    expect(repository.savedNote, isNull);
    expect(find.byKey(const ValueKey('add-note-error')), findsOneWidget);
    expect(find.textContaining('first field is empty'), findsOneWidget);
  });

  testWidgets('locks note type selection while the save is pending', (
    tester,
  ) async {
    final repository = _NoteRepository()..pendingSave = Completer<void>();
    await _showPage(tester, repository, deck);

    await tester.enterText(find.byKey(const ValueKey('note-field-0')), 'hola');
    await tester.tap(find.text('Add note'));
    await tester.pump();

    expect(
      tester.widget<DropdownButtonFormField<int>>(
        find.byType(DropdownButtonFormField<int>),
      ).onChanged,
      isNull,
    );
    repository.pendingSave!.complete();
    await tester.pumpAndSettle();
    expect(repository.savedNote!.fields.first, 'hola');
  });

  testWidgets('preserves entered values when Anki rejects a note', (tester) async {
    final repository = _NoteRepository()..failSave = true;
    await _showPage(tester, repository, deck);

    await tester.enterText(find.byKey(const ValueKey('note-field-0')), 'existing');
    await tester.tap(find.text('Add note'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(
        find.byKey(const ValueKey('note-field-0')),
      ).controller!.text,
      'existing',
    );
    expect(find.byKey(const ValueKey('add-note-error')), findsOneWidget);
  });

  testWidgets('create copy prefills fields and tags but saves a fresh note', (tester) async {
    final repository = _NoteRepository()
      ..sourceNote = notes.Note(
        id: Int64(999),
        notetypeId: Int64(1),
        fields: ['copied front', 'copied back'],
        tags: ['source-tag'],
      );

    await tester.pumpWidget(
      MaterialApp(
        home: AddNotePage(
          deck: deck,
          repository: repository,
          sourceNoteId: 999,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(find.byKey(const ValueKey('note-field-0'))).controller!.text,
      'copied front',
    );
    expect(
      tester.widget<TextField>(find.byKey(const ValueKey('note-field-1'))).controller!.text,
      'copied back',
    );
    expect(
      tester.widget<TextField>(find.byKey(const ValueKey('note-tags'))).controller!.text,
      'source-tag',
    );

    await tester.tap(find.text('Add note'));
    await tester.pumpAndSettle();

    expect(repository.requestedNoteIds, [999]);
    expect(repository.defaultsDeckId, isNull);
    expect(repository.savedDeckId, 72);
    expect(repository.savedNote!.id.toInt(), isNot(999));
    expect(repository.savedNote!.fields, ['copied front', 'copied back']);
    expect(repository.savedNote!.tags, ['source-tag']);
  });

  testWidgets('explains when the collection has no note types', (tester) async {
    final repository = _NoteRepository(notetypeChoices: []);
    await _showPage(tester, repository, deck);

    expect(find.text('This collection has no note types.'), findsOneWidget);
  });
}

Future<void> _showPage(
  WidgetTester tester,
  NoteEntryRepository repository,
  DeckNode deck,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: AddNotePage(deck: deck, repository: repository),
    ),
  );
  await tester.pumpAndSettle();
}

notetypes.NotetypeNameIdUseCount _typeChoice(int id, String name) =>
    notetypes.NotetypeNameIdUseCount(
      id: Int64(id),
      name: name,
      useCount: 0,
    );

class _NoteRepository implements NoteEntryRepository, NoteValidationRepository {
  _NoteRepository({
    List<notetypes.NotetypeNameIdUseCount>? notetypeChoices,
    this.defaultNotetypeId,
  }) : notetypeChoices = notetypeChoices ?? [_typeChoice(1, 'Basic')];

  final List<notetypes.NotetypeNameIdUseCount> notetypeChoices;
  final loadedNotetypeIds = <int>[];
  final int? defaultNotetypeId;
  int? defaultsDeckId;
  int? savedDeckId;
  notes.Note? savedNote;
  notes.Note? validatedNote;
  notes.Note? sourceNote;
  final requestedNoteIds = <int>[];
  Completer<void>? pendingSave;
  bool failSave = false;
  var validationState = notes.NoteFieldsCheckResponse_State.NORMAL;
  var _newNoteId = 0;

  @override
  Future<notes.NoteFieldsCheckResponse_State> checkNoteFields(notes.Note note) async {
    validatedNote = notes.Note.fromBuffer(note.writeToBuffer());
    return validationState;
  }

  @override
  Future<int> addNote({required int deckId, required notes.Note note}) async {
    if (failSave) throw StateError('duplicate note');
    await pendingSave?.future;
    savedDeckId = deckId;
    savedNote = notes.Note.fromBuffer(note.writeToBuffer());
    return 345;
  }

  @override
  Future<notes.DeckAndNotetype> defaultsForAdding(int selectedDeckId) async {
    defaultsDeckId = selectedDeckId;
    return notes.DeckAndNotetype(
      deckId: Int64(selectedDeckId),
      notetypeId: Int64(
        defaultNotetypeId ?? notetypeChoices.first.id.toInt(),
      ),
    );
  }

  @override
  Future<notetypes.NotetypeUseCounts> getNotetypeNamesAndCounts() async =>
      notetypes.NotetypeUseCounts(entries: notetypeChoices);

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async {
    loadedNotetypeIds.add(notetypeId);
    return notetypes.Notetype(
      id: Int64(notetypeId),
      name: notetypeChoices
          .firstWhere((entry) => entry.id.toInt() == notetypeId)
          .name,
      fields: notetypeId == 1
          ? [
              notetypes.Notetype_Field(name: 'Front'),
              notetypes.Notetype_Field(name: 'Back'),
            ]
          : [
              notetypes.Notetype_Field(name: 'Text'),
              notetypes.Notetype_Field(name: 'Extra'),
            ],
    );
  }

  @override
  Future<notes.Note> newNote(int notetypeId) async {
    _newNoteId++;
    return notes.Note(
      id: Int64(_newNoteId),
      notetypeId: Int64(notetypeId),
      fields: ['', ''],
    );
  }

  @override
  Future<notes.Note> getNote(int noteId) async {
    requestedNoteIds.add(noteId);
    final note = sourceNote;
    if (note == null) throw StateError('missing source note');
    return notes.Note.fromBuffer(note.writeToBuffer());
  }

  @override
  Future<void> updateNote(notes.Note note) async => throw UnimplementedError();
}
