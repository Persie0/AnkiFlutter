// This is a generated file - do not edit.
//
// Generated from anki/image_occlusion.proto.

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

@$core.Deprecated('Use getImageForOcclusionRequestDescriptor instead')
const GetImageForOcclusionRequest$json = {
  '1': 'GetImageForOcclusionRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `GetImageForOcclusionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImageForOcclusionRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRJbWFnZUZvck9jY2x1c2lvblJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aA==');

@$core.Deprecated('Use getImageForOcclusionResponseDescriptor instead')
const GetImageForOcclusionResponse$json = {
  '1': 'GetImageForOcclusionResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetImageForOcclusionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImageForOcclusionResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXRJbWFnZUZvck9jY2x1c2lvblJlc3BvbnNlEhIKBGRhdGEYASABKAxSBGRhdGESEgoEbm'
        'FtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use addImageOcclusionNoteRequestDescriptor instead')
const AddImageOcclusionNoteRequest$json = {
  '1': 'AddImageOcclusionNoteRequest',
  '2': [
    {'1': 'image_path', '3': 1, '4': 1, '5': 9, '10': 'imagePath'},
    {'1': 'occlusions', '3': 2, '4': 1, '5': 9, '10': 'occlusions'},
    {'1': 'header', '3': 3, '4': 1, '5': 9, '10': 'header'},
    {'1': 'back_extra', '3': 4, '4': 1, '5': 9, '10': 'backExtra'},
    {'1': 'tags', '3': 5, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'notetype_id', '3': 6, '4': 1, '5': 3, '10': 'notetypeId'},
  ],
};

/// Descriptor for `AddImageOcclusionNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addImageOcclusionNoteRequestDescriptor = $convert.base64Decode(
    'ChxBZGRJbWFnZU9jY2x1c2lvbk5vdGVSZXF1ZXN0Eh0KCmltYWdlX3BhdGgYASABKAlSCWltYW'
    'dlUGF0aBIeCgpvY2NsdXNpb25zGAIgASgJUgpvY2NsdXNpb25zEhYKBmhlYWRlchgDIAEoCVIG'
    'aGVhZGVyEh0KCmJhY2tfZXh0cmEYBCABKAlSCWJhY2tFeHRyYRISCgR0YWdzGAUgAygJUgR0YW'
    'dzEh8KC25vdGV0eXBlX2lkGAYgASgDUgpub3RldHlwZUlk');

@$core.Deprecated('Use getImageOcclusionNoteRequestDescriptor instead')
const GetImageOcclusionNoteRequest$json = {
  '1': 'GetImageOcclusionNoteRequest',
  '2': [
    {'1': 'note_id', '3': 1, '4': 1, '5': 3, '10': 'noteId'},
  ],
};

/// Descriptor for `GetImageOcclusionNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImageOcclusionNoteRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRJbWFnZU9jY2x1c2lvbk5vdGVSZXF1ZXN0EhcKB25vdGVfaWQYASABKANSBm5vdGVJZA'
        '==');

@$core.Deprecated('Use getImageOcclusionNoteResponseDescriptor instead')
const GetImageOcclusionNoteResponse$json = {
  '1': 'GetImageOcclusionNoteResponse',
  '2': [
    {
      '1': 'note',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusionNote',
      '9': 0,
      '10': 'note'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'error'},
  ],
  '3': [
    GetImageOcclusionNoteResponse_ImageOcclusionProperty$json,
    GetImageOcclusionNoteResponse_ImageOcclusionShape$json,
    GetImageOcclusionNoteResponse_ImageOcclusion$json,
    GetImageOcclusionNoteResponse_ImageOcclusionNote$json
  ],
  '8': [
    {'1': 'value'},
  ],
};

