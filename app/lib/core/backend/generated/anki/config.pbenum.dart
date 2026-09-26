// This is a generated file - do not edit.
//
// Generated from anki/config.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ExperimentalFeatureFlag extends $pb.ProtobufEnum {
  static const ExperimentalFeatureFlag TEST_FLAG =
      ExperimentalFeatureFlag._(0, _omitEnumNames ? '' : 'TEST_FLAG');
  static const ExperimentalFeatureFlag SVELTE_EDITOR =
      ExperimentalFeatureFlag._(1, _omitEnumNames ? '' : 'SVELTE_EDITOR');
  static const ExperimentalFeatureFlag SVELTE_REVIEWER =
      ExperimentalFeatureFlag._(2, _omitEnumNames ? '' : 'SVELTE_REVIEWER');

  static const $core.List<ExperimentalFeatureFlag> values =
      <ExperimentalFeatureFlag>[
    TEST_FLAG,
    SVELTE_EDITOR,
    SVELTE_REVIEWER,
  ];

  static final $core.List<ExperimentalFeatureFlag?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ExperimentalFeatureFlag? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ExperimentalFeatureFlag._(super.value, super.name);
}

class ConfigKey_Bool extends $pb.ProtobufEnum {
  static const ConfigKey_Bool BROWSER_TABLE_SHOW_NOTES_MODE = ConfigKey_Bool._(
      0, _omitEnumNames ? '' : 'BROWSER_TABLE_SHOW_NOTES_MODE');
  static const ConfigKey_Bool PREVIEW_BOTH_SIDES =
      ConfigKey_Bool._(3, _omitEnumNames ? '' : 'PREVIEW_BOTH_SIDES');
  static const ConfigKey_Bool COLLAPSE_TAGS =
      ConfigKey_Bool._(4, _omitEnumNames ? '' : 'COLLAPSE_TAGS');
  static const ConfigKey_Bool COLLAPSE_NOTETYPES =
      ConfigKey_Bool._(5, _omitEnumNames ? '' : 'COLLAPSE_NOTETYPES');
  static const ConfigKey_Bool COLLAPSE_DECKS =
      ConfigKey_Bool._(6, _omitEnumNames ? '' : 'COLLAPSE_DECKS');
  static const ConfigKey_Bool COLLAPSE_SAVED_SEARCHES =
      ConfigKey_Bool._(7, _omitEnumNames ? '' : 'COLLAPSE_SAVED_SEARCHES');
  static const ConfigKey_Bool COLLAPSE_TODAY =
      ConfigKey_Bool._(8, _omitEnumNames ? '' : 'COLLAPSE_TODAY');
  static const ConfigKey_Bool COLLAPSE_CARD_STATE =
      ConfigKey_Bool._(9, _omitEnumNames ? '' : 'COLLAPSE_CARD_STATE');
  static const ConfigKey_Bool COLLAPSE_FLAGS =
      ConfigKey_Bool._(10, _omitEnumNames ? '' : 'COLLAPSE_FLAGS');
  static const ConfigKey_Bool SCHED_2021 =
      ConfigKey_Bool._(11, _omitEnumNames ? '' : 'SCHED_2021');
  static const ConfigKey_Bool ADDING_DEFAULTS_TO_CURRENT_DECK =
      ConfigKey_Bool._(
          12, _omitEnumNames ? '' : 'ADDING_DEFAULTS_TO_CURRENT_DECK');
  static const ConfigKey_Bool HIDE_AUDIO_PLAY_BUTTONS =
      ConfigKey_Bool._(13, _omitEnumNames ? '' : 'HIDE_AUDIO_PLAY_BUTTONS');
  static const ConfigKey_Bool INTERRUPT_AUDIO_WHEN_ANSWERING = ConfigKey_Bool._(
      14, _omitEnumNames ? '' : 'INTERRUPT_AUDIO_WHEN_ANSWERING');
  static const ConfigKey_Bool PASTE_IMAGES_AS_PNG =
      ConfigKey_Bool._(15, _omitEnumNames ? '' : 'PASTE_IMAGES_AS_PNG');
  static const ConfigKey_Bool PASTE_STRIPS_FORMATTING =
      ConfigKey_Bool._(16, _omitEnumNames ? '' : 'PASTE_STRIPS_FORMATTING');
  static const ConfigKey_Bool NORMALIZE_NOTE_TEXT =
      ConfigKey_Bool._(17, _omitEnumNames ? '' : 'NORMALIZE_NOTE_TEXT');
  static const ConfigKey_Bool IGNORE_ACCENTS_IN_SEARCH =
      ConfigKey_Bool._(18, _omitEnumNames ? '' : 'IGNORE_ACCENTS_IN_SEARCH');
  static const ConfigKey_Bool RESTORE_POSITION_BROWSER =
      ConfigKey_Bool._(19, _omitEnumNames ? '' : 'RESTORE_POSITION_BROWSER');
  static const ConfigKey_Bool RESTORE_POSITION_REVIEWER =
      ConfigKey_Bool._(20, _omitEnumNames ? '' : 'RESTORE_POSITION_REVIEWER');
  static const ConfigKey_Bool RESET_COUNTS_BROWSER =
      ConfigKey_Bool._(21, _omitEnumNames ? '' : 'RESET_COUNTS_BROWSER');
  static const ConfigKey_Bool RESET_COUNTS_REVIEWER =
      ConfigKey_Bool._(22, _omitEnumNames ? '' : 'RESET_COUNTS_REVIEWER');
  static const ConfigKey_Bool RANDOM_ORDER_REPOSITION =
      ConfigKey_Bool._(23, _omitEnumNames ? '' : 'RANDOM_ORDER_REPOSITION');
  static const ConfigKey_Bool SHIFT_POSITION_OF_EXISTING_CARDS =
      ConfigKey_Bool._(
          24, _omitEnumNames ? '' : 'SHIFT_POSITION_OF_EXISTING_CARDS');
  static const ConfigKey_Bool RENDER_LATEX =
      ConfigKey_Bool._(25, _omitEnumNames ? '' : 'RENDER_LATEX');
  static const ConfigKey_Bool LOAD_BALANCER_ENABLED =
      ConfigKey_Bool._(26, _omitEnumNames ? '' : 'LOAD_BALANCER_ENABLED');
  static const ConfigKey_Bool FSRS_SHORT_TERM_WITH_STEPS_ENABLED =
      ConfigKey_Bool._(
          27, _omitEnumNames ? '' : 'FSRS_SHORT_TERM_WITH_STEPS_ENABLED');
  static const ConfigKey_Bool FSRS_LEGACY_EVALUATE =
      ConfigKey_Bool._(28, _omitEnumNames ? '' : 'FSRS_LEGACY_EVALUATE');

