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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'card_rendering.pbenum.dart';
import 'generic.pb.dart' as $2;
import 'notes.pb.dart' as $0;
import 'notetypes.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'card_rendering.pbenum.dart';

class ExtractAvTagsRequest extends $pb.GeneratedMessage {
  factory ExtractAvTagsRequest({
    $core.String? text,
    $core.bool? questionSide,
  }) {
    final result = ExtractAvTagsRequest._();
    if (text != null) result.text = text;
    if (questionSide != null) result.questionSide = questionSide;
    return result;
  }

  ExtractAvTagsRequest._();

  factory ExtractAvTagsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractAvTagsRequest()..mergeFromBuffer(data, registry);
  factory ExtractAvTagsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractAvTagsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtractAvTagsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: ExtractAvTagsRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOB(2, _omitFieldNames ? '' : 'questionSide')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractAvTagsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractAvTagsRequest copyWith(void Function(ExtractAvTagsRequest) updates) =>
      super.copyWith((message) => updates(message as ExtractAvTagsRequest))
          as ExtractAvTagsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExtractAvTagsRequest() / ExtractAvTagsRequest.new instead')
  static ExtractAvTagsRequest create() => ExtractAvTagsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ExtractAvTagsRequest._();
  @$core.override
  ExtractAvTagsRequest createEmptyInstance() => ExtractAvTagsRequest._();
  @$core.pragma('dart2js:noInline')
  static ExtractAvTagsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExtractAvTagsRequest>(
          ExtractAvTagsRequest.$_createMessage);
  static ExtractAvTagsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get questionSide => $_getBF(1);
  @$pb.TagNumber(2)
  set questionSide($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuestionSide() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuestionSide() => $_clearField(2);
}

class ExtractAvTagsResponse extends $pb.GeneratedMessage {
  factory ExtractAvTagsResponse({
    $core.String? text,
    $core.Iterable<AVTag>? avTags,
  }) {
    final result = ExtractAvTagsResponse._();
    if (text != null) result.text = text;
    if (avTags != null) result.avTags.addAll(avTags);
    return result;
  }

  ExtractAvTagsResponse._();

  factory ExtractAvTagsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractAvTagsResponse()..mergeFromBuffer(data, registry);
  factory ExtractAvTagsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractAvTagsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtractAvTagsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: ExtractAvTagsResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..pPM<AVTag>(2, _omitFieldNames ? '' : 'avTags',
        subBuilder: AVTag.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractAvTagsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractAvTagsResponse copyWith(
          void Function(ExtractAvTagsResponse) updates) =>
      super.copyWith((message) => updates(message as ExtractAvTagsResponse))
          as ExtractAvTagsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExtractAvTagsResponse() / ExtractAvTagsResponse.new instead')
  static ExtractAvTagsResponse create() => ExtractAvTagsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ExtractAvTagsResponse._();
  @$core.override
  ExtractAvTagsResponse createEmptyInstance() => ExtractAvTagsResponse._();
  @$core.pragma('dart2js:noInline')
  static ExtractAvTagsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExtractAvTagsResponse>(
          ExtractAvTagsResponse.$_createMessage);
  static ExtractAvTagsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<AVTag> get avTags => $_getList(1);
}

enum AVTag_Value { soundOrVideo, tts, notSet }

class AVTag extends $pb.GeneratedMessage {
  factory AVTag({
    $core.String? soundOrVideo,
    TTSTag? tts,
  }) {
    final result = AVTag._();
    if (soundOrVideo != null) result.soundOrVideo = soundOrVideo;
    if (tts != null) result.tts = tts;
    return result;
  }

  AVTag._();

