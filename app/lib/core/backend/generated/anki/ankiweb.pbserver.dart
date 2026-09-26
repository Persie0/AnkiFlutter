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

import 'package:protobuf/protobuf.dart' as $pb;

import 'ankiweb.pb.dart' as $0;
import 'ankiweb.pbjson.dart';

export 'ankiweb.pb.dart';

abstract class AnkiwebServiceBase extends $pb.GeneratedService {
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

  $core.Map<$core.String, $core.dynamic> get $json => AnkiwebServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => AnkiwebServiceBase$messageJson;
}

abstract class BackendAnkiwebServiceBase extends $pb.GeneratedService {
  $async.Future<$0.GetAddonInfoResponse> getAddonInfo(
      $pb.ServerContext ctx, $0.GetAddonInfoRequest request);
  $async.Future<$0.CheckForUpdateResponse> checkForUpdate(
      $pb.ServerContext ctx, $0.CheckForUpdateRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetAddonInfo':
        return $0.GetAddonInfoRequest();
      case 'CheckForUpdate':
        return $0.CheckForUpdateRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetAddonInfo':
        return getAddonInfo(ctx, request as $0.GetAddonInfoRequest);
      case 'CheckForUpdate':
        return checkForUpdate(ctx, request as $0.CheckForUpdateRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendAnkiwebServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendAnkiwebServiceBase$messageJson;
}
