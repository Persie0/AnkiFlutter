// This is a generated file - do not edit.
//
// Generated from anki/backend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BackendError_Kind extends $pb.ProtobufEnum {
  static const BackendError_Kind INVALID_INPUT =
      BackendError_Kind._(0, _omitEnumNames ? '' : 'INVALID_INPUT');
  static const BackendError_Kind UNDO_EMPTY =
      BackendError_Kind._(1, _omitEnumNames ? '' : 'UNDO_EMPTY');
  static const BackendError_Kind INTERRUPTED =
      BackendError_Kind._(2, _omitEnumNames ? '' : 'INTERRUPTED');
  static const BackendError_Kind TEMPLATE_PARSE =
      BackendError_Kind._(3, _omitEnumNames ? '' : 'TEMPLATE_PARSE');
  static const BackendError_Kind IO_ERROR =
      BackendError_Kind._(4, _omitEnumNames ? '' : 'IO_ERROR');
  static const BackendError_Kind DB_ERROR =
      BackendError_Kind._(5, _omitEnumNames ? '' : 'DB_ERROR');
  static const BackendError_Kind NETWORK_ERROR =
      BackendError_Kind._(6, _omitEnumNames ? '' : 'NETWORK_ERROR');
  static const BackendError_Kind SYNC_AUTH_ERROR =
      BackendError_Kind._(7, _omitEnumNames ? '' : 'SYNC_AUTH_ERROR');
  static const BackendError_Kind SYNC_SERVER_MESSAGE =
      BackendError_Kind._(23, _omitEnumNames ? '' : 'SYNC_SERVER_MESSAGE');
  static const BackendError_Kind SYNC_OTHER_ERROR =
      BackendError_Kind._(8, _omitEnumNames ? '' : 'SYNC_OTHER_ERROR');
  static const BackendError_Kind JSON_ERROR =
      BackendError_Kind._(9, _omitEnumNames ? '' : 'JSON_ERROR');
  static const BackendError_Kind PROTO_ERROR =
      BackendError_Kind._(10, _omitEnumNames ? '' : 'PROTO_ERROR');
  static const BackendError_Kind NOT_FOUND_ERROR =
      BackendError_Kind._(11, _omitEnumNames ? '' : 'NOT_FOUND_ERROR');
  static const BackendError_Kind EXISTS =
      BackendError_Kind._(12, _omitEnumNames ? '' : 'EXISTS');
  static const BackendError_Kind FILTERED_DECK_ERROR =
      BackendError_Kind._(13, _omitEnumNames ? '' : 'FILTERED_DECK_ERROR');
  static const BackendError_Kind SEARCH_ERROR =
      BackendError_Kind._(14, _omitEnumNames ? '' : 'SEARCH_ERROR');
  static const BackendError_Kind CUSTOM_STUDY_ERROR =
      BackendError_Kind._(15, _omitEnumNames ? '' : 'CUSTOM_STUDY_ERROR');
  static const BackendError_Kind IMPORT_ERROR =
      BackendError_Kind._(16, _omitEnumNames ? '' : 'IMPORT_ERROR');
  static const BackendError_Kind DELETED =
      BackendError_Kind._(17, _omitEnumNames ? '' : 'DELETED');
  static const BackendError_Kind CARD_TYPE_ERROR =
      BackendError_Kind._(18, _omitEnumNames ? '' : 'CARD_TYPE_ERROR');
  static const BackendError_Kind ANKIDROID_PANIC_ERROR =
      BackendError_Kind._(19, _omitEnumNames ? '' : 'ANKIDROID_PANIC_ERROR');

  /// Originated from and usually specific to the OS.
  static const BackendError_Kind OS_ERROR =
      BackendError_Kind._(20, _omitEnumNames ? '' : 'OS_ERROR');
  static const BackendError_Kind SCHEDULER_UPGRADE_REQUIRED =
      BackendError_Kind._(
          21, _omitEnumNames ? '' : 'SCHEDULER_UPGRADE_REQUIRED');
  static const BackendError_Kind INVALID_CERTIFICATE_FORMAT =
      BackendError_Kind._(
          22, _omitEnumNames ? '' : 'INVALID_CERTIFICATE_FORMAT');
  static const BackendError_Kind INVALID_CHECKSUM =
      BackendError_Kind._(24, _omitEnumNames ? '' : 'INVALID_CHECKSUM');

  static const $core.List<BackendError_Kind> values = <BackendError_Kind>[
    INVALID_INPUT,
    UNDO_EMPTY,
    INTERRUPTED,
    TEMPLATE_PARSE,
    IO_ERROR,
    DB_ERROR,
    NETWORK_ERROR,
    SYNC_AUTH_ERROR,
    SYNC_SERVER_MESSAGE,
    SYNC_OTHER_ERROR,
    JSON_ERROR,
    PROTO_ERROR,
    NOT_FOUND_ERROR,
    EXISTS,
    FILTERED_DECK_ERROR,
    SEARCH_ERROR,
    CUSTOM_STUDY_ERROR,
    IMPORT_ERROR,
    DELETED,
    CARD_TYPE_ERROR,
    ANKIDROID_PANIC_ERROR,
    OS_ERROR,
    SCHEDULER_UPGRADE_REQUIRED,
    INVALID_CERTIFICATE_FORMAT,
    INVALID_CHECKSUM,
  ];

  static final $core.List<BackendError_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 24);
  static BackendError_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BackendError_Kind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
