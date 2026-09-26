// This is a generated file - do not edit.
//
// Generated from anki/i18n.proto.

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

@$core.Deprecated('Use translateStringRequestDescriptor instead')
const TranslateStringRequest$json = {
  '1': 'TranslateStringRequest',
  '2': [
    {'1': 'module_index', '3': 1, '4': 1, '5': 13, '10': 'moduleIndex'},
    {'1': 'message_index', '3': 2, '4': 1, '5': 13, '10': 'messageIndex'},
    {
      '1': 'args',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.anki.i18n.TranslateStringRequest.ArgsEntry',
      '10': 'args'
    },
  ],
  '3': [TranslateStringRequest_ArgsEntry$json],
};

@$core.Deprecated('Use translateStringRequestDescriptor instead')
const TranslateStringRequest_ArgsEntry$json = {
  '1': 'ArgsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.i18n.TranslateArgValue',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `TranslateStringRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List translateStringRequestDescriptor = $convert.base64Decode(
    'ChZUcmFuc2xhdGVTdHJpbmdSZXF1ZXN0EiEKDG1vZHVsZV9pbmRleBgBIAEoDVILbW9kdWxlSW'
    '5kZXgSIwoNbWVzc2FnZV9pbmRleBgCIAEoDVIMbWVzc2FnZUluZGV4Ej8KBGFyZ3MYAyADKAsy'
    'Ky5hbmtpLmkxOG4uVHJhbnNsYXRlU3RyaW5nUmVxdWVzdC5BcmdzRW50cnlSBGFyZ3MaVQoJQX'
    'Jnc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EjIKBXZhbHVlGAIgASgLMhwuYW5raS5pMThuLlRy'
    'YW5zbGF0ZUFyZ1ZhbHVlUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use translateArgValueDescriptor instead')
const TranslateArgValue$json = {
  '1': 'TranslateArgValue',
  '2': [
    {'1': 'str', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'str'},
    {'1': 'number', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'number'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `TranslateArgValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List translateArgValueDescriptor = $convert.base64Decode(
    'ChFUcmFuc2xhdGVBcmdWYWx1ZRISCgNzdHIYASABKAlIAFIDc3RyEhgKBm51bWJlchgCIAEoAU'
    'gAUgZudW1iZXJCBwoFdmFsdWU=');

@$core.Deprecated('Use formatTimespanRequestDescriptor instead')
const FormatTimespanRequest$json = {
  '1': 'FormatTimespanRequest',
  '2': [
    {'1': 'seconds', '3': 1, '4': 1, '5': 2, '10': 'seconds'},
    {
      '1': 'context',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.i18n.FormatTimespanRequest.Context',
      '10': 'context'
    },
  ],
  '4': [FormatTimespanRequest_Context$json],
};

@$core.Deprecated('Use formatTimespanRequestDescriptor instead')
const FormatTimespanRequest_Context$json = {
  '1': 'Context',
  '2': [
    {'1': 'PRECISE', '2': 0},
    {'1': 'ANSWER_BUTTONS', '2': 1},
    {'1': 'INTERVALS', '2': 2},
  ],
};

/// Descriptor for `FormatTimespanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List formatTimespanRequestDescriptor = $convert.base64Decode(
    'ChVGb3JtYXRUaW1lc3BhblJlcXVlc3QSGAoHc2Vjb25kcxgBIAEoAlIHc2Vjb25kcxJCCgdjb2'
    '50ZXh0GAIgASgOMiguYW5raS5pMThuLkZvcm1hdFRpbWVzcGFuUmVxdWVzdC5Db250ZXh0Ugdj'
    'b250ZXh0IjkKB0NvbnRleHQSCwoHUFJFQ0lTRRAAEhIKDkFOU1dFUl9CVVRUT05TEAESDQoJSU'
    '5URVJWQUxTEAI=');

@$core.Deprecated('Use i18nResourcesRequestDescriptor instead')
const I18nResourcesRequest$json = {
  '1': 'I18nResourcesRequest',
  '2': [
    {'1': 'modules', '3': 1, '4': 3, '5': 9, '10': 'modules'},
  ],
};

