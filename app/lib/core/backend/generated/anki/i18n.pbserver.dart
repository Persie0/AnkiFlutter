// This is a generated file - do not edit.
//
// Generated from anki/i18n.proto.

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
import 'i18n.pb.dart' as $1;
import 'i18n.pbjson.dart';

export 'i18n.pb.dart';

abstract class I18nServiceBase extends $pb.GeneratedService {
  $async.Future<$0.String> translateString(
      $pb.ServerContext ctx, $1.TranslateStringRequest request);
  $async.Future<$0.String> formatTimespan(
      $pb.ServerContext ctx, $1.FormatTimespanRequest request);
  $async.Future<$0.Json> i18nResources(
      $pb.ServerContext ctx, $1.I18nResourcesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'TranslateString':
        return $1.TranslateStringRequest();
      case 'FormatTimespan':
        return $1.FormatTimespanRequest();
      case 'I18nResources':
        return $1.I18nResourcesRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'TranslateString':
        return translateString(ctx, request as $1.TranslateStringRequest);
      case 'FormatTimespan':
        return formatTimespan(ctx, request as $1.FormatTimespanRequest);
      case 'I18nResources':
        return i18nResources(ctx, request as $1.I18nResourcesRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => I18nServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => I18nServiceBase$messageJson;
}

abstract class BackendI18nServiceBase extends $pb.GeneratedService {
  $async.Future<$0.String> translateString(
      $pb.ServerContext ctx, $1.TranslateStringRequest request);
  $async.Future<$0.String> formatTimespan(
      $pb.ServerContext ctx, $1.FormatTimespanRequest request);
  $async.Future<$0.Json> i18nResources(
      $pb.ServerContext ctx, $1.I18nResourcesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'TranslateString':
        return $1.TranslateStringRequest();
      case 'FormatTimespan':
        return $1.FormatTimespanRequest();
      case 'I18nResources':
        return $1.I18nResourcesRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'TranslateString':
        return translateString(ctx, request as $1.TranslateStringRequest);
      case 'FormatTimespan':
        return formatTimespan(ctx, request as $1.FormatTimespanRequest);
      case 'I18nResources':
        return i18nResources(ctx, request as $1.I18nResourcesRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendI18nServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendI18nServiceBase$messageJson;
}
