// This is a generated file - do not edit.
//
// Generated from anki/scheduler.proto.

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
import 'collection.pbjson.dart' as $2;
import 'config.pbjson.dart' as $1;
import 'decks.pbjson.dart' as $4;
import 'generic.pbjson.dart' as $3;

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState$json = {
  '1': 'SchedulingState',
  '2': [
    {
      '1': 'normal',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Normal',
      '9': 0,
      '10': 'normal'
    },
    {
      '1': 'filtered',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Filtered',
      '9': 0,
      '10': 'filtered'
    },
    {
      '1': 'custom_data',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'customData',
      '17': true
    },
  ],
  '3': [
    SchedulingState_New$json,
    SchedulingState_Learning$json,
    SchedulingState_Review$json,
    SchedulingState_Relearning$json,
    SchedulingState_Normal$json,
    SchedulingState_Preview$json,
    SchedulingState_ReschedulingFilter$json,
    SchedulingState_Filtered$json
  ],
  '8': [
    {'1': 'kind'},
    {'1': '_custom_data'},
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_New$json = {
  '1': 'New',
  '2': [
    {'1': 'position', '3': 1, '4': 1, '5': 13, '10': 'position'},
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_Learning$json = {
  '1': 'Learning',
  '2': [
    {'1': 'remaining_steps', '3': 1, '4': 1, '5': 13, '10': 'remainingSteps'},
    {'1': 'scheduled_secs', '3': 2, '4': 1, '5': 13, '10': 'scheduledSecs'},
    {'1': 'elapsed_secs', '3': 3, '4': 1, '5': 13, '10': 'elapsedSecs'},
    {
      '1': 'memory_state',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.FsrsMemoryState',
      '9': 0,
      '10': 'memoryState',
      '17': true
    },
  ],
  '8': [
    {'1': '_memory_state'},
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_Review$json = {
  '1': 'Review',
  '2': [
    {'1': 'scheduled_days', '3': 1, '4': 1, '5': 13, '10': 'scheduledDays'},
    {'1': 'elapsed_days', '3': 2, '4': 1, '5': 13, '10': 'elapsedDays'},
    {'1': 'ease_factor', '3': 3, '4': 1, '5': 2, '10': 'easeFactor'},
    {'1': 'lapses', '3': 4, '4': 1, '5': 13, '10': 'lapses'},
    {'1': 'leeched', '3': 5, '4': 1, '5': 8, '10': 'leeched'},
    {
      '1': 'memory_state',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.FsrsMemoryState',
      '9': 0,
      '10': 'memoryState',
      '17': true
    },
  ],
  '8': [
    {'1': '_memory_state'},
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_Relearning$json = {
  '1': 'Relearning',
  '2': [
    {
      '1': 'review',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Review',
      '10': 'review'
    },
    {
      '1': 'learning',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Learning',
      '10': 'learning'
    },
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_Normal$json = {
  '1': 'Normal',
  '2': [
    {
      '1': 'new',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.New',
      '9': 0,
      '10': 'new'
    },
    {
      '1': 'learning',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Learning',
      '9': 0,
      '10': 'learning'
    },
    {
      '1': 'review',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Review',
      '9': 0,
      '10': 'review'
    },
    {
      '1': 'relearning',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Relearning',
      '9': 0,
      '10': 'relearning'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_Preview$json = {
  '1': 'Preview',
  '2': [
    {'1': 'scheduled_secs', '3': 1, '4': 1, '5': 13, '10': 'scheduledSecs'},
    {'1': 'finished', '3': 2, '4': 1, '5': 8, '10': 'finished'},
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_ReschedulingFilter$json = {
  '1': 'ReschedulingFilter',
  '2': [
    {
      '1': 'original_state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Normal',
      '10': 'originalState'
    },
  ],
};

@$core.Deprecated('Use schedulingStateDescriptor instead')
const SchedulingState_Filtered$json = {
  '1': 'Filtered',
  '2': [
    {
      '1': 'preview',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.Preview',
      '9': 0,
      '10': 'preview'
    },
    {
      '1': 'rescheduling',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState.ReschedulingFilter',
      '9': 0,
      '10': 'rescheduling'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `SchedulingState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List schedulingStateDescriptor = $convert.base64Decode(
    'Cg9TY2hlZHVsaW5nU3RhdGUSQAoGbm9ybWFsGAEgASgLMiYuYW5raS5zY2hlZHVsZXIuU2NoZW'
    'R1bGluZ1N0YXRlLk5vcm1hbEgAUgZub3JtYWwSRgoIZmlsdGVyZWQYAiABKAsyKC5hbmtpLnNj'
    'aGVkdWxlci5TY2hlZHVsaW5nU3RhdGUuRmlsdGVyZWRIAFIIZmlsdGVyZWQSJAoLY3VzdG9tX2'
    'RhdGEYAyABKAlIAVIKY3VzdG9tRGF0YYgBARohCgNOZXcSGgoIcG9zaXRpb24YASABKA1SCHBv'
    'c2l0aW9uGtMBCghMZWFybmluZxInCg9yZW1haW5pbmdfc3RlcHMYASABKA1SDnJlbWFpbmluZ1'
    'N0ZXBzEiUKDnNjaGVkdWxlZF9zZWNzGAIgASgNUg1zY2hlZHVsZWRTZWNzEiEKDGVsYXBzZWRf'
    'c2VjcxgDIAEoDVILZWxhcHNlZFNlY3MSQwoMbWVtb3J5X3N0YXRlGAYgASgLMhsuYW5raS5jYX'
    'Jkcy5Gc3JzTWVtb3J5U3RhdGVIAFILbWVtb3J5U3RhdGWIAQFCDwoNX21lbW9yeV9zdGF0ZRr7'
    'AQoGUmV2aWV3EiUKDnNjaGVkdWxlZF9kYXlzGAEgASgNUg1zY2hlZHVsZWREYXlzEiEKDGVsYX'
    'BzZWRfZGF5cxgCIAEoDVILZWxhcHNlZERheXMSHwoLZWFzZV9mYWN0b3IYAyABKAJSCmVhc2VG'
    'YWN0b3ISFgoGbGFwc2VzGAQgASgNUgZsYXBzZXMSGAoHbGVlY2hlZBgFIAEoCFIHbGVlY2hlZB'
    'JDCgxtZW1vcnlfc3RhdGUYBiABKAsyGy5hbmtpLmNhcmRzLkZzcnNNZW1vcnlTdGF0ZUgAUgtt'
    'ZW1vcnlTdGF0ZYgBAUIPCg1fbWVtb3J5X3N0YXRlGpIBCgpSZWxlYXJuaW5nEj4KBnJldmlldx'
    'gBIAEoCzImLmFua2kuc2NoZWR1bGVyLlNjaGVkdWxpbmdTdGF0ZS5SZXZpZXdSBnJldmlldxJE'
    'CghsZWFybmluZxgCIAEoCzIoLmFua2kuc2NoZWR1bGVyLlNjaGVkdWxpbmdTdGF0ZS5MZWFybm'
    'luZ1IIbGVhcm5pbmcaoQIKBk5vcm1hbBI3CgNuZXcYASABKAsyIy5hbmtpLnNjaGVkdWxlci5T'
    'Y2hlZHVsaW5nU3RhdGUuTmV3SABSA25ldxJGCghsZWFybmluZxgCIAEoCzIoLmFua2kuc2NoZW'
    'R1bGVyLlNjaGVkdWxpbmdTdGF0ZS5MZWFybmluZ0gAUghsZWFybmluZxJACgZyZXZpZXcYAyAB'
    'KAsyJi5hbmtpLnNjaGVkdWxlci5TY2hlZHVsaW5nU3RhdGUuUmV2aWV3SABSBnJldmlldxJMCg'
    'pyZWxlYXJuaW5nGAQgASgLMiouYW5raS5zY2hlZHVsZXIuU2NoZWR1bGluZ1N0YXRlLlJlbGVh'
    'cm5pbmdIAFIKcmVsZWFybmluZ0IGCgRraW5kGkwKB1ByZXZpZXcSJQoOc2NoZWR1bGVkX3NlY3'
    'MYASABKA1SDXNjaGVkdWxlZFNlY3MSGgoIZmluaXNoZWQYAiABKAhSCGZpbmlzaGVkGmMKElJl'
    'c2NoZWR1bGluZ0ZpbHRlchJNCg5vcmlnaW5hbF9zdGF0ZRgBIAEoCzImLmFua2kuc2NoZWR1bG'
    'VyLlNjaGVkdWxpbmdTdGF0ZS5Ob3JtYWxSDW9yaWdpbmFsU3RhdGUasQEKCEZpbHRlcmVkEkMK'
    'B3ByZXZpZXcYASABKAsyJy5hbmtpLnNjaGVkdWxlci5TY2hlZHVsaW5nU3RhdGUuUHJldmlld0'
    'gAUgdwcmV2aWV3ElgKDHJlc2NoZWR1bGluZxgCIAEoCzIyLmFua2kuc2NoZWR1bGVyLlNjaGVk'
    'dWxpbmdTdGF0ZS5SZXNjaGVkdWxpbmdGaWx0ZXJIAFIMcmVzY2hlZHVsaW5nQgYKBGtpbmRCBg'
    'oEa2luZEIOCgxfY3VzdG9tX2RhdGE=');

@$core.Deprecated('Use queuedCardsDescriptor instead')
const QueuedCards$json = {
  '1': 'QueuedCards',
  '2': [
    {
      '1': 'cards',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.QueuedCards.QueuedCard',
      '10': 'cards'
    },
    {'1': 'new_count', '3': 2, '4': 1, '5': 13, '10': 'newCount'},
    {'1': 'learning_count', '3': 3, '4': 1, '5': 13, '10': 'learningCount'},
    {'1': 'review_count', '3': 4, '4': 1, '5': 13, '10': 'reviewCount'},
  ],
  '3': [QueuedCards_QueuedCard$json],
  '4': [QueuedCards_Queue$json],
};

@$core.Deprecated('Use queuedCardsDescriptor instead')
const QueuedCards_QueuedCard$json = {
  '1': 'QueuedCard',
  '2': [
    {
      '1': 'card',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.Card',
      '10': 'card'
    },
    {
      '1': 'queue',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.QueuedCards.Queue',
      '10': 'queue'
    },
    {
      '1': 'states',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingStates',
      '10': 'states'
    },
    {
      '1': 'context',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingContext',
      '10': 'context'
    },
  ],
};

@$core.Deprecated('Use queuedCardsDescriptor instead')
const QueuedCards_Queue$json = {
  '1': 'Queue',
  '2': [
    {'1': 'NEW', '2': 0},
    {'1': 'LEARNING', '2': 1},
    {'1': 'REVIEW', '2': 2},
  ],
};

/// Descriptor for `QueuedCards`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queuedCardsDescriptor = $convert.base64Decode(
    'CgtRdWV1ZWRDYXJkcxI8CgVjYXJkcxgBIAMoCzImLmFua2kuc2NoZWR1bGVyLlF1ZXVlZENhcm'
    'RzLlF1ZXVlZENhcmRSBWNhcmRzEhsKCW5ld19jb3VudBgCIAEoDVIIbmV3Q291bnQSJQoObGVh'
    'cm5pbmdfY291bnQYAyABKA1SDWxlYXJuaW5nQ291bnQSIQoMcmV2aWV3X2NvdW50GAQgASgNUg'
    'tyZXZpZXdDb3VudBriAQoKUXVldWVkQ2FyZBIkCgRjYXJkGAEgASgLMhAuYW5raS5jYXJkcy5D'
    'YXJkUgRjYXJkEjcKBXF1ZXVlGAIgASgOMiEuYW5raS5zY2hlZHVsZXIuUXVldWVkQ2FyZHMuUX'
    'VldWVSBXF1ZXVlEjgKBnN0YXRlcxgDIAEoCzIgLmFua2kuc2NoZWR1bGVyLlNjaGVkdWxpbmdT'
    'dGF0ZXNSBnN0YXRlcxI7Cgdjb250ZXh0GAQgASgLMiEuYW5raS5zY2hlZHVsZXIuU2NoZWR1bG'
    'luZ0NvbnRleHRSB2NvbnRleHQiKgoFUXVldWUSBwoDTkVXEAASDAoITEVBUk5JTkcQARIKCgZS'
    'RVZJRVcQAg==');

@$core.Deprecated('Use getQueuedCardsRequestDescriptor instead')
const GetQueuedCardsRequest$json = {
  '1': 'GetQueuedCardsRequest',
  '2': [
    {'1': 'fetch_limit', '3': 1, '4': 1, '5': 13, '10': 'fetchLimit'},
    {
      '1': 'intraday_learning_only',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'intradayLearningOnly'
    },
  ],
};

/// Descriptor for `GetQueuedCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQueuedCardsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRRdWV1ZWRDYXJkc1JlcXVlc3QSHwoLZmV0Y2hfbGltaXQYASABKA1SCmZldGNoTGltaX'
    'QSNAoWaW50cmFkYXlfbGVhcm5pbmdfb25seRgCIAEoCFIUaW50cmFkYXlMZWFybmluZ09ubHk=');

@$core.Deprecated('Use schedTimingTodayResponseDescriptor instead')
const SchedTimingTodayResponse$json = {
  '1': 'SchedTimingTodayResponse',
  '2': [
    {'1': 'days_elapsed', '3': 1, '4': 1, '5': 13, '10': 'daysElapsed'},
    {'1': 'next_day_at', '3': 2, '4': 1, '5': 3, '10': 'nextDayAt'},
  ],
};

/// Descriptor for `SchedTimingTodayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List schedTimingTodayResponseDescriptor =
    $convert.base64Decode(
        'ChhTY2hlZFRpbWluZ1RvZGF5UmVzcG9uc2USIQoMZGF5c19lbGFwc2VkGAEgASgNUgtkYXlzRW'
        'xhcHNlZBIeCgtuZXh0X2RheV9hdBgCIAEoA1IJbmV4dERheUF0');

@$core.Deprecated('Use studiedTodayMessageRequestDescriptor instead')
const StudiedTodayMessageRequest$json = {
  '1': 'StudiedTodayMessageRequest',
  '2': [
    {'1': 'cards', '3': 1, '4': 1, '5': 13, '10': 'cards'},
    {'1': 'seconds', '3': 2, '4': 1, '5': 1, '10': 'seconds'},
  ],
};

/// Descriptor for `StudiedTodayMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studiedTodayMessageRequestDescriptor =
    $convert.base64Decode(
        'ChpTdHVkaWVkVG9kYXlNZXNzYWdlUmVxdWVzdBIUCgVjYXJkcxgBIAEoDVIFY2FyZHMSGAoHc2'
        'Vjb25kcxgCIAEoAVIHc2Vjb25kcw==');

@$core.Deprecated('Use updateStatsRequestDescriptor instead')
const UpdateStatsRequest$json = {
  '1': 'UpdateStatsRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'new_delta', '3': 2, '4': 1, '5': 5, '10': 'newDelta'},
    {'1': 'review_delta', '3': 4, '4': 1, '5': 5, '10': 'reviewDelta'},
    {
      '1': 'millisecond_delta',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'millisecondDelta'
    },
  ],
};

/// Descriptor for `UpdateStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateStatsRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVTdGF0c1JlcXVlc3QSFwoHZGVja19pZBgBIAEoA1IGZGVja0lkEhsKCW5ld19kZW'
    'x0YRgCIAEoBVIIbmV3RGVsdGESIQoMcmV2aWV3X2RlbHRhGAQgASgFUgtyZXZpZXdEZWx0YRIr'
    'ChFtaWxsaXNlY29uZF9kZWx0YRgFIAEoBVIQbWlsbGlzZWNvbmREZWx0YQ==');

@$core.Deprecated('Use extendLimitsRequestDescriptor instead')
const ExtendLimitsRequest$json = {
  '1': 'ExtendLimitsRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'new_delta', '3': 2, '4': 1, '5': 5, '10': 'newDelta'},
    {'1': 'review_delta', '3': 3, '4': 1, '5': 5, '10': 'reviewDelta'},
  ],
};

/// Descriptor for `ExtendLimitsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extendLimitsRequestDescriptor = $convert.base64Decode(
    'ChNFeHRlbmRMaW1pdHNSZXF1ZXN0EhcKB2RlY2tfaWQYASABKANSBmRlY2tJZBIbCgluZXdfZG'
    'VsdGEYAiABKAVSCG5ld0RlbHRhEiEKDHJldmlld19kZWx0YRgDIAEoBVILcmV2aWV3RGVsdGE=');

@$core.Deprecated('Use countsForDeckTodayResponseDescriptor instead')
const CountsForDeckTodayResponse$json = {
  '1': 'CountsForDeckTodayResponse',
  '2': [
    {'1': 'new', '3': 1, '4': 1, '5': 5, '10': 'new'},
    {'1': 'review', '3': 2, '4': 1, '5': 5, '10': 'review'},
  ],
};

/// Descriptor for `CountsForDeckTodayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countsForDeckTodayResponseDescriptor =
    $convert.base64Decode(
        'ChpDb3VudHNGb3JEZWNrVG9kYXlSZXNwb25zZRIQCgNuZXcYASABKAVSA25ldxIWCgZyZXZpZX'
        'cYAiABKAVSBnJldmlldw==');

@$core.Deprecated('Use congratsInfoResponseDescriptor instead')
const CongratsInfoResponse$json = {
  '1': 'CongratsInfoResponse',
  '2': [
    {'1': 'learn_remaining', '3': 1, '4': 1, '5': 13, '10': 'learnRemaining'},
    {
      '1': 'secs_until_next_learn',
      '3': 2,
      '4': 1,
      '5': 13,
      '10': 'secsUntilNextLearn'
    },
    {'1': 'review_remaining', '3': 3, '4': 1, '5': 8, '10': 'reviewRemaining'},
    {'1': 'new_remaining', '3': 4, '4': 1, '5': 8, '10': 'newRemaining'},
    {'1': 'have_sched_buried', '3': 5, '4': 1, '5': 8, '10': 'haveSchedBuried'},
    {'1': 'have_user_buried', '3': 6, '4': 1, '5': 8, '10': 'haveUserBuried'},
    {'1': 'is_filtered_deck', '3': 7, '4': 1, '5': 8, '10': 'isFilteredDeck'},
    {
      '1': 'bridge_commands_supported',
      '3': 8,
      '4': 1,
      '5': 8,
      '10': 'bridgeCommandsSupported'
    },
    {'1': 'deck_description', '3': 9, '4': 1, '5': 9, '10': 'deckDescription'},
  ],
};

/// Descriptor for `CongratsInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List congratsInfoResponseDescriptor = $convert.base64Decode(
    'ChRDb25ncmF0c0luZm9SZXNwb25zZRInCg9sZWFybl9yZW1haW5pbmcYASABKA1SDmxlYXJuUm'
    'VtYWluaW5nEjEKFXNlY3NfdW50aWxfbmV4dF9sZWFybhgCIAEoDVISc2Vjc1VudGlsTmV4dExl'
    'YXJuEikKEHJldmlld19yZW1haW5pbmcYAyABKAhSD3Jldmlld1JlbWFpbmluZxIjCg1uZXdfcm'
    'VtYWluaW5nGAQgASgIUgxuZXdSZW1haW5pbmcSKgoRaGF2ZV9zY2hlZF9idXJpZWQYBSABKAhS'
    'D2hhdmVTY2hlZEJ1cmllZBIoChBoYXZlX3VzZXJfYnVyaWVkGAYgASgIUg5oYXZlVXNlckJ1cm'
    'llZBIoChBpc19maWx0ZXJlZF9kZWNrGAcgASgIUg5pc0ZpbHRlcmVkRGVjaxI6ChlicmlkZ2Vf'
    'Y29tbWFuZHNfc3VwcG9ydGVkGAggASgIUhdicmlkZ2VDb21tYW5kc1N1cHBvcnRlZBIpChBkZW'
    'NrX2Rlc2NyaXB0aW9uGAkgASgJUg9kZWNrRGVzY3JpcHRpb24=');

@$core.Deprecated('Use unburyDeckRequestDescriptor instead')
const UnburyDeckRequest$json = {
  '1': 'UnburyDeckRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {
      '1': 'mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.UnburyDeckRequest.Mode',
      '10': 'mode'
    },
  ],
  '4': [UnburyDeckRequest_Mode$json],
};

@$core.Deprecated('Use unburyDeckRequestDescriptor instead')
const UnburyDeckRequest_Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'ALL', '2': 0},
    {'1': 'SCHED_ONLY', '2': 1},
    {'1': 'USER_ONLY', '2': 2},
  ],
};

/// Descriptor for `UnburyDeckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unburyDeckRequestDescriptor = $convert.base64Decode(
    'ChFVbmJ1cnlEZWNrUmVxdWVzdBIXCgdkZWNrX2lkGAEgASgDUgZkZWNrSWQSOgoEbW9kZRgCIA'
    'EoDjImLmFua2kuc2NoZWR1bGVyLlVuYnVyeURlY2tSZXF1ZXN0Lk1vZGVSBG1vZGUiLgoETW9k'
    'ZRIHCgNBTEwQABIOCgpTQ0hFRF9PTkxZEAESDQoJVVNFUl9PTkxZEAI=');

@$core.Deprecated('Use buryOrSuspendCardsRequestDescriptor instead')
const BuryOrSuspendCardsRequest$json = {
  '1': 'BuryOrSuspendCardsRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
    {'1': 'note_ids', '3': 2, '4': 3, '5': 3, '10': 'noteIds'},
    {
      '1': 'mode',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.BuryOrSuspendCardsRequest.Mode',
      '10': 'mode'
    },
  ],
  '4': [BuryOrSuspendCardsRequest_Mode$json],
};

@$core.Deprecated('Use buryOrSuspendCardsRequestDescriptor instead')
const BuryOrSuspendCardsRequest_Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'SUSPEND', '2': 0},
    {'1': 'BURY_SCHED', '2': 1},
    {'1': 'BURY_USER', '2': 2},
  ],
};

/// Descriptor for `BuryOrSuspendCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buryOrSuspendCardsRequestDescriptor = $convert.base64Decode(
    'ChlCdXJ5T3JTdXNwZW5kQ2FyZHNSZXF1ZXN0EhkKCGNhcmRfaWRzGAEgAygDUgdjYXJkSWRzEh'
    'kKCG5vdGVfaWRzGAIgAygDUgdub3RlSWRzEkIKBG1vZGUYAyABKA4yLi5hbmtpLnNjaGVkdWxl'
    'ci5CdXJ5T3JTdXNwZW5kQ2FyZHNSZXF1ZXN0Lk1vZGVSBG1vZGUiMgoETW9kZRILCgdTVVNQRU'
    '5EEAASDgoKQlVSWV9TQ0hFRBABEg0KCUJVUllfVVNFUhAC');

@$core.Deprecated('Use scheduleCardsAsNewRequestDescriptor instead')
const ScheduleCardsAsNewRequest$json = {
  '1': 'ScheduleCardsAsNewRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
    {'1': 'log', '3': 2, '4': 1, '5': 8, '10': 'log'},
    {'1': 'restore_position', '3': 3, '4': 1, '5': 8, '10': 'restorePosition'},
    {'1': 'reset_counts', '3': 4, '4': 1, '5': 8, '10': 'resetCounts'},
    {
      '1': 'context',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.ScheduleCardsAsNewRequest.Context',
      '9': 0,
      '10': 'context',
      '17': true
    },
  ],
  '4': [ScheduleCardsAsNewRequest_Context$json],
  '8': [
    {'1': '_context'},
  ],
};

