// This is a generated file - do not edit.
//
// Generated from anki/sync.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'generic.pb.dart' as $0;
import 'sync.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'sync.pbenum.dart';

class SyncAuth extends $pb.GeneratedMessage {
  factory SyncAuth({
    $core.String? hkey,
    $core.String? endpoint,
    $core.int? ioTimeoutSecs,
  }) {
    final result = SyncAuth._();
    if (hkey != null) result.hkey = hkey;
    if (endpoint != null) result.endpoint = endpoint;
    if (ioTimeoutSecs != null) result.ioTimeoutSecs = ioTimeoutSecs;
    return result;
  }

  SyncAuth._();

  factory SyncAuth.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncAuth()..mergeFromBuffer(data, registry);
  factory SyncAuth.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncAuth()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncAuth',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: SyncAuth.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'hkey')
    ..aOS(2, _omitFieldNames ? '' : 'endpoint')
    ..aI(3, _omitFieldNames ? '' : 'ioTimeoutSecs',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncAuth clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncAuth copyWith(void Function(SyncAuth) updates) =>
      super.copyWith((message) => updates(message as SyncAuth)) as SyncAuth;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncAuth() / SyncAuth.new instead')
  static SyncAuth create() => SyncAuth._();
  static $pb.GeneratedMessage $_createMessage() => SyncAuth._();
  @$core.override
  SyncAuth createEmptyInstance() => SyncAuth._();
  @$core.pragma('dart2js:noInline')
  static SyncAuth getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncAuth>(SyncAuth.$_createMessage);
  static SyncAuth? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hkey => $_getSZ(0);
  @$pb.TagNumber(1)
  set hkey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearHkey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endpoint => $_getSZ(1);
  @$pb.TagNumber(2)
  set endpoint($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndpoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndpoint() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ioTimeoutSecs => $_getIZ(2);
  @$pb.TagNumber(3)
  set ioTimeoutSecs($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIoTimeoutSecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearIoTimeoutSecs() => $_clearField(3);
}

class SyncLoginRequest extends $pb.GeneratedMessage {
  factory SyncLoginRequest({
    $core.String? username,
    $core.String? password,
    $core.String? endpoint,
  }) {
    final result = SyncLoginRequest._();
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    if (endpoint != null) result.endpoint = endpoint;
    return result;
  }

  SyncLoginRequest._();

  factory SyncLoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncLoginRequest()..mergeFromBuffer(data, registry);
  factory SyncLoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncLoginRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncLoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: SyncLoginRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOS(3, _omitFieldNames ? '' : 'endpoint')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncLoginRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncLoginRequest copyWith(void Function(SyncLoginRequest) updates) =>
      super.copyWith((message) => updates(message as SyncLoginRequest))
          as SyncLoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncLoginRequest() / SyncLoginRequest.new instead')
  static SyncLoginRequest create() => SyncLoginRequest._();
  static $pb.GeneratedMessage $_createMessage() => SyncLoginRequest._();
  @$core.override
  SyncLoginRequest createEmptyInstance() => SyncLoginRequest._();
  @$core.pragma('dart2js:noInline')
  static SyncLoginRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncLoginRequest>(
          SyncLoginRequest.$_createMessage);
  static SyncLoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get endpoint => $_getSZ(2);
  @$pb.TagNumber(3)
  set endpoint($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEndpoint() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndpoint() => $_clearField(3);
}

class SyncStatusResponse extends $pb.GeneratedMessage {
  factory SyncStatusResponse({
    SyncStatusResponse_Required? required,
    $core.String? newEndpoint,
  }) {
    final result = SyncStatusResponse._();
    if (required != null) result.required = required;
    if (newEndpoint != null) result.newEndpoint = newEndpoint;
    return result;
  }

  SyncStatusResponse._();

  factory SyncStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncStatusResponse()..mergeFromBuffer(data, registry);
  factory SyncStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncStatusResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: SyncStatusResponse.$_createMessage)
    ..aE<SyncStatusResponse_Required>(1, _omitFieldNames ? '' : 'required',
        enumValues: SyncStatusResponse_Required.values)
    ..aOS(4, _omitFieldNames ? '' : 'newEndpoint')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncStatusResponse copyWith(void Function(SyncStatusResponse) updates) =>
      super.copyWith((message) => updates(message as SyncStatusResponse))
          as SyncStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncStatusResponse() / SyncStatusResponse.new instead')
  static SyncStatusResponse create() => SyncStatusResponse._();
  static $pb.GeneratedMessage $_createMessage() => SyncStatusResponse._();
  @$core.override
  SyncStatusResponse createEmptyInstance() => SyncStatusResponse._();
  @$core.pragma('dart2js:noInline')
  static SyncStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncStatusResponse>(
          SyncStatusResponse.$_createMessage);
  static SyncStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SyncStatusResponse_Required get required => $_getN(0);
  @$pb.TagNumber(1)
  set required(SyncStatusResponse_Required value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequired() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequired() => $_clearField(1);

  @$pb.TagNumber(4)
  $core.String get newEndpoint => $_getSZ(1);
  @$pb.TagNumber(4)
  set newEndpoint($core.String value) => $_setString(1, value);
  @$pb.TagNumber(4)
  $core.bool hasNewEndpoint() => $_has(1);
  @$pb.TagNumber(4)
  void clearNewEndpoint() => $_clearField(4);
}

class SyncCollectionRequest extends $pb.GeneratedMessage {
  factory SyncCollectionRequest({
    SyncAuth? auth,
    $core.bool? syncMedia,
  }) {
    final result = SyncCollectionRequest._();
    if (auth != null) result.auth = auth;
    if (syncMedia != null) result.syncMedia = syncMedia;
    return result;
  }

  SyncCollectionRequest._();

  factory SyncCollectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncCollectionRequest()..mergeFromBuffer(data, registry);
  factory SyncCollectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncCollectionRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncCollectionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: SyncCollectionRequest.$_createMessage)
    ..aOM<SyncAuth>(1, _omitFieldNames ? '' : 'auth',
        subBuilder: SyncAuth.$_createMessage)
    ..aOB(2, _omitFieldNames ? '' : 'syncMedia')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncCollectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncCollectionRequest copyWith(
          void Function(SyncCollectionRequest) updates) =>
      super.copyWith((message) => updates(message as SyncCollectionRequest))
          as SyncCollectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SyncCollectionRequest() / SyncCollectionRequest.new instead')
  static SyncCollectionRequest create() => SyncCollectionRequest._();
  static $pb.GeneratedMessage $_createMessage() => SyncCollectionRequest._();
  @$core.override
  SyncCollectionRequest createEmptyInstance() => SyncCollectionRequest._();
  @$core.pragma('dart2js:noInline')
  static SyncCollectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncCollectionRequest>(
          SyncCollectionRequest.$_createMessage);
  static SyncCollectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SyncAuth get auth => $_getN(0);
  @$pb.TagNumber(1)
  set auth(SyncAuth value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAuth() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuth() => $_clearField(1);
  @$pb.TagNumber(1)
  SyncAuth ensureAuth() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get syncMedia => $_getBF(1);
  @$pb.TagNumber(2)
  set syncMedia($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSyncMedia() => $_has(1);
  @$pb.TagNumber(2)
  void clearSyncMedia() => $_clearField(2);
}

class SyncCollectionResponse extends $pb.GeneratedMessage {
  factory SyncCollectionResponse({
    $core.int? hostNumber,
    $core.String? serverMessage,
    SyncCollectionResponse_ChangesRequired? required,
    $core.String? newEndpoint,
    $core.int? serverMediaUsn,
  }) {
    final result = SyncCollectionResponse._();
    if (hostNumber != null) result.hostNumber = hostNumber;
    if (serverMessage != null) result.serverMessage = serverMessage;
    if (required != null) result.required = required;
    if (newEndpoint != null) result.newEndpoint = newEndpoint;
    if (serverMediaUsn != null) result.serverMediaUsn = serverMediaUsn;
    return result;
  }

  SyncCollectionResponse._();

  factory SyncCollectionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncCollectionResponse()..mergeFromBuffer(data, registry);
  factory SyncCollectionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncCollectionResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncCollectionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: SyncCollectionResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'hostNumber', fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'serverMessage')
    ..aE<SyncCollectionResponse_ChangesRequired>(
        3, _omitFieldNames ? '' : 'required',
        enumValues: SyncCollectionResponse_ChangesRequired.values)
    ..aOS(4, _omitFieldNames ? '' : 'newEndpoint')
    ..aI(5, _omitFieldNames ? '' : 'serverMediaUsn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncCollectionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncCollectionResponse copyWith(
          void Function(SyncCollectionResponse) updates) =>
      super.copyWith((message) => updates(message as SyncCollectionResponse))
          as SyncCollectionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SyncCollectionResponse() / SyncCollectionResponse.new instead')
  static SyncCollectionResponse create() => SyncCollectionResponse._();
  static $pb.GeneratedMessage $_createMessage() => SyncCollectionResponse._();
  @$core.override
  SyncCollectionResponse createEmptyInstance() => SyncCollectionResponse._();
  @$core.pragma('dart2js:noInline')
  static SyncCollectionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncCollectionResponse>(
          SyncCollectionResponse.$_createMessage);
  static SyncCollectionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get hostNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set hostNumber($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHostNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearHostNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get serverMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set serverMessage($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServerMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  SyncCollectionResponse_ChangesRequired get required => $_getN(2);
  @$pb.TagNumber(3)
  set required(SyncCollectionResponse_ChangesRequired value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRequired() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequired() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get newEndpoint => $_getSZ(3);
  @$pb.TagNumber(4)
  set newEndpoint($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewEndpoint() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewEndpoint() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get serverMediaUsn => $_getIZ(4);
  @$pb.TagNumber(5)
  set serverMediaUsn($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasServerMediaUsn() => $_has(4);
  @$pb.TagNumber(5)
  void clearServerMediaUsn() => $_clearField(5);
}

class MediaSyncStatusResponse extends $pb.GeneratedMessage {
  factory MediaSyncStatusResponse({
    $core.bool? active,
    MediaSyncProgress? progress,
  }) {
    final result = MediaSyncStatusResponse._();
    if (active != null) result.active = active;
    if (progress != null) result.progress = progress;
    return result;
  }

  MediaSyncStatusResponse._();

  factory MediaSyncStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaSyncStatusResponse()..mergeFromBuffer(data, registry);
  factory MediaSyncStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaSyncStatusResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaSyncStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: MediaSyncStatusResponse.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'active')
    ..aOM<MediaSyncProgress>(2, _omitFieldNames ? '' : 'progress',
        subBuilder: MediaSyncProgress.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaSyncStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaSyncStatusResponse copyWith(
          void Function(MediaSyncStatusResponse) updates) =>
      super.copyWith((message) => updates(message as MediaSyncStatusResponse))
          as MediaSyncStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use MediaSyncStatusResponse() / MediaSyncStatusResponse.new instead')
  static MediaSyncStatusResponse create() => MediaSyncStatusResponse._();
  static $pb.GeneratedMessage $_createMessage() => MediaSyncStatusResponse._();
  @$core.override
  MediaSyncStatusResponse createEmptyInstance() => MediaSyncStatusResponse._();
  @$core.pragma('dart2js:noInline')
  static MediaSyncStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaSyncStatusResponse>(
          MediaSyncStatusResponse.$_createMessage);
  static MediaSyncStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get active => $_getBF(0);
  @$pb.TagNumber(1)
  set active($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActive() => $_has(0);
  @$pb.TagNumber(1)
  void clearActive() => $_clearField(1);

  @$pb.TagNumber(2)
  MediaSyncProgress get progress => $_getN(1);
  @$pb.TagNumber(2)
  set progress(MediaSyncProgress value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => $_clearField(2);
  @$pb.TagNumber(2)
  MediaSyncProgress ensureProgress() => $_ensure(1);
}

class MediaSyncProgress extends $pb.GeneratedMessage {
  factory MediaSyncProgress({
    $core.String? checked,
    $core.String? added,
    $core.String? removed,
  }) {
    final result = MediaSyncProgress._();
    if (checked != null) result.checked = checked;
    if (added != null) result.added = added;
    if (removed != null) result.removed = removed;
    return result;
  }

  MediaSyncProgress._();

  factory MediaSyncProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaSyncProgress()..mergeFromBuffer(data, registry);
  factory MediaSyncProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaSyncProgress()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaSyncProgress',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: MediaSyncProgress.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'checked')
    ..aOS(2, _omitFieldNames ? '' : 'added')
    ..aOS(3, _omitFieldNames ? '' : 'removed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaSyncProgress clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaSyncProgress copyWith(void Function(MediaSyncProgress) updates) =>
      super.copyWith((message) => updates(message as MediaSyncProgress))
          as MediaSyncProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MediaSyncProgress() / MediaSyncProgress.new instead')
  static MediaSyncProgress create() => MediaSyncProgress._();
  static $pb.GeneratedMessage $_createMessage() => MediaSyncProgress._();
  @$core.override
  MediaSyncProgress createEmptyInstance() => MediaSyncProgress._();
  @$core.pragma('dart2js:noInline')
  static MediaSyncProgress getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaSyncProgress>(
          MediaSyncProgress.$_createMessage);
  static MediaSyncProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get checked => $_getSZ(0);
  @$pb.TagNumber(1)
  set checked($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChecked() => $_has(0);
  @$pb.TagNumber(1)
  void clearChecked() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get added => $_getSZ(1);
  @$pb.TagNumber(2)
  set added($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAdded() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdded() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get removed => $_getSZ(2);
  @$pb.TagNumber(3)
  set removed($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRemoved() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemoved() => $_clearField(3);
}

class FullUploadOrDownloadRequest extends $pb.GeneratedMessage {
  factory FullUploadOrDownloadRequest({
    SyncAuth? auth,
    $core.bool? upload,
    $core.int? serverUsn,
  }) {
    final result = FullUploadOrDownloadRequest._();
    if (auth != null) result.auth = auth;
    if (upload != null) result.upload = upload;
    if (serverUsn != null) result.serverUsn = serverUsn;
    return result;
  }

  FullUploadOrDownloadRequest._();

  factory FullUploadOrDownloadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FullUploadOrDownloadRequest()..mergeFromBuffer(data, registry);
  factory FullUploadOrDownloadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FullUploadOrDownloadRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FullUploadOrDownloadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.sync'),
      createEmptyInstance: FullUploadOrDownloadRequest.$_createMessage)
    ..aOM<SyncAuth>(1, _omitFieldNames ? '' : 'auth',
        subBuilder: SyncAuth.$_createMessage)
    ..aOB(2, _omitFieldNames ? '' : 'upload')
    ..aI(3, _omitFieldNames ? '' : 'serverUsn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FullUploadOrDownloadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FullUploadOrDownloadRequest copyWith(
          void Function(FullUploadOrDownloadRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FullUploadOrDownloadRequest))
          as FullUploadOrDownloadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FullUploadOrDownloadRequest() / FullUploadOrDownloadRequest.new instead')
  static FullUploadOrDownloadRequest create() =>
      FullUploadOrDownloadRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      FullUploadOrDownloadRequest._();
  @$core.override
  FullUploadOrDownloadRequest createEmptyInstance() =>
      FullUploadOrDownloadRequest._();
  @$core.pragma('dart2js:noInline')
  static FullUploadOrDownloadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FullUploadOrDownloadRequest>(
          FullUploadOrDownloadRequest.$_createMessage);
  static FullUploadOrDownloadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SyncAuth get auth => $_getN(0);
  @$pb.TagNumber(1)
  set auth(SyncAuth value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAuth() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuth() => $_clearField(1);
  @$pb.TagNumber(1)
  SyncAuth ensureAuth() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get upload => $_getBF(1);
  @$pb.TagNumber(2)
  set upload($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUpload() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpload() => $_clearField(2);

  /// if not provided, media syncing will be skipped
  @$pb.TagNumber(3)
  $core.int get serverUsn => $_getIZ(2);
  @$pb.TagNumber(3)
  set serverUsn($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServerUsn() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerUsn() => $_clearField(3);
}

/// Syncing methods are only available with a Backend handle.
class SyncServiceApi {
  final $pb.RpcClient _client;

  SyncServiceApi(this._client);
}

class BackendSyncServiceApi {
  final $pb.RpcClient _client;

  BackendSyncServiceApi(this._client);

  $async.Future<$0.Empty> syncMedia($pb.ClientContext? ctx, SyncAuth request) =>
      _client.invoke<$0.Empty>(
          ctx, 'BackendSyncService', 'SyncMedia', request, $0.Empty());
  $async.Future<$0.Empty> abortMediaSync(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(
          ctx, 'BackendSyncService', 'AbortMediaSync', request, $0.Empty());

  /// Can be used by the frontend to detect an active sync. If the sync aborted
  /// with an error, the next call to this method will return the error.
  $async.Future<MediaSyncStatusResponse> mediaSyncStatus(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<MediaSyncStatusResponse>(ctx, 'BackendSyncService',
          'MediaSyncStatus', request, MediaSyncStatusResponse());
  $async.Future<SyncAuth> syncLogin(
          $pb.ClientContext? ctx, SyncLoginRequest request) =>
      _client.invoke<SyncAuth>(
          ctx, 'BackendSyncService', 'SyncLogin', request, SyncAuth());
  $async.Future<SyncStatusResponse> syncStatus(
          $pb.ClientContext? ctx, SyncAuth request) =>
      _client.invoke<SyncStatusResponse>(ctx, 'BackendSyncService',
          'SyncStatus', request, SyncStatusResponse());
  $async.Future<SyncCollectionResponse> syncCollection(
          $pb.ClientContext? ctx, SyncCollectionRequest request) =>
      _client.invoke<SyncCollectionResponse>(ctx, 'BackendSyncService',
          'SyncCollection', request, SyncCollectionResponse());
  $async.Future<$0.Empty> fullUploadOrDownload(
          $pb.ClientContext? ctx, FullUploadOrDownloadRequest request) =>
      _client.invoke<$0.Empty>(ctx, 'BackendSyncService',
          'FullUploadOrDownload', request, $0.Empty());
  $async.Future<$0.Empty> abortSync($pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(
          ctx, 'BackendSyncService', 'AbortSync', request, $0.Empty());
  $async.Future<$0.Bool> setCustomCertificate(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$0.Bool>(ctx, 'BackendSyncService', 'SetCustomCertificate',
          request, $0.Bool());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
