// This is a generated file - do not edit.
//
// Generated from anki/stats.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'cards.pb.dart' as $0;
import 'generic.pb.dart' as $1;
import 'stats.pb.dart' as $2;
import 'stats.pbjson.dart';

export 'stats.pb.dart';

abstract class StatsServiceBase extends $pb.GeneratedService {
  $async.Future<$2.CardStatsResponse> cardStats(
      $pb.ServerContext ctx, $0.CardId request);
  $async.Future<$2.ReviewLogs> getReviewLogs(
      $pb.ServerContext ctx, $0.CardId request);
  $async.Future<$2.GraphsResponse> graphs(
      $pb.ServerContext ctx, $2.GraphsRequest request);
  $async.Future<$2.GraphPreferences> getGraphPreferences(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> setGraphPreferences(
      $pb.ServerContext ctx, $2.GraphPreferences request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CardStats':
        return $0.CardId();
      case 'GetReviewLogs':
        return $0.CardId();
      case 'Graphs':
        return $2.GraphsRequest();
      case 'GetGraphPreferences':
        return $1.Empty();
      case 'SetGraphPreferences':
        return $2.GraphPreferences();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CardStats':
        return cardStats(ctx, request as $0.CardId);
      case 'GetReviewLogs':
        return getReviewLogs(ctx, request as $0.CardId);
      case 'Graphs':
        return graphs(ctx, request as $2.GraphsRequest);
      case 'GetGraphPreferences':
        return getGraphPreferences(ctx, request as $1.Empty);
      case 'SetGraphPreferences':
        return setGraphPreferences(ctx, request as $2.GraphPreferences);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => StatsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => StatsServiceBase$messageJson;
}

abstract class BackendStatsServiceBase extends $pb.GeneratedService {
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
      BackendStatsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendStatsServiceBase$messageJson;
}
