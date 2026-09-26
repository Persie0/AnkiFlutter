// This is a generated file - do not edit.
//
// Generated from anki/decks.proto.

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

import 'collection.pbjson.dart' as $1;
import 'generic.pbjson.dart' as $0;

@$core.Deprecated('Use deckIdDescriptor instead')
const DeckId$json = {
  '1': 'DeckId',
  '2': [
    {'1': 'did', '3': 1, '4': 1, '5': 3, '10': 'did'},
  ],
};

/// Descriptor for `DeckId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckIdDescriptor =
    $convert.base64Decode('CgZEZWNrSWQSEAoDZGlkGAEgASgDUgNkaWQ=');

@$core.Deprecated('Use deckIdsDescriptor instead')
const DeckIds$json = {
  '1': 'DeckIds',
  '2': [
    {'1': 'dids', '3': 1, '4': 3, '5': 3, '10': 'dids'},
  ],
};

/// Descriptor for `DeckIds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckIdsDescriptor =
    $convert.base64Decode('CgdEZWNrSWRzEhIKBGRpZHMYASADKANSBGRpZHM=');

@$core.Deprecated('Use deckDescriptor instead')
const Deck$json = {
  '1': 'Deck',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'mtime_secs', '3': 3, '4': 1, '5': 3, '10': 'mtimeSecs'},
    {'1': 'usn', '3': 4, '4': 1, '5': 5, '10': 'usn'},
    {
      '1': 'common',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Common',
      '10': 'common'
    },
    {
      '1': 'normal',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Normal',
      '9': 0,
      '10': 'normal'
    },
    {
      '1': 'filtered',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Filtered',
      '9': 0,
      '10': 'filtered'
    },
  ],
  '3': [
    Deck_Common$json,
    Deck_Normal$json,
    Deck_Filtered$json,
    Deck_KindContainer$json
  ],
  '8': [
    {'1': 'kind'},
  ],
};

@$core.Deprecated('Use deckDescriptor instead')
const Deck_Common$json = {
  '1': 'Common',
  '2': [
    {'1': 'study_collapsed', '3': 1, '4': 1, '5': 8, '10': 'studyCollapsed'},
    {
      '1': 'browser_collapsed',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'browserCollapsed'
    },
    {'1': 'last_day_studied', '3': 3, '4': 1, '5': 13, '10': 'lastDayStudied'},
    {'1': 'new_studied', '3': 4, '4': 1, '5': 5, '10': 'newStudied'},
    {'1': 'review_studied', '3': 5, '4': 1, '5': 5, '10': 'reviewStudied'},
    {
      '1': 'milliseconds_studied',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'millisecondsStudied'
    },
    {'1': 'learning_studied', '3': 6, '4': 1, '5': 5, '10': 'learningStudied'},
    {'1': 'other', '3': 255, '4': 1, '5': 12, '10': 'other'},
  ],
  '9': [
    {'1': 8, '2': 14},
  ],
};

@$core.Deprecated('Use deckDescriptor instead')
const Deck_Normal$json = {
  '1': 'Normal',
  '2': [
    {'1': 'config_id', '3': 1, '4': 1, '5': 3, '10': 'configId'},
    {'1': 'extend_new', '3': 2, '4': 1, '5': 13, '10': 'extendNew'},
    {'1': 'extend_review', '3': 3, '4': 1, '5': 13, '10': 'extendReview'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'markdown_description',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'markdownDescription'
    },
    {
      '1': 'review_limit',
      '3': 6,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'reviewLimit',
      '17': true
    },
    {
      '1': 'new_limit',
      '3': 7,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'newLimit',
      '17': true
    },
    {
      '1': 'review_limit_today',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Normal.DayLimit',
      '10': 'reviewLimitToday'
    },
    {
      '1': 'new_limit_today',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Normal.DayLimit',
      '10': 'newLimitToday'
    },
    {
      '1': 'desired_retention',
      '3': 10,
      '4': 1,
      '5': 2,
      '9': 2,
      '10': 'desiredRetention',
      '17': true
    },
  ],
  '3': [Deck_Normal_DayLimit$json],
  '8': [
    {'1': '_review_limit'},
    {'1': '_new_limit'},
    {'1': '_desired_retention'},
  ],
  '9': [
    {'1': 12, '2': 16},
  ],
};

