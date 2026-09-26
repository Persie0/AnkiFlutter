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

import 'package:protobuf/protobuf.dart' as $pb;

import 'generic.pb.dart' as $0;
import 'media.pb.dart' as $2;
import 'media.pbjson.dart';
import 'notetypes.pb.dart' as $1;

export 'media.pb.dart';

abstract class MediaServiceBase extends $pb.GeneratedService {
  $async.Future<$2.CheckMediaResponse> checkMedia(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.String> addMediaFile(
      $pb.ServerContext ctx, $2.AddMediaFileRequest request);
  $async.Future<$0.String> addMediaFromPath(
      $pb.ServerContext ctx, $2.AddMediaFromPathRequest request);
  $async.Future<$0.Empty> trashMediaFiles(
      $pb.ServerContext ctx, $2.TrashMediaFilesRequest request);
  $async.Future<$0.Empty> emptyTrash($pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Empty> restoreTrash($pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.StringList> extractStaticMediaFiles(
      $pb.ServerContext ctx, $1.NotetypeId request);
  $async.Future<$0.StringList> extractMediaFiles(
      $pb.ServerContext ctx, $0.String request);
  $async.Future<$0.String> getAbsoluteMediaPath(
      $pb.ServerContext ctx, $0.String request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CheckMedia':
        return $0.Empty();
      case 'AddMediaFile':
        return $2.AddMediaFileRequest();
      case 'AddMediaFromPath':
        return $2.AddMediaFromPathRequest();
      case 'TrashMediaFiles':
        return $2.TrashMediaFilesRequest();
      case 'EmptyTrash':
        return $0.Empty();
      case 'RestoreTrash':
        return $0.Empty();
      case 'ExtractStaticMediaFiles':
        return $1.NotetypeId();
      case 'ExtractMediaFiles':
        return $0.String();
      case 'GetAbsoluteMediaPath':
        return $0.String();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CheckMedia':
        return checkMedia(ctx, request as $0.Empty);
      case 'AddMediaFile':
        return addMediaFile(ctx, request as $2.AddMediaFileRequest);
      case 'AddMediaFromPath':
        return addMediaFromPath(ctx, request as $2.AddMediaFromPathRequest);
      case 'TrashMediaFiles':
        return trashMediaFiles(ctx, request as $2.TrashMediaFilesRequest);
      case 'EmptyTrash':
        return emptyTrash(ctx, request as $0.Empty);
      case 'RestoreTrash':
        return restoreTrash(ctx, request as $0.Empty);
      case 'ExtractStaticMediaFiles':
        return extractStaticMediaFiles(ctx, request as $1.NotetypeId);
      case 'ExtractMediaFiles':
        return extractMediaFiles(ctx, request as $0.String);
      case 'GetAbsoluteMediaPath':
        return getAbsoluteMediaPath(ctx, request as $0.String);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => MediaServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => MediaServiceBase$messageJson;
}

abstract class BackendMediaServiceBase extends $pb.GeneratedService {
  $async.Future<$2.AddMediaFromUrlResponse> addMediaFromUrl(
      $pb.ServerContext ctx, $2.AddMediaFromUrlRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'AddMediaFromUrl':
        return $2.AddMediaFromUrlRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'AddMediaFromUrl':
        return addMediaFromUrl(ctx, request as $2.AddMediaFromUrlRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendMediaServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendMediaServiceBase$messageJson;
}
