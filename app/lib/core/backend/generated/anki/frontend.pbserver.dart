// This is a generated file - do not edit.
//
// Generated from anki/frontend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'frontend.pb.dart' as $5;
import 'frontend.pbjson.dart';
import 'generic.pb.dart' as $1;
import 'search.pb.dart' as $2;

export 'frontend.pb.dart';

abstract class FrontendServiceBase extends $pb.GeneratedService {
  $async.Future<$5.SchedulingStatesWithContext> getSchedulingStatesWithContext(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> setSchedulingStates(
      $pb.ServerContext ctx, $5.SetSchedulingStatesRequest request);
  $async.Future<$1.Empty> importDone($pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> searchInBrowser(
      $pb.ServerContext ctx, $2.SearchNode request);
  $async.Future<$1.Empty> deckOptionsRequireClose(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> deckOptionsReady(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$5.ConvertPastedImageResponse> convertPastedImage(
      $pb.ServerContext ctx, $5.ConvertPastedImageRequest request);
  $async.Future<$1.String> openFilePicker(
      $pb.ServerContext ctx, $5.openFilePickerRequest request);
  $async.Future<$1.Empty> openMedia($pb.ServerContext ctx, $1.String request);
  $async.Future<$1.Empty> showInMediaFolder(
      $pb.ServerContext ctx, $1.String request);
  $async.Future<$1.String> recordAudio($pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> playFile($pb.ServerContext ctx, $1.String request);
  $async.Future<$1.Empty> closeAddCards($pb.ServerContext ctx, $1.Bool request);
  $async.Future<$1.Empty> closeEditCurrent(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> openLink($pb.ServerContext ctx, $1.String request);
  $async.Future<$1.Bool> askUser(
      $pb.ServerContext ctx, $5.AskUserRequest request);
  $async.Future<$1.Empty> showMessageBox(
      $pb.ServerContext ctx, $5.ShowMessageBoxRequest request);
  $async.Future<$1.Empty> openFieldsDialog(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> openCardsDialog(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Json> getProfileConfigJson(
      $pb.ServerContext ctx, $1.String request);
  $async.Future<$1.Empty> setProfileConfigJson(
      $pb.ServerContext ctx, $5.SetSettingJsonRequest request);
  $async.Future<$1.Json> getMetaJson($pb.ServerContext ctx, $1.String request);
  $async.Future<$1.Empty> setMetaJson(
      $pb.ServerContext ctx, $5.SetSettingJsonRequest request);
  $async.Future<$5.ReadClipboardResponse> readClipboard(
      $pb.ServerContext ctx, $5.ReadClipboardRequest request);
  $async.Future<$1.Empty> writeClipboard(
      $pb.ServerContext ctx, $5.WriteClipboardRequest request);
  $async.Future<$1.Empty> saveCustomColours(
      $pb.ServerContext ctx, $1.Empty request);
  $async.Future<$1.Empty> importDialogRequireClose(
      $pb.ServerContext ctx, $1.Empty request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetSchedulingStatesWithContext':
        return $1.Empty();
      case 'SetSchedulingStates':
        return $5.SetSchedulingStatesRequest();
      case 'ImportDone':
        return $1.Empty();
      case 'SearchInBrowser':
        return $2.SearchNode();
      case 'deckOptionsRequireClose':
        return $1.Empty();
      case 'deckOptionsReady':
        return $1.Empty();
      case 'ConvertPastedImage':
        return $5.ConvertPastedImageRequest();
      case 'OpenFilePicker':
        return $5.openFilePickerRequest();
      case 'OpenMedia':
        return $1.String();
      case 'ShowInMediaFolder':
        return $1.String();
      case 'RecordAudio':
        return $1.Empty();
      case 'PlayFile':
        return $1.String();
      case 'CloseAddCards':
        return $1.Bool();
      case 'CloseEditCurrent':
        return $1.Empty();
      case 'OpenLink':
        return $1.String();
      case 'AskUser':
        return $5.AskUserRequest();
      case 'ShowMessageBox':
        return $5.ShowMessageBoxRequest();
      case 'OpenFieldsDialog':
        return $1.Empty();
      case 'OpenCardsDialog':
        return $1.Empty();
      case 'GetProfileConfigJson':
        return $1.String();
      case 'SetProfileConfigJson':
        return $5.SetSettingJsonRequest();
      case 'GetMetaJson':
        return $1.String();
      case 'SetMetaJson':
        return $5.SetSettingJsonRequest();
      case 'ReadClipboard':
        return $5.ReadClipboardRequest();
      case 'WriteClipboard':
        return $5.WriteClipboardRequest();
      case 'SaveCustomColours':
        return $1.Empty();
      case 'ImportDialogRequireClose':
        return $1.Empty();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetSchedulingStatesWithContext':
        return getSchedulingStatesWithContext(ctx, request as $1.Empty);
      case 'SetSchedulingStates':
        return setSchedulingStates(
            ctx, request as $5.SetSchedulingStatesRequest);
      case 'ImportDone':
        return importDone(ctx, request as $1.Empty);
      case 'SearchInBrowser':
        return searchInBrowser(ctx, request as $2.SearchNode);
      case 'deckOptionsRequireClose':
        return deckOptionsRequireClose(ctx, request as $1.Empty);
      case 'deckOptionsReady':
        return deckOptionsReady(ctx, request as $1.Empty);
      case 'ConvertPastedImage':
        return convertPastedImage(ctx, request as $5.ConvertPastedImageRequest);
      case 'OpenFilePicker':
        return openFilePicker(ctx, request as $5.openFilePickerRequest);
      case 'OpenMedia':
        return openMedia(ctx, request as $1.String);
      case 'ShowInMediaFolder':
        return showInMediaFolder(ctx, request as $1.String);
      case 'RecordAudio':
        return recordAudio(ctx, request as $1.Empty);
      case 'PlayFile':
        return playFile(ctx, request as $1.String);
      case 'CloseAddCards':
        return closeAddCards(ctx, request as $1.Bool);
      case 'CloseEditCurrent':
        return closeEditCurrent(ctx, request as $1.Empty);
      case 'OpenLink':
        return openLink(ctx, request as $1.String);
      case 'AskUser':
        return askUser(ctx, request as $5.AskUserRequest);
      case 'ShowMessageBox':
        return showMessageBox(ctx, request as $5.ShowMessageBoxRequest);
      case 'OpenFieldsDialog':
        return openFieldsDialog(ctx, request as $1.Empty);
      case 'OpenCardsDialog':
        return openCardsDialog(ctx, request as $1.Empty);
      case 'GetProfileConfigJson':
        return getProfileConfigJson(ctx, request as $1.String);
      case 'SetProfileConfigJson':
        return setProfileConfigJson(ctx, request as $5.SetSettingJsonRequest);
      case 'GetMetaJson':
        return getMetaJson(ctx, request as $1.String);
      case 'SetMetaJson':
        return setMetaJson(ctx, request as $5.SetSettingJsonRequest);
      case 'ReadClipboard':
        return readClipboard(ctx, request as $5.ReadClipboardRequest);
      case 'WriteClipboard':
        return writeClipboard(ctx, request as $5.WriteClipboardRequest);
      case 'SaveCustomColours':
        return saveCustomColours(ctx, request as $1.Empty);
      case 'ImportDialogRequireClose':
        return importDialogRequireClose(ctx, request as $1.Empty);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => FrontendServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => FrontendServiceBase$messageJson;
}

abstract class BackendFrontendServiceBase extends $pb.GeneratedService {
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
      BackendFrontendServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendFrontendServiceBase$messageJson;
}