@$core.Deprecated('Use deckDescriptor instead')
const Deck_Normal_DayLimit$json = {
  '1': 'DayLimit',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 13, '10': 'limit'},
    {'1': 'today', '3': 2, '4': 1, '5': 13, '10': 'today'},
  ],
};

@$core.Deprecated('Use deckDescriptor instead')
const Deck_Filtered$json = {
  '1': 'Filtered',
  '2': [
    {'1': 'reschedule', '3': 1, '4': 1, '5': 8, '10': 'reschedule'},
    {
      '1': 'search_terms',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.decks.Deck.Filtered.SearchTerm',
      '10': 'searchTerms'
    },
    {'1': 'delays', '3': 3, '4': 3, '5': 2, '10': 'delays'},
    {'1': 'preview_delay', '3': 4, '4': 1, '5': 13, '10': 'previewDelay'},
    {
      '1': 'preview_again_secs',
      '3': 7,
      '4': 1,
      '5': 13,
      '10': 'previewAgainSecs'
    },
    {
      '1': 'preview_hard_secs',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'previewHardSecs'
    },
    {
      '1': 'preview_good_secs',
      '3': 6,
      '4': 1,
      '5': 13,
      '10': 'previewGoodSecs'
    },
  ],
  '3': [Deck_Filtered_SearchTerm$json],
};

