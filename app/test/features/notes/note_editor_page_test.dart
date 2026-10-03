import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/features/notes/note_editor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fixnum/fixnum.dart';

void main() {
  testWidgets('loads note fields in notetype order and shows its tags', (
    tester,
  ) async {
    final repository = _NoteRepository();
    await _openEditor(tester, repository);

    expect(find.text('Front'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Tags'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byKey(const ValueKey('note-field-0')))
          .controller
          ?.text,
      'front original',
    );
    expect(
      tester.widget<TextField>(find.byKey(const ValueKey('note-field-1')))
          .controller
          ?.text,
      'back original',
    );
    expect(
      tester.widget<TextField>(find.byKey(const ValueKey('note-tags')))
          .controller
          ?.text,
      'tag-one tag-two',
    );
  });

  testWidgets('saves edited fields and tags and returns success', (tester) async {
    final repository = _NoteRepository();
    final results = await _openEditor(tester, repository);

    await tester.enterText(
      find.byKey(const ValueKey('note-field-0')),
      'front updated',
    );
    await tester.enterText(
      find.byKey(const ValueKey('note-tags')),
      'new-tag  second-tag',
    );
    await tester.tap(find.text('Save note'));
    await tester.pumpAndSettle();

    expect(repository.validatedNote?.fields.first, 'front updated');
    expect(repository.updateCount, 1);
    expect(repository.savedNote?.fields, ['front updated', 'back original']);
    expect(repository.savedNote?.tags, ['new-tag', 'second-tag']);
    expect(results, [true]);
  });

  testWidgets('duplicate edit requires explicit confirmation', (tester) async {
    final repository = _NoteRepository()
      ..validationState = notes.NoteFieldsCheckResponse_State.DUPLICATE;
    final results = await _openEditor(tester, repository);
    await tester.enterText(
      find.byKey(const ValueKey('note-field-0')),
      'duplicate front',
    );

    await tester.tap(find.text('Save note'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Duplicate note'), findsOneWidget);
    expect(repository.updateCount, 0);
    await tester.tap(find.text('Save anyway'));
    await tester.pumpAndSettle();

    expect(repository.updateCount, 1);
    expect(results, [true]);
  });

  testWidgets('keeps edits after update failure and retries the save', (
    tester,
  ) async {
    final repository = _NoteRepository()..failNextUpdate = true;
    final results = await _openEditor(tester, repository);
    await tester.enterText(
      find.byKey(const ValueKey('note-field-0')),
      'keep this edit',
    );
    await tester.tap(find.text('Save note'));
    await tester.pumpAndSettle();

    expect(find.textContaining('temporarily unavailable'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byKey(const ValueKey('note-field-0')))
          .controller
          ?.text,
      'keep this edit',
    );
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(repository.updateCount, 2);
    expect(repository.savedNote?.fields.first, 'keep this edit');
    expect(results, [true]);
  });
}

Future<List<bool?>> _openEditor(
  WidgetTester tester,
  _NoteRepository repository,
) async {
  final results = <bool?>[];
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: FilledButton(
              onPressed: () {
                Navigator.of(context)
                    .push<bool>(
                      MaterialPageRoute<bool>(
                        builder: (_) => NoteEditorPage.edit(
                          noteId: 42,
                          repository: repository,
                        ),
                      ),
                    )
                    .then(results.add);
              },
              child: const Text('Open editor'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open editor'));
  await tester.pumpAndSettle();
  return results;
}

class _NoteRepository implements NoteEntryRepository, NoteValidationRepository {
  bool failNextUpdate = false;
  int updateCount = 0;
  notes.Note? savedNote;
  notes.Note? validatedNote;
  var validationState = notes.NoteFieldsCheckResponse_State.NORMAL;

  @override
  Future<notes.NoteFieldsCheckResponse_State> checkNoteFields(notes.Note note) async {
    validatedNote = notes.Note.fromBuffer(note.writeToBuffer());
    return validationState;
  }

  @override
  Future<notes.Note> getNote(int noteId) async => notes.Note(
    id: Int64(noteId),
    notetypeId: Int64(7),
    fields: ['front original', 'back original'],
    tags: ['tag-one', 'tag-two'],
  );

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
    updateCount++;
    if (failNextUpdate) {
      failNextUpdate = false;
      throw StateError('temporarily unavailable');
    }
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
  Future<notes.Note> newNote(int notetypeId) async => throw UnimplementedError();
}
