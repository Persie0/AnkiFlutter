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

import 'package:protobuf/protobuf.dart' as $pb;

import 'collection.pb.dart' as $2;
import 'deck_config.pb.dart' as $3;
import 'deck_config.pbjson.dart';
import 'decks.pb.dart' as $1;
import 'generic.pb.dart' as $0;

export 'deck_config.pb.dart';

abstract class DeckConfigServiceBase extends $pb.GeneratedService {
  $async.Future<$3.DeckConfigId> addOrUpdateDeckConfigLegacy(
      $pb.ServerContext ctx, $0.Json request);
  $async.Future<$3.DeckConfig> getDeckConfig(
      $pb.ServerContext ctx, $3.DeckConfigId request);
  $async.Future<$0.Json> allDeckConfigLegacy(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Json> getDeckConfigLegacy(
      $pb.ServerContext ctx, $3.DeckConfigId request);
  $async.Future<$0.Json> newDeckConfigLegacy(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Empty> removeDeckConfig(
      $pb.ServerContext ctx, $3.DeckConfigId request);
  $async.Future<$3.DeckConfigsForUpdate> getDeckConfigsForUpdate(
      $pb.ServerContext ctx, $1.DeckId request);
  $async.Future<$2.OpChanges> updateDeckConfigs(
      $pb.ServerContext ctx, $3.UpdateDeckConfigsRequest request);
  $async.Future<$3.GetIgnoredBeforeCountResponse> getIgnoredBeforeCount(
      $pb.ServerContext ctx, $3.GetIgnoredBeforeCountRequest request);
  $async.Future<$3.GetRetentionWorkloadResponse> getRetentionWorkload(
      $pb.ServerContext ctx, $3.GetRetentionWorkloadRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'AddOrUpdateDeckConfigLegacy':
        return $0.Json();
      case 'GetDeckConfig':
        return $3.DeckConfigId();
      case 'AllDeckConfigLegacy':
        return $0.Empty();
      case 'GetDeckConfigLegacy':
        return $3.DeckConfigId();
      case 'NewDeckConfigLegacy':
        return $0.Empty();
      case 'RemoveDeckConfig':
        return $3.DeckConfigId();
      case 'GetDeckConfigsForUpdate':
        return $1.DeckId();
      case 'UpdateDeckConfigs':
        return $3.UpdateDeckConfigsRequest();
      case 'GetIgnoredBeforeCount':
        return $3.GetIgnoredBeforeCountRequest();
      case 'GetRetentionWorkload':
        return $3.GetRetentionWorkloadRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'AddOrUpdateDeckConfigLegacy':
        return addOrUpdateDeckConfigLegacy(ctx, request as $0.Json);
      case 'GetDeckConfig':
        return getDeckConfig(ctx, request as $3.DeckConfigId);
      case 'AllDeckConfigLegacy':
        return allDeckConfigLegacy(ctx, request as $0.Empty);
      case 'GetDeckConfigLegacy':
        return getDeckConfigLegacy(ctx, request as $3.DeckConfigId);
      case 'NewDeckConfigLegacy':
        return newDeckConfigLegacy(ctx, request as $0.Empty);
      case 'RemoveDeckConfig':
        return removeDeckConfig(ctx, request as $3.DeckConfigId);
      case 'GetDeckConfigsForUpdate':
        return getDeckConfigsForUpdate(ctx, request as $1.DeckId);
      case 'UpdateDeckConfigs':
        return updateDeckConfigs(ctx, request as $3.UpdateDeckConfigsRequest);
      case 'GetIgnoredBeforeCount':
        return getIgnoredBeforeCount(
            ctx, request as $3.GetIgnoredBeforeCountRequest);
      case 'GetRetentionWorkload':
        return getRetentionWorkload(
            ctx, request as $3.GetRetentionWorkloadRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      DeckConfigServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => DeckConfigServiceBase$messageJson;
}

abstract class BackendDeckConfigServiceBase extends $pb.GeneratedService {
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
      BackendDeckConfigServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendDeckConfigServiceBase$messageJson;
}