@$core.Deprecated('Use deckDescriptor instead')
const Deck_Filtered_SearchTerm$json = {
  '1': 'SearchTerm',
  '2': [
    {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
    {'1': 'limit', '3': 2, '4': 1, '5': 13, '10': 'limit'},
    {
      '1': 'order',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.anki.decks.Deck.Filtered.SearchTerm.Order',
      '10': 'order'
    },
  ],
  '4': [Deck_Filtered_SearchTerm_Order$json],
};

@$core.Deprecated('Use deckDescriptor instead')
const Deck_Filtered_SearchTerm_Order$json = {
  '1': 'Order',
  '2': [
    {'1': 'OLDEST_REVIEWED_FIRST', '2': 0},
    {'1': 'RANDOM', '2': 1},
    {'1': 'INTERVALS_ASCENDING', '2': 2},
    {'1': 'INTERVALS_DESCENDING', '2': 3},
    {'1': 'LAPSES', '2': 4},
    {'1': 'ADDED', '2': 5},
    {'1': 'DUE', '2': 6},
    {'1': 'REVERSE_ADDED', '2': 7},
    {'1': 'RETRIEVABILITY_ASCENDING', '2': 8},
    {'1': 'RETRIEVABILITY_DESCENDING', '2': 9},
    {'1': 'RELATIVE_OVERDUENESS', '2': 10},
  ],
};

@$core.Deprecated('Use deckDescriptor instead')
const Deck_KindContainer$json = {
  '1': 'KindContainer',
  '2': [
    {
      '1': 'normal',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Normal',
      '9': 0,
      '10': 'normal'
    },
    {
      '1': 'filtered',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Filtered',
      '9': 0,
      '10': 'filtered'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `Deck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckDescriptor = $convert.base64Decode(
    'CgREZWNrEg4KAmlkGAEgASgDUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCm10aW1lX3NlY3'
    'MYAyABKANSCW10aW1lU2VjcxIQCgN1c24YBCABKAVSA3VzbhIvCgZjb21tb24YBSABKAsyFy5h'
    'bmtpLmRlY2tzLkRlY2suQ29tbW9uUgZjb21tb24SMQoGbm9ybWFsGAYgASgLMhcuYW5raS5kZW'
    'Nrcy5EZWNrLk5vcm1hbEgAUgZub3JtYWwSNwoIZmlsdGVyZWQYByABKAsyGS5hbmtpLmRlY2tz'
    'LkRlY2suRmlsdGVyZWRIAFIIZmlsdGVyZWQaywIKBkNvbW1vbhInCg9zdHVkeV9jb2xsYXBzZW'
    'QYASABKAhSDnN0dWR5Q29sbGFwc2VkEisKEWJyb3dzZXJfY29sbGFwc2VkGAIgASgIUhBicm93'
    'c2VyQ29sbGFwc2VkEigKEGxhc3RfZGF5X3N0dWRpZWQYAyABKA1SDmxhc3REYXlTdHVkaWVkEh'
    '8KC25ld19zdHVkaWVkGAQgASgFUgpuZXdTdHVkaWVkEiUKDnJldmlld19zdHVkaWVkGAUgASgF'
    'Ug1yZXZpZXdTdHVkaWVkEjEKFG1pbGxpc2Vjb25kc19zdHVkaWVkGAcgASgFUhNtaWxsaXNlY2'
    '9uZHNTdHVkaWVkEikKEGxlYXJuaW5nX3N0dWRpZWQYBiABKAVSD2xlYXJuaW5nU3R1ZGllZBIV'
    'CgVvdGhlchj/ASABKAxSBW90aGVySgQICBAOGscECgZOb3JtYWwSGwoJY29uZmlnX2lkGAEgAS'
    'gDUghjb25maWdJZBIdCgpleHRlbmRfbmV3GAIgASgNUglleHRlbmROZXcSIwoNZXh0ZW5kX3Jl'
    'dmlldxgDIAEoDVIMZXh0ZW5kUmV2aWV3EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdG'
    'lvbhIxChRtYXJrZG93bl9kZXNjcmlwdGlvbhgFIAEoCFITbWFya2Rvd25EZXNjcmlwdGlvbhIm'
    'CgxyZXZpZXdfbGltaXQYBiABKA1IAFILcmV2aWV3TGltaXSIAQESIAoJbmV3X2xpbWl0GAcgAS'
    'gNSAFSCG5ld0xpbWl0iAEBEk4KEnJldmlld19saW1pdF90b2RheRgIIAEoCzIgLmFua2kuZGVj'
    'a3MuRGVjay5Ob3JtYWwuRGF5TGltaXRSEHJldmlld0xpbWl0VG9kYXkSSAoPbmV3X2xpbWl0X3'
    'RvZGF5GAkgASgLMiAuYW5raS5kZWNrcy5EZWNrLk5vcm1hbC5EYXlMaW1pdFINbmV3TGltaXRU'
    'b2RheRIwChFkZXNpcmVkX3JldGVudGlvbhgKIAEoAkgCUhBkZXNpcmVkUmV0ZW50aW9uiAEBGj'
    'YKCERheUxpbWl0EhQKBWxpbWl0GAEgASgNUgVsaW1pdBIUCgV0b2RheRgCIAEoDVIFdG9kYXlC'
    'DwoNX3Jldmlld19saW1pdEIMCgpfbmV3X2xpbWl0QhQKEl9kZXNpcmVkX3JldGVudGlvbkoECA'
    'wQEBqjBQoIRmlsdGVyZWQSHgoKcmVzY2hlZHVsZRgBIAEoCFIKcmVzY2hlZHVsZRJHCgxzZWFy'
    'Y2hfdGVybXMYAiADKAsyJC5hbmtpLmRlY2tzLkRlY2suRmlsdGVyZWQuU2VhcmNoVGVybVILc2'
    'VhcmNoVGVybXMSFgoGZGVsYXlzGAMgAygCUgZkZWxheXMSIwoNcHJldmlld19kZWxheRgEIAEo'
    'DVIMcHJldmlld0RlbGF5EiwKEnByZXZpZXdfYWdhaW5fc2VjcxgHIAEoDVIQcHJldmlld0FnYW'
    'luU2VjcxIqChFwcmV2aWV3X2hhcmRfc2VjcxgFIAEoDVIPcHJldmlld0hhcmRTZWNzEioKEXBy'
    'ZXZpZXdfZ29vZF9zZWNzGAYgASgNUg9wcmV2aWV3R29vZFNlY3Ma6gIKClNlYXJjaFRlcm0SFg'
    'oGc2VhcmNoGAEgASgJUgZzZWFyY2gSFAoFbGltaXQYAiABKA1SBWxpbWl0EkAKBW9yZGVyGAMg'
    'ASgOMiouYW5raS5kZWNrcy5EZWNrLkZpbHRlcmVkLlNlYXJjaFRlcm0uT3JkZXJSBW9yZGVyIu'
    'sBCgVPcmRlchIZChVPTERFU1RfUkVWSUVXRURfRklSU1QQABIKCgZSQU5ET00QARIXChNJTlRF'
    'UlZBTFNfQVNDRU5ESU5HEAISGAoUSU5URVJWQUxTX0RFU0NFTkRJTkcQAxIKCgZMQVBTRVMQBB'
    'IJCgVBRERFRBAFEgcKA0RVRRAGEhEKDVJFVkVSU0VfQURERUQQBxIcChhSRVRSSUVWQUJJTElU'
    'WV9BU0NFTkRJTkcQCBIdChlSRVRSSUVWQUJJTElUWV9ERVNDRU5ESU5HEAkSGAoUUkVMQVRJVk'
    'VfT1ZFUkRVRU5FU1MQChqDAQoNS2luZENvbnRhaW5lchIxCgZub3JtYWwYASABKAsyFy5hbmtp'
    'LmRlY2tzLkRlY2suTm9ybWFsSABSBm5vcm1hbBI3CghmaWx0ZXJlZBgCIAEoCzIZLmFua2kuZG'
    'Vja3MuRGVjay5GaWx0ZXJlZEgAUghmaWx0ZXJlZEIGCgRraW5kQgYKBGtpbmQ=');

@$core.Deprecated('Use addOrUpdateDeckLegacyRequestDescriptor instead')
const AddOrUpdateDeckLegacyRequest$json = {
  '1': 'AddOrUpdateDeckLegacyRequest',
  '2': [
    {'1': 'deck', '3': 1, '4': 1, '5': 12, '10': 'deck'},
    {
      '1': 'preserve_usn_and_mtime',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'preserveUsnAndMtime'
    },
  ],
};

/// Descriptor for `AddOrUpdateDeckLegacyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addOrUpdateDeckLegacyRequestDescriptor =
    $convert.base64Decode(
        'ChxBZGRPclVwZGF0ZURlY2tMZWdhY3lSZXF1ZXN0EhIKBGRlY2sYASABKAxSBGRlY2sSMwoWcH'
        'Jlc2VydmVfdXNuX2FuZF9tdGltZRgCIAEoCFITcHJlc2VydmVVc25BbmRNdGltZQ==');

@$core.Deprecated('Use deckTreeRequestDescriptor instead')
const DeckTreeRequest$json = {
  '1': 'DeckTreeRequest',
  '2': [
    {'1': 'now', '3': 1, '4': 1, '5': 3, '10': 'now'},
  ],
};

/// Descriptor for `DeckTreeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckTreeRequestDescriptor =
    $convert.base64Decode('Cg9EZWNrVHJlZVJlcXVlc3QSEAoDbm93GAEgASgDUgNub3c=');

@$core.Deprecated('Use deckTreeNodeDescriptor instead')
const DeckTreeNode$json = {
  '1': 'DeckTreeNode',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'level', '3': 4, '4': 1, '5': 13, '10': 'level'},
    {'1': 'collapsed', '3': 5, '4': 1, '5': 8, '10': 'collapsed'},
    {'1': 'review_count', '3': 6, '4': 1, '5': 13, '10': 'reviewCount'},
    {'1': 'learn_count', '3': 7, '4': 1, '5': 13, '10': 'learnCount'},
    {'1': 'new_count', '3': 8, '4': 1, '5': 13, '10': 'newCount'},
    {
      '1': 'intraday_learning',
      '3': 9,
      '4': 1,
      '5': 13,
      '10': 'intradayLearning'
    },
    {
      '1': 'interday_learning_uncapped',
      '3': 10,
      '4': 1,
      '5': 13,
      '10': 'interdayLearningUncapped'
    },
    {'1': 'new_uncapped', '3': 11, '4': 1, '5': 13, '10': 'newUncapped'},
    {'1': 'review_uncapped', '3': 12, '4': 1, '5': 13, '10': 'reviewUncapped'},
    {'1': 'total_in_deck', '3': 13, '4': 1, '5': 13, '10': 'totalInDeck'},
    {
      '1': 'total_including_children',
      '3': 14,
      '4': 1,
      '5': 13,
      '10': 'totalIncludingChildren'
    },
    {'1': 'filtered', '3': 16, '4': 1, '5': 8, '10': 'filtered'},
    {
      '1': 'children',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.anki.decks.DeckTreeNode',
      '10': 'children'
    },
  ],
};

/// Descriptor for `DeckTreeNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckTreeNodeDescriptor = $convert.base64Decode(
    'CgxEZWNrVHJlZU5vZGUSFwoHZGVja19pZBgBIAEoA1IGZGVja0lkEhIKBG5hbWUYAiABKAlSBG'
    '5hbWUSFAoFbGV2ZWwYBCABKA1SBWxldmVsEhwKCWNvbGxhcHNlZBgFIAEoCFIJY29sbGFwc2Vk'
    'EiEKDHJldmlld19jb3VudBgGIAEoDVILcmV2aWV3Q291bnQSHwoLbGVhcm5fY291bnQYByABKA'
    '1SCmxlYXJuQ291bnQSGwoJbmV3X2NvdW50GAggASgNUghuZXdDb3VudBIrChFpbnRyYWRheV9s'
    'ZWFybmluZxgJIAEoDVIQaW50cmFkYXlMZWFybmluZxI8ChppbnRlcmRheV9sZWFybmluZ191bm'
    'NhcHBlZBgKIAEoDVIYaW50ZXJkYXlMZWFybmluZ1VuY2FwcGVkEiEKDG5ld191bmNhcHBlZBgL'
    'IAEoDVILbmV3VW5jYXBwZWQSJwoPcmV2aWV3X3VuY2FwcGVkGAwgASgNUg5yZXZpZXdVbmNhcH'
    'BlZBIiCg10b3RhbF9pbl9kZWNrGA0gASgNUgt0b3RhbEluRGVjaxI4Chh0b3RhbF9pbmNsdWRp'
    'bmdfY2hpbGRyZW4YDiABKA1SFnRvdGFsSW5jbHVkaW5nQ2hpbGRyZW4SGgoIZmlsdGVyZWQYEC'
    'ABKAhSCGZpbHRlcmVkEjQKCGNoaWxkcmVuGAMgAygLMhguYW5raS5kZWNrcy5EZWNrVHJlZU5v'
    'ZGVSCGNoaWxkcmVu');

@$core.Deprecated('Use setDeckCollapsedRequestDescriptor instead')
const SetDeckCollapsedRequest$json = {
  '1': 'SetDeckCollapsedRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'collapsed', '3': 2, '4': 1, '5': 8, '10': 'collapsed'},
    {
      '1': 'scope',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.anki.decks.SetDeckCollapsedRequest.Scope',
      '10': 'scope'
    },
  ],
  '4': [SetDeckCollapsedRequest_Scope$json],
};

