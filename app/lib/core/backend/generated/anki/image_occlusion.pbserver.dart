// This is a generated file - do not edit.
//
// Generated from anki/image_occlusion.proto.

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
import 'generic.pb.dart' as $0;
import 'image_occlusion.pb.dart' as $2;
import 'image_occlusion.pbjson.dart';

export 'image_occlusion.pb.dart';

abstract class ImageOcclusionServiceBase extends $pb.GeneratedService {
  $async.Future<$2.GetImageForOcclusionResponse> getImageForOcclusion(
      $pb.ServerContext ctx, $2.GetImageForOcclusionRequest request);
  $async.Future<$2.GetImageOcclusionNoteResponse> getImageOcclusionNote(
      $pb.ServerContext ctx, $2.GetImageOcclusionNoteRequest request);
  $async.Future<$2.GetImageOcclusionFieldsResponse> getImageOcclusionFields(
      $pb.ServerContext ctx, $2.GetImageOcclusionFieldsRequest request);
  $async.Future<$1.OpChanges> addImageOcclusionNotetype(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.OpChanges> addImageOcclusionNote(
      $pb.ServerContext ctx, $2.AddImageOcclusionNoteRequest request);
  $async.Future<$1.OpChanges> updateImageOcclusionNote(
      $pb.ServerContext ctx, $2.UpdateImageOcclusionNoteRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetImageForOcclusion':
        return $2.GetImageForOcclusionRequest();
      case 'GetImageOcclusionNote':
        return $2.GetImageOcclusionNoteRequest();
      case 'GetImageOcclusionFields':
        return $2.GetImageOcclusionFieldsRequest();
      case 'AddImageOcclusionNotetype':
        return $0.Empty();
      case 'AddImageOcclusionNote':
        return $2.AddImageOcclusionNoteRequest();
      case 'UpdateImageOcclusionNote':
        return $2.UpdateImageOcclusionNoteRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetImageForOcclusion':
        return getImageForOcclusion(
            ctx, request as $2.GetImageForOcclusionRequest);
      case 'GetImageOcclusionNote':
        return getImageOcclusionNote(
            ctx, request as $2.GetImageOcclusionNoteRequest);
      case 'GetImageOcclusionFields':
        return getImageOcclusionFields(
            ctx, request as $2.GetImageOcclusionFieldsRequest);
      case 'AddImageOcclusionNotetype':
        return addImageOcclusionNotetype(ctx, request as $0.Empty);
      case 'AddImageOcclusionNote':
        return addImageOcclusionNote(
            ctx, request as $2.AddImageOcclusionNoteRequest);
      case 'UpdateImageOcclusionNote':
        return updateImageOcclusionNote(
            ctx, request as $2.UpdateImageOcclusionNoteRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      ImageOcclusionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ImageOcclusionServiceBase$messageJson;
}

abstract class BackendImageOcclusionServiceBase extends $pb.GeneratedService {
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
      BackendImageOcclusionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendImageOcclusionServiceBase$messageJson;
}
