// This is a generated file - do not edit.
//
// Generated from anki/ankidroid.proto.

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
import 'scheduler.pbjson.dart' as $1;

@$core.Deprecated(
    'Use debugActiveDatabaseSequenceNumbersResponseDescriptor instead')
const DebugActiveDatabaseSequenceNumbersResponse$json = {
  '1': 'DebugActiveDatabaseSequenceNumbersResponse',
  '2': [
    {'1': 'sequence_numbers', '3': 1, '4': 3, '5': 5, '10': 'sequenceNumbers'},
  ],
};

/// Descriptor for `DebugActiveDatabaseSequenceNumbersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    debugActiveDatabaseSequenceNumbersResponseDescriptor =
    $convert.base64Decode(
        'CipEZWJ1Z0FjdGl2ZURhdGFiYXNlU2VxdWVuY2VOdW1iZXJzUmVzcG9uc2USKQoQc2VxdWVuY2'
        'VfbnVtYmVycxgBIAMoBVIPc2VxdWVuY2VOdW1iZXJz');

@$core.Deprecated('Use schedTimingTodayLegacyRequestDescriptor instead')
const SchedTimingTodayLegacyRequest$json = {
  '1': 'SchedTimingTodayLegacyRequest',
  '2': [
    {'1': 'created_secs', '3': 1, '4': 1, '5': 3, '10': 'createdSecs'},
    {
      '1': 'created_mins_west',
      '3': 2,
      '4': 1,
      '5': 17,
      '9': 0,
      '10': 'createdMinsWest',
      '17': true
    },
    {'1': 'now_secs', '3': 3, '4': 1, '5': 3, '10': 'nowSecs'},
    {'1': 'now_mins_west', '3': 4, '4': 1, '5': 17, '10': 'nowMinsWest'},
    {'1': 'rollover_hour', '3': 5, '4': 1, '5': 17, '10': 'rolloverHour'},
  ],
  '8': [
    {'1': '_created_mins_west'},
  ],
};

/// Descriptor for `SchedTimingTodayLegacyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List schedTimingTodayLegacyRequestDescriptor = $convert.base64Decode(
    'Ch1TY2hlZFRpbWluZ1RvZGF5TGVnYWN5UmVxdWVzdBIhCgxjcmVhdGVkX3NlY3MYASABKANSC2'
    'NyZWF0ZWRTZWNzEi8KEWNyZWF0ZWRfbWluc193ZXN0GAIgASgRSABSD2NyZWF0ZWRNaW5zV2Vz'
    'dIgBARIZCghub3dfc2VjcxgDIAEoA1IHbm93U2VjcxIiCg1ub3dfbWluc193ZXN0GAQgASgRUg'
    'tub3dNaW5zV2VzdBIjCg1yb2xsb3Zlcl9ob3VyGAUgASgRUgxyb2xsb3ZlckhvdXJCFAoSX2Ny'
    'ZWF0ZWRfbWluc193ZXN0');

@$core.Deprecated('Use sqlValueDescriptor instead')
const SqlValue$json = {
  '1': 'SqlValue',
  '2': [
    {'1': 'stringValue', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'longValue', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'longValue'},
    {'1': 'doubleValue', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {'1': 'blobValue', '3': 4, '4': 1, '5': 12, '9': 0, '10': 'blobValue'},
  ],
  '8': [
    {'1': 'Data'},
  ],
};

/// Descriptor for `SqlValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sqlValueDescriptor = $convert.base64Decode(
    'CghTcWxWYWx1ZRIiCgtzdHJpbmdWYWx1ZRgBIAEoCUgAUgtzdHJpbmdWYWx1ZRIeCglsb25nVm'
    'FsdWUYAiABKANIAFIJbG9uZ1ZhbHVlEiIKC2RvdWJsZVZhbHVlGAMgASgBSABSC2RvdWJsZVZh'
    'bHVlEh4KCWJsb2JWYWx1ZRgEIAEoDEgAUglibG9iVmFsdWVCBgoERGF0YQ==');

@$core.Deprecated('Use rowDescriptor instead')
const Row$json = {
  '1': 'Row',
  '2': [
    {
      '1': 'fields',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.ankidroid.SqlValue',
      '10': 'fields'
    },
  ],
};

/// Descriptor for `Row`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rowDescriptor = $convert.base64Decode(
    'CgNSb3cSMAoGZmllbGRzGAEgAygLMhguYW5raS5hbmtpZHJvaWQuU3FsVmFsdWVSBmZpZWxkcw'
    '==');

@$core.Deprecated('Use dbResultDescriptor instead')
const DbResult$json = {
  '1': 'DbResult',
  '2': [
    {
      '1': 'rows',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.ankidroid.Row',
      '10': 'rows'
    },
  ],
};

