// This is a generated file - do not edit.
//
// Generated from anki/stats.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GraphPreferences_Weekday extends $pb.ProtobufEnum {
  static const GraphPreferences_Weekday SUNDAY =
      GraphPreferences_Weekday._(0, _omitEnumNames ? '' : 'SUNDAY');
  static const GraphPreferences_Weekday MONDAY =
      GraphPreferences_Weekday._(1, _omitEnumNames ? '' : 'MONDAY');
  static const GraphPreferences_Weekday FRIDAY =
      GraphPreferences_Weekday._(5, _omitEnumNames ? '' : 'FRIDAY');
  static const GraphPreferences_Weekday SATURDAY =
      GraphPreferences_Weekday._(6, _omitEnumNames ? '' : 'SATURDAY');

  static const $core.List<GraphPreferences_Weekday> values =
      <GraphPreferences_Weekday>[
    SUNDAY,
    MONDAY,
    FRIDAY,
    SATURDAY,
  ];

  static final $core.Map<$core.int, GraphPreferences_Weekday> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static GraphPreferences_Weekday? valueOf($core.int value) => _byValue[value];

  const GraphPreferences_Weekday._(super.value, super.name);
}

class RevlogEntry_ReviewKind extends $pb.ProtobufEnum {
  static const RevlogEntry_ReviewKind LEARNING =
      RevlogEntry_ReviewKind._(0, _omitEnumNames ? '' : 'LEARNING');
  static const RevlogEntry_ReviewKind REVIEW =
      RevlogEntry_ReviewKind._(1, _omitEnumNames ? '' : 'REVIEW');
  static const RevlogEntry_ReviewKind RELEARNING =
      RevlogEntry_ReviewKind._(2, _omitEnumNames ? '' : 'RELEARNING');
  static const RevlogEntry_ReviewKind FILTERED =
      RevlogEntry_ReviewKind._(3, _omitEnumNames ? '' : 'FILTERED');
  static const RevlogEntry_ReviewKind MANUAL =
      RevlogEntry_ReviewKind._(4, _omitEnumNames ? '' : 'MANUAL');
  static const RevlogEntry_ReviewKind RESCHEDULED =
      RevlogEntry_ReviewKind._(5, _omitEnumNames ? '' : 'RESCHEDULED');

  static const $core.List<RevlogEntry_ReviewKind> values =
      <RevlogEntry_ReviewKind>[
    LEARNING,
    REVIEW,
    RELEARNING,
    FILTERED,
    MANUAL,
    RESCHEDULED,
  ];

  static final $core.List<RevlogEntry_ReviewKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static RevlogEntry_ReviewKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RevlogEntry_ReviewKind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