@$core.Deprecated('Use getImageOcclusionNoteResponseDescriptor instead')
const GetImageOcclusionNoteResponse_ImageOcclusionProperty$json = {
  '1': 'ImageOcclusionProperty',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

@$core.Deprecated('Use getImageOcclusionNoteResponseDescriptor instead')
const GetImageOcclusionNoteResponse_ImageOcclusionShape$json = {
  '1': 'ImageOcclusionShape',
  '2': [
    {'1': 'shape', '3': 1, '4': 1, '5': 9, '10': 'shape'},
    {
      '1': 'properties',
      '3': 2,
      '4': 3,
      '5': 11,
      '6':
          '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusionProperty',
      '10': 'properties'
    },
  ],
};

@$core.Deprecated('Use getImageOcclusionNoteResponseDescriptor instead')
const GetImageOcclusionNoteResponse_ImageOcclusion$json = {
  '1': 'ImageOcclusion',
  '2': [
    {
      '1': 'shapes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusionShape',
      '10': 'shapes'
    },
    {'1': 'ordinal', '3': 2, '4': 1, '5': 13, '10': 'ordinal'},
  ],
};

@$core.Deprecated('Use getImageOcclusionNoteResponseDescriptor instead')
const GetImageOcclusionNoteResponse_ImageOcclusionNote$json = {
  '1': 'ImageOcclusionNote',
  '2': [
    {'1': 'image_data', '3': 1, '4': 1, '5': 12, '10': 'imageData'},
    {
      '1': 'occlusions',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusion',
      '10': 'occlusions'
    },
    {'1': 'header', '3': 3, '4': 1, '5': 9, '10': 'header'},
    {'1': 'back_extra', '3': 4, '4': 1, '5': 9, '10': 'backExtra'},
    {'1': 'tags', '3': 5, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'image_file_name', '3': 6, '4': 1, '5': 9, '10': 'imageFileName'},
    {'1': 'occlude_inactive', '3': 7, '4': 1, '5': 8, '10': 'occludeInactive'},
  ],
};

/// Descriptor for `GetImageOcclusionNoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImageOcclusionNoteResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRJbWFnZU9jY2x1c2lvbk5vdGVSZXNwb25zZRJcCgRub3RlGAEgASgLMkYuYW5raS5pbW'
    'FnZV9vY2NsdXNpb24uR2V0SW1hZ2VPY2NsdXNpb25Ob3RlUmVzcG9uc2UuSW1hZ2VPY2NsdXNp'
    'b25Ob3RlSABSBG5vdGUSFgoFZXJyb3IYAiABKAlIAFIFZXJyb3IaQgoWSW1hZ2VPY2NsdXNpb2'
    '5Qcm9wZXJ0eRISCgRuYW1lGAEgASgJUgRuYW1lEhQKBXZhbHVlGAIgASgJUgV2YWx1ZRqXAQoT'
    'SW1hZ2VPY2NsdXNpb25TaGFwZRIUCgVzaGFwZRgBIAEoCVIFc2hhcGUSagoKcHJvcGVydGllcx'
    'gCIAMoCzJKLmFua2kuaW1hZ2Vfb2NjbHVzaW9uLkdldEltYWdlT2NjbHVzaW9uTm90ZVJlc3Bv'
    'bnNlLkltYWdlT2NjbHVzaW9uUHJvcGVydHlSCnByb3BlcnRpZXMaiwEKDkltYWdlT2NjbHVzaW'
    '9uEl8KBnNoYXBlcxgBIAMoCzJHLmFua2kuaW1hZ2Vfb2NjbHVzaW9uLkdldEltYWdlT2NjbHVz'
    'aW9uTm90ZVJlc3BvbnNlLkltYWdlT2NjbHVzaW9uU2hhcGVSBnNoYXBlcxIYCgdvcmRpbmFsGA'
    'IgASgNUgdvcmRpbmFsGrUCChJJbWFnZU9jY2x1c2lvbk5vdGUSHQoKaW1hZ2VfZGF0YRgBIAEo'
    'DFIJaW1hZ2VEYXRhEmIKCm9jY2x1c2lvbnMYAiADKAsyQi5hbmtpLmltYWdlX29jY2x1c2lvbi'
    '5HZXRJbWFnZU9jY2x1c2lvbk5vdGVSZXNwb25zZS5JbWFnZU9jY2x1c2lvblIKb2NjbHVzaW9u'
    'cxIWCgZoZWFkZXIYAyABKAlSBmhlYWRlchIdCgpiYWNrX2V4dHJhGAQgASgJUgliYWNrRXh0cm'
    'ESEgoEdGFncxgFIAMoCVIEdGFncxImCg9pbWFnZV9maWxlX25hbWUYBiABKAlSDWltYWdlRmls'
    'ZU5hbWUSKQoQb2NjbHVkZV9pbmFjdGl2ZRgHIAEoCFIPb2NjbHVkZUluYWN0aXZlQgcKBXZhbH'
    'Vl');