/// Descriptor for `DbResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dbResultDescriptor = $convert.base64Decode(
    'CghEYlJlc3VsdBInCgRyb3dzGAEgAygLMhMuYW5raS5hbmtpZHJvaWQuUm93UgRyb3dz');

@$core.Deprecated('Use dbResponseDescriptor instead')
const DbResponse$json = {
  '1': 'DbResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.ankidroid.DbResult',
      '10': 'result'
    },
    {'1': 'sequenceNumber', '3': 2, '4': 1, '5': 5, '10': 'sequenceNumber'},
    {'1': 'rowCount', '3': 3, '4': 1, '5': 5, '10': 'rowCount'},
    {'1': 'startIndex', '3': 4, '4': 1, '5': 3, '10': 'startIndex'},
  ],
};

/// Descriptor for `DbResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dbResponseDescriptor = $convert.base64Decode(
    'CgpEYlJlc3BvbnNlEjAKBnJlc3VsdBgBIAEoCzIYLmFua2kuYW5raWRyb2lkLkRiUmVzdWx0Ug'
    'ZyZXN1bHQSJgoOc2VxdWVuY2VOdW1iZXIYAiABKAVSDnNlcXVlbmNlTnVtYmVyEhoKCHJvd0Nv'
    'dW50GAMgASgFUghyb3dDb3VudBIeCgpzdGFydEluZGV4GAQgASgDUgpzdGFydEluZGV4');

@$core.Deprecated('Use getNextResultPageRequestDescriptor instead')
const GetNextResultPageRequest$json = {
  '1': 'GetNextResultPageRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 5, '10': 'sequence'},
    {'1': 'index', '3': 2, '4': 1, '5': 3, '10': 'index'},
  ],
};

/// Descriptor for `GetNextResultPageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNextResultPageRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXROZXh0UmVzdWx0UGFnZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKAVSCHNlcXVlbmNlEh'
        'QKBWluZGV4GAIgASgDUgVpbmRleA==');

@$core.Deprecated('Use getActiveSequenceNumbersResponseDescriptor instead')
const GetActiveSequenceNumbersResponse$json = {
  '1': 'GetActiveSequenceNumbersResponse',
  '2': [
    {'1': 'numbers', '3': 1, '4': 3, '5': 5, '10': 'numbers'},
  ],
};

/// Descriptor for `GetActiveSequenceNumbersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveSequenceNumbersResponseDescriptor =
    $convert.base64Decode(
        'CiBHZXRBY3RpdmVTZXF1ZW5jZU51bWJlcnNSZXNwb25zZRIYCgdudW1iZXJzGAEgAygFUgdudW'
        '1iZXJz');

