// This is a generated file - do not edit.
//
// Generated from anki/card_rendering.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'generic.pbjson.dart' as $2;
import 'notes.pbjson.dart' as $0;
import 'notetypes.pbjson.dart' as $1;

@$core.Deprecated('Use extractAvTagsRequestDescriptor instead')
const ExtractAvTagsRequest$json = {
  '1': 'ExtractAvTagsRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'question_side', '3': 2, '4': 1, '5': 8, '10': 'questionSide'},
  ],
};

/// Descriptor for `ExtractAvTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractAvTagsRequestDescriptor = $convert.base64Decode(
    'ChRFeHRyYWN0QXZUYWdzUmVxdWVzdBISCgR0ZXh0GAEgASgJUgR0ZXh0EiMKDXF1ZXN0aW9uX3'
    'NpZGUYAiABKAhSDHF1ZXN0aW9uU2lkZQ==');

@$core.Deprecated('Use extractAvTagsResponseDescriptor instead')
const ExtractAvTagsResponse$json = {
  '1': 'ExtractAvTagsResponse',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'av_tags',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.card_rendering.AVTag',
      '10': 'avTags'
    },
  ],
};

/// Descriptor for `ExtractAvTagsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractAvTagsResponseDescriptor = $convert.base64Decode(
    'ChVFeHRyYWN0QXZUYWdzUmVzcG9uc2USEgoEdGV4dBgBIAEoCVIEdGV4dBIzCgdhdl90YWdzGA'
    'IgAygLMhouYW5raS5jYXJkX3JlbmRlcmluZy5BVlRhZ1IGYXZUYWdz');

@$core.Deprecated('Use aVTagDescriptor instead')
const AVTag$json = {
  '1': 'AVTag',
  '2': [
    {
      '1': 'sound_or_video',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'soundOrVideo'
    },
    {
      '1': 'tts',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.card_rendering.TTSTag',
      '9': 0,
      '10': 'tts'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `AVTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aVTagDescriptor = $convert.base64Decode(
    'CgVBVlRhZxImCg5zb3VuZF9vcl92aWRlbxgBIAEoCUgAUgxzb3VuZE9yVmlkZW8SLwoDdHRzGA'
    'IgASgLMhsuYW5raS5jYXJkX3JlbmRlcmluZy5UVFNUYWdIAFIDdHRzQgcKBXZhbHVl');

@$core.Deprecated('Use tTSTagDescriptor instead')
const TTSTag$json = {
  '1': 'TTSTag',
  '2': [
    {'1': 'field_text', '3': 1, '4': 1, '5': 9, '10': 'fieldText'},
    {'1': 'lang', '3': 2, '4': 1, '5': 9, '10': 'lang'},
    {'1': 'voices', '3': 3, '4': 3, '5': 9, '10': 'voices'},
    {'1': 'speed', '3': 4, '4': 1, '5': 2, '10': 'speed'},
    {'1': 'other_args', '3': 5, '4': 3, '5': 9, '10': 'otherArgs'},
  ],
};

/// Descriptor for `TTSTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tTSTagDescriptor = $convert.base64Decode(
    'CgZUVFNUYWcSHQoKZmllbGRfdGV4dBgBIAEoCVIJZmllbGRUZXh0EhIKBGxhbmcYAiABKAlSBG'
    'xhbmcSFgoGdm9pY2VzGAMgAygJUgZ2b2ljZXMSFAoFc3BlZWQYBCABKAJSBXNwZWVkEh0KCm90'
    'aGVyX2FyZ3MYBSADKAlSCW90aGVyQXJncw==');

@$core.Deprecated('Use extractLatexRequestDescriptor instead')
const ExtractLatexRequest$json = {
  '1': 'ExtractLatexRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'svg', '3': 2, '4': 1, '5': 8, '10': 'svg'},
    {'1': 'expand_clozes', '3': 3, '4': 1, '5': 8, '10': 'expandClozes'},
  ],
};

/// Descriptor for `ExtractLatexRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractLatexRequestDescriptor = $convert.base64Decode(
    'ChNFeHRyYWN0TGF0ZXhSZXF1ZXN0EhIKBHRleHQYASABKAlSBHRleHQSEAoDc3ZnGAIgASgIUg'
    'NzdmcSIwoNZXhwYW5kX2Nsb3plcxgDIAEoCFIMZXhwYW5kQ2xvemVz');

@$core.Deprecated('Use extractLatexResponseDescriptor instead')
const ExtractLatexResponse$json = {
  '1': 'ExtractLatexResponse',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'latex',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.card_rendering.ExtractedLatex',
      '10': 'latex'
    },
  ],
};

