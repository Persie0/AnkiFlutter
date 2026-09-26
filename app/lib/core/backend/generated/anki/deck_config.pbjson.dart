// This is a generated file - do not edit.
//
// Generated from anki/deck_config.proto.

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

import 'collection.pbjson.dart' as $2;
import 'decks.pbjson.dart' as $1;
import 'generic.pbjson.dart' as $0;

@$core.Deprecated('Use updateDeckConfigsModeDescriptor instead')
const UpdateDeckConfigsMode$json = {
  '1': 'UpdateDeckConfigsMode',
  '2': [
    {'1': 'UPDATE_DECK_CONFIGS_MODE_NORMAL', '2': 0},
    {'1': 'UPDATE_DECK_CONFIGS_MODE_APPLY_TO_CHILDREN', '2': 1},
    {'1': 'UPDATE_DECK_CONFIGS_MODE_COMPUTE_ALL_PARAMS', '2': 2},
  ],
};

/// Descriptor for `UpdateDeckConfigsMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List updateDeckConfigsModeDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVEZWNrQ29uZmlnc01vZGUSIwofVVBEQVRFX0RFQ0tfQ09ORklHU19NT0RFX05PUk'
    '1BTBAAEi4KKlVQREFURV9ERUNLX0NPTkZJR1NfTU9ERV9BUFBMWV9UT19DSElMRFJFThABEi8K'
    'K1VQREFURV9ERUNLX0NPTkZJR1NfTU9ERV9DT01QVVRFX0FMTF9QQVJBTVMQAg==');

@$core.Deprecated('Use deckConfigIdDescriptor instead')
const DeckConfigId$json = {
  '1': 'DeckConfigId',
  '2': [
    {'1': 'dcid', '3': 1, '4': 1, '5': 3, '10': 'dcid'},
  ],
};

/// Descriptor for `DeckConfigId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckConfigIdDescriptor =
    $convert.base64Decode('CgxEZWNrQ29uZmlnSWQSEgoEZGNpZBgBIAEoA1IEZGNpZA==');

