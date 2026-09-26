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
import 'config.pb.dart' as $2;
import 'config.pbjson.dart';
import 'generic.pb.dart' as $0;

export 'config.pb.dart';

abstract class ConfigServiceBase extends $pb.GeneratedService {
  $async.Future<$0.Json> getConfigJson(
      $pb.ServerContext ctx, $0.String request);
  $async.Future<$1.OpChanges> setConfigJson(
      $pb.ServerContext ctx, $2.SetConfigJsonRequest request);
  $async.Future<$0.Empty> setConfigJsonNoUndo(
      $pb.ServerContext ctx, $2.SetConfigJsonRequest request);
  $async.Future<$1.OpChanges> removeConfig(
      $pb.ServerContext ctx, $0.String request);
  $async.Future<$0.Json> getAllConfig($pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Bool> getConfigBool(
      $pb.ServerContext ctx, $2.GetConfigBoolRequest request);
  $async.Future<$1.OpChanges> setConfigBool(
      $pb.ServerContext ctx, $2.SetConfigBoolRequest request);
  $async.Future<$0.String> getConfigString(
      $pb.ServerContext ctx, $2.GetConfigStringRequest request);
  $async.Future<$1.OpChanges> setConfigString(
      $pb.ServerContext ctx, $2.SetConfigStringRequest request);
  $async.Future<$2.Preferences> getPreferences(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.OpChanges> setPreferences(
      $pb.ServerContext ctx, $2.Preferences request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetConfigJson':
        return $0.String();
      case 'SetConfigJson':
        return $2.SetConfigJsonRequest();
      case 'SetConfigJsonNoUndo':
        return $2.SetConfigJsonRequest();
      case 'RemoveConfig':
        return $0.String();
      case 'GetAllConfig':
        return $0.Empty();
      case 'GetConfigBool':
        return $2.GetConfigBoolRequest();
      case 'SetConfigBool':
        return $2.SetConfigBoolRequest();
      case 'GetConfigString':
        return $2.GetConfigStringRequest();
      case 'SetConfigString':
        return $2.SetConfigStringRequest();
      case 'GetPreferences':
        return $0.Empty();
      case 'SetPreferences':
        return $2.Preferences();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetConfigJson':
        return getConfigJson(ctx, request as $0.String);
      case 'SetConfigJson':
        return setConfigJson(ctx, request as $2.SetConfigJsonRequest);
      case 'SetConfigJsonNoUndo':
        return setConfigJsonNoUndo(ctx, request as $2.SetConfigJsonRequest);
      case 'RemoveConfig':
        return removeConfig(ctx, request as $0.String);
      case 'GetAllConfig':
        return getAllConfig(ctx, request as $0.Empty);
      case 'GetConfigBool':
        return getConfigBool(ctx, request as $2.GetConfigBoolRequest);
      case 'SetConfigBool':
        return setConfigBool(ctx, request as $2.SetConfigBoolRequest);
      case 'GetConfigString':
        return getConfigString(ctx, request as $2.GetConfigStringRequest);
      case 'SetConfigString':
        return setConfigString(ctx, request as $2.SetConfigStringRequest);
      case 'GetPreferences':
        return getPreferences(ctx, request as $0.Empty);
      case 'SetPreferences':
        return setPreferences(ctx, request as $2.Preferences);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ConfigServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ConfigServiceBase$messageJson;
}

abstract class BackendConfigServiceBase extends $pb.GeneratedService {
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

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendConfigServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendConfigServiceBase$messageJson;
}
