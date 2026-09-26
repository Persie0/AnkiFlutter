// This is a generated file - do not edit.
//
// Generated from anki/media.proto.

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

import 'generic.pbjson.dart' as $0;
import 'notetypes.pbjson.dart' as $1;

@$core.Deprecated('Use checkMediaResponseDescriptor instead')
const CheckMediaResponse$json = {
  '1': 'CheckMediaResponse',
  '2': [
    {'1': 'unused', '3': 1, '4': 3, '5': 9, '10': 'unused'},
    {'1': 'missing', '3': 2, '4': 3, '5': 9, '10': 'missing'},
    {
      '1': 'missing_media_notes',
      '3': 3,
      '4': 3,
      '5': 3,
      '10': 'missingMediaNotes'
    },
    {'1': 'report', '3': 4, '4': 1, '5': 9, '10': 'report'},
    {'1': 'have_trash', '3': 5, '4': 1, '5': 8, '10': 'haveTrash'},
  ],
};

/// Descriptor for `CheckMediaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkMediaResponseDescriptor = $convert.base64Decode(
    'ChJDaGVja01lZGlhUmVzcG9uc2USFgoGdW51c2VkGAEgAygJUgZ1bnVzZWQSGAoHbWlzc2luZx'
    'gCIAMoCVIHbWlzc2luZxIuChNtaXNzaW5nX21lZGlhX25vdGVzGAMgAygDUhFtaXNzaW5nTWVk'
    'aWFOb3RlcxIWCgZyZXBvcnQYBCABKAlSBnJlcG9ydBIdCgpoYXZlX3RyYXNoGAUgASgIUgloYX'
    'ZlVHJhc2g=');

@$core.Deprecated('Use trashMediaFilesRequestDescriptor instead')
const TrashMediaFilesRequest$json = {
  '1': 'TrashMediaFilesRequest',
  '2': [
    {'1': 'fnames', '3': 1, '4': 3, '5': 9, '10': 'fnames'},
  ],
};

/// Descriptor for `TrashMediaFilesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trashMediaFilesRequestDescriptor =
    $convert.base64Decode(
        'ChZUcmFzaE1lZGlhRmlsZXNSZXF1ZXN0EhYKBmZuYW1lcxgBIAMoCVIGZm5hbWVz');