@$core.Deprecated('Use setDeckCollapsedRequestDescriptor instead')
const SetDeckCollapsedRequest_Scope$json = {
  '1': 'Scope',
  '2': [
    {'1': 'REVIEWER', '2': 0},
    {'1': 'BROWSER', '2': 1},
  ],
};

/// Descriptor for `SetDeckCollapsedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDeckCollapsedRequestDescriptor = $convert.base64Decode(
    'ChdTZXREZWNrQ29sbGFwc2VkUmVxdWVzdBIXCgdkZWNrX2lkGAEgASgDUgZkZWNrSWQSHAoJY2'
    '9sbGFwc2VkGAIgASgIUgljb2xsYXBzZWQSPwoFc2NvcGUYAyABKA4yKS5hbmtpLmRlY2tzLlNl'
    'dERlY2tDb2xsYXBzZWRSZXF1ZXN0LlNjb3BlUgVzY29wZSIiCgVTY29wZRIMCghSRVZJRVdFUh'
    'AAEgsKB0JST1dTRVIQAQ==');

@$core.Deprecated('Use getDeckNamesRequestDescriptor instead')
const GetDeckNamesRequest$json = {
  '1': 'GetDeckNamesRequest',
  '2': [
    {
      '1': 'skip_empty_default',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'skipEmptyDefault'
    },
    {'1': 'include_filtered', '3': 2, '4': 1, '5': 8, '10': 'includeFiltered'},
  ],
};

