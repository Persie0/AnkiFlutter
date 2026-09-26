// This is a generated file - do not edit.
//
// Generated from anki/media.proto.

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

import 'generic.pb.dart' as $0;
import 'notetypes.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CheckMediaResponse extends $pb.GeneratedMessage {
  factory CheckMediaResponse({
    $core.Iterable<$core.String>? unused,
    $core.Iterable<$core.String>? missing,
    $core.Iterable<$fixnum.Int64>? missingMediaNotes,
    $core.String? report,
    $core.bool? haveTrash,
  }) {
    final result = CheckMediaResponse._();
    if (unused != null) result.unused.addAll(unused);
    if (missing != null) result.missing.addAll(missing);
    if (missingMediaNotes != null)
      result.missingMediaNotes.addAll(missingMediaNotes);
    if (report != null) result.report = report;
    if (haveTrash != null) result.haveTrash = haveTrash;
    return result;
  }

  CheckMediaResponse._();

  factory CheckMediaResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckMediaResponse()..mergeFromBuffer(data, registry);
  factory CheckMediaResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckMediaResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckMediaResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.media'),
      createEmptyInstance: CheckMediaResponse.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'unused')
    ..pPS(2, _omitFieldNames ? '' : 'missing')
    ..p<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'missingMediaNotes', $pb.PbFieldType.K6)
    ..aOS(4, _omitFieldNames ? '' : 'report')
    ..aOB(5, _omitFieldNames ? '' : 'haveTrash')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckMediaResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckMediaResponse copyWith(void Function(CheckMediaResponse) updates) =>
      super.copyWith((message) => updates(message as CheckMediaResponse))
          as CheckMediaResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CheckMediaResponse() / CheckMediaResponse.new instead')
  static CheckMediaResponse create() => CheckMediaResponse._();
  static $pb.GeneratedMessage $_createMessage() => CheckMediaResponse._();
  @$core.override
  CheckMediaResponse createEmptyInstance() => CheckMediaResponse._();
  @$core.pragma('dart2js:noInline')
  static CheckMediaResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckMediaResponse>(
          CheckMediaResponse.$_createMessage);
  static CheckMediaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get unused => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get missing => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$fixnum.Int64> get missingMediaNotes => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get report => $_getSZ(3);
  @$pb.TagNumber(4)
  set report($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReport() => $_has(3);
  @$pb.TagNumber(4)
  void clearReport() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get haveTrash => $_getBF(4);
  @$pb.TagNumber(5)
  set haveTrash($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHaveTrash() => $_has(4);
  @$pb.TagNumber(5)
  void clearHaveTrash() => $_clearField(5);
}

class TrashMediaFilesRequest extends $pb.GeneratedMessage {
  factory TrashMediaFilesRequest({
    $core.Iterable<$core.String>? fnames,
  }) {
    final result = TrashMediaFilesRequest._();
    if (fnames != null) result.fnames.addAll(fnames);
    return result;
  }

  TrashMediaFilesRequest._();

  factory TrashMediaFilesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TrashMediaFilesRequest()..mergeFromBuffer(data, registry);
  factory TrashMediaFilesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TrashMediaFilesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrashMediaFilesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.media'),
      createEmptyInstance: TrashMediaFilesRequest.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'fnames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrashMediaFilesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrashMediaFilesRequest copyWith(
          void Function(TrashMediaFilesRequest) updates) =>
      super.copyWith((message) => updates(message as TrashMediaFilesRequest))
          as TrashMediaFilesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use TrashMediaFilesRequest() / TrashMediaFilesRequest.new instead')
  static TrashMediaFilesRequest create() => TrashMediaFilesRequest._();
  static $pb.GeneratedMessage $_createMessage() => TrashMediaFilesRequest._();
  @$core.override
  TrashMediaFilesRequest createEmptyInstance() => TrashMediaFilesRequest._();
  @$core.pragma('dart2js:noInline')
  static TrashMediaFilesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrashMediaFilesRequest>(
          TrashMediaFilesRequest.$_createMessage);
  static TrashMediaFilesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get fnames => $_getList(0);
}

