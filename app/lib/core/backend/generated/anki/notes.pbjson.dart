// This is a generated file - do not edit.
//
// Generated from anki/notes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'cards.pbjson.dart' as $3;
import 'collection.pbjson.dart' as $0;
import 'decks.pbjson.dart' as $2;
import 'notetypes.pbjson.dart' as $1;

@$core.Deprecated('Use noteIdDescriptor instead')
const NoteId$json = {
  '1': 'NoteId',
  '2': [
    {'1': 'nid', '3': 1, '4': 1, '5': 3, '10': 'nid'},
  ],
};

/// Descriptor for `NoteId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteIdDescriptor =
    $convert.base64Decode('CgZOb3RlSWQSEAoDbmlkGAEgASgDUgNuaWQ=');

@$core.Deprecated('Use noteIdsDescriptor instead')
const NoteIds$json = {
  '1': 'NoteIds',
  '2': [
    {'1': 'note_ids', '3': 1, '4': 3, '5': 3, '10': 'noteIds'},
  ],
};

/// Descriptor for `NoteIds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteIdsDescriptor =
    $convert.base64Decode('CgdOb3RlSWRzEhkKCG5vdGVfaWRzGAEgAygDUgdub3RlSWRz');

@$core.Deprecated('Use noteDescriptor instead')
const Note$json = {
  '1': 'Note',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'guid', '3': 2, '4': 1, '5': 9, '10': 'guid'},
    {'1': 'notetype_id', '3': 3, '4': 1, '5': 3, '10': 'notetypeId'},
    {'1': 'mtime_secs', '3': 4, '4': 1, '5': 13, '10': 'mtimeSecs'},
    {'1': 'usn', '3': 5, '4': 1, '5': 5, '10': 'usn'},
    {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'fields', '3': 7, '4': 3, '5': 9, '10': 'fields'},
  ],
};

/// Descriptor for `Note`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteDescriptor = $convert.base64Decode(
    'CgROb3RlEg4KAmlkGAEgASgDUgJpZBISCgRndWlkGAIgASgJUgRndWlkEh8KC25vdGV0eXBlX2'
    'lkGAMgASgDUgpub3RldHlwZUlkEh0KCm10aW1lX3NlY3MYBCABKA1SCW10aW1lU2VjcxIQCgN1'
    'c24YBSABKAVSA3VzbhISCgR0YWdzGAYgAygJUgR0YWdzEhYKBmZpZWxkcxgHIAMoCVIGZmllbG'
    'Rz');

@$core.Deprecated('Use addNoteRequestDescriptor instead')
const AddNoteRequest$json = {
  '1': 'AddNoteRequest',
  '2': [
    {
      '1': 'note',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.notes.Note',
      '10': 'note'
    },
    {'1': 'deck_id', '3': 2, '4': 1, '5': 3, '10': 'deckId'},
  ],
};

/// Descriptor for `AddNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNoteRequestDescriptor = $convert.base64Decode(
    'Cg5BZGROb3RlUmVxdWVzdBIkCgRub3RlGAEgASgLMhAuYW5raS5ub3Rlcy5Ob3RlUgRub3RlEh'
    'cKB2RlY2tfaWQYAiABKANSBmRlY2tJZA==');

@$core.Deprecated('Use addNoteResponseDescriptor instead')
const AddNoteResponse$json = {
  '1': 'AddNoteResponse',
  '2': [
    {
      '1': 'changes',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.collection.OpChangesWithCount',
      '10': 'changes'
    },
    {'1': 'note_id', '3': 2, '4': 1, '5': 3, '10': 'noteId'},
  ],
};

/// Descriptor for `AddNoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNoteResponseDescriptor = $convert.base64Decode(
    'Cg9BZGROb3RlUmVzcG9uc2USPQoHY2hhbmdlcxgBIAEoCzIjLmFua2kuY29sbGVjdGlvbi5PcE'
    'NoYW5nZXNXaXRoQ291bnRSB2NoYW5nZXMSFwoHbm90ZV9pZBgCIAEoA1IGbm90ZUlk');

@$core.Deprecated('Use addNotesRequestDescriptor instead')
const AddNotesRequest$json = {
  '1': 'AddNotesRequest',
  '2': [
    {
      '1': 'requests',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.notes.AddNoteRequest',
      '10': 'requests'
    },
  ],
};

