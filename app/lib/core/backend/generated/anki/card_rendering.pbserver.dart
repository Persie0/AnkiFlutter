// This is a generated file - do not edit.
//
// Generated from anki/card_rendering.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'card_rendering.pb.dart' as $3;
import 'card_rendering.pbjson.dart';
import 'generic.pb.dart' as $2;

export 'card_rendering.pb.dart';

abstract class CardRenderingServiceBase extends $pb.GeneratedService {
  $async.Future<$3.ExtractAvTagsResponse> extractAvTags(
      $pb.ServerContext ctx, $3.ExtractAvTagsRequest request);
  $async.Future<$3.ExtractLatexResponse> extractLatex(
      $pb.ServerContext ctx, $3.ExtractLatexRequest request);
  $async.Future<$3.EmptyCardsReport> getEmptyCards(
      $pb.ServerContext ctx, $2.Empty request);
  $async.Future<$3.RenderCardResponse> renderExistingCard(
      $pb.ServerContext ctx, $3.RenderExistingCardRequest request);
  $async.Future<$3.RenderCardResponse> renderUncommittedCard(
      $pb.ServerContext ctx, $3.RenderUncommittedCardRequest request);
  $async.Future<$3.RenderCardResponse> renderUncommittedCardLegacy(
      $pb.ServerContext ctx, $3.RenderUncommittedCardLegacyRequest request);
  $async.Future<$2.String> stripAvTags(
      $pb.ServerContext ctx, $2.String request);
  $async.Future<$2.String> renderMarkdown(
      $pb.ServerContext ctx, $3.RenderMarkdownRequest request);
  $async.Future<$2.String> encodeIriPaths(
      $pb.ServerContext ctx, $2.String request);
  $async.Future<$2.String> decodeIriPaths(
      $pb.ServerContext ctx, $2.String request);
  $async.Future<$2.String> stripHtml(
      $pb.ServerContext ctx, $3.StripHtmlRequest request);
  $async.Future<$2.String> htmlToTextLine(
      $pb.ServerContext ctx, $3.HtmlToTextLineRequest request);
  $async.Future<$2.String> compareAnswer(
      $pb.ServerContext ctx, $3.CompareAnswerRequest request);
  $async.Future<$2.String> extractClozeForTyping(
      $pb.ServerContext ctx, $3.ExtractClozeForTypingRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ExtractAvTags':
        return $3.ExtractAvTagsRequest();
      case 'ExtractLatex':
        return $3.ExtractLatexRequest();
      case 'GetEmptyCards':
        return $2.Empty();
      case 'RenderExistingCard':
        return $3.RenderExistingCardRequest();
      case 'RenderUncommittedCard':
        return $3.RenderUncommittedCardRequest();
      case 'RenderUncommittedCardLegacy':
        return $3.RenderUncommittedCardLegacyRequest();
      case 'StripAvTags':
        return $2.String();
      case 'RenderMarkdown':
        return $3.RenderMarkdownRequest();
      case 'EncodeIriPaths':
        return $2.String();
      case 'DecodeIriPaths':
        return $2.String();
      case 'StripHtml':
        return $3.StripHtmlRequest();
      case 'HtmlToTextLine':
        return $3.HtmlToTextLineRequest();
      case 'CompareAnswer':
        return $3.CompareAnswerRequest();
      case 'ExtractClozeForTyping':
        return $3.ExtractClozeForTypingRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ExtractAvTags':
        return extractAvTags(ctx, request as $3.ExtractAvTagsRequest);
      case 'ExtractLatex':
        return extractLatex(ctx, request as $3.ExtractLatexRequest);
      case 'GetEmptyCards':
        return getEmptyCards(ctx, request as $2.Empty);
      case 'RenderExistingCard':
        return renderExistingCard(ctx, request as $3.RenderExistingCardRequest);
      case 'RenderUncommittedCard':
        return renderUncommittedCard(
            ctx, request as $3.RenderUncommittedCardRequest);
      case 'RenderUncommittedCardLegacy':
        return renderUncommittedCardLegacy(
            ctx, request as $3.RenderUncommittedCardLegacyRequest);
      case 'StripAvTags':
        return stripAvTags(ctx, request as $2.String);
      case 'RenderMarkdown':
        return renderMarkdown(ctx, request as $3.RenderMarkdownRequest);
      case 'EncodeIriPaths':
        return encodeIriPaths(ctx, request as $2.String);
      case 'DecodeIriPaths':
        return decodeIriPaths(ctx, request as $2.String);
      case 'StripHtml':
        return stripHtml(ctx, request as $3.StripHtmlRequest);
      case 'HtmlToTextLine':
        return htmlToTextLine(ctx, request as $3.HtmlToTextLineRequest);
      case 'CompareAnswer':
        return compareAnswer(ctx, request as $3.CompareAnswerRequest);
      case 'ExtractClozeForTyping':
        return extractClozeForTyping(
            ctx, request as $3.ExtractClozeForTypingRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      CardRenderingServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => CardRenderingServiceBase$messageJson;
}

abstract class BackendCardRenderingServiceBase extends $pb.GeneratedService {
  $async.Future<$2.String> stripHtml(
      $pb.ServerContext ctx, $3.StripHtmlRequest request);
  $async.Future<$3.AllTtsVoicesResponse> allTtsVoices(
      $pb.ServerContext ctx, $3.AllTtsVoicesRequest request);
  $async.Future<$2.Empty> writeTtsStream(
      $pb.ServerContext ctx, $3.WriteTtsStreamRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'StripHtml':
        return $3.StripHtmlRequest();
      case 'AllTtsVoices':
        return $3.AllTtsVoicesRequest();
      case 'WriteTtsStream':
        return $3.WriteTtsStreamRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'StripHtml':
        return stripHtml(ctx, request as $3.StripHtmlRequest);
      case 'AllTtsVoices':
        return allTtsVoices(ctx, request as $3.AllTtsVoicesRequest);
      case 'WriteTtsStream':
        return writeTtsStream(ctx, request as $3.WriteTtsStreamRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendCardRenderingServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendCardRenderingServiceBase$messageJson;
}
