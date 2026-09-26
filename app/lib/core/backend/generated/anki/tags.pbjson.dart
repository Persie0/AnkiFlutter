// This is a generated file - do not edit.
//
// Generated from anki/tags.proto.

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

@$core.Deprecated('Use setTagCollapsedRequestDescriptor instead')
const SetTagCollapsedRequest$json = {
  '1': 'SetTagCollapsedRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'collapsed', '3': 2, '4': 1, '5': 8, '10': 'collapsed'},
  ],
};

/// Descriptor for `SetTagCollapsedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTagCollapsedRequestDescriptor =
    $convert.base64Decode(
        'ChZTZXRUYWdDb2xsYXBzZWRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSHAoJY29sbGFwc2'
        'VkGAIgASgIUgljb2xsYXBzZWQ=');

@$core.Deprecated('Use tagTreeNodeDescriptor instead')
const TagTreeNode$json = {
  '1': 'TagTreeNode',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'children',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.tags.TagTreeNode',
      '10': 'children'
    },
    {'1': 'level', '3': 3, '4': 1, '5': 13, '10': 'level'},
    {'1': 'collapsed', '3': 4, '4': 1, '5': 8, '10': 'collapsed'},
  ],
};

/// Descriptor for `TagTreeNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagTreeNodeDescriptor = $convert.base64Decode(
    'CgtUYWdUcmVlTm9kZRISCgRuYW1lGAEgASgJUgRuYW1lEjIKCGNoaWxkcmVuGAIgAygLMhYuYW'
    '5raS50YWdzLlRhZ1RyZWVOb2RlUghjaGlsZHJlbhIUCgVsZXZlbBgDIAEoDVIFbGV2ZWwSHAoJ'
    'Y29sbGFwc2VkGAQgASgIUgljb2xsYXBzZWQ=');

@$core.Deprecated('Use reparentTagsRequestDescriptor instead')
const ReparentTagsRequest$json = {
  '1': 'ReparentTagsRequest',
  '2': [
    {'1': 'tags', '3': 1, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'new_parent', '3': 2, '4': 1, '5': 9, '10': 'newParent'},
  ],
};

/// Descriptor for `ReparentTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reparentTagsRequestDescriptor = $convert.base64Decode(
    'ChNSZXBhcmVudFRhZ3NSZXF1ZXN0EhIKBHRhZ3MYASADKAlSBHRhZ3MSHQoKbmV3X3BhcmVudB'
    'gCIAEoCVIJbmV3UGFyZW50');

@$core.Deprecated('Use renameTagsRequestDescriptor instead')
const RenameTagsRequest$json = {
  '1': 'RenameTagsRequest',
  '2': [
    {'1': 'current_prefix', '3': 1, '4': 1, '5': 9, '10': 'currentPrefix'},
    {'1': 'new_prefix', '3': 2, '4': 1, '5': 9, '10': 'newPrefix'},
  ],
};

/// Descriptor for `RenameTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameTagsRequestDescriptor = $convert.base64Decode(
    'ChFSZW5hbWVUYWdzUmVxdWVzdBIlCg5jdXJyZW50X3ByZWZpeBgBIAEoCVINY3VycmVudFByZW'
    'ZpeBIdCgpuZXdfcHJlZml4GAIgASgJUgluZXdQcmVmaXg=');

