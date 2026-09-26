// This is a generated file - do not edit.
//
// Generated from anki/card_rendering.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class StripHtmlRequest_Mode extends $pb.ProtobufEnum {
  static const StripHtmlRequest_Mode NORMAL =
      StripHtmlRequest_Mode._(0, _omitEnumNames ? '' : 'NORMAL');
  static const StripHtmlRequest_Mode PRESERVE_MEDIA_FILENAMES =
      StripHtmlRequest_Mode._(
          1, _omitEnumNames ? '' : 'PRESERVE_MEDIA_FILENAMES');

  static const $core.List<StripHtmlRequest_Mode> values =
      <StripHtmlRequest_Mode>[
    NORMAL,
    PRESERVE_MEDIA_FILENAMES,
  ];

  static final $core.List<StripHtmlRequest_Mode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static StripHtmlRequest_Mode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StripHtmlRequest_Mode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
