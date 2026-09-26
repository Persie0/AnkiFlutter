// This is a generated file - do not edit.
//
// Generated from anki/deck_config.proto.

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

import 'collection.pb.dart' as $2;
import 'deck_config.pbenum.dart';
import 'decks.pb.dart' as $1;
import 'generic.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'deck_config.pbenum.dart';

class DeckConfigId extends $pb.GeneratedMessage {
  factory DeckConfigId({
    $fixnum.Int64? dcid,
  }) {
    final result = DeckConfigId._();
    if (dcid != null) result.dcid = dcid;
    return result;
  }

  DeckConfigId._();

  factory DeckConfigId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigId()..mergeFromBuffer(data, registry);
  factory DeckConfigId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckConfigId',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: DeckConfigId.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'dcid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigId copyWith(void Function(DeckConfigId) updates) =>
      super.copyWith((message) => updates(message as DeckConfigId))
          as DeckConfigId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckConfigId() / DeckConfigId.new instead')
  static DeckConfigId create() => DeckConfigId._();
  static $pb.GeneratedMessage $_createMessage() => DeckConfigId._();
  @$core.override
  DeckConfigId createEmptyInstance() => DeckConfigId._();
  @$core.pragma('dart2js:noInline')
  static DeckConfigId getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeckConfigId>(
          DeckConfigId.$_createMessage);
  static DeckConfigId? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get dcid => $_getI64(0);
  @$pb.TagNumber(1)
  set dcid($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDcid() => $_has(0);
  @$pb.TagNumber(1)
  void clearDcid() => $_clearField(1);
}

class GetRetentionWorkloadRequest extends $pb.GeneratedMessage {
  factory GetRetentionWorkloadRequest({
    $core.Iterable<$core.double>? w,
    $core.String? search,
  }) {
    final result = GetRetentionWorkloadRequest._();
    if (w != null) result.w.addAll(w);
    if (search != null) result.search = search;
    return result;
  }

  GetRetentionWorkloadRequest._();

  factory GetRetentionWorkloadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetRetentionWorkloadRequest()..mergeFromBuffer(data, registry);
  factory GetRetentionWorkloadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetRetentionWorkloadRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRetentionWorkloadRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: GetRetentionWorkloadRequest.$_createMessage)
    ..p<$core.double>(1, _omitFieldNames ? '' : 'w', $pb.PbFieldType.KF)
    ..aOS(2, _omitFieldNames ? '' : 'search')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRetentionWorkloadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRetentionWorkloadRequest copyWith(
          void Function(GetRetentionWorkloadRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetRetentionWorkloadRequest))
          as GetRetentionWorkloadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetRetentionWorkloadRequest() / GetRetentionWorkloadRequest.new instead')
  static GetRetentionWorkloadRequest create() =>
      GetRetentionWorkloadRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetRetentionWorkloadRequest._();
  @$core.override
  GetRetentionWorkloadRequest createEmptyInstance() =>
      GetRetentionWorkloadRequest._();
  @$core.pragma('dart2js:noInline')
  static GetRetentionWorkloadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRetentionWorkloadRequest>(
          GetRetentionWorkloadRequest.$_createMessage);
  static GetRetentionWorkloadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.double> get w => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get search => $_getSZ(1);
  @$pb.TagNumber(2)
  set search($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSearch() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearch() => $_clearField(2);
}

class GetRetentionWorkloadResponse extends $pb.GeneratedMessage {
  factory GetRetentionWorkloadResponse({
    $core.Iterable<$core.MapEntry<$core.int, $core.double>>? costs,
  }) {
    final result = GetRetentionWorkloadResponse._();
    if (costs != null) result.costs.addEntries(costs);
    return result;
  }

  GetRetentionWorkloadResponse._();

  factory GetRetentionWorkloadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetRetentionWorkloadResponse()..mergeFromBuffer(data, registry);
  factory GetRetentionWorkloadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetRetentionWorkloadResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRetentionWorkloadResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: GetRetentionWorkloadResponse.$_createMessage)
    ..m<$core.int, $core.double>(1, _omitFieldNames ? '' : 'costs',
        entryClassName: 'GetRetentionWorkloadResponse.CostsEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('anki.deck_config'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRetentionWorkloadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRetentionWorkloadResponse copyWith(
          void Function(GetRetentionWorkloadResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetRetentionWorkloadResponse))
          as GetRetentionWorkloadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetRetentionWorkloadResponse() / GetRetentionWorkloadResponse.new instead')
  static GetRetentionWorkloadResponse create() =>
      GetRetentionWorkloadResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetRetentionWorkloadResponse._();
  @$core.override
  GetRetentionWorkloadResponse createEmptyInstance() =>
      GetRetentionWorkloadResponse._();
  @$core.pragma('dart2js:noInline')
  static GetRetentionWorkloadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRetentionWorkloadResponse>(
          GetRetentionWorkloadResponse.$_createMessage);
  static GetRetentionWorkloadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $core.double> get costs => $_getMap(0);
}

class GetIgnoredBeforeCountRequest extends $pb.GeneratedMessage {
  factory GetIgnoredBeforeCountRequest({
    $core.String? ignoreRevlogsBeforeDate,
    $core.String? search,
  }) {
    final result = GetIgnoredBeforeCountRequest._();
    if (ignoreRevlogsBeforeDate != null)
      result.ignoreRevlogsBeforeDate = ignoreRevlogsBeforeDate;
    if (search != null) result.search = search;
    return result;
  }

  GetIgnoredBeforeCountRequest._();

  factory GetIgnoredBeforeCountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetIgnoredBeforeCountRequest()..mergeFromBuffer(data, registry);
  factory GetIgnoredBeforeCountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetIgnoredBeforeCountRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIgnoredBeforeCountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: GetIgnoredBeforeCountRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'ignoreRevlogsBeforeDate')
    ..aOS(2, _omitFieldNames ? '' : 'search')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIgnoredBeforeCountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIgnoredBeforeCountRequest copyWith(
          void Function(GetIgnoredBeforeCountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetIgnoredBeforeCountRequest))
          as GetIgnoredBeforeCountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetIgnoredBeforeCountRequest() / GetIgnoredBeforeCountRequest.new instead')
  static GetIgnoredBeforeCountRequest create() =>
      GetIgnoredBeforeCountRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetIgnoredBeforeCountRequest._();
  @$core.override
  GetIgnoredBeforeCountRequest createEmptyInstance() =>
      GetIgnoredBeforeCountRequest._();
  @$core.pragma('dart2js:noInline')
  static GetIgnoredBeforeCountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIgnoredBeforeCountRequest>(
          GetIgnoredBeforeCountRequest.$_createMessage);
  static GetIgnoredBeforeCountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ignoreRevlogsBeforeDate => $_getSZ(0);
  @$pb.TagNumber(1)
  set ignoreRevlogsBeforeDate($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIgnoreRevlogsBeforeDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearIgnoreRevlogsBeforeDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get search => $_getSZ(1);
  @$pb.TagNumber(2)
  set search($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSearch() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearch() => $_clearField(2);
}

class GetIgnoredBeforeCountResponse extends $pb.GeneratedMessage {
  factory GetIgnoredBeforeCountResponse({
    $fixnum.Int64? included,
    $fixnum.Int64? total,
  }) {
    final result = GetIgnoredBeforeCountResponse._();
    if (included != null) result.included = included;
    if (total != null) result.total = total;
    return result;
  }

  GetIgnoredBeforeCountResponse._();

  factory GetIgnoredBeforeCountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetIgnoredBeforeCountResponse()..mergeFromBuffer(data, registry);
  factory GetIgnoredBeforeCountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetIgnoredBeforeCountResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIgnoredBeforeCountResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: GetIgnoredBeforeCountResponse.$_createMessage)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'included', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIgnoredBeforeCountResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIgnoredBeforeCountResponse copyWith(
          void Function(GetIgnoredBeforeCountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetIgnoredBeforeCountResponse))
          as GetIgnoredBeforeCountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetIgnoredBeforeCountResponse() / GetIgnoredBeforeCountResponse.new instead')
  static GetIgnoredBeforeCountResponse create() =>
      GetIgnoredBeforeCountResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetIgnoredBeforeCountResponse._();
  @$core.override
  GetIgnoredBeforeCountResponse createEmptyInstance() =>
      GetIgnoredBeforeCountResponse._();
  @$core.pragma('dart2js:noInline')
  static GetIgnoredBeforeCountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIgnoredBeforeCountResponse>(
          GetIgnoredBeforeCountResponse.$_createMessage);
  static GetIgnoredBeforeCountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get included => $_getI64(0);
  @$pb.TagNumber(1)
  set included($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIncluded() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncluded() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class DeckConfig_Config extends $pb.GeneratedMessage {
  factory DeckConfig_Config({
    $core.Iterable<$core.double>? learnSteps,
    $core.Iterable<$core.double>? relearnSteps,
    $core.Iterable<$core.double>? fsrsParams4,
    $core.Iterable<$core.double>? easyDaysPercentages,
    $core.Iterable<$core.double>? fsrsParams5,
    $core.Iterable<$core.double>? fsrsParams6,
    $core.int? newPerDay,
    $core.int? reviewsPerDay,
    $core.double? initialEase,
    $core.double? easyMultiplier,
    $core.double? hardMultiplier,
    $core.double? lapseMultiplier,
    $core.double? intervalMultiplier,
    $core.int? maximumReviewInterval,
    $core.int? minimumLapseInterval,
    $core.int? graduatingIntervalGood,
    $core.int? graduatingIntervalEasy,
    DeckConfig_Config_NewCardInsertOrder? newCardInsertOrder,
    DeckConfig_Config_LeechAction? leechAction,
    $core.int? leechThreshold,
    $core.bool? disableAutoplay,
    $core.int? capAnswerTimeToSecs,
    $core.bool? showTimer,
    $core.bool? skipQuestionWhenReplayingAnswer,
    $core.bool? buryNew,
    $core.bool? buryReviews,
    $core.bool? buryInterdayLearning,
    DeckConfig_Config_ReviewMix? newMix,
    DeckConfig_Config_ReviewMix? interdayLearningMix,
    DeckConfig_Config_NewCardSortOrder? newCardSortOrder,
    DeckConfig_Config_ReviewCardOrder? reviewOrder,
    DeckConfig_Config_NewCardGatherPriority? newCardGatherPriority,
    $core.int? newPerDayMinimum,
    DeckConfig_Config_QuestionAction? questionAction,
    $core.double? desiredRetention,
    $core.bool? stopTimerOnAnswer,
    $core.double? historicalRetention,
    $core.double? secondsToShowQuestion,
    $core.double? secondsToShowAnswer,
    DeckConfig_Config_AnswerAction? answerAction,
    $core.bool? waitForAudio,
    $core.String? paramSearch,
    $core.String? ignoreRevlogsBeforeDate,
    $core.List<$core.int>? other,
  }) {
    final result = DeckConfig_Config._();
    if (learnSteps != null) result.learnSteps.addAll(learnSteps);
    if (relearnSteps != null) result.relearnSteps.addAll(relearnSteps);
    if (fsrsParams4 != null) result.fsrsParams4.addAll(fsrsParams4);
    if (easyDaysPercentages != null)
      result.easyDaysPercentages.addAll(easyDaysPercentages);
    if (fsrsParams5 != null) result.fsrsParams5.addAll(fsrsParams5);
    if (fsrsParams6 != null) result.fsrsParams6.addAll(fsrsParams6);
    if (newPerDay != null) result.newPerDay = newPerDay;
    if (reviewsPerDay != null) result.reviewsPerDay = reviewsPerDay;
    if (initialEase != null) result.initialEase = initialEase;
    if (easyMultiplier != null) result.easyMultiplier = easyMultiplier;
    if (hardMultiplier != null) result.hardMultiplier = hardMultiplier;
    if (lapseMultiplier != null) result.lapseMultiplier = lapseMultiplier;
    if (intervalMultiplier != null)
      result.intervalMultiplier = intervalMultiplier;
    if (maximumReviewInterval != null)
      result.maximumReviewInterval = maximumReviewInterval;
    if (minimumLapseInterval != null)
      result.minimumLapseInterval = minimumLapseInterval;
    if (graduatingIntervalGood != null)
      result.graduatingIntervalGood = graduatingIntervalGood;
    if (graduatingIntervalEasy != null)
      result.graduatingIntervalEasy = graduatingIntervalEasy;
    if (newCardInsertOrder != null)
      result.newCardInsertOrder = newCardInsertOrder;
    if (leechAction != null) result.leechAction = leechAction;
    if (leechThreshold != null) result.leechThreshold = leechThreshold;
    if (disableAutoplay != null) result.disableAutoplay = disableAutoplay;
    if (capAnswerTimeToSecs != null)
      result.capAnswerTimeToSecs = capAnswerTimeToSecs;
    if (showTimer != null) result.showTimer = showTimer;
    if (skipQuestionWhenReplayingAnswer != null)
      result.skipQuestionWhenReplayingAnswer = skipQuestionWhenReplayingAnswer;
    if (buryNew != null) result.buryNew = buryNew;
    if (buryReviews != null) result.buryReviews = buryReviews;
    if (buryInterdayLearning != null)
      result.buryInterdayLearning = buryInterdayLearning;
    if (newMix != null) result.newMix = newMix;
    if (interdayLearningMix != null)
      result.interdayLearningMix = interdayLearningMix;
    if (newCardSortOrder != null) result.newCardSortOrder = newCardSortOrder;
    if (reviewOrder != null) result.reviewOrder = reviewOrder;
    if (newCardGatherPriority != null)
      result.newCardGatherPriority = newCardGatherPriority;
    if (newPerDayMinimum != null) result.newPerDayMinimum = newPerDayMinimum;
    if (questionAction != null) result.questionAction = questionAction;
    if (desiredRetention != null) result.desiredRetention = desiredRetention;
    if (stopTimerOnAnswer != null) result.stopTimerOnAnswer = stopTimerOnAnswer;
    if (historicalRetention != null)
      result.historicalRetention = historicalRetention;
    if (secondsToShowQuestion != null)
      result.secondsToShowQuestion = secondsToShowQuestion;
    if (secondsToShowAnswer != null)
      result.secondsToShowAnswer = secondsToShowAnswer;
    if (answerAction != null) result.answerAction = answerAction;
    if (waitForAudio != null) result.waitForAudio = waitForAudio;
    if (paramSearch != null) result.paramSearch = paramSearch;
    if (ignoreRevlogsBeforeDate != null)
      result.ignoreRevlogsBeforeDate = ignoreRevlogsBeforeDate;
    if (other != null) result.other = other;
    return result;
  }

  DeckConfig_Config._();

  factory DeckConfig_Config.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfig_Config()..mergeFromBuffer(data, registry);
  factory DeckConfig_Config.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfig_Config()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckConfig.Config',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: DeckConfig_Config.$_createMessage)
    ..p<$core.double>(
        1, _omitFieldNames ? '' : 'learnSteps', $pb.PbFieldType.KF)
    ..p<$core.double>(
        2, _omitFieldNames ? '' : 'relearnSteps', $pb.PbFieldType.KF)
    ..p<$core.double>(
        3, _omitFieldNames ? '' : 'fsrsParams4', $pb.PbFieldType.KF,
        protoName: 'fsrs_params_4')
    ..p<$core.double>(
        4, _omitFieldNames ? '' : 'easyDaysPercentages', $pb.PbFieldType.KF)
    ..p<$core.double>(
        5, _omitFieldNames ? '' : 'fsrsParams5', $pb.PbFieldType.KF,
        protoName: 'fsrs_params_5')
    ..p<$core.double>(
        6, _omitFieldNames ? '' : 'fsrsParams6', $pb.PbFieldType.KF,
        protoName: 'fsrs_params_6')
    ..aI(9, _omitFieldNames ? '' : 'newPerDay', fieldType: $pb.PbFieldType.OU3)
    ..aI(10, _omitFieldNames ? '' : 'reviewsPerDay',
        fieldType: $pb.PbFieldType.OU3)
    ..aD(11, _omitFieldNames ? '' : 'initialEase',
        fieldType: $pb.PbFieldType.OF)
    ..aD(12, _omitFieldNames ? '' : 'easyMultiplier',
        fieldType: $pb.PbFieldType.OF)
    ..aD(13, _omitFieldNames ? '' : 'hardMultiplier',
        fieldType: $pb.PbFieldType.OF)
    ..aD(14, _omitFieldNames ? '' : 'lapseMultiplier',
        fieldType: $pb.PbFieldType.OF)
    ..aD(15, _omitFieldNames ? '' : 'intervalMultiplier',
        fieldType: $pb.PbFieldType.OF)
    ..aI(16, _omitFieldNames ? '' : 'maximumReviewInterval',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(17, _omitFieldNames ? '' : 'minimumLapseInterval',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(18, _omitFieldNames ? '' : 'graduatingIntervalGood',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(19, _omitFieldNames ? '' : 'graduatingIntervalEasy',
        fieldType: $pb.PbFieldType.OU3)
    ..aE<DeckConfig_Config_NewCardInsertOrder>(
        20, _omitFieldNames ? '' : 'newCardInsertOrder',
        enumValues: DeckConfig_Config_NewCardInsertOrder.values)
    ..aE<DeckConfig_Config_LeechAction>(
        21, _omitFieldNames ? '' : 'leechAction',
        enumValues: DeckConfig_Config_LeechAction.values)
    ..aI(22, _omitFieldNames ? '' : 'leechThreshold',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(23, _omitFieldNames ? '' : 'disableAutoplay')
    ..aI(24, _omitFieldNames ? '' : 'capAnswerTimeToSecs',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(25, _omitFieldNames ? '' : 'showTimer')
    ..aOB(26, _omitFieldNames ? '' : 'skipQuestionWhenReplayingAnswer')
    ..aOB(27, _omitFieldNames ? '' : 'buryNew')
    ..aOB(28, _omitFieldNames ? '' : 'buryReviews')
    ..aOB(29, _omitFieldNames ? '' : 'buryInterdayLearning')
    ..aE<DeckConfig_Config_ReviewMix>(30, _omitFieldNames ? '' : 'newMix',
        enumValues: DeckConfig_Config_ReviewMix.values)
    ..aE<DeckConfig_Config_ReviewMix>(
        31, _omitFieldNames ? '' : 'interdayLearningMix',
        enumValues: DeckConfig_Config_ReviewMix.values)
    ..aE<DeckConfig_Config_NewCardSortOrder>(
        32, _omitFieldNames ? '' : 'newCardSortOrder',
        enumValues: DeckConfig_Config_NewCardSortOrder.values)
    ..aE<DeckConfig_Config_ReviewCardOrder>(
        33, _omitFieldNames ? '' : 'reviewOrder',
        enumValues: DeckConfig_Config_ReviewCardOrder.values)
    ..aE<DeckConfig_Config_NewCardGatherPriority>(
        34, _omitFieldNames ? '' : 'newCardGatherPriority',
        enumValues: DeckConfig_Config_NewCardGatherPriority.values)
    ..aI(35, _omitFieldNames ? '' : 'newPerDayMinimum',
        fieldType: $pb.PbFieldType.OU3)
    ..aE<DeckConfig_Config_QuestionAction>(
        36, _omitFieldNames ? '' : 'questionAction',
        enumValues: DeckConfig_Config_QuestionAction.values)
    ..aD(37, _omitFieldNames ? '' : 'desiredRetention',
        fieldType: $pb.PbFieldType.OF)
    ..aOB(38, _omitFieldNames ? '' : 'stopTimerOnAnswer')
    ..aD(40, _omitFieldNames ? '' : 'historicalRetention',
        fieldType: $pb.PbFieldType.OF)
    ..aD(41, _omitFieldNames ? '' : 'secondsToShowQuestion',
        fieldType: $pb.PbFieldType.OF)
    ..aD(42, _omitFieldNames ? '' : 'secondsToShowAnswer',
        fieldType: $pb.PbFieldType.OF)
    ..aE<DeckConfig_Config_AnswerAction>(
        43, _omitFieldNames ? '' : 'answerAction',
        enumValues: DeckConfig_Config_AnswerAction.values)
    ..aOB(44, _omitFieldNames ? '' : 'waitForAudio')
    ..aOS(45, _omitFieldNames ? '' : 'paramSearch')
    ..aOS(46, _omitFieldNames ? '' : 'ignoreRevlogsBeforeDate')
    ..a<$core.List<$core.int>>(
        255, _omitFieldNames ? '' : 'other', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfig_Config clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfig_Config copyWith(void Function(DeckConfig_Config) updates) =>
      super.copyWith((message) => updates(message as DeckConfig_Config))
          as DeckConfig_Config;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckConfig_Config() / DeckConfig_Config.new instead')
  static DeckConfig_Config create() => DeckConfig_Config._();
  static $pb.GeneratedMessage $_createMessage() => DeckConfig_Config._();
  @$core.override
  DeckConfig_Config createEmptyInstance() => DeckConfig_Config._();
  @$core.pragma('dart2js:noInline')
  static DeckConfig_Config getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeckConfig_Config>(
          DeckConfig_Config.$_createMessage);
  static DeckConfig_Config? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.double> get learnSteps => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.double> get relearnSteps => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.double> get fsrsParams4 => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.double> get easyDaysPercentages => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.double> get fsrsParams5 => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get fsrsParams6 => $_getList(5);

  @$pb.TagNumber(9)
  $core.int get newPerDay => $_getIZ(6);
  @$pb.TagNumber(9)
  set newPerDay($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(9)
  $core.bool hasNewPerDay() => $_has(6);
  @$pb.TagNumber(9)
  void clearNewPerDay() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get reviewsPerDay => $_getIZ(7);
  @$pb.TagNumber(10)
  set reviewsPerDay($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(10)
  $core.bool hasReviewsPerDay() => $_has(7);
  @$pb.TagNumber(10)
  void clearReviewsPerDay() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get initialEase => $_getN(8);
  @$pb.TagNumber(11)
  set initialEase($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(11)
  $core.bool hasInitialEase() => $_has(8);
  @$pb.TagNumber(11)
  void clearInitialEase() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get easyMultiplier => $_getN(9);
  @$pb.TagNumber(12)
  set easyMultiplier($core.double value) => $_setFloat(9, value);
  @$pb.TagNumber(12)
  $core.bool hasEasyMultiplier() => $_has(9);
  @$pb.TagNumber(12)
  void clearEasyMultiplier() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get hardMultiplier => $_getN(10);
  @$pb.TagNumber(13)
  set hardMultiplier($core.double value) => $_setFloat(10, value);
  @$pb.TagNumber(13)
  $core.bool hasHardMultiplier() => $_has(10);
  @$pb.TagNumber(13)
  void clearHardMultiplier() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get lapseMultiplier => $_getN(11);
  @$pb.TagNumber(14)
  set lapseMultiplier($core.double value) => $_setFloat(11, value);
  @$pb.TagNumber(14)
  $core.bool hasLapseMultiplier() => $_has(11);
  @$pb.TagNumber(14)
  void clearLapseMultiplier() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get intervalMultiplier => $_getN(12);
  @$pb.TagNumber(15)
  set intervalMultiplier($core.double value) => $_setFloat(12, value);
  @$pb.TagNumber(15)
  $core.bool hasIntervalMultiplier() => $_has(12);
  @$pb.TagNumber(15)
  void clearIntervalMultiplier() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get maximumReviewInterval => $_getIZ(13);
  @$pb.TagNumber(16)
  set maximumReviewInterval($core.int value) => $_setUnsignedInt32(13, value);
  @$pb.TagNumber(16)
  $core.bool hasMaximumReviewInterval() => $_has(13);
  @$pb.TagNumber(16)
  void clearMaximumReviewInterval() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get minimumLapseInterval => $_getIZ(14);
  @$pb.TagNumber(17)
  set minimumLapseInterval($core.int value) => $_setUnsignedInt32(14, value);
  @$pb.TagNumber(17)
  $core.bool hasMinimumLapseInterval() => $_has(14);
  @$pb.TagNumber(17)
  void clearMinimumLapseInterval() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get graduatingIntervalGood => $_getIZ(15);
  @$pb.TagNumber(18)
  set graduatingIntervalGood($core.int value) => $_setUnsignedInt32(15, value);
  @$pb.TagNumber(18)
  $core.bool hasGraduatingIntervalGood() => $_has(15);
  @$pb.TagNumber(18)
  void clearGraduatingIntervalGood() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get graduatingIntervalEasy => $_getIZ(16);
  @$pb.TagNumber(19)
  set graduatingIntervalEasy($core.int value) => $_setUnsignedInt32(16, value);
  @$pb.TagNumber(19)
  $core.bool hasGraduatingIntervalEasy() => $_has(16);
  @$pb.TagNumber(19)
  void clearGraduatingIntervalEasy() => $_clearField(19);

  @$pb.TagNumber(20)
  DeckConfig_Config_NewCardInsertOrder get newCardInsertOrder => $_getN(17);
  @$pb.TagNumber(20)
  set newCardInsertOrder(DeckConfig_Config_NewCardInsertOrder value) =>
      $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasNewCardInsertOrder() => $_has(17);
  @$pb.TagNumber(20)
  void clearNewCardInsertOrder() => $_clearField(20);

  @$pb.TagNumber(21)
  DeckConfig_Config_LeechAction get leechAction => $_getN(18);
  @$pb.TagNumber(21)
  set leechAction(DeckConfig_Config_LeechAction value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasLeechAction() => $_has(18);
  @$pb.TagNumber(21)
  void clearLeechAction() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.int get leechThreshold => $_getIZ(19);
  @$pb.TagNumber(22)
  set leechThreshold($core.int value) => $_setUnsignedInt32(19, value);
  @$pb.TagNumber(22)
  $core.bool hasLeechThreshold() => $_has(19);
  @$pb.TagNumber(22)
  void clearLeechThreshold() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.bool get disableAutoplay => $_getBF(20);
  @$pb.TagNumber(23)
  set disableAutoplay($core.bool value) => $_setBool(20, value);
  @$pb.TagNumber(23)
  $core.bool hasDisableAutoplay() => $_has(20);
  @$pb.TagNumber(23)
  void clearDisableAutoplay() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.int get capAnswerTimeToSecs => $_getIZ(21);
  @$pb.TagNumber(24)
  set capAnswerTimeToSecs($core.int value) => $_setUnsignedInt32(21, value);
  @$pb.TagNumber(24)
  $core.bool hasCapAnswerTimeToSecs() => $_has(21);
  @$pb.TagNumber(24)
  void clearCapAnswerTimeToSecs() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.bool get showTimer => $_getBF(22);
  @$pb.TagNumber(25)
  set showTimer($core.bool value) => $_setBool(22, value);
  @$pb.TagNumber(25)
  $core.bool hasShowTimer() => $_has(22);
  @$pb.TagNumber(25)
  void clearShowTimer() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.bool get skipQuestionWhenReplayingAnswer => $_getBF(23);
  @$pb.TagNumber(26)
  set skipQuestionWhenReplayingAnswer($core.bool value) => $_setBool(23, value);
  @$pb.TagNumber(26)
  $core.bool hasSkipQuestionWhenReplayingAnswer() => $_has(23);
  @$pb.TagNumber(26)
  void clearSkipQuestionWhenReplayingAnswer() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.bool get buryNew => $_getBF(24);
  @$pb.TagNumber(27)
  set buryNew($core.bool value) => $_setBool(24, value);
  @$pb.TagNumber(27)
  $core.bool hasBuryNew() => $_has(24);
  @$pb.TagNumber(27)
  void clearBuryNew() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.bool get buryReviews => $_getBF(25);
  @$pb.TagNumber(28)
  set buryReviews($core.bool value) => $_setBool(25, value);
  @$pb.TagNumber(28)
  $core.bool hasBuryReviews() => $_has(25);
  @$pb.TagNumber(28)
  void clearBuryReviews() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.bool get buryInterdayLearning => $_getBF(26);
  @$pb.TagNumber(29)
  set buryInterdayLearning($core.bool value) => $_setBool(26, value);
  @$pb.TagNumber(29)
  $core.bool hasBuryInterdayLearning() => $_has(26);
  @$pb.TagNumber(29)
  void clearBuryInterdayLearning() => $_clearField(29);

  @$pb.TagNumber(30)
  DeckConfig_Config_ReviewMix get newMix => $_getN(27);
  @$pb.TagNumber(30)
  set newMix(DeckConfig_Config_ReviewMix value) => $_setField(30, value);
  @$pb.TagNumber(30)
  $core.bool hasNewMix() => $_has(27);
  @$pb.TagNumber(30)
  void clearNewMix() => $_clearField(30);

  @$pb.TagNumber(31)
  DeckConfig_Config_ReviewMix get interdayLearningMix => $_getN(28);
  @$pb.TagNumber(31)
  set interdayLearningMix(DeckConfig_Config_ReviewMix value) =>
      $_setField(31, value);
  @$pb.TagNumber(31)
  $core.bool hasInterdayLearningMix() => $_has(28);
  @$pb.TagNumber(31)
  void clearInterdayLearningMix() => $_clearField(31);

  @$pb.TagNumber(32)
  DeckConfig_Config_NewCardSortOrder get newCardSortOrder => $_getN(29);
  @$pb.TagNumber(32)
  set newCardSortOrder(DeckConfig_Config_NewCardSortOrder value) =>
      $_setField(32, value);
  @$pb.TagNumber(32)
  $core.bool hasNewCardSortOrder() => $_has(29);
  @$pb.TagNumber(32)
  void clearNewCardSortOrder() => $_clearField(32);

  @$pb.TagNumber(33)
  DeckConfig_Config_ReviewCardOrder get reviewOrder => $_getN(30);
  @$pb.TagNumber(33)
  set reviewOrder(DeckConfig_Config_ReviewCardOrder value) =>
      $_setField(33, value);
  @$pb.TagNumber(33)
  $core.bool hasReviewOrder() => $_has(30);
  @$pb.TagNumber(33)
  void clearReviewOrder() => $_clearField(33);

  @$pb.TagNumber(34)
  DeckConfig_Config_NewCardGatherPriority get newCardGatherPriority =>
      $_getN(31);
  @$pb.TagNumber(34)
  set newCardGatherPriority(DeckConfig_Config_NewCardGatherPriority value) =>
      $_setField(34, value);
  @$pb.TagNumber(34)
  $core.bool hasNewCardGatherPriority() => $_has(31);
  @$pb.TagNumber(34)
  void clearNewCardGatherPriority() => $_clearField(34);

  /// not currently used
  @$pb.TagNumber(35)
  $core.int get newPerDayMinimum => $_getIZ(32);
  @$pb.TagNumber(35)
  set newPerDayMinimum($core.int value) => $_setUnsignedInt32(32, value);
  @$pb.TagNumber(35)
  $core.bool hasNewPerDayMinimum() => $_has(32);
  @$pb.TagNumber(35)
  void clearNewPerDayMinimum() => $_clearField(35);

  @$pb.TagNumber(36)
  DeckConfig_Config_QuestionAction get questionAction => $_getN(33);
  @$pb.TagNumber(36)
  set questionAction(DeckConfig_Config_QuestionAction value) =>
      $_setField(36, value);
  @$pb.TagNumber(36)
  $core.bool hasQuestionAction() => $_has(33);
  @$pb.TagNumber(36)
  void clearQuestionAction() => $_clearField(36);

  /// for fsrs
  @$pb.TagNumber(37)
  $core.double get desiredRetention => $_getN(34);
  @$pb.TagNumber(37)
  set desiredRetention($core.double value) => $_setFloat(34, value);
  @$pb.TagNumber(37)
  $core.bool hasDesiredRetention() => $_has(34);
  @$pb.TagNumber(37)
  void clearDesiredRetention() => $_clearField(37);

  @$pb.TagNumber(38)
  $core.bool get stopTimerOnAnswer => $_getBF(35);
  @$pb.TagNumber(38)
  set stopTimerOnAnswer($core.bool value) => $_setBool(35, value);
  @$pb.TagNumber(38)
  $core.bool hasStopTimerOnAnswer() => $_has(35);
  @$pb.TagNumber(38)
  void clearStopTimerOnAnswer() => $_clearField(38);

  @$pb.TagNumber(40)
  $core.double get historicalRetention => $_getN(36);
  @$pb.TagNumber(40)
  set historicalRetention($core.double value) => $_setFloat(36, value);
  @$pb.TagNumber(40)
  $core.bool hasHistoricalRetention() => $_has(36);
  @$pb.TagNumber(40)
  void clearHistoricalRetention() => $_clearField(40);

  @$pb.TagNumber(41)
  $core.double get secondsToShowQuestion => $_getN(37);
  @$pb.TagNumber(41)
  set secondsToShowQuestion($core.double value) => $_setFloat(37, value);
  @$pb.TagNumber(41)
  $core.bool hasSecondsToShowQuestion() => $_has(37);
  @$pb.TagNumber(41)
  void clearSecondsToShowQuestion() => $_clearField(41);

  @$pb.TagNumber(42)
  $core.double get secondsToShowAnswer => $_getN(38);
  @$pb.TagNumber(42)
  set secondsToShowAnswer($core.double value) => $_setFloat(38, value);
  @$pb.TagNumber(42)
  $core.bool hasSecondsToShowAnswer() => $_has(38);
  @$pb.TagNumber(42)
  void clearSecondsToShowAnswer() => $_clearField(42);

  @$pb.TagNumber(43)
  DeckConfig_Config_AnswerAction get answerAction => $_getN(39);
  @$pb.TagNumber(43)
  set answerAction(DeckConfig_Config_AnswerAction value) =>
      $_setField(43, value);
  @$pb.TagNumber(43)
  $core.bool hasAnswerAction() => $_has(39);
  @$pb.TagNumber(43)
  void clearAnswerAction() => $_clearField(43);

  @$pb.TagNumber(44)
  $core.bool get waitForAudio => $_getBF(40);
  @$pb.TagNumber(44)
  set waitForAudio($core.bool value) => $_setBool(40, value);
  @$pb.TagNumber(44)
  $core.bool hasWaitForAudio() => $_has(40);
  @$pb.TagNumber(44)
  void clearWaitForAudio() => $_clearField(44);

  @$pb.TagNumber(45)
  $core.String get paramSearch => $_getSZ(41);
  @$pb.TagNumber(45)
  set paramSearch($core.String value) => $_setString(41, value);
  @$pb.TagNumber(45)
  $core.bool hasParamSearch() => $_has(41);
  @$pb.TagNumber(45)
  void clearParamSearch() => $_clearField(45);

  @$pb.TagNumber(46)
  $core.String get ignoreRevlogsBeforeDate => $_getSZ(42);
  @$pb.TagNumber(46)
  set ignoreRevlogsBeforeDate($core.String value) => $_setString(42, value);
  @$pb.TagNumber(46)
  $core.bool hasIgnoreRevlogsBeforeDate() => $_has(42);
  @$pb.TagNumber(46)
  void clearIgnoreRevlogsBeforeDate() => $_clearField(46);

  @$pb.TagNumber(255)
  $core.List<$core.int> get other => $_getN(43);
  @$pb.TagNumber(255)
  set other($core.List<$core.int> value) => $_setBytes(43, value);
  @$pb.TagNumber(255)
  $core.bool hasOther() => $_has(43);
  @$pb.TagNumber(255)
  void clearOther() => $_clearField(255);
}

class DeckConfig extends $pb.GeneratedMessage {
  factory DeckConfig({
    $fixnum.Int64? id,
    $core.String? name,
    $fixnum.Int64? mtimeSecs,
    $core.int? usn,
    DeckConfig_Config? config,
  }) {
    final result = DeckConfig._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (mtimeSecs != null) result.mtimeSecs = mtimeSecs;
    if (usn != null) result.usn = usn;
    if (config != null) result.config = config;
    return result;
  }

  DeckConfig._();

  factory DeckConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfig()..mergeFromBuffer(data, registry);
  factory DeckConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfig()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckConfig',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: DeckConfig.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aInt64(3, _omitFieldNames ? '' : 'mtimeSecs')
    ..aI(4, _omitFieldNames ? '' : 'usn')
    ..aOM<DeckConfig_Config>(5, _omitFieldNames ? '' : 'config',
        subBuilder: DeckConfig_Config.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfig clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfig copyWith(void Function(DeckConfig) updates) =>
      super.copyWith((message) => updates(message as DeckConfig)) as DeckConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DeckConfig() / DeckConfig.new instead')
  static DeckConfig create() => DeckConfig._();
  static $pb.GeneratedMessage $_createMessage() => DeckConfig._();
  @$core.override
  DeckConfig createEmptyInstance() => DeckConfig._();
  @$core.pragma('dart2js:noInline')
  static DeckConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckConfig>(DeckConfig.$_createMessage);
  static DeckConfig? _defaultInstance;

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
  DeckConfig_Config get config => $_getN(4);
  @$pb.TagNumber(5)
  set config(DeckConfig_Config value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasConfig() => $_has(4);
  @$pb.TagNumber(5)
  void clearConfig() => $_clearField(5);
  @$pb.TagNumber(5)
  DeckConfig_Config ensureConfig() => $_ensure(4);
}

class DeckConfigsForUpdate_ConfigWithExtra extends $pb.GeneratedMessage {
  factory DeckConfigsForUpdate_ConfigWithExtra({
    DeckConfig? config,
    $core.int? useCount,
  }) {
    final result = DeckConfigsForUpdate_ConfigWithExtra._();
    if (config != null) result.config = config;
    if (useCount != null) result.useCount = useCount;
    return result;
  }

  DeckConfigsForUpdate_ConfigWithExtra._();

  factory DeckConfigsForUpdate_ConfigWithExtra.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate_ConfigWithExtra()..mergeFromBuffer(data, registry);
  factory DeckConfigsForUpdate_ConfigWithExtra.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate_ConfigWithExtra()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckConfigsForUpdate.ConfigWithExtra',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: DeckConfigsForUpdate_ConfigWithExtra.$_createMessage)
    ..aOM<DeckConfig>(1, _omitFieldNames ? '' : 'config',
        subBuilder: DeckConfig.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'useCount', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate_ConfigWithExtra clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate_ConfigWithExtra copyWith(
          void Function(DeckConfigsForUpdate_ConfigWithExtra) updates) =>
      super.copyWith((message) =>
              updates(message as DeckConfigsForUpdate_ConfigWithExtra))
          as DeckConfigsForUpdate_ConfigWithExtra;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeckConfigsForUpdate_ConfigWithExtra() / DeckConfigsForUpdate_ConfigWithExtra.new instead')
  static DeckConfigsForUpdate_ConfigWithExtra create() =>
      DeckConfigsForUpdate_ConfigWithExtra._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeckConfigsForUpdate_ConfigWithExtra._();
  @$core.override
  DeckConfigsForUpdate_ConfigWithExtra createEmptyInstance() =>
      DeckConfigsForUpdate_ConfigWithExtra._();
  @$core.pragma('dart2js:noInline')
  static DeckConfigsForUpdate_ConfigWithExtra getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              DeckConfigsForUpdate_ConfigWithExtra>(
          DeckConfigsForUpdate_ConfigWithExtra.$_createMessage);
  static DeckConfigsForUpdate_ConfigWithExtra? _defaultInstance;

  @$pb.TagNumber(1)
  DeckConfig get config => $_getN(0);
  @$pb.TagNumber(1)
  set config(DeckConfig value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => $_clearField(1);
  @$pb.TagNumber(1)
  DeckConfig ensureConfig() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get useCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set useCount($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUseCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearUseCount() => $_clearField(2);
}

class DeckConfigsForUpdate_CurrentDeck_Limits extends $pb.GeneratedMessage {
  factory DeckConfigsForUpdate_CurrentDeck_Limits({
    $core.int? review,
    $core.int? new_2,
    $core.int? reviewToday,
    $core.int? newToday,
    $core.bool? reviewTodayActive,
    $core.bool? newTodayActive,
    $core.double? desiredRetention,
  }) {
    final result = DeckConfigsForUpdate_CurrentDeck_Limits._();
    if (review != null) result.review = review;
    if (new_2 != null) result.new_2 = new_2;
    if (reviewToday != null) result.reviewToday = reviewToday;
    if (newToday != null) result.newToday = newToday;
    if (reviewTodayActive != null) result.reviewTodayActive = reviewTodayActive;
    if (newTodayActive != null) result.newTodayActive = newTodayActive;
    if (desiredRetention != null) result.desiredRetention = desiredRetention;
    return result;
  }

  DeckConfigsForUpdate_CurrentDeck_Limits._();

  factory DeckConfigsForUpdate_CurrentDeck_Limits.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate_CurrentDeck_Limits()
        ..mergeFromBuffer(data, registry);
  factory DeckConfigsForUpdate_CurrentDeck_Limits.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate_CurrentDeck_Limits()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckConfigsForUpdate.CurrentDeck.Limits',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance:
          DeckConfigsForUpdate_CurrentDeck_Limits.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'review', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'new', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'reviewToday',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'newToday', fieldType: $pb.PbFieldType.OU3)
    ..aOB(5, _omitFieldNames ? '' : 'reviewTodayActive')
    ..aOB(6, _omitFieldNames ? '' : 'newTodayActive')
    ..aD(7, _omitFieldNames ? '' : 'desiredRetention',
        fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate_CurrentDeck_Limits clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate_CurrentDeck_Limits copyWith(
          void Function(DeckConfigsForUpdate_CurrentDeck_Limits) updates) =>
      super.copyWith((message) =>
              updates(message as DeckConfigsForUpdate_CurrentDeck_Limits))
          as DeckConfigsForUpdate_CurrentDeck_Limits;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeckConfigsForUpdate_CurrentDeck_Limits() / DeckConfigsForUpdate_CurrentDeck_Limits.new instead')
  static DeckConfigsForUpdate_CurrentDeck_Limits create() =>
      DeckConfigsForUpdate_CurrentDeck_Limits._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeckConfigsForUpdate_CurrentDeck_Limits._();
  @$core.override
  DeckConfigsForUpdate_CurrentDeck_Limits createEmptyInstance() =>
      DeckConfigsForUpdate_CurrentDeck_Limits._();
  @$core.pragma('dart2js:noInline')
  static DeckConfigsForUpdate_CurrentDeck_Limits getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              DeckConfigsForUpdate_CurrentDeck_Limits>(
          DeckConfigsForUpdate_CurrentDeck_Limits.$_createMessage);
  static DeckConfigsForUpdate_CurrentDeck_Limits? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get review => $_getIZ(0);
  @$pb.TagNumber(1)
  set review($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearReview() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get new_2 => $_getIZ(1);
  @$pb.TagNumber(2)
  set new_2($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNew_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearNew_2() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get reviewToday => $_getIZ(2);
  @$pb.TagNumber(3)
  set reviewToday($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReviewToday() => $_has(2);
  @$pb.TagNumber(3)
  void clearReviewToday() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get newToday => $_getIZ(3);
  @$pb.TagNumber(4)
  set newToday($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewToday() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewToday() => $_clearField(4);

  /// Whether review_today applies to today or a past day.
  @$pb.TagNumber(5)
  $core.bool get reviewTodayActive => $_getBF(4);
  @$pb.TagNumber(5)
  set reviewTodayActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReviewTodayActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearReviewTodayActive() => $_clearField(5);

  /// Whether new_today applies to today or a past day.
  @$pb.TagNumber(6)
  $core.bool get newTodayActive => $_getBF(5);
  @$pb.TagNumber(6)
  set newTodayActive($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNewTodayActive() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewTodayActive() => $_clearField(6);

  /// Deck-specific desired retention override
  @$pb.TagNumber(7)
  $core.double get desiredRetention => $_getN(6);
  @$pb.TagNumber(7)
  set desiredRetention($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDesiredRetention() => $_has(6);
  @$pb.TagNumber(7)
  void clearDesiredRetention() => $_clearField(7);
}

class DeckConfigsForUpdate_CurrentDeck extends $pb.GeneratedMessage {
  factory DeckConfigsForUpdate_CurrentDeck({
    $core.String? name,
    $fixnum.Int64? configId,
    $core.Iterable<$fixnum.Int64>? parentConfigIds,
    DeckConfigsForUpdate_CurrentDeck_Limits? limits,
  }) {
    final result = DeckConfigsForUpdate_CurrentDeck._();
    if (name != null) result.name = name;
    if (configId != null) result.configId = configId;
    if (parentConfigIds != null) result.parentConfigIds.addAll(parentConfigIds);
    if (limits != null) result.limits = limits;
    return result;
  }

  DeckConfigsForUpdate_CurrentDeck._();

  factory DeckConfigsForUpdate_CurrentDeck.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate_CurrentDeck()..mergeFromBuffer(data, registry);
  factory DeckConfigsForUpdate_CurrentDeck.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate_CurrentDeck()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckConfigsForUpdate.CurrentDeck',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: DeckConfigsForUpdate_CurrentDeck.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'configId')
    ..p<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'parentConfigIds', $pb.PbFieldType.K6)
    ..aOM<DeckConfigsForUpdate_CurrentDeck_Limits>(
        4, _omitFieldNames ? '' : 'limits',
        subBuilder: DeckConfigsForUpdate_CurrentDeck_Limits.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate_CurrentDeck clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate_CurrentDeck copyWith(
          void Function(DeckConfigsForUpdate_CurrentDeck) updates) =>
      super.copyWith(
              (message) => updates(message as DeckConfigsForUpdate_CurrentDeck))
          as DeckConfigsForUpdate_CurrentDeck;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeckConfigsForUpdate_CurrentDeck() / DeckConfigsForUpdate_CurrentDeck.new instead')
  static DeckConfigsForUpdate_CurrentDeck create() =>
      DeckConfigsForUpdate_CurrentDeck._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeckConfigsForUpdate_CurrentDeck._();
  @$core.override
  DeckConfigsForUpdate_CurrentDeck createEmptyInstance() =>
      DeckConfigsForUpdate_CurrentDeck._();
  @$core.pragma('dart2js:noInline')
  static DeckConfigsForUpdate_CurrentDeck getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckConfigsForUpdate_CurrentDeck>(
          DeckConfigsForUpdate_CurrentDeck.$_createMessage);
  static DeckConfigsForUpdate_CurrentDeck? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get configId => $_getI64(1);
  @$pb.TagNumber(2)
  set configId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConfigId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfigId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$fixnum.Int64> get parentConfigIds => $_getList(2);

  @$pb.TagNumber(4)
  DeckConfigsForUpdate_CurrentDeck_Limits get limits => $_getN(3);
  @$pb.TagNumber(4)
  set limits(DeckConfigsForUpdate_CurrentDeck_Limits value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLimits() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimits() => $_clearField(4);
  @$pb.TagNumber(4)
  DeckConfigsForUpdate_CurrentDeck_Limits ensureLimits() => $_ensure(3);
}

class DeckConfigsForUpdate extends $pb.GeneratedMessage {
  factory DeckConfigsForUpdate({
    $core.Iterable<DeckConfigsForUpdate_ConfigWithExtra>? allConfig,
    DeckConfigsForUpdate_CurrentDeck? currentDeck,
    DeckConfig? defaults,
    $core.bool? schemaModified,
    $core.String? cardStateCustomizer,
    $core.bool? newCardsIgnoreReviewLimit,
    $core.bool? fsrs,
    $core.bool? applyAllParentLimits,
    $core.int? daysSinceLastFsrsOptimize,
    $core.bool? fsrsHealthCheck,
    $core.bool? fsrsLegacyEvaluate,
  }) {
    final result = DeckConfigsForUpdate._();
    if (allConfig != null) result.allConfig.addAll(allConfig);
    if (currentDeck != null) result.currentDeck = currentDeck;
    if (defaults != null) result.defaults = defaults;
    if (schemaModified != null) result.schemaModified = schemaModified;
    if (cardStateCustomizer != null)
      result.cardStateCustomizer = cardStateCustomizer;
    if (newCardsIgnoreReviewLimit != null)
      result.newCardsIgnoreReviewLimit = newCardsIgnoreReviewLimit;
    if (fsrs != null) result.fsrs = fsrs;
    if (applyAllParentLimits != null)
      result.applyAllParentLimits = applyAllParentLimits;
    if (daysSinceLastFsrsOptimize != null)
      result.daysSinceLastFsrsOptimize = daysSinceLastFsrsOptimize;
    if (fsrsHealthCheck != null) result.fsrsHealthCheck = fsrsHealthCheck;
    if (fsrsLegacyEvaluate != null)
      result.fsrsLegacyEvaluate = fsrsLegacyEvaluate;
    return result;
  }

  DeckConfigsForUpdate._();

  factory DeckConfigsForUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate()..mergeFromBuffer(data, registry);
  factory DeckConfigsForUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeckConfigsForUpdate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeckConfigsForUpdate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: DeckConfigsForUpdate.$_createMessage)
    ..pPM<DeckConfigsForUpdate_ConfigWithExtra>(
        1, _omitFieldNames ? '' : 'allConfig',
        subBuilder: DeckConfigsForUpdate_ConfigWithExtra.$_createMessage)
    ..aOM<DeckConfigsForUpdate_CurrentDeck>(
        2, _omitFieldNames ? '' : 'currentDeck',
        subBuilder: DeckConfigsForUpdate_CurrentDeck.$_createMessage)
    ..aOM<DeckConfig>(3, _omitFieldNames ? '' : 'defaults',
        subBuilder: DeckConfig.$_createMessage)
    ..aOB(4, _omitFieldNames ? '' : 'schemaModified')
    ..aOS(6, _omitFieldNames ? '' : 'cardStateCustomizer')
    ..aOB(7, _omitFieldNames ? '' : 'newCardsIgnoreReviewLimit')
    ..aOB(8, _omitFieldNames ? '' : 'fsrs')
    ..aOB(9, _omitFieldNames ? '' : 'applyAllParentLimits')
    ..aI(10, _omitFieldNames ? '' : 'daysSinceLastFsrsOptimize',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(11, _omitFieldNames ? '' : 'fsrsHealthCheck')
    ..aOB(12, _omitFieldNames ? '' : 'fsrsLegacyEvaluate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeckConfigsForUpdate copyWith(void Function(DeckConfigsForUpdate) updates) =>
      super.copyWith((message) => updates(message as DeckConfigsForUpdate))
          as DeckConfigsForUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeckConfigsForUpdate() / DeckConfigsForUpdate.new instead')
  static DeckConfigsForUpdate create() => DeckConfigsForUpdate._();
  static $pb.GeneratedMessage $_createMessage() => DeckConfigsForUpdate._();
  @$core.override
  DeckConfigsForUpdate createEmptyInstance() => DeckConfigsForUpdate._();
  @$core.pragma('dart2js:noInline')
  static DeckConfigsForUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeckConfigsForUpdate>(
          DeckConfigsForUpdate.$_createMessage);
  static DeckConfigsForUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeckConfigsForUpdate_ConfigWithExtra> get allConfig =>
      $_getList(0);

  @$pb.TagNumber(2)
  DeckConfigsForUpdate_CurrentDeck get currentDeck => $_getN(1);
  @$pb.TagNumber(2)
  set currentDeck(DeckConfigsForUpdate_CurrentDeck value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentDeck() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentDeck() => $_clearField(2);
  @$pb.TagNumber(2)
  DeckConfigsForUpdate_CurrentDeck ensureCurrentDeck() => $_ensure(1);

  @$pb.TagNumber(3)
  DeckConfig get defaults => $_getN(2);
  @$pb.TagNumber(3)
  set defaults(DeckConfig value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDefaults() => $_has(2);
  @$pb.TagNumber(3)
  void clearDefaults() => $_clearField(3);
  @$pb.TagNumber(3)
  DeckConfig ensureDefaults() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get schemaModified => $_getBF(3);
  @$pb.TagNumber(4)
  set schemaModified($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSchemaModified() => $_has(3);
  @$pb.TagNumber(4)
  void clearSchemaModified() => $_clearField(4);

  /// only applies to v3 scheduler
  @$pb.TagNumber(6)
  $core.String get cardStateCustomizer => $_getSZ(4);
  @$pb.TagNumber(6)
  set cardStateCustomizer($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasCardStateCustomizer() => $_has(4);
  @$pb.TagNumber(6)
  void clearCardStateCustomizer() => $_clearField(6);

  /// only applies to v3 scheduler
  @$pb.TagNumber(7)
  $core.bool get newCardsIgnoreReviewLimit => $_getBF(5);
  @$pb.TagNumber(7)
  set newCardsIgnoreReviewLimit($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(7)
  $core.bool hasNewCardsIgnoreReviewLimit() => $_has(5);
  @$pb.TagNumber(7)
  void clearNewCardsIgnoreReviewLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get fsrs => $_getBF(6);
  @$pb.TagNumber(8)
  set fsrs($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(8)
  $core.bool hasFsrs() => $_has(6);
  @$pb.TagNumber(8)
  void clearFsrs() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get applyAllParentLimits => $_getBF(7);
  @$pb.TagNumber(9)
  set applyAllParentLimits($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(9)
  $core.bool hasApplyAllParentLimits() => $_has(7);
  @$pb.TagNumber(9)
  void clearApplyAllParentLimits() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get daysSinceLastFsrsOptimize => $_getIZ(8);
  @$pb.TagNumber(10)
  set daysSinceLastFsrsOptimize($core.int value) =>
      $_setUnsignedInt32(8, value);
  @$pb.TagNumber(10)
  $core.bool hasDaysSinceLastFsrsOptimize() => $_has(8);
  @$pb.TagNumber(10)
  void clearDaysSinceLastFsrsOptimize() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get fsrsHealthCheck => $_getBF(9);
  @$pb.TagNumber(11)
  set fsrsHealthCheck($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(11)
  $core.bool hasFsrsHealthCheck() => $_has(9);
  @$pb.TagNumber(11)
  void clearFsrsHealthCheck() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get fsrsLegacyEvaluate => $_getBF(10);
  @$pb.TagNumber(12)
  set fsrsLegacyEvaluate($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(12)
  $core.bool hasFsrsLegacyEvaluate() => $_has(10);
  @$pb.TagNumber(12)
  void clearFsrsLegacyEvaluate() => $_clearField(12);
}

class UpdateDeckConfigsRequest extends $pb.GeneratedMessage {
  factory UpdateDeckConfigsRequest({
    $fixnum.Int64? targetDeckId,
    $core.Iterable<DeckConfig>? configs,
    $core.Iterable<$fixnum.Int64>? removedConfigIds,
    UpdateDeckConfigsMode? mode,
    $core.String? cardStateCustomizer,
    DeckConfigsForUpdate_CurrentDeck_Limits? limits,
    $core.bool? newCardsIgnoreReviewLimit,
    $core.bool? fsrs,
    $core.bool? applyAllParentLimits,
    $core.bool? fsrsReschedule,
    $core.bool? fsrsHealthCheck,
  }) {
    final result = UpdateDeckConfigsRequest._();
    if (targetDeckId != null) result.targetDeckId = targetDeckId;
    if (configs != null) result.configs.addAll(configs);
    if (removedConfigIds != null)
      result.removedConfigIds.addAll(removedConfigIds);
    if (mode != null) result.mode = mode;
    if (cardStateCustomizer != null)
      result.cardStateCustomizer = cardStateCustomizer;
    if (limits != null) result.limits = limits;
    if (newCardsIgnoreReviewLimit != null)
      result.newCardsIgnoreReviewLimit = newCardsIgnoreReviewLimit;
    if (fsrs != null) result.fsrs = fsrs;
    if (applyAllParentLimits != null)
      result.applyAllParentLimits = applyAllParentLimits;
    if (fsrsReschedule != null) result.fsrsReschedule = fsrsReschedule;
    if (fsrsHealthCheck != null) result.fsrsHealthCheck = fsrsHealthCheck;
    return result;
  }

  UpdateDeckConfigsRequest._();

  factory UpdateDeckConfigsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateDeckConfigsRequest()..mergeFromBuffer(data, registry);
  factory UpdateDeckConfigsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateDeckConfigsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDeckConfigsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.deck_config'),
      createEmptyInstance: UpdateDeckConfigsRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'targetDeckId')
    ..pPM<DeckConfig>(2, _omitFieldNames ? '' : 'configs',
        subBuilder: DeckConfig.$_createMessage)
    ..p<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'removedConfigIds', $pb.PbFieldType.K6)
    ..aE<UpdateDeckConfigsMode>(4, _omitFieldNames ? '' : 'mode',
        enumValues: UpdateDeckConfigsMode.values)
    ..aOS(5, _omitFieldNames ? '' : 'cardStateCustomizer')
    ..aOM<DeckConfigsForUpdate_CurrentDeck_Limits>(
        6, _omitFieldNames ? '' : 'limits',
        subBuilder: DeckConfigsForUpdate_CurrentDeck_Limits.$_createMessage)
    ..aOB(7, _omitFieldNames ? '' : 'newCardsIgnoreReviewLimit')
    ..aOB(8, _omitFieldNames ? '' : 'fsrs')
    ..aOB(9, _omitFieldNames ? '' : 'applyAllParentLimits')
    ..aOB(10, _omitFieldNames ? '' : 'fsrsReschedule')
    ..aOB(11, _omitFieldNames ? '' : 'fsrsHealthCheck')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDeckConfigsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDeckConfigsRequest copyWith(
          void Function(UpdateDeckConfigsRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateDeckConfigsRequest))
          as UpdateDeckConfigsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateDeckConfigsRequest() / UpdateDeckConfigsRequest.new instead')
  static UpdateDeckConfigsRequest create() => UpdateDeckConfigsRequest._();
  static $pb.GeneratedMessage $_createMessage() => UpdateDeckConfigsRequest._();
  @$core.override
  UpdateDeckConfigsRequest createEmptyInstance() =>
      UpdateDeckConfigsRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateDeckConfigsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDeckConfigsRequest>(
          UpdateDeckConfigsRequest.$_createMessage);
  static UpdateDeckConfigsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get targetDeckId => $_getI64(0);
  @$pb.TagNumber(1)
  set targetDeckId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTargetDeckId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetDeckId() => $_clearField(1);

  /// / Unchanged, non-selected configs can be omitted. Deck will
  /// / be set to whichever entry comes last.
  @$pb.TagNumber(2)
  $pb.PbList<DeckConfig> get configs => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$fixnum.Int64> get removedConfigIds => $_getList(2);

  @$pb.TagNumber(4)
  UpdateDeckConfigsMode get mode => $_getN(3);
  @$pb.TagNumber(4)
  set mode(UpdateDeckConfigsMode value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearMode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get cardStateCustomizer => $_getSZ(4);
  @$pb.TagNumber(5)
  set cardStateCustomizer($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCardStateCustomizer() => $_has(4);
  @$pb.TagNumber(5)
  void clearCardStateCustomizer() => $_clearField(5);

  @$pb.TagNumber(6)
  DeckConfigsForUpdate_CurrentDeck_Limits get limits => $_getN(5);
  @$pb.TagNumber(6)
  set limits(DeckConfigsForUpdate_CurrentDeck_Limits value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLimits() => $_has(5);
  @$pb.TagNumber(6)
  void clearLimits() => $_clearField(6);
  @$pb.TagNumber(6)
  DeckConfigsForUpdate_CurrentDeck_Limits ensureLimits() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get newCardsIgnoreReviewLimit => $_getBF(6);
  @$pb.TagNumber(7)
  set newCardsIgnoreReviewLimit($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNewCardsIgnoreReviewLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearNewCardsIgnoreReviewLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get fsrs => $_getBF(7);
  @$pb.TagNumber(8)
  set fsrs($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFsrs() => $_has(7);
  @$pb.TagNumber(8)
  void clearFsrs() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get applyAllParentLimits => $_getBF(8);
  @$pb.TagNumber(9)
  set applyAllParentLimits($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasApplyAllParentLimits() => $_has(8);
  @$pb.TagNumber(9)
  void clearApplyAllParentLimits() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get fsrsReschedule => $_getBF(9);
  @$pb.TagNumber(10)
  set fsrsReschedule($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasFsrsReschedule() => $_has(9);
  @$pb.TagNumber(10)
  void clearFsrsReschedule() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get fsrsHealthCheck => $_getBF(10);
  @$pb.TagNumber(11)
  set fsrsHealthCheck($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasFsrsHealthCheck() => $_has(10);
  @$pb.TagNumber(11)
  void clearFsrsHealthCheck() => $_clearField(11);
}

class DeckConfigServiceApi {
  final $pb.RpcClient _client;

  DeckConfigServiceApi(this._client);

  $async.Future<DeckConfigId> addOrUpdateDeckConfigLegacy(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<DeckConfigId>(ctx, 'DeckConfigService',
          'AddOrUpdateDeckConfigLegacy', request, DeckConfigId());
  $async.Future<DeckConfig> getDeckConfig(
          $pb.ClientContext? ctx, DeckConfigId request) =>
      _client.invoke<DeckConfig>(
          ctx, 'DeckConfigService', 'GetDeckConfig', request, DeckConfig());
  $async.Future<$0.Json> allDeckConfigLegacy(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Json>(
          ctx, 'DeckConfigService', 'AllDeckConfigLegacy', request, $0.Json());
  $async.Future<$0.Json> getDeckConfigLegacy(
          $pb.ClientContext? ctx, DeckConfigId request) =>
      _client.invoke<$0.Json>(
          ctx, 'DeckConfigService', 'GetDeckConfigLegacy', request, $0.Json());
  $async.Future<$0.Json> newDeckConfigLegacy(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Json>(
          ctx, 'DeckConfigService', 'NewDeckConfigLegacy', request, $0.Json());
  $async.Future<$0.Empty> removeDeckConfig(
          $pb.ClientContext? ctx, DeckConfigId request) =>
      _client.invoke<$0.Empty>(
          ctx, 'DeckConfigService', 'RemoveDeckConfig', request, $0.Empty());
  $async.Future<DeckConfigsForUpdate> getDeckConfigsForUpdate(
          $pb.ClientContext? ctx, $1.DeckId request) =>
      _client.invoke<DeckConfigsForUpdate>(ctx, 'DeckConfigService',
          'GetDeckConfigsForUpdate', request, DeckConfigsForUpdate());
  $async.Future<$2.OpChanges> updateDeckConfigs(
          $pb.ClientContext? ctx, UpdateDeckConfigsRequest request) =>
      _client.invoke<$2.OpChanges>(ctx, 'DeckConfigService',
          'UpdateDeckConfigs', request, $2.OpChanges());
  $async.Future<GetIgnoredBeforeCountResponse> getIgnoredBeforeCount(
          $pb.ClientContext? ctx, GetIgnoredBeforeCountRequest request) =>
      _client.invoke<GetIgnoredBeforeCountResponse>(ctx, 'DeckConfigService',
          'GetIgnoredBeforeCount', request, GetIgnoredBeforeCountResponse());
  $async.Future<GetRetentionWorkloadResponse> getRetentionWorkload(
          $pb.ClientContext? ctx, GetRetentionWorkloadRequest request) =>
      _client.invoke<GetRetentionWorkloadResponse>(ctx, 'DeckConfigService',
          'GetRetentionWorkload', request, GetRetentionWorkloadResponse());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendDeckConfigServiceApi {
  final $pb.RpcClient _client;

  BackendDeckConfigServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
