// This is a generated file - do not edit.
//
// Generated from anki/frontend.proto.

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

import 'cards.pbjson.dart' as $4;
import 'generic.pbjson.dart' as $1;
import 'scheduler.pbjson.dart' as $0;
import 'search.pbjson.dart' as $2;

@$core.Deprecated('Use messageBoxTypeDescriptor instead')
const MessageBoxType$json = {
  '1': 'MessageBoxType',
  '2': [
    {'1': 'INFO', '2': 0},
    {'1': 'WARNING', '2': 1},
    {'1': 'CRITICAL', '2': 2},
  ],
};

/// Descriptor for `MessageBoxType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageBoxTypeDescriptor = $convert.base64Decode(
    'Cg5NZXNzYWdlQm94VHlwZRIICgRJTkZPEAASCwoHV0FSTklORxABEgwKCENSSVRJQ0FMEAI=');

@$core.Deprecated('Use schedulingStatesWithContextDescriptor instead')
const SchedulingStatesWithContext$json = {
  '1': 'SchedulingStatesWithContext',
  '2': [
    {
      '1': 'states',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingStates',
      '10': 'states'
    },
    {
      '1': 'context',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingContext',
      '10': 'context'
    },
  ],
};

/// Descriptor for `SchedulingStatesWithContext`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List schedulingStatesWithContextDescriptor =
    $convert.base64Decode(
        'ChtTY2hlZHVsaW5nU3RhdGVzV2l0aENvbnRleHQSOAoGc3RhdGVzGAEgASgLMiAuYW5raS5zY2'
        'hlZHVsZXIuU2NoZWR1bGluZ1N0YXRlc1IGc3RhdGVzEjsKB2NvbnRleHQYAiABKAsyIS5hbmtp'
        'LnNjaGVkdWxlci5TY2hlZHVsaW5nQ29udGV4dFIHY29udGV4dA==');

@$core.Deprecated('Use setSchedulingStatesRequestDescriptor instead')
const SetSchedulingStatesRequest$json = {
  '1': 'SetSchedulingStatesRequest',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'states',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.scheduler.SchedulingStates',
      '10': 'states'
    },
  ],
};

/// Descriptor for `SetSchedulingStatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setSchedulingStatesRequestDescriptor =
    $convert.base64Decode(
        'ChpTZXRTY2hlZHVsaW5nU3RhdGVzUmVxdWVzdBIQCgNrZXkYASABKAlSA2tleRI4CgZzdGF0ZX'
        'MYAiABKAsyIC5hbmtpLnNjaGVkdWxlci5TY2hlZHVsaW5nU3RhdGVzUgZzdGF0ZXM=');

@$core.Deprecated('Use convertPastedImageRequestDescriptor instead')
const ConvertPastedImageRequest$json = {
  '1': 'ConvertPastedImageRequest',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'ext', '3': 2, '4': 1, '5': 9, '10': 'ext'},
  ],
};

/// Descriptor for `ConvertPastedImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertPastedImageRequestDescriptor =
    $convert.base64Decode(
        'ChlDb252ZXJ0UGFzdGVkSW1hZ2VSZXF1ZXN0EhIKBGRhdGEYASABKAxSBGRhdGESEAoDZXh0GA'
        'IgASgJUgNleHQ=');

@$core.Deprecated('Use convertPastedImageResponseDescriptor instead')
const ConvertPastedImageResponse$json = {
  '1': 'ConvertPastedImageResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `ConvertPastedImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertPastedImageResponseDescriptor =
    $convert.base64Decode(
        'ChpDb252ZXJ0UGFzdGVkSW1hZ2VSZXNwb25zZRISCgRkYXRhGAEgASgMUgRkYXRh');

@$core.Deprecated('Use setSettingJsonRequestDescriptor instead')
const SetSettingJsonRequest$json = {
  '1': 'SetSettingJsonRequest',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value_json', '3': 2, '4': 1, '5': 12, '10': 'valueJson'},
  ],
};

