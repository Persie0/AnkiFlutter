// This is a generated file - do not edit.
//
// Generated from anki/ankihub.proto.

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

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert
    .base64Decode('Cg1Mb2dpblJlc3BvbnNlEhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhoKCHBhc3N3b3JkGAIgASgJUghwYXNzd2'
    '9yZA==');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert
    .base64Decode('Cg1Mb2dvdXRSZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

const $core.Map<$core.String, $core.dynamic> AnkiHubServiceBase$json = {
  '1': 'AnkiHubService'
};

@$core.Deprecated('Use ankiHubServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    AnkiHubServiceBase$messageJson = {};

/// Descriptor for `AnkiHubService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List ankiHubServiceDescriptor =
    $convert.base64Decode('Cg5BbmtpSHViU2VydmljZQ==');

const $core.Map<$core.String, $core.dynamic> BackendAnkiHubServiceBase$json = {
  '1': 'BackendAnkiHubService',
  '2': [
    {
      '1': 'AnkihubLogin',
      '2': '.anki.ankihub.LoginRequest',
      '3': '.anki.ankihub.LoginResponse'
    },
    {
      '1': 'AnkihubLogout',
      '2': '.anki.ankihub.LogoutRequest',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use backendAnkiHubServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendAnkiHubServiceBase$messageJson = {
  '.anki.ankihub.LoginRequest': LoginRequest$json,
  '.anki.ankihub.LoginResponse': LoginResponse$json,
  '.anki.ankihub.LogoutRequest': LogoutRequest$json,
  '.anki.generic.Empty': $0.Empty$json,
};

/// Descriptor for `BackendAnkiHubService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendAnkiHubServiceDescriptor = $convert.base64Decode(
    'ChVCYWNrZW5kQW5raUh1YlNlcnZpY2USRwoMQW5raWh1YkxvZ2luEhouYW5raS5hbmtpaHViLk'
    'xvZ2luUmVxdWVzdBobLmFua2kuYW5raWh1Yi5Mb2dpblJlc3BvbnNlEkEKDUFua2lodWJMb2dv'
    'dXQSGy5hbmtpLmFua2lodWIuTG9nb3V0UmVxdWVzdBoTLmFua2kuZ2VuZXJpYy5FbXB0eQ==');