/// Descriptor for `GetDeckNamesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeckNamesRequestDescriptor = $convert.base64Decode(
    'ChNHZXREZWNrTmFtZXNSZXF1ZXN0EiwKEnNraXBfZW1wdHlfZGVmYXVsdBgBIAEoCFIQc2tpcE'
    'VtcHR5RGVmYXVsdBIpChBpbmNsdWRlX2ZpbHRlcmVkGAIgASgIUg9pbmNsdWRlRmlsdGVyZWQ=');

@$core.Deprecated('Use deckNamesDescriptor instead')
const DeckNames$json = {
  '1': 'DeckNames',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.decks.DeckNameId',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `DeckNames`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckNamesDescriptor = $convert.base64Decode(
    'CglEZWNrTmFtZXMSMAoHZW50cmllcxgBIAMoCzIWLmFua2kuZGVja3MuRGVja05hbWVJZFIHZW'
    '50cmllcw==');

@$core.Deprecated('Use deckNameIdDescriptor instead')
const DeckNameId$json = {
  '1': 'DeckNameId',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeckNameId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckNameIdDescriptor = $convert.base64Decode(
    'CgpEZWNrTmFtZUlkEg4KAmlkGAEgASgDUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use reparentDecksRequestDescriptor instead')
const ReparentDecksRequest$json = {
  '1': 'ReparentDecksRequest',
  '2': [
    {'1': 'deck_ids', '3': 1, '4': 3, '5': 3, '10': 'deckIds'},
    {'1': 'new_parent', '3': 2, '4': 1, '5': 3, '10': 'newParent'},
  ],
};

/// Descriptor for `ReparentDecksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reparentDecksRequestDescriptor = $convert.base64Decode(
    'ChRSZXBhcmVudERlY2tzUmVxdWVzdBIZCghkZWNrX2lkcxgBIAMoA1IHZGVja0lkcxIdCgpuZX'
    'dfcGFyZW50GAIgASgDUgluZXdQYXJlbnQ=');

