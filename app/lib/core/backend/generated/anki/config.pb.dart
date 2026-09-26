// This is a generated file - do not edit.
//
// Generated from anki/config.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'collection.pb.dart' as $1;
import 'config.pbenum.dart';
import 'generic.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'config.pbenum.dart';

class ConfigKey extends $pb.GeneratedMessage {
  factory ConfigKey() => ConfigKey._();

  ConfigKey._();

  factory ConfigKey.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConfigKey()..mergeFromBuffer(data, registry);
  factory ConfigKey.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConfigKey()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfigKey',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: ConfigKey.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfigKey clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfigKey copyWith(void Function(ConfigKey) updates) =>
      super.copyWith((message) => updates(message as ConfigKey)) as ConfigKey;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ConfigKey() / ConfigKey.new instead')
  static ConfigKey create() => ConfigKey._();
  static $pb.GeneratedMessage $_createMessage() => ConfigKey._();
  @$core.override
  ConfigKey createEmptyInstance() => ConfigKey._();
  @$core.pragma('dart2js:noInline')
  static ConfigKey getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfigKey>(ConfigKey.$_createMessage);
  static ConfigKey? _defaultInstance;
}

class GetConfigBoolRequest extends $pb.GeneratedMessage {
  factory GetConfigBoolRequest({
    ConfigKey_Bool? key,
  }) {
    final result = GetConfigBoolRequest._();
    if (key != null) result.key = key;
    return result;
  }

  GetConfigBoolRequest._();

