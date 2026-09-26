// This is a generated file - do not edit.
//
// Generated from anki/decks.proto.

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
import 'decks.pbenum.dart';
import 'generic.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'decks.pbenum.dart';

class DeckId extends $pb.GeneratedMessage {
  factory DeckId({
    $fixnum.Int64? did,
  }) {
    final result = DeckId._();
    if (did != null) result.did = did;
    return result;
  }

  DeckId._();

  factory DeckId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckId()..mergeFromBuffer(data, registry);
  factory DeckId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckId',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: DeckId.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'did')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckId copyWith(void Function(DeckId) updates) =>
      super.copyWith((message) => updates(message as DeckId)) as DeckId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckId() / DeckId.new instead')
  static DeckId create() => DeckId._();
  static $pb.GeneratedMessage $_createMessage() => DeckId._();
  @$core.override
  DeckId createEmptyInstance() => DeckId._();
  @$core.pragma('dart2js:noInline')
  static DeckId getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckId>(DeckId.$_createMessage);
  static DeckId? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get did => $_getI64(0);
  @$pb.TagNumber(1)
  set did($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDid() => $_has(0);
  @$pb.TagNumber(1)
  void clearDid() => $_clearField(1);
}

class DeckIds extends $pb.GeneratedMessage {
  factory DeckIds({
    $core.Iterable<$fixnum.Int64>? dids,
  }) {
    final result = DeckIds._();
    if (dids != null) result.dids.addAll(dids);
    return result;
  }

  DeckIds._();

  factory DeckIds.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckIds()..mergeFromBuffer(data, registry);
  factory DeckIds.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckIds()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckIds',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: DeckIds.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'dids', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckIds clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckIds copyWith(void Function(DeckIds) updates) =>
      super.copyWith((message) => updates(message as DeckIds)) as DeckIds;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckIds() / DeckIds.new instead')
  static DeckIds create() => DeckIds._();
  static $pb.GeneratedMessage $_createMessage() => DeckIds._();
  @$core.override
  DeckIds createEmptyInstance() => DeckIds._();
  @$core.pragma('dart2js:noInline')
  static DeckIds getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckIds>(DeckIds.$_createMessage);
  static DeckIds? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get dids => $_getList(0);
}

class Deck_Common extends $pb.GeneratedMessage {
  factory Deck_Common({
    $core.bool? studyCollapsed,
    $core.bool? browserCollapsed,
    $core.int? lastDayStudied,
    $core.int? newStudied,
    $core.int? reviewStudied,
    $core.int? learningStudied,
    $core.int? millisecondsStudied,
    $core.List<$core.int>? other,
  }) {
    final result = Deck_Common._();
    if (studyCollapsed != null) result.studyCollapsed = studyCollapsed;
    if (browserCollapsed != null) result.browserCollapsed = browserCollapsed;
    if (lastDayStudied != null) result.lastDayStudied = lastDayStudied;
    if (newStudied != null) result.newStudied = newStudied;
    if (reviewStudied != null) result.reviewStudied = reviewStudied;
    if (learningStudied != null) result.learningStudied = learningStudied;
    if (millisecondsStudied != null)
      result.millisecondsStudied = millisecondsStudied;
    if (other != null) result.other = other;
    return result;
  }

  Deck_Common._();

