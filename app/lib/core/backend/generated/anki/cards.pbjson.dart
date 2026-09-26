// This is a generated file - do not edit.
//
// Generated from anki/cards.proto.

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

import 'collection.pbjson.dart' as $0;

@$core.Deprecated('Use cardIdDescriptor instead')
const CardId$json = {
  '1': 'CardId',
  '2': [
    {'1': 'cid', '3': 1, '4': 1, '5': 3, '10': 'cid'},
  ],
};

/// Descriptor for `CardId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardIdDescriptor =
    $convert.base64Decode('CgZDYXJkSWQSEAoDY2lkGAEgASgDUgNjaWQ=');

@$core.Deprecated('Use cardIdsDescriptor instead')
const CardIds$json = {
  '1': 'CardIds',
  '2': [
    {'1': 'cids', '3': 1, '4': 3, '5': 3, '10': 'cids'},
  ],
};

/// Descriptor for `CardIds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardIdsDescriptor =
    $convert.base64Decode('CgdDYXJkSWRzEhIKBGNpZHMYASADKANSBGNpZHM=');

@$core.Deprecated('Use cardDescriptor instead')
const Card$json = {
  '1': 'Card',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'note_id', '3': 2, '4': 1, '5': 3, '10': 'noteId'},
    {'1': 'deck_id', '3': 3, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'template_idx', '3': 4, '4': 1, '5': 13, '10': 'templateIdx'},
    {'1': 'mtime_secs', '3': 5, '4': 1, '5': 3, '10': 'mtimeSecs'},
    {'1': 'usn', '3': 6, '4': 1, '5': 17, '10': 'usn'},
    {'1': 'ctype', '3': 7, '4': 1, '5': 13, '10': 'ctype'},
    {'1': 'queue', '3': 8, '4': 1, '5': 17, '10': 'queue'},
    {'1': 'due', '3': 9, '4': 1, '5': 17, '10': 'due'},
    {'1': 'interval', '3': 10, '4': 1, '5': 13, '10': 'interval'},
    {'1': 'ease_factor', '3': 11, '4': 1, '5': 13, '10': 'easeFactor'},
    {'1': 'reps', '3': 12, '4': 1, '5': 13, '10': 'reps'},
    {'1': 'lapses', '3': 13, '4': 1, '5': 13, '10': 'lapses'},
    {'1': 'remaining_steps', '3': 14, '4': 1, '5': 13, '10': 'remainingSteps'},
    {'1': 'original_due', '3': 15, '4': 1, '5': 17, '10': 'originalDue'},
    {'1': 'original_deck_id', '3': 16, '4': 1, '5': 3, '10': 'originalDeckId'},
    {'1': 'flags', '3': 17, '4': 1, '5': 13, '10': 'flags'},
    {
      '1': 'original_position',
      '3': 18,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'originalPosition',
      '17': true
    },
    {
      '1': 'memory_state',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.FsrsMemoryState',
      '9': 1,
      '10': 'memoryState',
      '17': true
    },
    {
      '1': 'desired_retention',
      '3': 21,
      '4': 1,
      '5': 2,
      '9': 2,
      '10': 'desiredRetention',
      '17': true
    },
    {'1': 'decay', '3': 22, '4': 1, '5': 2, '9': 3, '10': 'decay', '17': true},
    {
      '1': 'last_review_time_secs',
      '3': 23,
      '4': 1,
      '5': 3,
      '9': 4,
      '10': 'lastReviewTimeSecs',
      '17': true
    },
    {'1': 'custom_data', '3': 19, '4': 1, '5': 9, '10': 'customData'},
  ],
  '8': [
    {'1': '_original_position'},
    {'1': '_memory_state'},
    {'1': '_desired_retention'},
    {'1': '_decay'},
    {'1': '_last_review_time_secs'},
  ],
};