/// Descriptor for `ExtractLatexResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractLatexResponseDescriptor = $convert.base64Decode(
    'ChRFeHRyYWN0TGF0ZXhSZXNwb25zZRISCgR0ZXh0GAEgASgJUgR0ZXh0EjkKBWxhdGV4GAIgAy'
    'gLMiMuYW5raS5jYXJkX3JlbmRlcmluZy5FeHRyYWN0ZWRMYXRleFIFbGF0ZXg=');

@$core.Deprecated('Use extractedLatexDescriptor instead')
const ExtractedLatex$json = {
  '1': 'ExtractedLatex',
  '2': [
    {'1': 'filename', '3': 1, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'latex_body', '3': 2, '4': 1, '5': 9, '10': 'latexBody'},
  ],
};

/// Descriptor for `ExtractedLatex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractedLatexDescriptor = $convert.base64Decode(
    'Cg5FeHRyYWN0ZWRMYXRleBIaCghmaWxlbmFtZRgBIAEoCVIIZmlsZW5hbWUSHQoKbGF0ZXhfYm'
    '9keRgCIAEoCVIJbGF0ZXhCb2R5');

@$core.Deprecated('Use emptyCardsReportDescriptor instead')
const EmptyCardsReport$json = {
  '1': 'EmptyCardsReport',
  '2': [
    {'1': 'report', '3': 1, '4': 1, '5': 9, '10': 'report'},
    {
      '1': 'notes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.card_rendering.EmptyCardsReport.NoteWithEmptyCards',
      '10': 'notes'
    },
  ],
  '3': [EmptyCardsReport_NoteWithEmptyCards$json],
};

@$core.Deprecated('Use emptyCardsReportDescriptor instead')
const EmptyCardsReport_NoteWithEmptyCards$json = {
  '1': 'NoteWithEmptyCards',
  '2': [
    {'1': 'note_id', '3': 1, '4': 1, '5': 3, '10': 'noteId'},
    {'1': 'card_ids', '3': 2, '4': 3, '5': 3, '10': 'cardIds'},
    {'1': 'will_delete_note', '3': 3, '4': 1, '5': 8, '10': 'willDeleteNote'},
  ],
};

/// Descriptor for `EmptyCardsReport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyCardsReportDescriptor = $convert.base64Decode(
    'ChBFbXB0eUNhcmRzUmVwb3J0EhYKBnJlcG9ydBgBIAEoCVIGcmVwb3J0Ek4KBW5vdGVzGAIgAy'
    'gLMjguYW5raS5jYXJkX3JlbmRlcmluZy5FbXB0eUNhcmRzUmVwb3J0Lk5vdGVXaXRoRW1wdHlD'
    'YXJkc1IFbm90ZXMacgoSTm90ZVdpdGhFbXB0eUNhcmRzEhcKB25vdGVfaWQYASABKANSBm5vdG'
    'VJZBIZCghjYXJkX2lkcxgCIAMoA1IHY2FyZElkcxIoChB3aWxsX2RlbGV0ZV9ub3RlGAMgASgI'
    'Ug53aWxsRGVsZXRlTm90ZQ==');

@$core.Deprecated('Use renderExistingCardRequestDescriptor instead')
const RenderExistingCardRequest$json = {
  '1': 'RenderExistingCardRequest',
  '2': [
    {'1': 'card_id', '3': 1, '4': 1, '5': 3, '10': 'cardId'},
    {'1': 'browser', '3': 2, '4': 1, '5': 8, '10': 'browser'},
    {'1': 'partial_render', '3': 3, '4': 1, '5': 8, '10': 'partialRender'},
  ],
};

/// Descriptor for `RenderExistingCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renderExistingCardRequestDescriptor = $convert.base64Decode(
    'ChlSZW5kZXJFeGlzdGluZ0NhcmRSZXF1ZXN0EhcKB2NhcmRfaWQYASABKANSBmNhcmRJZBIYCg'
    'dicm93c2VyGAIgASgIUgdicm93c2VyEiUKDnBhcnRpYWxfcmVuZGVyGAMgASgIUg1wYXJ0aWFs'
    'UmVuZGVy');

