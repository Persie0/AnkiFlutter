// This is a generated file - do not edit.
//
// Generated from anki/stats.proto.

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

import 'cards.pbjson.dart' as $0;
import 'generic.pbjson.dart' as $1;

@$core.Deprecated('Use reviewLogsDescriptor instead')
const ReviewLogs$json = {
  '1': 'ReviewLogs',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.CardStatsResponse.StatsRevlogEntry',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `ReviewLogs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewLogsDescriptor = $convert.base64Decode(
    'CgpSZXZpZXdMb2dzEkgKB2VudHJpZXMYASADKAsyLi5hbmtpLnN0YXRzLkNhcmRTdGF0c1Jlc3'
    'BvbnNlLlN0YXRzUmV2bG9nRW50cnlSB2VudHJpZXM=');

@$core.Deprecated('Use cardStatsResponseDescriptor instead')
const CardStatsResponse$json = {
  '1': 'CardStatsResponse',
  '2': [
    {
      '1': 'revlog',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.CardStatsResponse.StatsRevlogEntry',
      '10': 'revlog'
    },
    {'1': 'card_id', '3': 2, '4': 1, '5': 3, '10': 'cardId'},
    {'1': 'note_id', '3': 3, '4': 1, '5': 3, '10': 'noteId'},
    {'1': 'deck', '3': 4, '4': 1, '5': 9, '10': 'deck'},
    {'1': 'added', '3': 5, '4': 1, '5': 3, '10': 'added'},
    {
      '1': 'first_review',
      '3': 6,
      '4': 1,
      '5': 3,
      '9': 0,
      '10': 'firstReview',
      '17': true
    },
    {
      '1': 'latest_review',
      '3': 7,
      '4': 1,
      '5': 3,
      '9': 1,
      '10': 'latestReview',
      '17': true
    },
    {
      '1': 'due_date',
      '3': 8,
      '4': 1,
      '5': 3,
      '9': 2,
      '10': 'dueDate',
      '17': true
    },
    {
      '1': 'due_position',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 3,
      '10': 'duePosition',
      '17': true
    },
    {'1': 'interval', '3': 10, '4': 1, '5': 13, '10': 'interval'},
    {'1': 'ease', '3': 11, '4': 1, '5': 13, '10': 'ease'},
    {'1': 'reviews', '3': 12, '4': 1, '5': 13, '10': 'reviews'},
    {'1': 'lapses', '3': 13, '4': 1, '5': 13, '10': 'lapses'},
    {'1': 'average_secs', '3': 14, '4': 1, '5': 2, '10': 'averageSecs'},
    {'1': 'total_secs', '3': 15, '4': 1, '5': 2, '10': 'totalSecs'},
    {'1': 'card_type', '3': 16, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'notetype', '3': 17, '4': 1, '5': 9, '10': 'notetype'},
    {
      '1': 'memory_state',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.FsrsMemoryState',
      '9': 4,
      '10': 'memoryState',
      '17': true
    },
    {
      '1': 'fsrs_retrievability',
      '3': 19,
      '4': 1,
      '5': 2,
      '9': 5,
      '10': 'fsrsRetrievability',
      '17': true
    },
    {'1': 'custom_data', '3': 20, '4': 1, '5': 9, '10': 'customData'},
    {'1': 'preset', '3': 21, '4': 1, '5': 9, '10': 'preset'},
    {
      '1': 'original_deck',
      '3': 22,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'originalDeck',
      '17': true
    },
    {
      '1': 'desired_retention',
      '3': 23,
      '4': 1,
      '5': 2,
      '9': 7,
      '10': 'desiredRetention',
      '17': true
    },
    {'1': 'fsrs_params', '3': 24, '4': 3, '5': 2, '10': 'fsrsParams'},
  ],
  '3': [CardStatsResponse_StatsRevlogEntry$json],
  '8': [
    {'1': '_first_review'},
    {'1': '_latest_review'},
    {'1': '_due_date'},
    {'1': '_due_position'},
    {'1': '_memory_state'},
    {'1': '_fsrs_retrievability'},
    {'1': '_original_deck'},
    {'1': '_desired_retention'},
  ],
};

@$core.Deprecated('Use cardStatsResponseDescriptor instead')
const CardStatsResponse_StatsRevlogEntry$json = {
  '1': 'StatsRevlogEntry',
  '2': [
    {'1': 'time', '3': 1, '4': 1, '5': 3, '10': 'time'},
    {
      '1': 'review_kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.stats.RevlogEntry.ReviewKind',
      '10': 'reviewKind'
    },
    {'1': 'button_chosen', '3': 3, '4': 1, '5': 13, '10': 'buttonChosen'},
    {'1': 'interval', '3': 4, '4': 1, '5': 13, '10': 'interval'},
    {'1': 'ease', '3': 5, '4': 1, '5': 13, '10': 'ease'},
    {'1': 'taken_secs', '3': 6, '4': 1, '5': 2, '10': 'takenSecs'},
    {
      '1': 'memory_state',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.FsrsMemoryState',
      '9': 0,
      '10': 'memoryState',
      '17': true
    },
    {'1': 'last_interval', '3': 8, '4': 1, '5': 13, '10': 'lastInterval'},
  ],
  '8': [
    {'1': '_memory_state'},
  ],
};

