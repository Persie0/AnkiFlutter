// This is a generated file - do not edit.
//
// Generated from anki/config.proto.

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

@$core.Deprecated('Use experimentalFeatureFlagDescriptor instead')
const ExperimentalFeatureFlag$json = {
  '1': 'ExperimentalFeatureFlag',
  '2': [
    {'1': 'TEST_FLAG', '2': 0},
    {'1': 'SVELTE_EDITOR', '2': 1},
    {'1': 'SVELTE_REVIEWER', '2': 2},
  ],
};

/// Descriptor for `ExperimentalFeatureFlag`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List experimentalFeatureFlagDescriptor =
    $convert.base64Decode(
        'ChdFeHBlcmltZW50YWxGZWF0dXJlRmxhZxINCglURVNUX0ZMQUcQABIRCg1TVkVMVEVfRURJVE'
        '9SEAESEwoPU1ZFTFRFX1JFVklFV0VSEAI=');

@$core.Deprecated('Use configKeyDescriptor instead')
const ConfigKey$json = {
  '1': 'ConfigKey',
  '4': [ConfigKey_Bool$json, ConfigKey_String$json],
};

@$core.Deprecated('Use configKeyDescriptor instead')
const ConfigKey_Bool$json = {
  '1': 'Bool',
  '2': [
    {'1': 'BROWSER_TABLE_SHOW_NOTES_MODE', '2': 0},
    {'1': 'PREVIEW_BOTH_SIDES', '2': 3},
    {'1': 'COLLAPSE_TAGS', '2': 4},
    {'1': 'COLLAPSE_NOTETYPES', '2': 5},
    {'1': 'COLLAPSE_DECKS', '2': 6},
    {'1': 'COLLAPSE_SAVED_SEARCHES', '2': 7},
    {'1': 'COLLAPSE_TODAY', '2': 8},
    {'1': 'COLLAPSE_CARD_STATE', '2': 9},
    {'1': 'COLLAPSE_FLAGS', '2': 10},
    {'1': 'SCHED_2021', '2': 11},
    {'1': 'ADDING_DEFAULTS_TO_CURRENT_DECK', '2': 12},
    {'1': 'HIDE_AUDIO_PLAY_BUTTONS', '2': 13},
    {'1': 'INTERRUPT_AUDIO_WHEN_ANSWERING', '2': 14},
    {'1': 'PASTE_IMAGES_AS_PNG', '2': 15},
    {'1': 'PASTE_STRIPS_FORMATTING', '2': 16},
    {'1': 'NORMALIZE_NOTE_TEXT', '2': 17},
    {'1': 'IGNORE_ACCENTS_IN_SEARCH', '2': 18},
    {'1': 'RESTORE_POSITION_BROWSER', '2': 19},
    {'1': 'RESTORE_POSITION_REVIEWER', '2': 20},
    {'1': 'RESET_COUNTS_BROWSER', '2': 21},
    {'1': 'RESET_COUNTS_REVIEWER', '2': 22},
    {'1': 'RANDOM_ORDER_REPOSITION', '2': 23},
    {'1': 'SHIFT_POSITION_OF_EXISTING_CARDS', '2': 24},
    {'1': 'RENDER_LATEX', '2': 25},
    {'1': 'LOAD_BALANCER_ENABLED', '2': 26},
    {'1': 'FSRS_SHORT_TERM_WITH_STEPS_ENABLED', '2': 27},
    {'1': 'FSRS_LEGACY_EVALUATE', '2': 28},
  ],
};

@$core.Deprecated('Use configKeyDescriptor instead')
const ConfigKey_String$json = {
  '1': 'String',
  '2': [
    {'1': 'SET_DUE_BROWSER', '2': 0},
    {'1': 'SET_DUE_REVIEWER', '2': 1},
    {'1': 'DEFAULT_SEARCH_TEXT', '2': 2},
    {'1': 'CARD_STATE_CUSTOMIZER', '2': 3},
  ],
};

