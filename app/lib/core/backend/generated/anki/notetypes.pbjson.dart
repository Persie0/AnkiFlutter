// This is a generated file - do not edit.
//
// Generated from anki/notetypes.proto.

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

import 'collection.pbjson.dart' as $1;
import 'generic.pbjson.dart' as $0;

@$core.Deprecated('Use imageOcclusionFieldDescriptor instead')
const ImageOcclusionField$json = {
  '1': 'ImageOcclusionField',
  '2': [
    {'1': 'IMAGE_OCCLUSION_FIELD_OCCLUSIONS', '2': 0},
    {'1': 'IMAGE_OCCLUSION_FIELD_IMAGE', '2': 1},
    {'1': 'IMAGE_OCCLUSION_FIELD_HEADER', '2': 2},
    {'1': 'IMAGE_OCCLUSION_FIELD_BACK_EXTRA', '2': 3},
    {'1': 'IMAGE_OCCLUSION_FIELD_COMMENTS', '2': 4},
  ],
};

/// Descriptor for `ImageOcclusionField`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List imageOcclusionFieldDescriptor = $convert.base64Decode(
    'ChNJbWFnZU9jY2x1c2lvbkZpZWxkEiQKIElNQUdFX09DQ0xVU0lPTl9GSUVMRF9PQ0NMVVNJT0'
    '5TEAASHwobSU1BR0VfT0NDTFVTSU9OX0ZJRUxEX0lNQUdFEAESIAocSU1BR0VfT0NDTFVTSU9O'
    'X0ZJRUxEX0hFQURFUhACEiQKIElNQUdFX09DQ0xVU0lPTl9GSUVMRF9CQUNLX0VYVFJBEAMSIg'
    'oeSU1BR0VfT0NDTFVTSU9OX0ZJRUxEX0NPTU1FTlRTEAQ=');

@$core.Deprecated('Use clozeFieldDescriptor instead')
const ClozeField$json = {
  '1': 'ClozeField',
  '2': [
    {'1': 'CLOZE_FIELD_TEXT', '2': 0},
    {'1': 'CLOZE_FIELD_BACK_EXTRA', '2': 1},
  ],
};

/// Descriptor for `ClozeField`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List clozeFieldDescriptor = $convert.base64Decode(
    'CgpDbG96ZUZpZWxkEhQKEENMT1pFX0ZJRUxEX1RFWFQQABIaChZDTE9aRV9GSUVMRF9CQUNLX0'
    'VYVFJBEAE=');

@$core.Deprecated('Use notetypeIdDescriptor instead')
const NotetypeId$json = {
  '1': 'NotetypeId',
  '2': [
    {'1': 'ntid', '3': 1, '4': 1, '5': 3, '10': 'ntid'},
  ],
};

