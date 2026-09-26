// This is a generated file - do not edit.
//
// Generated from anki/search.proto.

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
import 'search.pb.dart' as $2;
import 'search.pbjson.dart';

export 'search.pb.dart';

abstract class SearchServiceBase extends $pb.GeneratedService {
  $async.Future<$0.String> buildSearchString(
      $pb.ServerContext ctx, $2.SearchNode request);
  $async.Future<$2.SearchResponse> searchCards(
      $pb.ServerContext ctx, $2.SearchRequest request);
  $async.Future<$2.SearchResponse> searchNotes(
      $pb.ServerContext ctx, $2.SearchRequest request);
  $async.Future<$0.String> joinSearchNodes(
      $pb.ServerContext ctx, $2.JoinSearchNodesRequest request);
  $async.Future<$0.String> replaceSearchNode(
      $pb.ServerContext ctx, $2.ReplaceSearchNodeRequest request);
  $async.Future<$1.OpChangesWithCount> findAndReplace(
      $pb.ServerContext ctx, $2.FindAndReplaceRequest request);
  $async.Future<$2.BrowserColumns> allBrowserColumns(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.BrowserRow> browserRowForId(
      $pb.ServerContext ctx, $0.Int64 request);
  $async.Future<$0.Empty> setActiveBrowserColumns(
      $pb.ServerContext ctx, $0.StringList request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'BuildSearchString':
        return $2.SearchNode();
      case 'SearchCards':
        return $2.SearchRequest();
      case 'SearchNotes':
        return $2.SearchRequest();
      case 'JoinSearchNodes':
        return $2.JoinSearchNodesRequest();
      case 'ReplaceSearchNode':
        return $2.ReplaceSearchNodeRequest();
      case 'FindAndReplace':
        return $2.FindAndReplaceRequest();
      case 'AllBrowserColumns':
        return $0.Empty();
      case 'BrowserRowForId':
        return $0.Int64();
      case 'SetActiveBrowserColumns':
        return $0.StringList();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'BuildSearchString':
        return buildSearchString(ctx, request as $2.SearchNode);
      case 'SearchCards':
        return searchCards(ctx, request as $2.SearchRequest);
      case 'SearchNotes':
        return searchNotes(ctx, request as $2.SearchRequest);
      case 'JoinSearchNodes':
        return joinSearchNodes(ctx, request as $2.JoinSearchNodesRequest);
      case 'ReplaceSearchNode':
        return replaceSearchNode(ctx, request as $2.ReplaceSearchNodeRequest);
      case 'FindAndReplace':
        return findAndReplace(ctx, request as $2.FindAndReplaceRequest);
      case 'AllBrowserColumns':
        return allBrowserColumns(ctx, request as $0.Empty);
      case 'BrowserRowForId':
        return browserRowForId(ctx, request as $0.Int64);
      case 'SetActiveBrowserColumns':
        return setActiveBrowserColumns(ctx, request as $0.StringList);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SearchServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SearchServiceBase$messageJson;
}

abstract class BackendSearchServiceBase extends $pb.GeneratedService {
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
      BackendSearchServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendSearchServiceBase$messageJson;
}