@$core.Deprecated('Use addMediaFileRequestDescriptor instead')
const AddMediaFileRequest$json = {
  '1': 'AddMediaFileRequest',
  '2': [
    {'1': 'desired_name', '3': 1, '4': 1, '5': 9, '10': 'desiredName'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `AddMediaFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMediaFileRequestDescriptor = $convert.base64Decode(
    'ChNBZGRNZWRpYUZpbGVSZXF1ZXN0EiEKDGRlc2lyZWRfbmFtZRgBIAEoCVILZGVzaXJlZE5hbW'
    'USEgoEZGF0YRgCIAEoDFIEZGF0YQ==');

@$core.Deprecated('Use addMediaFromPathRequestDescriptor instead')
const AddMediaFromPathRequest$json = {
  '1': 'AddMediaFromPathRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `AddMediaFromPathRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMediaFromPathRequestDescriptor =
    $convert.base64Decode(
        'ChdBZGRNZWRpYUZyb21QYXRoUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRo');

@$core.Deprecated('Use addMediaFromUrlRequestDescriptor instead')
const AddMediaFromUrlRequest$json = {
  '1': 'AddMediaFromUrlRequest',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `AddMediaFromUrlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMediaFromUrlRequestDescriptor = $convert
    .base64Decode('ChZBZGRNZWRpYUZyb21VcmxSZXF1ZXN0EhAKA3VybBgBIAEoCVIDdXJs');

@$core.Deprecated('Use addMediaFromUrlResponseDescriptor instead')
const AddMediaFromUrlResponse$json = {
  '1': 'AddMediaFromUrlResponse',
  '2': [
    {
      '1': 'filename',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'filename',
      '17': true
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'error', '17': true},
  ],
  '8': [
    {'1': '_filename'},
    {'1': '_error'},
  ],
};

/// Descriptor for `AddMediaFromUrlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMediaFromUrlResponseDescriptor = $convert.base64Decode(
    'ChdBZGRNZWRpYUZyb21VcmxSZXNwb25zZRIfCghmaWxlbmFtZRgBIAEoCUgAUghmaWxlbmFtZY'
    'gBARIZCgVlcnJvchgCIAEoCUgBUgVlcnJvcogBAUILCglfZmlsZW5hbWVCCAoGX2Vycm9y');

const $core.Map<$core.String, $core.dynamic> MediaServiceBase$json = {
  '1': 'MediaService',
  '2': [
    {
      '1': 'CheckMedia',
      '2': '.anki.generic.Empty',
      '3': '.anki.media.CheckMediaResponse'
    },
    {
      '1': 'AddMediaFile',
      '2': '.anki.media.AddMediaFileRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'AddMediaFromPath',
      '2': '.anki.media.AddMediaFromPathRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'TrashMediaFiles',
      '2': '.anki.media.TrashMediaFilesRequest',
      '3': '.anki.generic.Empty'
    },
    {'1': 'EmptyTrash', '2': '.anki.generic.Empty', '3': '.anki.generic.Empty'},
    {
      '1': 'RestoreTrash',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'ExtractStaticMediaFiles',
      '2': '.anki.notetypes.NotetypeId',
      '3': '.anki.generic.StringList'
    },
    {
      '1': 'ExtractMediaFiles',
      '2': '.anki.generic.String',
      '3': '.anki.generic.StringList'
    },
    {
      '1': 'GetAbsoluteMediaPath',
      '2': '.anki.generic.String',
      '3': '.anki.generic.String'
    },
  ],
};

@$core.Deprecated('Use mediaServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    MediaServiceBase$messageJson = {
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.media.CheckMediaResponse': CheckMediaResponse$json,
  '.anki.media.AddMediaFileRequest': AddMediaFileRequest$json,
  '.anki.generic.String': $0.String$json,
  '.anki.media.AddMediaFromPathRequest': AddMediaFromPathRequest$json,
  '.anki.media.TrashMediaFilesRequest': TrashMediaFilesRequest$json,
  '.anki.notetypes.NotetypeId': $1.NotetypeId$json,
  '.anki.generic.StringList': $0.StringList$json,
};

/// Descriptor for `MediaService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List mediaServiceDescriptor = $convert.base64Decode(
    'CgxNZWRpYVNlcnZpY2USQQoKQ2hlY2tNZWRpYRITLmFua2kuZ2VuZXJpYy5FbXB0eRoeLmFua2'
    'kubWVkaWEuQ2hlY2tNZWRpYVJlc3BvbnNlEkUKDEFkZE1lZGlhRmlsZRIfLmFua2kubWVkaWEu'
    'QWRkTWVkaWFGaWxlUmVxdWVzdBoULmFua2kuZ2VuZXJpYy5TdHJpbmcSTQoQQWRkTWVkaWFGcm'
    '9tUGF0aBIjLmFua2kubWVkaWEuQWRkTWVkaWFGcm9tUGF0aFJlcXVlc3QaFC5hbmtpLmdlbmVy'
    'aWMuU3RyaW5nEkoKD1RyYXNoTWVkaWFGaWxlcxIiLmFua2kubWVkaWEuVHJhc2hNZWRpYUZpbG'
    'VzUmVxdWVzdBoTLmFua2kuZ2VuZXJpYy5FbXB0eRI2CgpFbXB0eVRyYXNoEhMuYW5raS5nZW5l'
    'cmljLkVtcHR5GhMuYW5raS5nZW5lcmljLkVtcHR5EjgKDFJlc3RvcmVUcmFzaBITLmFua2kuZ2'
    'VuZXJpYy5FbXB0eRoTLmFua2kuZ2VuZXJpYy5FbXB0eRJPChdFeHRyYWN0U3RhdGljTWVkaWFG'
    'aWxlcxIaLmFua2kubm90ZXR5cGVzLk5vdGV0eXBlSWQaGC5hbmtpLmdlbmVyaWMuU3RyaW5nTG'
    'lzdBJDChFFeHRyYWN0TWVkaWFGaWxlcxIULmFua2kuZ2VuZXJpYy5TdHJpbmcaGC5hbmtpLmdl'
    'bmVyaWMuU3RyaW5nTGlzdBJCChRHZXRBYnNvbHV0ZU1lZGlhUGF0aBIULmFua2kuZ2VuZXJpYy'
    '5TdHJpbmcaFC5hbmtpLmdlbmVyaWMuU3RyaW5n');

const $core.Map<$core.String, $core.dynamic> BackendMediaServiceBase$json = {
  '1': 'BackendMediaService',
  '2': [
    {
      '1': 'AddMediaFromUrl',
      '2': '.anki.media.AddMediaFromUrlRequest',
      '3': '.anki.media.AddMediaFromUrlResponse'
    },
  ],
};

@$core.Deprecated('Use backendMediaServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendMediaServiceBase$messageJson = {
  '.anki.media.AddMediaFromUrlRequest': AddMediaFromUrlRequest$json,
  '.anki.media.AddMediaFromUrlResponse': AddMediaFromUrlResponse$json,
};

/// Descriptor for `BackendMediaService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendMediaServiceDescriptor = $convert.base64Decode(
    'ChNCYWNrZW5kTWVkaWFTZXJ2aWNlEloKD0FkZE1lZGlhRnJvbVVybBIiLmFua2kubWVkaWEuQW'
    'RkTWVkaWFGcm9tVXJsUmVxdWVzdBojLmFua2kubWVkaWEuQWRkTWVkaWFGcm9tVXJsUmVzcG9u'
    'c2U=');