@$core.Deprecated('Use renderUncommittedCardRequestDescriptor instead')
const RenderUncommittedCardRequest$json = {
  '1': 'RenderUncommittedCardRequest',
  '2': [
    {
      '1': 'note',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.notes.Note',
      '10': 'note'
    },
    {'1': 'card_ord', '3': 2, '4': 1, '5': 13, '10': 'cardOrd'},
    {
      '1': 'template',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.notetypes.Notetype.Template',
      '10': 'template'
    },
    {'1': 'fill_empty', '3': 4, '4': 1, '5': 8, '10': 'fillEmpty'},
    {'1': 'partial_render', '3': 5, '4': 1, '5': 8, '10': 'partialRender'},
  ],
};

/// Descriptor for `RenderUncommittedCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renderUncommittedCardRequestDescriptor = $convert.base64Decode(
    'ChxSZW5kZXJVbmNvbW1pdHRlZENhcmRSZXF1ZXN0EiQKBG5vdGUYASABKAsyEC5hbmtpLm5vdG'
    'VzLk5vdGVSBG5vdGUSGQoIY2FyZF9vcmQYAiABKA1SB2NhcmRPcmQSPQoIdGVtcGxhdGUYAyAB'
    'KAsyIS5hbmtpLm5vdGV0eXBlcy5Ob3RldHlwZS5UZW1wbGF0ZVIIdGVtcGxhdGUSHQoKZmlsbF'
    '9lbXB0eRgEIAEoCFIJZmlsbEVtcHR5EiUKDnBhcnRpYWxfcmVuZGVyGAUgASgIUg1wYXJ0aWFs'
    'UmVuZGVy');

@$core.Deprecated('Use renderUncommittedCardLegacyRequestDescriptor instead')
const RenderUncommittedCardLegacyRequest$json = {
  '1': 'RenderUncommittedCardLegacyRequest',
  '2': [
    {
      '1': 'note',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.notes.Note',
      '10': 'note'
    },
    {'1': 'card_ord', '3': 2, '4': 1, '5': 13, '10': 'cardOrd'},
    {'1': 'template', '3': 3, '4': 1, '5': 12, '10': 'template'},
    {'1': 'fill_empty', '3': 4, '4': 1, '5': 8, '10': 'fillEmpty'},
    {'1': 'partial_render', '3': 5, '4': 1, '5': 8, '10': 'partialRender'},
  ],
};

/// Descriptor for `RenderUncommittedCardLegacyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renderUncommittedCardLegacyRequestDescriptor =
    $convert.base64Decode(
        'CiJSZW5kZXJVbmNvbW1pdHRlZENhcmRMZWdhY3lSZXF1ZXN0EiQKBG5vdGUYASABKAsyEC5hbm'
        'tpLm5vdGVzLk5vdGVSBG5vdGUSGQoIY2FyZF9vcmQYAiABKA1SB2NhcmRPcmQSGgoIdGVtcGxh'
        'dGUYAyABKAxSCHRlbXBsYXRlEh0KCmZpbGxfZW1wdHkYBCABKAhSCWZpbGxFbXB0eRIlCg5wYX'
        'J0aWFsX3JlbmRlchgFIAEoCFINcGFydGlhbFJlbmRlcg==');

@$core.Deprecated('Use renderCardResponseDescriptor instead')
const RenderCardResponse$json = {
  '1': 'RenderCardResponse',
  '2': [
    {
      '1': 'question_nodes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.card_rendering.RenderedTemplateNode',
      '10': 'questionNodes'
    },
    {
      '1': 'answer_nodes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.card_rendering.RenderedTemplateNode',
      '10': 'answerNodes'
    },
    {'1': 'css', '3': 3, '4': 1, '5': 9, '10': 'css'},
    {'1': 'latex_svg', '3': 4, '4': 1, '5': 8, '10': 'latexSvg'},
    {'1': 'is_empty', '3': 5, '4': 1, '5': 8, '10': 'isEmpty'},
  ],
};

