// This is a generated file - do not edit.
//
// Generated from anki/stats.proto.

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

import 'cards.pb.dart' as $0;
import 'generic.pb.dart' as $1;
import 'stats.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'stats.pbenum.dart';

class ReviewLogs extends $pb.GeneratedMessage {
  factory ReviewLogs({
    $core.Iterable<CardStatsResponse_StatsRevlogEntry>? entries,
  }) {
    final result = ReviewLogs._();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  ReviewLogs._();

  factory ReviewLogs.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReviewLogs()..mergeFromBuffer(data, registry);
  factory ReviewLogs.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReviewLogs()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewLogs',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: ReviewLogs.$_createMessage)
    ..pPM<CardStatsResponse_StatsRevlogEntry>(
        1, _omitFieldNames ? '' : 'entries',
        subBuilder: CardStatsResponse_StatsRevlogEntry.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewLogs clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewLogs copyWith(void Function(ReviewLogs) updates) =>
      super.copyWith((message) => updates(message as ReviewLogs)) as ReviewLogs;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReviewLogs() / ReviewLogs.new instead')
  static ReviewLogs create() => ReviewLogs._();
  static $pb.GeneratedMessage $_createMessage() => ReviewLogs._();
  @$core.override
  ReviewLogs createEmptyInstance() => ReviewLogs._();
  @$core.pragma('dart2js:noInline')
  static ReviewLogs getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewLogs>(ReviewLogs.$_createMessage);
  static ReviewLogs? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CardStatsResponse_StatsRevlogEntry> get entries => $_getList(0);
}

class CardStatsResponse_StatsRevlogEntry extends $pb.GeneratedMessage {
  factory CardStatsResponse_StatsRevlogEntry({
    $fixnum.Int64? time,
    RevlogEntry_ReviewKind? reviewKind,
    $core.int? buttonChosen,
    $core.int? interval,
    $core.int? ease,
    $core.double? takenSecs,
    $0.FsrsMemoryState? memoryState,
    $core.int? lastInterval,
  }) {
    final result = CardStatsResponse_StatsRevlogEntry._();
    if (time != null) result.time = time;
    if (reviewKind != null) result.reviewKind = reviewKind;
    if (buttonChosen != null) result.buttonChosen = buttonChosen;
    if (interval != null) result.interval = interval;
    if (ease != null) result.ease = ease;
    if (takenSecs != null) result.takenSecs = takenSecs;
    if (memoryState != null) result.memoryState = memoryState;
    if (lastInterval != null) result.lastInterval = lastInterval;
    return result;
  }

  CardStatsResponse_StatsRevlogEntry._();

  factory CardStatsResponse_StatsRevlogEntry.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardStatsResponse_StatsRevlogEntry()..mergeFromBuffer(data, registry);
  factory CardStatsResponse_StatsRevlogEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardStatsResponse_StatsRevlogEntry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardStatsResponse.StatsRevlogEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: CardStatsResponse_StatsRevlogEntry.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'time')
    ..aE<RevlogEntry_ReviewKind>(2, _omitFieldNames ? '' : 'reviewKind',
        enumValues: RevlogEntry_ReviewKind.values)
    ..aI(3, _omitFieldNames ? '' : 'buttonChosen',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'interval', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'ease', fieldType: $pb.PbFieldType.OU3)
    ..aD(6, _omitFieldNames ? '' : 'takenSecs', fieldType: $pb.PbFieldType.OF)
    ..aOM<$0.FsrsMemoryState>(7, _omitFieldNames ? '' : 'memoryState',
        subBuilder: $0.FsrsMemoryState.$_createMessage)
    ..aI(8, _omitFieldNames ? '' : 'lastInterval',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardStatsResponse_StatsRevlogEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardStatsResponse_StatsRevlogEntry copyWith(
          void Function(CardStatsResponse_StatsRevlogEntry) updates) =>
      super.copyWith((message) =>
              updates(message as CardStatsResponse_StatsRevlogEntry))
          as CardStatsResponse_StatsRevlogEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CardStatsResponse_StatsRevlogEntry() / CardStatsResponse_StatsRevlogEntry.new instead')
  static CardStatsResponse_StatsRevlogEntry create() =>
      CardStatsResponse_StatsRevlogEntry._();
  static $pb.GeneratedMessage $_createMessage() =>
      CardStatsResponse_StatsRevlogEntry._();
  @$core.override
  CardStatsResponse_StatsRevlogEntry createEmptyInstance() =>
      CardStatsResponse_StatsRevlogEntry._();
  @$core.pragma('dart2js:noInline')
  static CardStatsResponse_StatsRevlogEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CardStatsResponse_StatsRevlogEntry>(
          CardStatsResponse_StatsRevlogEntry.$_createMessage);
  static CardStatsResponse_StatsRevlogEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get time => $_getI64(0);
  @$pb.TagNumber(1)
  set time($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => $_clearField(1);

  @$pb.TagNumber(2)
  RevlogEntry_ReviewKind get reviewKind => $_getN(1);
  @$pb.TagNumber(2)
  set reviewKind(RevlogEntry_ReviewKind value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReviewKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearReviewKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get buttonChosen => $_getIZ(2);
  @$pb.TagNumber(3)
  set buttonChosen($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasButtonChosen() => $_has(2);
  @$pb.TagNumber(3)
  void clearButtonChosen() => $_clearField(3);

  /// seconds
  @$pb.TagNumber(4)
  $core.int get interval => $_getIZ(3);
  @$pb.TagNumber(4)
  set interval($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInterval() => $_has(3);
  @$pb.TagNumber(4)
  void clearInterval() => $_clearField(4);

  /// per mill
  @$pb.TagNumber(5)
  $core.int get ease => $_getIZ(4);
  @$pb.TagNumber(5)
  set ease($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEase() => $_has(4);
  @$pb.TagNumber(5)
  void clearEase() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get takenSecs => $_getN(5);
  @$pb.TagNumber(6)
  set takenSecs($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTakenSecs() => $_has(5);
  @$pb.TagNumber(6)
  void clearTakenSecs() => $_clearField(6);

  @$pb.TagNumber(7)
  $0.FsrsMemoryState get memoryState => $_getN(6);
  @$pb.TagNumber(7)
  set memoryState($0.FsrsMemoryState value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasMemoryState() => $_has(6);
  @$pb.TagNumber(7)
  void clearMemoryState() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.FsrsMemoryState ensureMemoryState() => $_ensure(6);

  /// seconds
  @$pb.TagNumber(8)
  $core.int get lastInterval => $_getIZ(7);
  @$pb.TagNumber(8)
  set lastInterval($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLastInterval() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastInterval() => $_clearField(8);
}

class CardStatsResponse extends $pb.GeneratedMessage {
  factory CardStatsResponse({
    $core.Iterable<CardStatsResponse_StatsRevlogEntry>? revlog,
    $fixnum.Int64? cardId,
    $fixnum.Int64? noteId,
    $core.String? deck,
    $fixnum.Int64? added,
    $fixnum.Int64? firstReview,
    $fixnum.Int64? latestReview,
    $fixnum.Int64? dueDate,
    $core.int? duePosition,
    $core.int? interval,
    $core.int? ease,
    $core.int? reviews,
    $core.int? lapses,
    $core.double? averageSecs,
    $core.double? totalSecs,
    $core.String? cardType,
    $core.String? notetype,
    $0.FsrsMemoryState? memoryState,
    $core.double? fsrsRetrievability,
    $core.String? customData,
    $core.String? preset,
    $core.String? originalDeck,
    $core.double? desiredRetention,
    $core.Iterable<$core.double>? fsrsParams,
  }) {
    final result = CardStatsResponse._();
    if (revlog != null) result.revlog.addAll(revlog);
    if (cardId != null) result.cardId = cardId;
    if (noteId != null) result.noteId = noteId;
    if (deck != null) result.deck = deck;
    if (added != null) result.added = added;
    if (firstReview != null) result.firstReview = firstReview;
    if (latestReview != null) result.latestReview = latestReview;
    if (dueDate != null) result.dueDate = dueDate;
    if (duePosition != null) result.duePosition = duePosition;
    if (interval != null) result.interval = interval;
    if (ease != null) result.ease = ease;
    if (reviews != null) result.reviews = reviews;
    if (lapses != null) result.lapses = lapses;
    if (averageSecs != null) result.averageSecs = averageSecs;
    if (totalSecs != null) result.totalSecs = totalSecs;
    if (cardType != null) result.cardType = cardType;
    if (notetype != null) result.notetype = notetype;
    if (memoryState != null) result.memoryState = memoryState;
    if (fsrsRetrievability != null)
      result.fsrsRetrievability = fsrsRetrievability;
    if (customData != null) result.customData = customData;
    if (preset != null) result.preset = preset;
    if (originalDeck != null) result.originalDeck = originalDeck;
    if (desiredRetention != null) result.desiredRetention = desiredRetention;
    if (fsrsParams != null) result.fsrsParams.addAll(fsrsParams);
    return result;
  }

  CardStatsResponse._();

  factory CardStatsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardStatsResponse()..mergeFromBuffer(data, registry);
  factory CardStatsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardStatsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardStatsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: CardStatsResponse.$_createMessage)
    ..pPM<CardStatsResponse_StatsRevlogEntry>(
        1, _omitFieldNames ? '' : 'revlog',
        subBuilder: CardStatsResponse_StatsRevlogEntry.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'cardId')
    ..aInt64(3, _omitFieldNames ? '' : 'noteId')
    ..aOS(4, _omitFieldNames ? '' : 'deck')
    ..aInt64(5, _omitFieldNames ? '' : 'added')
    ..aInt64(6, _omitFieldNames ? '' : 'firstReview')
    ..aInt64(7, _omitFieldNames ? '' : 'latestReview')
    ..aInt64(8, _omitFieldNames ? '' : 'dueDate')
    ..aI(9, _omitFieldNames ? '' : 'duePosition')
    ..aI(10, _omitFieldNames ? '' : 'interval', fieldType: $pb.PbFieldType.OU3)
    ..aI(11, _omitFieldNames ? '' : 'ease', fieldType: $pb.PbFieldType.OU3)
    ..aI(12, _omitFieldNames ? '' : 'reviews', fieldType: $pb.PbFieldType.OU3)
    ..aI(13, _omitFieldNames ? '' : 'lapses', fieldType: $pb.PbFieldType.OU3)
    ..aD(14, _omitFieldNames ? '' : 'averageSecs',
        fieldType: $pb.PbFieldType.OF)
    ..aD(15, _omitFieldNames ? '' : 'totalSecs', fieldType: $pb.PbFieldType.OF)
    ..aOS(16, _omitFieldNames ? '' : 'cardType')
    ..aOS(17, _omitFieldNames ? '' : 'notetype')
    ..aOM<$0.FsrsMemoryState>(18, _omitFieldNames ? '' : 'memoryState',
        subBuilder: $0.FsrsMemoryState.$_createMessage)
    ..aD(19, _omitFieldNames ? '' : 'fsrsRetrievability',
        fieldType: $pb.PbFieldType.OF)
    ..aOS(20, _omitFieldNames ? '' : 'customData')
    ..aOS(21, _omitFieldNames ? '' : 'preset')
    ..aOS(22, _omitFieldNames ? '' : 'originalDeck')
    ..aD(23, _omitFieldNames ? '' : 'desiredRetention',
        fieldType: $pb.PbFieldType.OF)
    ..p<$core.double>(
        24, _omitFieldNames ? '' : 'fsrsParams', $pb.PbFieldType.KF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardStatsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardStatsResponse copyWith(void Function(CardStatsResponse) updates) =>
      super.copyWith((message) => updates(message as CardStatsResponse))
          as CardStatsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CardStatsResponse() / CardStatsResponse.new instead')
  static CardStatsResponse create() => CardStatsResponse._();
  static $pb.GeneratedMessage $_createMessage() => CardStatsResponse._();
  @$core.override
  CardStatsResponse createEmptyInstance() => CardStatsResponse._();
  @$core.pragma('dart2js:noInline')
  static CardStatsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CardStatsResponse>(
          CardStatsResponse.$_createMessage);
  static CardStatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CardStatsResponse_StatsRevlogEntry> get revlog => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cardId => $_getI64(1);
  @$pb.TagNumber(2)
  set cardId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get noteId => $_getI64(2);
  @$pb.TagNumber(3)
  set noteId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNoteId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNoteId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get deck => $_getSZ(3);
  @$pb.TagNumber(4)
  set deck($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDeck() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeck() => $_clearField(4);

  /// Unix timestamps
  @$pb.TagNumber(5)
  $fixnum.Int64 get added => $_getI64(4);
  @$pb.TagNumber(5)
  set added($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAdded() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdded() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get firstReview => $_getI64(5);
  @$pb.TagNumber(6)
  set firstReview($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFirstReview() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirstReview() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get latestReview => $_getI64(6);
  @$pb.TagNumber(7)
  set latestReview($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLatestReview() => $_has(6);
  @$pb.TagNumber(7)
  void clearLatestReview() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get dueDate => $_getI64(7);
  @$pb.TagNumber(8)
  set dueDate($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDueDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearDueDate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get duePosition => $_getIZ(8);
  @$pb.TagNumber(9)
  set duePosition($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDuePosition() => $_has(8);
  @$pb.TagNumber(9)
  void clearDuePosition() => $_clearField(9);

  /// days
  @$pb.TagNumber(10)
  $core.int get interval => $_getIZ(9);
  @$pb.TagNumber(10)
  set interval($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInterval() => $_has(9);
  @$pb.TagNumber(10)
  void clearInterval() => $_clearField(10);

  /// per mill
  @$pb.TagNumber(11)
  $core.int get ease => $_getIZ(10);
  @$pb.TagNumber(11)
  set ease($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasEase() => $_has(10);
  @$pb.TagNumber(11)
  void clearEase() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get reviews => $_getIZ(11);
  @$pb.TagNumber(12)
  set reviews($core.int value) => $_setUnsignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasReviews() => $_has(11);
  @$pb.TagNumber(12)
  void clearReviews() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get lapses => $_getIZ(12);
  @$pb.TagNumber(13)
  set lapses($core.int value) => $_setUnsignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasLapses() => $_has(12);
  @$pb.TagNumber(13)
  void clearLapses() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get averageSecs => $_getN(13);
  @$pb.TagNumber(14)
  set averageSecs($core.double value) => $_setFloat(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAverageSecs() => $_has(13);
  @$pb.TagNumber(14)
  void clearAverageSecs() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get totalSecs => $_getN(14);
  @$pb.TagNumber(15)
  set totalSecs($core.double value) => $_setFloat(14, value);
  @$pb.TagNumber(15)
  $core.bool hasTotalSecs() => $_has(14);
  @$pb.TagNumber(15)
  void clearTotalSecs() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get cardType => $_getSZ(15);
  @$pb.TagNumber(16)
  set cardType($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCardType() => $_has(15);
  @$pb.TagNumber(16)
  void clearCardType() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get notetype => $_getSZ(16);
  @$pb.TagNumber(17)
  set notetype($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasNotetype() => $_has(16);
  @$pb.TagNumber(17)
  void clearNotetype() => $_clearField(17);

  @$pb.TagNumber(18)
  $0.FsrsMemoryState get memoryState => $_getN(17);
  @$pb.TagNumber(18)
  set memoryState($0.FsrsMemoryState value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasMemoryState() => $_has(17);
  @$pb.TagNumber(18)
  void clearMemoryState() => $_clearField(18);
  @$pb.TagNumber(18)
  $0.FsrsMemoryState ensureMemoryState() => $_ensure(17);

  /// not set if due date/state not available
  @$pb.TagNumber(19)
  $core.double get fsrsRetrievability => $_getN(18);
  @$pb.TagNumber(19)
  set fsrsRetrievability($core.double value) => $_setFloat(18, value);
  @$pb.TagNumber(19)
  $core.bool hasFsrsRetrievability() => $_has(18);
  @$pb.TagNumber(19)
  void clearFsrsRetrievability() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get customData => $_getSZ(19);
  @$pb.TagNumber(20)
  set customData($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCustomData() => $_has(19);
  @$pb.TagNumber(20)
  void clearCustomData() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get preset => $_getSZ(20);
  @$pb.TagNumber(21)
  set preset($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasPreset() => $_has(20);
  @$pb.TagNumber(21)
  void clearPreset() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get originalDeck => $_getSZ(21);
  @$pb.TagNumber(22)
  set originalDeck($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasOriginalDeck() => $_has(21);
  @$pb.TagNumber(22)
  void clearOriginalDeck() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.double get desiredRetention => $_getN(22);
  @$pb.TagNumber(23)
  set desiredRetention($core.double value) => $_setFloat(22, value);
  @$pb.TagNumber(23)
  $core.bool hasDesiredRetention() => $_has(22);
  @$pb.TagNumber(23)
  void clearDesiredRetention() => $_clearField(23);

  @$pb.TagNumber(24)
  $pb.PbList<$core.double> get fsrsParams => $_getList(23);
}

class GraphsRequest extends $pb.GeneratedMessage {
  factory GraphsRequest({
    $core.String? search,
    $core.int? days,
  }) {
    final result = GraphsRequest._();
    if (search != null) result.search = search;
    if (days != null) result.days = days;
    return result;
  }

  GraphsRequest._();

  factory GraphsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsRequest()..mergeFromBuffer(data, registry);
  factory GraphsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'search')
    ..aI(2, _omitFieldNames ? '' : 'days', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsRequest copyWith(void Function(GraphsRequest) updates) =>
      super.copyWith((message) => updates(message as GraphsRequest))
          as GraphsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GraphsRequest() / GraphsRequest.new instead')
  static GraphsRequest create() => GraphsRequest._();
  static $pb.GeneratedMessage $_createMessage() => GraphsRequest._();
  @$core.override
  GraphsRequest createEmptyInstance() => GraphsRequest._();
  @$core.pragma('dart2js:noInline')
  static GraphsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphsRequest>(
          GraphsRequest.$_createMessage);
  static GraphsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get search => $_getSZ(0);
  @$pb.TagNumber(1)
  set search($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSearch() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearch() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get days => $_getIZ(1);
  @$pb.TagNumber(2)
  set days($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDays() => $_has(1);
  @$pb.TagNumber(2)
  void clearDays() => $_clearField(2);
}

class GraphsResponse_Added extends $pb.GeneratedMessage {
  factory GraphsResponse_Added({
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? added,
  }) {
    final result = GraphsResponse_Added._();
    if (added != null) result.added.addEntries(added);
    return result;
  }

  GraphsResponse_Added._();

  factory GraphsResponse_Added.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Added()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Added.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Added()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Added',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Added.$_createMessage)
    ..m<$core.int, $core.int>(1, _omitFieldNames ? '' : 'added',
        entryClassName: 'GraphsResponse.Added.AddedEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('anki.stats'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Added clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Added copyWith(void Function(GraphsResponse_Added) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_Added))
          as GraphsResponse_Added;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Added() / GraphsResponse_Added.new instead')
  static GraphsResponse_Added create() => GraphsResponse_Added._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse_Added._();
  @$core.override
  GraphsResponse_Added createEmptyInstance() => GraphsResponse_Added._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Added getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Added>(
          GraphsResponse_Added.$_createMessage);
  static GraphsResponse_Added? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $core.int> get added => $_getMap(0);
}

class GraphsResponse_Intervals extends $pb.GeneratedMessage {
  factory GraphsResponse_Intervals({
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? intervals,
  }) {
    final result = GraphsResponse_Intervals._();
    if (intervals != null) result.intervals.addEntries(intervals);
    return result;
  }

  GraphsResponse_Intervals._();

  factory GraphsResponse_Intervals.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Intervals()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Intervals.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Intervals()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Intervals',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Intervals.$_createMessage)
    ..m<$core.int, $core.int>(1, _omitFieldNames ? '' : 'intervals',
        entryClassName: 'GraphsResponse.Intervals.IntervalsEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('anki.stats'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Intervals clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Intervals copyWith(
          void Function(GraphsResponse_Intervals) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_Intervals))
          as GraphsResponse_Intervals;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Intervals() / GraphsResponse_Intervals.new instead')
  static GraphsResponse_Intervals create() => GraphsResponse_Intervals._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse_Intervals._();
  @$core.override
  GraphsResponse_Intervals createEmptyInstance() =>
      GraphsResponse_Intervals._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Intervals getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Intervals>(
          GraphsResponse_Intervals.$_createMessage);
  static GraphsResponse_Intervals? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $core.int> get intervals => $_getMap(0);
}

class GraphsResponse_Eases extends $pb.GeneratedMessage {
  factory GraphsResponse_Eases({
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? eases,
    $core.double? average,
  }) {
    final result = GraphsResponse_Eases._();
    if (eases != null) result.eases.addEntries(eases);
    if (average != null) result.average = average;
    return result;
  }

  GraphsResponse_Eases._();

  factory GraphsResponse_Eases.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Eases()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Eases.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Eases()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Eases',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Eases.$_createMessage)
    ..m<$core.int, $core.int>(1, _omitFieldNames ? '' : 'eases',
        entryClassName: 'GraphsResponse.Eases.EasesEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('anki.stats'))
    ..aD(2, _omitFieldNames ? '' : 'average', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Eases clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Eases copyWith(void Function(GraphsResponse_Eases) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_Eases))
          as GraphsResponse_Eases;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Eases() / GraphsResponse_Eases.new instead')
  static GraphsResponse_Eases create() => GraphsResponse_Eases._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse_Eases._();
  @$core.override
  GraphsResponse_Eases createEmptyInstance() => GraphsResponse_Eases._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Eases getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Eases>(
          GraphsResponse_Eases.$_createMessage);
  static GraphsResponse_Eases? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $core.int> get eases => $_getMap(0);

  @$pb.TagNumber(2)
  $core.double get average => $_getN(1);
  @$pb.TagNumber(2)
  set average($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAverage() => $_has(1);
  @$pb.TagNumber(2)
  void clearAverage() => $_clearField(2);
}

class GraphsResponse_Retrievability extends $pb.GeneratedMessage {
  factory GraphsResponse_Retrievability({
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? retrievability,
    $core.double? average,
    $core.double? sumByCard,
    $core.double? sumByNote,
  }) {
    final result = GraphsResponse_Retrievability._();
    if (retrievability != null)
      result.retrievability.addEntries(retrievability);
    if (average != null) result.average = average;
    if (sumByCard != null) result.sumByCard = sumByCard;
    if (sumByNote != null) result.sumByNote = sumByNote;
    return result;
  }

  GraphsResponse_Retrievability._();

  factory GraphsResponse_Retrievability.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Retrievability()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Retrievability.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Retrievability()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Retrievability',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Retrievability.$_createMessage)
    ..m<$core.int, $core.int>(1, _omitFieldNames ? '' : 'retrievability',
        entryClassName: 'GraphsResponse.Retrievability.RetrievabilityEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('anki.stats'))
    ..aD(2, _omitFieldNames ? '' : 'average', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'sumByCard', fieldType: $pb.PbFieldType.OF)
    ..aD(4, _omitFieldNames ? '' : 'sumByNote', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Retrievability clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Retrievability copyWith(
          void Function(GraphsResponse_Retrievability) updates) =>
      super.copyWith(
              (message) => updates(message as GraphsResponse_Retrievability))
          as GraphsResponse_Retrievability;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Retrievability() / GraphsResponse_Retrievability.new instead')
  static GraphsResponse_Retrievability create() =>
      GraphsResponse_Retrievability._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_Retrievability._();
  @$core.override
  GraphsResponse_Retrievability createEmptyInstance() =>
      GraphsResponse_Retrievability._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Retrievability getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Retrievability>(
          GraphsResponse_Retrievability.$_createMessage);
  static GraphsResponse_Retrievability? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $core.int> get retrievability => $_getMap(0);

  @$pb.TagNumber(2)
  $core.double get average => $_getN(1);
  @$pb.TagNumber(2)
  set average($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAverage() => $_has(1);
  @$pb.TagNumber(2)
  void clearAverage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get sumByCard => $_getN(2);
  @$pb.TagNumber(3)
  set sumByCard($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSumByCard() => $_has(2);
  @$pb.TagNumber(3)
  void clearSumByCard() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get sumByNote => $_getN(3);
  @$pb.TagNumber(4)
  set sumByNote($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSumByNote() => $_has(3);
  @$pb.TagNumber(4)
  void clearSumByNote() => $_clearField(4);
}

class GraphsResponse_FutureDue extends $pb.GeneratedMessage {
  factory GraphsResponse_FutureDue({
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? futureDue,
    $core.bool? haveBacklog,
    $core.int? dailyLoad,
  }) {
    final result = GraphsResponse_FutureDue._();
    if (futureDue != null) result.futureDue.addEntries(futureDue);
    if (haveBacklog != null) result.haveBacklog = haveBacklog;
    if (dailyLoad != null) result.dailyLoad = dailyLoad;
    return result;
  }

  GraphsResponse_FutureDue._();

  factory GraphsResponse_FutureDue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_FutureDue()..mergeFromBuffer(data, registry);
  factory GraphsResponse_FutureDue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_FutureDue()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.FutureDue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_FutureDue.$_createMessage)
    ..m<$core.int, $core.int>(1, _omitFieldNames ? '' : 'futureDue',
        entryClassName: 'GraphsResponse.FutureDue.FutureDueEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('anki.stats'))
    ..aOB(2, _omitFieldNames ? '' : 'haveBacklog')
    ..aI(3, _omitFieldNames ? '' : 'dailyLoad', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_FutureDue clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_FutureDue copyWith(
          void Function(GraphsResponse_FutureDue) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_FutureDue))
          as GraphsResponse_FutureDue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_FutureDue() / GraphsResponse_FutureDue.new instead')
  static GraphsResponse_FutureDue create() => GraphsResponse_FutureDue._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse_FutureDue._();
  @$core.override
  GraphsResponse_FutureDue createEmptyInstance() =>
      GraphsResponse_FutureDue._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_FutureDue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_FutureDue>(
          GraphsResponse_FutureDue.$_createMessage);
  static GraphsResponse_FutureDue? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $core.int> get futureDue => $_getMap(0);

  @$pb.TagNumber(2)
  $core.bool get haveBacklog => $_getBF(1);
  @$pb.TagNumber(2)
  set haveBacklog($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHaveBacklog() => $_has(1);
  @$pb.TagNumber(2)
  void clearHaveBacklog() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get dailyLoad => $_getIZ(2);
  @$pb.TagNumber(3)
  set dailyLoad($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDailyLoad() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyLoad() => $_clearField(3);
}

class GraphsResponse_Today extends $pb.GeneratedMessage {
  factory GraphsResponse_Today({
    $core.int? answerCount,
    $core.int? answerMillis,
    $core.int? correctCount,
    $core.int? matureCorrect,
    $core.int? matureCount,
    $core.int? learnCount,
    $core.int? reviewCount,
    $core.int? relearnCount,
    $core.int? earlyReviewCount,
  }) {
    final result = GraphsResponse_Today._();
    if (answerCount != null) result.answerCount = answerCount;
    if (answerMillis != null) result.answerMillis = answerMillis;
    if (correctCount != null) result.correctCount = correctCount;
    if (matureCorrect != null) result.matureCorrect = matureCorrect;
    if (matureCount != null) result.matureCount = matureCount;
    if (learnCount != null) result.learnCount = learnCount;
    if (reviewCount != null) result.reviewCount = reviewCount;
    if (relearnCount != null) result.relearnCount = relearnCount;
    if (earlyReviewCount != null) result.earlyReviewCount = earlyReviewCount;
    return result;
  }

  GraphsResponse_Today._();

  factory GraphsResponse_Today.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Today()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Today.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Today()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Today',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Today.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'answerCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'answerMillis',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'correctCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'matureCorrect',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'matureCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'learnCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'reviewCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(8, _omitFieldNames ? '' : 'relearnCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(9, _omitFieldNames ? '' : 'earlyReviewCount',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Today clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Today copyWith(void Function(GraphsResponse_Today) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_Today))
          as GraphsResponse_Today;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Today() / GraphsResponse_Today.new instead')
  static GraphsResponse_Today create() => GraphsResponse_Today._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse_Today._();
  @$core.override
  GraphsResponse_Today createEmptyInstance() => GraphsResponse_Today._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Today getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Today>(
          GraphsResponse_Today.$_createMessage);
  static GraphsResponse_Today? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get answerCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set answerCount($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAnswerCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnswerCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get answerMillis => $_getIZ(1);
  @$pb.TagNumber(2)
  set answerMillis($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAnswerMillis() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnswerMillis() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get correctCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set correctCount($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCorrectCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCorrectCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get matureCorrect => $_getIZ(3);
  @$pb.TagNumber(4)
  set matureCorrect($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMatureCorrect() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatureCorrect() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get matureCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set matureCount($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMatureCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMatureCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get learnCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set learnCount($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLearnCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearLearnCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get reviewCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set reviewCount($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReviewCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearReviewCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get relearnCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set relearnCount($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRelearnCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearRelearnCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get earlyReviewCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set earlyReviewCount($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasEarlyReviewCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearEarlyReviewCount() => $_clearField(9);
}

class GraphsResponse_Hours_Hour extends $pb.GeneratedMessage {
  factory GraphsResponse_Hours_Hour({
    $core.int? total,
    $core.int? correct,
  }) {
    final result = GraphsResponse_Hours_Hour._();
    if (total != null) result.total = total;
    if (correct != null) result.correct = correct;
    return result;
  }

  GraphsResponse_Hours_Hour._();

  factory GraphsResponse_Hours_Hour.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Hours_Hour()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Hours_Hour.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Hours_Hour()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Hours.Hour',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Hours_Hour.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'total', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'correct', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Hours_Hour clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Hours_Hour copyWith(
          void Function(GraphsResponse_Hours_Hour) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_Hours_Hour))
          as GraphsResponse_Hours_Hour;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Hours_Hour() / GraphsResponse_Hours_Hour.new instead')
  static GraphsResponse_Hours_Hour create() => GraphsResponse_Hours_Hour._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_Hours_Hour._();
  @$core.override
  GraphsResponse_Hours_Hour createEmptyInstance() =>
      GraphsResponse_Hours_Hour._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Hours_Hour getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Hours_Hour>(
          GraphsResponse_Hours_Hour.$_createMessage);
  static GraphsResponse_Hours_Hour? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get total => $_getIZ(0);
  @$pb.TagNumber(1)
  set total($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotal() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotal() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get correct => $_getIZ(1);
  @$pb.TagNumber(2)
  set correct($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCorrect() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorrect() => $_clearField(2);
}

/// each bucket is a 24 element vec
class GraphsResponse_Hours extends $pb.GeneratedMessage {
  factory GraphsResponse_Hours({
    $core.Iterable<GraphsResponse_Hours_Hour>? oneMonth,
    $core.Iterable<GraphsResponse_Hours_Hour>? threeMonths,
    $core.Iterable<GraphsResponse_Hours_Hour>? oneYear,
    $core.Iterable<GraphsResponse_Hours_Hour>? allTime,
  }) {
    final result = GraphsResponse_Hours._();
    if (oneMonth != null) result.oneMonth.addAll(oneMonth);
    if (threeMonths != null) result.threeMonths.addAll(threeMonths);
    if (oneYear != null) result.oneYear.addAll(oneYear);
    if (allTime != null) result.allTime.addAll(allTime);
    return result;
  }

  GraphsResponse_Hours._();

  factory GraphsResponse_Hours.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Hours()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Hours.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Hours()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Hours',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Hours.$_createMessage)
    ..pPM<GraphsResponse_Hours_Hour>(1, _omitFieldNames ? '' : 'oneMonth',
        subBuilder: GraphsResponse_Hours_Hour.$_createMessage)
    ..pPM<GraphsResponse_Hours_Hour>(2, _omitFieldNames ? '' : 'threeMonths',
        subBuilder: GraphsResponse_Hours_Hour.$_createMessage)
    ..pPM<GraphsResponse_Hours_Hour>(3, _omitFieldNames ? '' : 'oneYear',
        subBuilder: GraphsResponse_Hours_Hour.$_createMessage)
    ..pPM<GraphsResponse_Hours_Hour>(4, _omitFieldNames ? '' : 'allTime',
        subBuilder: GraphsResponse_Hours_Hour.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Hours clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Hours copyWith(void Function(GraphsResponse_Hours) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_Hours))
          as GraphsResponse_Hours;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Hours() / GraphsResponse_Hours.new instead')
  static GraphsResponse_Hours create() => GraphsResponse_Hours._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse_Hours._();
  @$core.override
  GraphsResponse_Hours createEmptyInstance() => GraphsResponse_Hours._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Hours getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Hours>(
          GraphsResponse_Hours.$_createMessage);
  static GraphsResponse_Hours? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GraphsResponse_Hours_Hour> get oneMonth => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<GraphsResponse_Hours_Hour> get threeMonths => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<GraphsResponse_Hours_Hour> get oneYear => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<GraphsResponse_Hours_Hour> get allTime => $_getList(3);
}

class GraphsResponse_ReviewCountsAndTimes_Reviews extends $pb.GeneratedMessage {
  factory GraphsResponse_ReviewCountsAndTimes_Reviews({
    $core.int? learn,
    $core.int? relearn,
    $core.int? young,
    $core.int? mature,
    $core.int? filtered,
  }) {
    final result = GraphsResponse_ReviewCountsAndTimes_Reviews._();
    if (learn != null) result.learn = learn;
    if (relearn != null) result.relearn = relearn;
    if (young != null) result.young = young;
    if (mature != null) result.mature = mature;
    if (filtered != null) result.filtered = filtered;
    return result;
  }

  GraphsResponse_ReviewCountsAndTimes_Reviews._();

  factory GraphsResponse_ReviewCountsAndTimes_Reviews.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_ReviewCountsAndTimes_Reviews()
        ..mergeFromBuffer(data, registry);
  factory GraphsResponse_ReviewCountsAndTimes_Reviews.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_ReviewCountsAndTimes_Reviews()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.ReviewCountsAndTimes.Reviews',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance:
          GraphsResponse_ReviewCountsAndTimes_Reviews.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'learn', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'relearn', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'young', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'mature', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'filtered', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_ReviewCountsAndTimes_Reviews clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_ReviewCountsAndTimes_Reviews copyWith(
          void Function(GraphsResponse_ReviewCountsAndTimes_Reviews) updates) =>
      super.copyWith((message) =>
              updates(message as GraphsResponse_ReviewCountsAndTimes_Reviews))
          as GraphsResponse_ReviewCountsAndTimes_Reviews;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_ReviewCountsAndTimes_Reviews() / GraphsResponse_ReviewCountsAndTimes_Reviews.new instead')
  static GraphsResponse_ReviewCountsAndTimes_Reviews create() =>
      GraphsResponse_ReviewCountsAndTimes_Reviews._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_ReviewCountsAndTimes_Reviews._();
  @$core.override
  GraphsResponse_ReviewCountsAndTimes_Reviews createEmptyInstance() =>
      GraphsResponse_ReviewCountsAndTimes_Reviews._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_ReviewCountsAndTimes_Reviews getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GraphsResponse_ReviewCountsAndTimes_Reviews>(
          GraphsResponse_ReviewCountsAndTimes_Reviews.$_createMessage);
  static GraphsResponse_ReviewCountsAndTimes_Reviews? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get learn => $_getIZ(0);
  @$pb.TagNumber(1)
  set learn($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLearn() => $_has(0);
  @$pb.TagNumber(1)
  void clearLearn() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get relearn => $_getIZ(1);
  @$pb.TagNumber(2)
  set relearn($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRelearn() => $_has(1);
  @$pb.TagNumber(2)
  void clearRelearn() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get young => $_getIZ(2);
  @$pb.TagNumber(3)
  set young($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasYoung() => $_has(2);
  @$pb.TagNumber(3)
  void clearYoung() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get mature => $_getIZ(3);
  @$pb.TagNumber(4)
  set mature($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMature() => $_has(3);
  @$pb.TagNumber(4)
  void clearMature() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get filtered => $_getIZ(4);
  @$pb.TagNumber(5)
  set filtered($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFiltered() => $_has(4);
  @$pb.TagNumber(5)
  void clearFiltered() => $_clearField(5);
}

class GraphsResponse_ReviewCountsAndTimes extends $pb.GeneratedMessage {
  factory GraphsResponse_ReviewCountsAndTimes({
    $core.Iterable<
            $core
            .MapEntry<$core.int, GraphsResponse_ReviewCountsAndTimes_Reviews>>?
        count,
    $core.Iterable<
            $core
            .MapEntry<$core.int, GraphsResponse_ReviewCountsAndTimes_Reviews>>?
        time,
  }) {
    final result = GraphsResponse_ReviewCountsAndTimes._();
    if (count != null) result.count.addEntries(count);
    if (time != null) result.time.addEntries(time);
    return result;
  }

  GraphsResponse_ReviewCountsAndTimes._();

  factory GraphsResponse_ReviewCountsAndTimes.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_ReviewCountsAndTimes()..mergeFromBuffer(data, registry);
  factory GraphsResponse_ReviewCountsAndTimes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_ReviewCountsAndTimes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.ReviewCountsAndTimes',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_ReviewCountsAndTimes.$_createMessage)
    ..m<$core.int, GraphsResponse_ReviewCountsAndTimes_Reviews>(
        1, _omitFieldNames ? '' : 'count',
        entryClassName: 'GraphsResponse.ReviewCountsAndTimes.CountEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator:
            GraphsResponse_ReviewCountsAndTimes_Reviews.$_createMessage,
        valueDefaultOrMaker:
            GraphsResponse_ReviewCountsAndTimes_Reviews.getDefault,
        packageName: const $pb.PackageName('anki.stats'))
    ..m<$core.int, GraphsResponse_ReviewCountsAndTimes_Reviews>(
        2, _omitFieldNames ? '' : 'time',
        entryClassName: 'GraphsResponse.ReviewCountsAndTimes.TimeEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator:
            GraphsResponse_ReviewCountsAndTimes_Reviews.$_createMessage,
        valueDefaultOrMaker:
            GraphsResponse_ReviewCountsAndTimes_Reviews.getDefault,
        packageName: const $pb.PackageName('anki.stats'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_ReviewCountsAndTimes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_ReviewCountsAndTimes copyWith(
          void Function(GraphsResponse_ReviewCountsAndTimes) updates) =>
      super.copyWith((message) =>
              updates(message as GraphsResponse_ReviewCountsAndTimes))
          as GraphsResponse_ReviewCountsAndTimes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_ReviewCountsAndTimes() / GraphsResponse_ReviewCountsAndTimes.new instead')
  static GraphsResponse_ReviewCountsAndTimes create() =>
      GraphsResponse_ReviewCountsAndTimes._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_ReviewCountsAndTimes._();
  @$core.override
  GraphsResponse_ReviewCountsAndTimes createEmptyInstance() =>
      GraphsResponse_ReviewCountsAndTimes._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_ReviewCountsAndTimes getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GraphsResponse_ReviewCountsAndTimes>(
          GraphsResponse_ReviewCountsAndTimes.$_createMessage);
  static GraphsResponse_ReviewCountsAndTimes? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, GraphsResponse_ReviewCountsAndTimes_Reviews> get count =>
      $_getMap(0);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.int, GraphsResponse_ReviewCountsAndTimes_Reviews> get time =>
      $_getMap(1);
}

class GraphsResponse_Buttons_ButtonCounts extends $pb.GeneratedMessage {
  factory GraphsResponse_Buttons_ButtonCounts({
    $core.Iterable<$core.int>? learning,
    $core.Iterable<$core.int>? young,
    $core.Iterable<$core.int>? mature,
  }) {
    final result = GraphsResponse_Buttons_ButtonCounts._();
    if (learning != null) result.learning.addAll(learning);
    if (young != null) result.young.addAll(young);
    if (mature != null) result.mature.addAll(mature);
    return result;
  }

  GraphsResponse_Buttons_ButtonCounts._();

  factory GraphsResponse_Buttons_ButtonCounts.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Buttons_ButtonCounts()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Buttons_ButtonCounts.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Buttons_ButtonCounts()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Buttons.ButtonCounts',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Buttons_ButtonCounts.$_createMessage)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'learning', $pb.PbFieldType.KU3)
    ..p<$core.int>(2, _omitFieldNames ? '' : 'young', $pb.PbFieldType.KU3)
    ..p<$core.int>(3, _omitFieldNames ? '' : 'mature', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Buttons_ButtonCounts clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Buttons_ButtonCounts copyWith(
          void Function(GraphsResponse_Buttons_ButtonCounts) updates) =>
      super.copyWith((message) =>
              updates(message as GraphsResponse_Buttons_ButtonCounts))
          as GraphsResponse_Buttons_ButtonCounts;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Buttons_ButtonCounts() / GraphsResponse_Buttons_ButtonCounts.new instead')
  static GraphsResponse_Buttons_ButtonCounts create() =>
      GraphsResponse_Buttons_ButtonCounts._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_Buttons_ButtonCounts._();
  @$core.override
  GraphsResponse_Buttons_ButtonCounts createEmptyInstance() =>
      GraphsResponse_Buttons_ButtonCounts._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Buttons_ButtonCounts getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GraphsResponse_Buttons_ButtonCounts>(
          GraphsResponse_Buttons_ButtonCounts.$_createMessage);
  static GraphsResponse_Buttons_ButtonCounts? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get learning => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get young => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get mature => $_getList(2);
}

/// 4 element vecs for buttons 1-4
class GraphsResponse_Buttons extends $pb.GeneratedMessage {
  factory GraphsResponse_Buttons({
    GraphsResponse_Buttons_ButtonCounts? oneMonth,
    GraphsResponse_Buttons_ButtonCounts? threeMonths,
    GraphsResponse_Buttons_ButtonCounts? oneYear,
    GraphsResponse_Buttons_ButtonCounts? allTime,
  }) {
    final result = GraphsResponse_Buttons._();
    if (oneMonth != null) result.oneMonth = oneMonth;
    if (threeMonths != null) result.threeMonths = threeMonths;
    if (oneYear != null) result.oneYear = oneYear;
    if (allTime != null) result.allTime = allTime;
    return result;
  }

  GraphsResponse_Buttons._();

  factory GraphsResponse_Buttons.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Buttons()..mergeFromBuffer(data, registry);
  factory GraphsResponse_Buttons.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_Buttons()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.Buttons',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_Buttons.$_createMessage)
    ..aOM<GraphsResponse_Buttons_ButtonCounts>(
        1, _omitFieldNames ? '' : 'oneMonth',
        subBuilder: GraphsResponse_Buttons_ButtonCounts.$_createMessage)
    ..aOM<GraphsResponse_Buttons_ButtonCounts>(
        2, _omitFieldNames ? '' : 'threeMonths',
        subBuilder: GraphsResponse_Buttons_ButtonCounts.$_createMessage)
    ..aOM<GraphsResponse_Buttons_ButtonCounts>(
        3, _omitFieldNames ? '' : 'oneYear',
        subBuilder: GraphsResponse_Buttons_ButtonCounts.$_createMessage)
    ..aOM<GraphsResponse_Buttons_ButtonCounts>(
        4, _omitFieldNames ? '' : 'allTime',
        subBuilder: GraphsResponse_Buttons_ButtonCounts.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Buttons clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_Buttons copyWith(
          void Function(GraphsResponse_Buttons) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_Buttons))
          as GraphsResponse_Buttons;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_Buttons() / GraphsResponse_Buttons.new instead')
  static GraphsResponse_Buttons create() => GraphsResponse_Buttons._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse_Buttons._();
  @$core.override
  GraphsResponse_Buttons createEmptyInstance() => GraphsResponse_Buttons._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_Buttons getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_Buttons>(
          GraphsResponse_Buttons.$_createMessage);
  static GraphsResponse_Buttons? _defaultInstance;

  @$pb.TagNumber(1)
  GraphsResponse_Buttons_ButtonCounts get oneMonth => $_getN(0);
  @$pb.TagNumber(1)
  set oneMonth(GraphsResponse_Buttons_ButtonCounts value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOneMonth() => $_has(0);
  @$pb.TagNumber(1)
  void clearOneMonth() => $_clearField(1);
  @$pb.TagNumber(1)
  GraphsResponse_Buttons_ButtonCounts ensureOneMonth() => $_ensure(0);

  @$pb.TagNumber(2)
  GraphsResponse_Buttons_ButtonCounts get threeMonths => $_getN(1);
  @$pb.TagNumber(2)
  set threeMonths(GraphsResponse_Buttons_ButtonCounts value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasThreeMonths() => $_has(1);
  @$pb.TagNumber(2)
  void clearThreeMonths() => $_clearField(2);
  @$pb.TagNumber(2)
  GraphsResponse_Buttons_ButtonCounts ensureThreeMonths() => $_ensure(1);

  @$pb.TagNumber(3)
  GraphsResponse_Buttons_ButtonCounts get oneYear => $_getN(2);
  @$pb.TagNumber(3)
  set oneYear(GraphsResponse_Buttons_ButtonCounts value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOneYear() => $_has(2);
  @$pb.TagNumber(3)
  void clearOneYear() => $_clearField(3);
  @$pb.TagNumber(3)
  GraphsResponse_Buttons_ButtonCounts ensureOneYear() => $_ensure(2);

  @$pb.TagNumber(4)
  GraphsResponse_Buttons_ButtonCounts get allTime => $_getN(3);
  @$pb.TagNumber(4)
  set allTime(GraphsResponse_Buttons_ButtonCounts value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAllTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearAllTime() => $_clearField(4);
  @$pb.TagNumber(4)
  GraphsResponse_Buttons_ButtonCounts ensureAllTime() => $_ensure(3);
}

class GraphsResponse_CardCounts_Counts extends $pb.GeneratedMessage {
  factory GraphsResponse_CardCounts_Counts({
    $core.int? newCards,
    $core.int? learn,
    $core.int? relearn,
    $core.int? young,
    $core.int? mature,
    $core.int? suspended,
    $core.int? buried,
  }) {
    final result = GraphsResponse_CardCounts_Counts._();
    if (newCards != null) result.newCards = newCards;
    if (learn != null) result.learn = learn;
    if (relearn != null) result.relearn = relearn;
    if (young != null) result.young = young;
    if (mature != null) result.mature = mature;
    if (suspended != null) result.suspended = suspended;
    if (buried != null) result.buried = buried;
    return result;
  }

  GraphsResponse_CardCounts_Counts._();

  factory GraphsResponse_CardCounts_Counts.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_CardCounts_Counts()..mergeFromBuffer(data, registry);
  factory GraphsResponse_CardCounts_Counts.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_CardCounts_Counts()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.CardCounts.Counts',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_CardCounts_Counts.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'newCards',
        protoName: 'newCards', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'learn', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'relearn', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'young', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'mature', fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'suspended', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'buried', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_CardCounts_Counts clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_CardCounts_Counts copyWith(
          void Function(GraphsResponse_CardCounts_Counts) updates) =>
      super.copyWith(
              (message) => updates(message as GraphsResponse_CardCounts_Counts))
          as GraphsResponse_CardCounts_Counts;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_CardCounts_Counts() / GraphsResponse_CardCounts_Counts.new instead')
  static GraphsResponse_CardCounts_Counts create() =>
      GraphsResponse_CardCounts_Counts._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_CardCounts_Counts._();
  @$core.override
  GraphsResponse_CardCounts_Counts createEmptyInstance() =>
      GraphsResponse_CardCounts_Counts._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_CardCounts_Counts getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_CardCounts_Counts>(
          GraphsResponse_CardCounts_Counts.$_createMessage);
  static GraphsResponse_CardCounts_Counts? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get newCards => $_getIZ(0);
  @$pb.TagNumber(1)
  set newCards($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNewCards() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewCards() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get learn => $_getIZ(1);
  @$pb.TagNumber(2)
  set learn($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLearn() => $_has(1);
  @$pb.TagNumber(2)
  void clearLearn() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get relearn => $_getIZ(2);
  @$pb.TagNumber(3)
  set relearn($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRelearn() => $_has(2);
  @$pb.TagNumber(3)
  void clearRelearn() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get young => $_getIZ(3);
  @$pb.TagNumber(4)
  set young($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasYoung() => $_has(3);
  @$pb.TagNumber(4)
  void clearYoung() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get mature => $_getIZ(4);
  @$pb.TagNumber(5)
  set mature($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMature() => $_has(4);
  @$pb.TagNumber(5)
  void clearMature() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get suspended => $_getIZ(5);
  @$pb.TagNumber(6)
  set suspended($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSuspended() => $_has(5);
  @$pb.TagNumber(6)
  void clearSuspended() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get buried => $_getIZ(6);
  @$pb.TagNumber(7)
  set buried($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBuried() => $_has(6);
  @$pb.TagNumber(7)
  void clearBuried() => $_clearField(7);
}

class GraphsResponse_CardCounts extends $pb.GeneratedMessage {
  factory GraphsResponse_CardCounts({
    GraphsResponse_CardCounts_Counts? includingInactive,
    GraphsResponse_CardCounts_Counts? excludingInactive,
  }) {
    final result = GraphsResponse_CardCounts._();
    if (includingInactive != null) result.includingInactive = includingInactive;
    if (excludingInactive != null) result.excludingInactive = excludingInactive;
    return result;
  }

  GraphsResponse_CardCounts._();

  factory GraphsResponse_CardCounts.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_CardCounts()..mergeFromBuffer(data, registry);
  factory GraphsResponse_CardCounts.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_CardCounts()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.CardCounts',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_CardCounts.$_createMessage)
    ..aOM<GraphsResponse_CardCounts_Counts>(
        1, _omitFieldNames ? '' : 'includingInactive',
        subBuilder: GraphsResponse_CardCounts_Counts.$_createMessage)
    ..aOM<GraphsResponse_CardCounts_Counts>(
        2, _omitFieldNames ? '' : 'excludingInactive',
        subBuilder: GraphsResponse_CardCounts_Counts.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_CardCounts clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_CardCounts copyWith(
          void Function(GraphsResponse_CardCounts) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse_CardCounts))
          as GraphsResponse_CardCounts;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_CardCounts() / GraphsResponse_CardCounts.new instead')
  static GraphsResponse_CardCounts create() => GraphsResponse_CardCounts._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_CardCounts._();
  @$core.override
  GraphsResponse_CardCounts createEmptyInstance() =>
      GraphsResponse_CardCounts._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_CardCounts getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_CardCounts>(
          GraphsResponse_CardCounts.$_createMessage);
  static GraphsResponse_CardCounts? _defaultInstance;

  /// Buried/suspended cards are included in counts; suspended/buried counts
  /// are 0.
  @$pb.TagNumber(1)
  GraphsResponse_CardCounts_Counts get includingInactive => $_getN(0);
  @$pb.TagNumber(1)
  set includingInactive(GraphsResponse_CardCounts_Counts value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIncludingInactive() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncludingInactive() => $_clearField(1);
  @$pb.TagNumber(1)
  GraphsResponse_CardCounts_Counts ensureIncludingInactive() => $_ensure(0);

  /// Buried/suspended cards are counted separately.
  @$pb.TagNumber(2)
  GraphsResponse_CardCounts_Counts get excludingInactive => $_getN(1);
  @$pb.TagNumber(2)
  set excludingInactive(GraphsResponse_CardCounts_Counts value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasExcludingInactive() => $_has(1);
  @$pb.TagNumber(2)
  void clearExcludingInactive() => $_clearField(2);
  @$pb.TagNumber(2)
  GraphsResponse_CardCounts_Counts ensureExcludingInactive() => $_ensure(1);
}

class GraphsResponse_TrueRetentionStats_TrueRetention
    extends $pb.GeneratedMessage {
  factory GraphsResponse_TrueRetentionStats_TrueRetention({
    $core.int? youngPassed,
    $core.int? youngFailed,
    $core.int? maturePassed,
    $core.int? matureFailed,
  }) {
    final result = GraphsResponse_TrueRetentionStats_TrueRetention._();
    if (youngPassed != null) result.youngPassed = youngPassed;
    if (youngFailed != null) result.youngFailed = youngFailed;
    if (maturePassed != null) result.maturePassed = maturePassed;
    if (matureFailed != null) result.matureFailed = matureFailed;
    return result;
  }

  GraphsResponse_TrueRetentionStats_TrueRetention._();

  factory GraphsResponse_TrueRetentionStats_TrueRetention.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_TrueRetentionStats_TrueRetention()
        ..mergeFromBuffer(data, registry);
  factory GraphsResponse_TrueRetentionStats_TrueRetention.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_TrueRetentionStats_TrueRetention()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GraphsResponse.TrueRetentionStats.TrueRetention',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance:
          GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'youngPassed',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'youngFailed',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'maturePassed',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'matureFailed',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_TrueRetentionStats_TrueRetention clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_TrueRetentionStats_TrueRetention copyWith(
          void Function(GraphsResponse_TrueRetentionStats_TrueRetention)
              updates) =>
      super.copyWith((message) => updates(
              message as GraphsResponse_TrueRetentionStats_TrueRetention))
          as GraphsResponse_TrueRetentionStats_TrueRetention;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_TrueRetentionStats_TrueRetention() / GraphsResponse_TrueRetentionStats_TrueRetention.new instead')
  static GraphsResponse_TrueRetentionStats_TrueRetention create() =>
      GraphsResponse_TrueRetentionStats_TrueRetention._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_TrueRetentionStats_TrueRetention._();
  @$core.override
  GraphsResponse_TrueRetentionStats_TrueRetention createEmptyInstance() =>
      GraphsResponse_TrueRetentionStats_TrueRetention._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_TrueRetentionStats_TrueRetention getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GraphsResponse_TrueRetentionStats_TrueRetention>(
          GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage);
  static GraphsResponse_TrueRetentionStats_TrueRetention? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get youngPassed => $_getIZ(0);
  @$pb.TagNumber(1)
  set youngPassed($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasYoungPassed() => $_has(0);
  @$pb.TagNumber(1)
  void clearYoungPassed() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get youngFailed => $_getIZ(1);
  @$pb.TagNumber(2)
  set youngFailed($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasYoungFailed() => $_has(1);
  @$pb.TagNumber(2)
  void clearYoungFailed() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get maturePassed => $_getIZ(2);
  @$pb.TagNumber(3)
  set maturePassed($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMaturePassed() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaturePassed() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get matureFailed => $_getIZ(3);
  @$pb.TagNumber(4)
  set matureFailed($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMatureFailed() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatureFailed() => $_clearField(4);
}

class GraphsResponse_TrueRetentionStats extends $pb.GeneratedMessage {
  factory GraphsResponse_TrueRetentionStats({
    GraphsResponse_TrueRetentionStats_TrueRetention? today,
    GraphsResponse_TrueRetentionStats_TrueRetention? yesterday,
    GraphsResponse_TrueRetentionStats_TrueRetention? week,
    GraphsResponse_TrueRetentionStats_TrueRetention? month,
    GraphsResponse_TrueRetentionStats_TrueRetention? year,
    GraphsResponse_TrueRetentionStats_TrueRetention? allTime,
  }) {
    final result = GraphsResponse_TrueRetentionStats._();
    if (today != null) result.today = today;
    if (yesterday != null) result.yesterday = yesterday;
    if (week != null) result.week = week;
    if (month != null) result.month = month;
    if (year != null) result.year = year;
    if (allTime != null) result.allTime = allTime;
    return result;
  }

  GraphsResponse_TrueRetentionStats._();

  factory GraphsResponse_TrueRetentionStats.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_TrueRetentionStats()..mergeFromBuffer(data, registry);
  factory GraphsResponse_TrueRetentionStats.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse_TrueRetentionStats()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse.TrueRetentionStats',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse_TrueRetentionStats.$_createMessage)
    ..aOM<GraphsResponse_TrueRetentionStats_TrueRetention>(
        1, _omitFieldNames ? '' : 'today',
        subBuilder:
            GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage)
    ..aOM<GraphsResponse_TrueRetentionStats_TrueRetention>(
        2, _omitFieldNames ? '' : 'yesterday',
        subBuilder:
            GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage)
    ..aOM<GraphsResponse_TrueRetentionStats_TrueRetention>(
        3, _omitFieldNames ? '' : 'week',
        subBuilder:
            GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage)
    ..aOM<GraphsResponse_TrueRetentionStats_TrueRetention>(
        4, _omitFieldNames ? '' : 'month',
        subBuilder:
            GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage)
    ..aOM<GraphsResponse_TrueRetentionStats_TrueRetention>(
        5, _omitFieldNames ? '' : 'year',
        subBuilder:
            GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage)
    ..aOM<GraphsResponse_TrueRetentionStats_TrueRetention>(
        6, _omitFieldNames ? '' : 'allTime',
        subBuilder:
            GraphsResponse_TrueRetentionStats_TrueRetention.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_TrueRetentionStats clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse_TrueRetentionStats copyWith(
          void Function(GraphsResponse_TrueRetentionStats) updates) =>
      super.copyWith((message) =>
              updates(message as GraphsResponse_TrueRetentionStats))
          as GraphsResponse_TrueRetentionStats;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GraphsResponse_TrueRetentionStats() / GraphsResponse_TrueRetentionStats.new instead')
  static GraphsResponse_TrueRetentionStats create() =>
      GraphsResponse_TrueRetentionStats._();
  static $pb.GeneratedMessage $_createMessage() =>
      GraphsResponse_TrueRetentionStats._();
  @$core.override
  GraphsResponse_TrueRetentionStats createEmptyInstance() =>
      GraphsResponse_TrueRetentionStats._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse_TrueRetentionStats getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GraphsResponse_TrueRetentionStats>(
          GraphsResponse_TrueRetentionStats.$_createMessage);
  static GraphsResponse_TrueRetentionStats? _defaultInstance;

  @$pb.TagNumber(1)
  GraphsResponse_TrueRetentionStats_TrueRetention get today => $_getN(0);
  @$pb.TagNumber(1)
  set today(GraphsResponse_TrueRetentionStats_TrueRetention value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasToday() => $_has(0);
  @$pb.TagNumber(1)
  void clearToday() => $_clearField(1);
  @$pb.TagNumber(1)
  GraphsResponse_TrueRetentionStats_TrueRetention ensureToday() => $_ensure(0);

  @$pb.TagNumber(2)
  GraphsResponse_TrueRetentionStats_TrueRetention get yesterday => $_getN(1);
  @$pb.TagNumber(2)
  set yesterday(GraphsResponse_TrueRetentionStats_TrueRetention value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasYesterday() => $_has(1);
  @$pb.TagNumber(2)
  void clearYesterday() => $_clearField(2);
  @$pb.TagNumber(2)
  GraphsResponse_TrueRetentionStats_TrueRetention ensureYesterday() =>
      $_ensure(1);

  @$pb.TagNumber(3)
  GraphsResponse_TrueRetentionStats_TrueRetention get week => $_getN(2);
  @$pb.TagNumber(3)
  set week(GraphsResponse_TrueRetentionStats_TrueRetention value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasWeek() => $_has(2);
  @$pb.TagNumber(3)
  void clearWeek() => $_clearField(3);
  @$pb.TagNumber(3)
  GraphsResponse_TrueRetentionStats_TrueRetention ensureWeek() => $_ensure(2);

  @$pb.TagNumber(4)
  GraphsResponse_TrueRetentionStats_TrueRetention get month => $_getN(3);
  @$pb.TagNumber(4)
  set month(GraphsResponse_TrueRetentionStats_TrueRetention value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearMonth() => $_clearField(4);
  @$pb.TagNumber(4)
  GraphsResponse_TrueRetentionStats_TrueRetention ensureMonth() => $_ensure(3);

  @$pb.TagNumber(5)
  GraphsResponse_TrueRetentionStats_TrueRetention get year => $_getN(4);
  @$pb.TagNumber(5)
  set year(GraphsResponse_TrueRetentionStats_TrueRetention value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasYear() => $_has(4);
  @$pb.TagNumber(5)
  void clearYear() => $_clearField(5);
  @$pb.TagNumber(5)
  GraphsResponse_TrueRetentionStats_TrueRetention ensureYear() => $_ensure(4);

  @$pb.TagNumber(6)
  GraphsResponse_TrueRetentionStats_TrueRetention get allTime => $_getN(5);
  @$pb.TagNumber(6)
  set allTime(GraphsResponse_TrueRetentionStats_TrueRetention value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasAllTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearAllTime() => $_clearField(6);
  @$pb.TagNumber(6)
  GraphsResponse_TrueRetentionStats_TrueRetention ensureAllTime() =>
      $_ensure(5);
}

class GraphsResponse extends $pb.GeneratedMessage {
  factory GraphsResponse({
    GraphsResponse_Buttons? buttons,
    GraphsResponse_CardCounts? cardCounts,
    GraphsResponse_Hours? hours,
    GraphsResponse_Today? today,
    GraphsResponse_Eases? eases,
    GraphsResponse_Intervals? intervals,
    GraphsResponse_FutureDue? futureDue,
    GraphsResponse_Added? added,
    GraphsResponse_ReviewCountsAndTimes? reviews,
    $core.int? rolloverHour,
    GraphsResponse_Eases? difficulty,
    GraphsResponse_Retrievability? retrievability,
    $core.bool? fsrs,
    GraphsResponse_Intervals? stability,
    GraphsResponse_TrueRetentionStats? trueRetention,
  }) {
    final result = GraphsResponse._();
    if (buttons != null) result.buttons = buttons;
    if (cardCounts != null) result.cardCounts = cardCounts;
    if (hours != null) result.hours = hours;
    if (today != null) result.today = today;
    if (eases != null) result.eases = eases;
    if (intervals != null) result.intervals = intervals;
    if (futureDue != null) result.futureDue = futureDue;
    if (added != null) result.added = added;
    if (reviews != null) result.reviews = reviews;
    if (rolloverHour != null) result.rolloverHour = rolloverHour;
    if (difficulty != null) result.difficulty = difficulty;
    if (retrievability != null) result.retrievability = retrievability;
    if (fsrs != null) result.fsrs = fsrs;
    if (stability != null) result.stability = stability;
    if (trueRetention != null) result.trueRetention = trueRetention;
    return result;
  }

  GraphsResponse._();

  factory GraphsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse()..mergeFromBuffer(data, registry);
  factory GraphsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphsResponse.$_createMessage)
    ..aOM<GraphsResponse_Buttons>(1, _omitFieldNames ? '' : 'buttons',
        subBuilder: GraphsResponse_Buttons.$_createMessage)
    ..aOM<GraphsResponse_CardCounts>(2, _omitFieldNames ? '' : 'cardCounts',
        subBuilder: GraphsResponse_CardCounts.$_createMessage)
    ..aOM<GraphsResponse_Hours>(3, _omitFieldNames ? '' : 'hours',
        subBuilder: GraphsResponse_Hours.$_createMessage)
    ..aOM<GraphsResponse_Today>(4, _omitFieldNames ? '' : 'today',
        subBuilder: GraphsResponse_Today.$_createMessage)
    ..aOM<GraphsResponse_Eases>(5, _omitFieldNames ? '' : 'eases',
        subBuilder: GraphsResponse_Eases.$_createMessage)
    ..aOM<GraphsResponse_Intervals>(6, _omitFieldNames ? '' : 'intervals',
        subBuilder: GraphsResponse_Intervals.$_createMessage)
    ..aOM<GraphsResponse_FutureDue>(7, _omitFieldNames ? '' : 'futureDue',
        subBuilder: GraphsResponse_FutureDue.$_createMessage)
    ..aOM<GraphsResponse_Added>(8, _omitFieldNames ? '' : 'added',
        subBuilder: GraphsResponse_Added.$_createMessage)
    ..aOM<GraphsResponse_ReviewCountsAndTimes>(
        9, _omitFieldNames ? '' : 'reviews',
        subBuilder: GraphsResponse_ReviewCountsAndTimes.$_createMessage)
    ..aI(10, _omitFieldNames ? '' : 'rolloverHour',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<GraphsResponse_Eases>(11, _omitFieldNames ? '' : 'difficulty',
        subBuilder: GraphsResponse_Eases.$_createMessage)
    ..aOM<GraphsResponse_Retrievability>(
        12, _omitFieldNames ? '' : 'retrievability',
        subBuilder: GraphsResponse_Retrievability.$_createMessage)
    ..aOB(13, _omitFieldNames ? '' : 'fsrs')
    ..aOM<GraphsResponse_Intervals>(14, _omitFieldNames ? '' : 'stability',
        subBuilder: GraphsResponse_Intervals.$_createMessage)
    ..aOM<GraphsResponse_TrueRetentionStats>(
        15, _omitFieldNames ? '' : 'trueRetention',
        subBuilder: GraphsResponse_TrueRetentionStats.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphsResponse copyWith(void Function(GraphsResponse) updates) =>
      super.copyWith((message) => updates(message as GraphsResponse))
          as GraphsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GraphsResponse() / GraphsResponse.new instead')
  static GraphsResponse create() => GraphsResponse._();
  static $pb.GeneratedMessage $_createMessage() => GraphsResponse._();
  @$core.override
  GraphsResponse createEmptyInstance() => GraphsResponse._();
  @$core.pragma('dart2js:noInline')
  static GraphsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphsResponse>(
          GraphsResponse.$_createMessage);
  static GraphsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GraphsResponse_Buttons get buttons => $_getN(0);
  @$pb.TagNumber(1)
  set buttons(GraphsResponse_Buttons value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasButtons() => $_has(0);
  @$pb.TagNumber(1)
  void clearButtons() => $_clearField(1);
  @$pb.TagNumber(1)
  GraphsResponse_Buttons ensureButtons() => $_ensure(0);

  @$pb.TagNumber(2)
  GraphsResponse_CardCounts get cardCounts => $_getN(1);
  @$pb.TagNumber(2)
  set cardCounts(GraphsResponse_CardCounts value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCardCounts() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardCounts() => $_clearField(2);
  @$pb.TagNumber(2)
  GraphsResponse_CardCounts ensureCardCounts() => $_ensure(1);

  @$pb.TagNumber(3)
  GraphsResponse_Hours get hours => $_getN(2);
  @$pb.TagNumber(3)
  set hours(GraphsResponse_Hours value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasHours() => $_has(2);
  @$pb.TagNumber(3)
  void clearHours() => $_clearField(3);
  @$pb.TagNumber(3)
  GraphsResponse_Hours ensureHours() => $_ensure(2);

  @$pb.TagNumber(4)
  GraphsResponse_Today get today => $_getN(3);
  @$pb.TagNumber(4)
  set today(GraphsResponse_Today value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasToday() => $_has(3);
  @$pb.TagNumber(4)
  void clearToday() => $_clearField(4);
  @$pb.TagNumber(4)
  GraphsResponse_Today ensureToday() => $_ensure(3);

  @$pb.TagNumber(5)
  GraphsResponse_Eases get eases => $_getN(4);
  @$pb.TagNumber(5)
  set eases(GraphsResponse_Eases value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasEases() => $_has(4);
  @$pb.TagNumber(5)
  void clearEases() => $_clearField(5);
  @$pb.TagNumber(5)
  GraphsResponse_Eases ensureEases() => $_ensure(4);

  @$pb.TagNumber(6)
  GraphsResponse_Intervals get intervals => $_getN(5);
  @$pb.TagNumber(6)
  set intervals(GraphsResponse_Intervals value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasIntervals() => $_has(5);
  @$pb.TagNumber(6)
  void clearIntervals() => $_clearField(6);
  @$pb.TagNumber(6)
  GraphsResponse_Intervals ensureIntervals() => $_ensure(5);

  @$pb.TagNumber(7)
  GraphsResponse_FutureDue get futureDue => $_getN(6);
  @$pb.TagNumber(7)
  set futureDue(GraphsResponse_FutureDue value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasFutureDue() => $_has(6);
  @$pb.TagNumber(7)
  void clearFutureDue() => $_clearField(7);
  @$pb.TagNumber(7)
  GraphsResponse_FutureDue ensureFutureDue() => $_ensure(6);

  @$pb.TagNumber(8)
  GraphsResponse_Added get added => $_getN(7);
  @$pb.TagNumber(8)
  set added(GraphsResponse_Added value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasAdded() => $_has(7);
  @$pb.TagNumber(8)
  void clearAdded() => $_clearField(8);
  @$pb.TagNumber(8)
  GraphsResponse_Added ensureAdded() => $_ensure(7);

  @$pb.TagNumber(9)
  GraphsResponse_ReviewCountsAndTimes get reviews => $_getN(8);
  @$pb.TagNumber(9)
  set reviews(GraphsResponse_ReviewCountsAndTimes value) =>
      $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasReviews() => $_has(8);
  @$pb.TagNumber(9)
  void clearReviews() => $_clearField(9);
  @$pb.TagNumber(9)
  GraphsResponse_ReviewCountsAndTimes ensureReviews() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.int get rolloverHour => $_getIZ(9);
  @$pb.TagNumber(10)
  set rolloverHour($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRolloverHour() => $_has(9);
  @$pb.TagNumber(10)
  void clearRolloverHour() => $_clearField(10);

  @$pb.TagNumber(11)
  GraphsResponse_Eases get difficulty => $_getN(10);
  @$pb.TagNumber(11)
  set difficulty(GraphsResponse_Eases value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasDifficulty() => $_has(10);
  @$pb.TagNumber(11)
  void clearDifficulty() => $_clearField(11);
  @$pb.TagNumber(11)
  GraphsResponse_Eases ensureDifficulty() => $_ensure(10);

  @$pb.TagNumber(12)
  GraphsResponse_Retrievability get retrievability => $_getN(11);
  @$pb.TagNumber(12)
  set retrievability(GraphsResponse_Retrievability value) =>
      $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasRetrievability() => $_has(11);
  @$pb.TagNumber(12)
  void clearRetrievability() => $_clearField(12);
  @$pb.TagNumber(12)
  GraphsResponse_Retrievability ensureRetrievability() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.bool get fsrs => $_getBF(12);
  @$pb.TagNumber(13)
  set fsrs($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFsrs() => $_has(12);
  @$pb.TagNumber(13)
  void clearFsrs() => $_clearField(13);

  @$pb.TagNumber(14)
  GraphsResponse_Intervals get stability => $_getN(13);
  @$pb.TagNumber(14)
  set stability(GraphsResponse_Intervals value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasStability() => $_has(13);
  @$pb.TagNumber(14)
  void clearStability() => $_clearField(14);
  @$pb.TagNumber(14)
  GraphsResponse_Intervals ensureStability() => $_ensure(13);

  @$pb.TagNumber(15)
  GraphsResponse_TrueRetentionStats get trueRetention => $_getN(14);
  @$pb.TagNumber(15)
  set trueRetention(GraphsResponse_TrueRetentionStats value) =>
      $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasTrueRetention() => $_has(14);
  @$pb.TagNumber(15)
  void clearTrueRetention() => $_clearField(15);
  @$pb.TagNumber(15)
  GraphsResponse_TrueRetentionStats ensureTrueRetention() => $_ensure(14);
}

class GraphPreferences extends $pb.GeneratedMessage {
  factory GraphPreferences({
    GraphPreferences_Weekday? calendarFirstDayOfWeek,
    $core.bool? cardCountsSeparateInactive,
    $core.bool? browserLinksSupported,
    $core.bool? futureDueShowBacklog,
  }) {
    final result = GraphPreferences._();
    if (calendarFirstDayOfWeek != null)
      result.calendarFirstDayOfWeek = calendarFirstDayOfWeek;
    if (cardCountsSeparateInactive != null)
      result.cardCountsSeparateInactive = cardCountsSeparateInactive;
    if (browserLinksSupported != null)
      result.browserLinksSupported = browserLinksSupported;
    if (futureDueShowBacklog != null)
      result.futureDueShowBacklog = futureDueShowBacklog;
    return result;
  }

  GraphPreferences._();

  factory GraphPreferences.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphPreferences()..mergeFromBuffer(data, registry);
  factory GraphPreferences.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GraphPreferences()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GraphPreferences',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: GraphPreferences.$_createMessage)
    ..aE<GraphPreferences_Weekday>(
        1, _omitFieldNames ? '' : 'calendarFirstDayOfWeek',
        enumValues: GraphPreferences_Weekday.values)
    ..aOB(2, _omitFieldNames ? '' : 'cardCountsSeparateInactive')
    ..aOB(3, _omitFieldNames ? '' : 'browserLinksSupported')
    ..aOB(4, _omitFieldNames ? '' : 'futureDueShowBacklog')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphPreferences clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GraphPreferences copyWith(void Function(GraphPreferences) updates) =>
      super.copyWith((message) => updates(message as GraphPreferences))
          as GraphPreferences;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GraphPreferences() / GraphPreferences.new instead')
  static GraphPreferences create() => GraphPreferences._();
  static $pb.GeneratedMessage $_createMessage() => GraphPreferences._();
  @$core.override
  GraphPreferences createEmptyInstance() => GraphPreferences._();
  @$core.pragma('dart2js:noInline')
  static GraphPreferences getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphPreferences>(
          GraphPreferences.$_createMessage);
  static GraphPreferences? _defaultInstance;

  @$pb.TagNumber(1)
  GraphPreferences_Weekday get calendarFirstDayOfWeek => $_getN(0);
  @$pb.TagNumber(1)
  set calendarFirstDayOfWeek(GraphPreferences_Weekday value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCalendarFirstDayOfWeek() => $_has(0);
  @$pb.TagNumber(1)
  void clearCalendarFirstDayOfWeek() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get cardCountsSeparateInactive => $_getBF(1);
  @$pb.TagNumber(2)
  set cardCountsSeparateInactive($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardCountsSeparateInactive() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardCountsSeparateInactive() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get browserLinksSupported => $_getBF(2);
  @$pb.TagNumber(3)
  set browserLinksSupported($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBrowserLinksSupported() => $_has(2);
  @$pb.TagNumber(3)
  void clearBrowserLinksSupported() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get futureDueShowBacklog => $_getBF(3);
  @$pb.TagNumber(4)
  set futureDueShowBacklog($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFutureDueShowBacklog() => $_has(3);
  @$pb.TagNumber(4)
  void clearFutureDueShowBacklog() => $_clearField(4);
}

class RevlogEntry extends $pb.GeneratedMessage {
  factory RevlogEntry({
    $fixnum.Int64? id,
    $fixnum.Int64? cid,
    $core.int? usn,
    $core.int? buttonChosen,
    $core.int? interval,
    $core.int? lastInterval,
    $core.int? easeFactor,
    $core.int? takenMillis,
    RevlogEntry_ReviewKind? reviewKind,
  }) {
    final result = RevlogEntry._();
    if (id != null) result.id = id;
    if (cid != null) result.cid = cid;
    if (usn != null) result.usn = usn;
    if (buttonChosen != null) result.buttonChosen = buttonChosen;
    if (interval != null) result.interval = interval;
    if (lastInterval != null) result.lastInterval = lastInterval;
    if (easeFactor != null) result.easeFactor = easeFactor;
    if (takenMillis != null) result.takenMillis = takenMillis;
    if (reviewKind != null) result.reviewKind = reviewKind;
    return result;
  }

  RevlogEntry._();

  factory RevlogEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevlogEntry()..mergeFromBuffer(data, registry);
  factory RevlogEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevlogEntry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevlogEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: RevlogEntry.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'cid')
    ..aI(3, _omitFieldNames ? '' : 'usn')
    ..aI(4, _omitFieldNames ? '' : 'buttonChosen',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'interval')
    ..aI(6, _omitFieldNames ? '' : 'lastInterval')
    ..aI(7, _omitFieldNames ? '' : 'easeFactor', fieldType: $pb.PbFieldType.OU3)
    ..aI(8, _omitFieldNames ? '' : 'takenMillis',
        fieldType: $pb.PbFieldType.OU3)
    ..aE<RevlogEntry_ReviewKind>(9, _omitFieldNames ? '' : 'reviewKind',
        enumValues: RevlogEntry_ReviewKind.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevlogEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevlogEntry copyWith(void Function(RevlogEntry) updates) =>
      super.copyWith((message) => updates(message as RevlogEntry))
          as RevlogEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RevlogEntry() / RevlogEntry.new instead')
  static RevlogEntry create() => RevlogEntry._();
  static $pb.GeneratedMessage $_createMessage() => RevlogEntry._();
  @$core.override
  RevlogEntry createEmptyInstance() => RevlogEntry._();
  @$core.pragma('dart2js:noInline')
  static RevlogEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RevlogEntry>(
          RevlogEntry.$_createMessage);
  static RevlogEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cid => $_getI64(1);
  @$pb.TagNumber(2)
  set cid($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCid() => $_has(1);
  @$pb.TagNumber(2)
  void clearCid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get usn => $_getIZ(2);
  @$pb.TagNumber(3)
  set usn($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUsn() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsn() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get buttonChosen => $_getIZ(3);
  @$pb.TagNumber(4)
  set buttonChosen($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasButtonChosen() => $_has(3);
  @$pb.TagNumber(4)
  void clearButtonChosen() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get interval => $_getIZ(4);
  @$pb.TagNumber(5)
  set interval($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInterval() => $_has(4);
  @$pb.TagNumber(5)
  void clearInterval() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get lastInterval => $_getIZ(5);
  @$pb.TagNumber(6)
  set lastInterval($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastInterval() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastInterval() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get easeFactor => $_getIZ(6);
  @$pb.TagNumber(7)
  set easeFactor($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEaseFactor() => $_has(6);
  @$pb.TagNumber(7)
  void clearEaseFactor() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get takenMillis => $_getIZ(7);
  @$pb.TagNumber(8)
  set takenMillis($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTakenMillis() => $_has(7);
  @$pb.TagNumber(8)
  void clearTakenMillis() => $_clearField(8);

  @$pb.TagNumber(9)
  RevlogEntry_ReviewKind get reviewKind => $_getN(8);
  @$pb.TagNumber(9)
  set reviewKind(RevlogEntry_ReviewKind value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasReviewKind() => $_has(8);
  @$pb.TagNumber(9)
  void clearReviewKind() => $_clearField(9);
}

class CardEntry extends $pb.GeneratedMessage {
  factory CardEntry({
    $fixnum.Int64? id,
    $fixnum.Int64? noteId,
    $fixnum.Int64? deckId,
  }) {
    final result = CardEntry._();
    if (id != null) result.id = id;
    if (noteId != null) result.noteId = noteId;
    if (deckId != null) result.deckId = deckId;
    return result;
  }

  CardEntry._();

  factory CardEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardEntry()..mergeFromBuffer(data, registry);
  factory CardEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardEntry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: CardEntry.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'noteId')
    ..aInt64(3, _omitFieldNames ? '' : 'deckId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardEntry copyWith(void Function(CardEntry) updates) =>
      super.copyWith((message) => updates(message as CardEntry)) as CardEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CardEntry() / CardEntry.new instead')
  static CardEntry create() => CardEntry._();
  static $pb.GeneratedMessage $_createMessage() => CardEntry._();
  @$core.override
  CardEntry createEmptyInstance() => CardEntry._();
  @$core.pragma('dart2js:noInline')
  static CardEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CardEntry>(CardEntry.$_createMessage);
  static CardEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get noteId => $_getI64(1);
  @$pb.TagNumber(2)
  set noteId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNoteId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoteId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get deckId => $_getI64(2);
  @$pb.TagNumber(3)
  set deckId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeckId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeckId() => $_clearField(3);
}

class DeckEntry extends $pb.GeneratedMessage {
  factory DeckEntry({
    $fixnum.Int64? id,
    $fixnum.Int64? parentId,
    $fixnum.Int64? presetId,
  }) {
    final result = DeckEntry._();
    if (id != null) result.id = id;
    if (parentId != null) result.parentId = parentId;
    if (presetId != null) result.presetId = presetId;
    return result;
  }

  DeckEntry._();

  factory DeckEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckEntry()..mergeFromBuffer(data, registry);
  factory DeckEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckEntry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: DeckEntry.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'parentId')
    ..aInt64(3, _omitFieldNames ? '' : 'presetId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckEntry copyWith(void Function(DeckEntry) updates) =>
      super.copyWith((message) => updates(message as DeckEntry)) as DeckEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckEntry() / DeckEntry.new instead')
  static DeckEntry create() => DeckEntry._();
  static $pb.GeneratedMessage $_createMessage() => DeckEntry._();
  @$core.override
  DeckEntry createEmptyInstance() => DeckEntry._();
  @$core.pragma('dart2js:noInline')
  static DeckEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckEntry>(DeckEntry.$_createMessage);
  static DeckEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get parentId => $_getI64(1);
  @$pb.TagNumber(2)
  set parentId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasParentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get presetId => $_getI64(2);
  @$pb.TagNumber(3)
  set presetId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPresetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPresetId() => $_clearField(3);
}

class Dataset extends $pb.GeneratedMessage {
  factory Dataset({
    $core.Iterable<RevlogEntry>? revlogs,
    $core.Iterable<CardEntry>? cards,
    $core.Iterable<DeckEntry>? decks,
    $fixnum.Int64? nextDayAt,
  }) {
    final result = Dataset._();
    if (revlogs != null) result.revlogs.addAll(revlogs);
    if (cards != null) result.cards.addAll(cards);
    if (decks != null) result.decks.addAll(decks);
    if (nextDayAt != null) result.nextDayAt = nextDayAt;
    return result;
  }

  Dataset._();

  factory Dataset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Dataset()..mergeFromBuffer(data, registry);
  factory Dataset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Dataset()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Dataset',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.stats'),
      createEmptyInstance: Dataset.$_createMessage)
    ..pPM<RevlogEntry>(1, _omitFieldNames ? '' : 'revlogs',
        subBuilder: RevlogEntry.$_createMessage)
    ..pPM<CardEntry>(2, _omitFieldNames ? '' : 'cards',
        subBuilder: CardEntry.$_createMessage)
    ..pPM<DeckEntry>(3, _omitFieldNames ? '' : 'decks',
        subBuilder: DeckEntry.$_createMessage)
    ..aInt64(4, _omitFieldNames ? '' : 'nextDayAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dataset clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dataset copyWith(void Function(Dataset) updates) =>
      super.copyWith((message) => updates(message as Dataset)) as Dataset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Dataset() / Dataset.new instead')
  static Dataset create() => Dataset._();
  static $pb.GeneratedMessage $_createMessage() => Dataset._();
  @$core.override
  Dataset createEmptyInstance() => Dataset._();
  @$core.pragma('dart2js:noInline')
  static Dataset getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Dataset>(Dataset.$_createMessage);
  static Dataset? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RevlogEntry> get revlogs => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<CardEntry> get cards => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<DeckEntry> get decks => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get nextDayAt => $_getI64(3);
  @$pb.TagNumber(4)
  set nextDayAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNextDayAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextDayAt() => $_clearField(4);
}

class StatsServiceApi {
  final $pb.RpcClient _client;

  StatsServiceApi(this._client);

  $async.Future<CardStatsResponse> cardStats(
          $pb.ClientContext? ctx, $0.CardId request) =>
      _client.invoke<CardStatsResponse>(
          ctx, 'StatsService', 'CardStats', request, CardStatsResponse());
  $async.Future<ReviewLogs> getReviewLogs(
          $pb.ClientContext? ctx, $0.CardId request) =>
      _client.invoke<ReviewLogs>(
          ctx, 'StatsService', 'GetReviewLogs', request, ReviewLogs());
  $async.Future<GraphsResponse> graphs(
          $pb.ClientContext? ctx, GraphsRequest request) =>
      _client.invoke<GraphsResponse>(
          ctx, 'StatsService', 'Graphs', request, GraphsResponse());
  $async.Future<GraphPreferences> getGraphPreferences(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<GraphPreferences>(ctx, 'StatsService',
          'GetGraphPreferences', request, GraphPreferences());
  $async.Future<$1.Empty> setGraphPreferences(
          $pb.ClientContext? ctx, GraphPreferences request) =>
      _client.invoke<$1.Empty>(
          ctx, 'StatsService', 'SetGraphPreferences', request, $1.Empty());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendStatsServiceApi {
  final $pb.RpcClient _client;

  BackendStatsServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
