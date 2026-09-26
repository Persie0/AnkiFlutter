// This is a generated file - do not edit.
//
// Generated from anki/notetypes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'collection.pb.dart' as $1;
import 'generic.pb.dart' as $0;
import 'notetypes.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'notetypes.pbenum.dart';

class NotetypeId extends $pb.GeneratedMessage {
  factory NotetypeId({
    $fixnum.Int64? ntid,
  }) {
    final result = NotetypeId._();
    if (ntid != null) result.ntid = ntid;
    return result;
  }

  NotetypeId._();

  factory NotetypeId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeId()..mergeFromBuffer(data, registry);
  factory NotetypeId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotetypeId',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: NotetypeId.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'ntid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeId copyWith(void Function(NotetypeId) updates) =>
      super.copyWith((message) => updates(message as NotetypeId)) as NotetypeId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use NotetypeId() / NotetypeId.new instead')
  static NotetypeId create() => NotetypeId._();
  static $pb.GeneratedMessage $_createMessage() => NotetypeId._();
  @$core.override
  NotetypeId createEmptyInstance() => NotetypeId._();
  @$core.pragma('dart2js:noInline')
  static NotetypeId getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotetypeId>(NotetypeId.$_createMessage);
  static NotetypeId? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get ntid => $_getI64(0);
  @$pb.TagNumber(1)
  set ntid($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNtid() => $_has(0);
  @$pb.TagNumber(1)
  void clearNtid() => $_clearField(1);
}

class Notetype_Config_CardRequirement extends $pb.GeneratedMessage {
  factory Notetype_Config_CardRequirement({
    $core.int? cardOrd,
    Notetype_Config_CardRequirement_Kind? kind,
    $core.Iterable<$core.int>? fieldOrds,
  }) {
    final result = Notetype_Config_CardRequirement._();
    if (cardOrd != null) result.cardOrd = cardOrd;
    if (kind != null) result.kind = kind;
    if (fieldOrds != null) result.fieldOrds.addAll(fieldOrds);
    return result;
  }

  Notetype_Config_CardRequirement._();

