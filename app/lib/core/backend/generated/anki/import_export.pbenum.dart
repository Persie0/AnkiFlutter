// This is a generated file - do not edit.
//
// Generated from anki/import_export.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ImportAnkiPackageUpdateCondition extends $pb.ProtobufEnum {
  static const ImportAnkiPackageUpdateCondition
      IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER =
      ImportAnkiPackageUpdateCondition._(
          0,
          _omitEnumNames
              ? ''
              : 'IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER');
  static const ImportAnkiPackageUpdateCondition
      IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_ALWAYS =
      ImportAnkiPackageUpdateCondition._(1,
          _omitEnumNames ? '' : 'IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_ALWAYS');
  static const ImportAnkiPackageUpdateCondition
      IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_NEVER =
      ImportAnkiPackageUpdateCondition._(2,
          _omitEnumNames ? '' : 'IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_NEVER');

  static const $core.List<ImportAnkiPackageUpdateCondition> values =
      <ImportAnkiPackageUpdateCondition>[
    IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER,
    IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_ALWAYS,
    IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_NEVER,
  ];

  static final $core.List<ImportAnkiPackageUpdateCondition?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ImportAnkiPackageUpdateCondition? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ImportAnkiPackageUpdateCondition._(super.value, super.name);
}

class PackageMetadata_Version extends $pb.ProtobufEnum {
  static const PackageMetadata_Version VERSION_UNKNOWN =
      PackageMetadata_Version._(0, _omitEnumNames ? '' : 'VERSION_UNKNOWN');

  /// When `meta` missing, and collection.anki2 file present.
  static const PackageMetadata_Version VERSION_LEGACY_1 =
      PackageMetadata_Version._(1, _omitEnumNames ? '' : 'VERSION_LEGACY_1');

  /// When `meta` missing, and collection.anki21 file present.
  static const PackageMetadata_Version VERSION_LEGACY_2 =
      PackageMetadata_Version._(2, _omitEnumNames ? '' : 'VERSION_LEGACY_2');

  /// Implies MediaEntry media map, and zstd compression.
  /// collection.21b file
  static const PackageMetadata_Version VERSION_LATEST =
      PackageMetadata_Version._(3, _omitEnumNames ? '' : 'VERSION_LATEST');

  static const $core.List<PackageMetadata_Version> values =
      <PackageMetadata_Version>[
    VERSION_UNKNOWN,
    VERSION_LEGACY_1,
    VERSION_LEGACY_2,
    VERSION_LATEST,
  ];

  static final $core.List<PackageMetadata_Version?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static PackageMetadata_Version? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PackageMetadata_Version._(super.value, super.name);
}

class CsvMetadata_DupeResolution extends $pb.ProtobufEnum {
  static const CsvMetadata_DupeResolution UPDATE =
      CsvMetadata_DupeResolution._(0, _omitEnumNames ? '' : 'UPDATE');
  static const CsvMetadata_DupeResolution PRESERVE =
      CsvMetadata_DupeResolution._(1, _omitEnumNames ? '' : 'PRESERVE');
  static const CsvMetadata_DupeResolution DUPLICATE =
      CsvMetadata_DupeResolution._(2, _omitEnumNames ? '' : 'DUPLICATE');

  static const $core.List<CsvMetadata_DupeResolution> values =
      <CsvMetadata_DupeResolution>[
    UPDATE,
    PRESERVE,
    DUPLICATE,
  ];

  static final $core.List<CsvMetadata_DupeResolution?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CsvMetadata_DupeResolution? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CsvMetadata_DupeResolution._(super.value, super.name);
}

/// Order roughly in ascending expected frequency in note text, because the
/// delimiter detection algorithm is stupidly picking the first one it
/// encounters.
class CsvMetadata_Delimiter extends $pb.ProtobufEnum {
  static const CsvMetadata_Delimiter TAB =
      CsvMetadata_Delimiter._(0, _omitEnumNames ? '' : 'TAB');
  static const CsvMetadata_Delimiter PIPE =
      CsvMetadata_Delimiter._(1, _omitEnumNames ? '' : 'PIPE');
  static const CsvMetadata_Delimiter SEMICOLON =
      CsvMetadata_Delimiter._(2, _omitEnumNames ? '' : 'SEMICOLON');
  static const CsvMetadata_Delimiter COLON =
      CsvMetadata_Delimiter._(3, _omitEnumNames ? '' : 'COLON');
  static const CsvMetadata_Delimiter COMMA =
      CsvMetadata_Delimiter._(4, _omitEnumNames ? '' : 'COMMA');
  static const CsvMetadata_Delimiter SPACE =
      CsvMetadata_Delimiter._(5, _omitEnumNames ? '' : 'SPACE');

  static const $core.List<CsvMetadata_Delimiter> values =
      <CsvMetadata_Delimiter>[
    TAB,
    PIPE,
    SEMICOLON,
    COLON,
    COMMA,
    SPACE,
  ];

  static final $core.List<CsvMetadata_Delimiter?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static CsvMetadata_Delimiter? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CsvMetadata_Delimiter._(super.value, super.name);
}

class CsvMetadata_MatchScope extends $pb.ProtobufEnum {
  static const CsvMetadata_MatchScope NOTETYPE =
      CsvMetadata_MatchScope._(0, _omitEnumNames ? '' : 'NOTETYPE');
  static const CsvMetadata_MatchScope NOTETYPE_AND_DECK =
      CsvMetadata_MatchScope._(1, _omitEnumNames ? '' : 'NOTETYPE_AND_DECK');

  static const $core.List<CsvMetadata_MatchScope> values =
      <CsvMetadata_MatchScope>[
    NOTETYPE,
    NOTETYPE_AND_DECK,
  ];

  static final $core.List<CsvMetadata_MatchScope?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static CsvMetadata_MatchScope? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CsvMetadata_MatchScope._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