/// Descriptor for `Card`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardDescriptor = $convert.base64Decode(
    'CgRDYXJkEg4KAmlkGAEgASgDUgJpZBIXCgdub3RlX2lkGAIgASgDUgZub3RlSWQSFwoHZGVja1'
    '9pZBgDIAEoA1IGZGVja0lkEiEKDHRlbXBsYXRlX2lkeBgEIAEoDVILdGVtcGxhdGVJZHgSHQoK'
    'bXRpbWVfc2VjcxgFIAEoA1IJbXRpbWVTZWNzEhAKA3VzbhgGIAEoEVIDdXNuEhQKBWN0eXBlGA'
    'cgASgNUgVjdHlwZRIUCgVxdWV1ZRgIIAEoEVIFcXVldWUSEAoDZHVlGAkgASgRUgNkdWUSGgoI'
    'aW50ZXJ2YWwYCiABKA1SCGludGVydmFsEh8KC2Vhc2VfZmFjdG9yGAsgASgNUgplYXNlRmFjdG'
    '9yEhIKBHJlcHMYDCABKA1SBHJlcHMSFgoGbGFwc2VzGA0gASgNUgZsYXBzZXMSJwoPcmVtYWlu'
    'aW5nX3N0ZXBzGA4gASgNUg5yZW1haW5pbmdTdGVwcxIhCgxvcmlnaW5hbF9kdWUYDyABKBFSC2'
    '9yaWdpbmFsRHVlEigKEG9yaWdpbmFsX2RlY2tfaWQYECABKANSDm9yaWdpbmFsRGVja0lkEhQK'
    'BWZsYWdzGBEgASgNUgVmbGFncxIwChFvcmlnaW5hbF9wb3NpdGlvbhgSIAEoDUgAUhBvcmlnaW'
    '5hbFBvc2l0aW9uiAEBEkMKDG1lbW9yeV9zdGF0ZRgUIAEoCzIbLmFua2kuY2FyZHMuRnNyc01l'
    'bW9yeVN0YXRlSAFSC21lbW9yeVN0YXRliAEBEjAKEWRlc2lyZWRfcmV0ZW50aW9uGBUgASgCSA'
    'JSEGRlc2lyZWRSZXRlbnRpb26IAQESGQoFZGVjYXkYFiABKAJIA1IFZGVjYXmIAQESNgoVbGFz'
    'dF9yZXZpZXdfdGltZV9zZWNzGBcgASgDSARSEmxhc3RSZXZpZXdUaW1lU2Vjc4gBARIfCgtjdX'
    'N0b21fZGF0YRgTIAEoCVIKY3VzdG9tRGF0YUIUChJfb3JpZ2luYWxfcG9zaXRpb25CDwoNX21l'
    'bW9yeV9zdGF0ZUIUChJfZGVzaXJlZF9yZXRlbnRpb25CCAoGX2RlY2F5QhgKFl9sYXN0X3Jldm'
    'lld190aW1lX3NlY3M=');

@$core.Deprecated('Use fsrsMemoryStateDescriptor instead')
const FsrsMemoryState$json = {
  '1': 'FsrsMemoryState',
  '2': [
    {'1': 'stability', '3': 1, '4': 1, '5': 2, '10': 'stability'},
    {'1': 'difficulty', '3': 2, '4': 1, '5': 2, '10': 'difficulty'},
  ],
};

/// Descriptor for `FsrsMemoryState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fsrsMemoryStateDescriptor = $convert.base64Decode(
    'Cg9Gc3JzTWVtb3J5U3RhdGUSHAoJc3RhYmlsaXR5GAEgASgCUglzdGFiaWxpdHkSHgoKZGlmZm'
    'ljdWx0eRgCIAEoAlIKZGlmZmljdWx0eQ==');

@$core.Deprecated('Use updateCardsRequestDescriptor instead')
const UpdateCardsRequest$json = {
  '1': 'UpdateCardsRequest',
  '2': [
    {
      '1': 'cards',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.cards.Card',
      '10': 'cards'
    },
    {'1': 'skip_undo_entry', '3': 2, '4': 1, '5': 8, '10': 'skipUndoEntry'},
  ],
};

/// Descriptor for `UpdateCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardsRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVDYXJkc1JlcXVlc3QSJgoFY2FyZHMYASADKAsyEC5hbmtpLmNhcmRzLkNhcmRSBW'
    'NhcmRzEiYKD3NraXBfdW5kb19lbnRyeRgCIAEoCFINc2tpcFVuZG9FbnRyeQ==');

@$core.Deprecated('Use removeCardsRequestDescriptor instead')
const RemoveCardsRequest$json = {
  '1': 'RemoveCardsRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
  ],
};

