// This is a generated file - do not edit.
//
// Generated from anki/decks.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Deck_Filtered_SearchTerm_Order extends $pb.ProtobufEnum {
  static const Deck_Filtered_SearchTerm_Order OLDEST_REVIEWED_FIRST =
      Deck_Filtered_SearchTerm_Order._(
          0, _omitEnumNames ? '' : 'OLDEST_REVIEWED_FIRST');
  static const Deck_Filtered_SearchTerm_Order RANDOM =
      Deck_Filtered_SearchTerm_Order._(1, _omitEnumNames ? '' : 'RANDOM');
  static const Deck_Filtered_SearchTerm_Order INTERVALS_ASCENDING =
      Deck_Filtered_SearchTerm_Order._(
          2, _omitEnumNames ? '' : 'INTERVALS_ASCENDING');
  static const Deck_Filtered_SearchTerm_Order INTERVALS_DESCENDING =
      Deck_Filtered_SearchTerm_Order._(
          3, _omitEnumNames ? '' : 'INTERVALS_DESCENDING');
  static const Deck_Filtered_SearchTerm_Order LAPSES =
      Deck_Filtered_SearchTerm_Order._(4, _omitEnumNames ? '' : 'LAPSES');
  static const Deck_Filtered_SearchTerm_Order ADDED =
      Deck_Filtered_SearchTerm_Order._(5, _omitEnumNames ? '' : 'ADDED');
  static const Deck_Filtered_SearchTerm_Order DUE =
      Deck_Filtered_SearchTerm_Order._(6, _omitEnumNames ? '' : 'DUE');
  static const Deck_Filtered_SearchTerm_Order REVERSE_ADDED =
      Deck_Filtered_SearchTerm_Order._(
          7, _omitEnumNames ? '' : 'REVERSE_ADDED');
  static const Deck_Filtered_SearchTerm_Order RETRIEVABILITY_ASCENDING =
      Deck_Filtered_SearchTerm_Order._(
          8, _omitEnumNames ? '' : 'RETRIEVABILITY_ASCENDING');
  static const Deck_Filtered_SearchTerm_Order RETRIEVABILITY_DESCENDING =
      Deck_Filtered_SearchTerm_Order._(
          9, _omitEnumNames ? '' : 'RETRIEVABILITY_DESCENDING');
  static const Deck_Filtered_SearchTerm_Order RELATIVE_OVERDUENESS =
      Deck_Filtered_SearchTerm_Order._(
          10, _omitEnumNames ? '' : 'RELATIVE_OVERDUENESS');

  static const $core.List<Deck_Filtered_SearchTerm_Order> values =
      <Deck_Filtered_SearchTerm_Order>[
    OLDEST_REVIEWED_FIRST,
    RANDOM,
    INTERVALS_ASCENDING,
    INTERVALS_DESCENDING,
    LAPSES,
    ADDED,
    DUE,
    REVERSE_ADDED,
    RETRIEVABILITY_ASCENDING,
    RETRIEVABILITY_DESCENDING,
    RELATIVE_OVERDUENESS,
  ];

  static final $core.List<Deck_Filtered_SearchTerm_Order?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 10);
  static Deck_Filtered_SearchTerm_Order? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Deck_Filtered_SearchTerm_Order._(super.value, super.name);
}

class SetDeckCollapsedRequest_Scope extends $pb.ProtobufEnum {
  static const SetDeckCollapsedRequest_Scope REVIEWER =
      SetDeckCollapsedRequest_Scope._(0, _omitEnumNames ? '' : 'REVIEWER');
  static const SetDeckCollapsedRequest_Scope BROWSER =
      SetDeckCollapsedRequest_Scope._(1, _omitEnumNames ? '' : 'BROWSER');

  static const $core.List<SetDeckCollapsedRequest_Scope> values =
      <SetDeckCollapsedRequest_Scope>[
    REVIEWER,
    BROWSER,
  ];

  static final $core.List<SetDeckCollapsedRequest_Scope?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static SetDeckCollapsedRequest_Scope? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SetDeckCollapsedRequest_Scope._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