@$core.Deprecated('Use scheduleCardsAsNewRequestDescriptor instead')
const ScheduleCardsAsNewRequest_Context$json = {
  '1': 'Context',
  '2': [
    {'1': 'BROWSER', '2': 0},
    {'1': 'REVIEWER', '2': 1},
  ],
};

/// Descriptor for `ScheduleCardsAsNewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleCardsAsNewRequestDescriptor = $convert.base64Decode(
    'ChlTY2hlZHVsZUNhcmRzQXNOZXdSZXF1ZXN0EhkKCGNhcmRfaWRzGAEgAygDUgdjYXJkSWRzEh'
    'AKA2xvZxgCIAEoCFIDbG9nEikKEHJlc3RvcmVfcG9zaXRpb24YAyABKAhSD3Jlc3RvcmVQb3Np'
    'dGlvbhIhCgxyZXNldF9jb3VudHMYBCABKAhSC3Jlc2V0Q291bnRzElAKB2NvbnRleHQYBSABKA'
    '4yMS5hbmtpLnNjaGVkdWxlci5TY2hlZHVsZUNhcmRzQXNOZXdSZXF1ZXN0LkNvbnRleHRIAFIH'
    'Y29udGV4dIgBASIkCgdDb250ZXh0EgsKB0JST1dTRVIQABIMCghSRVZJRVdFUhABQgoKCF9jb2'
    '50ZXh0');