/// Descriptor for `RemoveCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeCardsRequestDescriptor =
    $convert.base64Decode(
        'ChJSZW1vdmVDYXJkc1JlcXVlc3QSGQoIY2FyZF9pZHMYASADKANSB2NhcmRJZHM=');

@$core.Deprecated('Use setDeckRequestDescriptor instead')
const SetDeckRequest$json = {
  '1': 'SetDeckRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
    {'1': 'deck_id', '3': 2, '4': 1, '5': 3, '10': 'deckId'},
  ],
};

/// Descriptor for `SetDeckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDeckRequestDescriptor = $convert.base64Decode(
    'Cg5TZXREZWNrUmVxdWVzdBIZCghjYXJkX2lkcxgBIAMoA1IHY2FyZElkcxIXCgdkZWNrX2lkGA'
    'IgASgDUgZkZWNrSWQ=');

@$core.Deprecated('Use setFlagRequestDescriptor instead')
const SetFlagRequest$json = {
  '1': 'SetFlagRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
    {'1': 'flag', '3': 2, '4': 1, '5': 13, '10': 'flag'},
  ],
};

/// Descriptor for `SetFlagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setFlagRequestDescriptor = $convert.base64Decode(
    'Cg5TZXRGbGFnUmVxdWVzdBIZCghjYXJkX2lkcxgBIAMoA1IHY2FyZElkcxISCgRmbGFnGAIgAS'
    'gNUgRmbGFn');

const $core.Map<$core.String, $core.dynamic> CardsServiceBase$json = {
  '1': 'CardsService',
  '2': [
    {'1': 'GetCard', '2': '.anki.cards.CardId', '3': '.anki.cards.Card'},
    {
      '1': 'UpdateCards',
      '2': '.anki.cards.UpdateCardsRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'RemoveCards',
      '2': '.anki.cards.RemoveCardsRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'SetDeck',
      '2': '.anki.cards.SetDeckRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'SetFlag',
      '2': '.anki.cards.SetFlagRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
  ],
};

@$core.Deprecated('Use cardsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    CardsServiceBase$messageJson = {
  '.anki.cards.CardId': CardId$json,
  '.anki.cards.Card': Card$json,
  '.anki.cards.FsrsMemoryState': FsrsMemoryState$json,
  '.anki.cards.UpdateCardsRequest': UpdateCardsRequest$json,
  '.anki.collection.OpChanges': $0.OpChanges$json,
  '.anki.cards.RemoveCardsRequest': RemoveCardsRequest$json,
  '.anki.collection.OpChangesWithCount': $0.OpChangesWithCount$json,
  '.anki.cards.SetDeckRequest': SetDeckRequest$json,
  '.anki.cards.SetFlagRequest': SetFlagRequest$json,
};

/// Descriptor for `CardsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List cardsServiceDescriptor = $convert.base64Decode(
    'CgxDYXJkc1NlcnZpY2USLwoHR2V0Q2FyZBISLmFua2kuY2FyZHMuQ2FyZElkGhAuYW5raS5jYX'
    'Jkcy5DYXJkEkkKC1VwZGF0ZUNhcmRzEh4uYW5raS5jYXJkcy5VcGRhdGVDYXJkc1JlcXVlc3Qa'
    'Gi5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzElIKC1JlbW92ZUNhcmRzEh4uYW5raS5jYXJkcy'
    '5SZW1vdmVDYXJkc1JlcXVlc3QaIy5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzV2l0aENvdW50'
    'EkoKB1NldERlY2sSGi5hbmtpLmNhcmRzLlNldERlY2tSZXF1ZXN0GiMuYW5raS5jb2xsZWN0aW'
    '9uLk9wQ2hhbmdlc1dpdGhDb3VudBJKCgdTZXRGbGFnEhouYW5raS5jYXJkcy5TZXRGbGFnUmVx'
    'dWVzdBojLmFua2kuY29sbGVjdGlvbi5PcENoYW5nZXNXaXRoQ291bnQ=');

const $core.Map<$core.String, $core.dynamic> BackendCardsServiceBase$json = {
  '1': 'BackendCardsService'
};

@$core.Deprecated('Use backendCardsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendCardsServiceBase$messageJson = {};

/// Descriptor for `BackendCardsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendCardsServiceDescriptor =
    $convert.base64Decode('ChNCYWNrZW5kQ2FyZHNTZXJ2aWNl');
