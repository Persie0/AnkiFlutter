// This is a generated file - do not edit.
//
// Generated from anki/github.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class LatestReleaseRequest extends $pb.GeneratedMessage {
  factory LatestReleaseRequest({
    $core.bool? includePrerelease,
  }) {
    final result = LatestReleaseRequest._();
    if (includePrerelease != null) result.includePrerelease = includePrerelease;
    return result;
  }

  LatestReleaseRequest._();

  factory LatestReleaseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LatestReleaseRequest()..mergeFromBuffer(data, registry);
  factory LatestReleaseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LatestReleaseRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LatestReleaseRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.github'),
      createEmptyInstance: LatestReleaseRequest.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'includePrerelease')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LatestReleaseRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LatestReleaseRequest copyWith(void Function(LatestReleaseRequest) updates) =>
      super.copyWith((message) => updates(message as LatestReleaseRequest))
          as LatestReleaseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use LatestReleaseRequest() / LatestReleaseRequest.new instead')
  static LatestReleaseRequest create() => LatestReleaseRequest._();
  static $pb.GeneratedMessage $_createMessage() => LatestReleaseRequest._();
  @$core.override
  LatestReleaseRequest createEmptyInstance() => LatestReleaseRequest._();
  @$core.pragma('dart2js:noInline')
  static LatestReleaseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LatestReleaseRequest>(
          LatestReleaseRequest.$_createMessage);
  static LatestReleaseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get includePrerelease => $_getBF(0);
  @$pb.TagNumber(1)
  set includePrerelease($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIncludePrerelease() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncludePrerelease() => $_clearField(1);
}

class GithubRelease extends $pb.GeneratedMessage {
  factory GithubRelease({
    $core.String? tagName,
    $core.String? filename,
    $core.String? url,
    $core.String? checksum,
  }) {
    final result = GithubRelease._();
    if (tagName != null) result.tagName = tagName;
    if (filename != null) result.filename = filename;
    if (url != null) result.url = url;
    if (checksum != null) result.checksum = checksum;
    return result;
  }

  GithubRelease._();

  factory GithubRelease.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GithubRelease()..mergeFromBuffer(data, registry);
  factory GithubRelease.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GithubRelease()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GithubRelease',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.github'),
      createEmptyInstance: GithubRelease.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'tagName')
    ..aOS(2, _omitFieldNames ? '' : 'filename')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOS(4, _omitFieldNames ? '' : 'checksum')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GithubRelease clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GithubRelease copyWith(void Function(GithubRelease) updates) =>
      super.copyWith((message) => updates(message as GithubRelease))
          as GithubRelease;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GithubRelease() / GithubRelease.new instead')
  static GithubRelease create() => GithubRelease._();
  static $pb.GeneratedMessage $_createMessage() => GithubRelease._();
  @$core.override
  GithubRelease createEmptyInstance() => GithubRelease._();
  @$core.pragma('dart2js:noInline')
  static GithubRelease getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GithubRelease>(
          GithubRelease.$_createMessage);
  static GithubRelease? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tagName => $_getSZ(0);
  @$pb.TagNumber(1)
  set tagName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTagName() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get checksum => $_getSZ(3);
  @$pb.TagNumber(4)
  set checksum($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChecksum() => $_has(3);
  @$pb.TagNumber(4)
  void clearChecksum() => $_clearField(4);
}

class GithubServiceApi {
  final $pb.RpcClient _client;

  GithubServiceApi(this._client);
}

class BackendGithubServiceApi {
  final $pb.RpcClient _client;

  BackendGithubServiceApi(this._client);

  $async.Future<GithubRelease> getLatestRelease(
          $pb.ClientContext? ctx, LatestReleaseRequest request) =>
      _client.invoke<GithubRelease>(ctx, 'BackendGithubService',
          'GetLatestRelease', request, GithubRelease());
  $async.Future<$0.String> downloadRelease(
          $pb.ClientContext? ctx, GithubRelease request) =>
      _client.invoke<$0.String>(
          ctx, 'BackendGithubService', 'DownloadRelease', request, $0.String());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
