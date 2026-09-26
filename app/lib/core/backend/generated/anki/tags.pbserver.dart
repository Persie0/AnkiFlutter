// This is a generated file - do not edit.
//
// Generated from anki/tags.proto.

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
import 'tags.pb.dart' as $2;
import 'tags.pbjson.dart';

export 'tags.pb.dart';

abstract class TagsServiceBase extends $pb.GeneratedService {
  $async.Future<$1.OpChangesWithCount> clearUnusedTags(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.StringList> allTags($pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.OpChangesWithCount> removeTags(
      $pb.ServerContext ctx, $0.String request);
  $async.Future<$1.OpChanges> setTagCollapsed(
      $pb.ServerContext ctx, $2.SetTagCollapsedRequest request);
  $async.Future<$2.TagTreeNode> tagTree(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.OpChangesWithCount> reparentTags(
      $pb.ServerContext ctx, $2.ReparentTagsRequest request);
  $async.Future<$1.OpChangesWithCount> renameTags(
      $pb.ServerContext ctx, $2.RenameTagsRequest request);
  $async.Future<$1.OpChangesWithCount> addNoteTags(
      $pb.ServerContext ctx, $2.NoteIdsAndTagsRequest request);
  $async.Future<$1.OpChangesWithCount> removeNoteTags(
      $pb.ServerContext ctx, $2.NoteIdsAndTagsRequest request);
  $async.Future<$1.OpChangesWithCount> findAndReplaceTag(
      $pb.ServerContext ctx, $2.FindAndReplaceTagRequest request);
  $async.Future<$2.CompleteTagResponse> completeTag(
      $pb.ServerContext ctx, $2.CompleteTagRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ClearUnusedTags':
        return $0.Empty();
      case 'AllTags':
        return $0.Empty();
      case 'RemoveTags':
        return $0.String();
      case 'SetTagCollapsed':
        return $2.SetTagCollapsedRequest();
      case 'TagTree':
        return $0.Empty();
      case 'ReparentTags':
        return $2.ReparentTagsRequest();
      case 'RenameTags':
        return $2.RenameTagsRequest();
      case 'AddNoteTags':
        return $2.NoteIdsAndTagsRequest();
      case 'RemoveNoteTags':
        return $2.NoteIdsAndTagsRequest();
      case 'FindAndReplaceTag':
        return $2.FindAndReplaceTagRequest();
      case 'CompleteTag':
        return $2.CompleteTagRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ClearUnusedTags':
        return clearUnusedTags(ctx, request as $0.Empty);
      case 'AllTags':
        return allTags(ctx, request as $0.Empty);
      case 'RemoveTags':
        return removeTags(ctx, request as $0.String);
      case 'SetTagCollapsed':
        return setTagCollapsed(ctx, request as $2.SetTagCollapsedRequest);
      case 'TagTree':
        return tagTree(ctx, request as $0.Empty);
      case 'ReparentTags':
        return reparentTags(ctx, request as $2.ReparentTagsRequest);
      case 'RenameTags':
        return renameTags(ctx, request as $2.RenameTagsRequest);
      case 'AddNoteTags':
        return addNoteTags(ctx, request as $2.NoteIdsAndTagsRequest);
      case 'RemoveNoteTags':
        return removeNoteTags(ctx, request as $2.NoteIdsAndTagsRequest);
      case 'FindAndReplaceTag':
        return findAndReplaceTag(ctx, request as $2.FindAndReplaceTagRequest);
      case 'CompleteTag':
        return completeTag(ctx, request as $2.CompleteTagRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TagsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => TagsServiceBase$messageJson;
}

abstract class BackendTagsServiceBase extends $pb.GeneratedService {
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
      BackendTagsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendTagsServiceBase$messageJson;
}