/// Descriptor for `NotetypeId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notetypeIdDescriptor =
    $convert.base64Decode('CgpOb3RldHlwZUlkEhIKBG50aWQYASABKANSBG50aWQ=');

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype$json = {
  '1': 'Notetype',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'mtime_secs', '3': 3, '4': 1, '5': 3, '10': 'mtimeSecs'},
    {'1': 'usn', '3': 4, '4': 1, '5': 17, '10': 'usn'},
    {
      '1': 'config',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.anki.notetypes.Notetype.Config',
      '10': 'config'
    },
    {
      '1': 'fields',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.anki.notetypes.Notetype.Field',
      '10': 'fields'
    },
    {
      '1': 'templates',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.anki.notetypes.Notetype.Template',
      '10': 'templates'
    },
  ],
  '3': [Notetype_Config$json, Notetype_Field$json, Notetype_Template$json],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Config$json = {
  '1': 'Config',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.notetypes.Notetype.Config.Kind',
      '10': 'kind'
    },
    {'1': 'sort_field_idx', '3': 2, '4': 1, '5': 13, '10': 'sortFieldIdx'},
    {'1': 'css', '3': 3, '4': 1, '5': 9, '10': 'css'},
    {
      '1': 'target_deck_id_unused',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'targetDeckIdUnused'
    },
    {'1': 'latex_pre', '3': 5, '4': 1, '5': 9, '10': 'latexPre'},
    {'1': 'latex_post', '3': 6, '4': 1, '5': 9, '10': 'latexPost'},
    {'1': 'latex_svg', '3': 7, '4': 1, '5': 8, '10': 'latexSvg'},
    {
      '1': 'reqs',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.anki.notetypes.Notetype.Config.CardRequirement',
      '10': 'reqs'
    },
    {
      '1': 'original_stock_kind',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.anki.notetypes.StockNotetype.OriginalStockKind',
      '10': 'originalStockKind'
    },
    {
      '1': 'original_id',
      '3': 10,
      '4': 1,
      '5': 3,
      '9': 0,
      '10': 'originalId',
      '17': true
    },
    {'1': 'other', '3': 255, '4': 1, '5': 12, '10': 'other'},
  ],
  '3': [Notetype_Config_CardRequirement$json],
  '4': [Notetype_Config_Kind$json],
  '8': [
    {'1': '_original_id'},
  ],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Config_CardRequirement$json = {
  '1': 'CardRequirement',
  '2': [
    {'1': 'card_ord', '3': 1, '4': 1, '5': 13, '10': 'cardOrd'},
    {
      '1': 'kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.notetypes.Notetype.Config.CardRequirement.Kind',
      '10': 'kind'
    },
    {'1': 'field_ords', '3': 3, '4': 3, '5': 13, '10': 'fieldOrds'},
  ],
  '4': [Notetype_Config_CardRequirement_Kind$json],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Config_CardRequirement_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'KIND_NONE', '2': 0},
    {'1': 'KIND_ANY', '2': 1},
    {'1': 'KIND_ALL', '2': 2},
  ],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Config_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'KIND_NORMAL', '2': 0},
    {'1': 'KIND_CLOZE', '2': 1},
  ],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Field$json = {
  '1': 'Field',
  '2': [
    {
      '1': 'ord',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.generic.UInt32',
      '10': 'ord'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'config',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.notetypes.Notetype.Field.Config',
      '10': 'config'
    },
  ],
  '3': [Notetype_Field_Config$json],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Field_Config$json = {
  '1': 'Config',
  '2': [
    {'1': 'sticky', '3': 1, '4': 1, '5': 8, '10': 'sticky'},
    {'1': 'rtl', '3': 2, '4': 1, '5': 8, '10': 'rtl'},
    {'1': 'font_name', '3': 3, '4': 1, '5': 9, '10': 'fontName'},
    {'1': 'font_size', '3': 4, '4': 1, '5': 13, '10': 'fontSize'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'plain_text', '3': 6, '4': 1, '5': 8, '10': 'plainText'},
    {'1': 'collapsed', '3': 7, '4': 1, '5': 8, '10': 'collapsed'},
    {
      '1': 'exclude_from_search',
      '3': 8,
      '4': 1,
      '5': 8,
      '10': 'excludeFromSearch'
    },
    {'1': 'id', '3': 9, '4': 1, '5': 3, '9': 0, '10': 'id', '17': true},
    {'1': 'tag', '3': 10, '4': 1, '5': 13, '9': 1, '10': 'tag', '17': true},
    {'1': 'prevent_deletion', '3': 11, '4': 1, '5': 8, '10': 'preventDeletion'},
    {'1': 'other', '3': 255, '4': 1, '5': 12, '10': 'other'},
  ],
  '8': [
    {'1': '_id'},
    {'1': '_tag'},
  ],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Template$json = {
  '1': 'Template',
  '2': [
    {
      '1': 'ord',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.generic.UInt32',
      '10': 'ord'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'mtime_secs', '3': 3, '4': 1, '5': 3, '10': 'mtimeSecs'},
    {'1': 'usn', '3': 4, '4': 1, '5': 17, '10': 'usn'},
    {
      '1': 'config',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.notetypes.Notetype.Template.Config',
      '10': 'config'
    },
  ],
  '3': [Notetype_Template_Config$json],
};

@$core.Deprecated('Use notetypeDescriptor instead')
const Notetype_Template_Config$json = {
  '1': 'Config',
  '2': [
    {'1': 'q_format', '3': 1, '4': 1, '5': 9, '10': 'qFormat'},
    {'1': 'a_format', '3': 2, '4': 1, '5': 9, '10': 'aFormat'},
    {'1': 'q_format_browser', '3': 3, '4': 1, '5': 9, '10': 'qFormatBrowser'},
    {'1': 'a_format_browser', '3': 4, '4': 1, '5': 9, '10': 'aFormatBrowser'},
    {'1': 'target_deck_id', '3': 5, '4': 1, '5': 3, '10': 'targetDeckId'},
    {'1': 'browser_font_name', '3': 6, '4': 1, '5': 9, '10': 'browserFontName'},
    {
      '1': 'browser_font_size',
      '3': 7,
      '4': 1,
      '5': 13,
      '10': 'browserFontSize'
    },
    {'1': 'id', '3': 8, '4': 1, '5': 3, '9': 0, '10': 'id', '17': true},
    {'1': 'other', '3': 255, '4': 1, '5': 12, '10': 'other'},
  ],
  '8': [
    {'1': '_id'},
  ],
};

/// Descriptor for `Notetype`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notetypeDescriptor = $convert.base64Decode(
    'CghOb3RldHlwZRIOCgJpZBgBIAEoA1ICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIdCgptdGltZV'
    '9zZWNzGAMgASgDUgltdGltZVNlY3MSEAoDdXNuGAQgASgRUgN1c24SNwoGY29uZmlnGAcgASgL'
    'Mh8uYW5raS5ub3RldHlwZXMuTm90ZXR5cGUuQ29uZmlnUgZjb25maWcSNgoGZmllbGRzGAggAy'
    'gLMh4uYW5raS5ub3RldHlwZXMuTm90ZXR5cGUuRmllbGRSBmZpZWxkcxI/Cgl0ZW1wbGF0ZXMY'
    'CSADKAsyIS5hbmtpLm5vdGV0eXBlcy5Ob3RldHlwZS5UZW1wbGF0ZVIJdGVtcGxhdGVzGu0FCg'
    'ZDb25maWcSOAoEa2luZBgBIAEoDjIkLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlLkNvbmZpZy5L'
    'aW5kUgRraW5kEiQKDnNvcnRfZmllbGRfaWR4GAIgASgNUgxzb3J0RmllbGRJZHgSEAoDY3NzGA'
    'MgASgJUgNjc3MSMQoVdGFyZ2V0X2RlY2tfaWRfdW51c2VkGAQgASgDUhJ0YXJnZXREZWNrSWRV'
    'bnVzZWQSGwoJbGF0ZXhfcHJlGAUgASgJUghsYXRleFByZRIdCgpsYXRleF9wb3N0GAYgASgJUg'
    'lsYXRleFBvc3QSGwoJbGF0ZXhfc3ZnGAcgASgIUghsYXRleFN2ZxJDCgRyZXFzGAggAygLMi8u'
    'YW5raS5ub3RldHlwZXMuTm90ZXR5cGUuQ29uZmlnLkNhcmRSZXF1aXJlbWVudFIEcmVxcxJfCh'
    'NvcmlnaW5hbF9zdG9ja19raW5kGAkgASgOMi8uYW5raS5ub3RldHlwZXMuU3RvY2tOb3RldHlw'
    'ZS5PcmlnaW5hbFN0b2NrS2luZFIRb3JpZ2luYWxTdG9ja0tpbmQSJAoLb3JpZ2luYWxfaWQYCi'
    'ABKANIAFIKb3JpZ2luYWxJZIgBARIVCgVvdGhlchj/ASABKAxSBW90aGVyGsgBCg9DYXJkUmVx'
    'dWlyZW1lbnQSGQoIY2FyZF9vcmQYASABKA1SB2NhcmRPcmQSSAoEa2luZBgCIAEoDjI0LmFua2'
    'kubm90ZXR5cGVzLk5vdGV0eXBlLkNvbmZpZy5DYXJkUmVxdWlyZW1lbnQuS2luZFIEa2luZBId'
    'CgpmaWVsZF9vcmRzGAMgAygNUglmaWVsZE9yZHMiMQoES2luZBINCglLSU5EX05PTkUQABIMCg'
    'hLSU5EX0FOWRABEgwKCEtJTkRfQUxMEAIiJwoES2luZBIPCgtLSU5EX05PUk1BTBAAEg4KCktJ'
    'TkRfQ0xPWkUQAUIOCgxfb3JpZ2luYWxfaWQa/QMKBUZpZWxkEiYKA29yZBgBIAEoCzIULmFua2'
    'kuZ2VuZXJpYy5VSW50MzJSA29yZBISCgRuYW1lGAIgASgJUgRuYW1lEj0KBmNvbmZpZxgFIAEo'
    'CzIlLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlLkZpZWxkLkNvbmZpZ1IGY29uZmlnGvgCCgZDb2'
    '5maWcSFgoGc3RpY2t5GAEgASgIUgZzdGlja3kSEAoDcnRsGAIgASgIUgNydGwSGwoJZm9udF9u'
    'YW1lGAMgASgJUghmb250TmFtZRIbCglmb250X3NpemUYBCABKA1SCGZvbnRTaXplEiAKC2Rlc2'
    'NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIdCgpwbGFpbl90ZXh0GAYgASgIUglwbGFpblRl'
    'eHQSHAoJY29sbGFwc2VkGAcgASgIUgljb2xsYXBzZWQSLgoTZXhjbHVkZV9mcm9tX3NlYXJjaB'
    'gIIAEoCFIRZXhjbHVkZUZyb21TZWFyY2gSEwoCaWQYCSABKANIAFICaWSIAQESFQoDdGFnGAog'
    'ASgNSAFSA3RhZ4gBARIpChBwcmV2ZW50X2RlbGV0aW9uGAsgASgIUg9wcmV2ZW50RGVsZXRpb2'
    '4SFQoFb3RoZXIY/wEgASgMUgVvdGhlckIFCgNfaWRCBgoEX3RhZxr/AwoIVGVtcGxhdGUSJgoD'
    'b3JkGAEgASgLMhQuYW5raS5nZW5lcmljLlVJbnQzMlIDb3JkEhIKBG5hbWUYAiABKAlSBG5hbW'
    'USHQoKbXRpbWVfc2VjcxgDIAEoA1IJbXRpbWVTZWNzEhAKA3VzbhgEIAEoEVIDdXNuEkAKBmNv'
    'bmZpZxgFIAEoCzIoLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlLlRlbXBsYXRlLkNvbmZpZ1IGY2'
    '9uZmlnGsMCCgZDb25maWcSGQoIcV9mb3JtYXQYASABKAlSB3FGb3JtYXQSGQoIYV9mb3JtYXQY'
    'AiABKAlSB2FGb3JtYXQSKAoQcV9mb3JtYXRfYnJvd3NlchgDIAEoCVIOcUZvcm1hdEJyb3dzZX'
    'ISKAoQYV9mb3JtYXRfYnJvd3NlchgEIAEoCVIOYUZvcm1hdEJyb3dzZXISJAoOdGFyZ2V0X2Rl'
    'Y2tfaWQYBSABKANSDHRhcmdldERlY2tJZBIqChFicm93c2VyX2ZvbnRfbmFtZRgGIAEoCVIPYn'
    'Jvd3NlckZvbnROYW1lEioKEWJyb3dzZXJfZm9udF9zaXplGAcgASgNUg9icm93c2VyRm9udFNp'
    'emUSEwoCaWQYCCABKANIAFICaWSIAQESFQoFb3RoZXIY/wEgASgMUgVvdGhlckIFCgNfaWQ=');

@$core.Deprecated('Use addOrUpdateNotetypeRequestDescriptor instead')
const AddOrUpdateNotetypeRequest$json = {
  '1': 'AddOrUpdateNotetypeRequest',
  '2': [
    {'1': 'json', '3': 1, '4': 1, '5': 12, '10': 'json'},
    {
      '1': 'preserve_usn_and_mtime',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'preserveUsnAndMtime'
    },
    {'1': 'skip_checks', '3': 3, '4': 1, '5': 8, '10': 'skipChecks'},
  ],
};

/// Descriptor for `AddOrUpdateNotetypeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addOrUpdateNotetypeRequestDescriptor =
    $convert.base64Decode(
        'ChpBZGRPclVwZGF0ZU5vdGV0eXBlUmVxdWVzdBISCgRqc29uGAEgASgMUgRqc29uEjMKFnByZX'
        'NlcnZlX3Vzbl9hbmRfbXRpbWUYAiABKAhSE3ByZXNlcnZlVXNuQW5kTXRpbWUSHwoLc2tpcF9j'
        'aGVja3MYAyABKAhSCnNraXBDaGVja3M=');

@$core.Deprecated('Use updateNotetypeLegacyRequestDescriptor instead')
const UpdateNotetypeLegacyRequest$json = {
  '1': 'UpdateNotetypeLegacyRequest',
  '2': [
    {'1': 'json', '3': 1, '4': 1, '5': 12, '10': 'json'},
    {'1': 'skip_checks', '3': 2, '4': 1, '5': 8, '10': 'skipChecks'},
  ],
};

/// Descriptor for `UpdateNotetypeLegacyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotetypeLegacyRequestDescriptor =
    $convert.base64Decode(
        'ChtVcGRhdGVOb3RldHlwZUxlZ2FjeVJlcXVlc3QSEgoEanNvbhgBIAEoDFIEanNvbhIfCgtza2'
        'lwX2NoZWNrcxgCIAEoCFIKc2tpcENoZWNrcw==');

@$core.Deprecated('Use stockNotetypeDescriptor instead')
const StockNotetype$json = {
  '1': 'StockNotetype',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.notetypes.StockNotetype.Kind',
      '10': 'kind'
    },
  ],
  '4': [StockNotetype_Kind$json, StockNotetype_OriginalStockKind$json],
};

