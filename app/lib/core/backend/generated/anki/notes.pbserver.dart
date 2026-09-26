// This is a generated file - do not edit.
//
// Generated from anki/notes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'cards.pb.dart' as $3;
import 'collection.pb.dart' as $0;
import 'decks.pb.dart' as $2;
import 'notes.pb.dart' as $4;
import 'notes.pbjson.dart';
import 'notetypes.pb.dart' as $1;

export 'notes.pb.dart';

abstract class NotesServiceBase extends $pb.GeneratedService {
  $async.Future<$4.Note> newNote($pb.ServerContext ctx, $1.NotetypeId request);
  $async.Future<$4.AddNoteResponse> addNote(
      $pb.ServerContext ctx, $4.AddNoteRequest request);
  $async.Future<$4.AddNotesResponse> addNotes(
      $pb.ServerContext ctx, $4.AddNotesRequest request);
  $async.Future<$4.DeckAndNotetype> defaultsForAdding(
      $pb.ServerContext ctx, $4.DefaultsForAddingRequest request);
  $async.Future<$2.DeckId> defaultDeckForNotetype(
      $pb.ServerContext ctx, $1.NotetypeId request);
  $async.Future<$0.OpChanges> updateNotes(
      $pb.ServerContext ctx, $4.UpdateNotesRequest request);
  $async.Future<$4.Note> getNote($pb.ServerContext ctx, $4.NoteId request);
  $async.Future<$0.OpChangesWithCount> removeNotes(
      $pb.ServerContext ctx, $4.RemoveNotesRequest request);
  $async.Future<$4.ClozeNumbersInNoteResponse> clozeNumbersInNote(
      $pb.ServerContext ctx, $4.Note request);
  $async.Future<$0.OpChangesWithCount> afterNoteUpdates(
      $pb.ServerContext ctx, $4.AfterNoteUpdatesRequest request);
  $async.Future<$4.FieldNamesForNotesResponse> fieldNamesForNotes(
      $pb.ServerContext ctx, $4.FieldNamesForNotesRequest request);
  $async.Future<$4.NoteFieldsCheckResponse> noteFieldsCheck(
      $pb.ServerContext ctx, $4.Note request);
  $async.Future<$3.CardIds> cardsOfNote(
      $pb.ServerContext ctx, $4.NoteId request);
  $async.Future<$1.NotetypeId> getSingleNotetypeOfNotes(
      $pb.ServerContext ctx, $4.NoteIds request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'NewNote':
        return $1.NotetypeId();
      case 'AddNote':
        return $4.AddNoteRequest();
      case 'AddNotes':
        return $4.AddNotesRequest();
      case 'DefaultsForAdding':
        return $4.DefaultsForAddingRequest();
      case 'DefaultDeckForNotetype':
        return $1.NotetypeId();
      case 'UpdateNotes':
        return $4.UpdateNotesRequest();
      case 'GetNote':
        return $4.NoteId();
      case 'RemoveNotes':
        return $4.RemoveNotesRequest();
      case 'ClozeNumbersInNote':
        return $4.Note();
      case 'AfterNoteUpdates':
        return $4.AfterNoteUpdatesRequest();
      case 'FieldNamesForNotes':
        return $4.FieldNamesForNotesRequest();
      case 'NoteFieldsCheck':
        return $4.Note();
      case 'CardsOfNote':
        return $4.NoteId();
      case 'GetSingleNotetypeOfNotes':
        return $4.NoteIds();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'NewNote':
        return newNote(ctx, request as $1.NotetypeId);
      case 'AddNote':
        return addNote(ctx, request as $4.AddNoteRequest);
      case 'AddNotes':
        return addNotes(ctx, request as $4.AddNotesRequest);
      case 'DefaultsForAdding':
        return defaultsForAdding(ctx, request as $4.DefaultsForAddingRequest);
      case 'DefaultDeckForNotetype':
        return defaultDeckForNotetype(ctx, request as $1.NotetypeId);
      case 'UpdateNotes':
        return updateNotes(ctx, request as $4.UpdateNotesRequest);
      case 'GetNote':
        return getNote(ctx, request as $4.NoteId);
      case 'RemoveNotes':
        return removeNotes(ctx, request as $4.RemoveNotesRequest);
      case 'ClozeNumbersInNote':
        return clozeNumbersInNote(ctx, request as $4.Note);
      case 'AfterNoteUpdates':
        return afterNoteUpdates(ctx, request as $4.AfterNoteUpdatesRequest);
      case 'FieldNamesForNotes':
        return fieldNamesForNotes(ctx, request as $4.FieldNamesForNotesRequest);
      case 'NoteFieldsCheck':
        return noteFieldsCheck(ctx, request as $4.Note);
      case 'CardsOfNote':
        return cardsOfNote(ctx, request as $4.NoteId);
      case 'GetSingleNotetypeOfNotes':
        return getSingleNotetypeOfNotes(ctx, request as $4.NoteIds);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => NotesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => NotesServiceBase$messageJson;
}

abstract class BackendNotesServiceBase extends $pb.GeneratedService {
  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendNotesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendNotesServiceBase$messageJson;
}