/// Descriptor for `ConfigKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List configKeyDescriptor = $convert.base64Decode(
    'CglDb25maWdLZXki5QUKBEJvb2wSIQodQlJPV1NFUl9UQUJMRV9TSE9XX05PVEVTX01PREUQAB'
    'IWChJQUkVWSUVXX0JPVEhfU0lERVMQAxIRCg1DT0xMQVBTRV9UQUdTEAQSFgoSQ09MTEFQU0Vf'
    'Tk9URVRZUEVTEAUSEgoOQ09MTEFQU0VfREVDS1MQBhIbChdDT0xMQVBTRV9TQVZFRF9TRUFSQ0'
    'hFUxAHEhIKDkNPTExBUFNFX1RPREFZEAgSFwoTQ09MTEFQU0VfQ0FSRF9TVEFURRAJEhIKDkNP'
    'TExBUFNFX0ZMQUdTEAoSDgoKU0NIRURfMjAyMRALEiMKH0FERElOR19ERUZBVUxUU19UT19DVV'
    'JSRU5UX0RFQ0sQDBIbChdISURFX0FVRElPX1BMQVlfQlVUVE9OUxANEiIKHklOVEVSUlVQVF9B'
    'VURJT19XSEVOX0FOU1dFUklORxAOEhcKE1BBU1RFX0lNQUdFU19BU19QTkcQDxIbChdQQVNURV'
    '9TVFJJUFNfRk9STUFUVElORxAQEhcKE05PUk1BTElaRV9OT1RFX1RFWFQQERIcChhJR05PUkVf'
    'QUNDRU5UU19JTl9TRUFSQ0gQEhIcChhSRVNUT1JFX1BPU0lUSU9OX0JST1dTRVIQExIdChlSRV'
    'NUT1JFX1BPU0lUSU9OX1JFVklFV0VSEBQSGAoUUkVTRVRfQ09VTlRTX0JST1dTRVIQFRIZChVS'
    'RVNFVF9DT1VOVFNfUkVWSUVXRVIQFhIbChdSQU5ET01fT1JERVJfUkVQT1NJVElPThAXEiQKIF'
    'NISUZUX1BPU0lUSU9OX09GX0VYSVNUSU5HX0NBUkRTEBgSEAoMUkVOREVSX0xBVEVYEBkSGQoV'
    'TE9BRF9CQUxBTkNFUl9FTkFCTEVEEBoSJgoiRlNSU19TSE9SVF9URVJNX1dJVEhfU1RFUFNfRU'
    '5BQkxFRBAbEhgKFEZTUlNfTEVHQUNZX0VWQUxVQVRFEBwiZwoGU3RyaW5nEhMKD1NFVF9EVUVf'
    'QlJPV1NFUhAAEhQKEFNFVF9EVUVfUkVWSUVXRVIQARIXChNERUZBVUxUX1NFQVJDSF9URVhUEA'
    'ISGQoVQ0FSRF9TVEFURV9DVVNUT01JWkVSEAM=');

@$core.Deprecated('Use getConfigBoolRequestDescriptor instead')
const GetConfigBoolRequest$json = {
  '1': 'GetConfigBoolRequest',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.config.ConfigKey.Bool',
      '10': 'key'
    },
  ],
};

/// Descriptor for `GetConfigBoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConfigBoolRequestDescriptor = $convert.base64Decode(
    'ChRHZXRDb25maWdCb29sUmVxdWVzdBItCgNrZXkYASABKA4yGy5hbmtpLmNvbmZpZy5Db25maW'
    'dLZXkuQm9vbFIDa2V5');

@$core.Deprecated('Use setConfigBoolRequestDescriptor instead')
const SetConfigBoolRequest$json = {
  '1': 'SetConfigBoolRequest',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.config.ConfigKey.Bool',
      '10': 'key'
    },
    {'1': 'value', '3': 2, '4': 1, '5': 8, '10': 'value'},
    {'1': 'undoable', '3': 3, '4': 1, '5': 8, '10': 'undoable'},
  ],
};

/// Descriptor for `SetConfigBoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setConfigBoolRequestDescriptor = $convert.base64Decode(
    'ChRTZXRDb25maWdCb29sUmVxdWVzdBItCgNrZXkYASABKA4yGy5hbmtpLmNvbmZpZy5Db25maW'
    'dLZXkuQm9vbFIDa2V5EhQKBXZhbHVlGAIgASgIUgV2YWx1ZRIaCgh1bmRvYWJsZRgDIAEoCFII'
    'dW5kb2FibGU=');