@$core.Deprecated('Use stockNotetypeDescriptor instead')
const StockNotetype_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'KIND_BASIC', '2': 0},
    {'1': 'KIND_BASIC_AND_REVERSED', '2': 1},
    {'1': 'KIND_BASIC_OPTIONAL_REVERSED', '2': 2},
    {'1': 'KIND_BASIC_TYPING', '2': 3},
    {'1': 'KIND_CLOZE', '2': 4},
    {'1': 'KIND_IMAGE_OCCLUSION', '2': 5},
  ],
};

@$core.Deprecated('Use stockNotetypeDescriptor instead')
const StockNotetype_OriginalStockKind$json = {
  '1': 'OriginalStockKind',
  '2': [
    {'1': 'ORIGINAL_STOCK_KIND_UNKNOWN', '2': 0},
    {'1': 'ORIGINAL_STOCK_KIND_BASIC', '2': 1},
    {'1': 'ORIGINAL_STOCK_KIND_BASIC_AND_REVERSED', '2': 2},
    {'1': 'ORIGINAL_STOCK_KIND_BASIC_OPTIONAL_REVERSED', '2': 3},
    {'1': 'ORIGINAL_STOCK_KIND_BASIC_TYPING', '2': 4},
    {'1': 'ORIGINAL_STOCK_KIND_CLOZE', '2': 5},
    {'1': 'ORIGINAL_STOCK_KIND_IMAGE_OCCLUSION', '2': 6},
  ],
};