@$core.Deprecated('Use scheduleCardsAsNewDefaultsRequestDescriptor instead')
const ScheduleCardsAsNewDefaultsRequest$json = {
  '1': 'ScheduleCardsAsNewDefaultsRequest',
  '2': [
    {
      '1': 'context',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.ScheduleCardsAsNewRequest.Context',
      '10': 'context'
    },
  ],
};

/// Descriptor for `ScheduleCardsAsNewDefaultsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleCardsAsNewDefaultsRequestDescriptor =
    $convert.base64Decode(
        'CiFTY2hlZHVsZUNhcmRzQXNOZXdEZWZhdWx0c1JlcXVlc3QSSwoHY29udGV4dBgBIAEoDjIxLm'
        'Fua2kuc2NoZWR1bGVyLlNjaGVkdWxlQ2FyZHNBc05ld1JlcXVlc3QuQ29udGV4dFIHY29udGV4'
        'dA==');

@$core.Deprecated('Use scheduleCardsAsNewDefaultsResponseDescriptor instead')
const ScheduleCardsAsNewDefaultsResponse$json = {
  '1': 'ScheduleCardsAsNewDefaultsResponse',
  '2': [
    {'1': 'restore_position', '3': 1, '4': 1, '5': 8, '10': 'restorePosition'},
    {'1': 'reset_counts', '3': 2, '4': 1, '5': 8, '10': 'resetCounts'},
  ],
};

/// Descriptor for `ScheduleCardsAsNewDefaultsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleCardsAsNewDefaultsResponseDescriptor =
    $convert.base64Decode(
        'CiJTY2hlZHVsZUNhcmRzQXNOZXdEZWZhdWx0c1Jlc3BvbnNlEikKEHJlc3RvcmVfcG9zaXRpb2'
        '4YASABKAhSD3Jlc3RvcmVQb3NpdGlvbhIhCgxyZXNldF9jb3VudHMYAiABKAhSC3Jlc2V0Q291'
        'bnRz');

@$core.Deprecated('Use setDueDateRequestDescriptor instead')
const SetDueDateRequest$json = {
  '1': 'SetDueDateRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
    {'1': 'days', '3': 2, '4': 1, '5': 9, '10': 'days'},
    {
      '1': 'config_key',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.config.OptionalStringConfigKey',
      '10': 'configKey'
    },
  ],
};

/// Descriptor for `SetDueDateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDueDateRequestDescriptor = $convert.base64Decode(
    'ChFTZXREdWVEYXRlUmVxdWVzdBIZCghjYXJkX2lkcxgBIAMoA1IHY2FyZElkcxISCgRkYXlzGA'
    'IgASgJUgRkYXlzEkMKCmNvbmZpZ19rZXkYAyABKAsyJC5hbmtpLmNvbmZpZy5PcHRpb25hbFN0'
    'cmluZ0NvbmZpZ0tleVIJY29uZmlnS2V5');

@$core.Deprecated('Use gradeNowRequestDescriptor instead')
const GradeNowRequest$json = {
  '1': 'GradeNowRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
    {
      '1': 'rating',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.CardAnswer.Rating',
      '10': 'rating'
    },
  ],
};

/// Descriptor for `GradeNowRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gradeNowRequestDescriptor = $convert.base64Decode(
    'Cg9HcmFkZU5vd1JlcXVlc3QSGQoIY2FyZF9pZHMYASADKANSB2NhcmRJZHMSOQoGcmF0aW5nGA'
    'IgASgOMiEuYW5raS5zY2hlZHVsZXIuQ2FyZEFuc3dlci5SYXRpbmdSBnJhdGluZw==');

@$core.Deprecated('Use sortCardsRequestDescriptor instead')
const SortCardsRequest$json = {
  '1': 'SortCardsRequest',
  '2': [
    {'1': 'card_ids', '3': 1, '4': 3, '5': 3, '10': 'cardIds'},
    {'1': 'starting_from', '3': 2, '4': 1, '5': 13, '10': 'startingFrom'},
    {'1': 'step_size', '3': 3, '4': 1, '5': 13, '10': 'stepSize'},
    {'1': 'randomize', '3': 4, '4': 1, '5': 8, '10': 'randomize'},
    {'1': 'shift_existing', '3': 5, '4': 1, '5': 8, '10': 'shiftExisting'},
  ],
};

/// Descriptor for `SortCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sortCardsRequestDescriptor = $convert.base64Decode(
    'ChBTb3J0Q2FyZHNSZXF1ZXN0EhkKCGNhcmRfaWRzGAEgAygDUgdjYXJkSWRzEiMKDXN0YXJ0aW'
    '5nX2Zyb20YAiABKA1SDHN0YXJ0aW5nRnJvbRIbCglzdGVwX3NpemUYAyABKA1SCHN0ZXBTaXpl'
    'EhwKCXJhbmRvbWl6ZRgEIAEoCFIJcmFuZG9taXplEiUKDnNoaWZ0X2V4aXN0aW5nGAUgASgIUg'
    '1zaGlmdEV4aXN0aW5n');

@$core.Deprecated('Use sortDeckRequestDescriptor instead')
const SortDeckRequest$json = {
  '1': 'SortDeckRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {'1': 'randomize', '3': 2, '4': 1, '5': 8, '10': 'randomize'},
  ],
};

/// Descriptor for `SortDeckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sortDeckRequestDescriptor = $convert.base64Decode(
    'Cg9Tb3J0RGVja1JlcXVlc3QSFwoHZGVja19pZBgBIAEoA1IGZGVja0lkEhwKCXJhbmRvbWl6ZR'
    'gCIAEoCFIJcmFuZG9taXpl');

@$core.Deprecated('Use schedulingStatesDescriptor instead')
const SchedulingStates$json = {
  '1': 'SchedulingStates',
  '2': [
    {
      '1': 'current',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState',
      '10': 'current'
    },
    {
      '1': 'again',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState',
      '10': 'again'
    },
    {
      '1': 'hard',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState',
      '10': 'hard'
    },
    {
      '1': 'good',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState',
      '10': 'good'
    },
    {
      '1': 'easy',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState',
      '10': 'easy'
    },
  ],
};

/// Descriptor for `SchedulingStates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List schedulingStatesDescriptor = $convert.base64Decode(
    'ChBTY2hlZHVsaW5nU3RhdGVzEjkKB2N1cnJlbnQYASABKAsyHy5hbmtpLnNjaGVkdWxlci5TY2'
    'hlZHVsaW5nU3RhdGVSB2N1cnJlbnQSNQoFYWdhaW4YAiABKAsyHy5hbmtpLnNjaGVkdWxlci5T'
    'Y2hlZHVsaW5nU3RhdGVSBWFnYWluEjMKBGhhcmQYAyABKAsyHy5hbmtpLnNjaGVkdWxlci5TY2'
    'hlZHVsaW5nU3RhdGVSBGhhcmQSMwoEZ29vZBgEIAEoCzIfLmFua2kuc2NoZWR1bGVyLlNjaGVk'
    'dWxpbmdTdGF0ZVIEZ29vZBIzCgRlYXN5GAUgASgLMh8uYW5raS5zY2hlZHVsZXIuU2NoZWR1bG'
    'luZ1N0YXRlUgRlYXN5');

@$core.Deprecated('Use cardAnswerDescriptor instead')
const CardAnswer$json = {
  '1': 'CardAnswer',
  '2': [
    {'1': 'card_id', '3': 1, '4': 1, '5': 3, '10': 'cardId'},
    {
      '1': 'current_state',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState',
      '10': 'currentState'
    },
    {
      '1': 'new_state',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingState',
      '10': 'newState'
    },
    {
      '1': 'rating',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.CardAnswer.Rating',
      '10': 'rating'
    },
    {
      '1': 'answered_at_millis',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'answeredAtMillis'
    },
    {
      '1': 'milliseconds_taken',
      '3': 6,
      '4': 1,
      '5': 13,
      '10': 'millisecondsTaken'
    },
  ],
  '4': [CardAnswer_Rating$json],
};

@$core.Deprecated('Use cardAnswerDescriptor instead')
const CardAnswer_Rating$json = {
  '1': 'Rating',
  '2': [
    {'1': 'AGAIN', '2': 0},
    {'1': 'HARD', '2': 1},
    {'1': 'GOOD', '2': 2},
    {'1': 'EASY', '2': 3},
  ],
};

/// Descriptor for `CardAnswer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardAnswerDescriptor = $convert.base64Decode(
    'CgpDYXJkQW5zd2VyEhcKB2NhcmRfaWQYASABKANSBmNhcmRJZBJECg1jdXJyZW50X3N0YXRlGA'
    'IgASgLMh8uYW5raS5zY2hlZHVsZXIuU2NoZWR1bGluZ1N0YXRlUgxjdXJyZW50U3RhdGUSPAoJ'
    'bmV3X3N0YXRlGAMgASgLMh8uYW5raS5zY2hlZHVsZXIuU2NoZWR1bGluZ1N0YXRlUghuZXdTdG'
    'F0ZRI5CgZyYXRpbmcYBCABKA4yIS5hbmtpLnNjaGVkdWxlci5DYXJkQW5zd2VyLlJhdGluZ1IG'
    'cmF0aW5nEiwKEmFuc3dlcmVkX2F0X21pbGxpcxgFIAEoA1IQYW5zd2VyZWRBdE1pbGxpcxItCh'
    'JtaWxsaXNlY29uZHNfdGFrZW4YBiABKA1SEW1pbGxpc2Vjb25kc1Rha2VuIjEKBlJhdGluZxIJ'
    'CgVBR0FJThAAEggKBEhBUkQQARIICgRHT09EEAISCAoERUFTWRAD');

@$core.Deprecated('Use customStudyRequestDescriptor instead')
const CustomStudyRequest$json = {
  '1': 'CustomStudyRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
    {
      '1': 'new_limit_delta',
      '3': 2,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'newLimitDelta'
    },
    {
      '1': 'review_limit_delta',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'reviewLimitDelta'
    },
    {'1': 'forgot_days', '3': 4, '4': 1, '5': 13, '9': 0, '10': 'forgotDays'},
    {
      '1': 'review_ahead_days',
      '3': 5,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'reviewAheadDays'
    },
    {'1': 'preview_days', '3': 6, '4': 1, '5': 13, '9': 0, '10': 'previewDays'},
    {
      '1': 'cram',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.CustomStudyRequest.Cram',
      '9': 0,
      '10': 'cram'
    },
  ],
  '3': [CustomStudyRequest_Cram$json],
  '8': [
    {'1': 'value'},
  ],
};

@$core.Deprecated('Use customStudyRequestDescriptor instead')
const CustomStudyRequest_Cram$json = {
  '1': 'Cram',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.scheduler.CustomStudyRequest.Cram.CramKind',
      '10': 'kind'
    },
    {'1': 'card_limit', '3': 2, '4': 1, '5': 13, '10': 'cardLimit'},
    {'1': 'tags_to_include', '3': 3, '4': 3, '5': 9, '10': 'tagsToInclude'},
    {'1': 'tags_to_exclude', '3': 4, '4': 3, '5': 9, '10': 'tagsToExclude'},
  ],
  '4': [CustomStudyRequest_Cram_CramKind$json],
};