  factory AVTag.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AVTag()..mergeFromBuffer(data, registry);
  factory AVTag.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AVTag()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, AVTag_Value> _AVTag_ValueByTag = {
    1: AVTag_Value.soundOrVideo,
    2: AVTag_Value.tts,
    0: AVTag_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AVTag',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: AVTag.$_createMessage)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'soundOrVideo')
    ..aOM<TTSTag>(2, _omitFieldNames ? '' : 'tts',
        subBuilder: TTSTag.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AVTag clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AVTag copyWith(void Function(AVTag) updates) =>
      super.copyWith((message) => updates(message as AVTag)) as AVTag;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AVTag() / AVTag.new instead')
  static AVTag create() => AVTag._();
  static $pb.GeneratedMessage $_createMessage() => AVTag._();
  @$core.override
  AVTag createEmptyInstance() => AVTag._();
  @$core.pragma('dart2js:noInline')
  static AVTag getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AVTag>(AVTag.$_createMessage);
  static AVTag? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  AVTag_Value whichValue() => _AVTag_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get soundOrVideo => $_getSZ(0);
  @$pb.TagNumber(1)
  set soundOrVideo($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSoundOrVideo() => $_has(0);
  @$pb.TagNumber(1)
  void clearSoundOrVideo() => $_clearField(1);

  @$pb.TagNumber(2)
  TTSTag get tts => $_getN(1);
  @$pb.TagNumber(2)
  set tts(TTSTag value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTts() => $_has(1);
  @$pb.TagNumber(2)
  void clearTts() => $_clearField(2);
  @$pb.TagNumber(2)
  TTSTag ensureTts() => $_ensure(1);
}

class TTSTag extends $pb.GeneratedMessage {
  factory TTSTag({
    $core.String? fieldText,
    $core.String? lang,
    $core.Iterable<$core.String>? voices,
    $core.double? speed,
    $core.Iterable<$core.String>? otherArgs,
  }) {
    final result = TTSTag._();
    if (fieldText != null) result.fieldText = fieldText;
    if (lang != null) result.lang = lang;
    if (voices != null) result.voices.addAll(voices);
    if (speed != null) result.speed = speed;
    if (otherArgs != null) result.otherArgs.addAll(otherArgs);
    return result;
  }

  TTSTag._();

  factory TTSTag.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TTSTag()..mergeFromBuffer(data, registry);
  factory TTSTag.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TTSTag()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TTSTag',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: TTSTag.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'fieldText')
    ..aOS(2, _omitFieldNames ? '' : 'lang')
    ..pPS(3, _omitFieldNames ? '' : 'voices')
    ..aD(4, _omitFieldNames ? '' : 'speed', fieldType: $pb.PbFieldType.OF)
    ..pPS(5, _omitFieldNames ? '' : 'otherArgs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TTSTag clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TTSTag copyWith(void Function(TTSTag) updates) =>
      super.copyWith((message) => updates(message as TTSTag)) as TTSTag;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TTSTag() / TTSTag.new instead')
  static TTSTag create() => TTSTag._();
  static $pb.GeneratedMessage $_createMessage() => TTSTag._();
  @$core.override
  TTSTag createEmptyInstance() => TTSTag._();
  @$core.pragma('dart2js:noInline')
  static TTSTag getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TTSTag>(TTSTag.$_createMessage);
  static TTSTag? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fieldText => $_getSZ(0);
  @$pb.TagNumber(1)
  set fieldText($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFieldText() => $_has(0);
  @$pb.TagNumber(1)
  void clearFieldText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lang => $_getSZ(1);
  @$pb.TagNumber(2)
  set lang($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLang() => $_has(1);
  @$pb.TagNumber(2)
  void clearLang() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get voices => $_getList(2);

  @$pb.TagNumber(4)
  $core.double get speed => $_getN(3);
  @$pb.TagNumber(4)
  set speed($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSpeed() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpeed() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get otherArgs => $_getList(4);
}

class ExtractLatexRequest extends $pb.GeneratedMessage {
  factory ExtractLatexRequest({
    $core.String? text,
    $core.bool? svg,
    $core.bool? expandClozes,
  }) {
    final result = ExtractLatexRequest._();
    if (text != null) result.text = text;
    if (svg != null) result.svg = svg;
    if (expandClozes != null) result.expandClozes = expandClozes;
    return result;
  }

  ExtractLatexRequest._();

  factory ExtractLatexRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractLatexRequest()..mergeFromBuffer(data, registry);
  factory ExtractLatexRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractLatexRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtractLatexRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: ExtractLatexRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOB(2, _omitFieldNames ? '' : 'svg')
    ..aOB(3, _omitFieldNames ? '' : 'expandClozes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractLatexRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractLatexRequest copyWith(void Function(ExtractLatexRequest) updates) =>
      super.copyWith((message) => updates(message as ExtractLatexRequest))
          as ExtractLatexRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ExtractLatexRequest() / ExtractLatexRequest.new instead')
  static ExtractLatexRequest create() => ExtractLatexRequest._();
  static $pb.GeneratedMessage $_createMessage() => ExtractLatexRequest._();
  @$core.override
  ExtractLatexRequest createEmptyInstance() => ExtractLatexRequest._();
  @$core.pragma('dart2js:noInline')
  static ExtractLatexRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExtractLatexRequest>(
          ExtractLatexRequest.$_createMessage);
  static ExtractLatexRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get svg => $_getBF(1);
  @$pb.TagNumber(2)
  set svg($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSvg() => $_has(1);
  @$pb.TagNumber(2)
  void clearSvg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get expandClozes => $_getBF(2);
  @$pb.TagNumber(3)
  set expandClozes($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpandClozes() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpandClozes() => $_clearField(3);
}

class ExtractLatexResponse extends $pb.GeneratedMessage {
  factory ExtractLatexResponse({
    $core.String? text,
    $core.Iterable<ExtractedLatex>? latex,
  }) {
    final result = ExtractLatexResponse._();
    if (text != null) result.text = text;
    if (latex != null) result.latex.addAll(latex);
    return result;
  }

  ExtractLatexResponse._();

  factory ExtractLatexResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractLatexResponse()..mergeFromBuffer(data, registry);
  factory ExtractLatexResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractLatexResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtractLatexResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: ExtractLatexResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..pPM<ExtractedLatex>(2, _omitFieldNames ? '' : 'latex',
        subBuilder: ExtractedLatex.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractLatexResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractLatexResponse copyWith(void Function(ExtractLatexResponse) updates) =>
      super.copyWith((message) => updates(message as ExtractLatexResponse))
          as ExtractLatexResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExtractLatexResponse() / ExtractLatexResponse.new instead')
  static ExtractLatexResponse create() => ExtractLatexResponse._();
  static $pb.GeneratedMessage $_createMessage() => ExtractLatexResponse._();
  @$core.override
  ExtractLatexResponse createEmptyInstance() => ExtractLatexResponse._();
  @$core.pragma('dart2js:noInline')
  static ExtractLatexResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExtractLatexResponse>(
          ExtractLatexResponse.$_createMessage);
  static ExtractLatexResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<ExtractedLatex> get latex => $_getList(1);
}

class ExtractedLatex extends $pb.GeneratedMessage {
  factory ExtractedLatex({
    $core.String? filename,
    $core.String? latexBody,
  }) {
    final result = ExtractedLatex._();
    if (filename != null) result.filename = filename;
    if (latexBody != null) result.latexBody = latexBody;
    return result;
  }

  ExtractedLatex._();

  factory ExtractedLatex.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractedLatex()..mergeFromBuffer(data, registry);
  factory ExtractedLatex.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractedLatex()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtractedLatex',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: ExtractedLatex.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'filename')
    ..aOS(2, _omitFieldNames ? '' : 'latexBody')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractedLatex clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractedLatex copyWith(void Function(ExtractedLatex) updates) =>
      super.copyWith((message) => updates(message as ExtractedLatex))
          as ExtractedLatex;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ExtractedLatex() / ExtractedLatex.new instead')
  static ExtractedLatex create() => ExtractedLatex._();
  static $pb.GeneratedMessage $_createMessage() => ExtractedLatex._();
  @$core.override
  ExtractedLatex createEmptyInstance() => ExtractedLatex._();
  @$core.pragma('dart2js:noInline')
  static ExtractedLatex getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtractedLatex>(
          ExtractedLatex.$_createMessage);
  static ExtractedLatex? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get filename => $_getSZ(0);
  @$pb.TagNumber(1)
  set filename($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFilename() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilename() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get latexBody => $_getSZ(1);
  @$pb.TagNumber(2)
  set latexBody($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLatexBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatexBody() => $_clearField(2);
}

class EmptyCardsReport_NoteWithEmptyCards extends $pb.GeneratedMessage {
  factory EmptyCardsReport_NoteWithEmptyCards({
    $fixnum.Int64? noteId,
    $core.Iterable<$fixnum.Int64>? cardIds,
    $core.bool? willDeleteNote,
  }) {
    final result = EmptyCardsReport_NoteWithEmptyCards._();
    if (noteId != null) result.noteId = noteId;
    if (cardIds != null) result.cardIds.addAll(cardIds);
    if (willDeleteNote != null) result.willDeleteNote = willDeleteNote;
    return result;
  }

  EmptyCardsReport_NoteWithEmptyCards._();

  factory EmptyCardsReport_NoteWithEmptyCards.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EmptyCardsReport_NoteWithEmptyCards()..mergeFromBuffer(data, registry);
  factory EmptyCardsReport_NoteWithEmptyCards.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EmptyCardsReport_NoteWithEmptyCards()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EmptyCardsReport.NoteWithEmptyCards',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: EmptyCardsReport_NoteWithEmptyCards.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'noteId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'cardIds', $pb.PbFieldType.K6)
    ..aOB(3, _omitFieldNames ? '' : 'willDeleteNote')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmptyCardsReport_NoteWithEmptyCards clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmptyCardsReport_NoteWithEmptyCards copyWith(
          void Function(EmptyCardsReport_NoteWithEmptyCards) updates) =>
      super.copyWith((message) =>
              updates(message as EmptyCardsReport_NoteWithEmptyCards))
          as EmptyCardsReport_NoteWithEmptyCards;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use EmptyCardsReport_NoteWithEmptyCards() / EmptyCardsReport_NoteWithEmptyCards.new instead')
  static EmptyCardsReport_NoteWithEmptyCards create() =>
      EmptyCardsReport_NoteWithEmptyCards._();
  static $pb.GeneratedMessage $_createMessage() =>
      EmptyCardsReport_NoteWithEmptyCards._();
  @$core.override
  EmptyCardsReport_NoteWithEmptyCards createEmptyInstance() =>
      EmptyCardsReport_NoteWithEmptyCards._();
  @$core.pragma('dart2js:noInline')
  static EmptyCardsReport_NoteWithEmptyCards getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              EmptyCardsReport_NoteWithEmptyCards>(
          EmptyCardsReport_NoteWithEmptyCards.$_createMessage);
  static EmptyCardsReport_NoteWithEmptyCards? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get noteId => $_getI64(0);
  @$pb.TagNumber(1)
  set noteId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get cardIds => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get willDeleteNote => $_getBF(2);
  @$pb.TagNumber(3)
  set willDeleteNote($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWillDeleteNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearWillDeleteNote() => $_clearField(3);
}

class EmptyCardsReport extends $pb.GeneratedMessage {
  factory EmptyCardsReport({
    $core.String? report,
    $core.Iterable<EmptyCardsReport_NoteWithEmptyCards>? notes,
  }) {
    final result = EmptyCardsReport._();
    if (report != null) result.report = report;
    if (notes != null) result.notes.addAll(notes);
    return result;
  }

  EmptyCardsReport._();

  factory EmptyCardsReport.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EmptyCardsReport()..mergeFromBuffer(data, registry);
  factory EmptyCardsReport.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EmptyCardsReport()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EmptyCardsReport',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: EmptyCardsReport.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'report')
    ..pPM<EmptyCardsReport_NoteWithEmptyCards>(
        2, _omitFieldNames ? '' : 'notes',
        subBuilder: EmptyCardsReport_NoteWithEmptyCards.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmptyCardsReport clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmptyCardsReport copyWith(void Function(EmptyCardsReport) updates) =>
      super.copyWith((message) => updates(message as EmptyCardsReport))
          as EmptyCardsReport;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EmptyCardsReport() / EmptyCardsReport.new instead')
  static EmptyCardsReport create() => EmptyCardsReport._();
  static $pb.GeneratedMessage $_createMessage() => EmptyCardsReport._();
  @$core.override
  EmptyCardsReport createEmptyInstance() => EmptyCardsReport._();
  @$core.pragma('dart2js:noInline')
  static EmptyCardsReport getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyCardsReport>(
          EmptyCardsReport.$_createMessage);
  static EmptyCardsReport? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get report => $_getSZ(0);
  @$pb.TagNumber(1)
  set report($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReport() => $_has(0);
  @$pb.TagNumber(1)
  void clearReport() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<EmptyCardsReport_NoteWithEmptyCards> get notes => $_getList(1);
}

class RenderExistingCardRequest extends $pb.GeneratedMessage {
  factory RenderExistingCardRequest({
    $fixnum.Int64? cardId,
    $core.bool? browser,
    $core.bool? partialRender,
  }) {
    final result = RenderExistingCardRequest._();
    if (cardId != null) result.cardId = cardId;
    if (browser != null) result.browser = browser;
    if (partialRender != null) result.partialRender = partialRender;
    return result;
  }

  RenderExistingCardRequest._();

  factory RenderExistingCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderExistingCardRequest()..mergeFromBuffer(data, registry);
  factory RenderExistingCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderExistingCardRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenderExistingCardRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: RenderExistingCardRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'cardId')
    ..aOB(2, _omitFieldNames ? '' : 'browser')
    ..aOB(3, _omitFieldNames ? '' : 'partialRender')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderExistingCardRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderExistingCardRequest copyWith(
          void Function(RenderExistingCardRequest) updates) =>
      super.copyWith((message) => updates(message as RenderExistingCardRequest))
          as RenderExistingCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RenderExistingCardRequest() / RenderExistingCardRequest.new instead')
  static RenderExistingCardRequest create() => RenderExistingCardRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      RenderExistingCardRequest._();
  @$core.override
  RenderExistingCardRequest createEmptyInstance() =>
      RenderExistingCardRequest._();
  @$core.pragma('dart2js:noInline')
  static RenderExistingCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenderExistingCardRequest>(
          RenderExistingCardRequest.$_createMessage);
  static RenderExistingCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get cardId => $_getI64(0);
  @$pb.TagNumber(1)
  set cardId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get browser => $_getBF(1);
  @$pb.TagNumber(2)
  set browser($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBrowser() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrowser() => $_clearField(2);

  /// If true, rendering will stop when an unknown filter is encountered,
  /// and caller will need to complete rendering. This is done to allow
  /// Python code to modify the rendering.
  @$pb.TagNumber(3)
  $core.bool get partialRender => $_getBF(2);
  @$pb.TagNumber(3)
  set partialRender($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPartialRender() => $_has(2);
  @$pb.TagNumber(3)
  void clearPartialRender() => $_clearField(3);
}

class RenderUncommittedCardRequest extends $pb.GeneratedMessage {
  factory RenderUncommittedCardRequest({
    $0.Note? note,
    $core.int? cardOrd,
    $1.Notetype_Template? template,
    $core.bool? fillEmpty,
    $core.bool? partialRender,
  }) {
    final result = RenderUncommittedCardRequest._();
    if (note != null) result.note = note;
    if (cardOrd != null) result.cardOrd = cardOrd;
    if (template != null) result.template = template;
    if (fillEmpty != null) result.fillEmpty = fillEmpty;
    if (partialRender != null) result.partialRender = partialRender;
    return result;
  }

  RenderUncommittedCardRequest._();

  factory RenderUncommittedCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderUncommittedCardRequest()..mergeFromBuffer(data, registry);
  factory RenderUncommittedCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderUncommittedCardRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenderUncommittedCardRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: RenderUncommittedCardRequest.$_createMessage)
    ..aOM<$0.Note>(1, _omitFieldNames ? '' : 'note',
        subBuilder: $0.Note.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'cardOrd', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$1.Notetype_Template>(3, _omitFieldNames ? '' : 'template',
        subBuilder: $1.Notetype_Template.$_createMessage)
    ..aOB(4, _omitFieldNames ? '' : 'fillEmpty')
    ..aOB(5, _omitFieldNames ? '' : 'partialRender')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderUncommittedCardRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderUncommittedCardRequest copyWith(
          void Function(RenderUncommittedCardRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RenderUncommittedCardRequest))
          as RenderUncommittedCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RenderUncommittedCardRequest() / RenderUncommittedCardRequest.new instead')
  static RenderUncommittedCardRequest create() =>
      RenderUncommittedCardRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      RenderUncommittedCardRequest._();
  @$core.override
  RenderUncommittedCardRequest createEmptyInstance() =>
      RenderUncommittedCardRequest._();
  @$core.pragma('dart2js:noInline')
  static RenderUncommittedCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenderUncommittedCardRequest>(
          RenderUncommittedCardRequest.$_createMessage);
  static RenderUncommittedCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Note get note => $_getN(0);
  @$pb.TagNumber(1)
  set note($0.Note value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNote() => $_has(0);
  @$pb.TagNumber(1)
  void clearNote() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Note ensureNote() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get cardOrd => $_getIZ(1);
  @$pb.TagNumber(2)
  set cardOrd($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardOrd() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardOrd() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Notetype_Template get template => $_getN(2);
  @$pb.TagNumber(3)
  set template($1.Notetype_Template value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTemplate() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemplate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Notetype_Template ensureTemplate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get fillEmpty => $_getBF(3);
  @$pb.TagNumber(4)
  set fillEmpty($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFillEmpty() => $_has(3);
  @$pb.TagNumber(4)
  void clearFillEmpty() => $_clearField(4);

  /// If true, rendering will stop when an unknown filter is encountered,
  /// and caller will need to complete rendering. This is done to allow
  /// Python code to modify the rendering.
  @$pb.TagNumber(5)
  $core.bool get partialRender => $_getBF(4);
  @$pb.TagNumber(5)
  set partialRender($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPartialRender() => $_has(4);
  @$pb.TagNumber(5)
  void clearPartialRender() => $_clearField(5);
}

class RenderUncommittedCardLegacyRequest extends $pb.GeneratedMessage {
  factory RenderUncommittedCardLegacyRequest({
    $0.Note? note,
    $core.int? cardOrd,
    $core.List<$core.int>? template,
    $core.bool? fillEmpty,
    $core.bool? partialRender,
  }) {
    final result = RenderUncommittedCardLegacyRequest._();
    if (note != null) result.note = note;
    if (cardOrd != null) result.cardOrd = cardOrd;
    if (template != null) result.template = template;
    if (fillEmpty != null) result.fillEmpty = fillEmpty;
    if (partialRender != null) result.partialRender = partialRender;
    return result;
  }

  RenderUncommittedCardLegacyRequest._();

  factory RenderUncommittedCardLegacyRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderUncommittedCardLegacyRequest()..mergeFromBuffer(data, registry);
  factory RenderUncommittedCardLegacyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderUncommittedCardLegacyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenderUncommittedCardLegacyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: RenderUncommittedCardLegacyRequest.$_createMessage)
    ..aOM<$0.Note>(1, _omitFieldNames ? '' : 'note',
        subBuilder: $0.Note.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'cardOrd', fieldType: $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'template', $pb.PbFieldType.OY)
    ..aOB(4, _omitFieldNames ? '' : 'fillEmpty')
    ..aOB(5, _omitFieldNames ? '' : 'partialRender')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderUncommittedCardLegacyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderUncommittedCardLegacyRequest copyWith(
          void Function(RenderUncommittedCardLegacyRequest) updates) =>
      super.copyWith((message) =>
              updates(message as RenderUncommittedCardLegacyRequest))
          as RenderUncommittedCardLegacyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RenderUncommittedCardLegacyRequest() / RenderUncommittedCardLegacyRequest.new instead')
  static RenderUncommittedCardLegacyRequest create() =>
      RenderUncommittedCardLegacyRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      RenderUncommittedCardLegacyRequest._();
  @$core.override
  RenderUncommittedCardLegacyRequest createEmptyInstance() =>
      RenderUncommittedCardLegacyRequest._();
  @$core.pragma('dart2js:noInline')
  static RenderUncommittedCardLegacyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenderUncommittedCardLegacyRequest>(
          RenderUncommittedCardLegacyRequest.$_createMessage);
  static RenderUncommittedCardLegacyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Note get note => $_getN(0);
  @$pb.TagNumber(1)
  set note($0.Note value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNote() => $_has(0);
  @$pb.TagNumber(1)
  void clearNote() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Note ensureNote() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get cardOrd => $_getIZ(1);
  @$pb.TagNumber(2)
  set cardOrd($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardOrd() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardOrd() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get template => $_getN(2);
  @$pb.TagNumber(3)
  set template($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTemplate() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemplate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get fillEmpty => $_getBF(3);
  @$pb.TagNumber(4)
  set fillEmpty($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFillEmpty() => $_has(3);
  @$pb.TagNumber(4)
  void clearFillEmpty() => $_clearField(4);

  /// If true, rendering will stop when an unknown filter is encountered,
  /// and caller will need to complete rendering. This is done to allow
  /// Python code to modify the rendering.
  @$pb.TagNumber(5)
  $core.bool get partialRender => $_getBF(4);
  @$pb.TagNumber(5)
  set partialRender($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPartialRender() => $_has(4);
  @$pb.TagNumber(5)
  void clearPartialRender() => $_clearField(5);
}

class RenderCardResponse extends $pb.GeneratedMessage {
  factory RenderCardResponse({
    $core.Iterable<RenderedTemplateNode>? questionNodes,
    $core.Iterable<RenderedTemplateNode>? answerNodes,
    $core.String? css,
    $core.bool? latexSvg,
    $core.bool? isEmpty,
  }) {
    final result = RenderCardResponse._();
    if (questionNodes != null) result.questionNodes.addAll(questionNodes);
    if (answerNodes != null) result.answerNodes.addAll(answerNodes);
    if (css != null) result.css = css;
    if (latexSvg != null) result.latexSvg = latexSvg;
    if (isEmpty != null) result.isEmpty = isEmpty;
    return result;
  }

  RenderCardResponse._();

  factory RenderCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderCardResponse()..mergeFromBuffer(data, registry);
  factory RenderCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderCardResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenderCardResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: RenderCardResponse.$_createMessage)
    ..pPM<RenderedTemplateNode>(1, _omitFieldNames ? '' : 'questionNodes',
        subBuilder: RenderedTemplateNode.$_createMessage)
    ..pPM<RenderedTemplateNode>(2, _omitFieldNames ? '' : 'answerNodes',
        subBuilder: RenderedTemplateNode.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'css')
    ..aOB(4, _omitFieldNames ? '' : 'latexSvg')
    ..aOB(5, _omitFieldNames ? '' : 'isEmpty')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderCardResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderCardResponse copyWith(void Function(RenderCardResponse) updates) =>
      super.copyWith((message) => updates(message as RenderCardResponse))
          as RenderCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RenderCardResponse() / RenderCardResponse.new instead')
  static RenderCardResponse create() => RenderCardResponse._();
  static $pb.GeneratedMessage $_createMessage() => RenderCardResponse._();
  @$core.override
  RenderCardResponse createEmptyInstance() => RenderCardResponse._();
  @$core.pragma('dart2js:noInline')
  static RenderCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenderCardResponse>(
          RenderCardResponse.$_createMessage);
  static RenderCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RenderedTemplateNode> get questionNodes => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<RenderedTemplateNode> get answerNodes => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get css => $_getSZ(2);
  @$pb.TagNumber(3)
  set css($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCss() => $_has(2);
  @$pb.TagNumber(3)
  void clearCss() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get latexSvg => $_getBF(3);
  @$pb.TagNumber(4)
  set latexSvg($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLatexSvg() => $_has(3);
  @$pb.TagNumber(4)
  void clearLatexSvg() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isEmpty => $_getBF(4);
  @$pb.TagNumber(5)
  set isEmpty($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsEmpty() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsEmpty() => $_clearField(5);
}

enum RenderedTemplateNode_Value { text, replacement, notSet }

class RenderedTemplateNode extends $pb.GeneratedMessage {
  factory RenderedTemplateNode({
    $core.String? text,
    RenderedTemplateReplacement? replacement,
  }) {
    final result = RenderedTemplateNode._();
    if (text != null) result.text = text;
    if (replacement != null) result.replacement = replacement;
    return result;
  }

  RenderedTemplateNode._();

  factory RenderedTemplateNode.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderedTemplateNode()..mergeFromBuffer(data, registry);
  factory RenderedTemplateNode.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderedTemplateNode()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, RenderedTemplateNode_Value>
      _RenderedTemplateNode_ValueByTag = {
    1: RenderedTemplateNode_Value.text,
    2: RenderedTemplateNode_Value.replacement,
    0: RenderedTemplateNode_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenderedTemplateNode',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: RenderedTemplateNode.$_createMessage)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOM<RenderedTemplateReplacement>(2, _omitFieldNames ? '' : 'replacement',
        subBuilder: RenderedTemplateReplacement.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderedTemplateNode clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderedTemplateNode copyWith(void Function(RenderedTemplateNode) updates) =>
      super.copyWith((message) => updates(message as RenderedTemplateNode))
          as RenderedTemplateNode;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RenderedTemplateNode() / RenderedTemplateNode.new instead')
  static RenderedTemplateNode create() => RenderedTemplateNode._();
  static $pb.GeneratedMessage $_createMessage() => RenderedTemplateNode._();
  @$core.override
  RenderedTemplateNode createEmptyInstance() => RenderedTemplateNode._();
  @$core.pragma('dart2js:noInline')
  static RenderedTemplateNode getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenderedTemplateNode>(
          RenderedTemplateNode.$_createMessage);
  static RenderedTemplateNode? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  RenderedTemplateNode_Value whichValue() =>
      _RenderedTemplateNode_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  RenderedTemplateReplacement get replacement => $_getN(1);
  @$pb.TagNumber(2)
  set replacement(RenderedTemplateReplacement value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReplacement() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplacement() => $_clearField(2);
  @$pb.TagNumber(2)
  RenderedTemplateReplacement ensureReplacement() => $_ensure(1);
}

class RenderedTemplateReplacement extends $pb.GeneratedMessage {
  factory RenderedTemplateReplacement({
    $core.String? fieldName,
    $core.String? currentText,
    $core.Iterable<$core.String>? filters,
  }) {
    final result = RenderedTemplateReplacement._();
    if (fieldName != null) result.fieldName = fieldName;
    if (currentText != null) result.currentText = currentText;
    if (filters != null) result.filters.addAll(filters);
    return result;
  }

  RenderedTemplateReplacement._();

  factory RenderedTemplateReplacement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderedTemplateReplacement()..mergeFromBuffer(data, registry);
  factory RenderedTemplateReplacement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderedTemplateReplacement()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenderedTemplateReplacement',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: RenderedTemplateReplacement.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'fieldName')
    ..aOS(2, _omitFieldNames ? '' : 'currentText')
    ..pPS(3, _omitFieldNames ? '' : 'filters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderedTemplateReplacement clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderedTemplateReplacement copyWith(
          void Function(RenderedTemplateReplacement) updates) =>
      super.copyWith(
              (message) => updates(message as RenderedTemplateReplacement))
          as RenderedTemplateReplacement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RenderedTemplateReplacement() / RenderedTemplateReplacement.new instead')
  static RenderedTemplateReplacement create() =>
      RenderedTemplateReplacement._();
  static $pb.GeneratedMessage $_createMessage() =>
      RenderedTemplateReplacement._();
  @$core.override
  RenderedTemplateReplacement createEmptyInstance() =>
      RenderedTemplateReplacement._();
  @$core.pragma('dart2js:noInline')
  static RenderedTemplateReplacement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenderedTemplateReplacement>(
          RenderedTemplateReplacement.$_createMessage);
  static RenderedTemplateReplacement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fieldName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fieldName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFieldName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFieldName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currentText => $_getSZ(1);
  @$pb.TagNumber(2)
  set currentText($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentText() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentText() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get filters => $_getList(2);
}

class RenderMarkdownRequest extends $pb.GeneratedMessage {
  factory RenderMarkdownRequest({
    $core.String? markdown,
    $core.bool? sanitize,
  }) {
    final result = RenderMarkdownRequest._();
    if (markdown != null) result.markdown = markdown;
    if (sanitize != null) result.sanitize = sanitize;
    return result;
  }

  RenderMarkdownRequest._();

  factory RenderMarkdownRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderMarkdownRequest()..mergeFromBuffer(data, registry);
  factory RenderMarkdownRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenderMarkdownRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenderMarkdownRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: RenderMarkdownRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'markdown')
    ..aOB(2, _omitFieldNames ? '' : 'sanitize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderMarkdownRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenderMarkdownRequest copyWith(
          void Function(RenderMarkdownRequest) updates) =>
      super.copyWith((message) => updates(message as RenderMarkdownRequest))
          as RenderMarkdownRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RenderMarkdownRequest() / RenderMarkdownRequest.new instead')
  static RenderMarkdownRequest create() => RenderMarkdownRequest._();
  static $pb.GeneratedMessage $_createMessage() => RenderMarkdownRequest._();
  @$core.override
  RenderMarkdownRequest createEmptyInstance() => RenderMarkdownRequest._();
  @$core.pragma('dart2js:noInline')
  static RenderMarkdownRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RenderMarkdownRequest>(
          RenderMarkdownRequest.$_createMessage);
  static RenderMarkdownRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get markdown => $_getSZ(0);
  @$pb.TagNumber(1)
  set markdown($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMarkdown() => $_has(0);
  @$pb.TagNumber(1)
  void clearMarkdown() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get sanitize => $_getBF(1);
  @$pb.TagNumber(2)
  set sanitize($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSanitize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSanitize() => $_clearField(2);
}

class StripHtmlRequest extends $pb.GeneratedMessage {
  factory StripHtmlRequest({
    $core.String? text,
    StripHtmlRequest_Mode? mode,
  }) {
    final result = StripHtmlRequest._();
    if (text != null) result.text = text;
    if (mode != null) result.mode = mode;
    return result;
  }

  StripHtmlRequest._();

  factory StripHtmlRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StripHtmlRequest()..mergeFromBuffer(data, registry);
  factory StripHtmlRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StripHtmlRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StripHtmlRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: StripHtmlRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aE<StripHtmlRequest_Mode>(2, _omitFieldNames ? '' : 'mode',
        enumValues: StripHtmlRequest_Mode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StripHtmlRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StripHtmlRequest copyWith(void Function(StripHtmlRequest) updates) =>
      super.copyWith((message) => updates(message as StripHtmlRequest))
          as StripHtmlRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StripHtmlRequest() / StripHtmlRequest.new instead')
  static StripHtmlRequest create() => StripHtmlRequest._();
  static $pb.GeneratedMessage $_createMessage() => StripHtmlRequest._();
  @$core.override
  StripHtmlRequest createEmptyInstance() => StripHtmlRequest._();
  @$core.pragma('dart2js:noInline')
  static StripHtmlRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StripHtmlRequest>(
          StripHtmlRequest.$_createMessage);
  static StripHtmlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  StripHtmlRequest_Mode get mode => $_getN(1);
  @$pb.TagNumber(2)
  set mode(StripHtmlRequest_Mode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => $_clearField(2);
}

class HtmlToTextLineRequest extends $pb.GeneratedMessage {
  factory HtmlToTextLineRequest({
    $core.String? text,
    $core.bool? preserveMediaFilenames,
  }) {
    final result = HtmlToTextLineRequest._();
    if (text != null) result.text = text;
    if (preserveMediaFilenames != null)
      result.preserveMediaFilenames = preserveMediaFilenames;
    return result;
  }

  HtmlToTextLineRequest._();

  factory HtmlToTextLineRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HtmlToTextLineRequest()..mergeFromBuffer(data, registry);
  factory HtmlToTextLineRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HtmlToTextLineRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HtmlToTextLineRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: HtmlToTextLineRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOB(2, _omitFieldNames ? '' : 'preserveMediaFilenames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HtmlToTextLineRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HtmlToTextLineRequest copyWith(
          void Function(HtmlToTextLineRequest) updates) =>
      super.copyWith((message) => updates(message as HtmlToTextLineRequest))
          as HtmlToTextLineRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use HtmlToTextLineRequest() / HtmlToTextLineRequest.new instead')
  static HtmlToTextLineRequest create() => HtmlToTextLineRequest._();
  static $pb.GeneratedMessage $_createMessage() => HtmlToTextLineRequest._();
  @$core.override
  HtmlToTextLineRequest createEmptyInstance() => HtmlToTextLineRequest._();
  @$core.pragma('dart2js:noInline')
  static HtmlToTextLineRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HtmlToTextLineRequest>(
          HtmlToTextLineRequest.$_createMessage);
  static HtmlToTextLineRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get preserveMediaFilenames => $_getBF(1);
  @$pb.TagNumber(2)
  set preserveMediaFilenames($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreserveMediaFilenames() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreserveMediaFilenames() => $_clearField(2);
}

class CompareAnswerRequest extends $pb.GeneratedMessage {
  factory CompareAnswerRequest({
    $core.String? expected,
    $core.String? provided,
    $core.bool? combining,
  }) {
    final result = CompareAnswerRequest._();
    if (expected != null) result.expected = expected;
    if (provided != null) result.provided = provided;
    if (combining != null) result.combining = combining;
    return result;
  }

  CompareAnswerRequest._();

  factory CompareAnswerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompareAnswerRequest()..mergeFromBuffer(data, registry);
  factory CompareAnswerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompareAnswerRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompareAnswerRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: CompareAnswerRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'expected')
    ..aOS(2, _omitFieldNames ? '' : 'provided')
    ..aOB(3, _omitFieldNames ? '' : 'combining')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompareAnswerRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompareAnswerRequest copyWith(void Function(CompareAnswerRequest) updates) =>
      super.copyWith((message) => updates(message as CompareAnswerRequest))
          as CompareAnswerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CompareAnswerRequest() / CompareAnswerRequest.new instead')
  static CompareAnswerRequest create() => CompareAnswerRequest._();
  static $pb.GeneratedMessage $_createMessage() => CompareAnswerRequest._();
  @$core.override
  CompareAnswerRequest createEmptyInstance() => CompareAnswerRequest._();
  @$core.pragma('dart2js:noInline')
  static CompareAnswerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompareAnswerRequest>(
          CompareAnswerRequest.$_createMessage);
  static CompareAnswerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expected => $_getSZ(0);
  @$pb.TagNumber(1)
  set expected($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExpected() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpected() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provided => $_getSZ(1);
  @$pb.TagNumber(2)
  set provided($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvided() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvided() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get combining => $_getBF(2);
  @$pb.TagNumber(3)
  set combining($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCombining() => $_has(2);
  @$pb.TagNumber(3)
  void clearCombining() => $_clearField(3);
}

class ExtractClozeForTypingRequest extends $pb.GeneratedMessage {
  factory ExtractClozeForTypingRequest({
    $core.String? text,
    $core.int? ordinal,
  }) {
    final result = ExtractClozeForTypingRequest._();
    if (text != null) result.text = text;
    if (ordinal != null) result.ordinal = ordinal;
    return result;
  }

  ExtractClozeForTypingRequest._();

  factory ExtractClozeForTypingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractClozeForTypingRequest()..mergeFromBuffer(data, registry);
  factory ExtractClozeForTypingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExtractClozeForTypingRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExtractClozeForTypingRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: ExtractClozeForTypingRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aI(2, _omitFieldNames ? '' : 'ordinal', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractClozeForTypingRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractClozeForTypingRequest copyWith(
          void Function(ExtractClozeForTypingRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ExtractClozeForTypingRequest))
          as ExtractClozeForTypingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExtractClozeForTypingRequest() / ExtractClozeForTypingRequest.new instead')
  static ExtractClozeForTypingRequest create() =>
      ExtractClozeForTypingRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ExtractClozeForTypingRequest._();
  @$core.override
  ExtractClozeForTypingRequest createEmptyInstance() =>
      ExtractClozeForTypingRequest._();
  @$core.pragma('dart2js:noInline')
  static ExtractClozeForTypingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExtractClozeForTypingRequest>(
          ExtractClozeForTypingRequest.$_createMessage);
  static ExtractClozeForTypingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get ordinal => $_getIZ(1);
  @$pb.TagNumber(2)
  set ordinal($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrdinal() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrdinal() => $_clearField(2);
}

class AllTtsVoicesRequest extends $pb.GeneratedMessage {
  factory AllTtsVoicesRequest({
    $core.bool? validate,
  }) {
    final result = AllTtsVoicesRequest._();
    if (validate != null) result.validate = validate;
    return result;
  }

  AllTtsVoicesRequest._();

  factory AllTtsVoicesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AllTtsVoicesRequest()..mergeFromBuffer(data, registry);
  factory AllTtsVoicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AllTtsVoicesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllTtsVoicesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: AllTtsVoicesRequest.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'validate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllTtsVoicesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllTtsVoicesRequest copyWith(void Function(AllTtsVoicesRequest) updates) =>
      super.copyWith((message) => updates(message as AllTtsVoicesRequest))
          as AllTtsVoicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use AllTtsVoicesRequest() / AllTtsVoicesRequest.new instead')
  static AllTtsVoicesRequest create() => AllTtsVoicesRequest._();
  static $pb.GeneratedMessage $_createMessage() => AllTtsVoicesRequest._();
  @$core.override
  AllTtsVoicesRequest createEmptyInstance() => AllTtsVoicesRequest._();
  @$core.pragma('dart2js:noInline')
  static AllTtsVoicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllTtsVoicesRequest>(
          AllTtsVoicesRequest.$_createMessage);
  static AllTtsVoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get validate => $_getBF(0);
  @$pb.TagNumber(1)
  set validate($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValidate() => $_has(0);
  @$pb.TagNumber(1)
  void clearValidate() => $_clearField(1);
}

class AllTtsVoicesResponse_TtsVoice extends $pb.GeneratedMessage {
  factory AllTtsVoicesResponse_TtsVoice({
    $core.String? id,
    $core.String? name,
    $core.String? language,
    $core.bool? available,
  }) {
    final result = AllTtsVoicesResponse_TtsVoice._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (language != null) result.language = language;
    if (available != null) result.available = available;
    return result;
  }

  AllTtsVoicesResponse_TtsVoice._();

  factory AllTtsVoicesResponse_TtsVoice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AllTtsVoicesResponse_TtsVoice()..mergeFromBuffer(data, registry);
  factory AllTtsVoicesResponse_TtsVoice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AllTtsVoicesResponse_TtsVoice()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllTtsVoicesResponse.TtsVoice',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: AllTtsVoicesResponse_TtsVoice.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'language')
    ..aOB(4, _omitFieldNames ? '' : 'available')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllTtsVoicesResponse_TtsVoice clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllTtsVoicesResponse_TtsVoice copyWith(
          void Function(AllTtsVoicesResponse_TtsVoice) updates) =>
      super.copyWith(
              (message) => updates(message as AllTtsVoicesResponse_TtsVoice))
          as AllTtsVoicesResponse_TtsVoice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AllTtsVoicesResponse_TtsVoice() / AllTtsVoicesResponse_TtsVoice.new instead')
  static AllTtsVoicesResponse_TtsVoice create() =>
      AllTtsVoicesResponse_TtsVoice._();
  static $pb.GeneratedMessage $_createMessage() =>
      AllTtsVoicesResponse_TtsVoice._();
  @$core.override
  AllTtsVoicesResponse_TtsVoice createEmptyInstance() =>
      AllTtsVoicesResponse_TtsVoice._();
  @$core.pragma('dart2js:noInline')
  static AllTtsVoicesResponse_TtsVoice getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllTtsVoicesResponse_TtsVoice>(
          AllTtsVoicesResponse_TtsVoice.$_createMessage);
  static AllTtsVoicesResponse_TtsVoice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get language => $_getSZ(2);
  @$pb.TagNumber(3)
  set language($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLanguage() => $_has(2);
  @$pb.TagNumber(3)
  void clearLanguage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get available => $_getBF(3);
  @$pb.TagNumber(4)
  set available($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvailable() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailable() => $_clearField(4);
}

class AllTtsVoicesResponse extends $pb.GeneratedMessage {
  factory AllTtsVoicesResponse({
    $core.Iterable<AllTtsVoicesResponse_TtsVoice>? voices,
  }) {
    final result = AllTtsVoicesResponse._();
    if (voices != null) result.voices.addAll(voices);
    return result;
  }

  AllTtsVoicesResponse._();

  factory AllTtsVoicesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AllTtsVoicesResponse()..mergeFromBuffer(data, registry);
  factory AllTtsVoicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AllTtsVoicesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllTtsVoicesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: AllTtsVoicesResponse.$_createMessage)
    ..pPM<AllTtsVoicesResponse_TtsVoice>(1, _omitFieldNames ? '' : 'voices',
        subBuilder: AllTtsVoicesResponse_TtsVoice.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllTtsVoicesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllTtsVoicesResponse copyWith(void Function(AllTtsVoicesResponse) updates) =>
      super.copyWith((message) => updates(message as AllTtsVoicesResponse))
          as AllTtsVoicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AllTtsVoicesResponse() / AllTtsVoicesResponse.new instead')
  static AllTtsVoicesResponse create() => AllTtsVoicesResponse._();
  static $pb.GeneratedMessage $_createMessage() => AllTtsVoicesResponse._();
  @$core.override
  AllTtsVoicesResponse createEmptyInstance() => AllTtsVoicesResponse._();
  @$core.pragma('dart2js:noInline')
  static AllTtsVoicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllTtsVoicesResponse>(
          AllTtsVoicesResponse.$_createMessage);
  static AllTtsVoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AllTtsVoicesResponse_TtsVoice> get voices => $_getList(0);
}

class WriteTtsStreamRequest extends $pb.GeneratedMessage {
  factory WriteTtsStreamRequest({
    $core.String? path,
    $core.String? voiceId,
    $core.double? speed,
    $core.String? text,
  }) {
    final result = WriteTtsStreamRequest._();
    if (path != null) result.path = path;
    if (voiceId != null) result.voiceId = voiceId;
    if (speed != null) result.speed = speed;
    if (text != null) result.text = text;
    return result;
  }

  WriteTtsStreamRequest._();

  factory WriteTtsStreamRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WriteTtsStreamRequest()..mergeFromBuffer(data, registry);
  factory WriteTtsStreamRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WriteTtsStreamRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WriteTtsStreamRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.card_rendering'),
      createEmptyInstance: WriteTtsStreamRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'voiceId')
    ..aD(3, _omitFieldNames ? '' : 'speed', fieldType: $pb.PbFieldType.OF)
    ..aOS(4, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteTtsStreamRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteTtsStreamRequest copyWith(
          void Function(WriteTtsStreamRequest) updates) =>
      super.copyWith((message) => updates(message as WriteTtsStreamRequest))
          as WriteTtsStreamRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use WriteTtsStreamRequest() / WriteTtsStreamRequest.new instead')
  static WriteTtsStreamRequest create() => WriteTtsStreamRequest._();
  static $pb.GeneratedMessage $_createMessage() => WriteTtsStreamRequest._();
  @$core.override
  WriteTtsStreamRequest createEmptyInstance() => WriteTtsStreamRequest._();
  @$core.pragma('dart2js:noInline')
  static WriteTtsStreamRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteTtsStreamRequest>(
          WriteTtsStreamRequest.$_createMessage);
  static WriteTtsStreamRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get voiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set voiceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVoiceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get speed => $_getN(2);
  @$pb.TagNumber(3)
  set speed($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpeed() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpeed() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get text => $_getSZ(3);
  @$pb.TagNumber(4)
  set text($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasText() => $_has(3);
  @$pb.TagNumber(4)
  void clearText() => $_clearField(4);
}

class CardRenderingServiceApi {
  final $pb.RpcClient _client;

  CardRenderingServiceApi(this._client);

  $async.Future<ExtractAvTagsResponse> extractAvTags(
          $pb.ClientContext? ctx, ExtractAvTagsRequest request) =>
      _client.invoke<ExtractAvTagsResponse>(ctx, 'CardRenderingService',
          'ExtractAvTags', request, ExtractAvTagsResponse());
  $async.Future<ExtractLatexResponse> extractLatex(
          $pb.ClientContext? ctx, ExtractLatexRequest request) =>
      _client.invoke<ExtractLatexResponse>(ctx, 'CardRenderingService',
          'ExtractLatex', request, ExtractLatexResponse());
  $async.Future<EmptyCardsReport> getEmptyCards(
          $pb.ClientContext? ctx, $2.Empty request) =>
      _client.invoke<EmptyCardsReport>(ctx, 'CardRenderingService',
          'GetEmptyCards', request, EmptyCardsReport());
  $async.Future<RenderCardResponse> renderExistingCard(
          $pb.ClientContext? ctx, RenderExistingCardRequest request) =>
      _client.invoke<RenderCardResponse>(ctx, 'CardRenderingService',
          'RenderExistingCard', request, RenderCardResponse());
  $async.Future<RenderCardResponse> renderUncommittedCard(
          $pb.ClientContext? ctx, RenderUncommittedCardRequest request) =>
      _client.invoke<RenderCardResponse>(ctx, 'CardRenderingService',
          'RenderUncommittedCard', request, RenderCardResponse());
  $async.Future<RenderCardResponse> renderUncommittedCardLegacy(
          $pb.ClientContext? ctx, RenderUncommittedCardLegacyRequest request) =>
      _client.invoke<RenderCardResponse>(ctx, 'CardRenderingService',
          'RenderUncommittedCardLegacy', request, RenderCardResponse());
  $async.Future<$2.String> stripAvTags(
          $pb.ClientContext? ctx, $2.String request) =>
      _client.invoke<$2.String>(
          ctx, 'CardRenderingService', 'StripAvTags', request, $2.String());
  $async.Future<$2.String> renderMarkdown(
          $pb.ClientContext? ctx, RenderMarkdownRequest request) =>
      _client.invoke<$2.String>(
          ctx, 'CardRenderingService', 'RenderMarkdown', request, $2.String());
  $async.Future<$2.String> encodeIriPaths(
          $pb.ClientContext? ctx, $2.String request) =>
      _client.invoke<$2.String>(
          ctx, 'CardRenderingService', 'EncodeIriPaths', request, $2.String());
  $async.Future<$2.String> decodeIriPaths(
          $pb.ClientContext? ctx, $2.String request) =>
      _client.invoke<$2.String>(
          ctx, 'CardRenderingService', 'DecodeIriPaths', request, $2.String());
  $async.Future<$2.String> stripHtml(
          $pb.ClientContext? ctx, StripHtmlRequest request) =>
      _client.invoke<$2.String>(
          ctx, 'CardRenderingService', 'StripHtml', request, $2.String());
  $async.Future<$2.String> htmlToTextLine(
          $pb.ClientContext? ctx, HtmlToTextLineRequest request) =>
      _client.invoke<$2.String>(
          ctx, 'CardRenderingService', 'HtmlToTextLine', request, $2.String());
  $async.Future<$2.String> compareAnswer(
          $pb.ClientContext? ctx, CompareAnswerRequest request) =>
      _client.invoke<$2.String>(
          ctx, 'CardRenderingService', 'CompareAnswer', request, $2.String());
  $async.Future<$2.String> extractClozeForTyping(
          $pb.ClientContext? ctx, ExtractClozeForTypingRequest request) =>
      _client.invoke<$2.String>(ctx, 'CardRenderingService',
          'ExtractClozeForTyping', request, $2.String());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendCardRenderingServiceApi {
  final $pb.RpcClient _client;

  BackendCardRenderingServiceApi(this._client);

  $async.Future<$2.String> stripHtml(
          $pb.ClientContext? ctx, StripHtmlRequest request) =>
      _client.invoke<$2.String>(ctx, 'BackendCardRenderingService', 'StripHtml',
          request, $2.String());
  $async.Future<AllTtsVoicesResponse> allTtsVoices(
          $pb.ClientContext? ctx, AllTtsVoicesRequest request) =>
      _client.invoke<AllTtsVoicesResponse>(ctx, 'BackendCardRenderingService',
          'AllTtsVoices', request, AllTtsVoicesResponse());
  $async.Future<$2.Empty> writeTtsStream(
          $pb.ClientContext? ctx, WriteTtsStreamRequest request) =>
      _client.invoke<$2.Empty>(ctx, 'BackendCardRenderingService',
          'WriteTtsStream', request, $2.Empty());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