  static const $core.List<ConfigKey_Bool> values = <ConfigKey_Bool>[
    BROWSER_TABLE_SHOW_NOTES_MODE,
    PREVIEW_BOTH_SIDES,
    COLLAPSE_TAGS,
    COLLAPSE_NOTETYPES,
    COLLAPSE_DECKS,
    COLLAPSE_SAVED_SEARCHES,
    COLLAPSE_TODAY,
    COLLAPSE_CARD_STATE,
    COLLAPSE_FLAGS,
    SCHED_2021,
    ADDING_DEFAULTS_TO_CURRENT_DECK,
    HIDE_AUDIO_PLAY_BUTTONS,
    INTERRUPT_AUDIO_WHEN_ANSWERING,
    PASTE_IMAGES_AS_PNG,
    PASTE_STRIPS_FORMATTING,
    NORMALIZE_NOTE_TEXT,
    IGNORE_ACCENTS_IN_SEARCH,
    RESTORE_POSITION_BROWSER,
    RESTORE_POSITION_REVIEWER,
    RESET_COUNTS_BROWSER,
    RESET_COUNTS_REVIEWER,
    RANDOM_ORDER_REPOSITION,
    SHIFT_POSITION_OF_EXISTING_CARDS,
    RENDER_LATEX,
    LOAD_BALANCER_ENABLED,
    FSRS_SHORT_TERM_WITH_STEPS_ENABLED,
    FSRS_LEGACY_EVALUATE,
  ];

  static final $core.List<ConfigKey_Bool?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 28);
  static ConfigKey_Bool? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ConfigKey_Bool._(super.value, super.name);
}

class ConfigKey_String extends $pb.ProtobufEnum {
  static const ConfigKey_String SET_DUE_BROWSER =
      ConfigKey_String._(0, _omitEnumNames ? '' : 'SET_DUE_BROWSER');
  static const ConfigKey_String SET_DUE_REVIEWER =
      ConfigKey_String._(1, _omitEnumNames ? '' : 'SET_DUE_REVIEWER');
  static const ConfigKey_String DEFAULT_SEARCH_TEXT =
      ConfigKey_String._(2, _omitEnumNames ? '' : 'DEFAULT_SEARCH_TEXT');
  static const ConfigKey_String CARD_STATE_CUSTOMIZER =
      ConfigKey_String._(3, _omitEnumNames ? '' : 'CARD_STATE_CUSTOMIZER');

  static const $core.List<ConfigKey_String> values = <ConfigKey_String>[
    SET_DUE_BROWSER,
    SET_DUE_REVIEWER,
    DEFAULT_SEARCH_TEXT,
    CARD_STATE_CUSTOMIZER,
  ];

  static final $core.List<ConfigKey_String?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ConfigKey_String? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ConfigKey_String._(super.value, super.name);
}

class Preferences_Scheduling_NewReviewMix extends $pb.ProtobufEnum {
  static const Preferences_Scheduling_NewReviewMix DISTRIBUTE =
      Preferences_Scheduling_NewReviewMix._(
          0, _omitEnumNames ? '' : 'DISTRIBUTE');
  static const Preferences_Scheduling_NewReviewMix REVIEWS_FIRST =
      Preferences_Scheduling_NewReviewMix._(
          1, _omitEnumNames ? '' : 'REVIEWS_FIRST');
  static const Preferences_Scheduling_NewReviewMix NEW_FIRST =
      Preferences_Scheduling_NewReviewMix._(
          2, _omitEnumNames ? '' : 'NEW_FIRST');

  static const $core.List<Preferences_Scheduling_NewReviewMix> values =
      <Preferences_Scheduling_NewReviewMix>[
    DISTRIBUTE,
    REVIEWS_FIRST,
    NEW_FIRST,
  ];

  static final $core.List<Preferences_Scheduling_NewReviewMix?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Preferences_Scheduling_NewReviewMix? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Preferences_Scheduling_NewReviewMix._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