/// Descriptor for `SetSettingJsonRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setSettingJsonRequestDescriptor = $convert.base64Decode(
    'ChVTZXRTZXR0aW5nSnNvblJlcXVlc3QSEAoDa2V5GAEgASgJUgNrZXkSHQoKdmFsdWVfanNvbh'
    'gCIAEoDFIJdmFsdWVKc29u');

@$core.Deprecated('Use openFilePickerRequestDescriptor instead')
const openFilePickerRequest$json = {
  '1': 'openFilePickerRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'key', '3': 2, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'filter_description',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'filterDescription'
    },
    {'1': 'extensions', '3': 4, '4': 3, '5': 9, '10': 'extensions'},
  ],
};

/// Descriptor for `openFilePickerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openFilePickerRequestDescriptor = $convert.base64Decode(
    'ChVvcGVuRmlsZVBpY2tlclJlcXVlc3QSFAoFdGl0bGUYASABKAlSBXRpdGxlEhAKA2tleRgCIA'
    'EoCVIDa2V5Ei0KEmZpbHRlcl9kZXNjcmlwdGlvbhgDIAEoCVIRZmlsdGVyRGVzY3JpcHRpb24S'
    'HgoKZXh0ZW5zaW9ucxgEIAMoCVIKZXh0ZW5zaW9ucw==');

@$core.Deprecated('Use readClipboardRequestDescriptor instead')
const ReadClipboardRequest$json = {
  '1': 'ReadClipboardRequest',
  '2': [
    {'1': 'types', '3': 1, '4': 3, '5': 9, '10': 'types'},
  ],
};

/// Descriptor for `ReadClipboardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readClipboardRequestDescriptor =
    $convert.base64Decode(
        'ChRSZWFkQ2xpcGJvYXJkUmVxdWVzdBIUCgV0eXBlcxgBIAMoCVIFdHlwZXM=');

@$core.Deprecated('Use readClipboardResponseDescriptor instead')
const ReadClipboardResponse$json = {
  '1': 'ReadClipboardResponse',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.frontend.ReadClipboardResponse.DataEntry',
      '10': 'data'
    },
  ],
  '3': [ReadClipboardResponse_DataEntry$json],
};

@$core.Deprecated('Use readClipboardResponseDescriptor instead')
const ReadClipboardResponse_DataEntry$json = {
  '1': 'DataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ReadClipboardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readClipboardResponseDescriptor = $convert.base64Decode(
    'ChVSZWFkQ2xpcGJvYXJkUmVzcG9uc2USQgoEZGF0YRgBIAMoCzIuLmFua2kuZnJvbnRlbmQuUm'
    'VhZENsaXBib2FyZFJlc3BvbnNlLkRhdGFFbnRyeVIEZGF0YRo3CglEYXRhRW50cnkSEAoDa2V5'
    'GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use writeClipboardRequestDescriptor instead')
const WriteClipboardRequest$json = {
  '1': 'WriteClipboardRequest',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.frontend.WriteClipboardRequest.DataEntry',
      '10': 'data'
    },
  ],
  '3': [WriteClipboardRequest_DataEntry$json],
};

@$core.Deprecated('Use writeClipboardRequestDescriptor instead')
const WriteClipboardRequest_DataEntry$json = {
  '1': 'DataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `WriteClipboardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeClipboardRequestDescriptor = $convert.base64Decode(
    'ChVXcml0ZUNsaXBib2FyZFJlcXVlc3QSQgoEZGF0YRgBIAMoCzIuLmFua2kuZnJvbnRlbmQuV3'
    'JpdGVDbGlwYm9hcmRSZXF1ZXN0LkRhdGFFbnRyeVIEZGF0YRo3CglEYXRhRW50cnkSEAoDa2V5'
    'GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use helpDescriptor instead')
