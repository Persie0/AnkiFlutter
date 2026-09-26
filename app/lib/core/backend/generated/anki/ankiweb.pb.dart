// This is a generated file - do not edit.
//
// Generated from anki/ankiweb.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetAddonInfoRequest extends $pb.GeneratedMessage {
  factory GetAddonInfoRequest({
    $core.int? clientVersion,
    $core.Iterable<$core.int>? addonIds,
  }) {
    final result = GetAddonInfoRequest._();
    if (clientVersion != null) result.clientVersion = clientVersion;
    if (addonIds != null) result.addonIds.addAll(addonIds);
    return result;
  }

  GetAddonInfoRequest._();

  factory GetAddonInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAddonInfoRequest()..mergeFromBuffer(data, registry);
  factory GetAddonInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAddonInfoRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAddonInfoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankiweb'),
      createEmptyInstance: GetAddonInfoRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'clientVersion',
        fieldType: $pb.PbFieldType.OU3)
    ..p<$core.int>(2, _omitFieldNames ? '' : 'addonIds', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAddonInfoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAddonInfoRequest copyWith(void Function(GetAddonInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetAddonInfoRequest))
          as GetAddonInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use GetAddonInfoRequest() / GetAddonInfoRequest.new instead')
  static GetAddonInfoRequest create() => GetAddonInfoRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetAddonInfoRequest._();
  @$core.override
  GetAddonInfoRequest createEmptyInstance() => GetAddonInfoRequest._();
  @$core.pragma('dart2js:noInline')
  static GetAddonInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAddonInfoRequest>(
          GetAddonInfoRequest.$_createMessage);
  static GetAddonInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get clientVersion => $_getIZ(0);
  @$pb.TagNumber(1)
  set clientVersion($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get addonIds => $_getList(1);
}

class GetAddonInfoResponse extends $pb.GeneratedMessage {
  factory GetAddonInfoResponse({
    $core.Iterable<AddonInfo>? info,
  }) {
    final result = GetAddonInfoResponse._();
    if (info != null) result.info.addAll(info);
    return result;
  }

  GetAddonInfoResponse._();

  factory GetAddonInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAddonInfoResponse()..mergeFromBuffer(data, registry);
  factory GetAddonInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetAddonInfoResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAddonInfoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankiweb'),
      createEmptyInstance: GetAddonInfoResponse.$_createMessage)
    ..pPM<AddonInfo>(1, _omitFieldNames ? '' : 'info',
        subBuilder: AddonInfo.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAddonInfoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAddonInfoResponse copyWith(void Function(GetAddonInfoResponse) updates) =>
      super.copyWith((message) => updates(message as GetAddonInfoResponse))
          as GetAddonInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetAddonInfoResponse() / GetAddonInfoResponse.new instead')
  static GetAddonInfoResponse create() => GetAddonInfoResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetAddonInfoResponse._();
  @$core.override
  GetAddonInfoResponse createEmptyInstance() => GetAddonInfoResponse._();
  @$core.pragma('dart2js:noInline')
  static GetAddonInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAddonInfoResponse>(
          GetAddonInfoResponse.$_createMessage);
  static GetAddonInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AddonInfo> get info => $_getList(0);
}

class AddonInfo extends $pb.GeneratedMessage {
  factory AddonInfo({
    $core.int? id,
    $fixnum.Int64? modified,
    $core.int? minVersion,
    $core.int? maxVersion,
  }) {
    final result = AddonInfo._();
    if (id != null) result.id = id;
    if (modified != null) result.modified = modified;
    if (minVersion != null) result.minVersion = minVersion;
    if (maxVersion != null) result.maxVersion = maxVersion;
    return result;
  }

  AddonInfo._();

  factory AddonInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddonInfo()..mergeFromBuffer(data, registry);
  factory AddonInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddonInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddonInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankiweb'),
      createEmptyInstance: AddonInfo.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'id', fieldType: $pb.PbFieldType.OU3)
    ..aInt64(2, _omitFieldNames ? '' : 'modified')
    ..aI(3, _omitFieldNames ? '' : 'minVersion', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'maxVersion', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddonInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddonInfo copyWith(void Function(AddonInfo) updates) =>
      super.copyWith((message) => updates(message as AddonInfo)) as AddonInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AddonInfo() / AddonInfo.new instead')
  static AddonInfo create() => AddonInfo._();
  static $pb.GeneratedMessage $_createMessage() => AddonInfo._();
  @$core.override
  AddonInfo createEmptyInstance() => AddonInfo._();
  @$core.pragma('dart2js:noInline')
  static AddonInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddonInfo>(AddonInfo.$_createMessage);
  static AddonInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get modified => $_getI64(1);
  @$pb.TagNumber(2)
  set modified($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasModified() => $_has(1);
  @$pb.TagNumber(2)
  void clearModified() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get minVersion => $_getIZ(2);
  @$pb.TagNumber(3)
  set minVersion($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinVersion() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get maxVersion => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxVersion($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxVersion() => $_clearField(4);
}

class CheckForUpdateRequest extends $pb.GeneratedMessage {
  factory CheckForUpdateRequest({
    $core.int? version,
    $core.String? buildhash,
    $core.String? os,
    $fixnum.Int64? installId,
    $core.int? lastMessageId,
  }) {
    final result = CheckForUpdateRequest._();
    if (version != null) result.version = version;
    if (buildhash != null) result.buildhash = buildhash;
    if (os != null) result.os = os;
    if (installId != null) result.installId = installId;
    if (lastMessageId != null) result.lastMessageId = lastMessageId;
    return result;
  }

  CheckForUpdateRequest._();

  factory CheckForUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckForUpdateRequest()..mergeFromBuffer(data, registry);
  factory CheckForUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckForUpdateRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckForUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankiweb'),
      createEmptyInstance: CheckForUpdateRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'version', fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'buildhash')
    ..aOS(3, _omitFieldNames ? '' : 'os')
    ..aInt64(4, _omitFieldNames ? '' : 'installId')
    ..aI(5, _omitFieldNames ? '' : 'lastMessageId',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckForUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckForUpdateRequest copyWith(
          void Function(CheckForUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as CheckForUpdateRequest))
          as CheckForUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckForUpdateRequest() / CheckForUpdateRequest.new instead')
  static CheckForUpdateRequest create() => CheckForUpdateRequest._();
  static $pb.GeneratedMessage $_createMessage() => CheckForUpdateRequest._();
  @$core.override
  CheckForUpdateRequest createEmptyInstance() => CheckForUpdateRequest._();
  @$core.pragma('dart2js:noInline')
  static CheckForUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckForUpdateRequest>(
          CheckForUpdateRequest.$_createMessage);
  static CheckForUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get buildhash => $_getSZ(1);
  @$pb.TagNumber(2)
  set buildhash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBuildhash() => $_has(1);
  @$pb.TagNumber(2)
  void clearBuildhash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get os => $_getSZ(2);
  @$pb.TagNumber(3)
  set os($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOs() => $_has(2);
  @$pb.TagNumber(3)
  void clearOs() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get installId => $_getI64(3);
  @$pb.TagNumber(4)
  set installId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstallId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstallId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get lastMessageId => $_getIZ(4);
  @$pb.TagNumber(5)
  set lastMessageId($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLastMessageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastMessageId() => $_clearField(5);
}

class CheckForUpdateResponse extends $pb.GeneratedMessage {
  factory CheckForUpdateResponse({
    $core.String? newVersion,
    $fixnum.Int64? currentTime,
    $core.String? message,
    $core.int? lastMessageId,
  }) {
    final result = CheckForUpdateResponse._();
    if (newVersion != null) result.newVersion = newVersion;
    if (currentTime != null) result.currentTime = currentTime;
    if (message != null) result.message = message;
    if (lastMessageId != null) result.lastMessageId = lastMessageId;
    return result;
  }

  CheckForUpdateResponse._();

  factory CheckForUpdateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckForUpdateResponse()..mergeFromBuffer(data, registry);
  factory CheckForUpdateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckForUpdateResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckForUpdateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankiweb'),
      createEmptyInstance: CheckForUpdateResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'newVersion')
    ..aInt64(2, _omitFieldNames ? '' : 'currentTime')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aI(4, _omitFieldNames ? '' : 'lastMessageId',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckForUpdateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckForUpdateResponse copyWith(
          void Function(CheckForUpdateResponse) updates) =>
      super.copyWith((message) => updates(message as CheckForUpdateResponse))
          as CheckForUpdateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckForUpdateResponse() / CheckForUpdateResponse.new instead')
  static CheckForUpdateResponse create() => CheckForUpdateResponse._();
  static $pb.GeneratedMessage $_createMessage() => CheckForUpdateResponse._();
  @$core.override
  CheckForUpdateResponse createEmptyInstance() => CheckForUpdateResponse._();
  @$core.pragma('dart2js:noInline')
  static CheckForUpdateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckForUpdateResponse>(
          CheckForUpdateResponse.$_createMessage);
  static CheckForUpdateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get newVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set newVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNewVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get currentTime => $_getI64(1);
  @$pb.TagNumber(2)
  set currentTime($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentTime() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get lastMessageId => $_getIZ(3);
  @$pb.TagNumber(4)
  set lastMessageId($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastMessageId() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastMessageId() => $_clearField(4);
}

class AnkiwebServiceApi {
  final $pb.RpcClient _client;

  AnkiwebServiceApi(this._client);
}

class BackendAnkiwebServiceApi {
  final $pb.RpcClient _client;

  BackendAnkiwebServiceApi(this._client);

  /// Fetch info on add-ons from AnkiWeb. A maximum of 25 can be queried at one
  /// time. If an add-on doesn't have a branch compatible with the provided
  /// version, that add-on will not be included in the returned list.
  $async.Future<GetAddonInfoResponse> getAddonInfo(
          $pb.ClientContext? ctx, GetAddonInfoRequest request) =>
      _client.invoke<GetAddonInfoResponse>(ctx, 'BackendAnkiwebService',
          'GetAddonInfo', request, GetAddonInfoResponse());
  $async.Future<CheckForUpdateResponse> checkForUpdate(
          $pb.ClientContext? ctx, CheckForUpdateRequest request) =>
      _client.invoke<CheckForUpdateResponse>(ctx, 'BackendAnkiwebService',
          'CheckForUpdate', request, CheckForUpdateResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