@$core.Deprecated('Use renameDeckRequestDescriptor instead')
const RenameDeckRequest$json = {
  '1': 'RenameDeckRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'new_name', '3': 2, '4': 1, '5': 9, '10': 'newName'},
  ],
};

/// Descriptor for `RenameDeckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameDeckRequestDescriptor = $convert.base64Decode(
    'ChFSZW5hbWVEZWNrUmVxdWVzdBIXCgdkZWNrX2lkGAEgASgDUgZkZWNrSWQSGQoIbmV3X25hbW'
    'UYAiABKAlSB25ld05hbWU=');

@$core.Deprecated('Use filteredDeckForUpdateDescriptor instead')
const FilteredDeckForUpdate$json = {
  '1': 'FilteredDeckForUpdate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'config',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.decks.Deck.Filtered',
      '10': 'config'
    },
    {'1': 'allow_empty', '3': 4, '4': 1, '5': 8, '10': 'allowEmpty'},
  ],
};

/// Descriptor for `FilteredDeckForUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filteredDeckForUpdateDescriptor = $convert.base64Decode(
    'ChVGaWx0ZXJlZERlY2tGb3JVcGRhdGUSDgoCaWQYASABKANSAmlkEhIKBG5hbWUYAiABKAlSBG'
    '5hbWUSMQoGY29uZmlnGAMgASgLMhkuYW5raS5kZWNrcy5EZWNrLkZpbHRlcmVkUgZjb25maWcS'
    'HwoLYWxsb3dfZW1wdHkYBCABKAhSCmFsbG93RW1wdHk=');

const $core.Map<$core.String, $core.dynamic> DecksServiceBase$json = {
  '1': 'DecksService',
  '2': [
    {'1': 'NewDeck', '2': '.anki.generic.Empty', '3': '.anki.decks.Deck'},
    {
      '1': 'AddDeck',
      '2': '.anki.decks.Deck',
      '3': '.anki.collection.OpChangesWithId'
    },
    {
      '1': 'AddDeckLegacy',
      '2': '.anki.generic.Json',
      '3': '.anki.collection.OpChangesWithId'
    },
    {
      '1': 'AddOrUpdateDeckLegacy',
      '2': '.anki.decks.AddOrUpdateDeckLegacyRequest',
      '3': '.anki.decks.DeckId'
    },
    {
      '1': 'DeckTree',
      '2': '.anki.decks.DeckTreeRequest',
      '3': '.anki.decks.DeckTreeNode'
    },
    {
      '1': 'DeckTreeLegacy',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'GetAllDecksLegacy',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'GetDeckIdByName',
      '2': '.anki.generic.String',
      '3': '.anki.decks.DeckId'
    },
    {'1': 'GetDeck', '2': '.anki.decks.DeckId', '3': '.anki.decks.Deck'},
    {
      '1': 'UpdateDeck',
      '2': '.anki.decks.Deck',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'UpdateDeckLegacy',
      '2': '.anki.generic.Json',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'SetDeckCollapsed',
      '2': '.anki.decks.SetDeckCollapsedRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetDeckLegacy',
      '2': '.anki.decks.DeckId',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'GetDeckNames',
      '2': '.anki.decks.GetDeckNamesRequest',
      '3': '.anki.decks.DeckNames'
    },
    {
      '1': 'GetDeckAndChildNames',
      '2': '.anki.decks.DeckId',
      '3': '.anki.decks.DeckNames'
    },
    {
      '1': 'NewDeckLegacy',
      '2': '.anki.generic.Bool',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'RemoveDecks',
      '2': '.anki.decks.DeckIds',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'ReparentDecks',
      '2': '.anki.decks.ReparentDecksRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'RenameDeck',
      '2': '.anki.decks.RenameDeckRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetOrCreateFilteredDeck',
      '2': '.anki.decks.DeckId',
      '3': '.anki.decks.FilteredDeckForUpdate'
    },
    {
      '1': 'AddOrUpdateFilteredDeck',
      '2': '.anki.decks.FilteredDeckForUpdate',
      '3': '.anki.collection.OpChangesWithId'
    },
    {
      '1': 'FilteredDeckOrderLabels',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.StringList'
    },
    {
      '1': 'SetCurrentDeck',
      '2': '.anki.decks.DeckId',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetCurrentDeck',
      '2': '.anki.generic.Empty',
      '3': '.anki.decks.Deck'
    },
  ],
};

