// This is a generated file - do not edit.
//
// Generated from anki/notetypes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ImageOcclusionField extends $pb.ProtobufEnum {
  static const ImageOcclusionField IMAGE_OCCLUSION_FIELD_OCCLUSIONS =
      ImageOcclusionField._(
          0, _omitEnumNames ? '' : 'IMAGE_OCCLUSION_FIELD_OCCLUSIONS');
  static const ImageOcclusionField IMAGE_OCCLUSION_FIELD_IMAGE =
      ImageOcclusionField._(
          1, _omitEnumNames ? '' : 'IMAGE_OCCLUSION_FIELD_IMAGE');
  static const ImageOcclusionField IMAGE_OCCLUSION_FIELD_HEADER =
      ImageOcclusionField._(
          2, _omitEnumNames ? '' : 'IMAGE_OCCLUSION_FIELD_HEADER');
  static const ImageOcclusionField IMAGE_OCCLUSION_FIELD_BACK_EXTRA =
      ImageOcclusionField._(
          3, _omitEnumNames ? '' : 'IMAGE_OCCLUSION_FIELD_BACK_EXTRA');
  static const ImageOcclusionField IMAGE_OCCLUSION_FIELD_COMMENTS =
      ImageOcclusionField._(
          4, _omitEnumNames ? '' : 'IMAGE_OCCLUSION_FIELD_COMMENTS');

  static const $core.List<ImageOcclusionField> values = <ImageOcclusionField>[
    IMAGE_OCCLUSION_FIELD_OCCLUSIONS,
    IMAGE_OCCLUSION_FIELD_IMAGE,
    IMAGE_OCCLUSION_FIELD_HEADER,
    IMAGE_OCCLUSION_FIELD_BACK_EXTRA,
    IMAGE_OCCLUSION_FIELD_COMMENTS,
  ];

  static final $core.List<ImageOcclusionField?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ImageOcclusionField? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ImageOcclusionField._(super.value, super.name);
}

class ClozeField extends $pb.ProtobufEnum {
  static const ClozeField CLOZE_FIELD_TEXT =
      ClozeField._(0, _omitEnumNames ? '' : 'CLOZE_FIELD_TEXT');
  static const ClozeField CLOZE_FIELD_BACK_EXTRA =
      ClozeField._(1, _omitEnumNames ? '' : 'CLOZE_FIELD_BACK_EXTRA');

  static const $core.List<ClozeField> values = <ClozeField>[
    CLOZE_FIELD_TEXT,
    CLOZE_FIELD_BACK_EXTRA,
  ];

  static final $core.List<ClozeField?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static ClozeField? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ClozeField._(super.value, super.name);
}

class Notetype_Config_Kind extends $pb.ProtobufEnum {
  static const Notetype_Config_Kind KIND_NORMAL =
      Notetype_Config_Kind._(0, _omitEnumNames ? '' : 'KIND_NORMAL');
  static const Notetype_Config_Kind KIND_CLOZE =
      Notetype_Config_Kind._(1, _omitEnumNames ? '' : 'KIND_CLOZE');

  static const $core.List<Notetype_Config_Kind> values = <Notetype_Config_Kind>[
    KIND_NORMAL,
    KIND_CLOZE,
  ];

  static final $core.List<Notetype_Config_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static Notetype_Config_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Notetype_Config_Kind._(super.value, super.name);
}

class Notetype_Config_CardRequirement_Kind extends $pb.ProtobufEnum {
  static const Notetype_Config_CardRequirement_Kind KIND_NONE =
      Notetype_Config_CardRequirement_Kind._(
          0, _omitEnumNames ? '' : 'KIND_NONE');
  static const Notetype_Config_CardRequirement_Kind KIND_ANY =
      Notetype_Config_CardRequirement_Kind._(
          1, _omitEnumNames ? '' : 'KIND_ANY');
  static const Notetype_Config_CardRequirement_Kind KIND_ALL =
      Notetype_Config_CardRequirement_Kind._(
          2, _omitEnumNames ? '' : 'KIND_ALL');

  static const $core.List<Notetype_Config_CardRequirement_Kind> values =
      <Notetype_Config_CardRequirement_Kind>[
    KIND_NONE,
    KIND_ANY,
    KIND_ALL,
  ];

  static final $core.List<Notetype_Config_CardRequirement_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Notetype_Config_CardRequirement_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Notetype_Config_CardRequirement_Kind._(super.value, super.name);
}