  factory GetConfigBoolRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetConfigBoolRequest()..mergeFromBuffer(data, registry);
  factory GetConfigBoolRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetConfigBoolRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetConfigBoolRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: GetConfigBoolRequest.$_createMessage)
    ..aE<ConfigKey_Bool>(1, _omitFieldNames ? '' : 'key',
        enumValues: ConfigKey_Bool.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConfigBoolRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConfigBoolRequest copyWith(void Function(GetConfigBoolRequest) updates) =>
      super.copyWith((message) => updates(message as GetConfigBoolRequest))
          as GetConfigBoolRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetConfigBoolRequest() / GetConfigBoolRequest.new instead')
  static GetConfigBoolRequest create() => GetConfigBoolRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetConfigBoolRequest._();
  @$core.override
  GetConfigBoolRequest createEmptyInstance() => GetConfigBoolRequest._();
  @$core.pragma('dart2js:noInline')
  static GetConfigBoolRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetConfigBoolRequest>(
          GetConfigBoolRequest.$_createMessage);
  static GetConfigBoolRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ConfigKey_Bool get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(ConfigKey_Bool value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
}

class SetConfigBoolRequest extends $pb.GeneratedMessage {
  factory SetConfigBoolRequest({
    ConfigKey_Bool? key,
    $core.bool? value,
    $core.bool? undoable,
  }) {
    final result = SetConfigBoolRequest._();
    if (key != null) result.key = key;
    if (value != null) result.value = value;
    if (undoable != null) result.undoable = undoable;
    return result;
  }

  SetConfigBoolRequest._();

  factory SetConfigBoolRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetConfigBoolRequest()..mergeFromBuffer(data, registry);
  factory SetConfigBoolRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetConfigBoolRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetConfigBoolRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: SetConfigBoolRequest.$_createMessage)
    ..aE<ConfigKey_Bool>(1, _omitFieldNames ? '' : 'key',
        enumValues: ConfigKey_Bool.values)
    ..aOB(2, _omitFieldNames ? '' : 'value')
    ..aOB(3, _omitFieldNames ? '' : 'undoable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetConfigBoolRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetConfigBoolRequest copyWith(void Function(SetConfigBoolRequest) updates) =>
      super.copyWith((message) => updates(message as SetConfigBoolRequest))
          as SetConfigBoolRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetConfigBoolRequest() / SetConfigBoolRequest.new instead')
  static SetConfigBoolRequest create() => SetConfigBoolRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetConfigBoolRequest._();
  @$core.override
  SetConfigBoolRequest createEmptyInstance() => SetConfigBoolRequest._();
  @$core.pragma('dart2js:noInline')
  static SetConfigBoolRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetConfigBoolRequest>(
          SetConfigBoolRequest.$_createMessage);
  static SetConfigBoolRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ConfigKey_Bool get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(ConfigKey_Bool value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get value => $_getBF(1);
  @$pb.TagNumber(2)
  set value($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get undoable => $_getBF(2);
  @$pb.TagNumber(3)
  set undoable($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUndoable() => $_has(2);
  @$pb.TagNumber(3)
  void clearUndoable() => $_clearField(3);
}

class GetConfigStringRequest extends $pb.GeneratedMessage {
  factory GetConfigStringRequest({
    ConfigKey_String? key,
  }) {
    final result = GetConfigStringRequest._();
    if (key != null) result.key = key;
    return result;
  }

  GetConfigStringRequest._();

  factory GetConfigStringRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetConfigStringRequest()..mergeFromBuffer(data, registry);
  factory GetConfigStringRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetConfigStringRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetConfigStringRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: GetConfigStringRequest.$_createMessage)
    ..aE<ConfigKey_String>(1, _omitFieldNames ? '' : 'key',
        enumValues: ConfigKey_String.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConfigStringRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConfigStringRequest copyWith(
          void Function(GetConfigStringRequest) updates) =>
      super.copyWith((message) => updates(message as GetConfigStringRequest))
          as GetConfigStringRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetConfigStringRequest() / GetConfigStringRequest.new instead')
  static GetConfigStringRequest create() => GetConfigStringRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetConfigStringRequest._();
  @$core.override
  GetConfigStringRequest createEmptyInstance() => GetConfigStringRequest._();
  @$core.pragma('dart2js:noInline')
  static GetConfigStringRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetConfigStringRequest>(
          GetConfigStringRequest.$_createMessage);
  static GetConfigStringRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ConfigKey_String get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(ConfigKey_String value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
}

class SetConfigStringRequest extends $pb.GeneratedMessage {
  factory SetConfigStringRequest({
    ConfigKey_String? key,
    $core.String? value,
    $core.bool? undoable,
  }) {
    final result = SetConfigStringRequest._();
    if (key != null) result.key = key;
    if (value != null) result.value = value;
    if (undoable != null) result.undoable = undoable;
    return result;
  }

  SetConfigStringRequest._();

  factory SetConfigStringRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetConfigStringRequest()..mergeFromBuffer(data, registry);
  factory SetConfigStringRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetConfigStringRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetConfigStringRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: SetConfigStringRequest.$_createMessage)
    ..aE<ConfigKey_String>(1, _omitFieldNames ? '' : 'key',
        enumValues: ConfigKey_String.values)
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..aOB(3, _omitFieldNames ? '' : 'undoable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetConfigStringRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetConfigStringRequest copyWith(
          void Function(SetConfigStringRequest) updates) =>
      super.copyWith((message) => updates(message as SetConfigStringRequest))
          as SetConfigStringRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetConfigStringRequest() / SetConfigStringRequest.new instead')
  static SetConfigStringRequest create() => SetConfigStringRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetConfigStringRequest._();
  @$core.override
  SetConfigStringRequest createEmptyInstance() => SetConfigStringRequest._();
  @$core.pragma('dart2js:noInline')
  static SetConfigStringRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetConfigStringRequest>(
          SetConfigStringRequest.$_createMessage);
  static SetConfigStringRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ConfigKey_String get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(ConfigKey_String value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get undoable => $_getBF(2);
  @$pb.TagNumber(3)
  set undoable($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUndoable() => $_has(2);
  @$pb.TagNumber(3)
  void clearUndoable() => $_clearField(3);
}

class OptionalStringConfigKey extends $pb.GeneratedMessage {
  factory OptionalStringConfigKey({
    ConfigKey_String? key,
  }) {
    final result = OptionalStringConfigKey._();
    if (key != null) result.key = key;
    return result;
  }

  OptionalStringConfigKey._();

  factory OptionalStringConfigKey.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OptionalStringConfigKey()..mergeFromBuffer(data, registry);
  factory OptionalStringConfigKey.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OptionalStringConfigKey()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OptionalStringConfigKey',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: OptionalStringConfigKey.$_createMessage)
    ..aE<ConfigKey_String>(1, _omitFieldNames ? '' : 'key',
        enumValues: ConfigKey_String.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OptionalStringConfigKey clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OptionalStringConfigKey copyWith(
          void Function(OptionalStringConfigKey) updates) =>
      super.copyWith((message) => updates(message as OptionalStringConfigKey))
          as OptionalStringConfigKey;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use OptionalStringConfigKey() / OptionalStringConfigKey.new instead')
  static OptionalStringConfigKey create() => OptionalStringConfigKey._();
  static $pb.GeneratedMessage $_createMessage() => OptionalStringConfigKey._();
  @$core.override
  OptionalStringConfigKey createEmptyInstance() => OptionalStringConfigKey._();
  @$core.pragma('dart2js:noInline')
  static OptionalStringConfigKey getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OptionalStringConfigKey>(
          OptionalStringConfigKey.$_createMessage);
  static OptionalStringConfigKey? _defaultInstance;

  @$pb.TagNumber(1)
  ConfigKey_String get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(ConfigKey_String value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
}

class SetConfigJsonRequest extends $pb.GeneratedMessage {
  factory SetConfigJsonRequest({
    $core.String? key,
    $core.List<$core.int>? valueJson,
    $core.bool? undoable,
  }) {
    final result = SetConfigJsonRequest._();
    if (key != null) result.key = key;
    if (valueJson != null) result.valueJson = valueJson;
    if (undoable != null) result.undoable = undoable;
    return result;
  }

  SetConfigJsonRequest._();

  factory SetConfigJsonRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetConfigJsonRequest()..mergeFromBuffer(data, registry);
  factory SetConfigJsonRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetConfigJsonRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetConfigJsonRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: SetConfigJsonRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'valueJson', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'undoable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetConfigJsonRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetConfigJsonRequest copyWith(void Function(SetConfigJsonRequest) updates) =>
      super.copyWith((message) => updates(message as SetConfigJsonRequest))
          as SetConfigJsonRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetConfigJsonRequest() / SetConfigJsonRequest.new instead')
  static SetConfigJsonRequest create() => SetConfigJsonRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetConfigJsonRequest._();
  @$core.override
  SetConfigJsonRequest createEmptyInstance() => SetConfigJsonRequest._();
  @$core.pragma('dart2js:noInline')
  static SetConfigJsonRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetConfigJsonRequest>(
          SetConfigJsonRequest.$_createMessage);
  static SetConfigJsonRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get valueJson => $_getN(1);
  @$pb.TagNumber(2)
  set valueJson($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValueJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueJson() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get undoable => $_getBF(2);
  @$pb.TagNumber(3)
  set undoable($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUndoable() => $_has(2);
  @$pb.TagNumber(3)
  void clearUndoable() => $_clearField(3);
}

class Preferences_Scheduling extends $pb.GeneratedMessage {
  factory Preferences_Scheduling({
    $core.int? rollover,
    $core.int? learnAheadSecs,
    Preferences_Scheduling_NewReviewMix? newReviewMix,
    $core.bool? newTimezone,
    $core.bool? dayLearnFirst,
  }) {
    final result = Preferences_Scheduling._();
    if (rollover != null) result.rollover = rollover;
    if (learnAheadSecs != null) result.learnAheadSecs = learnAheadSecs;
    if (newReviewMix != null) result.newReviewMix = newReviewMix;
    if (newTimezone != null) result.newTimezone = newTimezone;
    if (dayLearnFirst != null) result.dayLearnFirst = dayLearnFirst;
    return result;
  }

  Preferences_Scheduling._();

  factory Preferences_Scheduling.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_Scheduling()..mergeFromBuffer(data, registry);
  factory Preferences_Scheduling.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_Scheduling()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Preferences.Scheduling',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: Preferences_Scheduling.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'rollover', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'learnAheadSecs',
        fieldType: $pb.PbFieldType.OU3)
    ..aE<Preferences_Scheduling_NewReviewMix>(
        4, _omitFieldNames ? '' : 'newReviewMix',
        enumValues: Preferences_Scheduling_NewReviewMix.values)
    ..aOB(5, _omitFieldNames ? '' : 'newTimezone')
    ..aOB(6, _omitFieldNames ? '' : 'dayLearnFirst')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_Scheduling clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_Scheduling copyWith(
          void Function(Preferences_Scheduling) updates) =>
      super.copyWith((message) => updates(message as Preferences_Scheduling))
          as Preferences_Scheduling;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Preferences_Scheduling() / Preferences_Scheduling.new instead')
  static Preferences_Scheduling create() => Preferences_Scheduling._();
  static $pb.GeneratedMessage $_createMessage() => Preferences_Scheduling._();
  @$core.override
  Preferences_Scheduling createEmptyInstance() => Preferences_Scheduling._();
  @$core.pragma('dart2js:noInline')
  static Preferences_Scheduling getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Preferences_Scheduling>(
          Preferences_Scheduling.$_createMessage);
  static Preferences_Scheduling? _defaultInstance;

  @$pb.TagNumber(2)
  $core.int get rollover => $_getIZ(0);
  @$pb.TagNumber(2)
  set rollover($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasRollover() => $_has(0);
  @$pb.TagNumber(2)
  void clearRollover() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get learnAheadSecs => $_getIZ(1);
  @$pb.TagNumber(3)
  set learnAheadSecs($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasLearnAheadSecs() => $_has(1);
  @$pb.TagNumber(3)
  void clearLearnAheadSecs() => $_clearField(3);

  @$pb.TagNumber(4)
  Preferences_Scheduling_NewReviewMix get newReviewMix => $_getN(2);
  @$pb.TagNumber(4)
  set newReviewMix(Preferences_Scheduling_NewReviewMix value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasNewReviewMix() => $_has(2);
  @$pb.TagNumber(4)
  void clearNewReviewMix() => $_clearField(4);

  /// v2 only
  @$pb.TagNumber(5)
  $core.bool get newTimezone => $_getBF(3);
  @$pb.TagNumber(5)
  set newTimezone($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(5)
  $core.bool hasNewTimezone() => $_has(3);
  @$pb.TagNumber(5)
  void clearNewTimezone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get dayLearnFirst => $_getBF(4);
  @$pb.TagNumber(6)
  set dayLearnFirst($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(6)
  $core.bool hasDayLearnFirst() => $_has(4);
  @$pb.TagNumber(6)
  void clearDayLearnFirst() => $_clearField(6);
}

class Preferences_Reviewing extends $pb.GeneratedMessage {
  factory Preferences_Reviewing({
    $core.bool? hideAudioPlayButtons,
    $core.bool? interruptAudioWhenAnswering,
    $core.bool? showRemainingDueCounts,
    $core.bool? showIntervalsOnButtons,
    $core.int? timeLimitSecs,
    $core.bool? loadBalancerEnabled,
    $core.bool? fsrsShortTermWithStepsEnabled,
  }) {
    final result = Preferences_Reviewing._();
    if (hideAudioPlayButtons != null)
      result.hideAudioPlayButtons = hideAudioPlayButtons;
    if (interruptAudioWhenAnswering != null)
      result.interruptAudioWhenAnswering = interruptAudioWhenAnswering;
    if (showRemainingDueCounts != null)
      result.showRemainingDueCounts = showRemainingDueCounts;
    if (showIntervalsOnButtons != null)
      result.showIntervalsOnButtons = showIntervalsOnButtons;
    if (timeLimitSecs != null) result.timeLimitSecs = timeLimitSecs;
    if (loadBalancerEnabled != null)
      result.loadBalancerEnabled = loadBalancerEnabled;
    if (fsrsShortTermWithStepsEnabled != null)
      result.fsrsShortTermWithStepsEnabled = fsrsShortTermWithStepsEnabled;
    return result;
  }

  Preferences_Reviewing._();

  factory Preferences_Reviewing.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_Reviewing()..mergeFromBuffer(data, registry);
  factory Preferences_Reviewing.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_Reviewing()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Preferences.Reviewing',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: Preferences_Reviewing.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'hideAudioPlayButtons')
    ..aOB(2, _omitFieldNames ? '' : 'interruptAudioWhenAnswering')
    ..aOB(3, _omitFieldNames ? '' : 'showRemainingDueCounts')
    ..aOB(4, _omitFieldNames ? '' : 'showIntervalsOnButtons')
    ..aI(5, _omitFieldNames ? '' : 'timeLimitSecs',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(6, _omitFieldNames ? '' : 'loadBalancerEnabled')
    ..aOB(7, _omitFieldNames ? '' : 'fsrsShortTermWithStepsEnabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_Reviewing clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_Reviewing copyWith(
          void Function(Preferences_Reviewing) updates) =>
      super.copyWith((message) => updates(message as Preferences_Reviewing))
          as Preferences_Reviewing;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Preferences_Reviewing() / Preferences_Reviewing.new instead')
  static Preferences_Reviewing create() => Preferences_Reviewing._();
  static $pb.GeneratedMessage $_createMessage() => Preferences_Reviewing._();
  @$core.override
  Preferences_Reviewing createEmptyInstance() => Preferences_Reviewing._();
  @$core.pragma('dart2js:noInline')
  static Preferences_Reviewing getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Preferences_Reviewing>(
          Preferences_Reviewing.$_createMessage);
  static Preferences_Reviewing? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hideAudioPlayButtons => $_getBF(0);
  @$pb.TagNumber(1)
  set hideAudioPlayButtons($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHideAudioPlayButtons() => $_has(0);
  @$pb.TagNumber(1)
  void clearHideAudioPlayButtons() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get interruptAudioWhenAnswering => $_getBF(1);
  @$pb.TagNumber(2)
  set interruptAudioWhenAnswering($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInterruptAudioWhenAnswering() => $_has(1);
  @$pb.TagNumber(2)
  void clearInterruptAudioWhenAnswering() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get showRemainingDueCounts => $_getBF(2);
  @$pb.TagNumber(3)
  set showRemainingDueCounts($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasShowRemainingDueCounts() => $_has(2);
  @$pb.TagNumber(3)
  void clearShowRemainingDueCounts() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get showIntervalsOnButtons => $_getBF(3);
  @$pb.TagNumber(4)
  set showIntervalsOnButtons($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasShowIntervalsOnButtons() => $_has(3);
  @$pb.TagNumber(4)
  void clearShowIntervalsOnButtons() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get timeLimitSecs => $_getIZ(4);
  @$pb.TagNumber(5)
  set timeLimitSecs($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTimeLimitSecs() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimeLimitSecs() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get loadBalancerEnabled => $_getBF(5);
  @$pb.TagNumber(6)
  set loadBalancerEnabled($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLoadBalancerEnabled() => $_has(5);
  @$pb.TagNumber(6)
  void clearLoadBalancerEnabled() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get fsrsShortTermWithStepsEnabled => $_getBF(6);
  @$pb.TagNumber(7)
  set fsrsShortTermWithStepsEnabled($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFsrsShortTermWithStepsEnabled() => $_has(6);
  @$pb.TagNumber(7)
  void clearFsrsShortTermWithStepsEnabled() => $_clearField(7);
}

class Preferences_Editing extends $pb.GeneratedMessage {
  factory Preferences_Editing({
    $core.bool? addingDefaultsToCurrentDeck,
    $core.bool? pasteImagesAsPng,
    $core.bool? pasteStripsFormatting,
    $core.String? defaultSearchText,
    $core.bool? ignoreAccentsInSearch,
    $core.bool? renderLatex,
  }) {
    final result = Preferences_Editing._();
    if (addingDefaultsToCurrentDeck != null)
      result.addingDefaultsToCurrentDeck = addingDefaultsToCurrentDeck;
    if (pasteImagesAsPng != null) result.pasteImagesAsPng = pasteImagesAsPng;
    if (pasteStripsFormatting != null)
      result.pasteStripsFormatting = pasteStripsFormatting;
    if (defaultSearchText != null) result.defaultSearchText = defaultSearchText;
    if (ignoreAccentsInSearch != null)
      result.ignoreAccentsInSearch = ignoreAccentsInSearch;
    if (renderLatex != null) result.renderLatex = renderLatex;
    return result;
  }

  Preferences_Editing._();

  factory Preferences_Editing.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_Editing()..mergeFromBuffer(data, registry);
  factory Preferences_Editing.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_Editing()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Preferences.Editing',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: Preferences_Editing.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'addingDefaultsToCurrentDeck')
    ..aOB(2, _omitFieldNames ? '' : 'pasteImagesAsPng')
    ..aOB(3, _omitFieldNames ? '' : 'pasteStripsFormatting')
    ..aOS(4, _omitFieldNames ? '' : 'defaultSearchText')
    ..aOB(5, _omitFieldNames ? '' : 'ignoreAccentsInSearch')
    ..aOB(6, _omitFieldNames ? '' : 'renderLatex')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_Editing clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_Editing copyWith(void Function(Preferences_Editing) updates) =>
      super.copyWith((message) => updates(message as Preferences_Editing))
          as Preferences_Editing;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use Preferences_Editing() / Preferences_Editing.new instead')
  static Preferences_Editing create() => Preferences_Editing._();
  static $pb.GeneratedMessage $_createMessage() => Preferences_Editing._();
  @$core.override
  Preferences_Editing createEmptyInstance() => Preferences_Editing._();
  @$core.pragma('dart2js:noInline')
  static Preferences_Editing getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Preferences_Editing>(
          Preferences_Editing.$_createMessage);
  static Preferences_Editing? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get addingDefaultsToCurrentDeck => $_getBF(0);
  @$pb.TagNumber(1)
  set addingDefaultsToCurrentDeck($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddingDefaultsToCurrentDeck() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddingDefaultsToCurrentDeck() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get pasteImagesAsPng => $_getBF(1);
  @$pb.TagNumber(2)
  set pasteImagesAsPng($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPasteImagesAsPng() => $_has(1);
  @$pb.TagNumber(2)
  void clearPasteImagesAsPng() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get pasteStripsFormatting => $_getBF(2);
  @$pb.TagNumber(3)
  set pasteStripsFormatting($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPasteStripsFormatting() => $_has(2);
  @$pb.TagNumber(3)
  void clearPasteStripsFormatting() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get defaultSearchText => $_getSZ(3);
  @$pb.TagNumber(4)
  set defaultSearchText($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDefaultSearchText() => $_has(3);
  @$pb.TagNumber(4)
  void clearDefaultSearchText() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get ignoreAccentsInSearch => $_getBF(4);
  @$pb.TagNumber(5)
  set ignoreAccentsInSearch($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIgnoreAccentsInSearch() => $_has(4);
  @$pb.TagNumber(5)
  void clearIgnoreAccentsInSearch() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get renderLatex => $_getBF(5);
  @$pb.TagNumber(6)
  set renderLatex($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRenderLatex() => $_has(5);
  @$pb.TagNumber(6)
  void clearRenderLatex() => $_clearField(6);
}

class Preferences_BackupLimits extends $pb.GeneratedMessage {
  factory Preferences_BackupLimits({
    $core.int? daily,
    $core.int? weekly,
    $core.int? monthly,
    $core.int? minimumIntervalMins,
  }) {
    final result = Preferences_BackupLimits._();
    if (daily != null) result.daily = daily;
    if (weekly != null) result.weekly = weekly;
    if (monthly != null) result.monthly = monthly;
    if (minimumIntervalMins != null)
      result.minimumIntervalMins = minimumIntervalMins;
    return result;
  }

  Preferences_BackupLimits._();

  factory Preferences_BackupLimits.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_BackupLimits()..mergeFromBuffer(data, registry);
  factory Preferences_BackupLimits.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences_BackupLimits()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Preferences.BackupLimits',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: Preferences_BackupLimits.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'daily', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'weekly', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'monthly', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'minimumIntervalMins',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_BackupLimits clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences_BackupLimits copyWith(
          void Function(Preferences_BackupLimits) updates) =>
      super.copyWith((message) => updates(message as Preferences_BackupLimits))
          as Preferences_BackupLimits;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Preferences_BackupLimits() / Preferences_BackupLimits.new instead')
  static Preferences_BackupLimits create() => Preferences_BackupLimits._();
  static $pb.GeneratedMessage $_createMessage() => Preferences_BackupLimits._();
  @$core.override
  Preferences_BackupLimits createEmptyInstance() =>
      Preferences_BackupLimits._();
  @$core.pragma('dart2js:noInline')
  static Preferences_BackupLimits getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Preferences_BackupLimits>(
          Preferences_BackupLimits.$_createMessage);
  static Preferences_BackupLimits? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get daily => $_getIZ(0);
  @$pb.TagNumber(1)
  set daily($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDaily() => $_has(0);
  @$pb.TagNumber(1)
  void clearDaily() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get weekly => $_getIZ(1);
  @$pb.TagNumber(2)
  set weekly($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWeekly() => $_has(1);
  @$pb.TagNumber(2)
  void clearWeekly() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get monthly => $_getIZ(2);
  @$pb.TagNumber(3)
  set monthly($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMonthly() => $_has(2);
  @$pb.TagNumber(3)
  void clearMonthly() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get minimumIntervalMins => $_getIZ(3);
  @$pb.TagNumber(4)
  set minimumIntervalMins($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMinimumIntervalMins() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinimumIntervalMins() => $_clearField(4);
}

class Preferences extends $pb.GeneratedMessage {
  factory Preferences({
    Preferences_Scheduling? scheduling,
    Preferences_Reviewing? reviewing,
    Preferences_Editing? editing,
    Preferences_BackupLimits? backups,
  }) {
    final result = Preferences._();
    if (scheduling != null) result.scheduling = scheduling;
    if (reviewing != null) result.reviewing = reviewing;
    if (editing != null) result.editing = editing;
    if (backups != null) result.backups = backups;
    return result;
  }

  Preferences._();

  factory Preferences.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences()..mergeFromBuffer(data, registry);
  factory Preferences.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Preferences()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Preferences',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.config'),
      createEmptyInstance: Preferences.$_createMessage)
    ..aOM<Preferences_Scheduling>(1, _omitFieldNames ? '' : 'scheduling',
        subBuilder: Preferences_Scheduling.$_createMessage)
    ..aOM<Preferences_Reviewing>(2, _omitFieldNames ? '' : 'reviewing',
        subBuilder: Preferences_Reviewing.$_createMessage)
    ..aOM<Preferences_Editing>(3, _omitFieldNames ? '' : 'editing',
        subBuilder: Preferences_Editing.$_createMessage)
    ..aOM<Preferences_BackupLimits>(4, _omitFieldNames ? '' : 'backups',
        subBuilder: Preferences_BackupLimits.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences copyWith(void Function(Preferences) updates) =>
      super.copyWith((message) => updates(message as Preferences))
          as Preferences;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Preferences() / Preferences.new instead')
  static Preferences create() => Preferences._();
  static $pb.GeneratedMessage $_createMessage() => Preferences._();
  @$core.override
  Preferences createEmptyInstance() => Preferences._();
  @$core.pragma('dart2js:noInline')
  static Preferences getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Preferences>(
          Preferences.$_createMessage);
  static Preferences? _defaultInstance;

  @$pb.TagNumber(1)
  Preferences_Scheduling get scheduling => $_getN(0);
  @$pb.TagNumber(1)
  set scheduling(Preferences_Scheduling value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasScheduling() => $_has(0);
  @$pb.TagNumber(1)
  void clearScheduling() => $_clearField(1);
  @$pb.TagNumber(1)
  Preferences_Scheduling ensureScheduling() => $_ensure(0);

  @$pb.TagNumber(2)
  Preferences_Reviewing get reviewing => $_getN(1);
  @$pb.TagNumber(2)
  set reviewing(Preferences_Reviewing value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReviewing() => $_has(1);
  @$pb.TagNumber(2)
  void clearReviewing() => $_clearField(2);
  @$pb.TagNumber(2)
  Preferences_Reviewing ensureReviewing() => $_ensure(1);

  @$pb.TagNumber(3)
  Preferences_Editing get editing => $_getN(2);
  @$pb.TagNumber(3)
  set editing(Preferences_Editing value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEditing() => $_has(2);
  @$pb.TagNumber(3)
  void clearEditing() => $_clearField(3);
  @$pb.TagNumber(3)
  Preferences_Editing ensureEditing() => $_ensure(2);

  @$pb.TagNumber(4)
  Preferences_BackupLimits get backups => $_getN(3);
  @$pb.TagNumber(4)
  set backups(Preferences_BackupLimits value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasBackups() => $_has(3);
  @$pb.TagNumber(4)
  void clearBackups() => $_clearField(4);
  @$pb.TagNumber(4)
  Preferences_BackupLimits ensureBackups() => $_ensure(3);
}

class ConfigServiceApi {
  final $pb.RpcClient _client;

  ConfigServiceApi(this._client);

  $async.Future<$0.Json> getConfigJson(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$0.Json>(
          ctx, 'ConfigService', 'GetConfigJson', request, $0.Json());
  $async.Future<$1.OpChanges> setConfigJson(
          $pb.ClientContext? ctx, SetConfigJsonRequest request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'ConfigService', 'SetConfigJson', request, $1.OpChanges());
  $async.Future<$0.Empty> setConfigJsonNoUndo(
          $pb.ClientContext? ctx, SetConfigJsonRequest request) =>
      _client.invoke<$0.Empty>(
          ctx, 'ConfigService', 'SetConfigJsonNoUndo', request, $0.Empty());
  $async.Future<$1.OpChanges> removeConfig(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'ConfigService', 'RemoveConfig', request, $1.OpChanges());
  $async.Future<$0.Json> getAllConfig(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Json>(
          ctx, 'ConfigService', 'GetAllConfig', request, $0.Json());
  $async.Future<$0.Bool> getConfigBool(
          $pb.ClientContext? ctx, GetConfigBoolRequest request) =>
      _client.invoke<$0.Bool>(
          ctx, 'ConfigService', 'GetConfigBool', request, $0.Bool());
  $async.Future<$1.OpChanges> setConfigBool(
          $pb.ClientContext? ctx, SetConfigBoolRequest request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'ConfigService', 'SetConfigBool', request, $1.OpChanges());
  $async.Future<$0.String> getConfigString(
          $pb.ClientContext? ctx, GetConfigStringRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'ConfigService', 'GetConfigString', request, $0.String());
  $async.Future<$1.OpChanges> setConfigString(
          $pb.ClientContext? ctx, SetConfigStringRequest request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'ConfigService', 'SetConfigString', request, $1.OpChanges());
  $async.Future<Preferences> getPreferences(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<Preferences>(
          ctx, 'ConfigService', 'GetPreferences', request, Preferences());
  $async.Future<$1.OpChanges> setPreferences(
          $pb.ClientContext? ctx, Preferences request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'ConfigService', 'SetPreferences', request, $1.OpChanges());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendConfigServiceApi {
  final $pb.RpcClient _client;

  BackendConfigServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
