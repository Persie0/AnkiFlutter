import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads notetype choices from Anki', () async {
    final response = notetypes.NotetypeUseCounts(
      entries: [
        notetypes.NotetypeNameIdUseCount(
          id: Int64(12),
          name: 'Basic',
          useCount: 4,
        ),
      ],
    );
    final backend = _Backend(response.writeToBuffer());
    final repository = AnkiNoteRepository(backend: backend);

    final result = await repository.getNotetypeNamesAndCounts();

    expect(backend.calls.single.operation, BackendOperation.getNotetypeNamesAndCounts);
    expect(
      generic.Empty.fromBuffer(backend.calls.single.request),
      generic.Empty(),
    );
    expect(result.entries.single.name, 'Basic');
    expect(result.entries.single.id, Int64(12));
  });

  test('gets Anki defaults using the deck the user selected', () async {
    final response = notes.DeckAndNotetype(
      deckId: Int64(72),
      notetypeId: Int64(12),
    );
    final backend = _Backend(response.writeToBuffer());
    final repository = AnkiNoteRepository(backend: backend);

    final result = await repository.defaultsForAdding(72);

    expect(backend.calls.single.operation, BackendOperation.defaultsForAdding);
    expect(
      notes.DefaultsForAddingRequest.fromBuffer(backend.calls.single.request),
      notes.DefaultsForAddingRequest(
        homeDeckOfCurrentReviewCard: Int64(72),
      ),
    );
    expect(result.notetypeId, Int64(12));
  });

  test('loads the selected notetype and initializes a fresh note', () async {
    final typeResponse = notetypes.Notetype(
      id: Int64(12),
      name: 'Basic',
    );
    final noteResponse = notes.Note(
      id: Int64(100),
      notetypeId: Int64(12),
      fields: ['front', 'back'],
    );
    final backend = _BackendSequence([
      typeResponse.writeToBuffer(),
      noteResponse.writeToBuffer(),
    ]);
    final repository = AnkiNoteRepository(backend: backend);

    final type = await repository.getNotetype(12);
    final note = await repository.newNote(12);

    expect(backend.calls.map((call) => call.operation), [
      BackendOperation.getNotetype,
      BackendOperation.newNote,
    ]);
    expect(
      notetypes.NotetypeId.fromBuffer(backend.calls[0].request),
      notetypes.NotetypeId(ntid: Int64(12)),
    );
    expect(type.name, 'Basic');
    expect(
      notetypes.NotetypeId.fromBuffer(backend.calls[1].request),
      notetypes.NotetypeId(ntid: Int64(12)),
    );
    expect(note.fields, ['front', 'back']);
  });

  test('adds the supplied note to the selected deck and returns its ID', () async {
    final note = notes.Note(
      id: Int64(100),
      notetypeId: Int64(12),
      fields: ['front text', 'back text'],
    );
    final backend = _Backend(notes.AddNoteResponse(noteId: Int64(345)).writeToBuffer());
    final repository = AnkiNoteRepository(backend: backend);

    final noteId = await repository.addNote(deckId: 72, note: note);

    expect(backend.calls.single.operation, BackendOperation.addNote);
    expect(
      notes.AddNoteRequest.fromBuffer(backend.calls.single.request),
      notes.AddNoteRequest(note: note, deckId: Int64(72)),
    );
    expect(noteId, 345);
  });

  test('loads an existing note by its Anki note ID', () async {
    final expected = notes.Note(
      id: Int64(42),
      notetypeId: Int64(12),
      fields: ['front', 'back'],
      tags: ['lesson-1'],
    );
    final backend = _Backend(expected.writeToBuffer());
    final repository = AnkiNoteRepository(backend: backend);

    final note = await repository.getNote(42);

    expect(backend.calls.single.operation, BackendOperation.getNote);
    expect(
      notes.NoteId.fromBuffer(backend.calls.single.request),
      notes.NoteId(nid: Int64(42)),
    );
    expect(note, expected);
  });

  test('updates an existing note through Anki with an undo entry', () async {
    final note = notes.Note(
      id: Int64(42),
      notetypeId: Int64(12),
      fields: ['changed front', 'changed back'],
      tags: ['lesson-2'],
    );
    final backend = _Backend(Uint8List(0));
    final repository = AnkiNoteRepository(backend: backend);

    await repository.updateNote(note);

    expect(backend.calls.single.operation, BackendOperation.updateNotes);
    expect(
      notes.UpdateNotesRequest.fromBuffer(backend.calls.single.request),
      notes.UpdateNotesRequest(notes: [note], skipUndoEntry: false),
    );
  });
}

class _Call {
  const _Call(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.response);

  final Uint8List response;
  final calls = <_Call>[];

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    return response;
  }
}

class _BackendSequence implements BackendInvoker {
  _BackendSequence(this.responses);

  final List<Uint8List> responses;
  final calls = <_Call>[];
  var _index = 0;

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    return responses[_index++];
  }
}