/// Descriptor for `RenderCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renderCardResponseDescriptor = $convert.base64Decode(
    'ChJSZW5kZXJDYXJkUmVzcG9uc2USUAoOcXVlc3Rpb25fbm9kZXMYASADKAsyKS5hbmtpLmNhcm'
    'RfcmVuZGVyaW5nLlJlbmRlcmVkVGVtcGxhdGVOb2RlUg1xdWVzdGlvbk5vZGVzEkwKDGFuc3dl'
    'cl9ub2RlcxgCIAMoCzIpLmFua2kuY2FyZF9yZW5kZXJpbmcuUmVuZGVyZWRUZW1wbGF0ZU5vZG'
    'VSC2Fuc3dlck5vZGVzEhAKA2NzcxgDIAEoCVIDY3NzEhsKCWxhdGV4X3N2ZxgEIAEoCFIIbGF0'
    'ZXhTdmcSGQoIaXNfZW1wdHkYBSABKAhSB2lzRW1wdHk=');

@$core.Deprecated('Use renderedTemplateNodeDescriptor instead')
const RenderedTemplateNode$json = {
  '1': 'RenderedTemplateNode',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'text'},
    {
      '1': 'replacement',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.card_rendering.RenderedTemplateReplacement',
      '9': 0,
      '10': 'replacement'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `RenderedTemplateNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renderedTemplateNodeDescriptor = $convert.base64Decode(
    'ChRSZW5kZXJlZFRlbXBsYXRlTm9kZRIUCgR0ZXh0GAEgASgJSABSBHRleHQSVAoLcmVwbGFjZW'
    '1lbnQYAiABKAsyMC5hbmtpLmNhcmRfcmVuZGVyaW5nLlJlbmRlcmVkVGVtcGxhdGVSZXBsYWNl'
    'bWVudEgAUgtyZXBsYWNlbWVudEIHCgV2YWx1ZQ==');

@$core.Deprecated('Use renderedTemplateReplacementDescriptor instead')
const RenderedTemplateReplacement$json = {
  '1': 'RenderedTemplateReplacement',
  '2': [
    {'1': 'field_name', '3': 1, '4': 1, '5': 9, '10': 'fieldName'},
    {'1': 'current_text', '3': 2, '4': 1, '5': 9, '10': 'currentText'},
    {'1': 'filters', '3': 3, '4': 3, '5': 9, '10': 'filters'},
  ],
};

/// Descriptor for `RenderedTemplateReplacement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renderedTemplateReplacementDescriptor =
    $convert.base64Decode(
        'ChtSZW5kZXJlZFRlbXBsYXRlUmVwbGFjZW1lbnQSHQoKZmllbGRfbmFtZRgBIAEoCVIJZmllbG'
        'ROYW1lEiEKDGN1cnJlbnRfdGV4dBgCIAEoCVILY3VycmVudFRleHQSGAoHZmlsdGVycxgDIAMo'
        'CVIHZmlsdGVycw==');

@$core.Deprecated('Use renderMarkdownRequestDescriptor instead')
const RenderMarkdownRequest$json = {
  '1': 'RenderMarkdownRequest',
  '2': [
    {'1': 'markdown', '3': 1, '4': 1, '5': 9, '10': 'markdown'},
    {'1': 'sanitize', '3': 2, '4': 1, '5': 8, '10': 'sanitize'},
  ],
};

/// Descriptor for `RenderMarkdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renderMarkdownRequestDescriptor = $convert.base64Decode(
    'ChVSZW5kZXJNYXJrZG93blJlcXVlc3QSGgoIbWFya2Rvd24YASABKAlSCG1hcmtkb3duEhoKCH'
    'Nhbml0aXplGAIgASgIUghzYW5pdGl6ZQ==');

@$core.Deprecated('Use stripHtmlRequestDescriptor instead')
const StripHtmlRequest$json = {
  '1': 'StripHtmlRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.card_rendering.StripHtmlRequest.Mode',
      '10': 'mode'
    },
  ],
  '4': [StripHtmlRequest_Mode$json],
};

@$core.Deprecated('Use stripHtmlRequestDescriptor instead')
const StripHtmlRequest_Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'NORMAL', '2': 0},
    {'1': 'PRESERVE_MEDIA_FILENAMES', '2': 1},
  ],
};