/// Descriptor for `StockNotetype`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockNotetypeDescriptor = $convert.base64Decode(
    'Cg1TdG9ja05vdGV0eXBlEjYKBGtpbmQYASABKA4yIi5hbmtpLm5vdGV0eXBlcy5TdG9ja05vdG'
    'V0eXBlLktpbmRSBGtpbmQilgEKBEtpbmQSDgoKS0lORF9CQVNJQxAAEhsKF0tJTkRfQkFTSUNf'
    'QU5EX1JFVkVSU0VEEAESIAocS0lORF9CQVNJQ19PUFRJT05BTF9SRVZFUlNFRBACEhUKEUtJTk'
    'RfQkFTSUNfVFlQSU5HEAMSDgoKS0lORF9DTE9aRRAEEhgKFEtJTkRfSU1BR0VfT0NDTFVTSU9O'
    'EAUingIKEU9yaWdpbmFsU3RvY2tLaW5kEh8KG09SSUdJTkFMX1NUT0NLX0tJTkRfVU5LTk9XTh'
    'AAEh0KGU9SSUdJTkFMX1NUT0NLX0tJTkRfQkFTSUMQARIqCiZPUklHSU5BTF9TVE9DS19LSU5E'
    'X0JBU0lDX0FORF9SRVZFUlNFRBACEi8KK09SSUdJTkFMX1NUT0NLX0tJTkRfQkFTSUNfT1BUSU'
    '9OQUxfUkVWRVJTRUQQAxIkCiBPUklHSU5BTF9TVE9DS19LSU5EX0JBU0lDX1RZUElORxAEEh0K'
    'GU9SSUdJTkFMX1NUT0NLX0tJTkRfQ0xPWkUQBRInCiNPUklHSU5BTF9TVE9DS19LSU5EX0lNQU'
    'dFX09DQ0xVU0lPThAG');

