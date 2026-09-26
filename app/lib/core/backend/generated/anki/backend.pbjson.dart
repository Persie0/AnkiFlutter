// This is a generated file - do not edit.
//
// Generated from anki/backend.proto.

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

@$core.Deprecated('Use backendInitDescriptor instead')
const BackendInit$json = {
  '1': 'BackendInit',
  '2': [
    {'1': 'preferred_langs', '3': 1, '4': 3, '5': 9, '10': 'preferredLangs'},
    {
      '1': 'locale_folder_path',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'localeFolderPath'
    },
    {'1': 'server', '3': 3, '4': 1, '5': 8, '10': 'server'},
  ],
};

/// Descriptor for `BackendInit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List backendInitDescriptor = $convert.base64Decode(
    'CgtCYWNrZW5kSW5pdBInCg9wcmVmZXJyZWRfbGFuZ3MYASADKAlSDnByZWZlcnJlZExhbmdzEi'
    'wKEmxvY2FsZV9mb2xkZXJfcGF0aBgCIAEoCVIQbG9jYWxlRm9sZGVyUGF0aBIWCgZzZXJ2ZXIY'
    'AyABKAhSBnNlcnZlcg==');

@$core.Deprecated('Use i18nBackendInitDescriptor instead')
const I18nBackendInit$json = {
  '1': 'I18nBackendInit',
  '2': [
    {'1': 'preferred_langs', '3': 4, '4': 3, '5': 9, '10': 'preferredLangs'},
    {
      '1': 'locale_folder_path',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'localeFolderPath'
    },
  ],
};

/// Descriptor for `I18nBackendInit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List i18nBackendInitDescriptor = $convert.base64Decode(
    'Cg9JMThuQmFja2VuZEluaXQSJwoPcHJlZmVycmVkX2xhbmdzGAQgAygJUg5wcmVmZXJyZWRMYW'
    '5ncxIsChJsb2NhbGVfZm9sZGVyX3BhdGgYBSABKAlSEGxvY2FsZUZvbGRlclBhdGg=');

@$core.Deprecated('Use backendErrorDescriptor instead')
const BackendError$json = {
  '1': 'BackendError',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.backend.BackendError.Kind',
      '10': 'kind'
    },
    {
      '1': 'help_page',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.anki.links.HelpPageLinkRequest.HelpPage',
      '9': 0,
      '10': 'helpPage',
      '17': true
    },
    {'1': 'context', '3': 4, '4': 1, '5': 9, '10': 'context'},
    {'1': 'backtrace', '3': 5, '4': 1, '5': 9, '10': 'backtrace'},
  ],
  '4': [BackendError_Kind$json],
  '8': [
    {'1': '_help_page'},
  ],
};

@$core.Deprecated('Use backendErrorDescriptor instead')
const BackendError_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'INVALID_INPUT', '2': 0},
    {'1': 'UNDO_EMPTY', '2': 1},
    {'1': 'INTERRUPTED', '2': 2},
    {'1': 'TEMPLATE_PARSE', '2': 3},
    {'1': 'IO_ERROR', '2': 4},
    {'1': 'DB_ERROR', '2': 5},
    {'1': 'NETWORK_ERROR', '2': 6},
    {'1': 'SYNC_AUTH_ERROR', '2': 7},
    {'1': 'SYNC_SERVER_MESSAGE', '2': 23},
    {'1': 'SYNC_OTHER_ERROR', '2': 8},
    {'1': 'JSON_ERROR', '2': 9},
    {'1': 'PROTO_ERROR', '2': 10},
    {'1': 'NOT_FOUND_ERROR', '2': 11},
    {'1': 'EXISTS', '2': 12},
    {'1': 'FILTERED_DECK_ERROR', '2': 13},
    {'1': 'SEARCH_ERROR', '2': 14},
    {'1': 'CUSTOM_STUDY_ERROR', '2': 15},
    {'1': 'IMPORT_ERROR', '2': 16},
    {'1': 'DELETED', '2': 17},
    {'1': 'CARD_TYPE_ERROR', '2': 18},
    {'1': 'ANKIDROID_PANIC_ERROR', '2': 19},
    {'1': 'OS_ERROR', '2': 20},
    {'1': 'SCHEDULER_UPGRADE_REQUIRED', '2': 21},
    {'1': 'INVALID_CERTIFICATE_FORMAT', '2': 22},
    {'1': 'INVALID_CHECKSUM', '2': 24},
  ],
};

/// Descriptor for `BackendError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List backendErrorDescriptor = $convert.base64Decode(
    'CgxCYWNrZW5kRXJyb3ISGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRIzCgRraW5kGAIgASgOMh'
    '8uYW5raS5iYWNrZW5kLkJhY2tlbmRFcnJvci5LaW5kUgRraW5kEkoKCWhlbHBfcGFnZRgDIAEo'
    'DjIoLmFua2kubGlua3MuSGVscFBhZ2VMaW5rUmVxdWVzdC5IZWxwUGFnZUgAUghoZWxwUGFnZY'
    'gBARIYCgdjb250ZXh0GAQgASgJUgdjb250ZXh0EhwKCWJhY2t0cmFjZRgFIAEoCVIJYmFja3Ry'
    'YWNlIvkDCgRLaW5kEhEKDUlOVkFMSURfSU5QVVQQABIOCgpVTkRPX0VNUFRZEAESDwoLSU5URV'
    'JSVVBURUQQAhISCg5URU1QTEFURV9QQVJTRRADEgwKCElPX0VSUk9SEAQSDAoIREJfRVJST1IQ'
    'BRIRCg1ORVRXT1JLX0VSUk9SEAYSEwoPU1lOQ19BVVRIX0VSUk9SEAcSFwoTU1lOQ19TRVJWRV'
    'JfTUVTU0FHRRAXEhQKEFNZTkNfT1RIRVJfRVJST1IQCBIOCgpKU09OX0VSUk9SEAkSDwoLUFJP'
    'VE9fRVJST1IQChITCg9OT1RfRk9VTkRfRVJST1IQCxIKCgZFWElTVFMQDBIXChNGSUxURVJFRF'
    '9ERUNLX0VSUk9SEA0SEAoMU0VBUkNIX0VSUk9SEA4SFgoSQ1VTVE9NX1NUVURZX0VSUk9SEA8S'
    'EAoMSU1QT1JUX0VSUk9SEBASCwoHREVMRVRFRBAREhMKD0NBUkRfVFlQRV9FUlJPUhASEhkKFU'
    'FOS0lEUk9JRF9QQU5JQ19FUlJPUhATEgwKCE9TX0VSUk9SEBQSHgoaU0NIRURVTEVSX1VQR1JB'
    'REVfUkVRVUlSRUQQFRIeChpJTlZBTElEX0NFUlRJRklDQVRFX0ZPUk1BVBAWEhQKEElOVkFMSU'
    'RfQ0hFQ0tTVU0QGEIMCgpfaGVscF9wYWdl');
