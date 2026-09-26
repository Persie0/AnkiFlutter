// This is a generated file - do not edit.
//
// Generated from anki/frontend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MessageBoxType extends $pb.ProtobufEnum {
  static const MessageBoxType INFO =
      MessageBoxType._(0, _omitEnumNames ? '' : 'INFO');
  static const MessageBoxType WARNING =
      MessageBoxType._(1, _omitEnumNames ? '' : 'WARNING');
  static const MessageBoxType CRITICAL =
      MessageBoxType._(2, _omitEnumNames ? '' : 'CRITICAL');

  static const $core.List<MessageBoxType> values = <MessageBoxType>[
    INFO,
    WARNING,
    CRITICAL,
  ];

  static final $core.List<MessageBoxType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static MessageBoxType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MessageBoxType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
