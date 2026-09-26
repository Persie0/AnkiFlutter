// This is a generated file - do not edit.
//
// Generated from anki/sync.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SyncStatusResponse_Required extends $pb.ProtobufEnum {
  static const SyncStatusResponse_Required NO_CHANGES =
      SyncStatusResponse_Required._(0, _omitEnumNames ? '' : 'NO_CHANGES');
  static const SyncStatusResponse_Required NORMAL_SYNC =
      SyncStatusResponse_Required._(1, _omitEnumNames ? '' : 'NORMAL_SYNC');
  static const SyncStatusResponse_Required FULL_SYNC =
      SyncStatusResponse_Required._(2, _omitEnumNames ? '' : 'FULL_SYNC');

  static const $core.List<SyncStatusResponse_Required> values =
      <SyncStatusResponse_Required>[
    NO_CHANGES,
    NORMAL_SYNC,
    FULL_SYNC,
  ];

  static final $core.List<SyncStatusResponse_Required?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SyncStatusResponse_Required? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SyncStatusResponse_Required._(super.value, super.name);
}

class SyncCollectionResponse_ChangesRequired extends $pb.ProtobufEnum {
  static const SyncCollectionResponse_ChangesRequired NO_CHANGES =
      SyncCollectionResponse_ChangesRequired._(
          0, _omitEnumNames ? '' : 'NO_CHANGES');
  static const SyncCollectionResponse_ChangesRequired NORMAL_SYNC =
      SyncCollectionResponse_ChangesRequired._(
          1, _omitEnumNames ? '' : 'NORMAL_SYNC');
  static const SyncCollectionResponse_ChangesRequired FULL_SYNC =
      SyncCollectionResponse_ChangesRequired._(
          2, _omitEnumNames ? '' : 'FULL_SYNC');

  /// local collection has no cards; upload not an option
  static const SyncCollectionResponse_ChangesRequired FULL_DOWNLOAD =
      SyncCollectionResponse_ChangesRequired._(
          3, _omitEnumNames ? '' : 'FULL_DOWNLOAD');

  /// remote collection has no cards; download not an option
  static const SyncCollectionResponse_ChangesRequired FULL_UPLOAD =
      SyncCollectionResponse_ChangesRequired._(
          4, _omitEnumNames ? '' : 'FULL_UPLOAD');

  static const $core.List<SyncCollectionResponse_ChangesRequired> values =
      <SyncCollectionResponse_ChangesRequired>[
    NO_CHANGES,
    NORMAL_SYNC,
    FULL_SYNC,
    FULL_DOWNLOAD,
    FULL_UPLOAD,
  ];

  static final $core.List<SyncCollectionResponse_ChangesRequired?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static SyncCollectionResponse_ChangesRequired? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SyncCollectionResponse_ChangesRequired._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