const $core.Map<$core.String, $core.dynamic> AnkidroidServiceBase$json = {
  '1': 'AnkidroidService',
  '2': [
    {'1': 'RunDbCommand', '2': '.anki.generic.Json', '3': '.anki.generic.Json'},
    {
      '1': 'RunDbCommandProto',
      '2': '.anki.generic.Json',
      '3': '.anki.ankidroid.DbResponse'
    },
    {'1': 'InsertForId', '2': '.anki.generic.Json', '3': '.anki.generic.Int64'},
    {
      '1': 'RunDbCommandForRowCount',
      '2': '.anki.generic.Json',
      '3': '.anki.generic.Int64'
    },
    {
      '1': 'FlushAllQueries',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {'1': 'FlushQuery', '2': '.anki.generic.Int32', '3': '.anki.generic.Empty'},
    {
      '1': 'GetNextResultPage',
      '2': '.anki.ankidroid.GetNextResultPageRequest',
      '3': '.anki.ankidroid.DbResponse'
    },
    {
      '1': 'GetColumnNamesFromQuery',
      '2': '.anki.generic.String',
      '3': '.anki.generic.StringList'
    },
    {
      '1': 'GetActiveSequenceNumbers',
      '2': '.anki.generic.Empty',
      '3': '.anki.ankidroid.GetActiveSequenceNumbersResponse'
    },
  ],
};

@$core.Deprecated('Use ankidroidServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    AnkidroidServiceBase$messageJson = {
  '.anki.generic.Json': $0.Json$json,
  '.anki.ankidroid.DbResponse': DbResponse$json,
  '.anki.ankidroid.DbResult': DbResult$json,
  '.anki.ankidroid.Row': Row$json,
  '.anki.ankidroid.SqlValue': SqlValue$json,
  '.anki.generic.Int64': $0.Int64$json,
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.generic.Int32': $0.Int32$json,
  '.anki.ankidroid.GetNextResultPageRequest': GetNextResultPageRequest$json,
  '.anki.generic.String': $0.String$json,
  '.anki.generic.StringList': $0.StringList$json,
  '.anki.ankidroid.GetActiveSequenceNumbersResponse':
      GetActiveSequenceNumbersResponse$json,
};

/// Descriptor for `AnkidroidService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List ankidroidServiceDescriptor = $convert.base64Decode(
    'ChBBbmtpZHJvaWRTZXJ2aWNlEjYKDFJ1bkRiQ29tbWFuZBISLmFua2kuZ2VuZXJpYy5Kc29uGh'
    'IuYW5raS5nZW5lcmljLkpzb24SQwoRUnVuRGJDb21tYW5kUHJvdG8SEi5hbmtpLmdlbmVyaWMu'
    'SnNvbhoaLmFua2kuYW5raWRyb2lkLkRiUmVzcG9uc2USNgoLSW5zZXJ0Rm9ySWQSEi5hbmtpLm'
    'dlbmVyaWMuSnNvbhoTLmFua2kuZ2VuZXJpYy5JbnQ2NBJCChdSdW5EYkNvbW1hbmRGb3JSb3dD'
    'b3VudBISLmFua2kuZ2VuZXJpYy5Kc29uGhMuYW5raS5nZW5lcmljLkludDY0EjsKD0ZsdXNoQW'
    'xsUXVlcmllcxITLmFua2kuZ2VuZXJpYy5FbXB0eRoTLmFua2kuZ2VuZXJpYy5FbXB0eRI2CgpG'
    'bHVzaFF1ZXJ5EhMuYW5raS5nZW5lcmljLkludDMyGhMuYW5raS5nZW5lcmljLkVtcHR5ElkKEU'
    'dldE5leHRSZXN1bHRQYWdlEiguYW5raS5hbmtpZHJvaWQuR2V0TmV4dFJlc3VsdFBhZ2VSZXF1'
    'ZXN0GhouYW5raS5hbmtpZHJvaWQuRGJSZXNwb25zZRJJChdHZXRDb2x1bW5OYW1lc0Zyb21RdW'
    'VyeRIULmFua2kuZ2VuZXJpYy5TdHJpbmcaGC5hbmtpLmdlbmVyaWMuU3RyaW5nTGlzdBJhChhH'
    'ZXRBY3RpdmVTZXF1ZW5jZU51bWJlcnMSEy5hbmtpLmdlbmVyaWMuRW1wdHkaMC5hbmtpLmFua2'
    'lkcm9pZC5HZXRBY3RpdmVTZXF1ZW5jZU51bWJlcnNSZXNwb25zZQ==');

const $core.Map<$core.String, $core.dynamic> BackendAnkidroidServiceBase$json =
    {
  '1': 'BackendAnkidroidService',
  '2': [
    {
      '1': 'SchedTimingTodayLegacy',
      '2': '.anki.ankidroid.SchedTimingTodayLegacyRequest',
      '3': '.anki.scheduler.SchedTimingTodayResponse'
    },
    {
      '1': 'LocalMinutesWestLegacy',
      '2': '.anki.generic.Int64',
      '3': '.anki.generic.Int32'
    },
    {
      '1': 'SetPageSize',
      '2': '.anki.generic.Int64',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'DebugProduceError',
      '2': '.anki.generic.String',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use backendAnkidroidServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendAnkidroidServiceBase$messageJson = {
  '.anki.ankidroid.SchedTimingTodayLegacyRequest':
      SchedTimingTodayLegacyRequest$json,
  '.anki.scheduler.SchedTimingTodayResponse': $1.SchedTimingTodayResponse$json,
  '.anki.generic.Int64': $0.Int64$json,
  '.anki.generic.Int32': $0.Int32$json,
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.generic.String': $0.String$json,
};

/// Descriptor for `BackendAnkidroidService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendAnkidroidServiceDescriptor = $convert.base64Decode(
    'ChdCYWNrZW5kQW5raWRyb2lkU2VydmljZRJxChZTY2hlZFRpbWluZ1RvZGF5TGVnYWN5Ei0uYW'
    '5raS5hbmtpZHJvaWQuU2NoZWRUaW1pbmdUb2RheUxlZ2FjeVJlcXVlc3QaKC5hbmtpLnNjaGVk'
    'dWxlci5TY2hlZFRpbWluZ1RvZGF5UmVzcG9uc2USQgoWTG9jYWxNaW51dGVzV2VzdExlZ2FjeR'
    'ITLmFua2kuZ2VuZXJpYy5JbnQ2NBoTLmFua2kuZ2VuZXJpYy5JbnQzMhI3CgtTZXRQYWdlU2l6'
    'ZRITLmFua2kuZ2VuZXJpYy5JbnQ2NBoTLmFua2kuZ2VuZXJpYy5FbXB0eRI+ChFEZWJ1Z1Byb2'
    'R1Y2VFcnJvchIULmFua2kuZ2VuZXJpYy5TdHJpbmcaEy5hbmtpLmdlbmVyaWMuRW1wdHk=');