/// Descriptor for `AddNotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNotesRequestDescriptor = $convert.base64Decode(
    'Cg9BZGROb3Rlc1JlcXVlc3QSNgoIcmVxdWVzdHMYASADKAsyGi5hbmtpLm5vdGVzLkFkZE5vdG'
    'VSZXF1ZXN0UghyZXF1ZXN0cw==');

@$core.Deprecated('Use addNotesResponseDescriptor instead')
const AddNotesResponse$json = {
  '1': 'AddNotesResponse',
  '2': [
    {
      '1': 'changes',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.collection.OpChanges',
      '10': 'changes'
    },
    {'1': 'nids', '3': 2, '4': 3, '5': 3, '10': 'nids'},
  ],
};

/// Descriptor for `AddNotesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNotesResponseDescriptor = $convert.base64Decode(
    'ChBBZGROb3Rlc1Jlc3BvbnNlEjQKB2NoYW5nZXMYASABKAsyGi5hbmtpLmNvbGxlY3Rpb24uT3'
    'BDaGFuZ2VzUgdjaGFuZ2VzEhIKBG5pZHMYAiADKANSBG5pZHM=');

@$core.Deprecated('Use updateNotesRequestDescriptor instead')
const UpdateNotesRequest$json = {
  '1': 'UpdateNotesRequest',
  '2': [
    {
      '1': 'notes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.notes.Note',
      '10': 'notes'
    },
    {'1': 'skip_undo_entry', '3': 2, '4': 1, '5': 8, '10': 'skipUndoEntry'},
  ],
};

/// Descriptor for `UpdateNotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotesRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVOb3Rlc1JlcXVlc3QSJgoFbm90ZXMYASADKAsyEC5hbmtpLm5vdGVzLk5vdGVSBW'
    '5vdGVzEiYKD3NraXBfdW5kb19lbnRyeRgCIAEoCFINc2tpcFVuZG9FbnRyeQ==');

@$core.Deprecated('Use defaultsForAddingRequestDescriptor instead')
const DefaultsForAddingRequest$json = {
  '1': 'DefaultsForAddingRequest',
  '2': [
    {
      '1': 'home_deck_of_current_review_card',
      '3': 1,
      '4': 1,
      '5': 3,
      '10': 'homeDeckOfCurrentReviewCard'
    },
  ],
};

/// Descriptor for `DefaultsForAddingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List defaultsForAddingRequestDescriptor =
    $convert.base64Decode(
        'ChhEZWZhdWx0c0ZvckFkZGluZ1JlcXVlc3QSRQogaG9tZV9kZWNrX29mX2N1cnJlbnRfcmV2aW'
        'V3X2NhcmQYASABKANSG2hvbWVEZWNrT2ZDdXJyZW50UmV2aWV3Q2FyZA==');

@$core.Deprecated('Use deckAndNotetypeDescriptor instead')
const DeckAndNotetype$json = {
  '1': 'DeckAndNotetype',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'notetype_id', '3': 2, '4': 1, '5': 3, '10': 'notetypeId'},
  ],
};

/// Descriptor for `DeckAndNotetype`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckAndNotetypeDescriptor = $convert.base64Decode(
    'Cg9EZWNrQW5kTm90ZXR5cGUSFwoHZGVja19pZBgBIAEoA1IGZGVja0lkEh8KC25vdGV0eXBlX2'
    'lkGAIgASgDUgpub3RldHlwZUlk');

@$core.Deprecated('Use removeNotesRequestDescriptor instead')
const RemoveNotesRequest$json = {
  '1': 'RemoveNotesRequest',
  '2': [
    {'1': 'note_ids', '3': 1, '4': 3, '5': 3, '10': 'noteIds'},
    {'1': 'card_ids', '3': 2, '4': 3, '5': 3, '10': 'cardIds'},
  ],
};

/// Descriptor for `RemoveNotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeNotesRequestDescriptor = $convert.base64Decode(
    'ChJSZW1vdmVOb3Rlc1JlcXVlc3QSGQoIbm90ZV9pZHMYASADKANSB25vdGVJZHMSGQoIY2FyZF'
    '9pZHMYAiADKANSB2NhcmRJZHM=');