@$core.Deprecated('Use noteIdsAndTagsRequestDescriptor instead')
const NoteIdsAndTagsRequest$json = {
  '1': 'NoteIdsAndTagsRequest',
  '2': [
    {'1': 'note_ids', '3': 1, '4': 3, '5': 3, '10': 'noteIds'},
    {'1': 'tags', '3': 2, '4': 1, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `NoteIdsAndTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteIdsAndTagsRequestDescriptor = $convert.base64Decode(
    'ChVOb3RlSWRzQW5kVGFnc1JlcXVlc3QSGQoIbm90ZV9pZHMYASADKANSB25vdGVJZHMSEgoEdG'
    'FncxgCIAEoCVIEdGFncw==');

@$core.Deprecated('Use findAndReplaceTagRequestDescriptor instead')
const FindAndReplaceTagRequest$json = {
  '1': 'FindAndReplaceTagRequest',
  '2': [
    {'1': 'note_ids', '3': 1, '4': 3, '5': 3, '10': 'noteIds'},
    {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
    {'1': 'replacement', '3': 3, '4': 1, '5': 9, '10': 'replacement'},
    {'1': 'regex', '3': 4, '4': 1, '5': 8, '10': 'regex'},
    {'1': 'match_case', '3': 5, '4': 1, '5': 8, '10': 'matchCase'},
  ],
};

/// Descriptor for `FindAndReplaceTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findAndReplaceTagRequestDescriptor = $convert.base64Decode(
    'ChhGaW5kQW5kUmVwbGFjZVRhZ1JlcXVlc3QSGQoIbm90ZV9pZHMYASADKANSB25vdGVJZHMSFg'
    'oGc2VhcmNoGAIgASgJUgZzZWFyY2gSIAoLcmVwbGFjZW1lbnQYAyABKAlSC3JlcGxhY2VtZW50'
    'EhQKBXJlZ2V4GAQgASgIUgVyZWdleBIdCgptYXRjaF9jYXNlGAUgASgIUgltYXRjaENhc2U=');

@$core.Deprecated('Use completeTagRequestDescriptor instead')
const CompleteTagRequest$json = {
  '1': 'CompleteTagRequest',
  '2': [
    {'1': 'input', '3': 1, '4': 1, '5': 9, '10': 'input'},
    {'1': 'match_limit', '3': 2, '4': 1, '5': 13, '10': 'matchLimit'},
  ],
};

/// Descriptor for `CompleteTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTagRequestDescriptor = $convert.base64Decode(
    'ChJDb21wbGV0ZVRhZ1JlcXVlc3QSFAoFaW5wdXQYASABKAlSBWlucHV0Eh8KC21hdGNoX2xpbW'
    'l0GAIgASgNUgptYXRjaExpbWl0');

@$core.Deprecated('Use completeTagResponseDescriptor instead')
const CompleteTagResponse$json = {
  '1': 'CompleteTagResponse',
  '2': [
    {'1': 'tags', '3': 1, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `CompleteTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTagResponseDescriptor = $convert
    .base64Decode('ChNDb21wbGV0ZVRhZ1Jlc3BvbnNlEhIKBHRhZ3MYASADKAlSBHRhZ3M=');

const $core.Map<$core.String, $core.dynamic> TagsServiceBase$json = {
  '1': 'TagsService',
  '2': [
    {
      '1': 'ClearUnusedTags',
      '2': '.anki.generic.Empty',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'AllTags',
      '2': '.anki.generic.Empty',
      '3': '.anki.generic.StringList'
    },
    {
      '1': 'RemoveTags',
      '2': '.anki.generic.String',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'SetTagCollapsed',
      '2': '.anki.tags.SetTagCollapsedRequest',
      '3': '.anki.collection.OpChanges'
    },
    {'1': 'TagTree', '2': '.anki.generic.Empty', '3': '.anki.tags.TagTreeNode'},
    {
      '1': 'ReparentTags',
      '2': '.anki.tags.ReparentTagsRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'RenameTags',
      '2': '.anki.tags.RenameTagsRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'AddNoteTags',
      '2': '.anki.tags.NoteIdsAndTagsRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'RemoveNoteTags',
      '2': '.anki.tags.NoteIdsAndTagsRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'FindAndReplaceTag',
      '2': '.anki.tags.FindAndReplaceTagRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'CompleteTag',
      '2': '.anki.tags.CompleteTagRequest',
      '3': '.anki.tags.CompleteTagResponse'
    },
  ],
};

@$core.Deprecated('Use tagsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    TagsServiceBase$messageJson = {
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.collection.OpChangesWithCount': $1.OpChangesWithCount$json,
  '.anki.collection.OpChanges': $1.OpChanges$json,
  '.anki.generic.StringList': $0.StringList$json,
  '.anki.generic.String': $0.String$json,
  '.anki.tags.SetTagCollapsedRequest': SetTagCollapsedRequest$json,
  '.anki.tags.TagTreeNode': TagTreeNode$json,
  '.anki.tags.ReparentTagsRequest': ReparentTagsRequest$json,
  '.anki.tags.RenameTagsRequest': RenameTagsRequest$json,
  '.anki.tags.NoteIdsAndTagsRequest': NoteIdsAndTagsRequest$json,
  '.anki.tags.FindAndReplaceTagRequest': FindAndReplaceTagRequest$json,
  '.anki.tags.CompleteTagRequest': CompleteTagRequest$json,
  '.anki.tags.CompleteTagResponse': CompleteTagResponse$json,
};

/// Descriptor for `TagsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List tagsServiceDescriptor = $convert.base64Decode(
    'CgtUYWdzU2VydmljZRJLCg9DbGVhclVudXNlZFRhZ3MSEy5hbmtpLmdlbmVyaWMuRW1wdHkaIy'
    '5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzV2l0aENvdW50EjgKB0FsbFRhZ3MSEy5hbmtpLmdl'
    'bmVyaWMuRW1wdHkaGC5hbmtpLmdlbmVyaWMuU3RyaW5nTGlzdBJHCgpSZW1vdmVUYWdzEhQuYW'
    '5raS5nZW5lcmljLlN0cmluZxojLmFua2kuY29sbGVjdGlvbi5PcENoYW5nZXNXaXRoQ291bnQS'
    'UAoPU2V0VGFnQ29sbGFwc2VkEiEuYW5raS50YWdzLlNldFRhZ0NvbGxhcHNlZFJlcXVlc3QaGi'
    '5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzEjYKB1RhZ1RyZWUSEy5hbmtpLmdlbmVyaWMuRW1w'
    'dHkaFi5hbmtpLnRhZ3MuVGFnVHJlZU5vZGUSUwoMUmVwYXJlbnRUYWdzEh4uYW5raS50YWdzLl'
    'JlcGFyZW50VGFnc1JlcXVlc3QaIy5hbmtpLmNvbGxlY3Rpb24uT3BDaGFuZ2VzV2l0aENvdW50'
    'Ek8KClJlbmFtZVRhZ3MSHC5hbmtpLnRhZ3MuUmVuYW1lVGFnc1JlcXVlc3QaIy5hbmtpLmNvbG'
    'xlY3Rpb24uT3BDaGFuZ2VzV2l0aENvdW50ElQKC0FkZE5vdGVUYWdzEiAuYW5raS50YWdzLk5v'
    'dGVJZHNBbmRUYWdzUmVxdWVzdBojLmFua2kuY29sbGVjdGlvbi5PcENoYW5nZXNXaXRoQ291bn'
    'QSVwoOUmVtb3ZlTm90ZVRhZ3MSIC5hbmtpLnRhZ3MuTm90ZUlkc0FuZFRhZ3NSZXF1ZXN0GiMu'
    'YW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlc1dpdGhDb3VudBJdChFGaW5kQW5kUmVwbGFjZVRhZx'
    'IjLmFua2kudGFncy5GaW5kQW5kUmVwbGFjZVRhZ1JlcXVlc3QaIy5hbmtpLmNvbGxlY3Rpb24u'
    'T3BDaGFuZ2VzV2l0aENvdW50EkwKC0NvbXBsZXRlVGFnEh0uYW5raS50YWdzLkNvbXBsZXRlVG'
    'FnUmVxdWVzdBoeLmFua2kudGFncy5Db21wbGV0ZVRhZ1Jlc3BvbnNl');

const $core.Map<$core.String, $core.dynamic> BackendTagsServiceBase$json = {
  '1': 'BackendTagsService'
};

@$core.Deprecated('Use backendTagsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendTagsServiceBase$messageJson = {};

/// Descriptor for `BackendTagsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendTagsServiceDescriptor =
    $convert.base64Decode('ChJCYWNrZW5kVGFnc1NlcnZpY2U=');