@$core.Deprecated('Use getConfigStringRequestDescriptor instead')
const GetConfigStringRequest$json = {
  '1': 'GetConfigStringRequest',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.config.ConfigKey.String',
      '10': 'key'
    },
  ],
};

/// Descriptor for `GetConfigStringRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConfigStringRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRDb25maWdTdHJpbmdSZXF1ZXN0Ei8KA2tleRgBIAEoDjIdLmFua2kuY29uZmlnLkNvbm'
        'ZpZ0tleS5TdHJpbmdSA2tleQ==');

@$core.Deprecated('Use setConfigStringRequestDescriptor instead')
const SetConfigStringRequest$json = {
  '1': 'SetConfigStringRequest',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.config.ConfigKey.String',
      '10': 'key'
    },
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
    {'1': 'undoable', '3': 3, '4': 1, '5': 8, '10': 'undoable'},
  ],
};

/// Descriptor for `SetConfigStringRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setConfigStringRequestDescriptor = $convert.base64Decode(
    'ChZTZXRDb25maWdTdHJpbmdSZXF1ZXN0Ei8KA2tleRgBIAEoDjIdLmFua2kuY29uZmlnLkNvbm'
    'ZpZ0tleS5TdHJpbmdSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWUSGgoIdW5kb2FibGUYAyAB'
    'KAhSCHVuZG9hYmxl');

@$core.Deprecated('Use optionalStringConfigKeyDescriptor instead')
const OptionalStringConfigKey$json = {
  '1': 'OptionalStringConfigKey',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.config.ConfigKey.String',
      '10': 'key'
    },
  ],
};

/// Descriptor for `OptionalStringConfigKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List optionalStringConfigKeyDescriptor =
    $convert.base64Decode(
        'ChdPcHRpb25hbFN0cmluZ0NvbmZpZ0tleRIvCgNrZXkYASABKA4yHS5hbmtpLmNvbmZpZy5Db2'
        '5maWdLZXkuU3RyaW5nUgNrZXk=');

@$core.Deprecated('Use setConfigJsonRequestDescriptor instead')
const SetConfigJsonRequest$json = {
  '1': 'SetConfigJsonRequest',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value_json', '3': 2, '4': 1, '5': 12, '10': 'valueJson'},
    {'1': 'undoable', '3': 3, '4': 1, '5': 8, '10': 'undoable'},
  ],
};