const Help$json = {
  '1': 'Help',
  '2': [
    {
      '1': 'help_page',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.links.HelpPageLinkRequest.HelpPage',
      '9': 0,
      '10': 'helpPage'
    },
    {'1': 'help_link', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'helpLink'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `Help`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helpDescriptor = $convert.base64Decode(
    'CgRIZWxwEkcKCWhlbHBfcGFnZRgBIAEoDjIoLmFua2kubGlua3MuSGVscFBhZ2VMaW5rUmVxdW'
    'VzdC5IZWxwUGFnZUgAUghoZWxwUGFnZRIdCgloZWxwX2xpbmsYAiABKAlIAFIIaGVscExpbmtC'
    'BwoFdmFsdWU=');

@$core.Deprecated('Use askUserRequestDescriptor instead')
const AskUserRequest$json = {
  '1': 'AskUserRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'help',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.frontend.Help',
      '9': 0,
      '10': 'help',
      '17': true
    },
    {'1': 'title', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'title', '17': true},
    {
      '1': 'default_no',
      '3': 5,
      '4': 1,
      '5': 8,
      '9': 2,
      '10': 'defaultNo',
      '17': true
    },
  ],
  '8': [
    {'1': '_help'},
    {'1': '_title'},
    {'1': '_default_no'},
  ],
};

/// Descriptor for `AskUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List askUserRequestDescriptor = $convert.base64Decode(
    'Cg5Bc2tVc2VyUmVxdWVzdBISCgR0ZXh0GAEgASgJUgR0ZXh0EiwKBGhlbHAYAiABKAsyEy5hbm'
    'tpLmZyb250ZW5kLkhlbHBIAFIEaGVscIgBARIZCgV0aXRsZRgEIAEoCUgBUgV0aXRsZYgBARIi'
    'CgpkZWZhdWx0X25vGAUgASgISAJSCWRlZmF1bHROb4gBAUIHCgVfaGVscEIICgZfdGl0bGVCDQ'
    'oLX2RlZmF1bHRfbm8=');

@$core.Deprecated('Use showMessageBoxRequestDescriptor instead')
const ShowMessageBoxRequest$json = {
  '1': 'ShowMessageBoxRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.frontend.MessageBoxType',
      '10': 'type'
    },
    {
      '1': 'help',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.frontend.Help',
      '9': 0,
      '10': 'help',
      '17': true
    },
    {'1': 'title', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'title', '17': true},
    {
      '1': 'text_format',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'textFormat',
      '17': true
    },
  ],
  '8': [
    {'1': '_help'},
    {'1': '_title'},
    {'1': '_text_format'},
  ],
};

/// Descriptor for `ShowMessageBoxRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showMessageBoxRequestDescriptor = $convert.base64Decode(
    'ChVTaG93TWVzc2FnZUJveFJlcXVlc3QSEgoEdGV4dBgBIAEoCVIEdGV4dBIxCgR0eXBlGAIgAS'
    'gOMh0uYW5raS5mcm9udGVuZC5NZXNzYWdlQm94VHlwZVIEdHlwZRIsCgRoZWxwGAMgASgLMhMu'
    'YW5raS5mcm9udGVuZC5IZWxwSABSBGhlbHCIAQESGQoFdGl0bGUYBCABKAlIAVIFdGl0bGWIAQ'
    'ESJAoLdGV4dF9mb3JtYXQYBSABKAlIAlIKdGV4dEZvcm1hdIgBAUIHCgVfaGVscEIICgZfdGl0'
    'bGVCDgoMX3RleHRfZm9ybWF0');

