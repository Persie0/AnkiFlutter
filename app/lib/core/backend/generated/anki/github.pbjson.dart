// This is a generated file - do not edit.
//
// Generated from anki/github.proto.

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

@$core.Deprecated('Use latestReleaseRequestDescriptor instead')
const LatestReleaseRequest$json = {
  '1': 'LatestReleaseRequest',
  '2': [
    {
      '1': 'include_prerelease',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'includePrerelease'
    },
  ],
};

/// Descriptor for `LatestReleaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List latestReleaseRequestDescriptor = $convert.base64Decode(
    'ChRMYXRlc3RSZWxlYXNlUmVxdWVzdBItChJpbmNsdWRlX3ByZXJlbGVhc2UYASABKAhSEWluY2'
    'x1ZGVQcmVyZWxlYXNl');

@$core.Deprecated('Use githubReleaseDescriptor instead')
const GithubRelease$json = {
  '1': 'GithubRelease',
  '2': [
    {'1': 'tag_name', '3': 1, '4': 1, '5': 9, '10': 'tagName'},
    {'1': 'filename', '3': 2, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'checksum', '3': 4, '4': 1, '5': 9, '10': 'checksum'},
  ],
};

/// Descriptor for `GithubRelease`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List githubReleaseDescriptor = $convert.base64Decode(
    'Cg1HaXRodWJSZWxlYXNlEhkKCHRhZ19uYW1lGAEgASgJUgd0YWdOYW1lEhoKCGZpbGVuYW1lGA'
    'IgASgJUghmaWxlbmFtZRIQCgN1cmwYAyABKAlSA3VybBIaCghjaGVja3N1bRgEIAEoCVIIY2hl'
    'Y2tzdW0=');

const $core.Map<$core.String, $core.dynamic> GithubServiceBase$json = {
  '1': 'GithubService'
};

@$core.Deprecated('Use githubServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    GithubServiceBase$messageJson = {};

/// Descriptor for `GithubService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List githubServiceDescriptor =
    $convert.base64Decode('Cg1HaXRodWJTZXJ2aWNl');

const $core.Map<$core.String, $core.dynamic> BackendGithubServiceBase$json = {
  '1': 'BackendGithubService',
  '2': [
    {
      '1': 'GetLatestRelease',
      '2': '.anki.github.LatestReleaseRequest',
      '3': '.anki.github.GithubRelease'
    },
    {
      '1': 'DownloadRelease',
      '2': '.anki.github.GithubRelease',
      '3': '.anki.generic.String'
    },
  ],
};

@$core.Deprecated('Use backendGithubServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendGithubServiceBase$messageJson = {
  '.anki.github.LatestReleaseRequest': LatestReleaseRequest$json,
  '.anki.github.GithubRelease': GithubRelease$json,
  '.anki.generic.String': $0.String$json,
};

/// Descriptor for `BackendGithubService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendGithubServiceDescriptor = $convert.base64Decode(
    'ChRCYWNrZW5kR2l0aHViU2VydmljZRJRChBHZXRMYXRlc3RSZWxlYXNlEiEuYW5raS5naXRodW'
    'IuTGF0ZXN0UmVsZWFzZVJlcXVlc3QaGi5hbmtpLmdpdGh1Yi5HaXRodWJSZWxlYXNlEkMKD0Rv'
    'd25sb2FkUmVsZWFzZRIaLmFua2kuZ2l0aHViLkdpdGh1YlJlbGVhc2UaFC5hbmtpLmdlbmVyaW'
    'MuU3RyaW5n');