@$core.Deprecated('Use decksServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    DecksServiceBase$messageJson = {
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.decks.Deck': Deck$json,
  '.anki.decks.Deck.Common': Deck_Common$json,
  '.anki.decks.Deck.Normal': Deck_Normal$json,
  '.anki.decks.Deck.Normal.DayLimit': Deck_Normal_DayLimit$json,
  '.anki.decks.Deck.Filtered': Deck_Filtered$json,
  '.anki.decks.Deck.Filtered.SearchTerm': Deck_Filtered_SearchTerm$json,
  '.anki.collection.OpChangesWithId': $1.OpChangesWithId$json,
  '.anki.collection.OpChanges': $1.OpChanges$json,
  '.anki.generic.Json': $0.Json$json,
  '.anki.decks.AddOrUpdateDeckLegacyRequest': AddOrUpdateDeckLegacyRequest$json,
  '.anki.decks.DeckId': DeckId$json,
  '.anki.decks.DeckTreeRequest': DeckTreeRequest$json,
  '.anki.decks.DeckTreeNode': DeckTreeNode$json,
  '.anki.generic.String': $0.String$json,
  '.anki.decks.SetDeckCollapsedRequest': SetDeckCollapsedRequest$json,
  '.anki.decks.GetDeckNamesRequest': GetDeckNamesRequest$json,
  '.anki.decks.DeckNames': DeckNames$json,
  '.anki.decks.DeckNameId': DeckNameId$json,
  '.anki.generic.Bool': $0.Bool$json,
  '.anki.decks.DeckIds': DeckIds$json,
  '.anki.collection.OpChangesWithCount': $1.OpChangesWithCount$json,
  '.anki.decks.ReparentDecksRequest': ReparentDecksRequest$json,
  '.anki.decks.RenameDeckRequest': RenameDeckRequest$json,
  '.anki.decks.FilteredDeckForUpdate': FilteredDeckForUpdate$json,
  '.anki.generic.StringList': $0.StringList$json,
};