const $core.Map<$core.String, $core.dynamic> FrontendServiceBase$json = {
  '1': 'FrontendService',
  '2': [
    {
      '1': 'GetSchedulingStatesWithContext',
      '2': '.anki.generic.Empty',
      '3': '.anki.frontend.SchedulingStatesWithContext'
    },
    {
      '1': 'SetSchedulingStates',
      '2': '.anki.frontend.SetSchedulingStatesRequest',
      '3': '.anki.generic.Empty'
    },
    {'1': 'ImportDone', '2': '.anki.generic.Empty', '3': '.anki.generic.Empty'},
    {
      '1': 'SearchInBrowser',
      '2': '.anki.search.SearchNode',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'deckOptionsRequireClose',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'deckOptionsReady',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'ConvertPastedImage',
      '2': '.anki.frontend.ConvertPastedImageRequest',
      '3': '.anki.frontend.ConvertPastedImageResponse'
    },
    {
      '1': 'OpenFilePicker',
      '2': '.anki.frontend.openFilePickerRequest',
      '3': '.anki.generic.String'
    },
    {'1': 'OpenMedia', '2': '.anki.generic.String', '3': '.anki.generic.Empty'},
    {
      '1': 'ShowInMediaFolder',
      '2': '.anki.generic.String',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'RecordAudio',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.String'
    },
    {'1': 'PlayFile', '2': '.anki.generic.String', '3': '.anki.generic.Empty'},
    {
      '1': 'CloseAddCards',
      '2': '.anki.generic.Bool',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'CloseEditCurrent',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {'1': 'OpenLink', '2': '.anki.generic.String', '3': '.anki.generic.Empty'},
    {
      '1': 'AskUser',
      '2': '.anki.frontend.AskUserRequest',
      '3': '.anki.generic.Bool'
    },
    {
      '1': 'ShowMessageBox',
      '2': '.anki.frontend.ShowMessageBoxRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'OpenFieldsDialog',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'OpenCardsDialog',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'GetProfileConfigJson',
      '2': '.anki.generic.String',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'SetProfileConfigJson',
      '2': '.anki.frontend.SetSettingJsonRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'GetMetaJson',
      '2': '.anki.generic.String',
      '3': '.anki.generic.Json'
    },
    {
      '1': 'SetMetaJson',
      '2': '.anki.frontend.SetSettingJsonRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'ReadClipboard',
      '2': '.anki.frontend.ReadClipboardRequest',
      '3': '.anki.frontend.ReadClipboardResponse'
    },
    {
      '1': 'WriteClipboard',
      '2': '.anki.frontend.WriteClipboardRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'SaveCustomColours',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'ImportDialogRequireClose',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use frontendServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    FrontendServiceBase$messageJson = {
  '.anki.generic.Empty': $1.Empty$json,
  '.anki.frontend.SchedulingStatesWithContext':
      SchedulingStatesWithContext$json,
  '.anki.scheduler.SchedulingStates': $0.SchedulingStates$json,
  '.anki.scheduler.SchedulingState': $0.SchedulingState$json,
  '.anki.scheduler.SchedulingState.Normal': $0.SchedulingState_Normal$json,
  '.anki.scheduler.SchedulingState.New': $0.SchedulingState_New$json,
  '.anki.scheduler.SchedulingState.Learning': $0.SchedulingState_Learning$json,
  '.anki.cards.FsrsMemoryState': $4.FsrsMemoryState$json,
  '.anki.scheduler.SchedulingState.Review': $0.SchedulingState_Review$json,
  '.anki.scheduler.SchedulingState.Relearning':
      $0.SchedulingState_Relearning$json,
  '.anki.scheduler.SchedulingState.Filtered': $0.SchedulingState_Filtered$json,
  '.anki.scheduler.SchedulingState.Preview': $0.SchedulingState_Preview$json,
  '.anki.scheduler.SchedulingState.ReschedulingFilter':
      $0.SchedulingState_ReschedulingFilter$json,
  '.anki.scheduler.SchedulingContext': $0.SchedulingContext$json,
  '.anki.frontend.SetSchedulingStatesRequest': SetSchedulingStatesRequest$json,
  '.anki.search.SearchNode': $2.SearchNode$json,
  '.anki.search.SearchNode.Group': $2.SearchNode_Group$json,
  '.anki.search.SearchNode.Dupe': $2.SearchNode_Dupe$json,
  '.anki.search.SearchNode.Rated': $2.SearchNode_Rated$json,
  '.anki.search.SearchNode.IdList': $2.SearchNode_IdList$json,
  '.anki.search.SearchNode.Field': $2.SearchNode_Field$json,
  '.anki.frontend.ConvertPastedImageRequest': ConvertPastedImageRequest$json,
  '.anki.frontend.ConvertPastedImageResponse': ConvertPastedImageResponse$json,
  '.anki.frontend.openFilePickerRequest': openFilePickerRequest$json,
  '.anki.generic.String': $1.String$json,
  '.anki.generic.Bool': $1.Bool$json,
  '.anki.frontend.AskUserRequest': AskUserRequest$json,
  '.anki.frontend.Help': Help$json,
  '.anki.frontend.ShowMessageBoxRequest': ShowMessageBoxRequest$json,
  '.anki.generic.Json': $1.Json$json,
  '.anki.frontend.SetSettingJsonRequest': SetSettingJsonRequest$json,
  '.anki.frontend.ReadClipboardRequest': ReadClipboardRequest$json,
  '.anki.frontend.ReadClipboardResponse': ReadClipboardResponse$json,
  '.anki.frontend.ReadClipboardResponse.DataEntry':
      ReadClipboardResponse_DataEntry$json,
  '.anki.frontend.WriteClipboardRequest': WriteClipboardRequest$json,
  '.anki.frontend.WriteClipboardRequest.DataEntry':
      WriteClipboardRequest_DataEntry$json,
};

/// Descriptor for `FrontendService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List frontendServiceDescriptor = $convert.base64Decode(
    'Cg9Gcm9udGVuZFNlcnZpY2USYQoeR2V0U2NoZWR1bGluZ1N0YXRlc1dpdGhDb250ZXh0EhMuYW'
    '5raS5nZW5lcmljLkVtcHR5GiouYW5raS5mcm9udGVuZC5TY2hlZHVsaW5nU3RhdGVzV2l0aENv'
    'bnRleHQSVQoTU2V0U2NoZWR1bGluZ1N0YXRlcxIpLmFua2kuZnJvbnRlbmQuU2V0U2NoZWR1bG'
    'luZ1N0YXRlc1JlcXVlc3QaEy5hbmtpLmdlbmVyaWMuRW1wdHkSNgoKSW1wb3J0RG9uZRITLmFu'
    'a2kuZ2VuZXJpYy5FbXB0eRoTLmFua2kuZ2VuZXJpYy5FbXB0eRI/Cg9TZWFyY2hJbkJyb3dzZX'
    'ISFy5hbmtpLnNlYXJjaC5TZWFyY2hOb2RlGhMuYW5raS5nZW5lcmljLkVtcHR5EkMKF2RlY2tP'
    'cHRpb25zUmVxdWlyZUNsb3NlEhMuYW5raS5nZW5lcmljLkVtcHR5GhMuYW5raS5nZW5lcmljLk'
    'VtcHR5EjwKEGRlY2tPcHRpb25zUmVhZHkSEy5hbmtpLmdlbmVyaWMuRW1wdHkaEy5hbmtpLmdl'
    'bmVyaWMuRW1wdHkSaQoSQ29udmVydFBhc3RlZEltYWdlEiguYW5raS5mcm9udGVuZC5Db252ZX'
    'J0UGFzdGVkSW1hZ2VSZXF1ZXN0GikuYW5raS5mcm9udGVuZC5Db252ZXJ0UGFzdGVkSW1hZ2VS'
    'ZXNwb25zZRJMCg5PcGVuRmlsZVBpY2tlchIkLmFua2kuZnJvbnRlbmQub3BlbkZpbGVQaWNrZX'
    'JSZXF1ZXN0GhQuYW5raS5nZW5lcmljLlN0cmluZxI2CglPcGVuTWVkaWESFC5hbmtpLmdlbmVy'
    'aWMuU3RyaW5nGhMuYW5raS5nZW5lcmljLkVtcHR5Ej4KEVNob3dJbk1lZGlhRm9sZGVyEhQuYW'
    '5raS5nZW5lcmljLlN0cmluZxoTLmFua2kuZ2VuZXJpYy5FbXB0eRI4CgtSZWNvcmRBdWRpbxIT'
    'LmFua2kuZ2VuZXJpYy5FbXB0eRoULmFua2kuZ2VuZXJpYy5TdHJpbmcSNQoIUGxheUZpbGUSFC'
    '5hbmtpLmdlbmVyaWMuU3RyaW5nGhMuYW5raS5nZW5lcmljLkVtcHR5EjgKDUNsb3NlQWRkQ2Fy'
    'ZHMSEi5hbmtpLmdlbmVyaWMuQm9vbBoTLmFua2kuZ2VuZXJpYy5FbXB0eRI8ChBDbG9zZUVkaX'
    'RDdXJyZW50EhMuYW5raS5nZW5lcmljLkVtcHR5GhMuYW5raS5nZW5lcmljLkVtcHR5EjUKCE9w'
    'ZW5MaW5rEhQuYW5raS5nZW5lcmljLlN0cmluZxoTLmFua2kuZ2VuZXJpYy5FbXB0eRI8CgdBc2'
    'tVc2VyEh0uYW5raS5mcm9udGVuZC5Bc2tVc2VyUmVxdWVzdBoSLmFua2kuZ2VuZXJpYy5Cb29s'
    'EksKDlNob3dNZXNzYWdlQm94EiQuYW5raS5mcm9udGVuZC5TaG93TWVzc2FnZUJveFJlcXVlc3'
    'QaEy5hbmtpLmdlbmVyaWMuRW1wdHkSPAoQT3BlbkZpZWxkc0RpYWxvZxITLmFua2kuZ2VuZXJp'
    'Yy5FbXB0eRoTLmFua2kuZ2VuZXJpYy5FbXB0eRI7Cg9PcGVuQ2FyZHNEaWFsb2cSEy5hbmtpLm'
    'dlbmVyaWMuRW1wdHkaEy5hbmtpLmdlbmVyaWMuRW1wdHkSQAoUR2V0UHJvZmlsZUNvbmZpZ0pz'
    'b24SFC5hbmtpLmdlbmVyaWMuU3RyaW5nGhIuYW5raS5nZW5lcmljLkpzb24SUQoUU2V0UHJvZm'
    'lsZUNvbmZpZ0pzb24SJC5hbmtpLmZyb250ZW5kLlNldFNldHRpbmdKc29uUmVxdWVzdBoTLmFu'
    'a2kuZ2VuZXJpYy5FbXB0eRI3CgtHZXRNZXRhSnNvbhIULmFua2kuZ2VuZXJpYy5TdHJpbmcaEi'
    '5hbmtpLmdlbmVyaWMuSnNvbhJICgtTZXRNZXRhSnNvbhIkLmFua2kuZnJvbnRlbmQuU2V0U2V0'
    'dGluZ0pzb25SZXF1ZXN0GhMuYW5raS5nZW5lcmljLkVtcHR5EloKDVJlYWRDbGlwYm9hcmQSIy'
    '5hbmtpLmZyb250ZW5kLlJlYWRDbGlwYm9hcmRSZXF1ZXN0GiQuYW5raS5mcm9udGVuZC5SZWFk'
    'Q2xpcGJvYXJkUmVzcG9uc2USSwoOV3JpdGVDbGlwYm9hcmQSJC5hbmtpLmZyb250ZW5kLldyaX'
    'RlQ2xpcGJvYXJkUmVxdWVzdBoTLmFua2kuZ2VuZXJpYy5FbXB0eRI9ChFTYXZlQ3VzdG9tQ29s'
    'b3VycxITLmFua2kuZ2VuZXJpYy5FbXB0eRoTLmFua2kuZ2VuZXJpYy5FbXB0eRJEChhJbXBvcn'
    'REaWFsb2dSZXF1aXJlQ2xvc2USEy5hbmtpLmdlbmVyaWMuRW1wdHkaEy5hbmtpLmdlbmVyaWMu'
    'RW1wdHk=');

const $core.Map<$core.String, $core.dynamic> BackendFrontendServiceBase$json = {
  '1': 'BackendFrontendService'
};

@$core.Deprecated('Use backendFrontendServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendFrontendServiceBase$messageJson = {};

/// Descriptor for `BackendFrontendService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendFrontendServiceDescriptor =
    $convert.base64Decode('ChZCYWNrZW5kRnJvbnRlbmRTZXJ2aWNl');