/// Descriptor for `SetConfigJsonRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setConfigJsonRequestDescriptor = $convert.base64Decode(
    'ChRTZXRDb25maWdKc29uUmVxdWVzdBIQCgNrZXkYASABKAlSA2tleRIdCgp2YWx1ZV9qc29uGA'
    'IgASgMUgl2YWx1ZUpzb24SGgoIdW5kb2FibGUYAyABKAhSCHVuZG9hYmxl');

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences$json = {
  '1': 'Preferences',
  '2': [
    {
      '1': 'scheduling',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.config.Preferences.Scheduling',
      '10': 'scheduling'
    },
    {
      '1': 'reviewing',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.config.Preferences.Reviewing',
      '10': 'reviewing'
    },
    {
      '1': 'editing',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.config.Preferences.Editing',
      '10': 'editing'
    },
    {
      '1': 'backups',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.config.Preferences.BackupLimits',
      '10': 'backups'
    },
  ],
  '3': [
    Preferences_Scheduling$json,
    Preferences_Reviewing$json,
    Preferences_Editing$json,
    Preferences_BackupLimits$json
  ],
};

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences_Scheduling$json = {
  '1': 'Scheduling',
  '2': [
    {'1': 'rollover', '3': 2, '4': 1, '5': 13, '10': 'rollover'},
    {'1': 'learn_ahead_secs', '3': 3, '4': 1, '5': 13, '10': 'learnAheadSecs'},
    {
      '1': 'new_review_mix',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.anki.config.Preferences.Scheduling.NewReviewMix',
      '10': 'newReviewMix'
    },
    {'1': 'new_timezone', '3': 5, '4': 1, '5': 8, '10': 'newTimezone'},
    {'1': 'day_learn_first', '3': 6, '4': 1, '5': 8, '10': 'dayLearnFirst'},
  ],
  '4': [Preferences_Scheduling_NewReviewMix$json],
};

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences_Scheduling_NewReviewMix$json = {
  '1': 'NewReviewMix',
  '2': [
    {'1': 'DISTRIBUTE', '2': 0},
    {'1': 'REVIEWS_FIRST', '2': 1},
    {'1': 'NEW_FIRST', '2': 2},
  ],
};

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences_Reviewing$json = {
  '1': 'Reviewing',
  '2': [
    {
      '1': 'hide_audio_play_buttons',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'hideAudioPlayButtons'
    },
    {
      '1': 'interrupt_audio_when_answering',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'interruptAudioWhenAnswering'
    },
    {
      '1': 'show_remaining_due_counts',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'showRemainingDueCounts'
    },
    {
      '1': 'show_intervals_on_buttons',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'showIntervalsOnButtons'
    },
    {'1': 'time_limit_secs', '3': 5, '4': 1, '5': 13, '10': 'timeLimitSecs'},
    {
      '1': 'load_balancer_enabled',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'loadBalancerEnabled'
    },
    {
      '1': 'fsrs_short_term_with_steps_enabled',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'fsrsShortTermWithStepsEnabled'
    },
  ],
};

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences_Editing$json = {
  '1': 'Editing',
  '2': [
    {
      '1': 'adding_defaults_to_current_deck',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'addingDefaultsToCurrentDeck'
    },
    {
      '1': 'paste_images_as_png',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'pasteImagesAsPng'
    },
    {
      '1': 'paste_strips_formatting',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'pasteStripsFormatting'
    },
    {
      '1': 'default_search_text',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'defaultSearchText'
    },
    {
      '1': 'ignore_accents_in_search',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'ignoreAccentsInSearch'
    },
    {'1': 'render_latex', '3': 6, '4': 1, '5': 8, '10': 'renderLatex'},
  ],
};

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences_BackupLimits$json = {
  '1': 'BackupLimits',
  '2': [
    {'1': 'daily', '3': 1, '4': 1, '5': 13, '10': 'daily'},
    {'1': 'weekly', '3': 2, '4': 1, '5': 13, '10': 'weekly'},
    {'1': 'monthly', '3': 3, '4': 1, '5': 13, '10': 'monthly'},
    {
      '1': 'minimum_interval_mins',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'minimumIntervalMins'
    },
  ],
};