/// Descriptor for `DecksService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List decksServiceDescriptor = $convert.base64Decode(
    'CgxEZWNrc1NlcnZpY2USMAoHTmV3RGVjaxITLmFua2kuZ2VuZXJpYy5FbXB0eRoQLmFua2kuZG'
    'Vja3MuRGVjaxI9CgdBZGREZWNrEhAuYW5raS5kZWNrcy5EZWNrGiAuYW5raS5jb2xsZWN0aW9u'
    'Lk9wQ2hhbmdlc1dpdGhJZBJFCg1BZGREZWNrTGVnYWN5EhIuYW5raS5nZW5lcmljLkpzb24aIC'
    '5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzV2l0aElkElUKFUFkZE9yVXBkYXRlRGVja0xlZ2Fj'
    'eRIoLmFua2kuZGVja3MuQWRkT3JVcGRhdGVEZWNrTGVnYWN5UmVxdWVzdBoSLmFua2kuZGVja3'
    'MuRGVja0lkEkEKCERlY2tUcmVlEhsuYW5raS5kZWNrcy5EZWNrVHJlZVJlcXVlc3QaGC5hbmtp'
    'LmRlY2tzLkRlY2tUcmVlTm9kZRI5Cg5EZWNrVHJlZUxlZ2FjeRITLmFua2kuZ2VuZXJpYy5FbX'
    'B0eRoSLmFua2kuZ2VuZXJpYy5Kc29uEjwKEUdldEFsbERlY2tzTGVnYWN5EhMuYW5raS5nZW5l'
    'cmljLkVtcHR5GhIuYW5raS5nZW5lcmljLkpzb24SOwoPR2V0RGVja0lkQnlOYW1lEhQuYW5raS'
    '5nZW5lcmljLlN0cmluZxoSLmFua2kuZGVja3MuRGVja0lkEi8KB0dldERlY2sSEi5hbmtpLmRl'
    'Y2tzLkRlY2tJZBoQLmFua2kuZGVja3MuRGVjaxI6CgpVcGRhdGVEZWNrEhAuYW5raS5kZWNrcy'
    '5EZWNrGhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcxJCChBVcGRhdGVEZWNrTGVnYWN5EhIu'
    'YW5raS5nZW5lcmljLkpzb24aGi5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzElMKEFNldERlY2'
    'tDb2xsYXBzZWQSIy5hbmtpLmRlY2tzLlNldERlY2tDb2xsYXBzZWRSZXF1ZXN0GhouYW5raS5j'
    'b2xsZWN0aW9uLk9wQ2hhbmdlcxI3Cg1HZXREZWNrTGVnYWN5EhIuYW5raS5kZWNrcy5EZWNrSW'
    'QaEi5hbmtpLmdlbmVyaWMuSnNvbhJGCgxHZXREZWNrTmFtZXMSHy5hbmtpLmRlY2tzLkdldERl'
    'Y2tOYW1lc1JlcXVlc3QaFS5hbmtpLmRlY2tzLkRlY2tOYW1lcxJBChRHZXREZWNrQW5kQ2hpbG'
    'ROYW1lcxISLmFua2kuZGVja3MuRGVja0lkGhUuYW5raS5kZWNrcy5EZWNrTmFtZXMSNwoNTmV3'
    'RGVja0xlZ2FjeRISLmFua2kuZ2VuZXJpYy5Cb29sGhIuYW5raS5nZW5lcmljLkpzb24SRwoLUm'
    'Vtb3ZlRGVja3MSEy5hbmtpLmRlY2tzLkRlY2tJZHMaIy5hbmtpLmNvbGxlY3Rpb24uT3BDaGFu'
    'Z2VzV2l0aENvdW50ElYKDVJlcGFyZW50RGVja3MSIC5hbmtpLmRlY2tzLlJlcGFyZW50RGVja3'
    'NSZXF1ZXN0GiMuYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlc1dpdGhDb3VudBJHCgpSZW5hbWVE'
    'ZWNrEh0uYW5raS5kZWNrcy5SZW5hbWVEZWNrUmVxdWVzdBoaLmFua2kuY29sbGVjdGlvbi5PcE'
    'NoYW5nZXMSUAoXR2V0T3JDcmVhdGVGaWx0ZXJlZERlY2sSEi5hbmtpLmRlY2tzLkRlY2tJZBoh'
    'LmFua2kuZGVja3MuRmlsdGVyZWREZWNrRm9yVXBkYXRlEl4KF0FkZE9yVXBkYXRlRmlsdGVyZW'
    'REZWNrEiEuYW5raS5kZWNrcy5GaWx0ZXJlZERlY2tGb3JVcGRhdGUaIC5hbmtpLmNvbGxlY3Rp'
    'b24uT3BDaGFuZ2VzV2l0aElkEkgKF0ZpbHRlcmVkRGVja09yZGVyTGFiZWxzEhMuYW5raS5nZW'
    '5lcmljLkVtcHR5GhguYW5raS5nZW5lcmljLlN0cmluZ0xpc3QSQAoOU2V0Q3VycmVudERlY2sS'
    'Ei5hbmtpLmRlY2tzLkRlY2tJZBoaLmFua2kuY29sbGVjdGlvbi5PcENoYW5nZXMSNwoOR2V0Q3'
    'VycmVudERlY2sSEy5hbmtpLmdlbmVyaWMuRW1wdHkaEC5hbmtpLmRlY2tzLkRlY2s=');

const $core.Map<$core.String, $core.dynamic> BackendDecksServiceBase$json = {
  '1': 'BackendDecksService'
};

@$core.Deprecated('Use backendDecksServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendDecksServiceBase$messageJson = {};

/// Descriptor for `BackendDecksService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendDecksServiceDescriptor =
    $convert.base64Decode('ChNCYWNrZW5kRGVja3NTZXJ2aWNl');