@$core.Deprecated('Use clozeNumbersInNoteResponseDescriptor instead')
const ClozeNumbersInNoteResponse$json = {
  '1': 'ClozeNumbersInNoteResponse',
  '2': [
    {'1': 'numbers', '3': 1, '4': 3, '5': 13, '10': 'numbers'},
  ],
};

/// Descriptor for `ClozeNumbersInNoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clozeNumbersInNoteResponseDescriptor =
    $convert.base64Decode(
        'ChpDbG96ZU51bWJlcnNJbk5vdGVSZXNwb25zZRIYCgdudW1iZXJzGAEgAygNUgdudW1iZXJz');

@$core.Deprecated('Use afterNoteUpdatesRequestDescriptor instead')
const AfterNoteUpdatesRequest$json = {
  '1': 'AfterNoteUpdatesRequest',
  '2': [
    {'1': 'nids', '3': 1, '4': 3, '5': 3, '10': 'nids'},
    {
      '1': 'mark_notes_modified',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'markNotesModified'
    },
    {'1': 'generate_cards', '3': 3, '4': 1, '5': 8, '10': 'generateCards'},
  ],
};

/// Descriptor for `AfterNoteUpdatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List afterNoteUpdatesRequestDescriptor = $convert.base64Decode(
    'ChdBZnRlck5vdGVVcGRhdGVzUmVxdWVzdBISCgRuaWRzGAEgAygDUgRuaWRzEi4KE21hcmtfbm'
    '90ZXNfbW9kaWZpZWQYAiABKAhSEW1hcmtOb3Rlc01vZGlmaWVkEiUKDmdlbmVyYXRlX2NhcmRz'
    'GAMgASgIUg1nZW5lcmF0ZUNhcmRz');

@$core.Deprecated('Use fieldNamesForNotesRequestDescriptor instead')
const FieldNamesForNotesRequest$json = {
  '1': 'FieldNamesForNotesRequest',
  '2': [
    {'1': 'nids', '3': 1, '4': 3, '5': 3, '10': 'nids'},
  ],
};

/// Descriptor for `FieldNamesForNotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fieldNamesForNotesRequestDescriptor =
    $convert.base64Decode(
        'ChlGaWVsZE5hbWVzRm9yTm90ZXNSZXF1ZXN0EhIKBG5pZHMYASADKANSBG5pZHM=');

@$core.Deprecated('Use fieldNamesForNotesResponseDescriptor instead')
const FieldNamesForNotesResponse$json = {
  '1': 'FieldNamesForNotesResponse',
  '2': [
    {'1': 'fields', '3': 1, '4': 3, '5': 9, '10': 'fields'},
  ],
};

/// Descriptor for `FieldNamesForNotesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fieldNamesForNotesResponseDescriptor =
    $convert.base64Decode(
        'ChpGaWVsZE5hbWVzRm9yTm90ZXNSZXNwb25zZRIWCgZmaWVsZHMYASADKAlSBmZpZWxkcw==');

@$core.Deprecated('Use noteFieldsCheckResponseDescriptor instead')
const NoteFieldsCheckResponse$json = {
  '1': 'NoteFieldsCheckResponse',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.notes.NoteFieldsCheckResponse.State',
      '10': 'state'
    },
  ],
  '4': [NoteFieldsCheckResponse_State$json],
};

@$core.Deprecated('Use noteFieldsCheckResponseDescriptor instead')
const NoteFieldsCheckResponse_State$json = {
  '1': 'State',
  '2': [
    {'1': 'NORMAL', '2': 0},
    {'1': 'EMPTY', '2': 1},
    {'1': 'DUPLICATE', '2': 2},
    {'1': 'MISSING_CLOZE', '2': 3},
    {'1': 'NOTETYPE_NOT_CLOZE', '2': 4},
    {'1': 'FIELD_NOT_CLOZE', '2': 5},
  ],
};

