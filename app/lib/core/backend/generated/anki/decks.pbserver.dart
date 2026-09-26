// This is a generated file - do not edit.
//
// Generated from anki/decks.proto.

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
import 'decks.pb.dart' as $2;
import 'decks.pbjson.dart';
import 'generic.pb.dart' as $0;

export 'decks.pb.dart';

abstract class DecksServiceBase extends $pb.GeneratedService {
  $async.Future<$2.Deck> newDeck($pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.OpChangesWithId> addDeck(
      $pb.ServerContext ctx, $2.Deck request);
  $async.Future<$1.OpChangesWithId> addDeckLegacy(
      $pb.ServerContext ctx, $0.Json request);
  $async.Future<$2.DeckId> addOrUpdateDeckLegacy(
      $pb.ServerContext ctx, $2.AddOrUpdateDeckLegacyRequest request);
  $async.Future<$2.DeckTreeNode> deckTree(
      $pb.ServerContext ctx, $2.DeckTreeRequest request);
  $async.Future<$0.Json> deckTreeLegacy(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$0.Json> getAllDecksLegacy(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$2.DeckId> getDeckIdByName(
      $pb.ServerContext ctx, $0.String request);
  $async.Future<$2.Deck> getDeck($pb.ServerContext ctx, $2.DeckId request);
  $async.Future<$1.OpChanges> updateDeck(
      $pb.ServerContext ctx, $2.Deck request);
  $async.Future<$1.OpChanges> updateDeckLegacy(
      $pb.ServerContext ctx, $0.Json request);
  $async.Future<$1.OpChanges> setDeckCollapsed(
      $pb.ServerContext ctx, $2.SetDeckCollapsedRequest request);
  $async.Future<$0.Json> getDeckLegacy(
      $pb.ServerContext ctx, $2.DeckId request);
  $async.Future<$2.DeckNames> getDeckNames(
      $pb.ServerContext ctx, $2.GetDeckNamesRequest request);
  $async.Future<$2.DeckNames> getDeckAndChildNames(
      $pb.ServerContext ctx, $2.DeckId request);
  $async.Future<$0.Json> newDeckLegacy($pb.ServerContext ctx, $0.Bool request);
  $async.Future<$1.OpChangesWithCount> removeDecks(
      $pb.ServerContext ctx, $2.DeckIds request);
  $async.Future<$1.OpChangesWithCount> reparentDecks(
      $pb.ServerContext ctx, $2.ReparentDecksRequest request);
  $async.Future<$1.OpChanges> renameDeck(
      $pb.ServerContext ctx, $2.RenameDeckRequest request);
  $async.Future<$2.FilteredDeckForUpdate> getOrCreateFilteredDeck(
      $pb.ServerContext ctx, $2.DeckId request);
  $async.Future<$1.OpChangesWithId> addOrUpdateFilteredDeck(
      $pb.ServerContext ctx, $2.FilteredDeckForUpdate request);
  $async.Future<$0.StringList> filteredDeckOrderLabels(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.OpChanges> setCurrentDeck(
      $pb.ServerContext ctx, $2.DeckId request);
  $async.Future<$2.Deck> getCurrentDeck(
      $pb.ServerContext ctx, $0.Empty request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'NewDeck':
        return $0.Empty();
      case 'AddDeck':
        return $2.Deck();
      case 'AddDeckLegacy':
        return $0.Json();
      case 'AddOrUpdateDeckLegacy':
        return $2.AddOrUpdateDeckLegacyRequest();
      case 'DeckTree':
        return $2.DeckTreeRequest();
      case 'DeckTreeLegacy':
        return $0.Empty();
      case 'GetAllDecksLegacy':
        return $0.Empty();
      case 'GetDeckIdByName':
        return $0.String();
      case 'GetDeck':
        return $2.DeckId();
      case 'UpdateDeck':
        return $2.Deck();
      case 'UpdateDeckLegacy':
        return $0.Json();
      case 'SetDeckCollapsed':
        return $2.SetDeckCollapsedRequest();
      case 'GetDeckLegacy':
        return $2.DeckId();
      case 'GetDeckNames':
        return $2.GetDeckNamesRequest();
      case 'GetDeckAndChildNames':
        return $2.DeckId();
      case 'NewDeckLegacy':
        return $0.Bool();
      case 'RemoveDecks':
        return $2.DeckIds();
      case 'ReparentDecks':
        return $2.ReparentDecksRequest();
      case 'RenameDeck':
        return $2.RenameDeckRequest();
      case 'GetOrCreateFilteredDeck':
        return $2.DeckId();
      case 'AddOrUpdateFilteredDeck':
        return $2.FilteredDeckForUpdate();
      case 'FilteredDeckOrderLabels':
        return $0.Empty();
      case 'SetCurrentDeck':
        return $2.DeckId();
      case 'GetCurrentDeck':
        return $0.Empty();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'NewDeck':
        return newDeck(ctx, request as $0.Empty);
      case 'AddDeck':
        return addDeck(ctx, request as $2.Deck);
      case 'AddDeckLegacy':
        return addDeckLegacy(ctx, request as $0.Json);
      case 'AddOrUpdateDeckLegacy':
        return addOrUpdateDeckLegacy(
            ctx, request as $2.AddOrUpdateDeckLegacyRequest);
      case 'DeckTree':
        return deckTree(ctx, request as $2.DeckTreeRequest);
      case 'DeckTreeLegacy':
        return deckTreeLegacy(ctx, request as $0.Empty);
      case 'GetAllDecksLegacy':
        return getAllDecksLegacy(ctx, request as $0.Empty);
      case 'GetDeckIdByName':
        return getDeckIdByName(ctx, request as $0.String);
      case 'GetDeck':
        return getDeck(ctx, request as $2.DeckId);
      case 'UpdateDeck':
        return updateDeck(ctx, request as $2.Deck);
      case 'UpdateDeckLegacy':
        return updateDeckLegacy(ctx, request as $0.Json);
      case 'SetDeckCollapsed':
        return setDeckCollapsed(ctx, request as $2.SetDeckCollapsedRequest);
      case 'GetDeckLegacy':
        return getDeckLegacy(ctx, request as $2.DeckId);
      case 'GetDeckNames':
        return getDeckNames(ctx, request as $2.GetDeckNamesRequest);
      case 'GetDeckAndChildNames':
        return getDeckAndChildNames(ctx, request as $2.DeckId);
      case 'NewDeckLegacy':
        return newDeckLegacy(ctx, request as $0.Bool);
      case 'RemoveDecks':
        return removeDecks(ctx, request as $2.DeckIds);
      case 'ReparentDecks':
        return reparentDecks(ctx, request as $2.ReparentDecksRequest);
      case 'RenameDeck':
        return renameDeck(ctx, request as $2.RenameDeckRequest);
      case 'GetOrCreateFilteredDeck':
        return getOrCreateFilteredDeck(ctx, request as $2.DeckId);
      case 'AddOrUpdateFilteredDeck':
        return addOrUpdateFilteredDeck(
            ctx, request as $2.FilteredDeckForUpdate);
      case 'FilteredDeckOrderLabels':
        return filteredDeckOrderLabels(ctx, request as $0.Empty);
      case 'SetCurrentDeck':
        return setCurrentDeck(ctx, request as $2.DeckId);
      case 'GetCurrentDeck':
        return getCurrentDeck(ctx, request as $0.Empty);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => DecksServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => DecksServiceBase$messageJson;
}

abstract class BackendDecksServiceBase extends $pb.GeneratedService {
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
      BackendDecksServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendDecksServiceBase$messageJson;
}