/// Descriptor for `CardStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardStatsResponseDescriptor = $convert.base64Decode(
    'ChFDYXJkU3RhdHNSZXNwb25zZRJGCgZyZXZsb2cYASADKAsyLi5hbmtpLnN0YXRzLkNhcmRTdG'
    'F0c1Jlc3BvbnNlLlN0YXRzUmV2bG9nRW50cnlSBnJldmxvZxIXCgdjYXJkX2lkGAIgASgDUgZj'
    'YXJkSWQSFwoHbm90ZV9pZBgDIAEoA1IGbm90ZUlkEhIKBGRlY2sYBCABKAlSBGRlY2sSFAoFYW'
    'RkZWQYBSABKANSBWFkZGVkEiYKDGZpcnN0X3JldmlldxgGIAEoA0gAUgtmaXJzdFJldmlld4gB'
    'ARIoCg1sYXRlc3RfcmV2aWV3GAcgASgDSAFSDGxhdGVzdFJldmlld4gBARIeCghkdWVfZGF0ZR'
    'gIIAEoA0gCUgdkdWVEYXRliAEBEiYKDGR1ZV9wb3NpdGlvbhgJIAEoBUgDUgtkdWVQb3NpdGlv'
    'bogBARIaCghpbnRlcnZhbBgKIAEoDVIIaW50ZXJ2YWwSEgoEZWFzZRgLIAEoDVIEZWFzZRIYCg'
    'dyZXZpZXdzGAwgASgNUgdyZXZpZXdzEhYKBmxhcHNlcxgNIAEoDVIGbGFwc2VzEiEKDGF2ZXJh'
    'Z2Vfc2VjcxgOIAEoAlILYXZlcmFnZVNlY3MSHQoKdG90YWxfc2VjcxgPIAEoAlIJdG90YWxTZW'
    'NzEhsKCWNhcmRfdHlwZRgQIAEoCVIIY2FyZFR5cGUSGgoIbm90ZXR5cGUYESABKAlSCG5vdGV0'
    'eXBlEkMKDG1lbW9yeV9zdGF0ZRgSIAEoCzIbLmFua2kuY2FyZHMuRnNyc01lbW9yeVN0YXRlSA'
    'RSC21lbW9yeVN0YXRliAEBEjQKE2ZzcnNfcmV0cmlldmFiaWxpdHkYEyABKAJIBVISZnNyc1Jl'
    'dHJpZXZhYmlsaXR5iAEBEh8KC2N1c3RvbV9kYXRhGBQgASgJUgpjdXN0b21EYXRhEhYKBnByZX'
    'NldBgVIAEoCVIGcHJlc2V0EigKDW9yaWdpbmFsX2RlY2sYFiABKAlIBlIMb3JpZ2luYWxEZWNr'
    'iAEBEjAKEWRlc2lyZWRfcmV0ZW50aW9uGBcgASgCSAdSEGRlc2lyZWRSZXRlbnRpb26IAQESHw'
    'oLZnNyc19wYXJhbXMYGCADKAJSCmZzcnNQYXJhbXMa2gIKEFN0YXRzUmV2bG9nRW50cnkSEgoE'
    'dGltZRgBIAEoA1IEdGltZRJDCgtyZXZpZXdfa2luZBgCIAEoDjIiLmFua2kuc3RhdHMuUmV2bG'
    '9nRW50cnkuUmV2aWV3S2luZFIKcmV2aWV3S2luZBIjCg1idXR0b25fY2hvc2VuGAMgASgNUgxi'
    'dXR0b25DaG9zZW4SGgoIaW50ZXJ2YWwYBCABKA1SCGludGVydmFsEhIKBGVhc2UYBSABKA1SBG'
    'Vhc2USHQoKdGFrZW5fc2VjcxgGIAEoAlIJdGFrZW5TZWNzEkMKDG1lbW9yeV9zdGF0ZRgHIAEo'
    'CzIbLmFua2kuY2FyZHMuRnNyc01lbW9yeVN0YXRlSABSC21lbW9yeVN0YXRliAEBEiMKDWxhc3'
    'RfaW50ZXJ2YWwYCCABKA1SDGxhc3RJbnRlcnZhbEIPCg1fbWVtb3J5X3N0YXRlQg8KDV9maXJz'
    'dF9yZXZpZXdCEAoOX2xhdGVzdF9yZXZpZXdCCwoJX2R1ZV9kYXRlQg8KDV9kdWVfcG9zaXRpb2'
    '5CDwoNX21lbW9yeV9zdGF0ZUIWChRfZnNyc19yZXRyaWV2YWJpbGl0eUIQCg5fb3JpZ2luYWxf'
    'ZGVja0IUChJfZGVzaXJlZF9yZXRlbnRpb24=');