/// Descriptor for `StripHtmlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stripHtmlRequestDescriptor = $convert.base64Decode(
    'ChBTdHJpcEh0bWxSZXF1ZXN0EhIKBHRleHQYASABKAlSBHRleHQSPgoEbW9kZRgCIAEoDjIqLm'
    'Fua2kuY2FyZF9yZW5kZXJpbmcuU3RyaXBIdG1sUmVxdWVzdC5Nb2RlUgRtb2RlIjAKBE1vZGUS'
    'CgoGTk9STUFMEAASHAoYUFJFU0VSVkVfTUVESUFfRklMRU5BTUVTEAE=');

@$core.Deprecated('Use htmlToTextLineRequestDescriptor instead')
const HtmlToTextLineRequest$json = {
  '1': 'HtmlToTextLineRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'preserve_media_filenames',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'preserveMediaFilenames'
    },
  ],
};

/// Descriptor for `HtmlToTextLineRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List htmlToTextLineRequestDescriptor = $convert.base64Decode(
    'ChVIdG1sVG9UZXh0TGluZVJlcXVlc3QSEgoEdGV4dBgBIAEoCVIEdGV4dBI4ChhwcmVzZXJ2ZV'
    '9tZWRpYV9maWxlbmFtZXMYAiABKAhSFnByZXNlcnZlTWVkaWFGaWxlbmFtZXM=');

@$core.Deprecated('Use compareAnswerRequestDescriptor instead')
const CompareAnswerRequest$json = {
  '1': 'CompareAnswerRequest',
  '2': [
    {'1': 'expected', '3': 1, '4': 1, '5': 9, '10': 'expected'},
    {'1': 'provided', '3': 2, '4': 1, '5': 9, '10': 'provided'},
    {'1': 'combining', '3': 3, '4': 1, '5': 8, '10': 'combining'},
  ],
};

/// Descriptor for `CompareAnswerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List compareAnswerRequestDescriptor = $convert.base64Decode(
    'ChRDb21wYXJlQW5zd2VyUmVxdWVzdBIaCghleHBlY3RlZBgBIAEoCVIIZXhwZWN0ZWQSGgoIcH'
    'JvdmlkZWQYAiABKAlSCHByb3ZpZGVkEhwKCWNvbWJpbmluZxgDIAEoCFIJY29tYmluaW5n');

@$core.Deprecated('Use extractClozeForTypingRequestDescriptor instead')
const ExtractClozeForTypingRequest$json = {
  '1': 'ExtractClozeForTypingRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'ordinal', '3': 2, '4': 1, '5': 13, '10': 'ordinal'},
  ],
};

/// Descriptor for `ExtractClozeForTypingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractClozeForTypingRequestDescriptor =
    $convert.base64Decode(
        'ChxFeHRyYWN0Q2xvemVGb3JUeXBpbmdSZXF1ZXN0EhIKBHRleHQYASABKAlSBHRleHQSGAoHb3'
        'JkaW5hbBgCIAEoDVIHb3JkaW5hbA==');

@$core.Deprecated('Use allTtsVoicesRequestDescriptor instead')
const AllTtsVoicesRequest$json = {
  '1': 'AllTtsVoicesRequest',
  '2': [
    {'1': 'validate', '3': 1, '4': 1, '5': 8, '10': 'validate'},
  ],
};

/// Descriptor for `AllTtsVoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allTtsVoicesRequestDescriptor =
    $convert.base64Decode(
        'ChNBbGxUdHNWb2ljZXNSZXF1ZXN0EhoKCHZhbGlkYXRlGAEgASgIUgh2YWxpZGF0ZQ==');

@$core.Deprecated('Use allTtsVoicesResponseDescriptor instead')
const AllTtsVoicesResponse$json = {
  '1': 'AllTtsVoicesResponse',
  '2': [
    {
      '1': 'voices',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.card_rendering.AllTtsVoicesResponse.TtsVoice',
      '10': 'voices'
    },
  ],
  '3': [AllTtsVoicesResponse_TtsVoice$json],
};

@$core.Deprecated('Use allTtsVoicesResponseDescriptor instead')
const AllTtsVoicesResponse_TtsVoice$json = {
  '1': 'TtsVoice',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'language', '3': 3, '4': 1, '5': 9, '10': 'language'},
    {
      '1': 'available',
      '3': 4,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'available',
      '17': true
    },
  ],
  '8': [
    {'1': '_available'},
  ],
};