@$core.Deprecated('Use getRetentionWorkloadRequestDescriptor instead')
const GetRetentionWorkloadRequest$json = {
  '1': 'GetRetentionWorkloadRequest',
  '2': [
    {'1': 'w', '3': 1, '4': 3, '5': 2, '10': 'w'},
    {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `GetRetentionWorkloadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRetentionWorkloadRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRSZXRlbnRpb25Xb3JrbG9hZFJlcXVlc3QSDAoBdxgBIAMoAlIBdxIWCgZzZWFyY2gYAi'
        'ABKAlSBnNlYXJjaA==');

@$core.Deprecated('Use getRetentionWorkloadResponseDescriptor instead')
const GetRetentionWorkloadResponse$json = {
  '1': 'GetRetentionWorkloadResponse',
  '2': [
    {
      '1': 'costs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.deck_config.GetRetentionWorkloadResponse.CostsEntry',
      '10': 'costs'
    },
  ],
  '3': [GetRetentionWorkloadResponse_CostsEntry$json],
};

@$core.Deprecated('Use getRetentionWorkloadResponseDescriptor instead')
const GetRetentionWorkloadResponse_CostsEntry$json = {
  '1': 'CostsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 2, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetRetentionWorkloadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRetentionWorkloadResponseDescriptor = $convert.base64Decode(
    'ChxHZXRSZXRlbnRpb25Xb3JrbG9hZFJlc3BvbnNlEk8KBWNvc3RzGAEgAygLMjkuYW5raS5kZW'
    'NrX2NvbmZpZy5HZXRSZXRlbnRpb25Xb3JrbG9hZFJlc3BvbnNlLkNvc3RzRW50cnlSBWNvc3Rz'
    'GjgKCkNvc3RzRW50cnkSEAoDa2V5GAEgASgNUgNrZXkSFAoFdmFsdWUYAiABKAJSBXZhbHVlOg'
    'I4AQ==');

@$core.Deprecated('Use getIgnoredBeforeCountRequestDescriptor instead')
const GetIgnoredBeforeCountRequest$json = {
  '1': 'GetIgnoredBeforeCountRequest',
  '2': [
    {
      '1': 'ignore_revlogs_before_date',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'ignoreRevlogsBeforeDate'
    },
    {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `GetIgnoredBeforeCountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIgnoredBeforeCountRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRJZ25vcmVkQmVmb3JlQ291bnRSZXF1ZXN0EjsKGmlnbm9yZV9yZXZsb2dzX2JlZm9yZV'
        '9kYXRlGAEgASgJUhdpZ25vcmVSZXZsb2dzQmVmb3JlRGF0ZRIWCgZzZWFyY2gYAiABKAlSBnNl'
        'YXJjaA==');

@$core.Deprecated('Use getIgnoredBeforeCountResponseDescriptor instead')
const GetIgnoredBeforeCountResponse$json = {
  '1': 'GetIgnoredBeforeCountResponse',
  '2': [
    {'1': 'included', '3': 1, '4': 1, '5': 4, '10': 'included'},
    {'1': 'total', '3': 2, '4': 1, '5': 4, '10': 'total'},
  ],
};

/// Descriptor for `GetIgnoredBeforeCountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIgnoredBeforeCountResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRJZ25vcmVkQmVmb3JlQ291bnRSZXNwb25zZRIaCghpbmNsdWRlZBgBIAEoBFIIaW5jbH'
        'VkZWQSFAoFdG90YWwYAiABKARSBXRvdGFs');

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig$json = {
  '1': 'DeckConfig',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'mtime_secs', '3': 3, '4': 1, '5': 3, '10': 'mtimeSecs'},
    {'1': 'usn', '3': 4, '4': 1, '5': 5, '10': 'usn'},
    {
      '1': 'config',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.deck_config.DeckConfig.Config',
      '10': 'config'
    },
  ],
  '3': [DeckConfig_Config$json],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config$json = {
  '1': 'Config',
  '2': [
    {'1': 'learn_steps', '3': 1, '4': 3, '5': 2, '10': 'learnSteps'},
    {'1': 'relearn_steps', '3': 2, '4': 3, '5': 2, '10': 'relearnSteps'},
    {'1': 'fsrs_params_4', '3': 3, '4': 3, '5': 2, '10': 'fsrsParams4'},
    {'1': 'fsrs_params_5', '3': 5, '4': 3, '5': 2, '10': 'fsrsParams5'},
    {'1': 'fsrs_params_6', '3': 6, '4': 3, '5': 2, '10': 'fsrsParams6'},
    {'1': 'new_per_day', '3': 9, '4': 1, '5': 13, '10': 'newPerDay'},
    {'1': 'reviews_per_day', '3': 10, '4': 1, '5': 13, '10': 'reviewsPerDay'},
    {
      '1': 'new_per_day_minimum',
      '3': 35,
      '4': 1,
      '5': 13,
      '10': 'newPerDayMinimum'
    },
    {'1': 'initial_ease', '3': 11, '4': 1, '5': 2, '10': 'initialEase'},
    {'1': 'easy_multiplier', '3': 12, '4': 1, '5': 2, '10': 'easyMultiplier'},
    {'1': 'hard_multiplier', '3': 13, '4': 1, '5': 2, '10': 'hardMultiplier'},
    {'1': 'lapse_multiplier', '3': 14, '4': 1, '5': 2, '10': 'lapseMultiplier'},
    {
      '1': 'interval_multiplier',
      '3': 15,
      '4': 1,
      '5': 2,
      '10': 'intervalMultiplier'
    },
    {
      '1': 'maximum_review_interval',
      '3': 16,
      '4': 1,
      '5': 13,
      '10': 'maximumReviewInterval'
    },
    {
      '1': 'minimum_lapse_interval',
      '3': 17,
      '4': 1,
      '5': 13,
      '10': 'minimumLapseInterval'
    },
    {
      '1': 'graduating_interval_good',
      '3': 18,
      '4': 1,
      '5': 13,
      '10': 'graduatingIntervalGood'
    },
    {
      '1': 'graduating_interval_easy',
      '3': 19,
      '4': 1,
      '5': 13,
      '10': 'graduatingIntervalEasy'
    },
    {
      '1': 'new_card_insert_order',
      '3': 20,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.NewCardInsertOrder',
      '10': 'newCardInsertOrder'
    },
    {
      '1': 'new_card_gather_priority',
      '3': 34,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.NewCardGatherPriority',
      '10': 'newCardGatherPriority'
    },
    {
      '1': 'new_card_sort_order',
      '3': 32,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.NewCardSortOrder',
      '10': 'newCardSortOrder'
    },
    {
      '1': 'new_mix',
      '3': 30,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.ReviewMix',
      '10': 'newMix'
    },
    {
      '1': 'review_order',
      '3': 33,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.ReviewCardOrder',
      '10': 'reviewOrder'
    },
    {
      '1': 'interday_learning_mix',
      '3': 31,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.ReviewMix',
      '10': 'interdayLearningMix'
    },
    {
      '1': 'leech_action',
      '3': 21,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.LeechAction',
      '10': 'leechAction'
    },
    {'1': 'leech_threshold', '3': 22, '4': 1, '5': 13, '10': 'leechThreshold'},
    {'1': 'disable_autoplay', '3': 23, '4': 1, '5': 8, '10': 'disableAutoplay'},
    {
      '1': 'cap_answer_time_to_secs',
      '3': 24,
      '4': 1,
      '5': 13,
      '10': 'capAnswerTimeToSecs'
    },
    {'1': 'show_timer', '3': 25, '4': 1, '5': 8, '10': 'showTimer'},
    {
      '1': 'stop_timer_on_answer',
      '3': 38,
      '4': 1,
      '5': 8,
      '10': 'stopTimerOnAnswer'
    },
    {
      '1': 'seconds_to_show_question',
      '3': 41,
      '4': 1,
      '5': 2,
      '10': 'secondsToShowQuestion'
    },
    {
      '1': 'seconds_to_show_answer',
      '3': 42,
      '4': 1,
      '5': 2,
      '10': 'secondsToShowAnswer'
    },
    {
      '1': 'question_action',
      '3': 36,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.QuestionAction',
      '10': 'questionAction'
    },
    {
      '1': 'answer_action',
      '3': 43,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.DeckConfig.Config.AnswerAction',
      '10': 'answerAction'
    },
    {'1': 'wait_for_audio', '3': 44, '4': 1, '5': 8, '10': 'waitForAudio'},
    {
      '1': 'skip_question_when_replaying_answer',
      '3': 26,
      '4': 1,
      '5': 8,
      '10': 'skipQuestionWhenReplayingAnswer'
    },
    {'1': 'bury_new', '3': 27, '4': 1, '5': 8, '10': 'buryNew'},
    {'1': 'bury_reviews', '3': 28, '4': 1, '5': 8, '10': 'buryReviews'},
    {
      '1': 'bury_interday_learning',
      '3': 29,
      '4': 1,
      '5': 8,
      '10': 'buryInterdayLearning'
    },
    {
      '1': 'desired_retention',
      '3': 37,
      '4': 1,
      '5': 2,
      '10': 'desiredRetention'
    },
    {
      '1': 'ignore_revlogs_before_date',
      '3': 46,
      '4': 1,
      '5': 9,
      '10': 'ignoreRevlogsBeforeDate'
    },
    {
      '1': 'easy_days_percentages',
      '3': 4,
      '4': 3,
      '5': 2,
      '10': 'easyDaysPercentages'
    },
    {
      '1': 'historical_retention',
      '3': 40,
      '4': 1,
      '5': 2,
      '10': 'historicalRetention'
    },
    {'1': 'param_search', '3': 45, '4': 1, '5': 9, '10': 'paramSearch'},
    {'1': 'other', '3': 255, '4': 1, '5': 12, '10': 'other'},
  ],
  '4': [
    DeckConfig_Config_NewCardInsertOrder$json,
    DeckConfig_Config_NewCardGatherPriority$json,
    DeckConfig_Config_NewCardSortOrder$json,
    DeckConfig_Config_ReviewCardOrder$json,
    DeckConfig_Config_ReviewMix$json,
    DeckConfig_Config_LeechAction$json,
    DeckConfig_Config_AnswerAction$json,
    DeckConfig_Config_QuestionAction$json
  ],
  '9': [
    {'1': 7, '2': 9},
    {'1': 39, '2': 40},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_NewCardInsertOrder$json = {
  '1': 'NewCardInsertOrder',
  '2': [
    {'1': 'NEW_CARD_INSERT_ORDER_DUE', '2': 0},
    {'1': 'NEW_CARD_INSERT_ORDER_RANDOM', '2': 1},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_NewCardGatherPriority$json = {
  '1': 'NewCardGatherPriority',
  '2': [
    {'1': 'NEW_CARD_GATHER_PRIORITY_DECK', '2': 0},
    {'1': 'NEW_CARD_GATHER_PRIORITY_DECK_THEN_RANDOM_NOTES', '2': 5},
    {'1': 'NEW_CARD_GATHER_PRIORITY_LOWEST_POSITION', '2': 1},
    {'1': 'NEW_CARD_GATHER_PRIORITY_HIGHEST_POSITION', '2': 2},
    {'1': 'NEW_CARD_GATHER_PRIORITY_RANDOM_NOTES', '2': 3},
    {'1': 'NEW_CARD_GATHER_PRIORITY_RANDOM_CARDS', '2': 4},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_NewCardSortOrder$json = {
  '1': 'NewCardSortOrder',
  '2': [
    {'1': 'NEW_CARD_SORT_ORDER_TEMPLATE', '2': 0},
    {'1': 'NEW_CARD_SORT_ORDER_NO_SORT', '2': 1},
    {'1': 'NEW_CARD_SORT_ORDER_TEMPLATE_THEN_RANDOM', '2': 2},
    {'1': 'NEW_CARD_SORT_ORDER_RANDOM_NOTE_THEN_TEMPLATE', '2': 3},
    {'1': 'NEW_CARD_SORT_ORDER_RANDOM_CARD', '2': 4},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_ReviewCardOrder$json = {
  '1': 'ReviewCardOrder',
  '2': [
    {'1': 'REVIEW_CARD_ORDER_DAY', '2': 0},
    {'1': 'REVIEW_CARD_ORDER_DAY_THEN_DECK', '2': 1},
    {'1': 'REVIEW_CARD_ORDER_DECK_THEN_DAY', '2': 2},
    {'1': 'REVIEW_CARD_ORDER_INTERVALS_ASCENDING', '2': 3},
    {'1': 'REVIEW_CARD_ORDER_INTERVALS_DESCENDING', '2': 4},
    {'1': 'REVIEW_CARD_ORDER_EASE_ASCENDING', '2': 5},
    {'1': 'REVIEW_CARD_ORDER_EASE_DESCENDING', '2': 6},
    {'1': 'REVIEW_CARD_ORDER_RETRIEVABILITY_ASCENDING', '2': 7},
    {'1': 'REVIEW_CARD_ORDER_RETRIEVABILITY_DESCENDING', '2': 11},
    {'1': 'REVIEW_CARD_ORDER_RELATIVE_OVERDUENESS', '2': 12},
    {'1': 'REVIEW_CARD_ORDER_RANDOM', '2': 8},
    {'1': 'REVIEW_CARD_ORDER_ADDED', '2': 9},
    {'1': 'REVIEW_CARD_ORDER_REVERSE_ADDED', '2': 10},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_ReviewMix$json = {
  '1': 'ReviewMix',
  '2': [
    {'1': 'REVIEW_MIX_MIX_WITH_REVIEWS', '2': 0},
    {'1': 'REVIEW_MIX_AFTER_REVIEWS', '2': 1},
    {'1': 'REVIEW_MIX_BEFORE_REVIEWS', '2': 2},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_LeechAction$json = {
  '1': 'LeechAction',
  '2': [
    {'1': 'LEECH_ACTION_SUSPEND', '2': 0},
    {'1': 'LEECH_ACTION_TAG_ONLY', '2': 1},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_AnswerAction$json = {
  '1': 'AnswerAction',
  '2': [
    {'1': 'ANSWER_ACTION_BURY_CARD', '2': 0},
    {'1': 'ANSWER_ACTION_ANSWER_AGAIN', '2': 1},
    {'1': 'ANSWER_ACTION_ANSWER_GOOD', '2': 2},
    {'1': 'ANSWER_ACTION_ANSWER_HARD', '2': 3},
    {'1': 'ANSWER_ACTION_SHOW_REMINDER', '2': 4},
  ],
};

@$core.Deprecated('Use deckConfigDescriptor instead')
const DeckConfig_Config_QuestionAction$json = {
  '1': 'QuestionAction',
  '2': [
    {'1': 'QUESTION_ACTION_SHOW_ANSWER', '2': 0},
    {'1': 'QUESTION_ACTION_SHOW_REMINDER', '2': 1},
  ],
};

/// Descriptor for `DeckConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckConfigDescriptor = $convert.base64Decode(
    'CgpEZWNrQ29uZmlnEg4KAmlkGAEgASgDUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCm10aW'
    '1lX3NlY3MYAyABKANSCW10aW1lU2VjcxIQCgN1c24YBCABKAVSA3VzbhI7CgZjb25maWcYBSAB'
    'KAsyIy5hbmtpLmRlY2tfY29uZmlnLkRlY2tDb25maWcuQ29uZmlnUgZjb25maWcakB8KBkNvbm'
    'ZpZxIfCgtsZWFybl9zdGVwcxgBIAMoAlIKbGVhcm5TdGVwcxIjCg1yZWxlYXJuX3N0ZXBzGAIg'
    'AygCUgxyZWxlYXJuU3RlcHMSIgoNZnNyc19wYXJhbXNfNBgDIAMoAlILZnNyc1BhcmFtczQSIg'
    'oNZnNyc19wYXJhbXNfNRgFIAMoAlILZnNyc1BhcmFtczUSIgoNZnNyc19wYXJhbXNfNhgGIAMo'
    'AlILZnNyc1BhcmFtczYSHgoLbmV3X3Blcl9kYXkYCSABKA1SCW5ld1BlckRheRImCg9yZXZpZX'
    'dzX3Blcl9kYXkYCiABKA1SDXJldmlld3NQZXJEYXkSLQoTbmV3X3Blcl9kYXlfbWluaW11bRgj'
    'IAEoDVIQbmV3UGVyRGF5TWluaW11bRIhCgxpbml0aWFsX2Vhc2UYCyABKAJSC2luaXRpYWxFYX'
    'NlEicKD2Vhc3lfbXVsdGlwbGllchgMIAEoAlIOZWFzeU11bHRpcGxpZXISJwoPaGFyZF9tdWx0'
    'aXBsaWVyGA0gASgCUg5oYXJkTXVsdGlwbGllchIpChBsYXBzZV9tdWx0aXBsaWVyGA4gASgCUg'
    '9sYXBzZU11bHRpcGxpZXISLwoTaW50ZXJ2YWxfbXVsdGlwbGllchgPIAEoAlISaW50ZXJ2YWxN'
    'dWx0aXBsaWVyEjYKF21heGltdW1fcmV2aWV3X2ludGVydmFsGBAgASgNUhVtYXhpbXVtUmV2aW'
    'V3SW50ZXJ2YWwSNAoWbWluaW11bV9sYXBzZV9pbnRlcnZhbBgRIAEoDVIUbWluaW11bUxhcHNl'
    'SW50ZXJ2YWwSOAoYZ3JhZHVhdGluZ19pbnRlcnZhbF9nb29kGBIgASgNUhZncmFkdWF0aW5nSW'
    '50ZXJ2YWxHb29kEjgKGGdyYWR1YXRpbmdfaW50ZXJ2YWxfZWFzeRgTIAEoDVIWZ3JhZHVhdGlu'
    'Z0ludGVydmFsRWFzeRJpChVuZXdfY2FyZF9pbnNlcnRfb3JkZXIYFCABKA4yNi5hbmtpLmRlY2'
    'tfY29uZmlnLkRlY2tDb25maWcuQ29uZmlnLk5ld0NhcmRJbnNlcnRPcmRlclISbmV3Q2FyZElu'
    'c2VydE9yZGVyEnIKGG5ld19jYXJkX2dhdGhlcl9wcmlvcml0eRgiIAEoDjI5LmFua2kuZGVja1'
    '9jb25maWcuRGVja0NvbmZpZy5Db25maWcuTmV3Q2FyZEdhdGhlclByaW9yaXR5UhVuZXdDYXJk'
    'R2F0aGVyUHJpb3JpdHkSYwoTbmV3X2NhcmRfc29ydF9vcmRlchggIAEoDjI0LmFua2kuZGVja1'
    '9jb25maWcuRGVja0NvbmZpZy5Db25maWcuTmV3Q2FyZFNvcnRPcmRlclIQbmV3Q2FyZFNvcnRP'
    'cmRlchJGCgduZXdfbWl4GB4gASgOMi0uYW5raS5kZWNrX2NvbmZpZy5EZWNrQ29uZmlnLkNvbm'
    'ZpZy5SZXZpZXdNaXhSBm5ld01peBJWCgxyZXZpZXdfb3JkZXIYISABKA4yMy5hbmtpLmRlY2tf'
    'Y29uZmlnLkRlY2tDb25maWcuQ29uZmlnLlJldmlld0NhcmRPcmRlclILcmV2aWV3T3JkZXISYQ'
    'oVaW50ZXJkYXlfbGVhcm5pbmdfbWl4GB8gASgOMi0uYW5raS5kZWNrX2NvbmZpZy5EZWNrQ29u'
    'ZmlnLkNvbmZpZy5SZXZpZXdNaXhSE2ludGVyZGF5TGVhcm5pbmdNaXgSUgoMbGVlY2hfYWN0aW'
    '9uGBUgASgOMi8uYW5raS5kZWNrX2NvbmZpZy5EZWNrQ29uZmlnLkNvbmZpZy5MZWVjaEFjdGlv'
    'blILbGVlY2hBY3Rpb24SJwoPbGVlY2hfdGhyZXNob2xkGBYgASgNUg5sZWVjaFRocmVzaG9sZB'
    'IpChBkaXNhYmxlX2F1dG9wbGF5GBcgASgIUg9kaXNhYmxlQXV0b3BsYXkSNAoXY2FwX2Fuc3dl'
    'cl90aW1lX3RvX3NlY3MYGCABKA1SE2NhcEFuc3dlclRpbWVUb1NlY3MSHQoKc2hvd190aW1lch'
    'gZIAEoCFIJc2hvd1RpbWVyEi8KFHN0b3BfdGltZXJfb25fYW5zd2VyGCYgASgIUhFzdG9wVGlt'
    'ZXJPbkFuc3dlchI3ChhzZWNvbmRzX3RvX3Nob3dfcXVlc3Rpb24YKSABKAJSFXNlY29uZHNUb1'
    'Nob3dRdWVzdGlvbhIzChZzZWNvbmRzX3RvX3Nob3dfYW5zd2VyGCogASgCUhNzZWNvbmRzVG9T'
    'aG93QW5zd2VyElsKD3F1ZXN0aW9uX2FjdGlvbhgkIAEoDjIyLmFua2kuZGVja19jb25maWcuRG'
    'Vja0NvbmZpZy5Db25maWcuUXVlc3Rpb25BY3Rpb25SDnF1ZXN0aW9uQWN0aW9uElUKDWFuc3dl'
    'cl9hY3Rpb24YKyABKA4yMC5hbmtpLmRlY2tfY29uZmlnLkRlY2tDb25maWcuQ29uZmlnLkFuc3'
    'dlckFjdGlvblIMYW5zd2VyQWN0aW9uEiQKDndhaXRfZm9yX2F1ZGlvGCwgASgIUgx3YWl0Rm9y'
    'QXVkaW8STAojc2tpcF9xdWVzdGlvbl93aGVuX3JlcGxheWluZ19hbnN3ZXIYGiABKAhSH3NraX'
    'BRdWVzdGlvbldoZW5SZXBsYXlpbmdBbnN3ZXISGQoIYnVyeV9uZXcYGyABKAhSB2J1cnlOZXcS'
    'IQoMYnVyeV9yZXZpZXdzGBwgASgIUgtidXJ5UmV2aWV3cxI0ChZidXJ5X2ludGVyZGF5X2xlYX'
    'JuaW5nGB0gASgIUhRidXJ5SW50ZXJkYXlMZWFybmluZxIrChFkZXNpcmVkX3JldGVudGlvbhgl'
    'IAEoAlIQZGVzaXJlZFJldGVudGlvbhI7ChppZ25vcmVfcmV2bG9nc19iZWZvcmVfZGF0ZRguIA'
    'EoCVIXaWdub3JlUmV2bG9nc0JlZm9yZURhdGUSMgoVZWFzeV9kYXlzX3BlcmNlbnRhZ2VzGAQg'
    'AygCUhNlYXN5RGF5c1BlcmNlbnRhZ2VzEjEKFGhpc3RvcmljYWxfcmV0ZW50aW9uGCggASgCUh'
    'NoaXN0b3JpY2FsUmV0ZW50aW9uEiEKDHBhcmFtX3NlYXJjaBgtIAEoCVILcGFyYW1TZWFyY2gS'
    'FQoFb3RoZXIY/wEgASgMUgVvdGhlciJVChJOZXdDYXJkSW5zZXJ0T3JkZXISHQoZTkVXX0NBUk'
    'RfSU5TRVJUX09SREVSX0RVRRAAEiAKHE5FV19DQVJEX0lOU0VSVF9PUkRFUl9SQU5ET00QASKi'
    'AgoVTmV3Q2FyZEdhdGhlclByaW9yaXR5EiEKHU5FV19DQVJEX0dBVEhFUl9QUklPUklUWV9ERU'
    'NLEAASMwovTkVXX0NBUkRfR0FUSEVSX1BSSU9SSVRZX0RFQ0tfVEhFTl9SQU5ET01fTk9URVMQ'
    'BRIsCihORVdfQ0FSRF9HQVRIRVJfUFJJT1JJVFlfTE9XRVNUX1BPU0lUSU9OEAESLQopTkVXX0'
    'NBUkRfR0FUSEVSX1BSSU9SSVRZX0hJR0hFU1RfUE9TSVRJT04QAhIpCiVORVdfQ0FSRF9HQVRI'
    'RVJfUFJJT1JJVFlfUkFORE9NX05PVEVTEAMSKQolTkVXX0NBUkRfR0FUSEVSX1BSSU9SSVRZX1'
    'JBTkRPTV9DQVJEUxAEItsBChBOZXdDYXJkU29ydE9yZGVyEiAKHE5FV19DQVJEX1NPUlRfT1JE'
    'RVJfVEVNUExBVEUQABIfChtORVdfQ0FSRF9TT1JUX09SREVSX05PX1NPUlQQARIsCihORVdfQ0'
    'FSRF9TT1JUX09SREVSX1RFTVBMQVRFX1RIRU5fUkFORE9NEAISMQotTkVXX0NBUkRfU09SVF9P'
    'UkRFUl9SQU5ET01fTk9URV9USEVOX1RFTVBMQVRFEAMSIwofTkVXX0NBUkRfU09SVF9PUkRFUl'
    '9SQU5ET01fQ0FSRBAEIocECg9SZXZpZXdDYXJkT3JkZXISGQoVUkVWSUVXX0NBUkRfT1JERVJf'
    'REFZEAASIwofUkVWSUVXX0NBUkRfT1JERVJfREFZX1RIRU5fREVDSxABEiMKH1JFVklFV19DQV'
    'JEX09SREVSX0RFQ0tfVEhFTl9EQVkQAhIpCiVSRVZJRVdfQ0FSRF9PUkRFUl9JTlRFUlZBTFNf'
    'QVNDRU5ESU5HEAMSKgomUkVWSUVXX0NBUkRfT1JERVJfSU5URVJWQUxTX0RFU0NFTkRJTkcQBB'
    'IkCiBSRVZJRVdfQ0FSRF9PUkRFUl9FQVNFX0FTQ0VORElORxAFEiUKIVJFVklFV19DQVJEX09S'
    'REVSX0VBU0VfREVTQ0VORElORxAGEi4KKlJFVklFV19DQVJEX09SREVSX1JFVFJJRVZBQklMSV'
    'RZX0FTQ0VORElORxAHEi8KK1JFVklFV19DQVJEX09SREVSX1JFVFJJRVZBQklMSVRZX0RFU0NF'
    'TkRJTkcQCxIqCiZSRVZJRVdfQ0FSRF9PUkRFUl9SRUxBVElWRV9PVkVSRFVFTkVTUxAMEhwKGF'
    'JFVklFV19DQVJEX09SREVSX1JBTkRPTRAIEhsKF1JFVklFV19DQVJEX09SREVSX0FEREVEEAkS'
    'IwofUkVWSUVXX0NBUkRfT1JERVJfUkVWRVJTRV9BRERFRBAKImkKCVJldmlld01peBIfChtSRV'
    'ZJRVdfTUlYX01JWF9XSVRIX1JFVklFV1MQABIcChhSRVZJRVdfTUlYX0FGVEVSX1JFVklFV1MQ'
    'ARIdChlSRVZJRVdfTUlYX0JFRk9SRV9SRVZJRVdTEAIiQgoLTGVlY2hBY3Rpb24SGAoUTEVFQ0'
    'hfQUNUSU9OX1NVU1BFTkQQABIZChVMRUVDSF9BQ1RJT05fVEFHX09OTFkQASKqAQoMQW5zd2Vy'
    'QWN0aW9uEhsKF0FOU1dFUl9BQ1RJT05fQlVSWV9DQVJEEAASHgoaQU5TV0VSX0FDVElPTl9BTl'
    'NXRVJfQUdBSU4QARIdChlBTlNXRVJfQUNUSU9OX0FOU1dFUl9HT09EEAISHQoZQU5TV0VSX0FD'
    'VElPTl9BTlNXRVJfSEFSRBADEh8KG0FOU1dFUl9BQ1RJT05fU0hPV19SRU1JTkRFUhAEIlQKDl'
    'F1ZXN0aW9uQWN0aW9uEh8KG1FVRVNUSU9OX0FDVElPTl9TSE9XX0FOU1dFUhAAEiEKHVFVRVNU'
    'SU9OX0FDVElPTl9TSE9XX1JFTUlOREVSEAFKBAgHEAlKBAgnECg=');

@$core.Deprecated('Use deckConfigsForUpdateDescriptor instead')
const DeckConfigsForUpdate$json = {
  '1': 'DeckConfigsForUpdate',
  '2': [
    {
      '1': 'all_config',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.deck_config.DeckConfigsForUpdate.ConfigWithExtra',
      '10': 'allConfig'
    },
    {
      '1': 'current_deck',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.deck_config.DeckConfigsForUpdate.CurrentDeck',
      '10': 'currentDeck'
    },
    {
      '1': 'defaults',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.deck_config.DeckConfig',
      '10': 'defaults'
    },
    {'1': 'schema_modified', '3': 4, '4': 1, '5': 8, '10': 'schemaModified'},
    {
      '1': 'card_state_customizer',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'cardStateCustomizer'
    },
    {
      '1': 'new_cards_ignore_review_limit',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'newCardsIgnoreReviewLimit'
    },
    {'1': 'fsrs', '3': 8, '4': 1, '5': 8, '10': 'fsrs'},
    {
      '1': 'fsrs_health_check',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'fsrsHealthCheck'
    },
    {
      '1': 'fsrs_legacy_evaluate',
      '3': 12,
      '4': 1,
      '5': 8,
      '10': 'fsrsLegacyEvaluate'
    },
    {
      '1': 'apply_all_parent_limits',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'applyAllParentLimits'
    },
    {
      '1': 'days_since_last_fsrs_optimize',
      '3': 10,
      '4': 1,
      '5': 13,
      '10': 'daysSinceLastFsrsOptimize'
    },
  ],
  '3': [
    DeckConfigsForUpdate_ConfigWithExtra$json,
    DeckConfigsForUpdate_CurrentDeck$json
  ],
};

@$core.Deprecated('Use deckConfigsForUpdateDescriptor instead')
const DeckConfigsForUpdate_ConfigWithExtra$json = {
  '1': 'ConfigWithExtra',
  '2': [
    {
      '1': 'config',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.deck_config.DeckConfig',
      '10': 'config'
    },
    {'1': 'use_count', '3': 2, '4': 1, '5': 13, '10': 'useCount'},
  ],
};

@$core.Deprecated('Use deckConfigsForUpdateDescriptor instead')
const DeckConfigsForUpdate_CurrentDeck$json = {
  '1': 'CurrentDeck',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'config_id', '3': 2, '4': 1, '5': 3, '10': 'configId'},
    {'1': 'parent_config_ids', '3': 3, '4': 3, '5': 3, '10': 'parentConfigIds'},
    {
      '1': 'limits',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.deck_config.DeckConfigsForUpdate.CurrentDeck.Limits',
      '10': 'limits'
    },
  ],
  '3': [DeckConfigsForUpdate_CurrentDeck_Limits$json],
};

@$core.Deprecated('Use deckConfigsForUpdateDescriptor instead')
const DeckConfigsForUpdate_CurrentDeck_Limits$json = {
  '1': 'Limits',
  '2': [
    {
      '1': 'review',
      '3': 1,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'review',
      '17': true
    },
    {'1': 'new', '3': 2, '4': 1, '5': 13, '9': 1, '10': 'new', '17': true},
    {
      '1': 'review_today',
      '3': 3,
      '4': 1,
      '5': 13,
      '9': 2,
      '10': 'reviewToday',
      '17': true
    },
    {
      '1': 'new_today',
      '3': 4,
      '4': 1,
      '5': 13,
      '9': 3,
      '10': 'newToday',
      '17': true
    },
    {
      '1': 'review_today_active',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'reviewTodayActive'
    },
    {'1': 'new_today_active', '3': 6, '4': 1, '5': 8, '10': 'newTodayActive'},
    {
      '1': 'desired_retention',
      '3': 7,
      '4': 1,
      '5': 2,
      '9': 4,
      '10': 'desiredRetention',
      '17': true
    },
  ],
  '8': [
    {'1': '_review'},
    {'1': '_new'},
    {'1': '_review_today'},
    {'1': '_new_today'},
    {'1': '_desired_retention'},
  ],
};

/// Descriptor for `DeckConfigsForUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deckConfigsForUpdateDescriptor = $convert.base64Decode(
    'ChREZWNrQ29uZmlnc0ZvclVwZGF0ZRJVCgphbGxfY29uZmlnGAEgAygLMjYuYW5raS5kZWNrX2'
    'NvbmZpZy5EZWNrQ29uZmlnc0ZvclVwZGF0ZS5Db25maWdXaXRoRXh0cmFSCWFsbENvbmZpZxJV'
    'CgxjdXJyZW50X2RlY2sYAiABKAsyMi5hbmtpLmRlY2tfY29uZmlnLkRlY2tDb25maWdzRm9yVX'
    'BkYXRlLkN1cnJlbnREZWNrUgtjdXJyZW50RGVjaxI4CghkZWZhdWx0cxgDIAEoCzIcLmFua2ku'
    'ZGVja19jb25maWcuRGVja0NvbmZpZ1IIZGVmYXVsdHMSJwoPc2NoZW1hX21vZGlmaWVkGAQgAS'
    'gIUg5zY2hlbWFNb2RpZmllZBIyChVjYXJkX3N0YXRlX2N1c3RvbWl6ZXIYBiABKAlSE2NhcmRT'
    'dGF0ZUN1c3RvbWl6ZXISQAodbmV3X2NhcmRzX2lnbm9yZV9yZXZpZXdfbGltaXQYByABKAhSGW'
    '5ld0NhcmRzSWdub3JlUmV2aWV3TGltaXQSEgoEZnNycxgIIAEoCFIEZnNycxIqChFmc3JzX2hl'
    'YWx0aF9jaGVjaxgLIAEoCFIPZnNyc0hlYWx0aENoZWNrEjAKFGZzcnNfbGVnYWN5X2V2YWx1YX'
    'RlGAwgASgIUhJmc3JzTGVnYWN5RXZhbHVhdGUSNQoXYXBwbHlfYWxsX3BhcmVudF9saW1pdHMY'
    'CSABKAhSFGFwcGx5QWxsUGFyZW50TGltaXRzEkAKHWRheXNfc2luY2VfbGFzdF9mc3JzX29wdG'
    'ltaXplGAogASgNUhlkYXlzU2luY2VMYXN0RnNyc09wdGltaXplGmQKD0NvbmZpZ1dpdGhFeHRy'
    'YRI0CgZjb25maWcYASABKAsyHC5hbmtpLmRlY2tfY29uZmlnLkRlY2tDb25maWdSBmNvbmZpZx'
    'IbCgl1c2VfY291bnQYAiABKA1SCHVzZUNvdW50GpoECgtDdXJyZW50RGVjaxISCgRuYW1lGAEg'
    'ASgJUgRuYW1lEhsKCWNvbmZpZ19pZBgCIAEoA1IIY29uZmlnSWQSKgoRcGFyZW50X2NvbmZpZ1'
    '9pZHMYAyADKANSD3BhcmVudENvbmZpZ0lkcxJRCgZsaW1pdHMYBCABKAsyOS5hbmtpLmRlY2tf'
    'Y29uZmlnLkRlY2tDb25maWdzRm9yVXBkYXRlLkN1cnJlbnREZWNrLkxpbWl0c1IGbGltaXRzGt'
    'oCCgZMaW1pdHMSGwoGcmV2aWV3GAEgASgNSABSBnJldmlld4gBARIVCgNuZXcYAiABKA1IAVID'
    'bmV3iAEBEiYKDHJldmlld190b2RheRgDIAEoDUgCUgtyZXZpZXdUb2RheYgBARIgCgluZXdfdG'
    '9kYXkYBCABKA1IA1IIbmV3VG9kYXmIAQESLgoTcmV2aWV3X3RvZGF5X2FjdGl2ZRgFIAEoCFIR'
    'cmV2aWV3VG9kYXlBY3RpdmUSKAoQbmV3X3RvZGF5X2FjdGl2ZRgGIAEoCFIObmV3VG9kYXlBY3'
    'RpdmUSMAoRZGVzaXJlZF9yZXRlbnRpb24YByABKAJIBFIQZGVzaXJlZFJldGVudGlvbogBAUIJ'
    'CgdfcmV2aWV3QgYKBF9uZXdCDwoNX3Jldmlld190b2RheUIMCgpfbmV3X3RvZGF5QhQKEl9kZX'
    'NpcmVkX3JldGVudGlvbg==');

@$core.Deprecated('Use updateDeckConfigsRequestDescriptor instead')
const UpdateDeckConfigsRequest$json = {
  '1': 'UpdateDeckConfigsRequest',
  '2': [
    {'1': 'target_deck_id', '3': 1, '4': 1, '5': 3, '10': 'targetDeckId'},
    {
      '1': 'configs',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.deck_config.DeckConfig',
      '10': 'configs'
    },
    {
      '1': 'removed_config_ids',
      '3': 3,
      '4': 3,
      '5': 3,
      '10': 'removedConfigIds'
    },
    {
      '1': 'mode',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.anki.deck_config.UpdateDeckConfigsMode',
      '10': 'mode'
    },
    {
      '1': 'card_state_customizer',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'cardStateCustomizer'
    },
    {
      '1': 'limits',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.anki.deck_config.DeckConfigsForUpdate.CurrentDeck.Limits',
      '10': 'limits'
    },
    {
      '1': 'new_cards_ignore_review_limit',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'newCardsIgnoreReviewLimit'
    },
    {'1': 'fsrs', '3': 8, '4': 1, '5': 8, '10': 'fsrs'},
    {
      '1': 'apply_all_parent_limits',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'applyAllParentLimits'
    },
    {'1': 'fsrs_reschedule', '3': 10, '4': 1, '5': 8, '10': 'fsrsReschedule'},
    {
      '1': 'fsrs_health_check',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'fsrsHealthCheck'
    },
  ],
};

/// Descriptor for `UpdateDeckConfigsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDeckConfigsRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVEZWNrQ29uZmlnc1JlcXVlc3QSJAoOdGFyZ2V0X2RlY2tfaWQYASABKANSDHRhcm'
    'dldERlY2tJZBI2Cgdjb25maWdzGAIgAygLMhwuYW5raS5kZWNrX2NvbmZpZy5EZWNrQ29uZmln'
    'Ugdjb25maWdzEiwKEnJlbW92ZWRfY29uZmlnX2lkcxgDIAMoA1IQcmVtb3ZlZENvbmZpZ0lkcx'
    'I7CgRtb2RlGAQgASgOMicuYW5raS5kZWNrX2NvbmZpZy5VcGRhdGVEZWNrQ29uZmlnc01vZGVS'
    'BG1vZGUSMgoVY2FyZF9zdGF0ZV9jdXN0b21pemVyGAUgASgJUhNjYXJkU3RhdGVDdXN0b21pem'
    'VyElEKBmxpbWl0cxgGIAEoCzI5LmFua2kuZGVja19jb25maWcuRGVja0NvbmZpZ3NGb3JVcGRh'
    'dGUuQ3VycmVudERlY2suTGltaXRzUgZsaW1pdHMSQAodbmV3X2NhcmRzX2lnbm9yZV9yZXZpZX'
    'dfbGltaXQYByABKAhSGW5ld0NhcmRzSWdub3JlUmV2aWV3TGltaXQSEgoEZnNycxgIIAEoCFIE'
    'ZnNycxI1ChdhcHBseV9hbGxfcGFyZW50X2xpbWl0cxgJIAEoCFIUYXBwbHlBbGxQYXJlbnRMaW'
    '1pdHMSJwoPZnNyc19yZXNjaGVkdWxlGAogASgIUg5mc3JzUmVzY2hlZHVsZRIqChFmc3JzX2hl'
    'YWx0aF9jaGVjaxgLIAEoCFIPZnNyc0hlYWx0aENoZWNr');

const $core.Map<$core.String, $core.dynamic> DeckConfigServiceBase$json = {
  '1': 'DeckConfigService',
  '2': [
    {
      '1': 'AddOrUpdateDeckConfigLegacy',
      '2': '.anki.generic.Json',
      '3': '.anki.deck_config.DeckConfigId'
    },
    {
      '1': 'GetDeckConfig',
      '2': '.anki.deck_config.DeckConfigId',
      '3': '.anki.deck_config.DeckConfig'
    },
    {
      '1': 'AllDeckConfigLegacy',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'GetDeckConfigLegacy',
      '2': '.anki.deck_config.DeckConfigId',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'NewDeckConfigLegacy',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'RemoveDeckConfig',
      '2': '.anki.deck_config.DeckConfigId',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'GetDeckConfigsForUpdate',
      '2': '.anki.decks.DeckId',
      '3': '.anki.deck_config.DeckConfigsForUpdate'
    },
    {
      '1': 'UpdateDeckConfigs',
      '2': '.anki.deck_config.UpdateDeckConfigsRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetIgnoredBeforeCount',
      '2': '.anki.deck_config.GetIgnoredBeforeCountRequest',
      '3': '.anki.deck_config.GetIgnoredBeforeCountResponse'
    },
    {
      '1': 'GetRetentionWorkload',
      '2': '.anki.deck_config.GetRetentionWorkloadRequest',
      '3': '.anki.deck_config.GetRetentionWorkloadResponse'
    },
  ],
};

@$core.Deprecated('Use deckConfigServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    DeckConfigServiceBase$messageJson = {
  '.anki.generic.Json': $0.Json$json,
  '.anki.deck_config.DeckConfigId': DeckConfigId$json,
  '.anki.deck_config.DeckConfig': DeckConfig$json,
  '.anki.deck_config.DeckConfig.Config': DeckConfig_Config$json,
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.decks.DeckId': $1.DeckId$json,
  '.anki.deck_config.DeckConfigsForUpdate': DeckConfigsForUpdate$json,
  '.anki.deck_config.DeckConfigsForUpdate.ConfigWithExtra':
      DeckConfigsForUpdate_ConfigWithExtra$json,
  '.anki.deck_config.DeckConfigsForUpdate.CurrentDeck':
      DeckConfigsForUpdate_CurrentDeck$json,
  '.anki.deck_config.DeckConfigsForUpdate.CurrentDeck.Limits':
      DeckConfigsForUpdate_CurrentDeck_Limits$json,
  '.anki.deck_config.UpdateDeckConfigsRequest': UpdateDeckConfigsRequest$json,
  '.anki.collection.OpChanges': $2.OpChanges$json,
  '.anki.deck_config.GetIgnoredBeforeCountRequest':
      GetIgnoredBeforeCountRequest$json,
  '.anki.deck_config.GetIgnoredBeforeCountResponse':
      GetIgnoredBeforeCountResponse$json,
  '.anki.deck_config.GetRetentionWorkloadRequest':
      GetRetentionWorkloadRequest$json,
  '.anki.deck_config.GetRetentionWorkloadResponse':
      GetRetentionWorkloadResponse$json,
  '.anki.deck_config.GetRetentionWorkloadResponse.CostsEntry':
      GetRetentionWorkloadResponse_CostsEntry$json,
};

/// Descriptor for `DeckConfigService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List deckConfigServiceDescriptor = $convert.base64Decode(
    'ChFEZWNrQ29uZmlnU2VydmljZRJRChtBZGRPclVwZGF0ZURlY2tDb25maWdMZWdhY3kSEi5hbm'
    'tpLmdlbmVyaWMuSnNvbhoeLmFua2kuZGVja19jb25maWcuRGVja0NvbmZpZ0lkEk0KDUdldERl'
    'Y2tDb25maWcSHi5hbmtpLmRlY2tfY29uZmlnLkRlY2tDb25maWdJZBocLmFua2kuZGVja19jb2'
    '5maWcuRGVja0NvbmZpZxI+ChNBbGxEZWNrQ29uZmlnTGVnYWN5EhMuYW5raS5nZW5lcmljLkVt'
    'cHR5GhIuYW5raS5nZW5lcmljLkpzb24SSQoTR2V0RGVja0NvbmZpZ0xlZ2FjeRIeLmFua2kuZG'
    'Vja19jb25maWcuRGVja0NvbmZpZ0lkGhIuYW5raS5nZW5lcmljLkpzb24SPgoTTmV3RGVja0Nv'
    'bmZpZ0xlZ2FjeRITLmFua2kuZ2VuZXJpYy5FbXB0eRoSLmFua2kuZ2VuZXJpYy5Kc29uEkcKEF'
    'JlbW92ZURlY2tDb25maWcSHi5hbmtpLmRlY2tfY29uZmlnLkRlY2tDb25maWdJZBoTLmFua2ku'
    'Z2VuZXJpYy5FbXB0eRJVChdHZXREZWNrQ29uZmlnc0ZvclVwZGF0ZRISLmFua2kuZGVja3MuRG'
    'Vja0lkGiYuYW5raS5kZWNrX2NvbmZpZy5EZWNrQ29uZmlnc0ZvclVwZGF0ZRJbChFVcGRhdGVE'
    'ZWNrQ29uZmlncxIqLmFua2kuZGVja19jb25maWcuVXBkYXRlRGVja0NvbmZpZ3NSZXF1ZXN0Gh'
    'ouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcxJ4ChVHZXRJZ25vcmVkQmVmb3JlQ291bnQSLi5h'
    'bmtpLmRlY2tfY29uZmlnLkdldElnbm9yZWRCZWZvcmVDb3VudFJlcXVlc3QaLy5hbmtpLmRlY2'
    'tfY29uZmlnLkdldElnbm9yZWRCZWZvcmVDb3VudFJlc3BvbnNlEnUKFEdldFJldGVudGlvbldv'
    'cmtsb2FkEi0uYW5raS5kZWNrX2NvbmZpZy5HZXRSZXRlbnRpb25Xb3JrbG9hZFJlcXVlc3QaLi'
    '5hbmtpLmRlY2tfY29uZmlnLkdldFJldGVudGlvbldvcmtsb2FkUmVzcG9uc2U=');

const $core.Map<$core.String, $core.dynamic> BackendDeckConfigServiceBase$json =
    {'1': 'BackendDeckConfigService'};

@$core.Deprecated('Use backendDeckConfigServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendDeckConfigServiceBase$messageJson = {};

/// Descriptor for `BackendDeckConfigService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendDeckConfigServiceDescriptor =
    $convert.base64Decode('ChhCYWNrZW5kRGVja0NvbmZpZ1NlcnZpY2U=');