/// Descriptor for `Preferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preferencesDescriptor = $convert.base64Decode(
    'CgtQcmVmZXJlbmNlcxJDCgpzY2hlZHVsaW5nGAEgASgLMiMuYW5raS5jb25maWcuUHJlZmVyZW'
    '5jZXMuU2NoZWR1bGluZ1IKc2NoZWR1bGluZxJACglyZXZpZXdpbmcYAiABKAsyIi5hbmtpLmNv'
    'bmZpZy5QcmVmZXJlbmNlcy5SZXZpZXdpbmdSCXJldmlld2luZxI6CgdlZGl0aW5nGAMgASgLMi'
    'AuYW5raS5jb25maWcuUHJlZmVyZW5jZXMuRWRpdGluZ1IHZWRpdGluZxI/CgdiYWNrdXBzGAQg'
    'ASgLMiUuYW5raS5jb25maWcuUHJlZmVyZW5jZXMuQmFja3VwTGltaXRzUgdiYWNrdXBzGrcCCg'
    'pTY2hlZHVsaW5nEhoKCHJvbGxvdmVyGAIgASgNUghyb2xsb3ZlchIoChBsZWFybl9haGVhZF9z'
    'ZWNzGAMgASgNUg5sZWFybkFoZWFkU2VjcxJWCg5uZXdfcmV2aWV3X21peBgEIAEoDjIwLmFua2'
    'kuY29uZmlnLlByZWZlcmVuY2VzLlNjaGVkdWxpbmcuTmV3UmV2aWV3TWl4UgxuZXdSZXZpZXdN'
    'aXgSIQoMbmV3X3RpbWV6b25lGAUgASgIUgtuZXdUaW1lem9uZRImCg9kYXlfbGVhcm5fZmlyc3'
    'QYBiABKAhSDWRheUxlYXJuRmlyc3QiQAoMTmV3UmV2aWV3TWl4Eg4KCkRJU1RSSUJVVEUQABIR'
    'Cg1SRVZJRVdTX0ZJUlNUEAESDQoJTkVXX0ZJUlNUEAIapAMKCVJldmlld2luZxI1ChdoaWRlX2'
    'F1ZGlvX3BsYXlfYnV0dG9ucxgBIAEoCFIUaGlkZUF1ZGlvUGxheUJ1dHRvbnMSQwoeaW50ZXJy'
    'dXB0X2F1ZGlvX3doZW5fYW5zd2VyaW5nGAIgASgIUhtpbnRlcnJ1cHRBdWRpb1doZW5BbnN3ZX'
    'JpbmcSOQoZc2hvd19yZW1haW5pbmdfZHVlX2NvdW50cxgDIAEoCFIWc2hvd1JlbWFpbmluZ0R1'
    'ZUNvdW50cxI5ChlzaG93X2ludGVydmFsc19vbl9idXR0b25zGAQgASgIUhZzaG93SW50ZXJ2YW'
    'xzT25CdXR0b25zEiYKD3RpbWVfbGltaXRfc2VjcxgFIAEoDVINdGltZUxpbWl0U2VjcxIyChVs'
    'b2FkX2JhbGFuY2VyX2VuYWJsZWQYBiABKAhSE2xvYWRCYWxhbmNlckVuYWJsZWQSSQoiZnNyc1'
    '9zaG9ydF90ZXJtX3dpdGhfc3RlcHNfZW5hYmxlZBgHIAEoCFIdZnNyc1Nob3J0VGVybVdpdGhT'
    'dGVwc0VuYWJsZWQawgIKB0VkaXRpbmcSRAofYWRkaW5nX2RlZmF1bHRzX3RvX2N1cnJlbnRfZG'
    'VjaxgBIAEoCFIbYWRkaW5nRGVmYXVsdHNUb0N1cnJlbnREZWNrEi0KE3Bhc3RlX2ltYWdlc19h'
    'c19wbmcYAiABKAhSEHBhc3RlSW1hZ2VzQXNQbmcSNgoXcGFzdGVfc3RyaXBzX2Zvcm1hdHRpbm'
    'cYAyABKAhSFXBhc3RlU3RyaXBzRm9ybWF0dGluZxIuChNkZWZhdWx0X3NlYXJjaF90ZXh0GAQg'
    'ASgJUhFkZWZhdWx0U2VhcmNoVGV4dBI3ChhpZ25vcmVfYWNjZW50c19pbl9zZWFyY2gYBSABKA'
    'hSFWlnbm9yZUFjY2VudHNJblNlYXJjaBIhCgxyZW5kZXJfbGF0ZXgYBiABKAhSC3JlbmRlckxh'
    'dGV4GooBCgxCYWNrdXBMaW1pdHMSFAoFZGFpbHkYASABKA1SBWRhaWx5EhYKBndlZWtseRgCIA'
    'EoDVIGd2Vla2x5EhgKB21vbnRobHkYAyABKA1SB21vbnRobHkSMgoVbWluaW11bV9pbnRlcnZh'
    'bF9taW5zGAQgASgNUhNtaW5pbXVtSW50ZXJ2YWxNaW5z');

const $core.Map<$core.String, $core.dynamic> ConfigServiceBase$json = {
  '1': 'ConfigService',
  '2': [
    {
      '1': 'GetConfigJson',
      '2': '.anki.generic.String',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'SetConfigJson',
      '2': '.anki.config.SetConfigJsonRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'SetConfigJsonNoUndo',
      '2': '.anki.config.SetConfigJsonRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'RemoveConfig',
      '2': '.anki.generic.String',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetAllConfig',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'GetConfigBool',
      '2': '.anki.config.GetConfigBoolRequest',
      '3': '.anki.generic.Bool'
    },
    {
      '1': 'SetConfigBool',
      '2': '.anki.config.SetConfigBoolRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetConfigString',
      '2': '.anki.config.GetConfigStringRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'SetConfigString',
      '2': '.anki.config.SetConfigStringRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetPreferences',
      '2': '.anki.generic.Empty',
      '3': '.anki.config.Preferences'
    },
    {
      '1': 'SetPreferences',
      '2': '.anki.config.Preferences',
      '3': '.anki.collection.OpChanges'
    },
  ],
};