@$core.Deprecated('Use customStudyRequestDescriptor instead')
const CustomStudyRequest_Cram_CramKind$json = {
  '1': 'CramKind',
  '2': [
    {'1': 'CRAM_KIND_DUE', '2': 0},
    {'1': 'CRAM_KIND_NEW', '2': 1},
    {'1': 'CRAM_KIND_REVIEW', '2': 2},
    {'1': 'CRAM_KIND_ALL', '2': 3},
  ],
};

/// Descriptor for `CustomStudyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customStudyRequestDescriptor = $convert.base64Decode(
    'ChJDdXN0b21TdHVkeVJlcXVlc3QSFwoHZGVja19pZBgBIAEoA1IGZGVja0lkEigKD25ld19saW'
    '1pdF9kZWx0YRgCIAEoBUgAUg1uZXdMaW1pdERlbHRhEi4KEnJldmlld19saW1pdF9kZWx0YRgD'
    'IAEoBUgAUhByZXZpZXdMaW1pdERlbHRhEiEKC2ZvcmdvdF9kYXlzGAQgASgNSABSCmZvcmdvdE'
    'RheXMSLAoRcmV2aWV3X2FoZWFkX2RheXMYBSABKA1IAFIPcmV2aWV3QWhlYWREYXlzEiMKDHBy'
    'ZXZpZXdfZGF5cxgGIAEoDUgAUgtwcmV2aWV3RGF5cxI9CgRjcmFtGAcgASgLMicuYW5raS5zY2'
    'hlZHVsZXIuQ3VzdG9tU3R1ZHlSZXF1ZXN0LkNyYW1IAFIEY3JhbRqWAgoEQ3JhbRJECgRraW5k'
    'GAEgASgOMjAuYW5raS5zY2hlZHVsZXIuQ3VzdG9tU3R1ZHlSZXF1ZXN0LkNyYW0uQ3JhbUtpbm'
    'RSBGtpbmQSHQoKY2FyZF9saW1pdBgCIAEoDVIJY2FyZExpbWl0EiYKD3RhZ3NfdG9faW5jbHVk'
    'ZRgDIAMoCVINdGFnc1RvSW5jbHVkZRImCg90YWdzX3RvX2V4Y2x1ZGUYBCADKAlSDXRhZ3NUb0'
    'V4Y2x1ZGUiWQoIQ3JhbUtpbmQSEQoNQ1JBTV9LSU5EX0RVRRAAEhEKDUNSQU1fS0lORF9ORVcQ'
    'ARIUChBDUkFNX0tJTkRfUkVWSUVXEAISEQoNQ1JBTV9LSU5EX0FMTBADQgcKBXZhbHVl');

@$core.Deprecated('Use schedulingContextDescriptor instead')
const SchedulingContext$json = {
  '1': 'SchedulingContext',
  '2': [
    {'1': 'deck_name', '3': 1, '4': 1, '5': 9, '10': 'deckName'},
    {'1': 'seed', '3': 2, '4': 1, '5': 4, '10': 'seed'},
    {'1': 'decay', '3': 3, '4': 1, '5': 2, '9': 0, '10': 'decay', '17': true},
    {
      '1': 'desired_retention',
      '3': 4,
      '4': 1,
      '5': 2,
      '9': 1,
      '10': 'desiredRetention',
      '17': true
    },
  ],
  '8': [
    {'1': '_decay'},
    {'1': '_desired_retention'},
  ],
};

/// Descriptor for `SchedulingContext`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List schedulingContextDescriptor = $convert.base64Decode(
    'ChFTY2hlZHVsaW5nQ29udGV4dBIbCglkZWNrX25hbWUYASABKAlSCGRlY2tOYW1lEhIKBHNlZW'
    'QYAiABKARSBHNlZWQSGQoFZGVjYXkYAyABKAJIAFIFZGVjYXmIAQESMAoRZGVzaXJlZF9yZXRl'
    'bnRpb24YBCABKAJIAVIQZGVzaXJlZFJldGVudGlvbogBAUIICgZfZGVjYXlCFAoSX2Rlc2lyZW'
    'RfcmV0ZW50aW9u');

@$core.Deprecated('Use customStudyDefaultsRequestDescriptor instead')
const CustomStudyDefaultsRequest$json = {
  '1': 'CustomStudyDefaultsRequest',
  '2': [
    {'1': 'deck_id', '3': 1, '4': 1, '5': 3, '10': 'deckId'},
  ],
};

/// Descriptor for `CustomStudyDefaultsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customStudyDefaultsRequestDescriptor =
    $convert.base64Decode(
        'ChpDdXN0b21TdHVkeURlZmF1bHRzUmVxdWVzdBIXCgdkZWNrX2lkGAEgASgDUgZkZWNrSWQ=');

@$core.Deprecated('Use customStudyDefaultsResponseDescriptor instead')
const CustomStudyDefaultsResponse$json = {
  '1': 'CustomStudyDefaultsResponse',
  '2': [
    {
      '1': 'tags',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.CustomStudyDefaultsResponse.Tag',
      '10': 'tags'
    },
    {'1': 'extend_new', '3': 2, '4': 1, '5': 13, '10': 'extendNew'},
    {'1': 'extend_review', '3': 3, '4': 1, '5': 13, '10': 'extendReview'},
    {'1': 'available_new', '3': 4, '4': 1, '5': 13, '10': 'availableNew'},
    {'1': 'available_review', '3': 5, '4': 1, '5': 13, '10': 'availableReview'},
    {
      '1': 'available_new_in_children',
      '3': 6,
      '4': 1,
      '5': 13,
      '10': 'availableNewInChildren'
    },
    {
      '1': 'available_review_in_children',
      '3': 7,
      '4': 1,
      '5': 13,
      '10': 'availableReviewInChildren'
    },
  ],
  '3': [CustomStudyDefaultsResponse_Tag$json],
};

@$core.Deprecated('Use customStudyDefaultsResponseDescriptor instead')
const CustomStudyDefaultsResponse_Tag$json = {
  '1': 'Tag',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'include', '3': 2, '4': 1, '5': 8, '10': 'include'},
    {'1': 'exclude', '3': 3, '4': 1, '5': 8, '10': 'exclude'},
  ],
};

/// Descriptor for `CustomStudyDefaultsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customStudyDefaultsResponseDescriptor = $convert.base64Decode(
    'ChtDdXN0b21TdHVkeURlZmF1bHRzUmVzcG9uc2USQwoEdGFncxgBIAMoCzIvLmFua2kuc2NoZW'
    'R1bGVyLkN1c3RvbVN0dWR5RGVmYXVsdHNSZXNwb25zZS5UYWdSBHRhZ3MSHQoKZXh0ZW5kX25l'
    'dxgCIAEoDVIJZXh0ZW5kTmV3EiMKDWV4dGVuZF9yZXZpZXcYAyABKA1SDGV4dGVuZFJldmlldx'
    'IjCg1hdmFpbGFibGVfbmV3GAQgASgNUgxhdmFpbGFibGVOZXcSKQoQYXZhaWxhYmxlX3Jldmll'
    'dxgFIAEoDVIPYXZhaWxhYmxlUmV2aWV3EjkKGWF2YWlsYWJsZV9uZXdfaW5fY2hpbGRyZW4YBi'
    'ABKA1SFmF2YWlsYWJsZU5ld0luQ2hpbGRyZW4SPwocYXZhaWxhYmxlX3Jldmlld19pbl9jaGls'
    'ZHJlbhgHIAEoDVIZYXZhaWxhYmxlUmV2aWV3SW5DaGlsZHJlbhpNCgNUYWcSEgoEbmFtZRgBIA'
    'EoCVIEbmFtZRIYCgdpbmNsdWRlGAIgASgIUgdpbmNsdWRlEhgKB2V4Y2x1ZGUYAyABKAhSB2V4'
    'Y2x1ZGU=');

@$core.Deprecated('Use repositionDefaultsResponseDescriptor instead')
const RepositionDefaultsResponse$json = {
  '1': 'RepositionDefaultsResponse',
  '2': [
    {'1': 'random', '3': 1, '4': 1, '5': 8, '10': 'random'},
    {'1': 'shift', '3': 2, '4': 1, '5': 8, '10': 'shift'},
  ],
};

/// Descriptor for `RepositionDefaultsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repositionDefaultsResponseDescriptor =
    $convert.base64Decode(
        'ChpSZXBvc2l0aW9uRGVmYXVsdHNSZXNwb25zZRIWCgZyYW5kb20YASABKAhSBnJhbmRvbRIUCg'
        'VzaGlmdBgCIAEoCFIFc2hpZnQ=');

@$core.Deprecated('Use computeFsrsParamsRequestDescriptor instead')
const ComputeFsrsParamsRequest$json = {
  '1': 'ComputeFsrsParamsRequest',
  '2': [
    {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
    {'1': 'current_params', '3': 2, '4': 3, '5': 2, '10': 'currentParams'},
    {
      '1': 'ignore_revlogs_before_ms',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'ignoreRevlogsBeforeMs'
    },
    {
      '1': 'num_of_relearning_steps',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'numOfRelearningSteps'
    },
    {'1': 'health_check', '3': 5, '4': 1, '5': 8, '10': 'healthCheck'},
  ],
};

/// Descriptor for `ComputeFsrsParamsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List computeFsrsParamsRequestDescriptor = $convert.base64Decode(
    'ChhDb21wdXRlRnNyc1BhcmFtc1JlcXVlc3QSFgoGc2VhcmNoGAEgASgJUgZzZWFyY2gSJQoOY3'
    'VycmVudF9wYXJhbXMYAiADKAJSDWN1cnJlbnRQYXJhbXMSNwoYaWdub3JlX3JldmxvZ3NfYmVm'
    'b3JlX21zGAMgASgDUhVpZ25vcmVSZXZsb2dzQmVmb3JlTXMSNQoXbnVtX29mX3JlbGVhcm5pbm'
    'dfc3RlcHMYBCABKA1SFG51bU9mUmVsZWFybmluZ1N0ZXBzEiEKDGhlYWx0aF9jaGVjaxgFIAEo'
    'CFILaGVhbHRoQ2hlY2s=');

@$core.Deprecated('Use computeFsrsParamsResponseDescriptor instead')
const ComputeFsrsParamsResponse$json = {
  '1': 'ComputeFsrsParamsResponse',
  '2': [
    {'1': 'params', '3': 1, '4': 3, '5': 2, '10': 'params'},
    {'1': 'fsrs_items', '3': 2, '4': 1, '5': 13, '10': 'fsrsItems'},
    {
      '1': 'health_check_passed',
      '3': 3,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'healthCheckPassed',
      '17': true
    },
  ],
  '8': [
    {'1': '_health_check_passed'},
  ],
};

/// Descriptor for `ComputeFsrsParamsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List computeFsrsParamsResponseDescriptor = $convert.base64Decode(
    'ChlDb21wdXRlRnNyc1BhcmFtc1Jlc3BvbnNlEhYKBnBhcmFtcxgBIAMoAlIGcGFyYW1zEh0KCm'
    'ZzcnNfaXRlbXMYAiABKA1SCWZzcnNJdGVtcxIzChNoZWFsdGhfY2hlY2tfcGFzc2VkGAMgASgI'
    'SABSEWhlYWx0aENoZWNrUGFzc2VkiAEBQhYKFF9oZWFsdGhfY2hlY2tfcGFzc2Vk');

@$core.Deprecated('Use computeFsrsParamsFromItemsRequestDescriptor instead')
const ComputeFsrsParamsFromItemsRequest$json = {
  '1': 'ComputeFsrsParamsFromItemsRequest',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.FsrsItem',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ComputeFsrsParamsFromItemsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List computeFsrsParamsFromItemsRequestDescriptor =
    $convert.base64Decode(
        'CiFDb21wdXRlRnNyc1BhcmFtc0Zyb21JdGVtc1JlcXVlc3QSLgoFaXRlbXMYASADKAsyGC5hbm'
        'tpLnNjaGVkdWxlci5Gc3JzSXRlbVIFaXRlbXM=');

@$core.Deprecated('Use fsrsBenchmarkRequestDescriptor instead')
const FsrsBenchmarkRequest$json = {
  '1': 'FsrsBenchmarkRequest',
  '2': [
    {
      '1': 'train_set',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.FsrsItem',
      '10': 'trainSet'
    },
  ],
};

/// Descriptor for `FsrsBenchmarkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fsrsBenchmarkRequestDescriptor = $convert.base64Decode(
    'ChRGc3JzQmVuY2htYXJrUmVxdWVzdBI1Cgl0cmFpbl9zZXQYASADKAsyGC5hbmtpLnNjaGVkdW'
    'xlci5Gc3JzSXRlbVIIdHJhaW5TZXQ=');