/// Descriptor for `AllTtsVoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allTtsVoicesResponseDescriptor = $convert.base64Decode(
    'ChRBbGxUdHNWb2ljZXNSZXNwb25zZRJKCgZ2b2ljZXMYASADKAsyMi5hbmtpLmNhcmRfcmVuZG'
    'VyaW5nLkFsbFR0c1ZvaWNlc1Jlc3BvbnNlLlR0c1ZvaWNlUgZ2b2ljZXMaewoIVHRzVm9pY2US'
    'DgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGgoIbGFuZ3VhZ2UYAyABKAlSCG'
    'xhbmd1YWdlEiEKCWF2YWlsYWJsZRgEIAEoCEgAUglhdmFpbGFibGWIAQFCDAoKX2F2YWlsYWJs'
    'ZQ==');

@$core.Deprecated('Use writeTtsStreamRequestDescriptor instead')
const WriteTtsStreamRequest$json = {
  '1': 'WriteTtsStreamRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'voice_id', '3': 2, '4': 1, '5': 9, '10': 'voiceId'},
    {'1': 'speed', '3': 3, '4': 1, '5': 2, '10': 'speed'},
    {'1': 'text', '3': 4, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `WriteTtsStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeTtsStreamRequestDescriptor = $convert.base64Decode(
    'ChVXcml0ZVR0c1N0cmVhbVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBIZCgh2b2ljZV9pZB'
    'gCIAEoCVIHdm9pY2VJZBIUCgVzcGVlZBgDIAEoAlIFc3BlZWQSEgoEdGV4dBgEIAEoCVIEdGV4'
    'dA==');

const $core.Map<$core.String, $core.dynamic> CardRenderingServiceBase$json = {
  '1': 'CardRenderingService',
  '2': [
    {
      '1': 'ExtractAvTags',
      '2': '.anki.card_rendering.ExtractAvTagsRequest',
      '3': '.anki.card_rendering.ExtractAvTagsResponse'
    },
    {
      '1': 'ExtractLatex',
      '2': '.anki.card_rendering.ExtractLatexRequest',
      '3': '.anki.card_rendering.ExtractLatexResponse'
    },
    {
      '1': 'GetEmptyCards',
      '2': '.anki.generic.Empty',
      '3': '.anki.card_rendering.EmptyCardsReport'
    },
    {
      '1': 'RenderExistingCard',
      '2': '.anki.card_rendering.RenderExistingCardRequest',
      '3': '.anki.card_rendering.RenderCardResponse'
    },
    {
      '1': 'RenderUncommittedCard',
      '2': '.anki.card_rendering.RenderUncommittedCardRequest',
      '3': '.anki.card_rendering.RenderCardResponse'
    },
    {
      '1': 'RenderUncommittedCardLegacy',
      '2': '.anki.card_rendering.RenderUncommittedCardLegacyRequest',
      '3': '.anki.card_rendering.RenderCardResponse'
    },
    {
      '1': 'StripAvTags',
      '2': '.anki.generic.String',
      '3': '.anki.generic.String'
    },
    {
      '1': 'RenderMarkdown',
      '2': '.anki.card_rendering.RenderMarkdownRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'EncodeIriPaths',
      '2': '.anki.generic.String',
      '3': '.anki.generic.String'
    },
    {
      '1': 'DecodeIriPaths',
      '2': '.anki.generic.String',
      '3': '.anki.generic.String'
    },
    {
      '1': 'StripHtml',
      '2': '.anki.card_rendering.StripHtmlRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'HtmlToTextLine',
      '2': '.anki.card_rendering.HtmlToTextLineRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'CompareAnswer',
      '2': '.anki.card_rendering.CompareAnswerRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'ExtractClozeForTyping',
      '2': '.anki.card_rendering.ExtractClozeForTypingRequest',
      '3': '.anki.generic.String'
    },
  ],
};

@$core.Deprecated('Use cardRenderingServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    CardRenderingServiceBase$messageJson = {
  '.anki.card_rendering.ExtractAvTagsRequest': ExtractAvTagsRequest$json,
  '.anki.card_rendering.ExtractAvTagsResponse': ExtractAvTagsResponse$json,
  '.anki.card_rendering.AVTag': AVTag$json,
  '.anki.card_rendering.TTSTag': TTSTag$json,
  '.anki.card_rendering.ExtractLatexRequest': ExtractLatexRequest$json,
  '.anki.card_rendering.ExtractLatexResponse': ExtractLatexResponse$json,
  '.anki.card_rendering.ExtractedLatex': ExtractedLatex$json,
  '.anki.generic.Empty': $2.Empty$json,
  '.anki.card_rendering.EmptyCardsReport': EmptyCardsReport$json,
  '.anki.card_rendering.EmptyCardsReport.NoteWithEmptyCards':
      EmptyCardsReport_NoteWithEmptyCards$json,
  '.anki.card_rendering.RenderExistingCardRequest':
      RenderExistingCardRequest$json,
  '.anki.card_rendering.RenderCardResponse': RenderCardResponse$json,
  '.anki.card_rendering.RenderedTemplateNode': RenderedTemplateNode$json,
  '.anki.card_rendering.RenderedTemplateReplacement':
      RenderedTemplateReplacement$json,
  '.anki.card_rendering.RenderUncommittedCardRequest':
      RenderUncommittedCardRequest$json,
  '.anki.notes.Note': $0.Note$json,
  '.anki.notetypes.Notetype.Template': $1.Notetype_Template$json,
  '.anki.generic.UInt32': $2.UInt32$json,
  '.anki.notetypes.Notetype.Template.Config': $1.Notetype_Template_Config$json,
  '.anki.card_rendering.RenderUncommittedCardLegacyRequest':
      RenderUncommittedCardLegacyRequest$json,
  '.anki.generic.String': $2.String$json,
  '.anki.card_rendering.RenderMarkdownRequest': RenderMarkdownRequest$json,
  '.anki.card_rendering.StripHtmlRequest': StripHtmlRequest$json,
  '.anki.card_rendering.HtmlToTextLineRequest': HtmlToTextLineRequest$json,
  '.anki.card_rendering.CompareAnswerRequest': CompareAnswerRequest$json,
  '.anki.card_rendering.ExtractClozeForTypingRequest':
      ExtractClozeForTypingRequest$json,
};

/// Descriptor for `CardRenderingService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List cardRenderingServiceDescriptor = $convert.base64Decode(
    'ChRDYXJkUmVuZGVyaW5nU2VydmljZRJmCg1FeHRyYWN0QXZUYWdzEikuYW5raS5jYXJkX3Jlbm'
    'RlcmluZy5FeHRyYWN0QXZUYWdzUmVxdWVzdBoqLmFua2kuY2FyZF9yZW5kZXJpbmcuRXh0cmFj'
    'dEF2VGFnc1Jlc3BvbnNlEmMKDEV4dHJhY3RMYXRleBIoLmFua2kuY2FyZF9yZW5kZXJpbmcuRX'
    'h0cmFjdExhdGV4UmVxdWVzdBopLmFua2kuY2FyZF9yZW5kZXJpbmcuRXh0cmFjdExhdGV4UmVz'
    'cG9uc2USSwoNR2V0RW1wdHlDYXJkcxITLmFua2kuZ2VuZXJpYy5FbXB0eRolLmFua2kuY2FyZF'
    '9yZW5kZXJpbmcuRW1wdHlDYXJkc1JlcG9ydBJtChJSZW5kZXJFeGlzdGluZ0NhcmQSLi5hbmtp'
    'LmNhcmRfcmVuZGVyaW5nLlJlbmRlckV4aXN0aW5nQ2FyZFJlcXVlc3QaJy5hbmtpLmNhcmRfcm'
    'VuZGVyaW5nLlJlbmRlckNhcmRSZXNwb25zZRJzChVSZW5kZXJVbmNvbW1pdHRlZENhcmQSMS5h'
    'bmtpLmNhcmRfcmVuZGVyaW5nLlJlbmRlclVuY29tbWl0dGVkQ2FyZFJlcXVlc3QaJy5hbmtpLm'
    'NhcmRfcmVuZGVyaW5nLlJlbmRlckNhcmRSZXNwb25zZRJ/ChtSZW5kZXJVbmNvbW1pdHRlZENh'
    'cmRMZWdhY3kSNy5hbmtpLmNhcmRfcmVuZGVyaW5nLlJlbmRlclVuY29tbWl0dGVkQ2FyZExlZ2'
    'FjeVJlcXVlc3QaJy5hbmtpLmNhcmRfcmVuZGVyaW5nLlJlbmRlckNhcmRSZXNwb25zZRI5CgtT'
    'dHJpcEF2VGFncxIULmFua2kuZ2VuZXJpYy5TdHJpbmcaFC5hbmtpLmdlbmVyaWMuU3RyaW5nEl'
    'IKDlJlbmRlck1hcmtkb3duEiouYW5raS5jYXJkX3JlbmRlcmluZy5SZW5kZXJNYXJrZG93blJl'
    'cXVlc3QaFC5hbmtpLmdlbmVyaWMuU3RyaW5nEjwKDkVuY29kZUlyaVBhdGhzEhQuYW5raS5nZW'
    '5lcmljLlN0cmluZxoULmFua2kuZ2VuZXJpYy5TdHJpbmcSPAoORGVjb2RlSXJpUGF0aHMSFC5h'
    'bmtpLmdlbmVyaWMuU3RyaW5nGhQuYW5raS5nZW5lcmljLlN0cmluZxJICglTdHJpcEh0bWwSJS'
    '5hbmtpLmNhcmRfcmVuZGVyaW5nLlN0cmlwSHRtbFJlcXVlc3QaFC5hbmtpLmdlbmVyaWMuU3Ry'
    'aW5nElIKDkh0bWxUb1RleHRMaW5lEiouYW5raS5jYXJkX3JlbmRlcmluZy5IdG1sVG9UZXh0TG'
    'luZVJlcXVlc3QaFC5hbmtpLmdlbmVyaWMuU3RyaW5nElAKDUNvbXBhcmVBbnN3ZXISKS5hbmtp'
    'LmNhcmRfcmVuZGVyaW5nLkNvbXBhcmVBbnN3ZXJSZXF1ZXN0GhQuYW5raS5nZW5lcmljLlN0cm'
    'luZxJgChVFeHRyYWN0Q2xvemVGb3JUeXBpbmcSMS5hbmtpLmNhcmRfcmVuZGVyaW5nLkV4dHJh'
    'Y3RDbG96ZUZvclR5cGluZ1JlcXVlc3QaFC5hbmtpLmdlbmVyaWMuU3RyaW5n');

const $core.Map<$core.String, $core.dynamic>
    BackendCardRenderingServiceBase$json = {
  '1': 'BackendCardRenderingService',
  '2': [
    {
      '1': 'StripHtml',
      '2': '.anki.card_rendering.StripHtmlRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'AllTtsVoices',
      '2': '.anki.card_rendering.AllTtsVoicesRequest',
      '3': '.anki.card_rendering.AllTtsVoicesResponse'
    },
    {
      '1': 'WriteTtsStream',
      '2': '.anki.card_rendering.WriteTtsStreamRequest',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use backendCardRenderingServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendCardRenderingServiceBase$messageJson = {
  '.anki.card_rendering.StripHtmlRequest': StripHtmlRequest$json,
  '.anki.generic.String': $2.String$json,
  '.anki.card_rendering.AllTtsVoicesRequest': AllTtsVoicesRequest$json,
  '.anki.card_rendering.AllTtsVoicesResponse': AllTtsVoicesResponse$json,
  '.anki.card_rendering.AllTtsVoicesResponse.TtsVoice':
      AllTtsVoicesResponse_TtsVoice$json,
  '.anki.card_rendering.WriteTtsStreamRequest': WriteTtsStreamRequest$json,
  '.anki.generic.Empty': $2.Empty$json,
};

/// Descriptor for `BackendCardRenderingService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendCardRenderingServiceDescriptor = $convert.base64Decode(
    'ChtCYWNrZW5kQ2FyZFJlbmRlcmluZ1NlcnZpY2USSAoJU3RyaXBIdG1sEiUuYW5raS5jYXJkX3'
    'JlbmRlcmluZy5TdHJpcEh0bWxSZXF1ZXN0GhQuYW5raS5nZW5lcmljLlN0cmluZxJjCgxBbGxU'
    'dHNWb2ljZXMSKC5hbmtpLmNhcmRfcmVuZGVyaW5nLkFsbFR0c1ZvaWNlc1JlcXVlc3QaKS5hbm'
    'tpLmNhcmRfcmVuZGVyaW5nLkFsbFR0c1ZvaWNlc1Jlc3BvbnNlElEKDldyaXRlVHRzU3RyZWFt'
    'EiouYW5raS5jYXJkX3JlbmRlcmluZy5Xcml0ZVR0c1N0cmVhbVJlcXVlc3QaEy5hbmtpLmdlbm'
    'VyaWMuRW1wdHk=');