class AddMediaFileRequest extends $pb.GeneratedMessage {
  factory AddMediaFileRequest({
    $core.String? desiredName,
    $core.List<$core.int>? data,
  }) {
    final result = AddMediaFileRequest._();
    if (desiredName != null) result.desiredName = desiredName;
    if (data != null) result.data = data;
    return result;
  }

  AddMediaFileRequest._();

  factory AddMediaFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFileRequest()..mergeFromBuffer(data, registry);
  factory AddMediaFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFileRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMediaFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.media'),
      createEmptyInstance: AddMediaFileRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'desiredName')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFileRequest copyWith(void Function(AddMediaFileRequest) updates) =>
      super.copyWith((message) => updates(message as AddMediaFileRequest))
          as AddMediaFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use AddMediaFileRequest() / AddMediaFileRequest.new instead')
  static AddMediaFileRequest create() => AddMediaFileRequest._();
  static $pb.GeneratedMessage $_createMessage() => AddMediaFileRequest._();
  @$core.override
  AddMediaFileRequest createEmptyInstance() => AddMediaFileRequest._();
  @$core.pragma('dart2js:noInline')
  static AddMediaFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMediaFileRequest>(
          AddMediaFileRequest.$_createMessage);
  static AddMediaFileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get desiredName => $_getSZ(0);
  @$pb.TagNumber(1)
  set desiredName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDesiredName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDesiredName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
}

class AddMediaFromPathRequest extends $pb.GeneratedMessage {
  factory AddMediaFromPathRequest({
    $core.String? path,
  }) {
    final result = AddMediaFromPathRequest._();
    if (path != null) result.path = path;
    return result;
  }

  AddMediaFromPathRequest._();

  factory AddMediaFromPathRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFromPathRequest()..mergeFromBuffer(data, registry);
  factory AddMediaFromPathRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFromPathRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMediaFromPathRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.media'),
      createEmptyInstance: AddMediaFromPathRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFromPathRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFromPathRequest copyWith(
          void Function(AddMediaFromPathRequest) updates) =>
      super.copyWith((message) => updates(message as AddMediaFromPathRequest))
          as AddMediaFromPathRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AddMediaFromPathRequest() / AddMediaFromPathRequest.new instead')
  static AddMediaFromPathRequest create() => AddMediaFromPathRequest._();
  static $pb.GeneratedMessage $_createMessage() => AddMediaFromPathRequest._();
  @$core.override
  AddMediaFromPathRequest createEmptyInstance() => AddMediaFromPathRequest._();
  @$core.pragma('dart2js:noInline')
  static AddMediaFromPathRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMediaFromPathRequest>(
          AddMediaFromPathRequest.$_createMessage);
  static AddMediaFromPathRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => $_clearField(1);
}

class AddMediaFromUrlRequest extends $pb.GeneratedMessage {
  factory AddMediaFromUrlRequest({
    $core.String? url,
  }) {
    final result = AddMediaFromUrlRequest._();
    if (url != null) result.url = url;
    return result;
  }

  AddMediaFromUrlRequest._();

  factory AddMediaFromUrlRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFromUrlRequest()..mergeFromBuffer(data, registry);
  factory AddMediaFromUrlRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFromUrlRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMediaFromUrlRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.media'),
      createEmptyInstance: AddMediaFromUrlRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFromUrlRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFromUrlRequest copyWith(
          void Function(AddMediaFromUrlRequest) updates) =>
      super.copyWith((message) => updates(message as AddMediaFromUrlRequest))
          as AddMediaFromUrlRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AddMediaFromUrlRequest() / AddMediaFromUrlRequest.new instead')
  static AddMediaFromUrlRequest create() => AddMediaFromUrlRequest._();
  static $pb.GeneratedMessage $_createMessage() => AddMediaFromUrlRequest._();
  @$core.override
  AddMediaFromUrlRequest createEmptyInstance() => AddMediaFromUrlRequest._();
  @$core.pragma('dart2js:noInline')
  static AddMediaFromUrlRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMediaFromUrlRequest>(
          AddMediaFromUrlRequest.$_createMessage);
  static AddMediaFromUrlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);
}

