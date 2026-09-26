// This is a generated file - do not edit.
//
// Generated from anki/notes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class NoteFieldsCheckResponse_State extends $pb.ProtobufEnum {
  static const NoteFieldsCheckResponse_State NORMAL =
      NoteFieldsCheckResponse_State._(0, _omitEnumNames ? '' : 'NORMAL');
  static const NoteFieldsCheckResponse_State EMPTY =
      NoteFieldsCheckResponse_State._(1, _omitEnumNames ? '' : 'EMPTY');
  static const NoteFieldsCheckResponse_State DUPLICATE =
      NoteFieldsCheckResponse_State._(2, _omitEnumNames ? '' : 'DUPLICATE');
  static const NoteFieldsCheckResponse_State MISSING_CLOZE =
      NoteFieldsCheckResponse_State._(3, _omitEnumNames ? '' : 'MISSING_CLOZE');
  static const NoteFieldsCheckResponse_State NOTETYPE_NOT_CLOZE =
      NoteFieldsCheckResponse_State._(
          4, _omitEnumNames ? '' : 'NOTETYPE_NOT_CLOZE');
  static const NoteFieldsCheckResponse_State FIELD_NOT_CLOZE =
      NoteFieldsCheckResponse_State._(
          5, _omitEnumNames ? '' : 'FIELD_NOT_CLOZE');

  static const $core.List<NoteFieldsCheckResponse_State> values =
      <NoteFieldsCheckResponse_State>[
    NORMAL,
    EMPTY,
    DUPLICATE,
    MISSING_CLOZE,
    NOTETYPE_NOT_CLOZE,
    FIELD_NOT_CLOZE,
  ];

  static final $core.List<NoteFieldsCheckResponse_State?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static NoteFieldsCheckResponse_State? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const NoteFieldsCheckResponse_State._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