/// Descriptor for `NoteFieldsCheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteFieldsCheckResponseDescriptor = $convert.base64Decode(
    'ChdOb3RlRmllbGRzQ2hlY2tSZXNwb25zZRI/CgVzdGF0ZRgBIAEoDjIpLmFua2kubm90ZXMuTm'
    '90ZUZpZWxkc0NoZWNrUmVzcG9uc2UuU3RhdGVSBXN0YXRlIm0KBVN0YXRlEgoKBk5PUk1BTBAA'
    'EgkKBUVNUFRZEAESDQoJRFVQTElDQVRFEAISEQoNTUlTU0lOR19DTE9aRRADEhYKEk5PVEVUWV'
    'BFX05PVF9DTE9aRRAEEhMKD0ZJRUxEX05PVF9DTE9aRRAF');

const $core.Map<$core.String, $core.dynamic> NotesServiceBase$json = {
  '1': 'NotesService',
  '2': [
    {
      '1': 'NewNote',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.notes.Note'
    },
    {
      '1': 'AddNote',
      '2': '.anki.notes.AddNoteRequest',
      '3': '.anki.notes.AddNoteResponse'
    },
    {
      '1': 'AddNotes',
      '2': '.anki.notes.AddNotesRequest',
      '3': '.anki.notes.AddNotesResponse'
    },
    {
      '1': 'DefaultsForAdding',
      '2': '.anki.notes.DefaultsForAddingRequest',
      '3': '.anki.notes.DeckAndNotetype'
    },
    {
      '1': 'DefaultDeckForNotetype',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.decks.DeckId'
    },
    {
      '1': 'UpdateNotes',
      '2': '.anki.notes.UpdateNotesRequest',
      '3': '.anki.collection.OpChanges'
    },
    {'1': 'GetNote', '2': '.anki.notes.NoteId', '3': '.anki.notes.Note'},
    {
      '1': 'RemoveNotes',
      '2': '.anki.notes.RemoveNotesRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'ClozeNumbersInNote',
      '2': '.anki.notes.Note',
      '3': '.anki.notes.ClozeNumbersInNoteResponse'
    },
    {
      '1': 'AfterNoteUpdates',
      '2': '.anki.notes.AfterNoteUpdatesRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'FieldNamesForNotes',
      '2': '.anki.notes.FieldNamesForNotesRequest',
      '3': '.anki.notes.FieldNamesForNotesResponse'
    },
    {
      '1': 'NoteFieldsCheck',
      '2': '.anki.notes.Note',
      '3': '.anki.notes.NoteFieldsCheckResponse'
    },
    {'1': 'CardsOfNote', '2': '.anki.notes.NoteId', '3': '.anki.cards.CardIds'},
    {
      '1': 'GetSingleNotetypeOfNotes',
      '2': '.anki.notes.NoteIds',
      '3': '.anki.notetypes.NotetypeId'
    },
  ],
};

@$core.Deprecated('Use notesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    NotesServiceBase$messageJson = {
  '.anki.notetypes.NotetypeId': $1.NotetypeId$json,
  '.anki.notes.Note': Note$json,
  '.anki.notes.AddNoteRequest': AddNoteRequest$json,
  '.anki.notes.AddNoteResponse': AddNoteResponse$json,
  '.anki.collection.OpChangesWithCount': $0.OpChangesWithCount$json,
  '.anki.collection.OpChanges': $0.OpChanges$json,
  '.anki.notes.AddNotesRequest': AddNotesRequest$json,
  '.anki.notes.AddNotesResponse': AddNotesResponse$json,
  '.anki.notes.DefaultsForAddingRequest': DefaultsForAddingRequest$json,
  '.anki.notes.DeckAndNotetype': DeckAndNotetype$json,
  '.anki.decks.DeckId': $2.DeckId$json,
  '.anki.notes.UpdateNotesRequest': UpdateNotesRequest$json,
  '.anki.notes.NoteId': NoteId$json,
  '.anki.notes.RemoveNotesRequest': RemoveNotesRequest$json,
  '.anki.notes.ClozeNumbersInNoteResponse': ClozeNumbersInNoteResponse$json,
  '.anki.notes.AfterNoteUpdatesRequest': AfterNoteUpdatesRequest$json,
  '.anki.notes.FieldNamesForNotesRequest': FieldNamesForNotesRequest$json,
  '.anki.notes.FieldNamesForNotesResponse': FieldNamesForNotesResponse$json,
  '.anki.notes.NoteFieldsCheckResponse': NoteFieldsCheckResponse$json,
  '.anki.cards.CardIds': $3.CardIds$json,
  '.anki.notes.NoteIds': NoteIds$json,
};

