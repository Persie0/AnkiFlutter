// This is a generated file - do not edit.
//
// Generated from anki/links.proto.

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

@$core.Deprecated('Use helpPageLinkRequestDescriptor instead')
const HelpPageLinkRequest$json = {
  '1': 'HelpPageLinkRequest',
  '2': [
    {
      '1': 'page',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.links.HelpPageLinkRequest.HelpPage',
      '10': 'page'
    },
  ],
  '4': [HelpPageLinkRequest_HelpPage$json],
};

@$core.Deprecated('Use helpPageLinkRequestDescriptor instead')
const HelpPageLinkRequest_HelpPage$json = {
  '1': 'HelpPage',
  '2': [
    {'1': 'NOTE_TYPE', '2': 0},
    {'1': 'BROWSING', '2': 1},
    {'1': 'BROWSING_FIND_AND_REPLACE', '2': 2},
    {'1': 'BROWSING_NOTES_MENU', '2': 3},
    {'1': 'KEYBOARD_SHORTCUTS', '2': 4},
    {'1': 'EDITING', '2': 5},
    {'1': 'ADDING_CARD_AND_NOTE', '2': 6},
    {'1': 'ADDING_A_NOTE_TYPE', '2': 7},
    {'1': 'LATEX', '2': 8},
    {'1': 'PREFERENCES', '2': 9},
    {'1': 'INDEX', '2': 10},
    {'1': 'TEMPLATES', '2': 11},
    {'1': 'FILTERED_DECK', '2': 12},
    {'1': 'IMPORTING', '2': 13},
    {'1': 'CUSTOMIZING_FIELDS', '2': 14},
    {'1': 'DECK_OPTIONS', '2': 15},
    {'1': 'EDITING_FEATURES', '2': 16},
    {'1': 'FULL_SCREEN_ISSUE', '2': 17},
    {'1': 'CARD_TYPE_DUPLICATE', '2': 18},
    {'1': 'CARD_TYPE_NO_FRONT_FIELD', '2': 19},
    {'1': 'CARD_TYPE_MISSING_CLOZE', '2': 20},
    {'1': 'TROUBLESHOOTING', '2': 21},
    {'1': 'CARD_TYPE_TEMPLATE_ERROR', '2': 22},
  ],
};

/// Descriptor for `HelpPageLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helpPageLinkRequestDescriptor = $convert.base64Decode(
    'ChNIZWxwUGFnZUxpbmtSZXF1ZXN0EjwKBHBhZ2UYASABKA4yKC5hbmtpLmxpbmtzLkhlbHBQYW'
    'dlTGlua1JlcXVlc3QuSGVscFBhZ2VSBHBhZ2Ui7AMKCEhlbHBQYWdlEg0KCU5PVEVfVFlQRRAA'
    'EgwKCEJST1dTSU5HEAESHQoZQlJPV1NJTkdfRklORF9BTkRfUkVQTEFDRRACEhcKE0JST1dTSU'
    '5HX05PVEVTX01FTlUQAxIWChJLRVlCT0FSRF9TSE9SVENVVFMQBBILCgdFRElUSU5HEAUSGAoU'
    'QURESU5HX0NBUkRfQU5EX05PVEUQBhIWChJBRERJTkdfQV9OT1RFX1RZUEUQBxIJCgVMQVRFWB'
    'AIEg8KC1BSRUZFUkVOQ0VTEAkSCQoFSU5ERVgQChINCglURU1QTEFURVMQCxIRCg1GSUxURVJF'
    'RF9ERUNLEAwSDQoJSU1QT1JUSU5HEA0SFgoSQ1VTVE9NSVpJTkdfRklFTERTEA4SEAoMREVDS1'
    '9PUFRJT05TEA8SFAoQRURJVElOR19GRUFUVVJFUxAQEhUKEUZVTExfU0NSRUVOX0lTU1VFEBES'
    'FwoTQ0FSRF9UWVBFX0RVUExJQ0FURRASEhwKGENBUkRfVFlQRV9OT19GUk9OVF9GSUVMRBATEh'
    'sKF0NBUkRfVFlQRV9NSVNTSU5HX0NMT1pFEBQSEwoPVFJPVUJMRVNIT09USU5HEBUSHAoYQ0FS'
    'RF9UWVBFX1RFTVBMQVRFX0VSUk9SEBY=');

const $core.Map<$core.String, $core.dynamic> LinksServiceBase$json = {
  '1': 'LinksService',
  '2': [
    {
      '1': 'HelpPageLink',
      '2': '.anki.links.HelpPageLinkRequest',
      '3': '.anki.generic.String'
    },
  ],
};

@$core.Deprecated('Use linksServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    LinksServiceBase$messageJson = {
  '.anki.links.HelpPageLinkRequest': HelpPageLinkRequest$json,
  '.anki.generic.String': $0.String$json,
};

/// Descriptor for `LinksService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List linksServiceDescriptor = $convert.base64Decode(
    'CgxMaW5rc1NlcnZpY2USRQoMSGVscFBhZ2VMaW5rEh8uYW5raS5saW5rcy5IZWxwUGFnZUxpbm'
    'tSZXF1ZXN0GhQuYW5raS5nZW5lcmljLlN0cmluZw==');

const $core.Map<$core.String, $core.dynamic> BackendLinksServiceBase$json = {
  '1': 'BackendLinksService'
};

@$core.Deprecated('Use backendLinksServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendLinksServiceBase$messageJson = {};

/// Descriptor for `BackendLinksService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendLinksServiceDescriptor =
    $convert.base64Decode('ChNCYWNrZW5kTGlua3NTZXJ2aWNl');