@$core.Deprecated('Use fsrsBenchmarkResponseDescriptor instead')
const FsrsBenchmarkResponse$json = {
  '1': 'FsrsBenchmarkResponse',
  '2': [
    {'1': 'params', '3': 1, '4': 3, '5': 2, '10': 'params'},
  ],
};

/// Descriptor for `FsrsBenchmarkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fsrsBenchmarkResponseDescriptor =
    $convert.base64Decode(
        'ChVGc3JzQmVuY2htYXJrUmVzcG9uc2USFgoGcGFyYW1zGAEgAygCUgZwYXJhbXM=');

@$core.Deprecated('Use exportDatasetRequestDescriptor instead')
const ExportDatasetRequest$json = {
  '1': 'ExportDatasetRequest',
  '2': [
    {'1': 'min_entries', '3': 1, '4': 1, '5': 13, '10': 'minEntries'},
    {'1': 'target_path', '3': 2, '4': 1, '5': 9, '10': 'targetPath'},
  ],
};

/// Descriptor for `ExportDatasetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportDatasetRequestDescriptor = $convert.base64Decode(
    'ChRFeHBvcnREYXRhc2V0UmVxdWVzdBIfCgttaW5fZW50cmllcxgBIAEoDVIKbWluRW50cmllcx'
    'IfCgt0YXJnZXRfcGF0aBgCIAEoCVIKdGFyZ2V0UGF0aA==');

@$core.Deprecated('Use fsrsItemDescriptor instead')
const FsrsItem$json = {
  '1': 'FsrsItem',
  '2': [
    {
      '1': 'reviews',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.FsrsReview',
      '10': 'reviews'
    },
  ],
};

/// Descriptor for `FsrsItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fsrsItemDescriptor = $convert.base64Decode(
    'CghGc3JzSXRlbRI0CgdyZXZpZXdzGAEgAygLMhouYW5raS5zY2hlZHVsZXIuRnNyc1Jldmlld1'
    'IHcmV2aWV3cw==');

@$core.Deprecated('Use fsrsReviewDescriptor instead')
const FsrsReview$json = {
  '1': 'FsrsReview',
  '2': [
    {'1': 'rating', '3': 1, '4': 1, '5': 13, '10': 'rating'},
    {'1': 'delta_t', '3': 2, '4': 1, '5': 13, '10': 'deltaT'},
  ],
};

/// Descriptor for `FsrsReview`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fsrsReviewDescriptor = $convert.base64Decode(
    'CgpGc3JzUmV2aWV3EhYKBnJhdGluZxgBIAEoDVIGcmF0aW5nEhcKB2RlbHRhX3QYAiABKA1SBm'
    'RlbHRhVA==');

@$core.Deprecated('Use simulateFsrsReviewRequestDescriptor instead')
const SimulateFsrsReviewRequest$json = {
  '1': 'SimulateFsrsReviewRequest',
  '2': [
    {'1': 'params', '3': 1, '4': 3, '5': 2, '10': 'params'},
    {
      '1': 'desired_retention',
      '3': 2,
      '4': 1,
      '5': 2,
      '10': 'desiredRetention'
    },
    {'1': 'deck_size', '3': 3, '4': 1, '5': 13, '10': 'deckSize'},
    {'1': 'days_to_simulate', '3': 4, '4': 1, '5': 13, '10': 'daysToSimulate'},
    {'1': 'new_limit', '3': 5, '4': 1, '5': 13, '10': 'newLimit'},
    {'1': 'review_limit', '3': 6, '4': 1, '5': 13, '10': 'reviewLimit'},
    {'1': 'max_interval', '3': 7, '4': 1, '5': 13, '10': 'maxInterval'},
    {'1': 'search', '3': 8, '4': 1, '5': 9, '10': 'search'},
    {
      '1': 'new_cards_ignore_review_limit',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'newCardsIgnoreReviewLimit'
    },
    {
      '1': 'easy_days_percentages',
      '3': 10,
      '4': 3,
      '5': 2,
      '10': 'easyDaysPercentages'
    },
    {
      '1': 'review_order',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.ReviewCardOrder',
      '10': 'reviewOrder'
    },
    {
      '1': 'suspend_after_lapse_count',
      '3': 12,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'suspendAfterLapseCount',
      '17': true
    },
    {
      '1': 'historical_retention',
      '3': 13,
      '4': 1,
      '5': 2,
      '10': 'historicalRetention'
    },
    {
      '1': 'learning_step_count',
      '3': 14,
      '4': 1,
      '5': 13,
      '10': 'learningStepCount'
    },
    {
      '1': 'relearning_step_count',
      '3': 15,
      '4': 1,
      '5': 13,
      '10': 'relearningStepCount'
    },
  ],
  '8': [
    {'1': '_suspend_after_lapse_count'},
  ],
};

/// Descriptor for `SimulateFsrsReviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simulateFsrsReviewRequestDescriptor = $convert.base64Decode(
    'ChlTaW11bGF0ZUZzcnNSZXZpZXdSZXF1ZXN0EhYKBnBhcmFtcxgBIAMoAlIGcGFyYW1zEisKEW'
    'Rlc2lyZWRfcmV0ZW50aW9uGAIgASgCUhBkZXNpcmVkUmV0ZW50aW9uEhsKCWRlY2tfc2l6ZRgD'
    'IAEoDVIIZGVja1NpemUSKAoQZGF5c190b19zaW11bGF0ZRgEIAEoDVIOZGF5c1RvU2ltdWxhdG'
    'USGwoJbmV3X2xpbWl0GAUgASgNUghuZXdMaW1pdBIhCgxyZXZpZXdfbGltaXQYBiABKA1SC3Jl'
    'dmlld0xpbWl0EiEKDG1heF9pbnRlcnZhbBgHIAEoDVILbWF4SW50ZXJ2YWwSFgoGc2VhcmNoGA'
    'ggASgJUgZzZWFyY2gSQAodbmV3X2NhcmRzX2lnbm9yZV9yZXZpZXdfbGltaXQYCSABKAhSGW5l'
    'd0NhcmRzSWdub3JlUmV2aWV3TGltaXQSMgoVZWFzeV9kYXlzX3BlcmNlbnRhZ2VzGAogAygCUh'
    'NlYXN5RGF5c1BlcmNlbnRhZ2VzElYKDHJldmlld19vcmRlchgLIAEoDjIzLmFua2kuZGVja19j'
    'b25maWcuRGVja0NvbmZpZy5Db25maWcuUmV2aWV3Q2FyZE9yZGVyUgtyZXZpZXdPcmRlchI+Ch'
    'lzdXNwZW5kX2FmdGVyX2xhcHNlX2NvdW50GAwgASgNSABSFnN1c3BlbmRBZnRlckxhcHNlQ291'
    'bnSIAQESMQoUaGlzdG9yaWNhbF9yZXRlbnRpb24YDSABKAJSE2hpc3RvcmljYWxSZXRlbnRpb2'
    '4SLgoTbGVhcm5pbmdfc3RlcF9jb3VudBgOIAEoDVIRbGVhcm5pbmdTdGVwQ291bnQSMgoVcmVs'
    'ZWFybmluZ19zdGVwX2NvdW50GA8gASgNUhNyZWxlYXJuaW5nU3RlcENvdW50QhwKGl9zdXNwZW'
    '5kX2FmdGVyX2xhcHNlX2NvdW50');

@$core.Deprecated('Use simulateFsrsReviewResponseDescriptor instead')
const SimulateFsrsReviewResponse$json = {
  '1': 'SimulateFsrsReviewResponse',
  '2': [
    {
      '1': 'accumulated_knowledge_acquisition',
      '3': 1,
      '4': 3,
      '5': 2,
      '10': 'accumulatedKnowledgeAcquisition'
    },
    {
      '1': 'daily_review_count',
      '3': 2,
      '4': 3,
      '5': 13,
      '10': 'dailyReviewCount'
    },
    {'1': 'daily_new_count', '3': 3, '4': 3, '5': 13, '10': 'dailyNewCount'},
    {'1': 'daily_time_cost', '3': 4, '4': 3, '5': 2, '10': 'dailyTimeCost'},
  ],
};

/// Descriptor for `SimulateFsrsReviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simulateFsrsReviewResponseDescriptor = $convert.base64Decode(
    'ChpTaW11bGF0ZUZzcnNSZXZpZXdSZXNwb25zZRJKCiFhY2N1bXVsYXRlZF9rbm93bGVkZ2VfYW'
    'NxdWlzaXRpb24YASADKAJSH2FjY3VtdWxhdGVkS25vd2xlZGdlQWNxdWlzaXRpb24SLAoSZGFp'
    'bHlfcmV2aWV3X2NvdW50GAIgAygNUhBkYWlseVJldmlld0NvdW50EiYKD2RhaWx5X25ld19jb3'
    'VudBgDIAMoDVINZGFpbHlOZXdDb3VudBImCg9kYWlseV90aW1lX2Nvc3QYBCADKAJSDWRhaWx5'
    'VGltZUNvc3Q=');

@$core.Deprecated('Use simulateFsrsWorkloadResponseDescriptor instead')
const SimulateFsrsWorkloadResponse$json = {
  '1': 'SimulateFsrsWorkloadResponse',
  '2': [
    {
      '1': 'cost',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.SimulateFsrsWorkloadResponse.CostEntry',
      '10': 'cost'
    },
    {
      '1': 'reviewless_end_memorized',
      '3': 2,
      '4': 1,
      '5': 2,
      '10': 'reviewlessEndMemorized'
    },
    {
      '1': 'memorized',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.SimulateFsrsWorkloadResponse.MemorizedEntry',
      '10': 'memorized'
    },
    {
      '1': 'review_count',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.anki.scheduler.SimulateFsrsWorkloadResponse.ReviewCountEntry',
      '10': 'reviewCount'
    },
  ],
  '3': [
    SimulateFsrsWorkloadResponse_CostEntry$json,
    SimulateFsrsWorkloadResponse_MemorizedEntry$json,
    SimulateFsrsWorkloadResponse_ReviewCountEntry$json
  ],
};

@$core.Deprecated('Use simulateFsrsWorkloadResponseDescriptor instead')
const SimulateFsrsWorkloadResponse_CostEntry$json = {
  '1': 'CostEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 2, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use simulateFsrsWorkloadResponseDescriptor instead')
const SimulateFsrsWorkloadResponse_MemorizedEntry$json = {
  '1': 'MemorizedEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 2, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use simulateFsrsWorkloadResponseDescriptor instead')
const SimulateFsrsWorkloadResponse_ReviewCountEntry$json = {
  '1': 'ReviewCountEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SimulateFsrsWorkloadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simulateFsrsWorkloadResponseDescriptor = $convert.base64Decode(
    'ChxTaW11bGF0ZUZzcnNXb3JrbG9hZFJlc3BvbnNlEkoKBGNvc3QYASADKAsyNi5hbmtpLnNjaG'
    'VkdWxlci5TaW11bGF0ZUZzcnNXb3JrbG9hZFJlc3BvbnNlLkNvc3RFbnRyeVIEY29zdBI4Chhy'
    'ZXZpZXdsZXNzX2VuZF9tZW1vcml6ZWQYAiABKAJSFnJldmlld2xlc3NFbmRNZW1vcml6ZWQSWQ'
    'oJbWVtb3JpemVkGAMgAygLMjsuYW5raS5zY2hlZHVsZXIuU2ltdWxhdGVGc3JzV29ya2xvYWRS'
    'ZXNwb25zZS5NZW1vcml6ZWRFbnRyeVIJbWVtb3JpemVkEmAKDHJldmlld19jb3VudBgEIAMoCz'
    'I9LmFua2kuc2NoZWR1bGVyLlNpbXVsYXRlRnNyc1dvcmtsb2FkUmVzcG9uc2UuUmV2aWV3Q291'
    'bnRFbnRyeVILcmV2aWV3Q291bnQaNwoJQ29zdEVudHJ5EhAKA2tleRgBIAEoDVIDa2V5EhQKBX'
    'ZhbHVlGAIgASgCUgV2YWx1ZToCOAEaPAoOTWVtb3JpemVkRW50cnkSEAoDa2V5GAEgASgNUgNr'
    'ZXkSFAoFdmFsdWUYAiABKAJSBXZhbHVlOgI4ARo+ChBSZXZpZXdDb3VudEVudHJ5EhAKA2tleR'
    'gBIAEoDVIDa2V5EhQKBXZhbHVlGAIgASgNUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use computeOptimalRetentionResponseDescriptor instead')