/// Descriptor for `NotesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List notesServiceDescriptor = $convert.base64Decode(
    'CgxOb3Rlc1NlcnZpY2USNwoHTmV3Tm90ZRIaLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlSWQaEC'
    '5hbmtpLm5vdGVzLk5vdGUSQgoHQWRkTm90ZRIaLmFua2kubm90ZXMuQWRkTm90ZVJlcXVlc3Qa'
    'Gy5hbmtpLm5vdGVzLkFkZE5vdGVSZXNwb25zZRJFCghBZGROb3RlcxIbLmFua2kubm90ZXMuQW'
    'RkTm90ZXNSZXF1ZXN0GhwuYW5raS5ub3Rlcy5BZGROb3Rlc1Jlc3BvbnNlElYKEURlZmF1bHRz'
    'Rm9yQWRkaW5nEiQuYW5raS5ub3Rlcy5EZWZhdWx0c0ZvckFkZGluZ1JlcXVlc3QaGy5hbmtpLm'
    '5vdGVzLkRlY2tBbmROb3RldHlwZRJIChZEZWZhdWx0RGVja0Zvck5vdGV0eXBlEhouYW5raS5u'
    'b3RldHlwZXMuTm90ZXR5cGVJZBoSLmFua2kuZGVja3MuRGVja0lkEkkKC1VwZGF0ZU5vdGVzEh'
    '4uYW5raS5ub3Rlcy5VcGRhdGVOb3Rlc1JlcXVlc3QaGi5hbmtpLmNvbGxlY3Rpb24uT3BDaGFu'
    'Z2VzEi8KB0dldE5vdGUSEi5hbmtpLm5vdGVzLk5vdGVJZBoQLmFua2kubm90ZXMuTm90ZRJSCg'
    'tSZW1vdmVOb3RlcxIeLmFua2kubm90ZXMuUmVtb3ZlTm90ZXNSZXF1ZXN0GiMuYW5raS5jb2xs'
    'ZWN0aW9uLk9wQ2hhbmdlc1dpdGhDb3VudBJOChJDbG96ZU51bWJlcnNJbk5vdGUSEC5hbmtpLm'
    '5vdGVzLk5vdGUaJi5hbmtpLm5vdGVzLkNsb3plTnVtYmVyc0luTm90ZVJlc3BvbnNlElwKEEFm'
    'dGVyTm90ZVVwZGF0ZXMSIy5hbmtpLm5vdGVzLkFmdGVyTm90ZVVwZGF0ZXNSZXF1ZXN0GiMuYW'
    '5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlc1dpdGhDb3VudBJjChJGaWVsZE5hbWVzRm9yTm90ZXMS'
    'JS5hbmtpLm5vdGVzLkZpZWxkTmFtZXNGb3JOb3Rlc1JlcXVlc3QaJi5hbmtpLm5vdGVzLkZpZW'
    'xkTmFtZXNGb3JOb3Rlc1Jlc3BvbnNlEkgKD05vdGVGaWVsZHNDaGVjaxIQLmFua2kubm90ZXMu'
    'Tm90ZRojLmFua2kubm90ZXMuTm90ZUZpZWxkc0NoZWNrUmVzcG9uc2USNgoLQ2FyZHNPZk5vdG'
    'USEi5hbmtpLm5vdGVzLk5vdGVJZBoTLmFua2kuY2FyZHMuQ2FyZElkcxJLChhHZXRTaW5nbGVO'
    'b3RldHlwZU9mTm90ZXMSEy5hbmtpLm5vdGVzLk5vdGVJZHMaGi5hbmtpLm5vdGV0eXBlcy5Ob3'
    'RldHlwZUlk');

const $core.Map<$core.String, $core.dynamic> BackendNotesServiceBase$json = {
  '1': 'BackendNotesService'
};

@$core.Deprecated('Use backendNotesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendNotesServiceBase$messageJson = {};

/// Descriptor for `BackendNotesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendNotesServiceDescriptor =
    $convert.base64Decode('ChNCYWNrZW5kTm90ZXNTZXJ2aWNl');
