// This is a generated file - do not edit.
//
// Generated from anki/ankihub.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'ankihub.pb.dart' as $1;
import 'ankihub.pbjson.dart';
import 'generic.pb.dart' as $0;

export 'ankihub.pb.dart';

abstract class AnkiHubServiceBase extends $pb.GeneratedService {
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

  $core.Map<$core.String, $core.dynamic> get $json => AnkiHubServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => AnkiHubServiceBase$messageJson;
}

abstract class BackendAnkiHubServiceBase extends $pb.GeneratedService {
  $async.Future<$1.LoginResponse> ankihubLogin(
      $pb.ServerContext ctx, $1.LoginRequest request);
  $async.Future<$0.Empty> ankihubLogout(
      $pb.ServerContext ctx, $1.LogoutRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'AnkihubLogin':
        return $1.LoginRequest();
      case 'AnkihubLogout':
        return $1.LogoutRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'AnkihubLogin':
        return ankihubLogin(ctx, request as $1.LoginRequest);
      case 'AnkihubLogout':
        return ankihubLogout(ctx, request as $1.LogoutRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendAnkiHubServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendAnkiHubServiceBase$messageJson;
}