@$core.Deprecated('Use notetypeNamesDescriptor instead')
const NotetypeNames$json = {
  '1': 'NotetypeNames',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.notetypes.NotetypeNameId',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `NotetypeNames`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notetypeNamesDescriptor = $convert.base64Decode(
    'Cg1Ob3RldHlwZU5hbWVzEjgKB2VudHJpZXMYASADKAsyHi5hbmtpLm5vdGV0eXBlcy5Ob3RldH'
    'lwZU5hbWVJZFIHZW50cmllcw==');

@$core.Deprecated('Use notetypeUseCountsDescriptor instead')
const NotetypeUseCounts$json = {
  '1': 'NotetypeUseCounts',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.notetypes.NotetypeNameIdUseCount',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `NotetypeUseCounts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notetypeUseCountsDescriptor = $convert.base64Decode(
    'ChFOb3RldHlwZVVzZUNvdW50cxJACgdlbnRyaWVzGAEgAygLMiYuYW5raS5ub3RldHlwZXMuTm'
    '90ZXR5cGVOYW1lSWRVc2VDb3VudFIHZW50cmllcw==');

@$core.Deprecated('Use notetypeNameIdDescriptor instead')
const NotetypeNameId$json = {
  '1': 'NotetypeNameId',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `NotetypeNameId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notetypeNameIdDescriptor = $convert.base64Decode(
    'Cg5Ob3RldHlwZU5hbWVJZBIOCgJpZBgBIAEoA1ICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use notetypeNameIdUseCountDescriptor instead')
const NotetypeNameIdUseCount$json = {
  '1': 'NotetypeNameIdUseCount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'use_count', '3': 3, '4': 1, '5': 13, '10': 'useCount'},
  ],
};

/// Descriptor for `NotetypeNameIdUseCount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notetypeNameIdUseCountDescriptor =
    $convert.base64Decode(
        'ChZOb3RldHlwZU5hbWVJZFVzZUNvdW50Eg4KAmlkGAEgASgDUgJpZBISCgRuYW1lGAIgASgJUg'
        'RuYW1lEhsKCXVzZV9jb3VudBgDIAEoDVIIdXNlQ291bnQ=');

@$core.Deprecated('Use getAuxConfigKeyRequestDescriptor instead')
const GetAuxConfigKeyRequest$json = {
  '1': 'GetAuxConfigKeyRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'key', '3': 2, '4': 1, '5': 9, '10': 'key'},
  ],
};

/// Descriptor for `GetAuxConfigKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAuxConfigKeyRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRBdXhDb25maWdLZXlSZXF1ZXN0Eg4KAmlkGAEgASgDUgJpZBIQCgNrZXkYAiABKAlSA2'
        'tleQ==');

@$core.Deprecated('Use getAuxTemplateConfigKeyRequestDescriptor instead')
const GetAuxTemplateConfigKeyRequest$json = {
  '1': 'GetAuxTemplateConfigKeyRequest',
  '2': [
    {'1': 'notetype_id', '3': 1, '4': 1, '5': 3, '10': 'notetypeId'},
    {'1': 'card_ordinal', '3': 2, '4': 1, '5': 13, '10': 'cardOrdinal'},
    {'1': 'key', '3': 3, '4': 1, '5': 9, '10': 'key'},
  ],
};

/// Descriptor for `GetAuxTemplateConfigKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAuxTemplateConfigKeyRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRBdXhUZW1wbGF0ZUNvbmZpZ0tleVJlcXVlc3QSHwoLbm90ZXR5cGVfaWQYASABKANSCm'
        '5vdGV0eXBlSWQSIQoMY2FyZF9vcmRpbmFsGAIgASgNUgtjYXJkT3JkaW5hbBIQCgNrZXkYAyAB'
        'KAlSA2tleQ==');

@$core.Deprecated('Use getChangeNotetypeInfoRequestDescriptor instead')
const GetChangeNotetypeInfoRequest$json = {
  '1': 'GetChangeNotetypeInfoRequest',
  '2': [
    {'1': 'old_notetype_id', '3': 1, '4': 1, '5': 3, '10': 'oldNotetypeId'},
    {'1': 'new_notetype_id', '3': 2, '4': 1, '5': 3, '10': 'newNotetypeId'},
  ],
};

/// Descriptor for `GetChangeNotetypeInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChangeNotetypeInfoRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRDaGFuZ2VOb3RldHlwZUluZm9SZXF1ZXN0EiYKD29sZF9ub3RldHlwZV9pZBgBIAEoA1'
        'INb2xkTm90ZXR5cGVJZBImCg9uZXdfbm90ZXR5cGVfaWQYAiABKANSDW5ld05vdGV0eXBlSWQ=');

@$core.Deprecated('Use changeNotetypeRequestDescriptor instead')
const ChangeNotetypeRequest$json = {
  '1': 'ChangeNotetypeRequest',
  '2': [
    {'1': 'note_ids', '3': 1, '4': 3, '5': 3, '10': 'noteIds'},
    {'1': 'new_fields', '3': 2, '4': 3, '5': 5, '10': 'newFields'},
    {'1': 'new_templates', '3': 3, '4': 3, '5': 5, '10': 'newTemplates'},
    {'1': 'old_notetype_id', '3': 4, '4': 1, '5': 3, '10': 'oldNotetypeId'},
    {'1': 'new_notetype_id', '3': 5, '4': 1, '5': 3, '10': 'newNotetypeId'},
    {'1': 'current_schema', '3': 6, '4': 1, '5': 3, '10': 'currentSchema'},
    {'1': 'old_notetype_name', '3': 7, '4': 1, '5': 9, '10': 'oldNotetypeName'},
    {'1': 'is_cloze', '3': 8, '4': 1, '5': 8, '10': 'isCloze'},
  ],
};

