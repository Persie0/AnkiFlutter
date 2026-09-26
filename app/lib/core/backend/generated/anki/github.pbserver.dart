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
import 'github.pb.dart' as $1;
import 'github.pbjson.dart';

export 'github.pb.dart';

abstract class GithubServiceBase extends $pb.GeneratedService {
  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => GithubServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => GithubServiceBase$messageJson;
}

abstract class BackendGithubServiceBase extends $pb.GeneratedService {
  $async.Future<$1.GithubRelease> getLatestRelease(
      $pb.ServerContext ctx, $1.LatestReleaseRequest request);
  $async.Future<$0.String> downloadRelease(
      $pb.ServerContext ctx, $1.GithubRelease request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetLatestRelease':
        return $1.LatestReleaseRequest();
      case 'DownloadRelease':
        return $1.GithubRelease();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetLatestRelease':
        return getLatestRelease(ctx, request as $1.LatestReleaseRequest);
      case 'DownloadRelease':
        return downloadRelease(ctx, request as $1.GithubRelease);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendGithubServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendGithubServiceBase$messageJson;
}