const ComputeOptimalRetentionResponse$json = {
  '1': 'ComputeOptimalRetentionResponse',
  '2': [
    {
      '1': 'optimal_retention',
      '3': 1,
      '4': 1,
      '5': 2,
      '10': 'optimalRetention'
    },
  ],
};

/// Descriptor for `ComputeOptimalRetentionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List computeOptimalRetentionResponseDescriptor =
    $convert.base64Decode(
        'Ch9Db21wdXRlT3B0aW1hbFJldGVudGlvblJlc3BvbnNlEisKEW9wdGltYWxfcmV0ZW50aW9uGA'
        'EgASgCUhBvcHRpbWFsUmV0ZW50aW9u');

@$core.Deprecated('Use getOptimalRetentionParametersRequestDescriptor instead')
const GetOptimalRetentionParametersRequest$json = {
  '1': 'GetOptimalRetentionParametersRequest',
  '2': [
    {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `GetOptimalRetentionParametersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOptimalRetentionParametersRequestDescriptor =
    $convert.base64Decode(
        'CiRHZXRPcHRpbWFsUmV0ZW50aW9uUGFyYW1ldGVyc1JlcXVlc3QSFgoGc2VhcmNoGAEgASgJUg'
        'ZzZWFyY2g=');

@$core.Deprecated('Use getOptimalRetentionParametersResponseDescriptor instead')
const GetOptimalRetentionParametersResponse$json = {
  '1': 'GetOptimalRetentionParametersResponse',
  '2': [
    {'1': 'deck_size', '3': 1, '4': 1, '5': 13, '10': 'deckSize'},
    {'1': 'learn_span', '3': 2, '4': 1, '5': 13, '10': 'learnSpan'},
    {'1': 'max_cost_perday', '3': 3, '4': 1, '5': 2, '10': 'maxCostPerday'},
    {'1': 'max_ivl', '3': 4, '4': 1, '5': 2, '10': 'maxIvl'},
    {'1': 'first_rating_prob', '3': 5, '4': 3, '5': 2, '10': 'firstRatingProb'},
    {
      '1': 'review_rating_prob',
      '3': 6,
      '4': 3,
      '5': 2,
      '10': 'reviewRatingProb'
    },
    {'1': 'loss_aversion', '3': 7, '4': 1, '5': 2, '10': 'lossAversion'},
    {'1': 'learn_limit', '3': 8, '4': 1, '5': 13, '10': 'learnLimit'},
    {'1': 'review_limit', '3': 9, '4': 1, '5': 13, '10': 'reviewLimit'},
    {
      '1': 'learning_step_transitions',
      '3': 10,
      '4': 3,
      '5': 2,
      '10': 'learningStepTransitions'
    },
    {
      '1': 'relearning_step_transitions',
      '3': 11,
      '4': 3,
      '5': 2,
      '10': 'relearningStepTransitions'
    },
    {
      '1': 'state_rating_costs',
      '3': 12,
      '4': 3,
      '5': 2,
      '10': 'stateRatingCosts'
    },
    {
      '1': 'learning_step_count',
      '3': 13,
      '4': 1,
      '5': 13,
      '10': 'learningStepCount'
    },
    {
      '1': 'relearning_step_count',
      '3': 14,
      '4': 1,
      '5': 13,
      '10': 'relearningStepCount'
    },
  ],
};

/// Descriptor for `GetOptimalRetentionParametersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOptimalRetentionParametersResponseDescriptor = $convert.base64Decode(
    'CiVHZXRPcHRpbWFsUmV0ZW50aW9uUGFyYW1ldGVyc1Jlc3BvbnNlEhsKCWRlY2tfc2l6ZRgBIA'
    'EoDVIIZGVja1NpemUSHQoKbGVhcm5fc3BhbhgCIAEoDVIJbGVhcm5TcGFuEiYKD21heF9jb3N0'
    'X3BlcmRheRgDIAEoAlINbWF4Q29zdFBlcmRheRIXCgdtYXhfaXZsGAQgASgCUgZtYXhJdmwSKg'
    'oRZmlyc3RfcmF0aW5nX3Byb2IYBSADKAJSD2ZpcnN0UmF0aW5nUHJvYhIsChJyZXZpZXdfcmF0'
    'aW5nX3Byb2IYBiADKAJSEHJldmlld1JhdGluZ1Byb2ISIwoNbG9zc19hdmVyc2lvbhgHIAEoAl'
    'IMbG9zc0F2ZXJzaW9uEh8KC2xlYXJuX2xpbWl0GAggASgNUgpsZWFybkxpbWl0EiEKDHJldmll'
    'd19saW1pdBgJIAEoDVILcmV2aWV3TGltaXQSOgoZbGVhcm5pbmdfc3RlcF90cmFuc2l0aW9ucx'
    'gKIAMoAlIXbGVhcm5pbmdTdGVwVHJhbnNpdGlvbnMSPgobcmVsZWFybmluZ19zdGVwX3RyYW5z'
    'aXRpb25zGAsgAygCUhlyZWxlYXJuaW5nU3RlcFRyYW5zaXRpb25zEiwKEnN0YXRlX3JhdGluZ1'
    '9jb3N0cxgMIAMoAlIQc3RhdGVSYXRpbmdDb3N0cxIuChNsZWFybmluZ19zdGVwX2NvdW50GA0g'
    'ASgNUhFsZWFybmluZ1N0ZXBDb3VudBIyChVyZWxlYXJuaW5nX3N0ZXBfY291bnQYDiABKA1SE3'
    'JlbGVhcm5pbmdTdGVwQ291bnQ=');

@$core.Deprecated('Use evaluateParamsRequestDescriptor instead')
const EvaluateParamsRequest$json = {
  '1': 'EvaluateParamsRequest',
  '2': [
    {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
    {
      '1': 'ignore_revlogs_before_ms',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'ignoreRevlogsBeforeMs'
    },
    {
      '1': 'num_of_relearning_steps',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'numOfRelearningSteps'
    },
  ],
};

/// Descriptor for `EvaluateParamsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluateParamsRequestDescriptor = $convert.base64Decode(
    'ChVFdmFsdWF0ZVBhcmFtc1JlcXVlc3QSFgoGc2VhcmNoGAEgASgJUgZzZWFyY2gSNwoYaWdub3'
    'JlX3JldmxvZ3NfYmVmb3JlX21zGAIgASgDUhVpZ25vcmVSZXZsb2dzQmVmb3JlTXMSNQoXbnVt'
    'X29mX3JlbGVhcm5pbmdfc3RlcHMYAyABKA1SFG51bU9mUmVsZWFybmluZ1N0ZXBz');

@$core.Deprecated('Use evaluateParamsLegacyRequestDescriptor instead')
const EvaluateParamsLegacyRequest$json = {
  '1': 'EvaluateParamsLegacyRequest',
  '2': [
    {'1': 'params', '3': 1, '4': 3, '5': 2, '10': 'params'},
    {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
    {
      '1': 'ignore_revlogs_before_ms',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'ignoreRevlogsBeforeMs'
    },
  ],
};

/// Descriptor for `EvaluateParamsLegacyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluateParamsLegacyRequestDescriptor =
    $convert.base64Decode(
        'ChtFdmFsdWF0ZVBhcmFtc0xlZ2FjeVJlcXVlc3QSFgoGcGFyYW1zGAEgAygCUgZwYXJhbXMSFg'
        'oGc2VhcmNoGAIgASgJUgZzZWFyY2gSNwoYaWdub3JlX3JldmxvZ3NfYmVmb3JlX21zGAMgASgD'
        'UhVpZ25vcmVSZXZsb2dzQmVmb3JlTXM=');

@$core.Deprecated('Use evaluateParamsResponseDescriptor instead')
const EvaluateParamsResponse$json = {
  '1': 'EvaluateParamsResponse',
  '2': [
    {'1': 'log_loss', '3': 1, '4': 1, '5': 2, '10': 'logLoss'},
    {'1': 'rmse_bins', '3': 2, '4': 1, '5': 2, '10': 'rmseBins'},
  ],
};

/// Descriptor for `EvaluateParamsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluateParamsResponseDescriptor =
    $convert.base64Decode(
        'ChZFdmFsdWF0ZVBhcmFtc1Jlc3BvbnNlEhkKCGxvZ19sb3NzGAEgASgCUgdsb2dMb3NzEhsKCX'
        'Jtc2VfYmlucxgCIAEoAlIIcm1zZUJpbnM=');

@$core.Deprecated('Use computeMemoryStateResponseDescriptor instead')
const ComputeMemoryStateResponse$json = {
  '1': 'ComputeMemoryStateResponse',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.FsrsMemoryState',
      '9': 0,
      '10': 'state',
      '17': true
    },
    {
      '1': 'desired_retention',
      '3': 2,
      '4': 1,
      '5': 2,
      '10': 'desiredRetention'
    },
    {'1': 'decay', '3': 3, '4': 1, '5': 2, '10': 'decay'},
  ],
  '8': [
    {'1': '_state'},
  ],
};

/// Descriptor for `ComputeMemoryStateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List computeMemoryStateResponseDescriptor =
    $convert.base64Decode(
        'ChpDb21wdXRlTWVtb3J5U3RhdGVSZXNwb25zZRI2CgVzdGF0ZRgBIAEoCzIbLmFua2kuY2FyZH'
        'MuRnNyc01lbW9yeVN0YXRlSABSBXN0YXRliAEBEisKEWRlc2lyZWRfcmV0ZW50aW9uGAIgASgC'
        'UhBkZXNpcmVkUmV0ZW50aW9uEhQKBWRlY2F5GAMgASgCUgVkZWNheUIICgZfc3RhdGU=');

@$core.Deprecated('Use fuzzDeltaRequestDescriptor instead')
const FuzzDeltaRequest$json = {
  '1': 'FuzzDeltaRequest',
  '2': [
    {'1': 'card_id', '3': 1, '4': 1, '5': 3, '10': 'cardId'},
    {'1': 'interval', '3': 2, '4': 1, '5': 13, '10': 'interval'},
  ],
};

/// Descriptor for `FuzzDeltaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fuzzDeltaRequestDescriptor = $convert.base64Decode(
    'ChBGdXp6RGVsdGFSZXF1ZXN0EhcKB2NhcmRfaWQYASABKANSBmNhcmRJZBIaCghpbnRlcnZhbB'
    'gCIAEoDVIIaW50ZXJ2YWw=');

@$core.Deprecated('Use fuzzDeltaResponseDescriptor instead')
const FuzzDeltaResponse$json = {
  '1': 'FuzzDeltaResponse',
  '2': [
    {'1': 'delta_days', '3': 1, '4': 1, '5': 17, '10': 'deltaDays'},
  ],
};

/// Descriptor for `FuzzDeltaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fuzzDeltaResponseDescriptor = $convert.base64Decode(
    'ChFGdXp6RGVsdGFSZXNwb25zZRIdCgpkZWx0YV9kYXlzGAEgASgRUglkZWx0YURheXM=');