@$core.Deprecated('Use graphsRequestDescriptor instead')
const GraphsRequest$json = {
  '1': 'GraphsRequest',
  '2': [
    {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
    {'1': 'days', '3': 2, '4': 1, '5': 13, '10': 'days'},
  ],
};

/// Descriptor for `GraphsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphsRequestDescriptor = $convert.base64Decode(
    'Cg1HcmFwaHNSZXF1ZXN0EhYKBnNlYXJjaBgBIAEoCVIGc2VhcmNoEhIKBGRheXMYAiABKA1SBG'
    'RheXM=');

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse$json = {
  '1': 'GraphsResponse',
  '2': [
    {
      '1': 'buttons',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Buttons',
      '10': 'buttons'
    },
    {
      '1': 'card_counts',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.CardCounts',
      '10': 'cardCounts'
    },
    {
      '1': 'hours',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Hours',
      '10': 'hours'
    },
    {
      '1': 'today',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Today',
      '10': 'today'
    },
    {
      '1': 'eases',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Eases',
      '10': 'eases'
    },
    {
      '1': 'difficulty',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Eases',
      '10': 'difficulty'
    },
    {
      '1': 'intervals',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Intervals',
      '10': 'intervals'
    },
    {
      '1': 'future_due',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.FutureDue',
      '10': 'futureDue'
    },
    {
      '1': 'added',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Added',
      '10': 'added'
    },
    {
      '1': 'reviews',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.ReviewCountsAndTimes',
      '10': 'reviews'
    },
    {'1': 'rollover_hour', '3': 10, '4': 1, '5': 13, '10': 'rolloverHour'},
    {
      '1': 'retrievability',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Retrievability',
      '10': 'retrievability'
    },
    {'1': 'fsrs', '3': 13, '4': 1, '5': 8, '10': 'fsrs'},
    {
      '1': 'stability',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Intervals',
      '10': 'stability'
    },
    {
      '1': 'true_retention',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.TrueRetentionStats',
      '10': 'trueRetention'
    },
  ],
  '3': [
    GraphsResponse_Added$json,
    GraphsResponse_Intervals$json,
    GraphsResponse_Eases$json,
    GraphsResponse_Retrievability$json,
    GraphsResponse_FutureDue$json,
    GraphsResponse_Today$json,
    GraphsResponse_Hours$json,
    GraphsResponse_ReviewCountsAndTimes$json,
    GraphsResponse_Buttons$json,
    GraphsResponse_CardCounts$json,
    GraphsResponse_TrueRetentionStats$json
  ],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Added$json = {
  '1': 'Added',
  '2': [
    {
      '1': 'added',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Added.AddedEntry',
      '10': 'added'
    },
  ],
  '3': [GraphsResponse_Added_AddedEntry$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Added_AddedEntry$json = {
  '1': 'AddedEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Intervals$json = {
  '1': 'Intervals',
  '2': [
    {
      '1': 'intervals',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Intervals.IntervalsEntry',
      '10': 'intervals'
    },
  ],
  '3': [GraphsResponse_Intervals_IntervalsEntry$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Intervals_IntervalsEntry$json = {
  '1': 'IntervalsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Eases$json = {
  '1': 'Eases',
  '2': [
    {
      '1': 'eases',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Eases.EasesEntry',
      '10': 'eases'
    },
    {'1': 'average', '3': 2, '4': 1, '5': 2, '10': 'average'},
  ],
  '3': [GraphsResponse_Eases_EasesEntry$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Eases_EasesEntry$json = {
  '1': 'EasesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Retrievability$json = {
  '1': 'Retrievability',
  '2': [
    {
      '1': 'retrievability',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Retrievability.RetrievabilityEntry',
      '10': 'retrievability'
    },
    {'1': 'average', '3': 2, '4': 1, '5': 2, '10': 'average'},
    {'1': 'sum_by_card', '3': 3, '4': 1, '5': 2, '10': 'sumByCard'},
    {'1': 'sum_by_note', '3': 4, '4': 1, '5': 2, '10': 'sumByNote'},
  ],
  '3': [GraphsResponse_Retrievability_RetrievabilityEntry$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Retrievability_RetrievabilityEntry$json = {
  '1': 'RetrievabilityEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_FutureDue$json = {
  '1': 'FutureDue',
  '2': [
    {
      '1': 'future_due',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.FutureDue.FutureDueEntry',
      '10': 'futureDue'
    },
    {'1': 'have_backlog', '3': 2, '4': 1, '5': 8, '10': 'haveBacklog'},
    {'1': 'daily_load', '3': 3, '4': 1, '5': 13, '10': 'dailyLoad'},
  ],
  '3': [GraphsResponse_FutureDue_FutureDueEntry$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_FutureDue_FutureDueEntry$json = {
  '1': 'FutureDueEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Today$json = {
  '1': 'Today',
  '2': [
    {'1': 'answer_count', '3': 1, '4': 1, '5': 13, '10': 'answerCount'},
    {'1': 'answer_millis', '3': 2, '4': 1, '5': 13, '10': 'answerMillis'},
    {'1': 'correct_count', '3': 3, '4': 1, '5': 13, '10': 'correctCount'},
    {'1': 'mature_correct', '3': 4, '4': 1, '5': 13, '10': 'matureCorrect'},
    {'1': 'mature_count', '3': 5, '4': 1, '5': 13, '10': 'matureCount'},
    {'1': 'learn_count', '3': 6, '4': 1, '5': 13, '10': 'learnCount'},
    {'1': 'review_count', '3': 7, '4': 1, '5': 13, '10': 'reviewCount'},
    {'1': 'relearn_count', '3': 8, '4': 1, '5': 13, '10': 'relearnCount'},
    {
      '1': 'early_review_count',
      '3': 9,
      '4': 1,
      '5': 13,
      '10': 'earlyReviewCount'
    },
  ],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Hours$json = {
  '1': 'Hours',
  '2': [
    {
      '1': 'one_month',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Hours.Hour',
      '10': 'oneMonth'
    },
    {
      '1': 'three_months',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Hours.Hour',
      '10': 'threeMonths'
    },
    {
      '1': 'one_year',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Hours.Hour',
      '10': 'oneYear'
    },
    {
      '1': 'all_time',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Hours.Hour',
      '10': 'allTime'
    },
  ],
  '3': [GraphsResponse_Hours_Hour$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Hours_Hour$json = {
  '1': 'Hour',
  '2': [
    {'1': 'total', '3': 1, '4': 1, '5': 13, '10': 'total'},
    {'1': 'correct', '3': 2, '4': 1, '5': 13, '10': 'correct'},
  ],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_ReviewCountsAndTimes$json = {
  '1': 'ReviewCountsAndTimes',
  '2': [
    {
      '1': 'count',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.ReviewCountsAndTimes.CountEntry',
      '10': 'count'
    },
    {
      '1': 'time',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.ReviewCountsAndTimes.TimeEntry',
      '10': 'time'
    },
  ],
  '3': [
    GraphsResponse_ReviewCountsAndTimes_Reviews$json,
    GraphsResponse_ReviewCountsAndTimes_CountEntry$json,
    GraphsResponse_ReviewCountsAndTimes_TimeEntry$json
  ],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_ReviewCountsAndTimes_Reviews$json = {
  '1': 'Reviews',
  '2': [
    {'1': 'learn', '3': 1, '4': 1, '5': 13, '10': 'learn'},
    {'1': 'relearn', '3': 2, '4': 1, '5': 13, '10': 'relearn'},
    {'1': 'young', '3': 3, '4': 1, '5': 13, '10': 'young'},
    {'1': 'mature', '3': 4, '4': 1, '5': 13, '10': 'mature'},
    {'1': 'filtered', '3': 5, '4': 1, '5': 13, '10': 'filtered'},
  ],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_ReviewCountsAndTimes_CountEntry$json = {
  '1': 'CountEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.ReviewCountsAndTimes.Reviews',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_ReviewCountsAndTimes_TimeEntry$json = {
  '1': 'TimeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.ReviewCountsAndTimes.Reviews',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Buttons$json = {
  '1': 'Buttons',
  '2': [
    {
      '1': 'one_month',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Buttons.ButtonCounts',
      '10': 'oneMonth'
    },
    {
      '1': 'three_months',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Buttons.ButtonCounts',
      '10': 'threeMonths'
    },
    {
      '1': 'one_year',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Buttons.ButtonCounts',
      '10': 'oneYear'
    },
    {
      '1': 'all_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.Buttons.ButtonCounts',
      '10': 'allTime'
    },
  ],
  '3': [GraphsResponse_Buttons_ButtonCounts$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_Buttons_ButtonCounts$json = {
  '1': 'ButtonCounts',
  '2': [
    {'1': 'learning', '3': 1, '4': 3, '5': 13, '10': 'learning'},
    {'1': 'young', '3': 2, '4': 3, '5': 13, '10': 'young'},
    {'1': 'mature', '3': 3, '4': 3, '5': 13, '10': 'mature'},
  ],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_CardCounts$json = {
  '1': 'CardCounts',
  '2': [
    {
      '1': 'including_inactive',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.CardCounts.Counts',
      '10': 'includingInactive'
    },
    {
      '1': 'excluding_inactive',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.CardCounts.Counts',
      '10': 'excludingInactive'
    },
  ],
  '3': [GraphsResponse_CardCounts_Counts$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_CardCounts_Counts$json = {
  '1': 'Counts',
  '2': [
    {'1': 'newCards', '3': 1, '4': 1, '5': 13, '10': 'newCards'},
    {'1': 'learn', '3': 2, '4': 1, '5': 13, '10': 'learn'},
    {'1': 'relearn', '3': 3, '4': 1, '5': 13, '10': 'relearn'},
    {'1': 'young', '3': 4, '4': 1, '5': 13, '10': 'young'},
    {'1': 'mature', '3': 5, '4': 1, '5': 13, '10': 'mature'},
    {'1': 'suspended', '3': 6, '4': 1, '5': 13, '10': 'suspended'},
    {'1': 'buried', '3': 7, '4': 1, '5': 13, '10': 'buried'},
  ],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_TrueRetentionStats$json = {
  '1': 'TrueRetentionStats',
  '2': [
    {
      '1': 'today',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.TrueRetentionStats.TrueRetention',
      '10': 'today'
    },
    {
      '1': 'yesterday',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.TrueRetentionStats.TrueRetention',
      '10': 'yesterday'
    },
    {
      '1': 'week',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.TrueRetentionStats.TrueRetention',
      '10': 'week'
    },
    {
      '1': 'month',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.TrueRetentionStats.TrueRetention',
      '10': 'month'
    },
    {
      '1': 'year',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.TrueRetentionStats.TrueRetention',
      '10': 'year'
    },
    {
      '1': 'all_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.anki.stats.GraphsResponse.TrueRetentionStats.TrueRetention',
      '10': 'allTime'
    },
  ],
  '3': [GraphsResponse_TrueRetentionStats_TrueRetention$json],
};

@$core.Deprecated('Use graphsResponseDescriptor instead')
const GraphsResponse_TrueRetentionStats_TrueRetention$json = {
  '1': 'TrueRetention',
  '2': [
    {'1': 'young_passed', '3': 1, '4': 1, '5': 13, '10': 'youngPassed'},
    {'1': 'young_failed', '3': 2, '4': 1, '5': 13, '10': 'youngFailed'},
    {'1': 'mature_passed', '3': 3, '4': 1, '5': 13, '10': 'maturePassed'},
    {'1': 'mature_failed', '3': 4, '4': 1, '5': 13, '10': 'matureFailed'},
  ],
};

/// Descriptor for `GraphsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphsResponseDescriptor = $convert.base64Decode(
    'Cg5HcmFwaHNSZXNwb25zZRI8CgdidXR0b25zGAEgASgLMiIuYW5raS5zdGF0cy5HcmFwaHNSZX'
    'Nwb25zZS5CdXR0b25zUgdidXR0b25zEkYKC2NhcmRfY291bnRzGAIgASgLMiUuYW5raS5zdGF0'
    'cy5HcmFwaHNSZXNwb25zZS5DYXJkQ291bnRzUgpjYXJkQ291bnRzEjYKBWhvdXJzGAMgASgLMi'
    'AuYW5raS5zdGF0cy5HcmFwaHNSZXNwb25zZS5Ib3Vyc1IFaG91cnMSNgoFdG9kYXkYBCABKAsy'
    'IC5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLlRvZGF5UgV0b2RheRI2CgVlYXNlcxgFIAEoCz'
    'IgLmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2UuRWFzZXNSBWVhc2VzEkAKCmRpZmZpY3VsdHkY'
    'CyABKAsyIC5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLkVhc2VzUgpkaWZmaWN1bHR5EkIKCW'
    'ludGVydmFscxgGIAEoCzIkLmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2UuSW50ZXJ2YWxzUglp'
    'bnRlcnZhbHMSQwoKZnV0dXJlX2R1ZRgHIAEoCzIkLmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2'
    'UuRnV0dXJlRHVlUglmdXR1cmVEdWUSNgoFYWRkZWQYCCABKAsyIC5hbmtpLnN0YXRzLkdyYXBo'
    'c1Jlc3BvbnNlLkFkZGVkUgVhZGRlZBJJCgdyZXZpZXdzGAkgASgLMi8uYW5raS5zdGF0cy5Hcm'
    'FwaHNSZXNwb25zZS5SZXZpZXdDb3VudHNBbmRUaW1lc1IHcmV2aWV3cxIjCg1yb2xsb3Zlcl9o'
    'b3VyGAogASgNUgxyb2xsb3ZlckhvdXISUQoOcmV0cmlldmFiaWxpdHkYDCABKAsyKS5hbmtpLn'
    'N0YXRzLkdyYXBoc1Jlc3BvbnNlLlJldHJpZXZhYmlsaXR5Ug5yZXRyaWV2YWJpbGl0eRISCgRm'
    'c3JzGA0gASgIUgRmc3JzEkIKCXN0YWJpbGl0eRgOIAEoCzIkLmFua2kuc3RhdHMuR3JhcGhzUm'
    'VzcG9uc2UuSW50ZXJ2YWxzUglzdGFiaWxpdHkSVAoOdHJ1ZV9yZXRlbnRpb24YDyABKAsyLS5h'
    'bmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLlRydWVSZXRlbnRpb25TdGF0c1INdHJ1ZVJldGVudG'
    'lvbhqEAQoFQWRkZWQSQQoFYWRkZWQYASADKAsyKy5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNl'
    'LkFkZGVkLkFkZGVkRW50cnlSBWFkZGVkGjgKCkFkZGVkRW50cnkSEAoDa2V5GAEgASgFUgNrZX'
    'kSFAoFdmFsdWUYAiABKA1SBXZhbHVlOgI4ARqcAQoJSW50ZXJ2YWxzElEKCWludGVydmFscxgB'
    'IAMoCzIzLmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2UuSW50ZXJ2YWxzLkludGVydmFsc0VudH'
    'J5UglpbnRlcnZhbHMaPAoOSW50ZXJ2YWxzRW50cnkSEAoDa2V5GAEgASgNUgNrZXkSFAoFdmFs'
    'dWUYAiABKA1SBXZhbHVlOgI4ARqeAQoFRWFzZXMSQQoFZWFzZXMYASADKAsyKy5hbmtpLnN0YX'
    'RzLkdyYXBoc1Jlc3BvbnNlLkVhc2VzLkVhc2VzRW50cnlSBWVhc2VzEhgKB2F2ZXJhZ2UYAiAB'
    'KAJSB2F2ZXJhZ2UaOAoKRWFzZXNFbnRyeRIQCgNrZXkYASABKA1SA2tleRIUCgV2YWx1ZRgCIA'
    'EoDVIFdmFsdWU6AjgBGpQCCg5SZXRyaWV2YWJpbGl0eRJlCg5yZXRyaWV2YWJpbGl0eRgBIAMo'
    'CzI9LmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2UuUmV0cmlldmFiaWxpdHkuUmV0cmlldmFiaW'
    'xpdHlFbnRyeVIOcmV0cmlldmFiaWxpdHkSGAoHYXZlcmFnZRgCIAEoAlIHYXZlcmFnZRIeCgtz'
    'dW1fYnlfY2FyZBgDIAEoAlIJc3VtQnlDYXJkEh4KC3N1bV9ieV9ub3RlGAQgASgCUglzdW1CeU'
    '5vdGUaQQoTUmV0cmlldmFiaWxpdHlFbnRyeRIQCgNrZXkYASABKA1SA2tleRIUCgV2YWx1ZRgC'
    'IAEoDVIFdmFsdWU6AjgBGt8BCglGdXR1cmVEdWUSUgoKZnV0dXJlX2R1ZRgBIAMoCzIzLmFua2'
    'kuc3RhdHMuR3JhcGhzUmVzcG9uc2UuRnV0dXJlRHVlLkZ1dHVyZUR1ZUVudHJ5UglmdXR1cmVE'
    'dWUSIQoMaGF2ZV9iYWNrbG9nGAIgASgIUgtoYXZlQmFja2xvZxIdCgpkYWlseV9sb2FkGAMgAS'
    'gNUglkYWlseUxvYWQaPAoORnV0dXJlRHVlRW50cnkSEAoDa2V5GAEgASgFUgNrZXkSFAoFdmFs'
    'dWUYAiABKA1SBXZhbHVlOgI4ARrVAgoFVG9kYXkSIQoMYW5zd2VyX2NvdW50GAEgASgNUgthbn'
    'N3ZXJDb3VudBIjCg1hbnN3ZXJfbWlsbGlzGAIgASgNUgxhbnN3ZXJNaWxsaXMSIwoNY29ycmVj'
    'dF9jb3VudBgDIAEoDVIMY29ycmVjdENvdW50EiUKDm1hdHVyZV9jb3JyZWN0GAQgASgNUg1tYX'
    'R1cmVDb3JyZWN0EiEKDG1hdHVyZV9jb3VudBgFIAEoDVILbWF0dXJlQ291bnQSHwoLbGVhcm5f'
    'Y291bnQYBiABKA1SCmxlYXJuQ291bnQSIQoMcmV2aWV3X2NvdW50GAcgASgNUgtyZXZpZXdDb3'
    'VudBIjCg1yZWxlYXJuX2NvdW50GAggASgNUgxyZWxlYXJuQ291bnQSLAoSZWFybHlfcmV2aWV3'
    'X2NvdW50GAkgASgNUhBlYXJseVJldmlld0NvdW50GtECCgVIb3VycxJCCglvbmVfbW9udGgYAS'
    'ADKAsyJS5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLkhvdXJzLkhvdXJSCG9uZU1vbnRoEkgK'
    'DHRocmVlX21vbnRocxgCIAMoCzIlLmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2UuSG91cnMuSG'
    '91clILdGhyZWVNb250aHMSQAoIb25lX3llYXIYAyADKAsyJS5hbmtpLnN0YXRzLkdyYXBoc1Jl'
    'c3BvbnNlLkhvdXJzLkhvdXJSB29uZVllYXISQAoIYWxsX3RpbWUYBCADKAsyJS5hbmtpLnN0YX'
    'RzLkdyYXBoc1Jlc3BvbnNlLkhvdXJzLkhvdXJSB2FsbFRpbWUaNgoESG91chIUCgV0b3RhbBgB'
    'IAEoDVIFdG90YWwSGAoHY29ycmVjdBgCIAEoDVIHY29ycmVjdBqiBAoUUmV2aWV3Q291bnRzQW'
    '5kVGltZXMSUAoFY291bnQYASADKAsyOi5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLlJldmll'
    'd0NvdW50c0FuZFRpbWVzLkNvdW50RW50cnlSBWNvdW50Ek0KBHRpbWUYAiADKAsyOS5hbmtpLn'
    'N0YXRzLkdyYXBoc1Jlc3BvbnNlLlJldmlld0NvdW50c0FuZFRpbWVzLlRpbWVFbnRyeVIEdGlt'
    'ZRqDAQoHUmV2aWV3cxIUCgVsZWFybhgBIAEoDVIFbGVhcm4SGAoHcmVsZWFybhgCIAEoDVIHcm'
    'VsZWFybhIUCgV5b3VuZxgDIAEoDVIFeW91bmcSFgoGbWF0dXJlGAQgASgNUgZtYXR1cmUSGgoI'
    'ZmlsdGVyZWQYBSABKA1SCGZpbHRlcmVkGnEKCkNvdW50RW50cnkSEAoDa2V5GAEgASgFUgNrZX'
    'kSTQoFdmFsdWUYAiABKAsyNy5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLlJldmlld0NvdW50'
    'c0FuZFRpbWVzLlJldmlld3NSBXZhbHVlOgI4ARpwCglUaW1lRW50cnkSEAoDa2V5GAEgASgFUg'
    'NrZXkSTQoFdmFsdWUYAiABKAsyNy5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLlJldmlld0Nv'
    'dW50c0FuZFRpbWVzLlJldmlld3NSBXZhbHVlOgI4ARqdAwoHQnV0dG9ucxJMCglvbmVfbW9udG'
    'gYASABKAsyLy5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLkJ1dHRvbnMuQnV0dG9uQ291bnRz'
    'UghvbmVNb250aBJSCgx0aHJlZV9tb250aHMYAiABKAsyLy5hbmtpLnN0YXRzLkdyYXBoc1Jlc3'
    'BvbnNlLkJ1dHRvbnMuQnV0dG9uQ291bnRzUgt0aHJlZU1vbnRocxJKCghvbmVfeWVhchgDIAEo'
    'CzIvLmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2UuQnV0dG9ucy5CdXR0b25Db3VudHNSB29uZV'
    'llYXISSgoIYWxsX3RpbWUYBCABKAsyLy5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLkJ1dHRv'
    'bnMuQnV0dG9uQ291bnRzUgdhbGxUaW1lGlgKDEJ1dHRvbkNvdW50cxIaCghsZWFybmluZxgBIA'
    'MoDVIIbGVhcm5pbmcSFAoFeW91bmcYAiADKA1SBXlvdW5nEhYKBm1hdHVyZRgDIAMoDVIGbWF0'
    'dXJlGoEDCgpDYXJkQ291bnRzElsKEmluY2x1ZGluZ19pbmFjdGl2ZRgBIAEoCzIsLmFua2kuc3'
    'RhdHMuR3JhcGhzUmVzcG9uc2UuQ2FyZENvdW50cy5Db3VudHNSEWluY2x1ZGluZ0luYWN0aXZl'
    'ElsKEmV4Y2x1ZGluZ19pbmFjdGl2ZRgCIAEoCzIsLmFua2kuc3RhdHMuR3JhcGhzUmVzcG9uc2'
    'UuQ2FyZENvdW50cy5Db3VudHNSEWV4Y2x1ZGluZ0luYWN0aXZlGrgBCgZDb3VudHMSGgoIbmV3'
    'Q2FyZHMYASABKA1SCG5ld0NhcmRzEhQKBWxlYXJuGAIgASgNUgVsZWFybhIYCgdyZWxlYXJuGA'
    'MgASgNUgdyZWxlYXJuEhQKBXlvdW5nGAQgASgNUgV5b3VuZxIWCgZtYXR1cmUYBSABKA1SBm1h'
    'dHVyZRIcCglzdXNwZW5kZWQYBiABKA1SCXN1c3BlbmRlZBIWCgZidXJpZWQYByABKA1SBmJ1cm'
    'llZBqxBQoSVHJ1ZVJldGVudGlvblN0YXRzElEKBXRvZGF5GAEgASgLMjsuYW5raS5zdGF0cy5H'
    'cmFwaHNSZXNwb25zZS5UcnVlUmV0ZW50aW9uU3RhdHMuVHJ1ZVJldGVudGlvblIFdG9kYXkSWQ'
    'oJeWVzdGVyZGF5GAIgASgLMjsuYW5raS5zdGF0cy5HcmFwaHNSZXNwb25zZS5UcnVlUmV0ZW50'
    'aW9uU3RhdHMuVHJ1ZVJldGVudGlvblIJeWVzdGVyZGF5Ek8KBHdlZWsYAyABKAsyOy5hbmtpLn'
    'N0YXRzLkdyYXBoc1Jlc3BvbnNlLlRydWVSZXRlbnRpb25TdGF0cy5UcnVlUmV0ZW50aW9uUgR3'
    'ZWVrElEKBW1vbnRoGAQgASgLMjsuYW5raS5zdGF0cy5HcmFwaHNSZXNwb25zZS5UcnVlUmV0ZW'
    '50aW9uU3RhdHMuVHJ1ZVJldGVudGlvblIFbW9udGgSTwoEeWVhchgFIAEoCzI7LmFua2kuc3Rh'
    'dHMuR3JhcGhzUmVzcG9uc2UuVHJ1ZVJldGVudGlvblN0YXRzLlRydWVSZXRlbnRpb25SBHllYX'
    'ISVgoIYWxsX3RpbWUYBiABKAsyOy5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlLlRydWVSZXRl'
    'bnRpb25TdGF0cy5UcnVlUmV0ZW50aW9uUgdhbGxUaW1lGp8BCg1UcnVlUmV0ZW50aW9uEiEKDH'
    'lvdW5nX3Bhc3NlZBgBIAEoDVILeW91bmdQYXNzZWQSIQoMeW91bmdfZmFpbGVkGAIgASgNUgt5'
    'b3VuZ0ZhaWxlZBIjCg1tYXR1cmVfcGFzc2VkGAMgASgNUgxtYXR1cmVQYXNzZWQSIwoNbWF0dX'
    'JlX2ZhaWxlZBgEIAEoDVIMbWF0dXJlRmFpbGVk');

@$core.Deprecated('Use graphPreferencesDescriptor instead')
const GraphPreferences$json = {
  '1': 'GraphPreferences',
  '2': [
    {
      '1': 'calendar_first_day_of_week',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.stats.GraphPreferences.Weekday',
      '10': 'calendarFirstDayOfWeek'
    },
    {
      '1': 'card_counts_separate_inactive',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'cardCountsSeparateInactive'
    },
    {
      '1': 'browser_links_supported',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'browserLinksSupported'
    },
    {
      '1': 'future_due_show_backlog',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'futureDueShowBacklog'
    },
  ],
  '4': [GraphPreferences_Weekday$json],
};

@$core.Deprecated('Use graphPreferencesDescriptor instead')
const GraphPreferences_Weekday$json = {
  '1': 'Weekday',
  '2': [
    {'1': 'SUNDAY', '2': 0},
    {'1': 'MONDAY', '2': 1},
    {'1': 'FRIDAY', '2': 5},
    {'1': 'SATURDAY', '2': 6},
  ],
};

/// Descriptor for `GraphPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphPreferencesDescriptor = $convert.base64Decode(
    'ChBHcmFwaFByZWZlcmVuY2VzEmAKGmNhbGVuZGFyX2ZpcnN0X2RheV9vZl93ZWVrGAEgASgOMi'
    'QuYW5raS5zdGF0cy5HcmFwaFByZWZlcmVuY2VzLldlZWtkYXlSFmNhbGVuZGFyRmlyc3REYXlP'
    'ZldlZWsSQQodY2FyZF9jb3VudHNfc2VwYXJhdGVfaW5hY3RpdmUYAiABKAhSGmNhcmRDb3VudH'
    'NTZXBhcmF0ZUluYWN0aXZlEjYKF2Jyb3dzZXJfbGlua3Nfc3VwcG9ydGVkGAMgASgIUhVicm93'
    'c2VyTGlua3NTdXBwb3J0ZWQSNQoXZnV0dXJlX2R1ZV9zaG93X2JhY2tsb2cYBCABKAhSFGZ1dH'
    'VyZUR1ZVNob3dCYWNrbG9nIjsKB1dlZWtkYXkSCgoGU1VOREFZEAASCgoGTU9OREFZEAESCgoG'
    'RlJJREFZEAUSDAoIU0FUVVJEQVkQBg==');

@$core.Deprecated('Use revlogEntryDescriptor instead')
const RevlogEntry$json = {
  '1': 'RevlogEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'cid', '3': 2, '4': 1, '5': 3, '10': 'cid'},
    {'1': 'usn', '3': 3, '4': 1, '5': 5, '10': 'usn'},
    {'1': 'button_chosen', '3': 4, '4': 1, '5': 13, '10': 'buttonChosen'},
    {'1': 'interval', '3': 5, '4': 1, '5': 5, '10': 'interval'},
    {'1': 'last_interval', '3': 6, '4': 1, '5': 5, '10': 'lastInterval'},
    {'1': 'ease_factor', '3': 7, '4': 1, '5': 13, '10': 'easeFactor'},
    {'1': 'taken_millis', '3': 8, '4': 1, '5': 13, '10': 'takenMillis'},
    {
      '1': 'review_kind',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.anki.stats.RevlogEntry.ReviewKind',
      '10': 'reviewKind'
    },
  ],
  '4': [RevlogEntry_ReviewKind$json],
};

@$core.Deprecated('Use revlogEntryDescriptor instead')
const RevlogEntry_ReviewKind$json = {
  '1': 'ReviewKind',
  '2': [
    {'1': 'LEARNING', '2': 0},
    {'1': 'REVIEW', '2': 1},
    {'1': 'RELEARNING', '2': 2},
    {'1': 'FILTERED', '2': 3},
    {'1': 'MANUAL', '2': 4},
    {'1': 'RESCHEDULED', '2': 5},
  ],
};

/// Descriptor for `RevlogEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revlogEntryDescriptor = $convert.base64Decode(
    'CgtSZXZsb2dFbnRyeRIOCgJpZBgBIAEoA1ICaWQSEAoDY2lkGAIgASgDUgNjaWQSEAoDdXNuGA'
    'MgASgFUgN1c24SIwoNYnV0dG9uX2Nob3NlbhgEIAEoDVIMYnV0dG9uQ2hvc2VuEhoKCGludGVy'
    'dmFsGAUgASgFUghpbnRlcnZhbBIjCg1sYXN0X2ludGVydmFsGAYgASgFUgxsYXN0SW50ZXJ2YW'
    'wSHwoLZWFzZV9mYWN0b3IYByABKA1SCmVhc2VGYWN0b3ISIQoMdGFrZW5fbWlsbGlzGAggASgN'
    'Ugt0YWtlbk1pbGxpcxJDCgtyZXZpZXdfa2luZBgJIAEoDjIiLmFua2kuc3RhdHMuUmV2bG9nRW'
    '50cnkuUmV2aWV3S2luZFIKcmV2aWV3S2luZCJhCgpSZXZpZXdLaW5kEgwKCExFQVJOSU5HEAAS'
    'CgoGUkVWSUVXEAESDgoKUkVMRUFSTklORxACEgwKCEZJTFRFUkVEEAMSCgoGTUFOVUFMEAQSDw'
    'oLUkVTQ0hFRFVMRUQQBQ==');

@$core.Deprecated('Use cardEntryDescriptor instead')
const CardEntry$json = {
  '1': 'CardEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'note_id', '3': 2, '4': 1, '5': 3, '10': 'noteId'},
    {'1': 'deck_id', '3': 3, '4': 1, '5': 3, '10': 'deckId'},
  ],
};

/// Descriptor for `CardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardEntryDescriptor = $convert.base64Decode(
    'CglDYXJkRW50cnkSDgoCaWQYASABKANSAmlkEhcKB25vdGVfaWQYAiABKANSBm5vdGVJZBIXCg'
    'dkZWNrX2lkGAMgASgDUgZkZWNrSWQ=');

@$core.Deprecated('Use deckEntryDescriptor instead')
const DeckEntry$json = {
  '1': 'DeckEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'parent_id', '3': 2, '4': 1, '5': 3, '10': 'parentId'},
    {'1': 'preset_id', '3': 3, '4': 1, '5': 3, '10': 'presetId'},
  ],
};

/// Descriptor for `DeckEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckEntryDescriptor = $convert.base64Decode(
    'CglEZWNrRW50cnkSDgoCaWQYASABKANSAmlkEhsKCXBhcmVudF9pZBgCIAEoA1IIcGFyZW50SW'
    'QSGwoJcHJlc2V0X2lkGAMgASgDUghwcmVzZXRJZA==');

@$core.Deprecated('Use datasetDescriptor instead')
const Dataset$json = {
  '1': 'Dataset',
  '2': [
    {
      '1': 'revlogs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.RevlogEntry',
      '10': 'revlogs'
    },
    {
      '1': 'cards',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.CardEntry',
      '10': 'cards'
    },
    {
      '1': 'decks',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.anki.stats.DeckEntry',
      '10': 'decks'
    },
    {'1': 'next_day_at', '3': 4, '4': 1, '5': 3, '10': 'nextDayAt'},
  ],
};

/// Descriptor for `Dataset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List datasetDescriptor = $convert.base64Decode(
    'CgdEYXRhc2V0EjEKB3JldmxvZ3MYASADKAsyFy5hbmtpLnN0YXRzLlJldmxvZ0VudHJ5UgdyZX'
    'Zsb2dzEisKBWNhcmRzGAIgAygLMhUuYW5raS5zdGF0cy5DYXJkRW50cnlSBWNhcmRzEisKBWRl'
    'Y2tzGAMgAygLMhUuYW5raS5zdGF0cy5EZWNrRW50cnlSBWRlY2tzEh4KC25leHRfZGF5X2F0GA'
    'QgASgDUgluZXh0RGF5QXQ=');

const $core.Map<$core.String, $core.dynamic> StatsServiceBase$json = {
  '1': 'StatsService',
  '2': [
    {
      '1': 'CardStats',
      '2': '.anki.cards.CardId',
      '3': '.anki.stats.CardStatsResponse'
    },
    {
      '1': 'GetReviewLogs',
      '2': '.anki.cards.CardId',
      '3': '.anki.stats.ReviewLogs'
    },
    {
      '1': 'Graphs',
      '2': '.anki.stats.GraphsRequest',
      '3': '.anki.stats.GraphsResponse'
    },
    {
      '1': 'GetGraphPreferences',
      '2': '.anki.generic.Empty',
      '3': '.anki.stats.GraphPreferences'
    },
    {
      '1': 'SetGraphPreferences',
      '2': '.anki.stats.GraphPreferences',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use statsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    StatsServiceBase$messageJson = {
  '.anki.cards.CardId': $0.CardId$json,
  '.anki.stats.CardStatsResponse': CardStatsResponse$json,
  '.anki.stats.CardStatsResponse.StatsRevlogEntry':
      CardStatsResponse_StatsRevlogEntry$json,
  '.anki.cards.FsrsMemoryState': $0.FsrsMemoryState$json,
  '.anki.stats.ReviewLogs': ReviewLogs$json,
  '.anki.stats.GraphsRequest': GraphsRequest$json,
  '.anki.stats.GraphsResponse': GraphsResponse$json,
  '.anki.stats.GraphsResponse.Buttons': GraphsResponse_Buttons$json,
  '.anki.stats.GraphsResponse.Buttons.ButtonCounts':
      GraphsResponse_Buttons_ButtonCounts$json,
  '.anki.stats.GraphsResponse.CardCounts': GraphsResponse_CardCounts$json,
  '.anki.stats.GraphsResponse.CardCounts.Counts':
      GraphsResponse_CardCounts_Counts$json,
  '.anki.stats.GraphsResponse.Hours': GraphsResponse_Hours$json,
  '.anki.stats.GraphsResponse.Hours.Hour': GraphsResponse_Hours_Hour$json,
  '.anki.stats.GraphsResponse.Today': GraphsResponse_Today$json,
  '.anki.stats.GraphsResponse.Eases': GraphsResponse_Eases$json,
  '.anki.stats.GraphsResponse.Eases.EasesEntry':
      GraphsResponse_Eases_EasesEntry$json,
  '.anki.stats.GraphsResponse.Intervals': GraphsResponse_Intervals$json,
  '.anki.stats.GraphsResponse.Intervals.IntervalsEntry':
      GraphsResponse_Intervals_IntervalsEntry$json,
  '.anki.stats.GraphsResponse.FutureDue': GraphsResponse_FutureDue$json,
  '.anki.stats.GraphsResponse.FutureDue.FutureDueEntry':
      GraphsResponse_FutureDue_FutureDueEntry$json,
  '.anki.stats.GraphsResponse.Added': GraphsResponse_Added$json,
  '.anki.stats.GraphsResponse.Added.AddedEntry':
      GraphsResponse_Added_AddedEntry$json,
  '.anki.stats.GraphsResponse.ReviewCountsAndTimes':
      GraphsResponse_ReviewCountsAndTimes$json,
  '.anki.stats.GraphsResponse.ReviewCountsAndTimes.CountEntry':
      GraphsResponse_ReviewCountsAndTimes_CountEntry$json,
  '.anki.stats.GraphsResponse.ReviewCountsAndTimes.Reviews':
      GraphsResponse_ReviewCountsAndTimes_Reviews$json,
  '.anki.stats.GraphsResponse.ReviewCountsAndTimes.TimeEntry':
      GraphsResponse_ReviewCountsAndTimes_TimeEntry$json,
  '.anki.stats.GraphsResponse.Retrievability':
      GraphsResponse_Retrievability$json,
  '.anki.stats.GraphsResponse.Retrievability.RetrievabilityEntry':
      GraphsResponse_Retrievability_RetrievabilityEntry$json,
  '.anki.stats.GraphsResponse.TrueRetentionStats':
      GraphsResponse_TrueRetentionStats$json,
  '.anki.stats.GraphsResponse.TrueRetentionStats.TrueRetention':
      GraphsResponse_TrueRetentionStats_TrueRetention$json,
  '.anki.generic.Empty': $1.Empty$json,
  '.anki.stats.GraphPreferences': GraphPreferences$json,
};

/// Descriptor for `StatsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List statsServiceDescriptor = $convert.base64Decode(
    'CgxTdGF0c1NlcnZpY2USPgoJQ2FyZFN0YXRzEhIuYW5raS5jYXJkcy5DYXJkSWQaHS5hbmtpLn'
    'N0YXRzLkNhcmRTdGF0c1Jlc3BvbnNlEjsKDUdldFJldmlld0xvZ3MSEi5hbmtpLmNhcmRzLkNh'
    'cmRJZBoWLmFua2kuc3RhdHMuUmV2aWV3TG9ncxI/CgZHcmFwaHMSGS5hbmtpLnN0YXRzLkdyYX'
    'Boc1JlcXVlc3QaGi5hbmtpLnN0YXRzLkdyYXBoc1Jlc3BvbnNlEkgKE0dldEdyYXBoUHJlZmVy'
    'ZW5jZXMSEy5hbmtpLmdlbmVyaWMuRW1wdHkaHC5hbmtpLnN0YXRzLkdyYXBoUHJlZmVyZW5jZX'
    'MSSAoTU2V0R3JhcGhQcmVmZXJlbmNlcxIcLmFua2kuc3RhdHMuR3JhcGhQcmVmZXJlbmNlcxoT'
    'LmFua2kuZ2VuZXJpYy5FbXB0eQ==');

const $core.Map<$core.String, $core.dynamic> BackendStatsServiceBase$json = {
  '1': 'BackendStatsService'
};

@$core.Deprecated('Use backendStatsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendStatsServiceBase$messageJson = {};

/// Descriptor for `BackendStatsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendStatsServiceDescriptor =
    $convert.base64Decode('ChNCYWNrZW5kU3RhdHNTZXJ2aWNl');
