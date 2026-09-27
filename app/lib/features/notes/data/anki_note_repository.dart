import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart'
    as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:fixnum/fixnum.dart';

abstract interface class NoteEntryRepository {
  Future<notetypes.NotetypeUseCounts> getNotetypeNamesAndCounts();

  Future<notes.DeckAndNotetype> defaultsForAdding(int selectedDeckId);

  Future<notetypes.Notetype> getNotetype(int notetypeId);

  Future<notes.Note> newNote(int notetypeId);

  Future<int> addNote({required int deckId, required notes.Note note});
}

/// Sends note-entry requests through the shared native Anki backend.
class AnkiNoteRepository implements NoteEntryRepository {
  const AnkiNoteRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<notetypes.NotetypeUseCounts> getNotetypeNamesAndCounts() async {
    final response = await backend.invoke(
      BackendOperation.getNotetypeNamesAndCounts,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return notetypes.NotetypeUseCounts.fromBuffer(response);
  }

  @override
  Future<notes.DeckAndNotetype> defaultsForAdding(int selectedDeckId) async {
    final request = notes.DefaultsForAddingRequest(
      homeDeckOfCurrentReviewCard: Int64(selectedDeckId),
    );
    final response = await backend.invoke(
      BackendOperation.defaultsForAdding,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return notes.DeckAndNotetype.fromBuffer(response);
  }

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async {
    final request = notetypes.NotetypeId(ntid: Int64(notetypeId));
    final response = await backend.invoke(
      BackendOperation.getNotetype,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return notetypes.Notetype.fromBuffer(response);
  }

  @override
  Future<notes.Note> newNote(int notetypeId) async {
    final request = notetypes.NotetypeId(ntid: Int64(notetypeId));
    final response = await backend.invoke(
      BackendOperation.newNote,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return notes.Note.fromBuffer(response);
  }

  @override
  Future<int> addNote({required int deckId, required notes.Note note}) async {
    final request = notes.AddNoteRequest(note: note, deckId: Int64(deckId));
    final response = await backend.invoke(
      BackendOperation.addNote,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return notes.AddNoteResponse.fromBuffer(response).noteId.toInt();
  }
}