const $core.Map<$core.String, $core.dynamic> SchedulerServiceBase$json = {
  '1': 'SchedulerService',
  '2': [
    {
      '1': 'GetQueuedCards',
      '2': '.anki.scheduler.GetQueuedCardsRequest',
      '3': '.anki.scheduler.QueuedCards'
    },
    {
      '1': 'AnswerCard',
      '2': '.anki.scheduler.CardAnswer',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'SchedTimingToday',
      '2': '.anki.generic.Empty',
      '3': '.anki.scheduler.SchedTimingTodayResponse'
    },
    {
      '1': 'StudiedToday',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.String'
    },
    {
      '1': 'StudiedTodayMessage',
      '2': '.anki.scheduler.StudiedTodayMessageRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'UpdateStats',
      '2': '.anki.scheduler.UpdateStatsRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'ExtendLimits',
      '2': '.anki.scheduler.ExtendLimitsRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'CountsForDeckToday',
      '2': '.anki.decks.DeckId',
      '3': '.anki.scheduler.CountsForDeckTodayResponse'
    },
    {
      '1': 'CongratsInfo',
      '2': '.anki.generic.Empty',
      '3': '.anki.scheduler.CongratsInfoResponse'
    },
    {
      '1': 'RestoreBuriedAndSuspendedCards',
      '2': '.anki.cards.CardIds',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'UnburyDeck',
      '2': '.anki.scheduler.UnburyDeckRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'BuryOrSuspendCards',
      '2': '.anki.scheduler.BuryOrSuspendCardsRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'EmptyFilteredDeck',
      '2': '.anki.decks.DeckId',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'RebuildFilteredDeck',
      '2': '.anki.decks.DeckId',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'ScheduleCardsAsNew',
      '2': '.anki.scheduler.ScheduleCardsAsNewRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'ScheduleCardsAsNewDefaults',
      '2': '.anki.scheduler.ScheduleCardsAsNewDefaultsRequest',
      '3': '.anki.scheduler.ScheduleCardsAsNewDefaultsResponse'
    },
    {
      '1': 'SetDueDate',
      '2': '.anki.scheduler.SetDueDateRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GradeNow',
      '2': '.anki.scheduler.GradeNowRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'SortCards',
      '2': '.anki.scheduler.SortCardsRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'SortDeck',
      '2': '.anki.scheduler.SortDeckRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'GetSchedulingStates',
      '2': '.anki.cards.CardId',
      '3': '.anki.scheduler.SchedulingStates'
    },
    {
      '1': 'DescribeNextStates',
      '2': '.anki.scheduler.SchedulingStates',
      '3': '.anki.generic.StringList'
    },
    {
      '1': 'StateIsLeech',
      '2': '.anki.scheduler.SchedulingState',
      '3': '.anki.generic.Bool'
    },
    {
      '1': 'UpgradeScheduler',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'CustomStudy',
      '2': '.anki.scheduler.CustomStudyRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'CustomStudyDefaults',
      '2': '.anki.scheduler.CustomStudyDefaultsRequest',
      '3': '.anki.scheduler.CustomStudyDefaultsResponse'
    },
    {
      '1': 'RepositionDefaults',
      '2': '.anki.generic.Empty',
      '3': '.anki.scheduler.RepositionDefaultsResponse'
    },
    {
      '1': 'ComputeFsrsParams',
      '2': '.anki.scheduler.ComputeFsrsParamsRequest',
      '3': '.anki.scheduler.ComputeFsrsParamsResponse'
    },
    {
      '1': 'GetOptimalRetentionParameters',
      '2': '.anki.scheduler.GetOptimalRetentionParametersRequest',
      '3': '.anki.scheduler.GetOptimalRetentionParametersResponse'
    },
    {
      '1': 'ComputeOptimalRetention',
      '2': '.anki.scheduler.SimulateFsrsReviewRequest',
      '3': '.anki.scheduler.ComputeOptimalRetentionResponse'
    },
    {
      '1': 'SimulateFsrsReview',
      '2': '.anki.scheduler.SimulateFsrsReviewRequest',
      '3': '.anki.scheduler.SimulateFsrsReviewResponse'
    },
    {
      '1': 'SimulateFsrsWorkload',
      '2': '.anki.scheduler.SimulateFsrsReviewRequest',
      '3': '.anki.scheduler.SimulateFsrsWorkloadResponse'
    },
    {
      '1': 'EvaluateParams',
      '2': '.anki.scheduler.EvaluateParamsRequest',
      '3': '.anki.scheduler.EvaluateParamsResponse'
    },
    {
      '1': 'EvaluateParamsLegacy',
      '2': '.anki.scheduler.EvaluateParamsLegacyRequest',
      '3': '.anki.scheduler.EvaluateParamsResponse'
    },
    {
      '1': 'ComputeMemoryState',
      '2': '.anki.cards.CardId',
      '3': '.anki.scheduler.ComputeMemoryStateResponse'
    },
    {
      '1': 'FuzzDelta',
      '2': '.anki.scheduler.FuzzDeltaRequest',
      '3': '.anki.scheduler.FuzzDeltaResponse'
    },
  ],
};

@$core.Deprecated('Use schedulerServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SchedulerServiceBase$messageJson = {
  '.anki.scheduler.GetQueuedCardsRequest': GetQueuedCardsRequest$json,
  '.anki.scheduler.QueuedCards': QueuedCards$json,
  '.anki.scheduler.QueuedCards.QueuedCard': QueuedCards_QueuedCard$json,
  '.anki.cards.Card': $0.Card$json,
  '.anki.cards.FsrsMemoryState': $0.FsrsMemoryState$json,
  '.anki.scheduler.SchedulingStates': SchedulingStates$json,
  '.anki.scheduler.SchedulingState': SchedulingState$json,
  '.anki.scheduler.SchedulingState.Normal': SchedulingState_Normal$json,
  '.anki.scheduler.SchedulingState.New': SchedulingState_New$json,
  '.anki.scheduler.SchedulingState.Learning': SchedulingState_Learning$json,
  '.anki.scheduler.SchedulingState.Review': SchedulingState_Review$json,
  '.anki.scheduler.SchedulingState.Relearning': SchedulingState_Relearning$json,
  '.anki.scheduler.SchedulingState.Filtered': SchedulingState_Filtered$json,
  '.anki.scheduler.SchedulingState.Preview': SchedulingState_Preview$json,
  '.anki.scheduler.SchedulingState.ReschedulingFilter':
      SchedulingState_ReschedulingFilter$json,
  '.anki.scheduler.SchedulingContext': SchedulingContext$json,
  '.anki.scheduler.CardAnswer': CardAnswer$json,
  '.anki.collection.OpChanges': $2.OpChanges$json,
  '.anki.generic.Empty': $3.Empty$json,
  '.anki.scheduler.SchedTimingTodayResponse': SchedTimingTodayResponse$json,
  '.anki.generic.String': $3.String$json,
  '.anki.scheduler.StudiedTodayMessageRequest': StudiedTodayMessageRequest$json,
  '.anki.scheduler.UpdateStatsRequest': UpdateStatsRequest$json,
  '.anki.scheduler.ExtendLimitsRequest': ExtendLimitsRequest$json,
  '.anki.decks.DeckId': $4.DeckId$json,
  '.anki.scheduler.CountsForDeckTodayResponse': CountsForDeckTodayResponse$json,
  '.anki.scheduler.CongratsInfoResponse': CongratsInfoResponse$json,
  '.anki.cards.CardIds': $0.CardIds$json,
  '.anki.scheduler.UnburyDeckRequest': UnburyDeckRequest$json,
  '.anki.scheduler.BuryOrSuspendCardsRequest': BuryOrSuspendCardsRequest$json,
  '.anki.collection.OpChangesWithCount': $2.OpChangesWithCount$json,
  '.anki.scheduler.ScheduleCardsAsNewRequest': ScheduleCardsAsNewRequest$json,
  '.anki.scheduler.ScheduleCardsAsNewDefaultsRequest':
      ScheduleCardsAsNewDefaultsRequest$json,
  '.anki.scheduler.ScheduleCardsAsNewDefaultsResponse':
      ScheduleCardsAsNewDefaultsResponse$json,
  '.anki.scheduler.SetDueDateRequest': SetDueDateRequest$json,
  '.anki.config.OptionalStringConfigKey': $1.OptionalStringConfigKey$json,
  '.anki.scheduler.GradeNowRequest': GradeNowRequest$json,
  '.anki.scheduler.SortCardsRequest': SortCardsRequest$json,
  '.anki.scheduler.SortDeckRequest': SortDeckRequest$json,
  '.anki.cards.CardId': $0.CardId$json,
  '.anki.generic.StringList': $3.StringList$json,
  '.anki.generic.Bool': $3.Bool$json,
  '.anki.scheduler.CustomStudyRequest': CustomStudyRequest$json,
  '.anki.scheduler.CustomStudyRequest.Cram': CustomStudyRequest_Cram$json,
  '.anki.scheduler.CustomStudyDefaultsRequest': CustomStudyDefaultsRequest$json,
  '.anki.scheduler.CustomStudyDefaultsResponse':
      CustomStudyDefaultsResponse$json,
  '.anki.scheduler.CustomStudyDefaultsResponse.Tag':
      CustomStudyDefaultsResponse_Tag$json,
  '.anki.scheduler.RepositionDefaultsResponse': RepositionDefaultsResponse$json,
  '.anki.scheduler.ComputeFsrsParamsRequest': ComputeFsrsParamsRequest$json,
  '.anki.scheduler.ComputeFsrsParamsResponse': ComputeFsrsParamsResponse$json,
  '.anki.scheduler.GetOptimalRetentionParametersRequest':
      GetOptimalRetentionParametersRequest$json,
  '.anki.scheduler.GetOptimalRetentionParametersResponse':
      GetOptimalRetentionParametersResponse$json,
  '.anki.scheduler.SimulateFsrsReviewRequest': SimulateFsrsReviewRequest$json,
  '.anki.scheduler.ComputeOptimalRetentionResponse':
      ComputeOptimalRetentionResponse$json,
  '.anki.scheduler.SimulateFsrsReviewResponse': SimulateFsrsReviewResponse$json,
  '.anki.scheduler.SimulateFsrsWorkloadResponse':
      SimulateFsrsWorkloadResponse$json,
  '.anki.scheduler.SimulateFsrsWorkloadResponse.CostEntry':
      SimulateFsrsWorkloadResponse_CostEntry$json,
  '.anki.scheduler.SimulateFsrsWorkloadResponse.MemorizedEntry':
      SimulateFsrsWorkloadResponse_MemorizedEntry$json,
  '.anki.scheduler.SimulateFsrsWorkloadResponse.ReviewCountEntry':
      SimulateFsrsWorkloadResponse_ReviewCountEntry$json,
  '.anki.scheduler.EvaluateParamsRequest': EvaluateParamsRequest$json,
  '.anki.scheduler.EvaluateParamsResponse': EvaluateParamsResponse$json,
  '.anki.scheduler.EvaluateParamsLegacyRequest':
      EvaluateParamsLegacyRequest$json,
  '.anki.scheduler.ComputeMemoryStateResponse': ComputeMemoryStateResponse$json,
  '.anki.scheduler.FuzzDeltaRequest': FuzzDeltaRequest$json,
  '.anki.scheduler.FuzzDeltaResponse': FuzzDeltaResponse$json,
};