/// Descriptor for `ChangeNotetypeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeNotetypeRequestDescriptor = $convert.base64Decode(
    'ChVDaGFuZ2VOb3RldHlwZVJlcXVlc3QSGQoIbm90ZV9pZHMYASADKANSB25vdGVJZHMSHQoKbm'
    'V3X2ZpZWxkcxgCIAMoBVIJbmV3RmllbGRzEiMKDW5ld190ZW1wbGF0ZXMYAyADKAVSDG5ld1Rl'
    'bXBsYXRlcxImCg9vbGRfbm90ZXR5cGVfaWQYBCABKANSDW9sZE5vdGV0eXBlSWQSJgoPbmV3X2'
    '5vdGV0eXBlX2lkGAUgASgDUg1uZXdOb3RldHlwZUlkEiUKDmN1cnJlbnRfc2NoZW1hGAYgASgD'
    'Ug1jdXJyZW50U2NoZW1hEioKEW9sZF9ub3RldHlwZV9uYW1lGAcgASgJUg9vbGROb3RldHlwZU'
    '5hbWUSGQoIaXNfY2xvemUYCCABKAhSB2lzQ2xvemU=');

@$core.Deprecated('Use changeNotetypeInfoDescriptor instead')
const ChangeNotetypeInfo$json = {
  '1': 'ChangeNotetypeInfo',
  '2': [
    {'1': 'old_field_names', '3': 1, '4': 3, '5': 9, '10': 'oldFieldNames'},
    {
      '1': 'old_template_names',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'oldTemplateNames'
    },
    {'1': 'new_field_names', '3': 3, '4': 3, '5': 9, '10': 'newFieldNames'},
    {
      '1': 'new_template_names',
      '3': 4,
      '4': 3,
      '5': 9,
      '10': 'newTemplateNames'
    },
    {
      '1': 'input',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.anki.notetypes.ChangeNotetypeRequest',
      '10': 'input'
    },
    {'1': 'old_notetype_name', '3': 6, '4': 1, '5': 9, '10': 'oldNotetypeName'},
  ],
};

/// Descriptor for `ChangeNotetypeInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeNotetypeInfoDescriptor = $convert.base64Decode(
    'ChJDaGFuZ2VOb3RldHlwZUluZm8SJgoPb2xkX2ZpZWxkX25hbWVzGAEgAygJUg1vbGRGaWVsZE'
    '5hbWVzEiwKEm9sZF90ZW1wbGF0ZV9uYW1lcxgCIAMoCVIQb2xkVGVtcGxhdGVOYW1lcxImCg9u'
    'ZXdfZmllbGRfbmFtZXMYAyADKAlSDW5ld0ZpZWxkTmFtZXMSLAoSbmV3X3RlbXBsYXRlX25hbW'
    'VzGAQgAygJUhBuZXdUZW1wbGF0ZU5hbWVzEjsKBWlucHV0GAUgASgLMiUuYW5raS5ub3RldHlw'
    'ZXMuQ2hhbmdlTm90ZXR5cGVSZXF1ZXN0UgVpbnB1dBIqChFvbGRfbm90ZXR5cGVfbmFtZRgGIA'
    'EoCVIPb2xkTm90ZXR5cGVOYW1l');

@$core.Deprecated('Use restoreNotetypeToStockRequestDescriptor instead')
const RestoreNotetypeToStockRequest$json = {
  '1': 'RestoreNotetypeToStockRequest',
  '2': [
    {
      '1': 'notetype_id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.notetypes.NotetypeId',
      '10': 'notetypeId'
    },
    {
      '1': 'force_kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.notetypes.StockNotetype.Kind',
      '9': 0,
      '10': 'forceKind',
      '17': true
    },
  ],
  '8': [
    {'1': '_force_kind'},
  ],
};

/// Descriptor for `RestoreNotetypeToStockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restoreNotetypeToStockRequestDescriptor = $convert.base64Decode(
    'Ch1SZXN0b3JlTm90ZXR5cGVUb1N0b2NrUmVxdWVzdBI7Cgtub3RldHlwZV9pZBgBIAEoCzIaLm'
    'Fua2kubm90ZXR5cGVzLk5vdGV0eXBlSWRSCm5vdGV0eXBlSWQSRgoKZm9yY2Vfa2luZBgCIAEo'
    'DjIiLmFua2kubm90ZXR5cGVzLlN0b2NrTm90ZXR5cGUuS2luZEgAUglmb3JjZUtpbmSIAQFCDQ'
    'oLX2ZvcmNlX2tpbmQ=');

@$core.Deprecated('Use getClozeFieldOrdsResponseDescriptor instead')
const GetClozeFieldOrdsResponse$json = {
  '1': 'GetClozeFieldOrdsResponse',
  '2': [
    {'1': 'ords', '3': 1, '4': 3, '5': 13, '10': 'ords'},
  ],
};

