// This is a generated file - do not edit.
//
// Generated from anki/ankiweb.proto.

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

@$core.Deprecated('Use getAddonInfoRequestDescriptor instead')
const GetAddonInfoRequest$json = {
  '1': 'GetAddonInfoRequest',
  '2': [
    {'1': 'client_version', '3': 1, '4': 1, '5': 13, '10': 'clientVersion'},
    {'1': 'addon_ids', '3': 2, '4': 3, '5': 13, '10': 'addonIds'},
  ],
};

/// Descriptor for `GetAddonInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAddonInfoRequestDescriptor = $convert.base64Decode(
    'ChNHZXRBZGRvbkluZm9SZXF1ZXN0EiUKDmNsaWVudF92ZXJzaW9uGAEgASgNUg1jbGllbnRWZX'
    'JzaW9uEhsKCWFkZG9uX2lkcxgCIAMoDVIIYWRkb25JZHM=');

@$core.Deprecated('Use getAddonInfoResponseDescriptor instead')
const GetAddonInfoResponse$json = {
  '1': 'GetAddonInfoResponse',
  '2': [
    {
      '1': 'info',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.ankiweb.AddonInfo',
      '10': 'info'
    },
  ],
};

/// Descriptor for `GetAddonInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAddonInfoResponseDescriptor = $convert.base64Decode(
    'ChRHZXRBZGRvbkluZm9SZXNwb25zZRIrCgRpbmZvGAEgAygLMhcuYW5raS5hbmtpd2ViLkFkZG'
    '9uSW5mb1IEaW5mbw==');

@$core.Deprecated('Use addonInfoDescriptor instead')
const AddonInfo$json = {
  '1': 'AddonInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'modified', '3': 2, '4': 1, '5': 3, '10': 'modified'},
    {'1': 'min_version', '3': 3, '4': 1, '5': 13, '10': 'minVersion'},
    {'1': 'max_version', '3': 4, '4': 1, '5': 13, '10': 'maxVersion'},
  ],
};

/// Descriptor for `AddonInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addonInfoDescriptor = $convert.base64Decode(
    'CglBZGRvbkluZm8SDgoCaWQYASABKA1SAmlkEhoKCG1vZGlmaWVkGAIgASgDUghtb2RpZmllZB'
    'IfCgttaW5fdmVyc2lvbhgDIAEoDVIKbWluVmVyc2lvbhIfCgttYXhfdmVyc2lvbhgEIAEoDVIK'
    'bWF4VmVyc2lvbg==');

@$core.Deprecated('Use checkForUpdateRequestDescriptor instead')
const CheckForUpdateRequest$json = {
  '1': 'CheckForUpdateRequest',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 13, '10': 'version'},
    {'1': 'buildhash', '3': 2, '4': 1, '5': 9, '10': 'buildhash'},
    {'1': 'os', '3': 3, '4': 1, '5': 9, '10': 'os'},
    {'1': 'install_id', '3': 4, '4': 1, '5': 3, '10': 'installId'},
    {'1': 'last_message_id', '3': 5, '4': 1, '5': 13, '10': 'lastMessageId'},
  ],
};

/// Descriptor for `CheckForUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkForUpdateRequestDescriptor = $convert.base64Decode(
    'ChVDaGVja0ZvclVwZGF0ZVJlcXVlc3QSGAoHdmVyc2lvbhgBIAEoDVIHdmVyc2lvbhIcCglidW'
    'lsZGhhc2gYAiABKAlSCWJ1aWxkaGFzaBIOCgJvcxgDIAEoCVICb3MSHQoKaW5zdGFsbF9pZBgE'
    'IAEoA1IJaW5zdGFsbElkEiYKD2xhc3RfbWVzc2FnZV9pZBgFIAEoDVINbGFzdE1lc3NhZ2VJZA'
    '==');

@$core.Deprecated('Use checkForUpdateResponseDescriptor instead')
const CheckForUpdateResponse$json = {
  '1': 'CheckForUpdateResponse',
  '2': [
    {
      '1': 'new_version',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'newVersion',
      '17': true
    },
    {'1': 'current_time', '3': 2, '4': 1, '5': 3, '10': 'currentTime'},
    {
      '1': 'message',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'message',
      '17': true
    },
    {'1': 'last_message_id', '3': 4, '4': 1, '5': 13, '10': 'lastMessageId'},
  ],
  '8': [
    {'1': '_new_version'},
    {'1': '_message'},
  ],
};

/// Descriptor for `CheckForUpdateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkForUpdateResponseDescriptor = $convert.base64Decode(
    'ChZDaGVja0ZvclVwZGF0ZVJlc3BvbnNlEiQKC25ld192ZXJzaW9uGAEgASgJSABSCm5ld1Zlcn'
    'Npb26IAQESIQoMY3VycmVudF90aW1lGAIgASgDUgtjdXJyZW50VGltZRIdCgdtZXNzYWdlGAMg'
    'ASgJSAFSB21lc3NhZ2WIAQESJgoPbGFzdF9tZXNzYWdlX2lkGAQgASgNUg1sYXN0TWVzc2FnZU'
    'lkQg4KDF9uZXdfdmVyc2lvbkIKCghfbWVzc2FnZQ==');

const $core.Map<$core.String, $core.dynamic> AnkiwebServiceBase$json = {
  '1': 'AnkiwebService'
};

@$core.Deprecated('Use ankiwebServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    AnkiwebServiceBase$messageJson = {};

/// Descriptor for `AnkiwebService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List ankiwebServiceDescriptor =
    $convert.base64Decode('Cg5Bbmtpd2ViU2VydmljZQ==');

const $core.Map<$core.String, $core.dynamic> BackendAnkiwebServiceBase$json = {
  '1': 'BackendAnkiwebService',
  '2': [
    {
      '1': 'GetAddonInfo',
      '2': '.anki.ankiweb.GetAddonInfoRequest',
      '3': '.anki.ankiweb.GetAddonInfoResponse'
    },
    {
      '1': 'CheckForUpdate',
      '2': '.anki.ankiweb.CheckForUpdateRequest',
      '3': '.anki.ankiweb.CheckForUpdateResponse'
    },
  ],
};

@$core.Deprecated('Use backendAnkiwebServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendAnkiwebServiceBase$messageJson = {
  '.anki.ankiweb.GetAddonInfoRequest': GetAddonInfoRequest$json,
  '.anki.ankiweb.GetAddonInfoResponse': GetAddonInfoResponse$json,
  '.anki.ankiweb.AddonInfo': AddonInfo$json,
  '.anki.ankiweb.CheckForUpdateRequest': CheckForUpdateRequest$json,
  '.anki.ankiweb.CheckForUpdateResponse': CheckForUpdateResponse$json,
};

/// Descriptor for `BackendAnkiwebService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendAnkiwebServiceDescriptor = $convert.base64Decode(
    'ChVCYWNrZW5kQW5raXdlYlNlcnZpY2USVQoMR2V0QWRkb25JbmZvEiEuYW5raS5hbmtpd2ViLk'
    'dldEFkZG9uSW5mb1JlcXVlc3QaIi5hbmtpLmFua2l3ZWIuR2V0QWRkb25JbmZvUmVzcG9uc2US'
    'WwoOQ2hlY2tGb3JVcGRhdGUSIy5hbmtpLmFua2l3ZWIuQ2hlY2tGb3JVcGRhdGVSZXF1ZXN0Gi'
    'QuYW5raS5hbmtpd2ViLkNoZWNrRm9yVXBkYXRlUmVzcG9uc2U=');