@$core.Deprecated('Use updateImageOcclusionNoteRequestDescriptor instead')
const UpdateImageOcclusionNoteRequest$json = {
  '1': 'UpdateImageOcclusionNoteRequest',
  '2': [
    {'1': 'note_id', '3': 1, '4': 1, '5': 3, '10': 'noteId'},
    {'1': 'occlusions', '3': 2, '4': 1, '5': 9, '10': 'occlusions'},
    {'1': 'header', '3': 3, '4': 1, '5': 9, '10': 'header'},
    {'1': 'back_extra', '3': 4, '4': 1, '5': 9, '10': 'backExtra'},
    {'1': 'tags', '3': 5, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `UpdateImageOcclusionNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateImageOcclusionNoteRequestDescriptor =
    $convert.base64Decode(
        'Ch9VcGRhdGVJbWFnZU9jY2x1c2lvbk5vdGVSZXF1ZXN0EhcKB25vdGVfaWQYASABKANSBm5vdG'
        'VJZBIeCgpvY2NsdXNpb25zGAIgASgJUgpvY2NsdXNpb25zEhYKBmhlYWRlchgDIAEoCVIGaGVh'
        'ZGVyEh0KCmJhY2tfZXh0cmEYBCABKAlSCWJhY2tFeHRyYRISCgR0YWdzGAUgAygJUgR0YWdz');

@$core.Deprecated('Use getImageOcclusionFieldsRequestDescriptor instead')
const GetImageOcclusionFieldsRequest$json = {
  '1': 'GetImageOcclusionFieldsRequest',
  '2': [
    {'1': 'notetype_id', '3': 1, '4': 1, '5': 3, '10': 'notetypeId'},
  ],
};

/// Descriptor for `GetImageOcclusionFieldsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImageOcclusionFieldsRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRJbWFnZU9jY2x1c2lvbkZpZWxkc1JlcXVlc3QSHwoLbm90ZXR5cGVfaWQYASABKANSCm'
        '5vdGV0eXBlSWQ=');

@$core.Deprecated('Use getImageOcclusionFieldsResponseDescriptor instead')
const GetImageOcclusionFieldsResponse$json = {
  '1': 'GetImageOcclusionFieldsResponse',
  '2': [
    {
      '1': 'fields',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.image_occlusion.ImageOcclusionFieldIndexes',
      '10': 'fields'
    },
  ],
};

/// Descriptor for `GetImageOcclusionFieldsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImageOcclusionFieldsResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRJbWFnZU9jY2x1c2lvbkZpZWxkc1Jlc3BvbnNlEkgKBmZpZWxkcxgBIAEoCzIwLmFua2'
        'kuaW1hZ2Vfb2NjbHVzaW9uLkltYWdlT2NjbHVzaW9uRmllbGRJbmRleGVzUgZmaWVsZHM=');

@$core.Deprecated('Use imageOcclusionFieldIndexesDescriptor instead')
const ImageOcclusionFieldIndexes$json = {
  '1': 'ImageOcclusionFieldIndexes',
  '2': [
    {'1': 'occlusions', '3': 1, '4': 1, '5': 13, '10': 'occlusions'},
    {'1': 'image', '3': 2, '4': 1, '5': 13, '10': 'image'},
    {'1': 'header', '3': 3, '4': 1, '5': 13, '10': 'header'},
    {'1': 'back_extra', '3': 4, '4': 1, '5': 13, '10': 'backExtra'},
  ],
};

/// Descriptor for `ImageOcclusionFieldIndexes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageOcclusionFieldIndexesDescriptor =
    $convert.base64Decode(
        'ChpJbWFnZU9jY2x1c2lvbkZpZWxkSW5kZXhlcxIeCgpvY2NsdXNpb25zGAEgASgNUgpvY2NsdX'
        'Npb25zEhQKBWltYWdlGAIgASgNUgVpbWFnZRIWCgZoZWFkZXIYAyABKA1SBmhlYWRlchIdCgpi'
        'YWNrX2V4dHJhGAQgASgNUgliYWNrRXh0cmE=');

const $core.Map<$core.String, $core.dynamic> ImageOcclusionServiceBase$json = {
  '1': 'ImageOcclusionService',
  '2': [
    {
      '1': 'GetImageForOcclusion',
      '2': '.anki.image_occlusion.GetImageForOcclusionRequest',
      '3': '.anki.image_occlusion.GetImageForOcclusionResponse'
    },
    {
      '1': 'GetImageOcclusionNote',
      '2': '.anki.image_occlusion.GetImageOcclusionNoteRequest',
      '3': '.anki.image_occlusion.GetImageOcclusionNoteResponse'
    },
    {
      '1': 'GetImageOcclusionFields',
      '2': '.anki.image_occlusion.GetImageOcclusionFieldsRequest',
      '3': '.anki.image_occlusion.GetImageOcclusionFieldsResponse'
    },
    {
      '1': 'AddImageOcclusionNotetype',
      '2': '.anki.generic.Empty',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'AddImageOcclusionNote',
      '2': '.anki.image_occlusion.AddImageOcclusionNoteRequest',
      '3': '.anki.collection.OpChanges'
    },
    {
      '1': 'UpdateImageOcclusionNote',
      '2': '.anki.image_occlusion.UpdateImageOcclusionNoteRequest',
      '3': '.anki.collection.OpChanges'
    },
  ],
};

@$core.Deprecated('Use imageOcclusionServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ImageOcclusionServiceBase$messageJson = {
  '.anki.image_occlusion.GetImageForOcclusionRequest':
      GetImageForOcclusionRequest$json,
  '.anki.image_occlusion.GetImageForOcclusionResponse':
      GetImageForOcclusionResponse$json,
  '.anki.image_occlusion.GetImageOcclusionNoteRequest':
      GetImageOcclusionNoteRequest$json,
  '.anki.image_occlusion.GetImageOcclusionNoteResponse':
      GetImageOcclusionNoteResponse$json,
  '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusionNote':
      GetImageOcclusionNoteResponse_ImageOcclusionNote$json,
  '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusion':
      GetImageOcclusionNoteResponse_ImageOcclusion$json,
  '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusionShape':
      GetImageOcclusionNoteResponse_ImageOcclusionShape$json,
  '.anki.image_occlusion.GetImageOcclusionNoteResponse.ImageOcclusionProperty':
      GetImageOcclusionNoteResponse_ImageOcclusionProperty$json,
  '.anki.image_occlusion.GetImageOcclusionFieldsRequest':
      GetImageOcclusionFieldsRequest$json,
  '.anki.image_occlusion.GetImageOcclusionFieldsResponse':
      GetImageOcclusionFieldsResponse$json,
  '.anki.image_occlusion.ImageOcclusionFieldIndexes':
      ImageOcclusionFieldIndexes$json,
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.collection.OpChanges': $1.OpChanges$json,
  '.anki.image_occlusion.AddImageOcclusionNoteRequest':
      AddImageOcclusionNoteRequest$json,
  '.anki.image_occlusion.UpdateImageOcclusionNoteRequest':
      UpdateImageOcclusionNoteRequest$json,
};

/// Descriptor for `ImageOcclusionService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List imageOcclusionServiceDescriptor = $convert.base64Decode(
    'ChVJbWFnZU9jY2x1c2lvblNlcnZpY2USfQoUR2V0SW1hZ2VGb3JPY2NsdXNpb24SMS5hbmtpLm'
    'ltYWdlX29jY2x1c2lvbi5HZXRJbWFnZUZvck9jY2x1c2lvblJlcXVlc3QaMi5hbmtpLmltYWdl'
    'X29jY2x1c2lvbi5HZXRJbWFnZUZvck9jY2x1c2lvblJlc3BvbnNlEoABChVHZXRJbWFnZU9jY2'
    'x1c2lvbk5vdGUSMi5hbmtpLmltYWdlX29jY2x1c2lvbi5HZXRJbWFnZU9jY2x1c2lvbk5vdGVS'
    'ZXF1ZXN0GjMuYW5raS5pbWFnZV9vY2NsdXNpb24uR2V0SW1hZ2VPY2NsdXNpb25Ob3RlUmVzcG'
    '9uc2UShgEKF0dldEltYWdlT2NjbHVzaW9uRmllbGRzEjQuYW5raS5pbWFnZV9vY2NsdXNpb24u'
    'R2V0SW1hZ2VPY2NsdXNpb25GaWVsZHNSZXF1ZXN0GjUuYW5raS5pbWFnZV9vY2NsdXNpb24uR2'
    'V0SW1hZ2VPY2NsdXNpb25GaWVsZHNSZXNwb25zZRJMChlBZGRJbWFnZU9jY2x1c2lvbk5vdGV0'
    'eXBlEhMuYW5raS5nZW5lcmljLkVtcHR5GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcxJnCh'
    'VBZGRJbWFnZU9jY2x1c2lvbk5vdGUSMi5hbmtpLmltYWdlX29jY2x1c2lvbi5BZGRJbWFnZU9j'
    'Y2x1c2lvbk5vdGVSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcxJtChhVcGRhdG'
    'VJbWFnZU9jY2x1c2lvbk5vdGUSNS5hbmtpLmltYWdlX29jY2x1c2lvbi5VcGRhdGVJbWFnZU9j'
    'Y2x1c2lvbk5vdGVSZXF1ZXN0GhouYW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlcw==');

const $core.Map<$core.String, $core.dynamic>
    BackendImageOcclusionServiceBase$json = {
  '1': 'BackendImageOcclusionService'
};

@$core.Deprecated('Use backendImageOcclusionServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendImageOcclusionServiceBase$messageJson = {};

/// Descriptor for `BackendImageOcclusionService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendImageOcclusionServiceDescriptor =
    $convert.base64Decode('ChxCYWNrZW5kSW1hZ2VPY2NsdXNpb25TZXJ2aWNl');
