// This is a generated file - do not edit.
//
// Generated from anki/collection.proto.

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
import 'collection.pbjson.dart';
import 'generic.pb.dart' as $0;

export 'collection.pb.dart';

abstract class CollectionServiceBase extends $pb.GeneratedService {
  $async.Future<$2.CheckDatabaseResponse> checkDatabase(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.UndoStatus> getUndoStatus(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.OpChangesAfterUndo> undo(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.OpChangesAfterUndo> redo(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.UInt32> addCustomUndoEntry(
      $pb.ServerContext ctx, $0.String request);
  $async.Future<$2.OpChanges> mergeUndoEntries(
      $pb.ServerContext ctx, $0.UInt32 request);
  $async.Future<$2.Progress> latestProgress(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Empty> setWantsAbort(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.OpChanges> setLoadBalancerEnabled(
      $pb.ServerContext ctx, $0.Bool request);
  $async.Future<$2.GetCustomColoursResponse> getCustomColours(
      $pb.ServerContext ctx, $0.Empty request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CheckDatabase':
        return $0.Empty();
      case 'GetUndoStatus':
        return $0.Empty();
      case 'Undo':
        return $0.Empty();
      case 'Redo':
        return $0.Empty();
      case 'AddCustomUndoEntry':
        return $0.String();
      case 'MergeUndoEntries':
        return $0.UInt32();
      case 'LatestProgress':
        return $0.Empty();
      case 'SetWantsAbort':
        return $0.Empty();
      case 'SetLoadBalancerEnabled':
        return $0.Bool();
      case 'GetCustomColours':
        return $0.Empty();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CheckDatabase':
        return checkDatabase(ctx, request as $0.Empty);
      case 'GetUndoStatus':
        return getUndoStatus(ctx, request as $0.Empty);
      case 'Undo':
        return undo(ctx, request as $0.Empty);
      case 'Redo':
        return redo(ctx, request as $0.Empty);
      case 'AddCustomUndoEntry':
        return addCustomUndoEntry(ctx, request as $0.String);
      case 'MergeUndoEntries':
        return mergeUndoEntries(ctx, request as $0.UInt32);
      case 'LatestProgress':
        return latestProgress(ctx, request as $0.Empty);
      case 'SetWantsAbort':
        return setWantsAbort(ctx, request as $0.Empty);
      case 'SetLoadBalancerEnabled':
        return setLoadBalancerEnabled(ctx, request as $0.Bool);
      case 'GetCustomColours':
        return getCustomColours(ctx, request as $0.Empty);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      CollectionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => CollectionServiceBase$messageJson;
}

abstract class BackendCollectionServiceBase extends $pb.GeneratedService {
  $async.Future<$0.Empty> openCollection(
      $pb.ServerContext ctx, $2.OpenCollectionRequest request);
  $async.Future<$0.Empty> closeCollection(
      $pb.ServerContext ctx, $2.CloseCollectionRequest request);
  $async.Future<$0.Bool> createBackup(
      $pb.ServerContext ctx, $2.CreateBackupRequest request);
  $async.Future<$0.Empty> awaitBackupCompletion(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.Progress> latestProgress(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Empty> setWantsAbort(
      $pb.ServerContext ctx, $0.Empty request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'OpenCollection':
        return $2.OpenCollectionRequest();
      case 'CloseCollection':
        return $2.CloseCollectionRequest();
      case 'CreateBackup':
        return $2.CreateBackupRequest();
      case 'AwaitBackupCompletion':
        return $0.Empty();
      case 'LatestProgress':
        return $0.Empty();
      case 'SetWantsAbort':
        return $0.Empty();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'OpenCollection':
        return openCollection(ctx, request as $2.OpenCollectionRequest);
      case 'CloseCollection':
        return closeCollection(ctx, request as $2.CloseCollectionRequest);
      case 'CreateBackup':
        return createBackup(ctx, request as $2.CreateBackupRequest);
      case 'AwaitBackupCompletion':
        return awaitBackupCompletion(ctx, request as $0.Empty);
      case 'LatestProgress':
        return latestProgress(ctx, request as $0.Empty);
      case 'SetWantsAbort':
        return setWantsAbort(ctx, request as $0.Empty);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendCollectionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendCollectionServiceBase$messageJson;
}