  factory Notetype_Config_CardRequirement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Config_CardRequirement()..mergeFromBuffer(data, registry);
  factory Notetype_Config_CardRequirement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Config_CardRequirement()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Notetype.Config.CardRequirement',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: Notetype_Config_CardRequirement.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'cardOrd', fieldType: $pb.PbFieldType.OU3)
    ..aE<Notetype_Config_CardRequirement_Kind>(2, _omitFieldNames ? '' : 'kind',
        enumValues: Notetype_Config_CardRequirement_Kind.values)
    ..p<$core.int>(3, _omitFieldNames ? '' : 'fieldOrds', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Config_CardRequirement clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Config_CardRequirement copyWith(
          void Function(Notetype_Config_CardRequirement) updates) =>
      super.copyWith(
              (message) => updates(message as Notetype_Config_CardRequirement))
          as Notetype_Config_CardRequirement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Notetype_Config_CardRequirement() / Notetype_Config_CardRequirement.new instead')
  static Notetype_Config_CardRequirement create() =>
      Notetype_Config_CardRequirement._();
  static $pb.GeneratedMessage $_createMessage() =>
      Notetype_Config_CardRequirement._();
  @$core.override
  Notetype_Config_CardRequirement createEmptyInstance() =>
      Notetype_Config_CardRequirement._();
  @$core.pragma('dart2js:noInline')
  static Notetype_Config_CardRequirement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Notetype_Config_CardRequirement>(
          Notetype_Config_CardRequirement.$_createMessage);
  static Notetype_Config_CardRequirement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get cardOrd => $_getIZ(0);
  @$pb.TagNumber(1)
  set cardOrd($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardOrd() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardOrd() => $_clearField(1);

  @$pb.TagNumber(2)
  Notetype_Config_CardRequirement_Kind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(Notetype_Config_CardRequirement_Kind value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get fieldOrds => $_getList(2);
}

class Notetype_Config extends $pb.GeneratedMessage {
  factory Notetype_Config({
    Notetype_Config_Kind? kind,
    $core.int? sortFieldIdx,
    $core.String? css,
    $fixnum.Int64? targetDeckIdUnused,
    $core.String? latexPre,
    $core.String? latexPost,
    $core.bool? latexSvg,
    $core.Iterable<Notetype_Config_CardRequirement>? reqs,
    StockNotetype_OriginalStockKind? originalStockKind,
    $fixnum.Int64? originalId,
    $core.List<$core.int>? other,
  }) {
    final result = Notetype_Config._();
    if (kind != null) result.kind = kind;
    if (sortFieldIdx != null) result.sortFieldIdx = sortFieldIdx;
    if (css != null) result.css = css;
    if (targetDeckIdUnused != null)
      result.targetDeckIdUnused = targetDeckIdUnused;
    if (latexPre != null) result.latexPre = latexPre;
    if (latexPost != null) result.latexPost = latexPost;
    if (latexSvg != null) result.latexSvg = latexSvg;
    if (reqs != null) result.reqs.addAll(reqs);
    if (originalStockKind != null) result.originalStockKind = originalStockKind;
    if (originalId != null) result.originalId = originalId;
    if (other != null) result.other = other;
    return result;
  }

  Notetype_Config._();

  factory Notetype_Config.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Config()..mergeFromBuffer(data, registry);
  factory Notetype_Config.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Config()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Notetype.Config',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: Notetype_Config.$_createMessage)
    ..aE<Notetype_Config_Kind>(1, _omitFieldNames ? '' : 'kind',
        enumValues: Notetype_Config_Kind.values)
    ..aI(2, _omitFieldNames ? '' : 'sortFieldIdx',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'css')
    ..aInt64(4, _omitFieldNames ? '' : 'targetDeckIdUnused')
    ..aOS(5, _omitFieldNames ? '' : 'latexPre')
    ..aOS(6, _omitFieldNames ? '' : 'latexPost')
    ..aOB(7, _omitFieldNames ? '' : 'latexSvg')
    ..pPM<Notetype_Config_CardRequirement>(8, _omitFieldNames ? '' : 'reqs',
        subBuilder: Notetype_Config_CardRequirement.$_createMessage)
    ..aE<StockNotetype_OriginalStockKind>(
        9, _omitFieldNames ? '' : 'originalStockKind',
        enumValues: StockNotetype_OriginalStockKind.values)
    ..aInt64(10, _omitFieldNames ? '' : 'originalId')
    ..a<$core.List<$core.int>>(
        255, _omitFieldNames ? '' : 'other', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Config clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Config copyWith(void Function(Notetype_Config) updates) =>
      super.copyWith((message) => updates(message as Notetype_Config))
          as Notetype_Config;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Notetype_Config() / Notetype_Config.new instead')
  static Notetype_Config create() => Notetype_Config._();
  static $pb.GeneratedMessage $_createMessage() => Notetype_Config._();
  @$core.override
  Notetype_Config createEmptyInstance() => Notetype_Config._();
  @$core.pragma('dart2js:noInline')
  static Notetype_Config getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Notetype_Config>(
          Notetype_Config.$_createMessage);
  static Notetype_Config? _defaultInstance;

  @$pb.TagNumber(1)
  Notetype_Config_Kind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(Notetype_Config_Kind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get sortFieldIdx => $_getIZ(1);
  @$pb.TagNumber(2)
  set sortFieldIdx($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSortFieldIdx() => $_has(1);
  @$pb.TagNumber(2)
  void clearSortFieldIdx() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get css => $_getSZ(2);
  @$pb.TagNumber(3)
  set css($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCss() => $_has(2);
  @$pb.TagNumber(3)
  void clearCss() => $_clearField(3);

  /// This is now stored separately; retrieve with DefaultsForAdding()
  @$pb.TagNumber(4)
  $fixnum.Int64 get targetDeckIdUnused => $_getI64(3);
  @$pb.TagNumber(4)
  set targetDeckIdUnused($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetDeckIdUnused() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetDeckIdUnused() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get latexPre => $_getSZ(4);
  @$pb.TagNumber(5)
  set latexPre($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLatexPre() => $_has(4);
  @$pb.TagNumber(5)
  void clearLatexPre() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get latexPost => $_getSZ(5);
  @$pb.TagNumber(6)
  set latexPost($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLatexPost() => $_has(5);
  @$pb.TagNumber(6)
  void clearLatexPost() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get latexSvg => $_getBF(6);
  @$pb.TagNumber(7)
  set latexSvg($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLatexSvg() => $_has(6);
  @$pb.TagNumber(7)
  void clearLatexSvg() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<Notetype_Config_CardRequirement> get reqs => $_getList(7);

  /// Only set on notetypes created with Anki 2.1.62+.
  @$pb.TagNumber(9)
  StockNotetype_OriginalStockKind get originalStockKind => $_getN(8);
  @$pb.TagNumber(9)
  set originalStockKind(StockNotetype_OriginalStockKind value) =>
      $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasOriginalStockKind() => $_has(8);
  @$pb.TagNumber(9)
  void clearOriginalStockKind() => $_clearField(9);

  /// the id in the source collection for imported notetypes (Anki 23.10)
  @$pb.TagNumber(10)
  $fixnum.Int64 get originalId => $_getI64(9);
  @$pb.TagNumber(10)
  set originalId($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasOriginalId() => $_has(9);
  @$pb.TagNumber(10)
  void clearOriginalId() => $_clearField(10);

  @$pb.TagNumber(255)
  $core.List<$core.int> get other => $_getN(10);
  @$pb.TagNumber(255)
  set other($core.List<$core.int> value) => $_setBytes(10, value);
  @$pb.TagNumber(255)
  $core.bool hasOther() => $_has(10);
  @$pb.TagNumber(255)
  void clearOther() => $_clearField(255);
}

class Notetype_Field_Config extends $pb.GeneratedMessage {
  factory Notetype_Field_Config({
    $core.bool? sticky,
    $core.bool? rtl,
    $core.String? fontName,
    $core.int? fontSize,
    $core.String? description,
    $core.bool? plainText,
    $core.bool? collapsed,
    $core.bool? excludeFromSearch,
    $fixnum.Int64? id,
    $core.int? tag,
    $core.bool? preventDeletion,
    $core.List<$core.int>? other,
  }) {
    final result = Notetype_Field_Config._();
    if (sticky != null) result.sticky = sticky;
    if (rtl != null) result.rtl = rtl;
    if (fontName != null) result.fontName = fontName;
    if (fontSize != null) result.fontSize = fontSize;
    if (description != null) result.description = description;
    if (plainText != null) result.plainText = plainText;
    if (collapsed != null) result.collapsed = collapsed;
    if (excludeFromSearch != null) result.excludeFromSearch = excludeFromSearch;
    if (id != null) result.id = id;
    if (tag != null) result.tag = tag;
    if (preventDeletion != null) result.preventDeletion = preventDeletion;
    if (other != null) result.other = other;
    return result;
  }

  Notetype_Field_Config._();

  factory Notetype_Field_Config.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Field_Config()..mergeFromBuffer(data, registry);
  factory Notetype_Field_Config.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Field_Config()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Notetype.Field.Config',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: Notetype_Field_Config.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'sticky')
    ..aOB(2, _omitFieldNames ? '' : 'rtl')
    ..aOS(3, _omitFieldNames ? '' : 'fontName')
    ..aI(4, _omitFieldNames ? '' : 'fontSize', fieldType: $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOB(6, _omitFieldNames ? '' : 'plainText')
    ..aOB(7, _omitFieldNames ? '' : 'collapsed')
    ..aOB(8, _omitFieldNames ? '' : 'excludeFromSearch')
    ..aInt64(9, _omitFieldNames ? '' : 'id')
    ..aI(10, _omitFieldNames ? '' : 'tag', fieldType: $pb.PbFieldType.OU3)
    ..aOB(11, _omitFieldNames ? '' : 'preventDeletion')
    ..a<$core.List<$core.int>>(
        255, _omitFieldNames ? '' : 'other', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Field_Config clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Field_Config copyWith(
          void Function(Notetype_Field_Config) updates) =>
      super.copyWith((message) => updates(message as Notetype_Field_Config))
          as Notetype_Field_Config;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Notetype_Field_Config() / Notetype_Field_Config.new instead')
  static Notetype_Field_Config create() => Notetype_Field_Config._();
  static $pb.GeneratedMessage $_createMessage() => Notetype_Field_Config._();
  @$core.override
  Notetype_Field_Config createEmptyInstance() => Notetype_Field_Config._();
  @$core.pragma('dart2js:noInline')
  static Notetype_Field_Config getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Notetype_Field_Config>(
          Notetype_Field_Config.$_createMessage);
  static Notetype_Field_Config? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get sticky => $_getBF(0);
  @$pb.TagNumber(1)
  set sticky($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSticky() => $_has(0);
  @$pb.TagNumber(1)
  void clearSticky() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get rtl => $_getBF(1);
  @$pb.TagNumber(2)
  set rtl($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRtl() => $_has(1);
  @$pb.TagNumber(2)
  void clearRtl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fontName => $_getSZ(2);
  @$pb.TagNumber(3)
  set fontName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFontName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFontName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get fontSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set fontSize($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFontSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearFontSize() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get plainText => $_getBF(5);
  @$pb.TagNumber(6)
  set plainText($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPlainText() => $_has(5);
  @$pb.TagNumber(6)
  void clearPlainText() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get collapsed => $_getBF(6);
  @$pb.TagNumber(7)
  set collapsed($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCollapsed() => $_has(6);
  @$pb.TagNumber(7)
  void clearCollapsed() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get excludeFromSearch => $_getBF(7);
  @$pb.TagNumber(8)
  set excludeFromSearch($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasExcludeFromSearch() => $_has(7);
  @$pb.TagNumber(8)
  void clearExcludeFromSearch() => $_clearField(8);

  /// used for merging notetypes on import (Anki 23.10)
  @$pb.TagNumber(9)
  $fixnum.Int64 get id => $_getI64(8);
  @$pb.TagNumber(9)
  set id($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasId() => $_has(8);
  @$pb.TagNumber(9)
  void clearId() => $_clearField(9);

  /// Can be used to uniquely identify required fields.
  @$pb.TagNumber(10)
  $core.int get tag => $_getIZ(9);
  @$pb.TagNumber(10)
  set tag($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTag() => $_has(9);
  @$pb.TagNumber(10)
  void clearTag() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get preventDeletion => $_getBF(10);
  @$pb.TagNumber(11)
  set preventDeletion($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPreventDeletion() => $_has(10);
  @$pb.TagNumber(11)
  void clearPreventDeletion() => $_clearField(11);

  @$pb.TagNumber(255)
  $core.List<$core.int> get other => $_getN(11);
  @$pb.TagNumber(255)
  set other($core.List<$core.int> value) => $_setBytes(11, value);
  @$pb.TagNumber(255)
  $core.bool hasOther() => $_has(11);
  @$pb.TagNumber(255)
  void clearOther() => $_clearField(255);
}

class Notetype_Field extends $pb.GeneratedMessage {
  factory Notetype_Field({
    $0.UInt32? ord,
    $core.String? name,
    Notetype_Field_Config? config,
  }) {
    final result = Notetype_Field._();
    if (ord != null) result.ord = ord;
    if (name != null) result.name = name;
    if (config != null) result.config = config;
    return result;
  }

  Notetype_Field._();

  factory Notetype_Field.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Field()..mergeFromBuffer(data, registry);
  factory Notetype_Field.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Field()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Notetype.Field',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: Notetype_Field.$_createMessage)
    ..aOM<$0.UInt32>(1, _omitFieldNames ? '' : 'ord',
        subBuilder: $0.UInt32.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<Notetype_Field_Config>(5, _omitFieldNames ? '' : 'config',
        subBuilder: Notetype_Field_Config.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Field clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Field copyWith(void Function(Notetype_Field) updates) =>
      super.copyWith((message) => updates(message as Notetype_Field))
          as Notetype_Field;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Notetype_Field() / Notetype_Field.new instead')
  static Notetype_Field create() => Notetype_Field._();
  static $pb.GeneratedMessage $_createMessage() => Notetype_Field._();
  @$core.override
  Notetype_Field createEmptyInstance() => Notetype_Field._();
  @$core.pragma('dart2js:noInline')
  static Notetype_Field getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Notetype_Field>(
          Notetype_Field.$_createMessage);
  static Notetype_Field? _defaultInstance;

  @$pb.TagNumber(1)
  $0.UInt32 get ord => $_getN(0);
  @$pb.TagNumber(1)
  set ord($0.UInt32 value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrd() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrd() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.UInt32 ensureOrd() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(5)
  Notetype_Field_Config get config => $_getN(2);
  @$pb.TagNumber(5)
  set config(Notetype_Field_Config value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasConfig() => $_has(2);
  @$pb.TagNumber(5)
  void clearConfig() => $_clearField(5);
  @$pb.TagNumber(5)
  Notetype_Field_Config ensureConfig() => $_ensure(2);
}

class Notetype_Template_Config extends $pb.GeneratedMessage {
  factory Notetype_Template_Config({
    $core.String? qFormat,
    $core.String? aFormat,
    $core.String? qFormatBrowser,
    $core.String? aFormatBrowser,
    $fixnum.Int64? targetDeckId,
    $core.String? browserFontName,
    $core.int? browserFontSize,
    $fixnum.Int64? id,
    $core.List<$core.int>? other,
  }) {
    final result = Notetype_Template_Config._();
    if (qFormat != null) result.qFormat = qFormat;
    if (aFormat != null) result.aFormat = aFormat;
    if (qFormatBrowser != null) result.qFormatBrowser = qFormatBrowser;
    if (aFormatBrowser != null) result.aFormatBrowser = aFormatBrowser;
    if (targetDeckId != null) result.targetDeckId = targetDeckId;
    if (browserFontName != null) result.browserFontName = browserFontName;
    if (browserFontSize != null) result.browserFontSize = browserFontSize;
    if (id != null) result.id = id;
    if (other != null) result.other = other;
    return result;
  }

  Notetype_Template_Config._();

  factory Notetype_Template_Config.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Template_Config()..mergeFromBuffer(data, registry);
  factory Notetype_Template_Config.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Template_Config()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Notetype.Template.Config',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: Notetype_Template_Config.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'qFormat')
    ..aOS(2, _omitFieldNames ? '' : 'aFormat')
    ..aOS(3, _omitFieldNames ? '' : 'qFormatBrowser')
    ..aOS(4, _omitFieldNames ? '' : 'aFormatBrowser')
    ..aInt64(5, _omitFieldNames ? '' : 'targetDeckId')
    ..aOS(6, _omitFieldNames ? '' : 'browserFontName')
    ..aI(7, _omitFieldNames ? '' : 'browserFontSize',
        fieldType: $pb.PbFieldType.OU3)
    ..aInt64(8, _omitFieldNames ? '' : 'id')
    ..a<$core.List<$core.int>>(
        255, _omitFieldNames ? '' : 'other', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Template_Config clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Template_Config copyWith(
          void Function(Notetype_Template_Config) updates) =>
      super.copyWith((message) => updates(message as Notetype_Template_Config))
          as Notetype_Template_Config;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Notetype_Template_Config() / Notetype_Template_Config.new instead')
  static Notetype_Template_Config create() => Notetype_Template_Config._();
  static $pb.GeneratedMessage $_createMessage() => Notetype_Template_Config._();
  @$core.override
  Notetype_Template_Config createEmptyInstance() =>
      Notetype_Template_Config._();
  @$core.pragma('dart2js:noInline')
  static Notetype_Template_Config getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Notetype_Template_Config>(
          Notetype_Template_Config.$_createMessage);
  static Notetype_Template_Config? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get qFormat => $_getSZ(0);
  @$pb.TagNumber(1)
  set qFormat($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQFormat() => $_has(0);
  @$pb.TagNumber(1)
  void clearQFormat() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get aFormat => $_getSZ(1);
  @$pb.TagNumber(2)
  set aFormat($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAFormat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAFormat() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get qFormatBrowser => $_getSZ(2);
  @$pb.TagNumber(3)
  set qFormatBrowser($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQFormatBrowser() => $_has(2);
  @$pb.TagNumber(3)
  void clearQFormatBrowser() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get aFormatBrowser => $_getSZ(3);
  @$pb.TagNumber(4)
  set aFormatBrowser($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAFormatBrowser() => $_has(3);
  @$pb.TagNumber(4)
  void clearAFormatBrowser() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get targetDeckId => $_getI64(4);
  @$pb.TagNumber(5)
  set targetDeckId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetDeckId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetDeckId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get browserFontName => $_getSZ(5);
  @$pb.TagNumber(6)
  set browserFontName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBrowserFontName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBrowserFontName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get browserFontSize => $_getIZ(6);
  @$pb.TagNumber(7)
  set browserFontSize($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBrowserFontSize() => $_has(6);
  @$pb.TagNumber(7)
  void clearBrowserFontSize() => $_clearField(7);

  /// used for merging notetypes on import (Anki 23.10)
  @$pb.TagNumber(8)
  $fixnum.Int64 get id => $_getI64(7);
  @$pb.TagNumber(8)
  set id($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasId() => $_has(7);
  @$pb.TagNumber(8)
  void clearId() => $_clearField(8);

  @$pb.TagNumber(255)
  $core.List<$core.int> get other => $_getN(8);
  @$pb.TagNumber(255)
  set other($core.List<$core.int> value) => $_setBytes(8, value);
  @$pb.TagNumber(255)
  $core.bool hasOther() => $_has(8);
  @$pb.TagNumber(255)
  void clearOther() => $_clearField(255);
}

class Notetype_Template extends $pb.GeneratedMessage {
  factory Notetype_Template({
    $0.UInt32? ord,
    $core.String? name,
    $fixnum.Int64? mtimeSecs,
    $core.int? usn,
    Notetype_Template_Config? config,
  }) {
    final result = Notetype_Template._();
    if (ord != null) result.ord = ord;
    if (name != null) result.name = name;
    if (mtimeSecs != null) result.mtimeSecs = mtimeSecs;
    if (usn != null) result.usn = usn;
    if (config != null) result.config = config;
    return result;
  }

  Notetype_Template._();

  factory Notetype_Template.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Template()..mergeFromBuffer(data, registry);
  factory Notetype_Template.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype_Template()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Notetype.Template',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: Notetype_Template.$_createMessage)
    ..aOM<$0.UInt32>(1, _omitFieldNames ? '' : 'ord',
        subBuilder: $0.UInt32.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aInt64(3, _omitFieldNames ? '' : 'mtimeSecs')
    ..aI(4, _omitFieldNames ? '' : 'usn', fieldType: $pb.PbFieldType.OS3)
    ..aOM<Notetype_Template_Config>(5, _omitFieldNames ? '' : 'config',
        subBuilder: Notetype_Template_Config.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Template clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype_Template copyWith(void Function(Notetype_Template) updates) =>
      super.copyWith((message) => updates(message as Notetype_Template))
          as Notetype_Template;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Notetype_Template() / Notetype_Template.new instead')
  static Notetype_Template create() => Notetype_Template._();
  static $pb.GeneratedMessage $_createMessage() => Notetype_Template._();
  @$core.override
  Notetype_Template createEmptyInstance() => Notetype_Template._();
  @$core.pragma('dart2js:noInline')
  static Notetype_Template getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Notetype_Template>(
          Notetype_Template.$_createMessage);
  static Notetype_Template? _defaultInstance;

  @$pb.TagNumber(1)
  $0.UInt32 get ord => $_getN(0);
  @$pb.TagNumber(1)
  set ord($0.UInt32 value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrd() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrd() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.UInt32 ensureOrd() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get mtimeSecs => $_getI64(2);
  @$pb.TagNumber(3)
  set mtimeSecs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMtimeSecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearMtimeSecs() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get usn => $_getIZ(3);
  @$pb.TagNumber(4)
  set usn($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsn() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsn() => $_clearField(4);

  @$pb.TagNumber(5)
  Notetype_Template_Config get config => $_getN(4);
  @$pb.TagNumber(5)
  set config(Notetype_Template_Config value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasConfig() => $_has(4);
  @$pb.TagNumber(5)
  void clearConfig() => $_clearField(5);
  @$pb.TagNumber(5)
  Notetype_Template_Config ensureConfig() => $_ensure(4);
}

class Notetype extends $pb.GeneratedMessage {
  factory Notetype({
    $fixnum.Int64? id,
    $core.String? name,
    $fixnum.Int64? mtimeSecs,
    $core.int? usn,
    Notetype_Config? config,
    $core.Iterable<Notetype_Field>? fields,
    $core.Iterable<Notetype_Template>? templates,
  }) {
    final result = Notetype._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (mtimeSecs != null) result.mtimeSecs = mtimeSecs;
    if (usn != null) result.usn = usn;
    if (config != null) result.config = config;
    if (fields != null) result.fields.addAll(fields);
    if (templates != null) result.templates.addAll(templates);
    return result;
  }

  Notetype._();

  factory Notetype.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype()..mergeFromBuffer(data, registry);
  factory Notetype.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Notetype()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Notetype',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: Notetype.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aInt64(3, _omitFieldNames ? '' : 'mtimeSecs')
    ..aI(4, _omitFieldNames ? '' : 'usn', fieldType: $pb.PbFieldType.OS3)
    ..aOM<Notetype_Config>(7, _omitFieldNames ? '' : 'config',
        subBuilder: Notetype_Config.$_createMessage)
    ..pPM<Notetype_Field>(8, _omitFieldNames ? '' : 'fields',
        subBuilder: Notetype_Field.$_createMessage)
    ..pPM<Notetype_Template>(9, _omitFieldNames ? '' : 'templates',
        subBuilder: Notetype_Template.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Notetype copyWith(void Function(Notetype) updates) =>
      super.copyWith((message) => updates(message as Notetype)) as Notetype;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Notetype() / Notetype.new instead')
  static Notetype create() => Notetype._();
  static $pb.GeneratedMessage $_createMessage() => Notetype._();
  @$core.override
  Notetype createEmptyInstance() => Notetype._();
  @$core.pragma('dart2js:noInline')
  static Notetype getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Notetype>(Notetype.$_createMessage);
  static Notetype? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get mtimeSecs => $_getI64(2);
  @$pb.TagNumber(3)
  set mtimeSecs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMtimeSecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearMtimeSecs() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get usn => $_getIZ(3);
  @$pb.TagNumber(4)
  set usn($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsn() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsn() => $_clearField(4);

  @$pb.TagNumber(7)
  Notetype_Config get config => $_getN(4);
  @$pb.TagNumber(7)
  set config(Notetype_Config value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasConfig() => $_has(4);
  @$pb.TagNumber(7)
  void clearConfig() => $_clearField(7);
  @$pb.TagNumber(7)
  Notetype_Config ensureConfig() => $_ensure(4);

  @$pb.TagNumber(8)
  $pb.PbList<Notetype_Field> get fields => $_getList(5);

  @$pb.TagNumber(9)
  $pb.PbList<Notetype_Template> get templates => $_getList(6);
}

class AddOrUpdateNotetypeRequest extends $pb.GeneratedMessage {
  factory AddOrUpdateNotetypeRequest({
    $core.List<$core.int>? json,
    $core.bool? preserveUsnAndMtime,
    $core.bool? skipChecks,
  }) {
    final result = AddOrUpdateNotetypeRequest._();
    if (json != null) result.json = json;
    if (preserveUsnAndMtime != null)
      result.preserveUsnAndMtime = preserveUsnAndMtime;
    if (skipChecks != null) result.skipChecks = skipChecks;
    return result;
  }

  AddOrUpdateNotetypeRequest._();

  factory AddOrUpdateNotetypeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddOrUpdateNotetypeRequest()..mergeFromBuffer(data, registry);
  factory AddOrUpdateNotetypeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddOrUpdateNotetypeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddOrUpdateNotetypeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: AddOrUpdateNotetypeRequest.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'json', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'preserveUsnAndMtime')
    ..aOB(3, _omitFieldNames ? '' : 'skipChecks')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddOrUpdateNotetypeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddOrUpdateNotetypeRequest copyWith(
          void Function(AddOrUpdateNotetypeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AddOrUpdateNotetypeRequest))
          as AddOrUpdateNotetypeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AddOrUpdateNotetypeRequest() / AddOrUpdateNotetypeRequest.new instead')
  static AddOrUpdateNotetypeRequest create() => AddOrUpdateNotetypeRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      AddOrUpdateNotetypeRequest._();
  @$core.override
  AddOrUpdateNotetypeRequest createEmptyInstance() =>
      AddOrUpdateNotetypeRequest._();
  @$core.pragma('dart2js:noInline')
  static AddOrUpdateNotetypeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddOrUpdateNotetypeRequest>(
          AddOrUpdateNotetypeRequest.$_createMessage);
  static AddOrUpdateNotetypeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get json => $_getN(0);
  @$pb.TagNumber(1)
  set json($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearJson() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get preserveUsnAndMtime => $_getBF(1);
  @$pb.TagNumber(2)
  set preserveUsnAndMtime($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreserveUsnAndMtime() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreserveUsnAndMtime() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get skipChecks => $_getBF(2);
  @$pb.TagNumber(3)
  set skipChecks($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSkipChecks() => $_has(2);
  @$pb.TagNumber(3)
  void clearSkipChecks() => $_clearField(3);
}

class UpdateNotetypeLegacyRequest extends $pb.GeneratedMessage {
  factory UpdateNotetypeLegacyRequest({
    $core.List<$core.int>? json,
    $core.bool? skipChecks,
  }) {
    final result = UpdateNotetypeLegacyRequest._();
    if (json != null) result.json = json;
    if (skipChecks != null) result.skipChecks = skipChecks;
    return result;
  }

  UpdateNotetypeLegacyRequest._();

  factory UpdateNotetypeLegacyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateNotetypeLegacyRequest()..mergeFromBuffer(data, registry);
  factory UpdateNotetypeLegacyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateNotetypeLegacyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateNotetypeLegacyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: UpdateNotetypeLegacyRequest.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'json', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'skipChecks')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotetypeLegacyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotetypeLegacyRequest copyWith(
          void Function(UpdateNotetypeLegacyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateNotetypeLegacyRequest))
          as UpdateNotetypeLegacyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateNotetypeLegacyRequest() / UpdateNotetypeLegacyRequest.new instead')
  static UpdateNotetypeLegacyRequest create() =>
      UpdateNotetypeLegacyRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      UpdateNotetypeLegacyRequest._();
  @$core.override
  UpdateNotetypeLegacyRequest createEmptyInstance() =>
      UpdateNotetypeLegacyRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateNotetypeLegacyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateNotetypeLegacyRequest>(
          UpdateNotetypeLegacyRequest.$_createMessage);
  static UpdateNotetypeLegacyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get json => $_getN(0);
  @$pb.TagNumber(1)
  set json($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearJson() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get skipChecks => $_getBF(1);
  @$pb.TagNumber(2)
  set skipChecks($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSkipChecks() => $_has(1);
  @$pb.TagNumber(2)
  void clearSkipChecks() => $_clearField(2);
}

class StockNotetype extends $pb.GeneratedMessage {
  factory StockNotetype({
    StockNotetype_Kind? kind,
  }) {
    final result = StockNotetype._();
    if (kind != null) result.kind = kind;
    return result;
  }

  StockNotetype._();

  factory StockNotetype.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StockNotetype()..mergeFromBuffer(data, registry);
  factory StockNotetype.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StockNotetype()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StockNotetype',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: StockNotetype.$_createMessage)
    ..aE<StockNotetype_Kind>(1, _omitFieldNames ? '' : 'kind',
        enumValues: StockNotetype_Kind.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockNotetype clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockNotetype copyWith(void Function(StockNotetype) updates) =>
      super.copyWith((message) => updates(message as StockNotetype))
          as StockNotetype;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StockNotetype() / StockNotetype.new instead')
  static StockNotetype create() => StockNotetype._();
  static $pb.GeneratedMessage $_createMessage() => StockNotetype._();
  @$core.override
  StockNotetype createEmptyInstance() => StockNotetype._();
  @$core.pragma('dart2js:noInline')
  static StockNotetype getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StockNotetype>(
          StockNotetype.$_createMessage);
  static StockNotetype? _defaultInstance;

  @$pb.TagNumber(1)
  StockNotetype_Kind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(StockNotetype_Kind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);
}

class NotetypeNames extends $pb.GeneratedMessage {
  factory NotetypeNames({
    $core.Iterable<NotetypeNameId>? entries,
  }) {
    final result = NotetypeNames._();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  NotetypeNames._();

  factory NotetypeNames.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeNames()..mergeFromBuffer(data, registry);
  factory NotetypeNames.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeNames()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotetypeNames',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: NotetypeNames.$_createMessage)
    ..pPM<NotetypeNameId>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: NotetypeNameId.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeNames clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeNames copyWith(void Function(NotetypeNames) updates) =>
      super.copyWith((message) => updates(message as NotetypeNames))
          as NotetypeNames;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use NotetypeNames() / NotetypeNames.new instead')
  static NotetypeNames create() => NotetypeNames._();
  static $pb.GeneratedMessage $_createMessage() => NotetypeNames._();
  @$core.override
  NotetypeNames createEmptyInstance() => NotetypeNames._();
  @$core.pragma('dart2js:noInline')
  static NotetypeNames getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotetypeNames>(
          NotetypeNames.$_createMessage);
  static NotetypeNames? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NotetypeNameId> get entries => $_getList(0);
}

class NotetypeUseCounts extends $pb.GeneratedMessage {
  factory NotetypeUseCounts({
    $core.Iterable<NotetypeNameIdUseCount>? entries,
  }) {
    final result = NotetypeUseCounts._();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  NotetypeUseCounts._();

  factory NotetypeUseCounts.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeUseCounts()..mergeFromBuffer(data, registry);
  factory NotetypeUseCounts.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeUseCounts()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotetypeUseCounts',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: NotetypeUseCounts.$_createMessage)
    ..pPM<NotetypeNameIdUseCount>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: NotetypeNameIdUseCount.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeUseCounts clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeUseCounts copyWith(void Function(NotetypeUseCounts) updates) =>
      super.copyWith((message) => updates(message as NotetypeUseCounts))
          as NotetypeUseCounts;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use NotetypeUseCounts() / NotetypeUseCounts.new instead')
  static NotetypeUseCounts create() => NotetypeUseCounts._();
  static $pb.GeneratedMessage $_createMessage() => NotetypeUseCounts._();
  @$core.override
  NotetypeUseCounts createEmptyInstance() => NotetypeUseCounts._();
  @$core.pragma('dart2js:noInline')
  static NotetypeUseCounts getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotetypeUseCounts>(
          NotetypeUseCounts.$_createMessage);
  static NotetypeUseCounts? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NotetypeNameIdUseCount> get entries => $_getList(0);
}

class NotetypeNameId extends $pb.GeneratedMessage {
  factory NotetypeNameId({
    $fixnum.Int64? id,
    $core.String? name,
  }) {
    final result = NotetypeNameId._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  NotetypeNameId._();

  factory NotetypeNameId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeNameId()..mergeFromBuffer(data, registry);
  factory NotetypeNameId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeNameId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotetypeNameId',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: NotetypeNameId.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeNameId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeNameId copyWith(void Function(NotetypeNameId) updates) =>
      super.copyWith((message) => updates(message as NotetypeNameId))
          as NotetypeNameId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use NotetypeNameId() / NotetypeNameId.new instead')
  static NotetypeNameId create() => NotetypeNameId._();
  static $pb.GeneratedMessage $_createMessage() => NotetypeNameId._();
  @$core.override
  NotetypeNameId createEmptyInstance() => NotetypeNameId._();
  @$core.pragma('dart2js:noInline')
  static NotetypeNameId getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotetypeNameId>(
          NotetypeNameId.$_createMessage);
  static NotetypeNameId? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class NotetypeNameIdUseCount extends $pb.GeneratedMessage {
  factory NotetypeNameIdUseCount({
    $fixnum.Int64? id,
    $core.String? name,
    $core.int? useCount,
  }) {
    final result = NotetypeNameIdUseCount._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (useCount != null) result.useCount = useCount;
    return result;
  }

  NotetypeNameIdUseCount._();

  factory NotetypeNameIdUseCount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeNameIdUseCount()..mergeFromBuffer(data, registry);
  factory NotetypeNameIdUseCount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NotetypeNameIdUseCount()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotetypeNameIdUseCount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: NotetypeNameIdUseCount.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aI(3, _omitFieldNames ? '' : 'useCount', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeNameIdUseCount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotetypeNameIdUseCount copyWith(
          void Function(NotetypeNameIdUseCount) updates) =>
      super.copyWith((message) => updates(message as NotetypeNameIdUseCount))
          as NotetypeNameIdUseCount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use NotetypeNameIdUseCount() / NotetypeNameIdUseCount.new instead')
  static NotetypeNameIdUseCount create() => NotetypeNameIdUseCount._();
  static $pb.GeneratedMessage $_createMessage() => NotetypeNameIdUseCount._();
  @$core.override
  NotetypeNameIdUseCount createEmptyInstance() => NotetypeNameIdUseCount._();
  @$core.pragma('dart2js:noInline')
  static NotetypeNameIdUseCount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotetypeNameIdUseCount>(
          NotetypeNameIdUseCount.$_createMessage);
  static NotetypeNameIdUseCount? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get useCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set useCount($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUseCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearUseCount() => $_clearField(3);
}

class GetAuxConfigKeyRequest extends $pb.GeneratedMessage {
  factory GetAuxConfigKeyRequest({
    $fixnum.Int64? id,
    $core.String? key,
  }) {
    final result = GetAuxConfigKeyRequest._();
    if (id != null) result.id = id;
    if (key != null) result.key = key;
    return result;
  }

  GetAuxConfigKeyRequest._();

  factory GetAuxConfigKeyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAuxConfigKeyRequest()..mergeFromBuffer(data, registry);
  factory GetAuxConfigKeyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAuxConfigKeyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAuxConfigKeyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: GetAuxConfigKeyRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'key')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuxConfigKeyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuxConfigKeyRequest copyWith(
          void Function(GetAuxConfigKeyRequest) updates) =>
      super.copyWith((message) => updates(message as GetAuxConfigKeyRequest))
          as GetAuxConfigKeyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetAuxConfigKeyRequest() / GetAuxConfigKeyRequest.new instead')
  static GetAuxConfigKeyRequest create() => GetAuxConfigKeyRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetAuxConfigKeyRequest._();
  @$core.override
  GetAuxConfigKeyRequest createEmptyInstance() => GetAuxConfigKeyRequest._();
  @$core.pragma('dart2js:noInline')
  static GetAuxConfigKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAuxConfigKeyRequest>(
          GetAuxConfigKeyRequest.$_createMessage);
  static GetAuxConfigKeyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get key => $_getSZ(1);
  @$pb.TagNumber(2)
  set key($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => $_clearField(2);
}

class GetAuxTemplateConfigKeyRequest extends $pb.GeneratedMessage {
  factory GetAuxTemplateConfigKeyRequest({
    $fixnum.Int64? notetypeId,
    $core.int? cardOrdinal,
    $core.String? key,
  }) {
    final result = GetAuxTemplateConfigKeyRequest._();
    if (notetypeId != null) result.notetypeId = notetypeId;
    if (cardOrdinal != null) result.cardOrdinal = cardOrdinal;
    if (key != null) result.key = key;
    return result;
  }

  GetAuxTemplateConfigKeyRequest._();

  factory GetAuxTemplateConfigKeyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAuxTemplateConfigKeyRequest()..mergeFromBuffer(data, registry);
  factory GetAuxTemplateConfigKeyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAuxTemplateConfigKeyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAuxTemplateConfigKeyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: GetAuxTemplateConfigKeyRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'notetypeId')
    ..aI(2, _omitFieldNames ? '' : 'cardOrdinal',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'key')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuxTemplateConfigKeyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAuxTemplateConfigKeyRequest copyWith(
          void Function(GetAuxTemplateConfigKeyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAuxTemplateConfigKeyRequest))
          as GetAuxTemplateConfigKeyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetAuxTemplateConfigKeyRequest() / GetAuxTemplateConfigKeyRequest.new instead')
  static GetAuxTemplateConfigKeyRequest create() =>
      GetAuxTemplateConfigKeyRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetAuxTemplateConfigKeyRequest._();
  @$core.override
  GetAuxTemplateConfigKeyRequest createEmptyInstance() =>
      GetAuxTemplateConfigKeyRequest._();
  @$core.pragma('dart2js:noInline')
  static GetAuxTemplateConfigKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAuxTemplateConfigKeyRequest>(
          GetAuxTemplateConfigKeyRequest.$_createMessage);
  static GetAuxTemplateConfigKeyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get notetypeId => $_getI64(0);
  @$pb.TagNumber(1)
  set notetypeId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNotetypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotetypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get cardOrdinal => $_getIZ(1);
  @$pb.TagNumber(2)
  set cardOrdinal($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardOrdinal() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardOrdinal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get key => $_getSZ(2);
  @$pb.TagNumber(3)
  set key($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearKey() => $_clearField(3);
}

class GetChangeNotetypeInfoRequest extends $pb.GeneratedMessage {
  factory GetChangeNotetypeInfoRequest({
    $fixnum.Int64? oldNotetypeId,
    $fixnum.Int64? newNotetypeId,
  }) {
    final result = GetChangeNotetypeInfoRequest._();
    if (oldNotetypeId != null) result.oldNotetypeId = oldNotetypeId;
    if (newNotetypeId != null) result.newNotetypeId = newNotetypeId;
    return result;
  }

  GetChangeNotetypeInfoRequest._();

  factory GetChangeNotetypeInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetChangeNotetypeInfoRequest()..mergeFromBuffer(data, registry);
  factory GetChangeNotetypeInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetChangeNotetypeInfoRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChangeNotetypeInfoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: GetChangeNotetypeInfoRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'oldNotetypeId')
    ..aInt64(2, _omitFieldNames ? '' : 'newNotetypeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChangeNotetypeInfoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChangeNotetypeInfoRequest copyWith(
          void Function(GetChangeNotetypeInfoRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetChangeNotetypeInfoRequest))
          as GetChangeNotetypeInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetChangeNotetypeInfoRequest() / GetChangeNotetypeInfoRequest.new instead')
  static GetChangeNotetypeInfoRequest create() =>
      GetChangeNotetypeInfoRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetChangeNotetypeInfoRequest._();
  @$core.override
  GetChangeNotetypeInfoRequest createEmptyInstance() =>
      GetChangeNotetypeInfoRequest._();
  @$core.pragma('dart2js:noInline')
  static GetChangeNotetypeInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChangeNotetypeInfoRequest>(
          GetChangeNotetypeInfoRequest.$_createMessage);
  static GetChangeNotetypeInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get oldNotetypeId => $_getI64(0);
  @$pb.TagNumber(1)
  set oldNotetypeId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOldNotetypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOldNotetypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get newNotetypeId => $_getI64(1);
  @$pb.TagNumber(2)
  set newNotetypeId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewNotetypeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewNotetypeId() => $_clearField(2);
}

class ChangeNotetypeRequest extends $pb.GeneratedMessage {
  factory ChangeNotetypeRequest({
    $core.Iterable<$fixnum.Int64>? noteIds,
    $core.Iterable<$core.int>? newFields,
    $core.Iterable<$core.int>? newTemplates,
    $fixnum.Int64? oldNotetypeId,
    $fixnum.Int64? newNotetypeId,
    $fixnum.Int64? currentSchema,
    $core.String? oldNotetypeName,
    $core.bool? isCloze,
  }) {
    final result = ChangeNotetypeRequest._();
    if (noteIds != null) result.noteIds.addAll(noteIds);
    if (newFields != null) result.newFields.addAll(newFields);
    if (newTemplates != null) result.newTemplates.addAll(newTemplates);
    if (oldNotetypeId != null) result.oldNotetypeId = oldNotetypeId;
    if (newNotetypeId != null) result.newNotetypeId = newNotetypeId;
    if (currentSchema != null) result.currentSchema = currentSchema;
    if (oldNotetypeName != null) result.oldNotetypeName = oldNotetypeName;
    if (isCloze != null) result.isCloze = isCloze;
    return result;
  }

  ChangeNotetypeRequest._();

  factory ChangeNotetypeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangeNotetypeRequest()..mergeFromBuffer(data, registry);
  factory ChangeNotetypeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangeNotetypeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangeNotetypeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: ChangeNotetypeRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'noteIds', $pb.PbFieldType.K6)
    ..p<$core.int>(2, _omitFieldNames ? '' : 'newFields', $pb.PbFieldType.K3)
    ..p<$core.int>(3, _omitFieldNames ? '' : 'newTemplates', $pb.PbFieldType.K3)
    ..aInt64(4, _omitFieldNames ? '' : 'oldNotetypeId')
    ..aInt64(5, _omitFieldNames ? '' : 'newNotetypeId')
    ..aInt64(6, _omitFieldNames ? '' : 'currentSchema')
    ..aOS(7, _omitFieldNames ? '' : 'oldNotetypeName')
    ..aOB(8, _omitFieldNames ? '' : 'isCloze')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeNotetypeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeNotetypeRequest copyWith(
          void Function(ChangeNotetypeRequest) updates) =>
      super.copyWith((message) => updates(message as ChangeNotetypeRequest))
          as ChangeNotetypeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ChangeNotetypeRequest() / ChangeNotetypeRequest.new instead')
  static ChangeNotetypeRequest create() => ChangeNotetypeRequest._();
  static $pb.GeneratedMessage $_createMessage() => ChangeNotetypeRequest._();
  @$core.override
  ChangeNotetypeRequest createEmptyInstance() => ChangeNotetypeRequest._();
  @$core.pragma('dart2js:noInline')
  static ChangeNotetypeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangeNotetypeRequest>(
          ChangeNotetypeRequest.$_createMessage);
  static ChangeNotetypeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get noteIds => $_getList(0);

  /// -1 is used to represent null, as nullable repeated fields
  /// are unwieldy in protobuf
  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get newFields => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get newTemplates => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get oldNotetypeId => $_getI64(3);
  @$pb.TagNumber(4)
  set oldNotetypeId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOldNotetypeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOldNotetypeId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get newNotetypeId => $_getI64(4);
  @$pb.TagNumber(5)
  set newNotetypeId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNewNotetypeId() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewNotetypeId() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get currentSchema => $_getI64(5);
  @$pb.TagNumber(6)
  set currentSchema($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentSchema() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentSchema() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get oldNotetypeName => $_getSZ(6);
  @$pb.TagNumber(7)
  set oldNotetypeName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOldNotetypeName() => $_has(6);
  @$pb.TagNumber(7)
  void clearOldNotetypeName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isCloze => $_getBF(7);
  @$pb.TagNumber(8)
  set isCloze($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsCloze() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsCloze() => $_clearField(8);
}

class ChangeNotetypeInfo extends $pb.GeneratedMessage {
  factory ChangeNotetypeInfo({
    $core.Iterable<$core.String>? oldFieldNames,
    $core.Iterable<$core.String>? oldTemplateNames,
    $core.Iterable<$core.String>? newFieldNames,
    $core.Iterable<$core.String>? newTemplateNames,
    ChangeNotetypeRequest? input,
    $core.String? oldNotetypeName,
  }) {
    final result = ChangeNotetypeInfo._();
    if (oldFieldNames != null) result.oldFieldNames.addAll(oldFieldNames);
    if (oldTemplateNames != null)
      result.oldTemplateNames.addAll(oldTemplateNames);
    if (newFieldNames != null) result.newFieldNames.addAll(newFieldNames);
    if (newTemplateNames != null)
      result.newTemplateNames.addAll(newTemplateNames);
    if (input != null) result.input = input;
    if (oldNotetypeName != null) result.oldNotetypeName = oldNotetypeName;
    return result;
  }

  ChangeNotetypeInfo._();

  factory ChangeNotetypeInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangeNotetypeInfo()..mergeFromBuffer(data, registry);
  factory ChangeNotetypeInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChangeNotetypeInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangeNotetypeInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: ChangeNotetypeInfo.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'oldFieldNames')
    ..pPS(2, _omitFieldNames ? '' : 'oldTemplateNames')
    ..pPS(3, _omitFieldNames ? '' : 'newFieldNames')
    ..pPS(4, _omitFieldNames ? '' : 'newTemplateNames')
    ..aOM<ChangeNotetypeRequest>(5, _omitFieldNames ? '' : 'input',
        subBuilder: ChangeNotetypeRequest.$_createMessage)
    ..aOS(6, _omitFieldNames ? '' : 'oldNotetypeName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeNotetypeInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeNotetypeInfo copyWith(void Function(ChangeNotetypeInfo) updates) =>
      super.copyWith((message) => updates(message as ChangeNotetypeInfo))
          as ChangeNotetypeInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChangeNotetypeInfo() / ChangeNotetypeInfo.new instead')
  static ChangeNotetypeInfo create() => ChangeNotetypeInfo._();
  static $pb.GeneratedMessage $_createMessage() => ChangeNotetypeInfo._();
  @$core.override
  ChangeNotetypeInfo createEmptyInstance() => ChangeNotetypeInfo._();
  @$core.pragma('dart2js:noInline')
  static ChangeNotetypeInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangeNotetypeInfo>(
          ChangeNotetypeInfo.$_createMessage);
  static ChangeNotetypeInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get oldFieldNames => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get oldTemplateNames => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get newFieldNames => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get newTemplateNames => $_getList(3);

  @$pb.TagNumber(5)
  ChangeNotetypeRequest get input => $_getN(4);
  @$pb.TagNumber(5)
  set input(ChangeNotetypeRequest value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasInput() => $_has(4);
  @$pb.TagNumber(5)
  void clearInput() => $_clearField(5);
  @$pb.TagNumber(5)
  ChangeNotetypeRequest ensureInput() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get oldNotetypeName => $_getSZ(5);
  @$pb.TagNumber(6)
  set oldNotetypeName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOldNotetypeName() => $_has(5);
  @$pb.TagNumber(6)
  void clearOldNotetypeName() => $_clearField(6);
}

class RestoreNotetypeToStockRequest extends $pb.GeneratedMessage {
  factory RestoreNotetypeToStockRequest({
    NotetypeId? notetypeId,
    StockNotetype_Kind? forceKind,
  }) {
    final result = RestoreNotetypeToStockRequest._();
    if (notetypeId != null) result.notetypeId = notetypeId;
    if (forceKind != null) result.forceKind = forceKind;
    return result;
  }

  RestoreNotetypeToStockRequest._();

  factory RestoreNotetypeToStockRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RestoreNotetypeToStockRequest()..mergeFromBuffer(data, registry);
  factory RestoreNotetypeToStockRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RestoreNotetypeToStockRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RestoreNotetypeToStockRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: RestoreNotetypeToStockRequest.$_createMessage)
    ..aOM<NotetypeId>(1, _omitFieldNames ? '' : 'notetypeId',
        subBuilder: NotetypeId.$_createMessage)
    ..aE<StockNotetype_Kind>(2, _omitFieldNames ? '' : 'forceKind',
        enumValues: StockNotetype_Kind.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RestoreNotetypeToStockRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RestoreNotetypeToStockRequest copyWith(
          void Function(RestoreNotetypeToStockRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RestoreNotetypeToStockRequest))
          as RestoreNotetypeToStockRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RestoreNotetypeToStockRequest() / RestoreNotetypeToStockRequest.new instead')
  static RestoreNotetypeToStockRequest create() =>
      RestoreNotetypeToStockRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      RestoreNotetypeToStockRequest._();
  @$core.override
  RestoreNotetypeToStockRequest createEmptyInstance() =>
      RestoreNotetypeToStockRequest._();
  @$core.pragma('dart2js:noInline')
  static RestoreNotetypeToStockRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RestoreNotetypeToStockRequest>(
          RestoreNotetypeToStockRequest.$_createMessage);
  static RestoreNotetypeToStockRequest? _defaultInstance;

  @$pb.TagNumber(1)
  NotetypeId get notetypeId => $_getN(0);
  @$pb.TagNumber(1)
  set notetypeId(NotetypeId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNotetypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotetypeId() => $_clearField(1);
  @$pb.TagNumber(1)
  NotetypeId ensureNotetypeId() => $_ensure(0);

  /// Older notetypes did not store their original stock kind, so we allow the UI
  /// to pass in an override to use when missing, or for tests.
  @$pb.TagNumber(2)
  StockNotetype_Kind get forceKind => $_getN(1);
  @$pb.TagNumber(2)
  set forceKind(StockNotetype_Kind value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasForceKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearForceKind() => $_clearField(2);
}

class GetClozeFieldOrdsResponse extends $pb.GeneratedMessage {
  factory GetClozeFieldOrdsResponse({
    $core.Iterable<$core.int>? ords,
  }) {
    final result = GetClozeFieldOrdsResponse._();
    if (ords != null) result.ords.addAll(ords);
    return result;
  }

  GetClozeFieldOrdsResponse._();

  factory GetClozeFieldOrdsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetClozeFieldOrdsResponse()..mergeFromBuffer(data, registry);
  factory GetClozeFieldOrdsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetClozeFieldOrdsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetClozeFieldOrdsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.notetypes'),
      createEmptyInstance: GetClozeFieldOrdsResponse.$_createMessage)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'ords', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetClozeFieldOrdsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetClozeFieldOrdsResponse copyWith(
          void Function(GetClozeFieldOrdsResponse) updates) =>
      super.copyWith((message) => updates(message as GetClozeFieldOrdsResponse))
          as GetClozeFieldOrdsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetClozeFieldOrdsResponse() / GetClozeFieldOrdsResponse.new instead')
  static GetClozeFieldOrdsResponse create() => GetClozeFieldOrdsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetClozeFieldOrdsResponse._();
  @$core.override
  GetClozeFieldOrdsResponse createEmptyInstance() =>
      GetClozeFieldOrdsResponse._();
  @$core.pragma('dart2js:noInline')
  static GetClozeFieldOrdsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetClozeFieldOrdsResponse>(
          GetClozeFieldOrdsResponse.$_createMessage);
  static GetClozeFieldOrdsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get ords => $_getList(0);
}

class NotetypesServiceApi {
  final $pb.RpcClient _client;

  NotetypesServiceApi(this._client);

  $async.Future<$1.OpChangesWithId> addNotetype(
          $pb.ClientContext? ctx, Notetype request) =>
      _client.invoke<$1.OpChangesWithId>(ctx, 'NotetypesService', 'AddNotetype',
          request, $1.OpChangesWithId());
  $async.Future<$1.OpChanges> updateNotetype(
          $pb.ClientContext? ctx, Notetype request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'NotetypesService', 'UpdateNotetype', request, $1.OpChanges());
  $async.Future<$1.OpChangesWithId> addNotetypeLegacy(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<$1.OpChangesWithId>(ctx, 'NotetypesService',
          'AddNotetypeLegacy', request, $1.OpChangesWithId());
  $async.Future<$1.OpChanges> updateNotetypeLegacy(
          $pb.ClientContext? ctx, UpdateNotetypeLegacyRequest request) =>
      _client.invoke<$1.OpChanges>(ctx, 'NotetypesService',
          'UpdateNotetypeLegacy', request, $1.OpChanges());
  $async.Future<NotetypeId> addOrUpdateNotetype(
          $pb.ClientContext? ctx, AddOrUpdateNotetypeRequest request) =>
      _client.invoke<NotetypeId>(ctx, 'NotetypesService', 'AddOrUpdateNotetype',
          request, NotetypeId());
  $async.Future<$0.Json> getStockNotetypeLegacy(
          $pb.ClientContext? ctx, StockNotetype request) =>
      _client.invoke<$0.Json>(ctx, 'NotetypesService', 'GetStockNotetypeLegacy',
          request, $0.Json());
  $async.Future<Notetype> getNotetype(
          $pb.ClientContext? ctx, NotetypeId request) =>
      _client.invoke<Notetype>(
          ctx, 'NotetypesService', 'GetNotetype', request, Notetype());
  $async.Future<$0.Json> getNotetypeLegacy(
          $pb.ClientContext? ctx, NotetypeId request) =>
      _client.invoke<$0.Json>(
          ctx, 'NotetypesService', 'GetNotetypeLegacy', request, $0.Json());
  $async.Future<NotetypeNames> getNotetypeNames(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<NotetypeNames>(ctx, 'NotetypesService', 'GetNotetypeNames',
          request, NotetypeNames());
  $async.Future<NotetypeUseCounts> getNotetypeNamesAndCounts(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<NotetypeUseCounts>(ctx, 'NotetypesService',
          'GetNotetypeNamesAndCounts', request, NotetypeUseCounts());
  $async.Future<NotetypeId> getNotetypeIdByName(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<NotetypeId>(ctx, 'NotetypesService', 'GetNotetypeIdByName',
          request, NotetypeId());
  $async.Future<$1.OpChanges> removeNotetype(
          $pb.ClientContext? ctx, NotetypeId request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'NotetypesService', 'RemoveNotetype', request, $1.OpChanges());
  $async.Future<$0.String> getAuxNotetypeConfigKey(
          $pb.ClientContext? ctx, GetAuxConfigKeyRequest request) =>
      _client.invoke<$0.String>(ctx, 'NotetypesService',
          'GetAuxNotetypeConfigKey', request, $0.String());
  $async.Future<$0.String> getAuxTemplateConfigKey(
          $pb.ClientContext? ctx, GetAuxTemplateConfigKeyRequest request) =>
      _client.invoke<$0.String>(ctx, 'NotetypesService',
          'GetAuxTemplateConfigKey', request, $0.String());
  $async.Future<ChangeNotetypeInfo> getChangeNotetypeInfo(
          $pb.ClientContext? ctx, GetChangeNotetypeInfoRequest request) =>
      _client.invoke<ChangeNotetypeInfo>(ctx, 'NotetypesService',
          'GetChangeNotetypeInfo', request, ChangeNotetypeInfo());
  $async.Future<$1.OpChanges> changeNotetype(
          $pb.ClientContext? ctx, ChangeNotetypeRequest request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'NotetypesService', 'ChangeNotetype', request, $1.OpChanges());
  $async.Future<$0.StringList> getFieldNames(
          $pb.ClientContext? ctx, NotetypeId request) =>
      _client.invoke<$0.StringList>(
          ctx, 'NotetypesService', 'GetFieldNames', request, $0.StringList());
  $async.Future<$1.OpChanges> restoreNotetypeToStock(
          $pb.ClientContext? ctx, RestoreNotetypeToStockRequest request) =>
      _client.invoke<$1.OpChanges>(ctx, 'NotetypesService',
          'RestoreNotetypeToStock', request, $1.OpChanges());
  $async.Future<GetClozeFieldOrdsResponse> getClozeFieldOrds(
          $pb.ClientContext? ctx, NotetypeId request) =>
      _client.invoke<GetClozeFieldOrdsResponse>(ctx, 'NotetypesService',
          'GetClozeFieldOrds', request, GetClozeFieldOrdsResponse());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendNotetypesServiceApi {
  final $pb.RpcClient _client;

  BackendNotetypesServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
