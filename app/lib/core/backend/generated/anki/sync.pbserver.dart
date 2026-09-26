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
import 'sync.pb.dart' as $1;
import 'sync.pbjson.dart';

export 'sync.pb.dart';

abstract class SyncServiceBase extends $pb.GeneratedService {
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

  $core.Map<$core.String, $core.dynamic> get $json => SyncServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SyncServiceBase$messageJson;
}

abstract class BackendSyncServiceBase extends $pb.GeneratedService {
  $async.Future<$0.Empty> syncMedia($pb.ServerContext ctx, $1.SyncAuth request);
  $async.Future<$0.Empty> abortMediaSync(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.MediaSyncStatusResponse> mediaSyncStatus(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.SyncAuth> syncLogin(
      $pb.ServerContext ctx, $1.SyncLoginRequest request);
  $async.Future<$1.SyncStatusResponse> syncStatus(
      $pb.ServerContext ctx, $1.SyncAuth request);
  $async.Future<$1.SyncCollectionResponse> syncCollection(
      $pb.ServerContext ctx, $1.SyncCollectionRequest request);
  $async.Future<$0.Empty> fullUploadOrDownload(
      $pb.ServerContext ctx, $1.FullUploadOrDownloadRequest request);
  $async.Future<$0.Empty> abortSync($pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Bool> setCustomCertificate(
      $pb.ServerContext ctx, $0.String request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'SyncMedia':
        return $1.SyncAuth();
      case 'AbortMediaSync':
        return $0.Empty();
      case 'MediaSyncStatus':
        return $0.Empty();
      case 'SyncLogin':
        return $1.SyncLoginRequest();
      case 'SyncStatus':
        return $1.SyncAuth();
      case 'SyncCollection':
        return $1.SyncCollectionRequest();
      case 'FullUploadOrDownload':
        return $1.FullUploadOrDownloadRequest();
      case 'AbortSync':
        return $0.Empty();
      case 'SetCustomCertificate':
        return $0.String();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'SyncMedia':
        return syncMedia(ctx, request as $1.SyncAuth);
      case 'AbortMediaSync':
        return abortMediaSync(ctx, request as $0.Empty);
      case 'MediaSyncStatus':
        return mediaSyncStatus(ctx, request as $0.Empty);
      case 'SyncLogin':
        return syncLogin(ctx, request as $1.SyncLoginRequest);
      case 'SyncStatus':
        return syncStatus(ctx, request as $1.SyncAuth);
      case 'SyncCollection':
        return syncCollection(ctx, request as $1.SyncCollectionRequest);
      case 'FullUploadOrDownload':
        return fullUploadOrDownload(
            ctx, request as $1.FullUploadOrDownloadRequest);
      case 'AbortSync':
        return abortSync(ctx, request as $0.Empty);
      case 'SetCustomCertificate':
        return setCustomCertificate(ctx, request as $0.String);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendSyncServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendSyncServiceBase$messageJson;
}
