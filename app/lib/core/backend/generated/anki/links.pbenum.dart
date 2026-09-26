// This is a generated file - do not edit.
//
// Generated from anki/links.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class HelpPageLinkRequest_HelpPage extends $pb.ProtobufEnum {
  static const HelpPageLinkRequest_HelpPage NOTE_TYPE =
      HelpPageLinkRequest_HelpPage._(0, _omitEnumNames ? '' : 'NOTE_TYPE');
  static const HelpPageLinkRequest_HelpPage BROWSING =
      HelpPageLinkRequest_HelpPage._(1, _omitEnumNames ? '' : 'BROWSING');
  static const HelpPageLinkRequest_HelpPage BROWSING_FIND_AND_REPLACE =
      HelpPageLinkRequest_HelpPage._(
          2, _omitEnumNames ? '' : 'BROWSING_FIND_AND_REPLACE');
  static const HelpPageLinkRequest_HelpPage BROWSING_NOTES_MENU =
      HelpPageLinkRequest_HelpPage._(
          3, _omitEnumNames ? '' : 'BROWSING_NOTES_MENU');
  static const HelpPageLinkRequest_HelpPage KEYBOARD_SHORTCUTS =
      HelpPageLinkRequest_HelpPage._(
          4, _omitEnumNames ? '' : 'KEYBOARD_SHORTCUTS');
  static const HelpPageLinkRequest_HelpPage EDITING =
      HelpPageLinkRequest_HelpPage._(5, _omitEnumNames ? '' : 'EDITING');
  static const HelpPageLinkRequest_HelpPage ADDING_CARD_AND_NOTE =
      HelpPageLinkRequest_HelpPage._(
          6, _omitEnumNames ? '' : 'ADDING_CARD_AND_NOTE');
  static const HelpPageLinkRequest_HelpPage ADDING_A_NOTE_TYPE =
      HelpPageLinkRequest_HelpPage._(
          7, _omitEnumNames ? '' : 'ADDING_A_NOTE_TYPE');
  static const HelpPageLinkRequest_HelpPage LATEX =
      HelpPageLinkRequest_HelpPage._(8, _omitEnumNames ? '' : 'LATEX');
  static const HelpPageLinkRequest_HelpPage PREFERENCES =
      HelpPageLinkRequest_HelpPage._(9, _omitEnumNames ? '' : 'PREFERENCES');
  static const HelpPageLinkRequest_HelpPage INDEX =
      HelpPageLinkRequest_HelpPage._(10, _omitEnumNames ? '' : 'INDEX');
  static const HelpPageLinkRequest_HelpPage TEMPLATES =
      HelpPageLinkRequest_HelpPage._(11, _omitEnumNames ? '' : 'TEMPLATES');
  static const HelpPageLinkRequest_HelpPage FILTERED_DECK =
      HelpPageLinkRequest_HelpPage._(12, _omitEnumNames ? '' : 'FILTERED_DECK');
  static const HelpPageLinkRequest_HelpPage IMPORTING =
      HelpPageLinkRequest_HelpPage._(13, _omitEnumNames ? '' : 'IMPORTING');
  static const HelpPageLinkRequest_HelpPage CUSTOMIZING_FIELDS =
      HelpPageLinkRequest_HelpPage._(
          14, _omitEnumNames ? '' : 'CUSTOMIZING_FIELDS');
  static const HelpPageLinkRequest_HelpPage DECK_OPTIONS =
      HelpPageLinkRequest_HelpPage._(15, _omitEnumNames ? '' : 'DECK_OPTIONS');
  static const HelpPageLinkRequest_HelpPage EDITING_FEATURES =
      HelpPageLinkRequest_HelpPage._(
          16, _omitEnumNames ? '' : 'EDITING_FEATURES');
  static const HelpPageLinkRequest_HelpPage FULL_SCREEN_ISSUE =
      HelpPageLinkRequest_HelpPage._(
          17, _omitEnumNames ? '' : 'FULL_SCREEN_ISSUE');
  static const HelpPageLinkRequest_HelpPage CARD_TYPE_DUPLICATE =
      HelpPageLinkRequest_HelpPage._(
          18, _omitEnumNames ? '' : 'CARD_TYPE_DUPLICATE');
  static const HelpPageLinkRequest_HelpPage CARD_TYPE_NO_FRONT_FIELD =
      HelpPageLinkRequest_HelpPage._(
          19, _omitEnumNames ? '' : 'CARD_TYPE_NO_FRONT_FIELD');
  static const HelpPageLinkRequest_HelpPage CARD_TYPE_MISSING_CLOZE =
      HelpPageLinkRequest_HelpPage._(
          20, _omitEnumNames ? '' : 'CARD_TYPE_MISSING_CLOZE');
  static const HelpPageLinkRequest_HelpPage TROUBLESHOOTING =
      HelpPageLinkRequest_HelpPage._(
          21, _omitEnumNames ? '' : 'TROUBLESHOOTING');
  static const HelpPageLinkRequest_HelpPage CARD_TYPE_TEMPLATE_ERROR =
      HelpPageLinkRequest_HelpPage._(
          22, _omitEnumNames ? '' : 'CARD_TYPE_TEMPLATE_ERROR');

  static const $core.List<HelpPageLinkRequest_HelpPage> values =
      <HelpPageLinkRequest_HelpPage>[
    NOTE_TYPE,
    BROWSING,
    BROWSING_FIND_AND_REPLACE,
    BROWSING_NOTES_MENU,
    KEYBOARD_SHORTCUTS,
    EDITING,
    ADDING_CARD_AND_NOTE,
    ADDING_A_NOTE_TYPE,
    LATEX,
    PREFERENCES,
    INDEX,
    TEMPLATES,
    FILTERED_DECK,
    IMPORTING,
    CUSTOMIZING_FIELDS,
    DECK_OPTIONS,
    EDITING_FEATURES,
    FULL_SCREEN_ISSUE,
    CARD_TYPE_DUPLICATE,
    CARD_TYPE_NO_FRONT_FIELD,
    CARD_TYPE_MISSING_CLOZE,
    TROUBLESHOOTING,
    CARD_TYPE_TEMPLATE_ERROR,
  ];

  static final $core.List<HelpPageLinkRequest_HelpPage?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 22);
  static HelpPageLinkRequest_HelpPage? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HelpPageLinkRequest_HelpPage._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