/// Descriptor for `GetClozeFieldOrdsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClozeFieldOrdsResponseDescriptor =
    $convert.base64Decode(
        'ChlHZXRDbG96ZUZpZWxkT3Jkc1Jlc3BvbnNlEhIKBG9yZHMYASADKA1SBG9yZHM=');

const $core.Map<$core.String, $core.dynamic> NotetypesServiceBase$json = {
  '1': 'NotetypesService',
  '2': [
    {
      '1': 'AddNotetype',
      '2': '.anki.notetypes.Notetype',
      '3': '.anki.collection.OpChangesWithId'
    },
    {
      '1': 'UpdateNotetype',
      '2': '.anki.notetypes.Notetype',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'AddNotetypeLegacy',
      '2': '.anki.generic.Json',
      '3': '.anki.collection.OpChangesWithId'
    },
    {
      '1': 'UpdateNotetypeLegacy',
      '2': '.anki.notetypes.UpdateNotetypeLegacyRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'AddOrUpdateNotetype',
      '2': '.anki.notetypes.AddOrUpdateNotetypeRequest',
      '3': '.anki.notetypes.NotetypeId'
    },
    {
      '1': 'GetStockNotetypeLegacy',
      '2': '.anki.notetypes.StockNotetype',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'GetNotetype',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.notetypes.Notetype'
    },
    {
      '1': 'GetNotetypeLegacy',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'GetNotetypeNames',
      '2': '.anki.generic.Empty',
      '3': '.anki.notetypes.NotetypeNames'
    },
    {
      '1': 'GetNotetypeNamesAndCounts',
      '2': '.anki.generic.Empty',
      '3': '.anki.notetypes.NotetypeUseCounts'
    },
    {
      '1': 'GetNotetypeIdByName',
      '2': '.anki.generic.String',
      '3': '.anki.notetypes.NotetypeId'
    },
    {
      '1': 'RemoveNotetype',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetAuxNotetypeConfigKey',
      '2': '.anki.notetypes.GetAuxConfigKeyRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'GetAuxTemplateConfigKey',
      '2': '.anki.notetypes.GetAuxTemplateConfigKeyRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'GetChangeNotetypeInfo',
      '2': '.anki.notetypes.GetChangeNotetypeInfoRequest',
      '3': '.anki.notetypes.ChangeNotetypeInfo'
    },
    {
      '1': 'ChangeNotetype',
      '2': '.anki.notetypes.ChangeNotetypeRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetFieldNames',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.generic.StringList'
    },
    {
      '1': 'RestoreNotetypeToStock',
      '2': '.anki.notetypes.RestoreNotetypeToStockRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'GetClozeFieldOrds',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.notetypes.GetClozeFieldOrdsResponse'
    },
  ],
};

@$core.Deprecated('Use notetypesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    NotetypesServiceBase$messageJson = {
  '.anki.notetypes.Notetype': Notetype$json,
  '.anki.notetypes.Notetype.Config': Notetype_Config$json,
  '.anki.notetypes.Notetype.Config.CardRequirement':
      Notetype_Config_CardRequirement$json,
  '.anki.notetypes.Notetype.Field': Notetype_Field$json,
  '.anki.generic.UInt32': $0.UInt32$json,
  '.anki.notetypes.Notetype.Field.Config': Notetype_Field_Config$json,
  '.anki.notetypes.Notetype.Template': Notetype_Template$json,
  '.anki.notetypes.Notetype.Template.Config': Notetype_Template_Config$json,
  '.anki.collection.OpChangesWithId': $1.OpChangesWithId$json,
  '.anki.collection.OpChanges': $1.OpChanges$json,
  '.anki.generic.Json': $0.Json$json,
  '.anki.notetypes.UpdateNotetypeLegacyRequest':
      UpdateNotetypeLegacyRequest$json,
  '.anki.notetypes.AddOrUpdateNotetypeRequest': AddOrUpdateNotetypeRequest$json,
  '.anki.notetypes.NotetypeId': NotetypeId$json,
  '.anki.notetypes.StockNotetype': StockNotetype$json,
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.notetypes.NotetypeNames': NotetypeNames$json,
  '.anki.notetypes.NotetypeNameId': NotetypeNameId$json,
  '.anki.notetypes.NotetypeUseCounts': NotetypeUseCounts$json,
  '.anki.notetypes.NotetypeNameIdUseCount': NotetypeNameIdUseCount$json,
  '.anki.generic.String': $0.String$json,
  '.anki.notetypes.GetAuxConfigKeyRequest': GetAuxConfigKeyRequest$json,
  '.anki.notetypes.GetAuxTemplateConfigKeyRequest':
      GetAuxTemplateConfigKeyRequest$json,
  '.anki.notetypes.GetChangeNotetypeInfoRequest':
      GetChangeNotetypeInfoRequest$json,
  '.anki.notetypes.ChangeNotetypeInfo': ChangeNotetypeInfo$json,
  '.anki.notetypes.ChangeNotetypeRequest': ChangeNotetypeRequest$json,
  '.anki.generic.StringList': $0.StringList$json,
  '.anki.notetypes.RestoreNotetypeToStockRequest':
      RestoreNotetypeToStockRequest$json,
  '.anki.notetypes.GetClozeFieldOrdsResponse': GetClozeFieldOrdsResponse$json,
};