/// Descriptor for `I18nResourcesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List i18nResourcesRequestDescriptor =
    $convert.base64Decode(
        'ChRJMThuUmVzb3VyY2VzUmVxdWVzdBIYCgdtb2R1bGVzGAEgAygJUgdtb2R1bGVz');

const $core.Map<$core.String, $core.dynamic> I18nServiceBase$json = {
  '1': 'I18nService',
  '2': [
    {
      '1': 'TranslateString',
      '2': '.anki.i18n.TranslateStringRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'FormatTimespan',
      '2': '.anki.i18n.FormatTimespanRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'I18nResources',
      '2': '.anki.i18n.I18nResourcesRequest',
      '3': '.anki.generic.Json'
    },
  ],
};

@$core.Deprecated('Use i18nServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    I18nServiceBase$messageJson = {
  '.anki.i18n.TranslateStringRequest': TranslateStringRequest$json,
  '.anki.i18n.TranslateStringRequest.ArgsEntry':
      TranslateStringRequest_ArgsEntry$json,
  '.anki.i18n.TranslateArgValue': TranslateArgValue$json,
  '.anki.generic.String': $0.String$json,
  '.anki.i18n.FormatTimespanRequest': FormatTimespanRequest$json,
  '.anki.i18n.I18nResourcesRequest': I18nResourcesRequest$json,
  '.anki.generic.Json': $0.Json$json,
};

/// Descriptor for `I18nService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List i18nServiceDescriptor = $convert.base64Decode(
    'CgtJMThuU2VydmljZRJKCg9UcmFuc2xhdGVTdHJpbmcSIS5hbmtpLmkxOG4uVHJhbnNsYXRlU3'
    'RyaW5nUmVxdWVzdBoULmFua2kuZ2VuZXJpYy5TdHJpbmcSSAoORm9ybWF0VGltZXNwYW4SIC5h'
    'bmtpLmkxOG4uRm9ybWF0VGltZXNwYW5SZXF1ZXN0GhQuYW5raS5nZW5lcmljLlN0cmluZxJECg'
    '1JMThuUmVzb3VyY2VzEh8uYW5raS5pMThuLkkxOG5SZXNvdXJjZXNSZXF1ZXN0GhIuYW5raS5n'
    'ZW5lcmljLkpzb24=');

const $core.Map<$core.String, $core.dynamic> BackendI18nServiceBase$json = {
  '1': 'BackendI18nService',
  '2': [
    {
      '1': 'TranslateString',
      '2': '.anki.i18n.TranslateStringRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'FormatTimespan',
      '2': '.anki.i18n.FormatTimespanRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'I18nResources',
      '2': '.anki.i18n.I18nResourcesRequest',
      '3': '.anki.generic.Json'
    },
  ],
};

@$core.Deprecated('Use backendI18nServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendI18nServiceBase$messageJson = {
  '.anki.i18n.TranslateStringRequest': TranslateStringRequest$json,
  '.anki.i18n.TranslateStringRequest.ArgsEntry':
      TranslateStringRequest_ArgsEntry$json,
  '.anki.i18n.TranslateArgValue': TranslateArgValue$json,
  '.anki.generic.String': $0.String$json,
  '.anki.i18n.FormatTimespanRequest': FormatTimespanRequest$json,
  '.anki.i18n.I18nResourcesRequest': I18nResourcesRequest$json,
  '.anki.generic.Json': $0.Json$json,
};

/// Descriptor for `BackendI18nService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendI18nServiceDescriptor = $convert.base64Decode(
    'ChJCYWNrZW5kSTE4blNlcnZpY2USSgoPVHJhbnNsYXRlU3RyaW5nEiEuYW5raS5pMThuLlRyYW'
    '5zbGF0ZVN0cmluZ1JlcXVlc3QaFC5hbmtpLmdlbmVyaWMuU3RyaW5nEkgKDkZvcm1hdFRpbWVz'
    'cGFuEiAuYW5raS5pMThuLkZvcm1hdFRpbWVzcGFuUmVxdWVzdBoULmFua2kuZ2VuZXJpYy5TdH'
    'JpbmcSRAoNSTE4blJlc291cmNlcxIfLmFua2kuaTE4bi5JMThuUmVzb3VyY2VzUmVxdWVzdBoS'
    'LmFua2kuZ2VuZXJpYy5Kc29u');
