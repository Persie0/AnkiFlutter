// This is a generated file - do not edit.
//
// Generated from anki/cards.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'cards.pb.dart' as $1;
import 'cards.pbjson.dart';
import 'collection.pb.dart' as $0;

export 'cards.pb.dart';

abstract class CardsServiceBase extends $pb.GeneratedService {
  $async.Future<$1.Card> getCard($pb.ServerContext ctx, $1.CardId request);
  $async.Future<$0.OpChanges> updateCards(
      $pb.ServerContext ctx, $1.UpdateCardsRequest request);
  $async.Future<$0.OpChangesWithCount> removeCards(
      $pb.ServerContext ctx, $1.RemoveCardsRequest request);
  $async.Future<$0.OpChangesWithCount> setDeck(
      $pb.ServerContext ctx, $1.SetDeckRequest request);
  $async.Future<$0.OpChangesWithCount> setFlag(
      $pb.ServerContext ctx, $1.SetFlagRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetCard':
        return $1.CardId();
      case 'UpdateCards':
        return $1.UpdateCardsRequest();
      case 'RemoveCards':
        return $1.RemoveCardsRequest();
      case 'SetDeck':
        return $1.SetDeckRequest();
      case 'SetFlag':
        return $1.SetFlagRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetCard':
        return getCard(ctx, request as $1.CardId);
      case 'UpdateCards':
        return updateCards(ctx, request as $1.UpdateCardsRequest);
      case 'RemoveCards':
        return removeCards(ctx, request as $1.RemoveCardsRequest);
      case 'SetDeck':
        return setDeck(ctx, request as $1.SetDeckRequest);
      case 'SetFlag':
        return setFlag(ctx, request as $1.SetFlagRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => CardsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => CardsServiceBase$messageJson;
}

abstract class BackendCardsServiceBase extends $pb.GeneratedService {
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
      BackendCardsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendCardsServiceBase$messageJson;
}