/// Descriptor for `NotetypesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List notetypesServiceDescriptor = $convert.base64Decode(
    'ChBOb3RldHlwZXNTZXJ2aWNlEkkKC0FkZE5vdGV0eXBlEhguYW5raS5ub3RldHlwZXMuTm90ZX'
    'R5cGUaIC5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzV2l0aElkEkYKDlVwZGF0ZU5vdGV0eXBl'
    'EhguYW5raS5ub3RldHlwZXMuTm90ZXR5cGUaGi5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzEk'
    'kKEUFkZE5vdGV0eXBlTGVnYWN5EhIuYW5raS5nZW5lcmljLkpzb24aIC5hbmtpLmNvbGxlY3Rp'
    'b24uT3BDaGFuZ2VzV2l0aElkEl8KFFVwZGF0ZU5vdGV0eXBlTGVnYWN5EisuYW5raS5ub3RldH'
    'lwZXMuVXBkYXRlTm90ZXR5cGVMZWdhY3lSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hh'
    'bmdlcxJdChNBZGRPclVwZGF0ZU5vdGV0eXBlEiouYW5raS5ub3RldHlwZXMuQWRkT3JVcGRhdG'
    'VOb3RldHlwZVJlcXVlc3QaGi5hbmtpLm5vdGV0eXBlcy5Ob3RldHlwZUlkEksKFkdldFN0b2Nr'
    'Tm90ZXR5cGVMZWdhY3kSHS5hbmtpLm5vdGV0eXBlcy5TdG9ja05vdGV0eXBlGhIuYW5raS5nZW'
    '5lcmljLkpzb24SQwoLR2V0Tm90ZXR5cGUSGi5hbmtpLm5vdGV0eXBlcy5Ob3RldHlwZUlkGhgu'
    'YW5raS5ub3RldHlwZXMuTm90ZXR5cGUSQwoRR2V0Tm90ZXR5cGVMZWdhY3kSGi5hbmtpLm5vdG'
    'V0eXBlcy5Ob3RldHlwZUlkGhIuYW5raS5nZW5lcmljLkpzb24SRgoQR2V0Tm90ZXR5cGVOYW1l'
    'cxITLmFua2kuZ2VuZXJpYy5FbXB0eRodLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlTmFtZXMSUw'
    'oZR2V0Tm90ZXR5cGVOYW1lc0FuZENvdW50cxITLmFua2kuZ2VuZXJpYy5FbXB0eRohLmFua2ku'
    'bm90ZXR5cGVzLk5vdGV0eXBlVXNlQ291bnRzEkcKE0dldE5vdGV0eXBlSWRCeU5hbWUSFC5hbm'
    'tpLmdlbmVyaWMuU3RyaW5nGhouYW5raS5ub3RldHlwZXMuTm90ZXR5cGVJZBJICg5SZW1vdmVO'
    'b3RldHlwZRIaLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlSWQaGi5hbmtpLmNvbGxlY3Rpb24uT3'
    'BDaGFuZ2VzElcKF0dldEF1eE5vdGV0eXBlQ29uZmlnS2V5EiYuYW5raS5ub3RldHlwZXMuR2V0'
    'QXV4Q29uZmlnS2V5UmVxdWVzdBoULmFua2kuZ2VuZXJpYy5TdHJpbmcSXwoXR2V0QXV4VGVtcG'
    'xhdGVDb25maWdLZXkSLi5hbmtpLm5vdGV0eXBlcy5HZXRBdXhUZW1wbGF0ZUNvbmZpZ0tleVJl'
    'cXVlc3QaFC5hbmtpLmdlbmVyaWMuU3RyaW5nEmkKFUdldENoYW5nZU5vdGV0eXBlSW5mbxIsLm'
    'Fua2kubm90ZXR5cGVzLkdldENoYW5nZU5vdGV0eXBlSW5mb1JlcXVlc3QaIi5hbmtpLm5vdGV0'
    'eXBlcy5DaGFuZ2VOb3RldHlwZUluZm8SUwoOQ2hhbmdlTm90ZXR5cGUSJS5hbmtpLm5vdGV0eX'
    'Blcy5DaGFuZ2VOb3RldHlwZVJlcXVlc3QaGi5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzEkUK'
    'DUdldEZpZWxkTmFtZXMSGi5hbmtpLm5vdGV0eXBlcy5Ob3RldHlwZUlkGhguYW5raS5nZW5lcm'
    'ljLlN0cmluZ0xpc3QSYwoWUmVzdG9yZU5vdGV0eXBlVG9TdG9jaxItLmFua2kubm90ZXR5cGVz'
    'LlJlc3RvcmVOb3RldHlwZVRvU3RvY2tSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbm'
    'dlcxJaChFHZXRDbG96ZUZpZWxkT3JkcxIaLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlSWQaKS5h'
    'bmtpLm5vdGV0eXBlcy5HZXRDbG96ZUZpZWxkT3Jkc1Jlc3BvbnNl');

const $core.Map<$core.String, $core.dynamic> BackendNotetypesServiceBase$json =
    {'1': 'BackendNotetypesService'};

@$core.Deprecated('Use backendNotetypesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendNotetypesServiceBase$messageJson = {};

/// Descriptor for `BackendNotetypesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendNotetypesServiceDescriptor =
    $convert.base64Decode('ChdCYWNrZW5kTm90ZXR5cGVzU2VydmljZQ==');