class AddMediaFromUrlResponse extends $pb.GeneratedMessage {
  factory AddMediaFromUrlResponse({
    $core.String? filename,
    $core.String? error,
  }) {
    final result = AddMediaFromUrlResponse._();
    if (filename != null) result.filename = filename;
    if (error != null) result.error = error;
    return result;
  }

  AddMediaFromUrlResponse._();

  factory AddMediaFromUrlResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFromUrlResponse()..mergeFromBuffer(data, registry);
  factory AddMediaFromUrlResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMediaFromUrlResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMediaFromUrlResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.media'),
      createEmptyInstance: AddMediaFromUrlResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'filename')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFromUrlResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMediaFromUrlResponse copyWith(
          void Function(AddMediaFromUrlResponse) updates) =>
      super.copyWith((message) => updates(message as AddMediaFromUrlResponse))
          as AddMediaFromUrlResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AddMediaFromUrlResponse() / AddMediaFromUrlResponse.new instead')
  static AddMediaFromUrlResponse create() => AddMediaFromUrlResponse._();
  static $pb.GeneratedMessage $_createMessage() => AddMediaFromUrlResponse._();
  @$core.override
  AddMediaFromUrlResponse createEmptyInstance() => AddMediaFromUrlResponse._();
  @$core.pragma('dart2js:noInline')
  static AddMediaFromUrlResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMediaFromUrlResponse>(
          AddMediaFromUrlResponse.$_createMessage);
  static AddMediaFromUrlResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get filename => $_getSZ(0);
  @$pb.TagNumber(1)
  set filename($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFilename() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilename() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class MediaServiceApi {
  final $pb.RpcClient _client;

  MediaServiceApi(this._client);

  $async.Future<CheckMediaResponse> checkMedia(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<CheckMediaResponse>(
          ctx, 'MediaService', 'CheckMedia', request, CheckMediaResponse());
  $async.Future<$0.String> addMediaFile(
          $pb.ClientContext? ctx, AddMediaFileRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'MediaService', 'AddMediaFile', request, $0.String());
  $async.Future<$0.String> addMediaFromPath(
          $pb.ClientContext? ctx, AddMediaFromPathRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'MediaService', 'AddMediaFromPath', request, $0.String());
  $async.Future<$0.Empty> trashMediaFiles(
          $pb.ClientContext? ctx, TrashMediaFilesRequest request) =>
      _client.invoke<$0.Empty>(
          ctx, 'MediaService', 'TrashMediaFiles', request, $0.Empty());
  $async.Future<$0.Empty> emptyTrash(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(
          ctx, 'MediaService', 'EmptyTrash', request, $0.Empty());
  $async.Future<$0.Empty> restoreTrash(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(
          ctx, 'MediaService', 'RestoreTrash', request, $0.Empty());
  $async.Future<$0.StringList> extractStaticMediaFiles(
          $pb.ClientContext? ctx, $1.NotetypeId request) =>
      _client.invoke<$0.StringList>(ctx, 'MediaService',
          'ExtractStaticMediaFiles', request, $0.StringList());
  $async.Future<$0.StringList> extractMediaFiles(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$0.StringList>(
          ctx, 'MediaService', 'ExtractMediaFiles', request, $0.StringList());
  $async.Future<$0.String> getAbsoluteMediaPath(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$0.String>(
          ctx, 'MediaService', 'GetAbsoluteMediaPath', request, $0.String());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendMediaServiceApi {
  final $pb.RpcClient _client;

  BackendMediaServiceApi(this._client);

  $async.Future<AddMediaFromUrlResponse> addMediaFromUrl(
          $pb.ClientContext? ctx, AddMediaFromUrlRequest request) =>
      _client.invoke<AddMediaFromUrlResponse>(ctx, 'BackendMediaService',
          'AddMediaFromUrl', request, AddMediaFromUrlResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