class StockNotetype_Kind extends $pb.ProtobufEnum {
  static const StockNotetype_Kind KIND_BASIC =
      StockNotetype_Kind._(0, _omitEnumNames ? '' : 'KIND_BASIC');
  static const StockNotetype_Kind KIND_BASIC_AND_REVERSED =
      StockNotetype_Kind._(1, _omitEnumNames ? '' : 'KIND_BASIC_AND_REVERSED');
  static const StockNotetype_Kind KIND_BASIC_OPTIONAL_REVERSED =
      StockNotetype_Kind._(
          2, _omitEnumNames ? '' : 'KIND_BASIC_OPTIONAL_REVERSED');
  static const StockNotetype_Kind KIND_BASIC_TYPING =
      StockNotetype_Kind._(3, _omitEnumNames ? '' : 'KIND_BASIC_TYPING');
  static const StockNotetype_Kind KIND_CLOZE =
      StockNotetype_Kind._(4, _omitEnumNames ? '' : 'KIND_CLOZE');
  static const StockNotetype_Kind KIND_IMAGE_OCCLUSION =
      StockNotetype_Kind._(5, _omitEnumNames ? '' : 'KIND_IMAGE_OCCLUSION');

  static const $core.List<StockNotetype_Kind> values = <StockNotetype_Kind>[
    KIND_BASIC,
    KIND_BASIC_AND_REVERSED,
    KIND_BASIC_OPTIONAL_REVERSED,
    KIND_BASIC_TYPING,
    KIND_CLOZE,
    KIND_IMAGE_OCCLUSION,
  ];

  static final $core.List<StockNotetype_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static StockNotetype_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StockNotetype_Kind._(super.value, super.name);
}

/// This is decoupled from Kind to allow us to evolve notetypes over time
/// (eg an older notetype might require different JS), and allow us to store
/// a type even for notetypes that we don't add by default. Code should not
/// assume that the entries here are always +1 from Kind.
class StockNotetype_OriginalStockKind extends $pb.ProtobufEnum {
  static const StockNotetype_OriginalStockKind ORIGINAL_STOCK_KIND_UNKNOWN =
      StockNotetype_OriginalStockKind._(
          0, _omitEnumNames ? '' : 'ORIGINAL_STOCK_KIND_UNKNOWN');
  static const StockNotetype_OriginalStockKind ORIGINAL_STOCK_KIND_BASIC =
      StockNotetype_OriginalStockKind._(
          1, _omitEnumNames ? '' : 'ORIGINAL_STOCK_KIND_BASIC');
  static const StockNotetype_OriginalStockKind
      ORIGINAL_STOCK_KIND_BASIC_AND_REVERSED =
      StockNotetype_OriginalStockKind._(
          2, _omitEnumNames ? '' : 'ORIGINAL_STOCK_KIND_BASIC_AND_REVERSED');
  static const StockNotetype_OriginalStockKind
      ORIGINAL_STOCK_KIND_BASIC_OPTIONAL_REVERSED =
      StockNotetype_OriginalStockKind._(3,
          _omitEnumNames ? '' : 'ORIGINAL_STOCK_KIND_BASIC_OPTIONAL_REVERSED');
  static const StockNotetype_OriginalStockKind
      ORIGINAL_STOCK_KIND_BASIC_TYPING = StockNotetype_OriginalStockKind._(
          4, _omitEnumNames ? '' : 'ORIGINAL_STOCK_KIND_BASIC_TYPING');
  static const StockNotetype_OriginalStockKind ORIGINAL_STOCK_KIND_CLOZE =
      StockNotetype_OriginalStockKind._(
          5, _omitEnumNames ? '' : 'ORIGINAL_STOCK_KIND_CLOZE');
  static const StockNotetype_OriginalStockKind
      ORIGINAL_STOCK_KIND_IMAGE_OCCLUSION = StockNotetype_OriginalStockKind._(
          6, _omitEnumNames ? '' : 'ORIGINAL_STOCK_KIND_IMAGE_OCCLUSION');

  static const $core.List<StockNotetype_OriginalStockKind> values =
      <StockNotetype_OriginalStockKind>[
    ORIGINAL_STOCK_KIND_UNKNOWN,
    ORIGINAL_STOCK_KIND_BASIC,
    ORIGINAL_STOCK_KIND_BASIC_AND_REVERSED,
    ORIGINAL_STOCK_KIND_BASIC_OPTIONAL_REVERSED,
    ORIGINAL_STOCK_KIND_BASIC_TYPING,
    ORIGINAL_STOCK_KIND_CLOZE,
    ORIGINAL_STOCK_KIND_IMAGE_OCCLUSION,
  ];

  static final $core.List<StockNotetype_OriginalStockKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static StockNotetype_OriginalStockKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StockNotetype_OriginalStockKind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