  factory Deck_Common.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Common()..mergeFromBuffer(data, registry);
  factory Deck_Common.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Common()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck.Common',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: Deck_Common.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'studyCollapsed')
    ..aOB(2, _omitFieldNames ? '' : 'browserCollapsed')
    ..aI(3, _omitFieldNames ? '' : 'lastDayStudied',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'newStudied')
    ..aI(5, _omitFieldNames ? '' : 'reviewStudied')
    ..aI(6, _omitFieldNames ? '' : 'learningStudied')
    ..aI(7, _omitFieldNames ? '' : 'millisecondsStudied')
    ..a<$core.List<$core.int>>(
        255, _omitFieldNames ? '' : 'other', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Common clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Common copyWith(void Function(Deck_Common) updates) =>
      super.copyWith((message) => updates(message as Deck_Common))
          as Deck_Common;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Deck_Common() / Deck_Common.new instead')
  static Deck_Common create() => Deck_Common._();
  static $pb.GeneratedMessage $_createMessage() => Deck_Common._();
  @$core.override
  Deck_Common createEmptyInstance() => Deck_Common._();
  @$core.pragma('dart2js:noInline')
  static Deck_Common getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Deck_Common>(
          Deck_Common.$_createMessage);
  static Deck_Common? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get studyCollapsed => $_getBF(0);
  @$pb.TagNumber(1)
  set studyCollapsed($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStudyCollapsed() => $_has(0);
  @$pb.TagNumber(1)
  void clearStudyCollapsed() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get browserCollapsed => $_getBF(1);
  @$pb.TagNumber(2)
  set browserCollapsed($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBrowserCollapsed() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrowserCollapsed() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get lastDayStudied => $_getIZ(2);
  @$pb.TagNumber(3)
  set lastDayStudied($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastDayStudied() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastDayStudied() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get newStudied => $_getIZ(3);
  @$pb.TagNumber(4)
  set newStudied($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewStudied() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewStudied() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get reviewStudied => $_getIZ(4);
  @$pb.TagNumber(5)
  set reviewStudied($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReviewStudied() => $_has(4);
  @$pb.TagNumber(5)
  void clearReviewStudied() => $_clearField(5);

  /// previously set in the v1 scheduler,
  /// but not currently used for anything
  @$pb.TagNumber(6)
  $core.int get learningStudied => $_getIZ(5);
  @$pb.TagNumber(6)
  set learningStudied($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLearningStudied() => $_has(5);
  @$pb.TagNumber(6)
  void clearLearningStudied() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get millisecondsStudied => $_getIZ(6);
  @$pb.TagNumber(7)
  set millisecondsStudied($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMillisecondsStudied() => $_has(6);
  @$pb.TagNumber(7)
  void clearMillisecondsStudied() => $_clearField(7);

  @$pb.TagNumber(255)
  $core.List<$core.int> get other => $_getN(7);
  @$pb.TagNumber(255)
  set other($core.List<$core.int> value) => $_setBytes(7, value);
  @$pb.TagNumber(255)
  $core.bool hasOther() => $_has(7);
  @$pb.TagNumber(255)
  void clearOther() => $_clearField(255);
}

class Deck_Normal_DayLimit extends $pb.GeneratedMessage {
  factory Deck_Normal_DayLimit({
    $core.int? limit,
    $core.int? today,
  }) {
    final result = Deck_Normal_DayLimit._();
    if (limit != null) result.limit = limit;
    if (today != null) result.today = today;
    return result;
  }

  Deck_Normal_DayLimit._();

  factory Deck_Normal_DayLimit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Normal_DayLimit()..mergeFromBuffer(data, registry);
  factory Deck_Normal_DayLimit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Normal_DayLimit()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck.Normal.DayLimit',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: Deck_Normal_DayLimit.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'limit', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'today', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Normal_DayLimit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Normal_DayLimit copyWith(void Function(Deck_Normal_DayLimit) updates) =>
      super.copyWith((message) => updates(message as Deck_Normal_DayLimit))
          as Deck_Normal_DayLimit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Deck_Normal_DayLimit() / Deck_Normal_DayLimit.new instead')
  static Deck_Normal_DayLimit create() => Deck_Normal_DayLimit._();
  static $pb.GeneratedMessage $_createMessage() => Deck_Normal_DayLimit._();
  @$core.override
  Deck_Normal_DayLimit createEmptyInstance() => Deck_Normal_DayLimit._();
  @$core.pragma('dart2js:noInline')
  static Deck_Normal_DayLimit getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Deck_Normal_DayLimit>(
          Deck_Normal_DayLimit.$_createMessage);
  static Deck_Normal_DayLimit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get today => $_getIZ(1);
  @$pb.TagNumber(2)
  set today($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToday() => $_has(1);
  @$pb.TagNumber(2)
  void clearToday() => $_clearField(2);
}

class Deck_Normal extends $pb.GeneratedMessage {
  factory Deck_Normal({
    $fixnum.Int64? configId,
    $core.int? extendNew,
    $core.int? extendReview,
    $core.String? description,
    $core.bool? markdownDescription,
    $core.int? reviewLimit,
    $core.int? newLimit,
    Deck_Normal_DayLimit? reviewLimitToday,
    Deck_Normal_DayLimit? newLimitToday,
    $core.double? desiredRetention,
  }) {
    final result = Deck_Normal._();
    if (configId != null) result.configId = configId;
    if (extendNew != null) result.extendNew = extendNew;
    if (extendReview != null) result.extendReview = extendReview;
    if (description != null) result.description = description;
    if (markdownDescription != null)
      result.markdownDescription = markdownDescription;
    if (reviewLimit != null) result.reviewLimit = reviewLimit;
    if (newLimit != null) result.newLimit = newLimit;
    if (reviewLimitToday != null) result.reviewLimitToday = reviewLimitToday;
    if (newLimitToday != null) result.newLimitToday = newLimitToday;
    if (desiredRetention != null) result.desiredRetention = desiredRetention;
    return result;
  }

  Deck_Normal._();

  factory Deck_Normal.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Normal()..mergeFromBuffer(data, registry);
  factory Deck_Normal.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Normal()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck.Normal',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: Deck_Normal.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'configId')
    ..aI(2, _omitFieldNames ? '' : 'extendNew', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'extendReview',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOB(5, _omitFieldNames ? '' : 'markdownDescription')
    ..aI(6, _omitFieldNames ? '' : 'reviewLimit',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'newLimit', fieldType: $pb.PbFieldType.OU3)
    ..aOM<Deck_Normal_DayLimit>(8, _omitFieldNames ? '' : 'reviewLimitToday',
        subBuilder: Deck_Normal_DayLimit.$_createMessage)
    ..aOM<Deck_Normal_DayLimit>(9, _omitFieldNames ? '' : 'newLimitToday',
        subBuilder: Deck_Normal_DayLimit.$_createMessage)
    ..aD(10, _omitFieldNames ? '' : 'desiredRetention',
        fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Normal clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Normal copyWith(void Function(Deck_Normal) updates) =>
      super.copyWith((message) => updates(message as Deck_Normal))
          as Deck_Normal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Deck_Normal() / Deck_Normal.new instead')
  static Deck_Normal create() => Deck_Normal._();
  static $pb.GeneratedMessage $_createMessage() => Deck_Normal._();
  @$core.override
  Deck_Normal createEmptyInstance() => Deck_Normal._();
  @$core.pragma('dart2js:noInline')
  static Deck_Normal getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Deck_Normal>(
          Deck_Normal.$_createMessage);
  static Deck_Normal? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get configId => $_getI64(0);
  @$pb.TagNumber(1)
  set configId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConfigId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfigId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get extendNew => $_getIZ(1);
  @$pb.TagNumber(2)
  set extendNew($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExtendNew() => $_has(1);
  @$pb.TagNumber(2)
  void clearExtendNew() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get extendReview => $_getIZ(2);
  @$pb.TagNumber(3)
  set extendReview($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExtendReview() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtendReview() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get markdownDescription => $_getBF(4);
  @$pb.TagNumber(5)
  set markdownDescription($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMarkdownDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearMarkdownDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get reviewLimit => $_getIZ(5);
  @$pb.TagNumber(6)
  set reviewLimit($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReviewLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearReviewLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get newLimit => $_getIZ(6);
  @$pb.TagNumber(7)
  set newLimit($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNewLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearNewLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  Deck_Normal_DayLimit get reviewLimitToday => $_getN(7);
  @$pb.TagNumber(8)
  set reviewLimitToday(Deck_Normal_DayLimit value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasReviewLimitToday() => $_has(7);
  @$pb.TagNumber(8)
  void clearReviewLimitToday() => $_clearField(8);
  @$pb.TagNumber(8)
  Deck_Normal_DayLimit ensureReviewLimitToday() => $_ensure(7);

  @$pb.TagNumber(9)
  Deck_Normal_DayLimit get newLimitToday => $_getN(8);
  @$pb.TagNumber(9)
  set newLimitToday(Deck_Normal_DayLimit value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasNewLimitToday() => $_has(8);
  @$pb.TagNumber(9)
  void clearNewLimitToday() => $_clearField(9);
  @$pb.TagNumber(9)
  Deck_Normal_DayLimit ensureNewLimitToday() => $_ensure(8);

  /// Deck-specific desired retention override
  @$pb.TagNumber(10)
  $core.double get desiredRetention => $_getN(9);
  @$pb.TagNumber(10)
  set desiredRetention($core.double value) => $_setFloat(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDesiredRetention() => $_has(9);
  @$pb.TagNumber(10)
  void clearDesiredRetention() => $_clearField(10);
}

class Deck_Filtered_SearchTerm extends $pb.GeneratedMessage {
  factory Deck_Filtered_SearchTerm({
    $core.String? search,
    $core.int? limit,
    Deck_Filtered_SearchTerm_Order? order,
  }) {
    final result = Deck_Filtered_SearchTerm._();
    if (search != null) result.search = search;
    if (limit != null) result.limit = limit;
    if (order != null) result.order = order;
    return result;
  }

  Deck_Filtered_SearchTerm._();

  factory Deck_Filtered_SearchTerm.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Filtered_SearchTerm()..mergeFromBuffer(data, registry);
  factory Deck_Filtered_SearchTerm.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Filtered_SearchTerm()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck.Filtered.SearchTerm',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: Deck_Filtered_SearchTerm.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'search')
    ..aI(2, _omitFieldNames ? '' : 'limit', fieldType: $pb.PbFieldType.OU3)
    ..aE<Deck_Filtered_SearchTerm_Order>(3, _omitFieldNames ? '' : 'order',
        enumValues: Deck_Filtered_SearchTerm_Order.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Filtered_SearchTerm clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Filtered_SearchTerm copyWith(
          void Function(Deck_Filtered_SearchTerm) updates) =>
      super.copyWith((message) => updates(message as Deck_Filtered_SearchTerm))
          as Deck_Filtered_SearchTerm;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Deck_Filtered_SearchTerm() / Deck_Filtered_SearchTerm.new instead')
  static Deck_Filtered_SearchTerm create() => Deck_Filtered_SearchTerm._();
  static $pb.GeneratedMessage $_createMessage() => Deck_Filtered_SearchTerm._();
  @$core.override
  Deck_Filtered_SearchTerm createEmptyInstance() =>
      Deck_Filtered_SearchTerm._();
  @$core.pragma('dart2js:noInline')
  static Deck_Filtered_SearchTerm getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Deck_Filtered_SearchTerm>(
          Deck_Filtered_SearchTerm.$_createMessage);
  static Deck_Filtered_SearchTerm? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get search => $_getSZ(0);
  @$pb.TagNumber(1)
  set search($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSearch() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearch() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  Deck_Filtered_SearchTerm_Order get order => $_getN(2);
  @$pb.TagNumber(3)
  set order(Deck_Filtered_SearchTerm_Order value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrder() => $_clearField(3);
}

class Deck_Filtered extends $pb.GeneratedMessage {
  factory Deck_Filtered({
    $core.bool? reschedule,
    $core.Iterable<Deck_Filtered_SearchTerm>? searchTerms,
    $core.Iterable<$core.double>? delays,
    $core.int? previewDelay,
    $core.int? previewHardSecs,
    $core.int? previewGoodSecs,
    $core.int? previewAgainSecs,
  }) {
    final result = Deck_Filtered._();
    if (reschedule != null) result.reschedule = reschedule;
    if (searchTerms != null) result.searchTerms.addAll(searchTerms);
    if (delays != null) result.delays.addAll(delays);
    if (previewDelay != null) result.previewDelay = previewDelay;
    if (previewHardSecs != null) result.previewHardSecs = previewHardSecs;
    if (previewGoodSecs != null) result.previewGoodSecs = previewGoodSecs;
    if (previewAgainSecs != null) result.previewAgainSecs = previewAgainSecs;
    return result;
  }

  Deck_Filtered._();

  factory Deck_Filtered.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Filtered()..mergeFromBuffer(data, registry);
  factory Deck_Filtered.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_Filtered()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck.Filtered',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: Deck_Filtered.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'reschedule')
    ..pPM<Deck_Filtered_SearchTerm>(2, _omitFieldNames ? '' : 'searchTerms',
        subBuilder: Deck_Filtered_SearchTerm.$_createMessage)
    ..p<$core.double>(3, _omitFieldNames ? '' : 'delays', $pb.PbFieldType.KF)
    ..aI(4, _omitFieldNames ? '' : 'previewDelay',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'previewHardSecs',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'previewGoodSecs',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'previewAgainSecs',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Filtered clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_Filtered copyWith(void Function(Deck_Filtered) updates) =>
      super.copyWith((message) => updates(message as Deck_Filtered))
          as Deck_Filtered;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Deck_Filtered() / Deck_Filtered.new instead')
  static Deck_Filtered create() => Deck_Filtered._();
  static $pb.GeneratedMessage $_createMessage() => Deck_Filtered._();
  @$core.override
  Deck_Filtered createEmptyInstance() => Deck_Filtered._();
  @$core.pragma('dart2js:noInline')
  static Deck_Filtered getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Deck_Filtered>(
          Deck_Filtered.$_createMessage);
  static Deck_Filtered? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get reschedule => $_getBF(0);
  @$pb.TagNumber(1)
  set reschedule($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReschedule() => $_has(0);
  @$pb.TagNumber(1)
  void clearReschedule() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Deck_Filtered_SearchTerm> get searchTerms => $_getList(1);

  /// v1 scheduler only
  @$pb.TagNumber(3)
  $pb.PbList<$core.double> get delays => $_getList(2);

  /// v2 and old v3 scheduler only
  @$pb.TagNumber(4)
  $core.int get previewDelay => $_getIZ(3);
  @$pb.TagNumber(4)
  set previewDelay($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPreviewDelay() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreviewDelay() => $_clearField(4);

  /// recent v3 scheduler only; 0 means card will be returned
  @$pb.TagNumber(5)
  $core.int get previewHardSecs => $_getIZ(4);
  @$pb.TagNumber(5)
  set previewHardSecs($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPreviewHardSecs() => $_has(4);
  @$pb.TagNumber(5)
  void clearPreviewHardSecs() => $_clearField(5);

  /// recent v3 scheduler only; 0 means card will be returned
  @$pb.TagNumber(6)
  $core.int get previewGoodSecs => $_getIZ(5);
  @$pb.TagNumber(6)
  set previewGoodSecs($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPreviewGoodSecs() => $_has(5);
  @$pb.TagNumber(6)
  void clearPreviewGoodSecs() => $_clearField(6);

  /// recent v3 scheduler only; 0 means card will be returned
  @$pb.TagNumber(7)
  $core.int get previewAgainSecs => $_getIZ(6);
  @$pb.TagNumber(7)
  set previewAgainSecs($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPreviewAgainSecs() => $_has(6);
  @$pb.TagNumber(7)
  void clearPreviewAgainSecs() => $_clearField(7);
}

enum Deck_KindContainer_Kind { normal, filtered, notSet }

/// a container to store the deck specifics in the DB
/// as a tagged enum
class Deck_KindContainer extends $pb.GeneratedMessage {
  factory Deck_KindContainer({
    Deck_Normal? normal,
    Deck_Filtered? filtered,
  }) {
    final result = Deck_KindContainer._();
    if (normal != null) result.normal = normal;
    if (filtered != null) result.filtered = filtered;
    return result;
  }

  Deck_KindContainer._();

  factory Deck_KindContainer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_KindContainer()..mergeFromBuffer(data, registry);
  factory Deck_KindContainer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck_KindContainer()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Deck_KindContainer_Kind>
      _Deck_KindContainer_KindByTag = {
    1: Deck_KindContainer_Kind.normal,
    2: Deck_KindContainer_Kind.filtered,
    0: Deck_KindContainer_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck.KindContainer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: Deck_KindContainer.$_createMessage)
    ..oo(0, [1, 2])
    ..aOM<Deck_Normal>(1, _omitFieldNames ? '' : 'normal',
        subBuilder: Deck_Normal.$_createMessage)
    ..aOM<Deck_Filtered>(2, _omitFieldNames ? '' : 'filtered',
        subBuilder: Deck_Filtered.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_KindContainer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck_KindContainer copyWith(void Function(Deck_KindContainer) updates) =>
      super.copyWith((message) => updates(message as Deck_KindContainer))
          as Deck_KindContainer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Deck_KindContainer() / Deck_KindContainer.new instead')
  static Deck_KindContainer create() => Deck_KindContainer._();
  static $pb.GeneratedMessage $_createMessage() => Deck_KindContainer._();
  @$core.override
  Deck_KindContainer createEmptyInstance() => Deck_KindContainer._();
  @$core.pragma('dart2js:noInline')
  static Deck_KindContainer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Deck_KindContainer>(
          Deck_KindContainer.$_createMessage);
  static Deck_KindContainer? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  Deck_KindContainer_Kind whichKind() =>
      _Deck_KindContainer_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Deck_Normal get normal => $_getN(0);
  @$pb.TagNumber(1)
  set normal(Deck_Normal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNormal() => $_has(0);
  @$pb.TagNumber(1)
  void clearNormal() => $_clearField(1);
  @$pb.TagNumber(1)
  Deck_Normal ensureNormal() => $_ensure(0);

  @$pb.TagNumber(2)
  Deck_Filtered get filtered => $_getN(1);
  @$pb.TagNumber(2)
  set filtered(Deck_Filtered value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFiltered() => $_has(1);
  @$pb.TagNumber(2)
  void clearFiltered() => $_clearField(2);
  @$pb.TagNumber(2)
  Deck_Filtered ensureFiltered() => $_ensure(1);
}

enum Deck_Kind { normal, filtered, notSet }

class Deck extends $pb.GeneratedMessage {
  factory Deck({
    $fixnum.Int64? id,
    $core.String? name,
    $fixnum.Int64? mtimeSecs,
    $core.int? usn,
    Deck_Common? common,
    Deck_Normal? normal,
    Deck_Filtered? filtered,
  }) {
    final result = Deck._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (mtimeSecs != null) result.mtimeSecs = mtimeSecs;
    if (usn != null) result.usn = usn;
    if (common != null) result.common = common;
    if (normal != null) result.normal = normal;
    if (filtered != null) result.filtered = filtered;
    return result;
  }

  Deck._();

  factory Deck.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck()..mergeFromBuffer(data, registry);
  factory Deck.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Deck_Kind> _Deck_KindByTag = {
    6: Deck_Kind.normal,
    7: Deck_Kind.filtered,
    0: Deck_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: Deck.$_createMessage)
    ..oo(0, [6, 7])
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aInt64(3, _omitFieldNames ? '' : 'mtimeSecs')
    ..aI(4, _omitFieldNames ? '' : 'usn')
    ..aOM<Deck_Common>(5, _omitFieldNames ? '' : 'common',
        subBuilder: Deck_Common.$_createMessage)
    ..aOM<Deck_Normal>(6, _omitFieldNames ? '' : 'normal',
        subBuilder: Deck_Normal.$_createMessage)
    ..aOM<Deck_Filtered>(7, _omitFieldNames ? '' : 'filtered',
        subBuilder: Deck_Filtered.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck copyWith(void Function(Deck) updates) =>
      super.copyWith((message) => updates(message as Deck)) as Deck;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Deck() / Deck.new instead')
  static Deck create() => Deck._();
  static $pb.GeneratedMessage $_createMessage() => Deck._();
  @$core.override
  Deck createEmptyInstance() => Deck._();
  @$core.pragma('dart2js:noInline')
  static Deck getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Deck>(Deck.$_createMessage);
  static Deck? _defaultInstance;

  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  Deck_Kind whichKind() => _Deck_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  void clearKind() => $_clearField($_whichOneof(0));

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

  @$pb.TagNumber(5)
  Deck_Common get common => $_getN(4);
  @$pb.TagNumber(5)
  set common(Deck_Common value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCommon() => $_has(4);
  @$pb.TagNumber(5)
  void clearCommon() => $_clearField(5);
  @$pb.TagNumber(5)
  Deck_Common ensureCommon() => $_ensure(4);

  @$pb.TagNumber(6)
  Deck_Normal get normal => $_getN(5);
  @$pb.TagNumber(6)
  set normal(Deck_Normal value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNormal() => $_has(5);
  @$pb.TagNumber(6)
  void clearNormal() => $_clearField(6);
  @$pb.TagNumber(6)
  Deck_Normal ensureNormal() => $_ensure(5);

  @$pb.TagNumber(7)
  Deck_Filtered get filtered => $_getN(6);
  @$pb.TagNumber(7)
  set filtered(Deck_Filtered value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasFiltered() => $_has(6);
  @$pb.TagNumber(7)
  void clearFiltered() => $_clearField(7);
  @$pb.TagNumber(7)
  Deck_Filtered ensureFiltered() => $_ensure(6);
}

class AddOrUpdateDeckLegacyRequest extends $pb.GeneratedMessage {
  factory AddOrUpdateDeckLegacyRequest({
    $core.List<$core.int>? deck,
    $core.bool? preserveUsnAndMtime,
  }) {
    final result = AddOrUpdateDeckLegacyRequest._();
    if (deck != null) result.deck = deck;
    if (preserveUsnAndMtime != null)
      result.preserveUsnAndMtime = preserveUsnAndMtime;
    return result;
  }

  AddOrUpdateDeckLegacyRequest._();

  factory AddOrUpdateDeckLegacyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddOrUpdateDeckLegacyRequest()..mergeFromBuffer(data, registry);
  factory AddOrUpdateDeckLegacyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddOrUpdateDeckLegacyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddOrUpdateDeckLegacyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: AddOrUpdateDeckLegacyRequest.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'deck', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'preserveUsnAndMtime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddOrUpdateDeckLegacyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddOrUpdateDeckLegacyRequest copyWith(
          void Function(AddOrUpdateDeckLegacyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AddOrUpdateDeckLegacyRequest))
          as AddOrUpdateDeckLegacyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AddOrUpdateDeckLegacyRequest() / AddOrUpdateDeckLegacyRequest.new instead')
  static AddOrUpdateDeckLegacyRequest create() =>
      AddOrUpdateDeckLegacyRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      AddOrUpdateDeckLegacyRequest._();
  @$core.override
  AddOrUpdateDeckLegacyRequest createEmptyInstance() =>
      AddOrUpdateDeckLegacyRequest._();
  @$core.pragma('dart2js:noInline')
  static AddOrUpdateDeckLegacyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddOrUpdateDeckLegacyRequest>(
          AddOrUpdateDeckLegacyRequest.$_createMessage);
  static AddOrUpdateDeckLegacyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get deck => $_getN(0);
  @$pb.TagNumber(1)
  set deck($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeck() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeck() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get preserveUsnAndMtime => $_getBF(1);
  @$pb.TagNumber(2)
  set preserveUsnAndMtime($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreserveUsnAndMtime() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreserveUsnAndMtime() => $_clearField(2);
}

class DeckTreeRequest extends $pb.GeneratedMessage {
  factory DeckTreeRequest({
    $fixnum.Int64? now,
  }) {
    final result = DeckTreeRequest._();
    if (now != null) result.now = now;
    return result;
  }

  DeckTreeRequest._();

  factory DeckTreeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckTreeRequest()..mergeFromBuffer(data, registry);
  factory DeckTreeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckTreeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckTreeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: DeckTreeRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'now')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckTreeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckTreeRequest copyWith(void Function(DeckTreeRequest) updates) =>
      super.copyWith((message) => updates(message as DeckTreeRequest))
          as DeckTreeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckTreeRequest() / DeckTreeRequest.new instead')
  static DeckTreeRequest create() => DeckTreeRequest._();
  static $pb.GeneratedMessage $_createMessage() => DeckTreeRequest._();
  @$core.override
  DeckTreeRequest createEmptyInstance() => DeckTreeRequest._();
  @$core.pragma('dart2js:noInline')
  static DeckTreeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeckTreeRequest>(
          DeckTreeRequest.$_createMessage);
  static DeckTreeRequest? _defaultInstance;

  /// if non-zero, counts for the provided timestamp will be included
  @$pb.TagNumber(1)
  $fixnum.Int64 get now => $_getI64(0);
  @$pb.TagNumber(1)
  set now($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNow() => $_has(0);
  @$pb.TagNumber(1)
  void clearNow() => $_clearField(1);
}

class DeckTreeNode extends $pb.GeneratedMessage {
  factory DeckTreeNode({
    $fixnum.Int64? deckId,
    $core.String? name,
    $core.Iterable<DeckTreeNode>? children,
    $core.int? level,
    $core.bool? collapsed,
    $core.int? reviewCount,
    $core.int? learnCount,
    $core.int? newCount,
    $core.int? intradayLearning,
    $core.int? interdayLearningUncapped,
    $core.int? newUncapped,
    $core.int? reviewUncapped,
    $core.int? totalInDeck,
    $core.int? totalIncludingChildren,
    $core.bool? filtered,
  }) {
    final result = DeckTreeNode._();
    if (deckId != null) result.deckId = deckId;
    if (name != null) result.name = name;
    if (children != null) result.children.addAll(children);
    if (level != null) result.level = level;
    if (collapsed != null) result.collapsed = collapsed;
    if (reviewCount != null) result.reviewCount = reviewCount;
    if (learnCount != null) result.learnCount = learnCount;
    if (newCount != null) result.newCount = newCount;
    if (intradayLearning != null) result.intradayLearning = intradayLearning;
    if (interdayLearningUncapped != null)
      result.interdayLearningUncapped = interdayLearningUncapped;
    if (newUncapped != null) result.newUncapped = newUncapped;
    if (reviewUncapped != null) result.reviewUncapped = reviewUncapped;
    if (totalInDeck != null) result.totalInDeck = totalInDeck;
    if (totalIncludingChildren != null)
      result.totalIncludingChildren = totalIncludingChildren;
    if (filtered != null) result.filtered = filtered;
    return result;
  }

  DeckTreeNode._();

  factory DeckTreeNode.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckTreeNode()..mergeFromBuffer(data, registry);
  factory DeckTreeNode.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckTreeNode()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckTreeNode',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: DeckTreeNode.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'deckId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<DeckTreeNode>(3, _omitFieldNames ? '' : 'children',
        subBuilder: DeckTreeNode.$_createMessage)
    ..aI(4, _omitFieldNames ? '' : 'level', fieldType: $pb.PbFieldType.OU3)
    ..aOB(5, _omitFieldNames ? '' : 'collapsed')
    ..aI(6, _omitFieldNames ? '' : 'reviewCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'learnCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(8, _omitFieldNames ? '' : 'newCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(9, _omitFieldNames ? '' : 'intradayLearning',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(10, _omitFieldNames ? '' : 'interdayLearningUncapped',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(11, _omitFieldNames ? '' : 'newUncapped',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(12, _omitFieldNames ? '' : 'reviewUncapped',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(13, _omitFieldNames ? '' : 'totalInDeck',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(14, _omitFieldNames ? '' : 'totalIncludingChildren',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(16, _omitFieldNames ? '' : 'filtered')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckTreeNode clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckTreeNode copyWith(void Function(DeckTreeNode) updates) =>
      super.copyWith((message) => updates(message as DeckTreeNode))
          as DeckTreeNode;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckTreeNode() / DeckTreeNode.new instead')
  static DeckTreeNode create() => DeckTreeNode._();
  static $pb.GeneratedMessage $_createMessage() => DeckTreeNode._();
  @$core.override
  DeckTreeNode createEmptyInstance() => DeckTreeNode._();
  @$core.pragma('dart2js:noInline')
  static DeckTreeNode getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeckTreeNode>(
          DeckTreeNode.$_createMessage);
  static DeckTreeNode? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get deckId => $_getI64(0);
  @$pb.TagNumber(1)
  set deckId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeckId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeckId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  /// low index so key can be packed into a byte, but at bottom
  /// to make debug output easier to read
  @$pb.TagNumber(3)
  $pb.PbList<DeckTreeNode> get children => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get level => $_getIZ(3);
  @$pb.TagNumber(4)
  set level($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLevel() => $_has(3);
  @$pb.TagNumber(4)
  void clearLevel() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get collapsed => $_getBF(4);
  @$pb.TagNumber(5)
  set collapsed($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCollapsed() => $_has(4);
  @$pb.TagNumber(5)
  void clearCollapsed() => $_clearField(5);

  /// counts after adding children+applying limits
  @$pb.TagNumber(6)
  $core.int get reviewCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set reviewCount($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReviewCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearReviewCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get learnCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set learnCount($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLearnCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearLearnCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get newCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set newCount($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNewCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearNewCount() => $_clearField(8);

  /// card counts without children or limits applied
  @$pb.TagNumber(9)
  $core.int get intradayLearning => $_getIZ(8);
  @$pb.TagNumber(9)
  set intradayLearning($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIntradayLearning() => $_has(8);
  @$pb.TagNumber(9)
  void clearIntradayLearning() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get interdayLearningUncapped => $_getIZ(9);
  @$pb.TagNumber(10)
  set interdayLearningUncapped($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInterdayLearningUncapped() => $_has(9);
  @$pb.TagNumber(10)
  void clearInterdayLearningUncapped() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get newUncapped => $_getIZ(10);
  @$pb.TagNumber(11)
  set newUncapped($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNewUncapped() => $_has(10);
  @$pb.TagNumber(11)
  void clearNewUncapped() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get reviewUncapped => $_getIZ(11);
  @$pb.TagNumber(12)
  set reviewUncapped($core.int value) => $_setUnsignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasReviewUncapped() => $_has(11);
  @$pb.TagNumber(12)
  void clearReviewUncapped() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get totalInDeck => $_getIZ(12);
  @$pb.TagNumber(13)
  set totalInDeck($core.int value) => $_setUnsignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTotalInDeck() => $_has(12);
  @$pb.TagNumber(13)
  void clearTotalInDeck() => $_clearField(13);

  /// with children, without any limits
  @$pb.TagNumber(14)
  $core.int get totalIncludingChildren => $_getIZ(13);
  @$pb.TagNumber(14)
  set totalIncludingChildren($core.int value) => $_setUnsignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasTotalIncludingChildren() => $_has(13);
  @$pb.TagNumber(14)
  void clearTotalIncludingChildren() => $_clearField(14);

  @$pb.TagNumber(16)
  $core.bool get filtered => $_getBF(14);
  @$pb.TagNumber(16)
  set filtered($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(16)
  $core.bool hasFiltered() => $_has(14);
  @$pb.TagNumber(16)
  void clearFiltered() => $_clearField(16);
}

class SetDeckCollapsedRequest extends $pb.GeneratedMessage {
  factory SetDeckCollapsedRequest({
    $fixnum.Int64? deckId,
    $core.bool? collapsed,
    SetDeckCollapsedRequest_Scope? scope,
  }) {
    final result = SetDeckCollapsedRequest._();
    if (deckId != null) result.deckId = deckId;
    if (collapsed != null) result.collapsed = collapsed;
    if (scope != null) result.scope = scope;
    return result;
  }

  SetDeckCollapsedRequest._();

  factory SetDeckCollapsedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDeckCollapsedRequest()..mergeFromBuffer(data, registry);
  factory SetDeckCollapsedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDeckCollapsedRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDeckCollapsedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: SetDeckCollapsedRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'deckId')
    ..aOB(2, _omitFieldNames ? '' : 'collapsed')
    ..aE<SetDeckCollapsedRequest_Scope>(3, _omitFieldNames ? '' : 'scope',
        enumValues: SetDeckCollapsedRequest_Scope.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDeckCollapsedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDeckCollapsedRequest copyWith(
          void Function(SetDeckCollapsedRequest) updates) =>
      super.copyWith((message) => updates(message as SetDeckCollapsedRequest))
          as SetDeckCollapsedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetDeckCollapsedRequest() / SetDeckCollapsedRequest.new instead')
  static SetDeckCollapsedRequest create() => SetDeckCollapsedRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetDeckCollapsedRequest._();
  @$core.override
  SetDeckCollapsedRequest createEmptyInstance() => SetDeckCollapsedRequest._();
  @$core.pragma('dart2js:noInline')
  static SetDeckCollapsedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetDeckCollapsedRequest>(
          SetDeckCollapsedRequest.$_createMessage);
  static SetDeckCollapsedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get deckId => $_getI64(0);
  @$pb.TagNumber(1)
  set deckId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeckId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeckId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get collapsed => $_getBF(1);
  @$pb.TagNumber(2)
  set collapsed($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCollapsed() => $_has(1);
  @$pb.TagNumber(2)
  void clearCollapsed() => $_clearField(2);

  @$pb.TagNumber(3)
  SetDeckCollapsedRequest_Scope get scope => $_getN(2);
  @$pb.TagNumber(3)
  set scope(SetDeckCollapsedRequest_Scope value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasScope() => $_has(2);
  @$pb.TagNumber(3)
  void clearScope() => $_clearField(3);
}

class GetDeckNamesRequest extends $pb.GeneratedMessage {
  factory GetDeckNamesRequest({
    $core.bool? skipEmptyDefault,
    $core.bool? includeFiltered,
  }) {
    final result = GetDeckNamesRequest._();
    if (skipEmptyDefault != null) result.skipEmptyDefault = skipEmptyDefault;
    if (includeFiltered != null) result.includeFiltered = includeFiltered;
    return result;
  }

  GetDeckNamesRequest._();

  factory GetDeckNamesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDeckNamesRequest()..mergeFromBuffer(data, registry);
  factory GetDeckNamesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDeckNamesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDeckNamesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: GetDeckNamesRequest.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'skipEmptyDefault')
    ..aOB(2, _omitFieldNames ? '' : 'includeFiltered')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeckNamesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeckNamesRequest copyWith(void Function(GetDeckNamesRequest) updates) =>
      super.copyWith((message) => updates(message as GetDeckNamesRequest))
          as GetDeckNamesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use GetDeckNamesRequest() / GetDeckNamesRequest.new instead')
  static GetDeckNamesRequest create() => GetDeckNamesRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetDeckNamesRequest._();
  @$core.override
  GetDeckNamesRequest createEmptyInstance() => GetDeckNamesRequest._();
  @$core.pragma('dart2js:noInline')
  static GetDeckNamesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDeckNamesRequest>(
          GetDeckNamesRequest.$_createMessage);
  static GetDeckNamesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get skipEmptyDefault => $_getBF(0);
  @$pb.TagNumber(1)
  set skipEmptyDefault($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSkipEmptyDefault() => $_has(0);
  @$pb.TagNumber(1)
  void clearSkipEmptyDefault() => $_clearField(1);

  /// if unset, implies skip_empty_default
  @$pb.TagNumber(2)
  $core.bool get includeFiltered => $_getBF(1);
  @$pb.TagNumber(2)
  set includeFiltered($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncludeFiltered() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeFiltered() => $_clearField(2);
}

class DeckNames extends $pb.GeneratedMessage {
  factory DeckNames({
    $core.Iterable<DeckNameId>? entries,
  }) {
    final result = DeckNames._();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  DeckNames._();

  factory DeckNames.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckNames()..mergeFromBuffer(data, registry);
  factory DeckNames.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckNames()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckNames',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: DeckNames.$_createMessage)
    ..pPM<DeckNameId>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: DeckNameId.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckNames clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckNames copyWith(void Function(DeckNames) updates) =>
      super.copyWith((message) => updates(message as DeckNames)) as DeckNames;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckNames() / DeckNames.new instead')
  static DeckNames create() => DeckNames._();
  static $pb.GeneratedMessage $_createMessage() => DeckNames._();
  @$core.override
  DeckNames createEmptyInstance() => DeckNames._();
  @$core.pragma('dart2js:noInline')
  static DeckNames getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckNames>(DeckNames.$_createMessage);
  static DeckNames? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeckNameId> get entries => $_getList(0);
}

class DeckNameId extends $pb.GeneratedMessage {
  factory DeckNameId({
    $fixnum.Int64? id,
    $core.String? name,
  }) {
    final result = DeckNameId._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  DeckNameId._();

  factory DeckNameId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckNameId()..mergeFromBuffer(data, registry);
  factory DeckNameId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckNameId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckNameId',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: DeckNameId.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckNameId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckNameId copyWith(void Function(DeckNameId) updates) =>
      super.copyWith((message) => updates(message as DeckNameId)) as DeckNameId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckNameId() / DeckNameId.new instead')
  static DeckNameId create() => DeckNameId._();
  static $pb.GeneratedMessage $_createMessage() => DeckNameId._();
  @$core.override
  DeckNameId createEmptyInstance() => DeckNameId._();
  @$core.pragma('dart2js:noInline')
  static DeckNameId getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckNameId>(DeckNameId.$_createMessage);
  static DeckNameId? _defaultInstance;

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

class ReparentDecksRequest extends $pb.GeneratedMessage {
  factory ReparentDecksRequest({
    $core.Iterable<$fixnum.Int64>? deckIds,
    $fixnum.Int64? newParent,
  }) {
    final result = ReparentDecksRequest._();
    if (deckIds != null) result.deckIds.addAll(deckIds);
    if (newParent != null) result.newParent = newParent;
    return result;
  }

  ReparentDecksRequest._();

  factory ReparentDecksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReparentDecksRequest()..mergeFromBuffer(data, registry);
  factory ReparentDecksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReparentDecksRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReparentDecksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: ReparentDecksRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'deckIds', $pb.PbFieldType.K6)
    ..aInt64(2, _omitFieldNames ? '' : 'newParent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReparentDecksRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReparentDecksRequest copyWith(void Function(ReparentDecksRequest) updates) =>
      super.copyWith((message) => updates(message as ReparentDecksRequest))
          as ReparentDecksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReparentDecksRequest() / ReparentDecksRequest.new instead')
  static ReparentDecksRequest create() => ReparentDecksRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReparentDecksRequest._();
  @$core.override
  ReparentDecksRequest createEmptyInstance() => ReparentDecksRequest._();
  @$core.pragma('dart2js:noInline')
  static ReparentDecksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReparentDecksRequest>(
          ReparentDecksRequest.$_createMessage);
  static ReparentDecksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get deckIds => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get newParent => $_getI64(1);
  @$pb.TagNumber(2)
  set newParent($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewParent() => $_clearField(2);
}

class RenameDeckRequest extends $pb.GeneratedMessage {
  factory RenameDeckRequest({
    $fixnum.Int64? deckId,
    $core.String? newName,
  }) {
    final result = RenameDeckRequest._();
    if (deckId != null) result.deckId = deckId;
    if (newName != null) result.newName = newName;
    return result;
  }

  RenameDeckRequest._();

  factory RenameDeckRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenameDeckRequest()..mergeFromBuffer(data, registry);
  factory RenameDeckRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenameDeckRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenameDeckRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: RenameDeckRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'deckId')
    ..aOS(2, _omitFieldNames ? '' : 'newName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenameDeckRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenameDeckRequest copyWith(void Function(RenameDeckRequest) updates) =>
      super.copyWith((message) => updates(message as RenameDeckRequest))
          as RenameDeckRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RenameDeckRequest() / RenameDeckRequest.new instead')
  static RenameDeckRequest create() => RenameDeckRequest._();
  static $pb.GeneratedMessage $_createMessage() => RenameDeckRequest._();
  @$core.override
  RenameDeckRequest createEmptyInstance() => RenameDeckRequest._();
  @$core.pragma('dart2js:noInline')
  static RenameDeckRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameDeckRequest>(
          RenameDeckRequest.$_createMessage);
  static RenameDeckRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get deckId => $_getI64(0);
  @$pb.TagNumber(1)
  set deckId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeckId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeckId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newName => $_getSZ(1);
  @$pb.TagNumber(2)
  set newName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewName() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewName() => $_clearField(2);
}

class FilteredDeckForUpdate extends $pb.GeneratedMessage {
  factory FilteredDeckForUpdate({
    $fixnum.Int64? id,
    $core.String? name,
    Deck_Filtered? config,
    $core.bool? allowEmpty,
  }) {
    final result = FilteredDeckForUpdate._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (config != null) result.config = config;
    if (allowEmpty != null) result.allowEmpty = allowEmpty;
    return result;
  }

  FilteredDeckForUpdate._();

  factory FilteredDeckForUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FilteredDeckForUpdate()..mergeFromBuffer(data, registry);
  factory FilteredDeckForUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FilteredDeckForUpdate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilteredDeckForUpdate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.decks'),
      createEmptyInstance: FilteredDeckForUpdate.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<Deck_Filtered>(3, _omitFieldNames ? '' : 'config',
        subBuilder: Deck_Filtered.$_createMessage)
    ..aOB(4, _omitFieldNames ? '' : 'allowEmpty')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilteredDeckForUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilteredDeckForUpdate copyWith(
          void Function(FilteredDeckForUpdate) updates) =>
      super.copyWith((message) => updates(message as FilteredDeckForUpdate))
          as FilteredDeckForUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FilteredDeckForUpdate() / FilteredDeckForUpdate.new instead')
  static FilteredDeckForUpdate create() => FilteredDeckForUpdate._();
  static $pb.GeneratedMessage $_createMessage() => FilteredDeckForUpdate._();
  @$core.override
  FilteredDeckForUpdate createEmptyInstance() => FilteredDeckForUpdate._();
  @$core.pragma('dart2js:noInline')
  static FilteredDeckForUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FilteredDeckForUpdate>(
          FilteredDeckForUpdate.$_createMessage);
  static FilteredDeckForUpdate? _defaultInstance;

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
  Deck_Filtered get config => $_getN(2);
  @$pb.TagNumber(3)
  set config(Deck_Filtered value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasConfig() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfig() => $_clearField(3);
  @$pb.TagNumber(3)
  Deck_Filtered ensureConfig() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get allowEmpty => $_getBF(3);
  @$pb.TagNumber(4)
  set allowEmpty($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAllowEmpty() => $_has(3);
  @$pb.TagNumber(4)
  void clearAllowEmpty() => $_clearField(4);
}

class DecksServiceApi {
  final $pb.RpcClient _client;

  DecksServiceApi(this._client);

  $async.Future<Deck> newDeck($pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<Deck>(ctx, 'DecksService', 'NewDeck', request, Deck());
  $async.Future<$1.OpChangesWithId> addDeck(
          $pb.ClientContext? ctx, Deck request) =>
      _client.invoke<$1.OpChangesWithId>(
          ctx, 'DecksService', 'AddDeck', request, $1.OpChangesWithId());
  $async.Future<$1.OpChangesWithId> addDeckLegacy(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<$1.OpChangesWithId>(
          ctx, 'DecksService', 'AddDeckLegacy', request, $1.OpChangesWithId());
  $async.Future<DeckId> addOrUpdateDeckLegacy(
          $pb.ClientContext? ctx, AddOrUpdateDeckLegacyRequest request) =>
      _client.invoke<DeckId>(
          ctx, 'DecksService', 'AddOrUpdateDeckLegacy', request, DeckId());
  $async.Future<DeckTreeNode> deckTree(
          $pb.ClientContext? ctx, DeckTreeRequest request) =>
      _client.invoke<DeckTreeNode>(
          ctx, 'DecksService', 'DeckTree', request, DeckTreeNode());
  $async.Future<$0.Json> deckTreeLegacy(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Json>(
          ctx, 'DecksService', 'DeckTreeLegacy', request, $0.Json());
  $async.Future<$0.Json> getAllDecksLegacy(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Json>(
          ctx, 'DecksService', 'GetAllDecksLegacy', request, $0.Json());
  $async.Future<DeckId> getDeckIdByName(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<DeckId>(
          ctx, 'DecksService', 'GetDeckIdByName', request, DeckId());
  $async.Future<Deck> getDeck($pb.ClientContext? ctx, DeckId request) =>
      _client.invoke<Deck>(ctx, 'DecksService', 'GetDeck', request, Deck());
  $async.Future<$1.OpChanges> updateDeck(
          $pb.ClientContext? ctx, Deck request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'DecksService', 'UpdateDeck', request, $1.OpChanges());
  $async.Future<$1.OpChanges> updateDeckLegacy(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'DecksService', 'UpdateDeckLegacy', request, $1.OpChanges());
  $async.Future<$1.OpChanges> setDeckCollapsed(
          $pb.ClientContext? ctx, SetDeckCollapsedRequest request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'DecksService', 'SetDeckCollapsed', request, $1.OpChanges());
  $async.Future<$0.Json> getDeckLegacy(
          $pb.ClientContext? ctx, DeckId request) =>
      _client.invoke<$0.Json>(
          ctx, 'DecksService', 'GetDeckLegacy', request, $0.Json());
  $async.Future<DeckNames> getDeckNames(
          $pb.ClientContext? ctx, GetDeckNamesRequest request) =>
      _client.invoke<DeckNames>(
          ctx, 'DecksService', 'GetDeckNames', request, DeckNames());
  $async.Future<DeckNames> getDeckAndChildNames(
          $pb.ClientContext? ctx, DeckId request) =>
      _client.invoke<DeckNames>(
          ctx, 'DecksService', 'GetDeckAndChildNames', request, DeckNames());
  $async.Future<$0.Json> newDeckLegacy(
          $pb.ClientContext? ctx, $0.Bool request) =>
      _client.invoke<$0.Json>(
          ctx, 'DecksService', 'NewDeckLegacy', request, $0.Json());
  $async.Future<$1.OpChangesWithCount> removeDecks(
          $pb.ClientContext? ctx, DeckIds request) =>
      _client.invoke<$1.OpChangesWithCount>(
          ctx, 'DecksService', 'RemoveDecks', request, $1.OpChangesWithCount());
  $async.Future<$1.OpChangesWithCount> reparentDecks(
          $pb.ClientContext? ctx, ReparentDecksRequest request) =>
      _client.invoke<$1.OpChangesWithCount>(ctx, 'DecksService',
          'ReparentDecks', request, $1.OpChangesWithCount());
  $async.Future<$1.OpChanges> renameDeck(
          $pb.ClientContext? ctx, RenameDeckRequest request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'DecksService', 'RenameDeck', request, $1.OpChanges());
  $async.Future<FilteredDeckForUpdate> getOrCreateFilteredDeck(
          $pb.ClientContext? ctx, DeckId request) =>
      _client.invoke<FilteredDeckForUpdate>(ctx, 'DecksService',
          'GetOrCreateFilteredDeck', request, FilteredDeckForUpdate());
  $async.Future<$1.OpChangesWithId> addOrUpdateFilteredDeck(
          $pb.ClientContext? ctx, FilteredDeckForUpdate request) =>
      _client.invoke<$1.OpChangesWithId>(ctx, 'DecksService',
          'AddOrUpdateFilteredDeck', request, $1.OpChangesWithId());
  $async.Future<$0.StringList> filteredDeckOrderLabels(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.StringList>(ctx, 'DecksService',
          'FilteredDeckOrderLabels', request, $0.StringList());
  $async.Future<$1.OpChanges> setCurrentDeck(
          $pb.ClientContext? ctx, DeckId request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'DecksService', 'SetCurrentDeck', request, $1.OpChanges());
  $async.Future<Deck> getCurrentDeck(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<Deck>(
          ctx, 'DecksService', 'GetCurrentDeck', request, Deck());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendDecksServiceApi {
  final $pb.RpcClient _client;

  BackendDecksServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