@$core.Deprecated('Use configServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ConfigServiceBase$messageJson = {
  '.anki.generic.String': $0.String$json,
  '.anki.generic.Json': $0.Json$json,
  '.anki.config.SetConfigJsonRequest': SetConfigJsonRequest$json,
  '.anki.collection.OpChanges': $1.OpChanges$json,
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.config.GetConfigBoolRequest': GetConfigBoolRequest$json,
  '.anki.generic.Bool': $0.Bool$json,
  '.anki.config.SetConfigBoolRequest': SetConfigBoolRequest$json,
  '.anki.config.GetConfigStringRequest': GetConfigStringRequest$json,
  '.anki.config.SetConfigStringRequest': SetConfigStringRequest$json,
  '.anki.config.Preferences': Preferences$json,
  '.anki.config.Preferences.Scheduling': Preferences_Scheduling$json,
  '.anki.config.Preferences.Reviewing': Preferences_Reviewing$json,
  '.anki.config.Preferences.Editing': Preferences_Editing$json,
  '.anki.config.Preferences.BackupLimits': Preferences_BackupLimits$json,
};

/// Descriptor for `ConfigService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List configServiceDescriptor = $convert.base64Decode(
    'Cg1Db25maWdTZXJ2aWNlEjkKDUdldENvbmZpZ0pzb24SFC5hbmtpLmdlbmVyaWMuU3RyaW5nGh'
    'IuYW5raS5nZW5lcmljLkpzb24STgoNU2V0Q29uZmlnSnNvbhIhLmFua2kuY29uZmlnLlNldENv'
    'bmZpZ0pzb25SZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcxJNChNTZXRDb25maW'
    'dKc29uTm9VbmRvEiEuYW5raS5jb25maWcuU2V0Q29uZmlnSnNvblJlcXVlc3QaEy5hbmtpLmdl'
    'bmVyaWMuRW1wdHkSQAoMUmVtb3ZlQ29uZmlnEhQuYW5raS5nZW5lcmljLlN0cmluZxoaLmFua2'
    'kuY29sbGVjdGlvbi5PcENoYW5nZXMSNwoMR2V0QWxsQ29uZmlnEhMuYW5raS5nZW5lcmljLkVt'
    'cHR5GhIuYW5raS5nZW5lcmljLkpzb24SRgoNR2V0Q29uZmlnQm9vbBIhLmFua2kuY29uZmlnLk'
    'dldENvbmZpZ0Jvb2xSZXF1ZXN0GhIuYW5raS5nZW5lcmljLkJvb2wSTgoNU2V0Q29uZmlnQm9v'
    'bBIhLmFua2kuY29uZmlnLlNldENvbmZpZ0Jvb2xSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk'
    '9wQ2hhbmdlcxJMCg9HZXRDb25maWdTdHJpbmcSIy5hbmtpLmNvbmZpZy5HZXRDb25maWdTdHJp'
    'bmdSZXF1ZXN0GhQuYW5raS5nZW5lcmljLlN0cmluZxJSCg9TZXRDb25maWdTdHJpbmcSIy5hbm'
    'tpLmNvbmZpZy5TZXRDb25maWdTdHJpbmdSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hh'
    'bmdlcxI/Cg5HZXRQcmVmZXJlbmNlcxITLmFua2kuZ2VuZXJpYy5FbXB0eRoYLmFua2kuY29uZm'
    'lnLlByZWZlcmVuY2VzEkYKDlNldFByZWZlcmVuY2VzEhguYW5raS5jb25maWcuUHJlZmVyZW5j'
    'ZXMaGi5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2Vz');

const $core.Map<$core.String, $core.dynamic> BackendConfigServiceBase$json = {
  '1': 'BackendConfigService'
};

@$core.Deprecated('Use backendConfigServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendConfigServiceBase$messageJson = {};

/// Descriptor for `BackendConfigService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendConfigServiceDescriptor =
    $convert.base64Decode('ChRCYWNrZW5kQ29uZmlnU2VydmljZQ==');
