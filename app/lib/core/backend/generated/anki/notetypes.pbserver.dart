// This is a generated file - do not edit.
//
// Generated from anki/notetypes.proto.

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
import 'notetypes.pb.dart' as $2;
import 'notetypes.pbjson.dart';

export 'notetypes.pb.dart';

abstract class NotetypesServiceBase extends $pb.GeneratedService {
  $async.Future<$1.OpChangesWithId> addNotetype(
      $pb.ServerContext ctx, $2.Notetype request);
  $async.Future<$1.OpChanges> updateNotetype(
      $pb.ServerContext ctx, $2.Notetype request);
  $async.Future<$1.OpChangesWithId> addNotetypeLegacy(
      $pb.ServerContext ctx, $0.Json request);
  $async.Future<$1.OpChanges> updateNotetypeLegacy(
      $pb.ServerContext ctx, $2.UpdateNotetypeLegacyRequest request);
  $async.Future<$2.NotetypeId> addOrUpdateNotetype(
      $pb.ServerContext ctx, $2.AddOrUpdateNotetypeRequest request);
  $async.Future<$0.Json> getStockNotetypeLegacy(
      $pb.ServerContext ctx, $2.StockNotetype request);
  $async.Future<$2.Notetype> getNotetype(
      $pb.ServerContext ctx, $2.NotetypeId request);
  $async.Future<$0.Json> getNotetypeLegacy(
      $pb.ServerContext ctx, $2.NotetypeId request);
  $async.Future<$2.NotetypeNames> getNotetypeNames(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.NotetypeUseCounts> getNotetypeNamesAndCounts(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.NotetypeId> getNotetypeIdByName(
      $pb.ServerContext ctx, $0.String request);
  $async.Future<$1.OpChanges> removeNotetype(
      $pb.ServerContext ctx, $2.NotetypeId request);
  $async.Future<$0.String> getAuxNotetypeConfigKey(
      $pb.ServerContext ctx, $2.GetAuxConfigKeyRequest request);
  $async.Future<$0.String> getAuxTemplateConfigKey(
      $pb.ServerContext ctx, $2.GetAuxTemplateConfigKeyRequest request);
  $async.Future<$2.ChangeNotetypeInfo> getChangeNotetypeInfo(
      $pb.ServerContext ctx, $2.GetChangeNotetypeInfoRequest request);
  $async.Future<$1.OpChanges> changeNotetype(
      $pb.ServerContext ctx, $2.ChangeNotetypeRequest request);
  $async.Future<$0.StringList> getFieldNames(
      $pb.ServerContext ctx, $2.NotetypeId request);
  $async.Future<$1.OpChanges> restoreNotetypeToStock(
      $pb.ServerContext ctx, $2.RestoreNotetypeToStockRequest request);
  $async.Future<$2.GetClozeFieldOrdsResponse> getClozeFieldOrds(
      $pb.ServerContext ctx, $2.NotetypeId request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'AddNotetype':
        return $2.Notetype();
      case 'UpdateNotetype':
        return $2.Notetype();
      case 'AddNotetypeLegacy':
        return $0.Json();
      case 'UpdateNotetypeLegacy':
        return $2.UpdateNotetypeLegacyRequest();
      case 'AddOrUpdateNotetype':
        return $2.AddOrUpdateNotetypeRequest();
      case 'GetStockNotetypeLegacy':
        return $2.StockNotetype();
      case 'GetNotetype':
        return $2.NotetypeId();
      case 'GetNotetypeLegacy':
        return $2.NotetypeId();
      case 'GetNotetypeNames':
        return $0.Empty();
      case 'GetNotetypeNamesAndCounts':
        return $0.Empty();
      case 'GetNotetypeIdByName':
        return $0.String();
      case 'RemoveNotetype':
        return $2.NotetypeId();
      case 'GetAuxNotetypeConfigKey':
        return $2.GetAuxConfigKeyRequest();
      case 'GetAuxTemplateConfigKey':
        return $2.GetAuxTemplateConfigKeyRequest();
      case 'GetChangeNotetypeInfo':
        return $2.GetChangeNotetypeInfoRequest();
      case 'ChangeNotetype':
        return $2.ChangeNotetypeRequest();
      case 'GetFieldNames':
        return $2.NotetypeId();
      case 'RestoreNotetypeToStock':
        return $2.RestoreNotetypeToStockRequest();
      case 'GetClozeFieldOrds':
        return $2.NotetypeId();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'AddNotetype':
        return addNotetype(ctx, request as $2.Notetype);
      case 'UpdateNotetype':
        return updateNotetype(ctx, request as $2.Notetype);
      case 'AddNotetypeLegacy':
        return addNotetypeLegacy(ctx, request as $0.Json);
      case 'UpdateNotetypeLegacy':
        return updateNotetypeLegacy(
            ctx, request as $2.UpdateNotetypeLegacyRequest);
      case 'AddOrUpdateNotetype':
        return addOrUpdateNotetype(
            ctx, request as $2.AddOrUpdateNotetypeRequest);
      case 'GetStockNotetypeLegacy':
        return getStockNotetypeLegacy(ctx, request as $2.StockNotetype);
      case 'GetNotetype':
        return getNotetype(ctx, request as $2.NotetypeId);
      case 'GetNotetypeLegacy':
        return getNotetypeLegacy(ctx, request as $2.NotetypeId);
      case 'GetNotetypeNames':
        return getNotetypeNames(ctx, request as $0.Empty);
      case 'GetNotetypeNamesAndCounts':
        return getNotetypeNamesAndCounts(ctx, request as $0.Empty);
      case 'GetNotetypeIdByName':
        return getNotetypeIdByName(ctx, request as $0.String);
      case 'RemoveNotetype':
        return removeNotetype(ctx, request as $2.NotetypeId);
      case 'GetAuxNotetypeConfigKey':
        return getAuxNotetypeConfigKey(
            ctx, request as $2.GetAuxConfigKeyRequest);
      case 'GetAuxTemplateConfigKey':
        return getAuxTemplateConfigKey(
            ctx, request as $2.GetAuxTemplateConfigKeyRequest);
      case 'GetChangeNotetypeInfo':
        return getChangeNotetypeInfo(
            ctx, request as $2.GetChangeNotetypeInfoRequest);
      case 'ChangeNotetype':
        return changeNotetype(ctx, request as $2.ChangeNotetypeRequest);
      case 'GetFieldNames':
        return getFieldNames(ctx, request as $2.NotetypeId);
      case 'RestoreNotetypeToStock':
        return restoreNotetypeToStock(
            ctx, request as $2.RestoreNotetypeToStockRequest);
      case 'GetClozeFieldOrds':
        return getClozeFieldOrds(ctx, request as $2.NotetypeId);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => NotetypesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => NotetypesServiceBase$messageJson;
}

abstract class BackendNotetypesServiceBase extends $pb.GeneratedService {
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
      BackendNotetypesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendNotetypesServiceBase$messageJson;
}