/// Descriptor for `SchedulerService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List schedulerServiceDescriptor = $convert.base64Decode(
    'ChBTY2hlZHVsZXJTZXJ2aWNlElQKDkdldFF1ZXVlZENhcmRzEiUuYW5raS5zY2hlZHVsZXIuR2'
    'V0UXVldWVkQ2FyZHNSZXF1ZXN0GhsuYW5raS5zY2hlZHVsZXIuUXVldWVkQ2FyZHMSRAoKQW5z'
    'd2VyQ2FyZBIaLmFua2kuc2NoZWR1bGVyLkNhcmRBbnN3ZXIaGi5hbmtpLmNvbGxlY3Rpb24uT3'
    'BDaGFuZ2VzElEKEFNjaGVkVGltaW5nVG9kYXkSEy5hbmtpLmdlbmVyaWMuRW1wdHkaKC5hbmtp'
    'LnNjaGVkdWxlci5TY2hlZFRpbWluZ1RvZGF5UmVzcG9uc2USOQoMU3R1ZGllZFRvZGF5EhMuYW'
    '5raS5nZW5lcmljLkVtcHR5GhQuYW5raS5nZW5lcmljLlN0cmluZxJXChNTdHVkaWVkVG9kYXlN'
    'ZXNzYWdlEiouYW5raS5zY2hlZHVsZXIuU3R1ZGllZFRvZGF5TWVzc2FnZVJlcXVlc3QaFC5hbm'
    'tpLmdlbmVyaWMuU3RyaW5nEkYKC1VwZGF0ZVN0YXRzEiIuYW5raS5zY2hlZHVsZXIuVXBkYXRl'
    'U3RhdHNSZXF1ZXN0GhMuYW5raS5nZW5lcmljLkVtcHR5EkgKDEV4dGVuZExpbWl0cxIjLmFua2'
    'kuc2NoZWR1bGVyLkV4dGVuZExpbWl0c1JlcXVlc3QaEy5hbmtpLmdlbmVyaWMuRW1wdHkSVAoS'
    'Q291bnRzRm9yRGVja1RvZGF5EhIuYW5raS5kZWNrcy5EZWNrSWQaKi5hbmtpLnNjaGVkdWxlci'
    '5Db3VudHNGb3JEZWNrVG9kYXlSZXNwb25zZRJJCgxDb25ncmF0c0luZm8SEy5hbmtpLmdlbmVy'
    'aWMuRW1wdHkaJC5hbmtpLnNjaGVkdWxlci5Db25ncmF0c0luZm9SZXNwb25zZRJRCh5SZXN0b3'
    'JlQnVyaWVkQW5kU3VzcGVuZGVkQ2FyZHMSEy5hbmtpLmNhcmRzLkNhcmRJZHMaGi5hbmtpLmNv'
    'bGxlY3Rpb24uT3BDaGFuZ2VzEksKClVuYnVyeURlY2sSIS5hbmtpLnNjaGVkdWxlci5VbmJ1cn'
    'lEZWNrUmVxdWVzdBoaLmFua2kuY29sbGVjdGlvbi5PcENoYW5nZXMSZAoSQnVyeU9yU3VzcGVu'
    'ZENhcmRzEikuYW5raS5zY2hlZHVsZXIuQnVyeU9yU3VzcGVuZENhcmRzUmVxdWVzdBojLmFua2'
    'kuY29sbGVjdGlvbi5PcENoYW5nZXNXaXRoQ291bnQSQwoRRW1wdHlGaWx0ZXJlZERlY2sSEi5h'
    'bmtpLmRlY2tzLkRlY2tJZBoaLmFua2kuY29sbGVjdGlvbi5PcENoYW5nZXMSTgoTUmVidWlsZE'
    'ZpbHRlcmVkRGVjaxISLmFua2kuZGVja3MuRGVja0lkGiMuYW5raS5jb2xsZWN0aW9uLk9wQ2hh'
    'bmdlc1dpdGhDb3VudBJbChJTY2hlZHVsZUNhcmRzQXNOZXcSKS5hbmtpLnNjaGVkdWxlci5TY2'
    'hlZHVsZUNhcmRzQXNOZXdSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcxKDAQoa'
    'U2NoZWR1bGVDYXJkc0FzTmV3RGVmYXVsdHMSMS5hbmtpLnNjaGVkdWxlci5TY2hlZHVsZUNhcm'
    'RzQXNOZXdEZWZhdWx0c1JlcXVlc3QaMi5hbmtpLnNjaGVkdWxlci5TY2hlZHVsZUNhcmRzQXNO'
    'ZXdEZWZhdWx0c1Jlc3BvbnNlEksKClNldER1ZURhdGUSIS5hbmtpLnNjaGVkdWxlci5TZXREdW'
    'VEYXRlUmVxdWVzdBoaLmFua2kuY29sbGVjdGlvbi5PcENoYW5nZXMSRwoIR3JhZGVOb3cSHy5h'
    'bmtpLnNjaGVkdWxlci5HcmFkZU5vd1JlcXVlc3QaGi5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2'
    'VzElIKCVNvcnRDYXJkcxIgLmFua2kuc2NoZWR1bGVyLlNvcnRDYXJkc1JlcXVlc3QaIy5hbmtp'
    'LmNvbGxlY3Rpb24uT3BDaGFuZ2VzV2l0aENvdW50ElAKCFNvcnREZWNrEh8uYW5raS5zY2hlZH'
    'VsZXIuU29ydERlY2tSZXF1ZXN0GiMuYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlc1dpdGhDb3Vu'
    'dBJLChNHZXRTY2hlZHVsaW5nU3RhdGVzEhIuYW5raS5jYXJkcy5DYXJkSWQaIC5hbmtpLnNjaG'
    'VkdWxlci5TY2hlZHVsaW5nU3RhdGVzElAKEkRlc2NyaWJlTmV4dFN0YXRlcxIgLmFua2kuc2No'
    'ZWR1bGVyLlNjaGVkdWxpbmdTdGF0ZXMaGC5hbmtpLmdlbmVyaWMuU3RyaW5nTGlzdBJDCgxTdG'
    'F0ZUlzTGVlY2gSHy5hbmtpLnNjaGVkdWxlci5TY2hlZHVsaW5nU3RhdGUaEi5hbmtpLmdlbmVy'
    'aWMuQm9vbBI8ChBVcGdyYWRlU2NoZWR1bGVyEhMuYW5raS5nZW5lcmljLkVtcHR5GhMuYW5raS'
    '5nZW5lcmljLkVtcHR5Ek0KC0N1c3RvbVN0dWR5EiIuYW5raS5zY2hlZHVsZXIuQ3VzdG9tU3R1'
    'ZHlSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcxJuChNDdXN0b21TdHVkeURlZm'
    'F1bHRzEiouYW5raS5zY2hlZHVsZXIuQ3VzdG9tU3R1ZHlEZWZhdWx0c1JlcXVlc3QaKy5hbmtp'
    'LnNjaGVkdWxlci5DdXN0b21TdHVkeURlZmF1bHRzUmVzcG9uc2USVQoSUmVwb3NpdGlvbkRlZm'
    'F1bHRzEhMuYW5raS5nZW5lcmljLkVtcHR5GiouYW5raS5zY2hlZHVsZXIuUmVwb3NpdGlvbkRl'
    'ZmF1bHRzUmVzcG9uc2USaAoRQ29tcHV0ZUZzcnNQYXJhbXMSKC5hbmtpLnNjaGVkdWxlci5Db2'
    '1wdXRlRnNyc1BhcmFtc1JlcXVlc3QaKS5hbmtpLnNjaGVkdWxlci5Db21wdXRlRnNyc1BhcmFt'
    'c1Jlc3BvbnNlEowBCh1HZXRPcHRpbWFsUmV0ZW50aW9uUGFyYW1ldGVycxI0LmFua2kuc2NoZW'
    'R1bGVyLkdldE9wdGltYWxSZXRlbnRpb25QYXJhbWV0ZXJzUmVxdWVzdBo1LmFua2kuc2NoZWR1'
    'bGVyLkdldE9wdGltYWxSZXRlbnRpb25QYXJhbWV0ZXJzUmVzcG9uc2USdQoXQ29tcHV0ZU9wdG'
    'ltYWxSZXRlbnRpb24SKS5hbmtpLnNjaGVkdWxlci5TaW11bGF0ZUZzcnNSZXZpZXdSZXF1ZXN0'
    'Gi8uYW5raS5zY2hlZHVsZXIuQ29tcHV0ZU9wdGltYWxSZXRlbnRpb25SZXNwb25zZRJrChJTaW'
    '11bGF0ZUZzcnNSZXZpZXcSKS5hbmtpLnNjaGVkdWxlci5TaW11bGF0ZUZzcnNSZXZpZXdSZXF1'
    'ZXN0GiouYW5raS5zY2hlZHVsZXIuU2ltdWxhdGVGc3JzUmV2aWV3UmVzcG9uc2USbwoUU2ltdW'
    'xhdGVGc3JzV29ya2xvYWQSKS5hbmtpLnNjaGVkdWxlci5TaW11bGF0ZUZzcnNSZXZpZXdSZXF1'
    'ZXN0GiwuYW5raS5zY2hlZHVsZXIuU2ltdWxhdGVGc3JzV29ya2xvYWRSZXNwb25zZRJfCg5Fdm'
    'FsdWF0ZVBhcmFtcxIlLmFua2kuc2NoZWR1bGVyLkV2YWx1YXRlUGFyYW1zUmVxdWVzdBomLmFu'
    'a2kuc2NoZWR1bGVyLkV2YWx1YXRlUGFyYW1zUmVzcG9uc2USawoURXZhbHVhdGVQYXJhbXNMZW'
    'dhY3kSKy5hbmtpLnNjaGVkdWxlci5FdmFsdWF0ZVBhcmFtc0xlZ2FjeVJlcXVlc3QaJi5hbmtp'
    'LnNjaGVkdWxlci5FdmFsdWF0ZVBhcmFtc1Jlc3BvbnNlElQKEkNvbXB1dGVNZW1vcnlTdGF0ZR'
    'ISLmFua2kuY2FyZHMuQ2FyZElkGiouYW5raS5zY2hlZHVsZXIuQ29tcHV0ZU1lbW9yeVN0YXRl'
    'UmVzcG9uc2USUAoJRnV6ekRlbHRhEiAuYW5raS5zY2hlZHVsZXIuRnV6ekRlbHRhUmVxdWVzdB'
    'ohLmFua2kuc2NoZWR1bGVyLkZ1enpEZWx0YVJlc3BvbnNl');

const $core.Map<$core.String, $core.dynamic> BackendSchedulerServiceBase$json =
    {
  '1': 'BackendSchedulerService',
  '2': [
    {
      '1': 'ComputeFsrsParamsFromItems',
      '2': '.anki.scheduler.ComputeFsrsParamsFromItemsRequest',
      '3': '.anki.scheduler.ComputeFsrsParamsResponse'
    },
    {
      '1': 'FsrsBenchmark',
      '2': '.anki.scheduler.FsrsBenchmarkRequest',
      '3': '.anki.scheduler.FsrsBenchmarkResponse'
    },
    {
      '1': 'ExportDataset',
      '2': '.anki.scheduler.ExportDatasetRequest',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use backendSchedulerServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendSchedulerServiceBase$messageJson = {
  '.anki.scheduler.ComputeFsrsParamsFromItemsRequest':
      ComputeFsrsParamsFromItemsRequest$json,
  '.anki.scheduler.FsrsItem': FsrsItem$json,
  '.anki.scheduler.FsrsReview': FsrsReview$json,
  '.anki.scheduler.ComputeFsrsParamsResponse': ComputeFsrsParamsResponse$json,
  '.anki.scheduler.FsrsBenchmarkRequest': FsrsBenchmarkRequest$json,
  '.anki.scheduler.FsrsBenchmarkResponse': FsrsBenchmarkResponse$json,
  '.anki.scheduler.ExportDatasetRequest': ExportDatasetRequest$json,
  '.anki.generic.Empty': $3.Empty$json,
};

/// Descriptor for `BackendSchedulerService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendSchedulerServiceDescriptor = $convert.base64Decode(
    'ChdCYWNrZW5kU2NoZWR1bGVyU2VydmljZRJ6ChpDb21wdXRlRnNyc1BhcmFtc0Zyb21JdGVtcx'
    'IxLmFua2kuc2NoZWR1bGVyLkNvbXB1dGVGc3JzUGFyYW1zRnJvbUl0ZW1zUmVxdWVzdBopLmFu'
    'a2kuc2NoZWR1bGVyLkNvbXB1dGVGc3JzUGFyYW1zUmVzcG9uc2USXAoNRnNyc0JlbmNobWFyax'
    'IkLmFua2kuc2NoZWR1bGVyLkZzcnNCZW5jaG1hcmtSZXF1ZXN0GiUuYW5raS5zY2hlZHVsZXIu'
    'RnNyc0JlbmNobWFya1Jlc3BvbnNlEkoKDUV4cG9ydERhdGFzZXQSJC5hbmtpLnNjaGVkdWxlci'
    '5FeHBvcnREYXRhc2V0UmVxdWVzdBoTLmFua2kuZ2VuZXJpYy5FbXB0eQ==');
