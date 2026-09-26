// This is a generated file - do not edit.
//
// Generated from anki/search.proto.

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

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode$json = {
  '1': 'SearchNode',
  '2': [
    {
      '1': 'group',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode.Group',
      '9': 0,
      '10': 'group'
    },
    {
      '1': 'negated',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode',
      '9': 0,
      '10': 'negated'
    },
    {
      '1': 'parsable_text',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'parsableText'
    },
    {'1': 'template', '3': 4, '4': 1, '5': 13, '9': 0, '10': 'template'},
    {'1': 'nid', '3': 5, '4': 1, '5': 3, '9': 0, '10': 'nid'},
    {
      '1': 'dupe',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode.Dupe',
      '9': 0,
      '10': 'dupe'
    },
    {'1': 'field_name', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'fieldName'},
    {
      '1': 'rated',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode.Rated',
      '9': 0,
      '10': 'rated'
    },
    {
      '1': 'added_in_days',
      '3': 9,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'addedInDays'
    },
    {'1': 'due_in_days', '3': 10, '4': 1, '5': 5, '9': 0, '10': 'dueInDays'},
    {
      '1': 'flag',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.anki.search.SearchNode.Flag',
      '9': 0,
      '10': 'flag'
    },
    {
      '1': 'card_state',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.anki.search.SearchNode.CardState',
      '9': 0,
      '10': 'cardState'
    },
    {
      '1': 'nids',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode.IdList',
      '9': 0,
      '10': 'nids'
    },
    {
      '1': 'edited_in_days',
      '3': 14,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'editedInDays'
    },
    {'1': 'deck', '3': 15, '4': 1, '5': 9, '9': 0, '10': 'deck'},
    {'1': 'due_on_day', '3': 16, '4': 1, '5': 5, '9': 0, '10': 'dueOnDay'},
    {'1': 'tag', '3': 17, '4': 1, '5': 9, '9': 0, '10': 'tag'},
    {'1': 'note', '3': 18, '4': 1, '5': 9, '9': 0, '10': 'note'},
    {
      '1': 'introduced_in_days',
      '3': 19,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'introducedInDays'
    },
    {
      '1': 'field',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode.Field',
      '9': 0,
      '10': 'field'
    },
    {'1': 'literal_text', '3': 21, '4': 1, '5': 9, '9': 0, '10': 'literalText'},
  ],
  '3': [
    SearchNode_Dupe$json,
    SearchNode_Rated$json,
    SearchNode_IdList$json,
    SearchNode_Group$json,
    SearchNode_Field$json
  ],
  '4': [
    SearchNode_Flag$json,
    SearchNode_Rating$json,
    SearchNode_CardState$json,
    SearchNode_FieldSearchMode$json
  ],
  '8': [
    {'1': 'filter'},
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_Dupe$json = {
  '1': 'Dupe',
  '2': [
    {'1': 'notetype_id', '3': 1, '4': 1, '5': 3, '10': 'notetypeId'},
    {'1': 'first_field', '3': 2, '4': 1, '5': 9, '10': 'firstField'},
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_Rated$json = {
  '1': 'Rated',
  '2': [
    {'1': 'days', '3': 1, '4': 1, '5': 13, '10': 'days'},
    {
      '1': 'rating',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.search.SearchNode.Rating',
      '10': 'rating'
    },
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_IdList$json = {
  '1': 'IdList',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 3, '10': 'ids'},
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_Group$json = {
  '1': 'Group',
  '2': [
    {
      '1': 'nodes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.search.SearchNode',
      '10': 'nodes'
    },
    {
      '1': 'joiner',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.search.SearchNode.Group.Joiner',
      '10': 'joiner'
    },
  ],
  '4': [SearchNode_Group_Joiner$json],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_Group_Joiner$json = {
  '1': 'Joiner',
  '2': [
    {'1': 'AND', '2': 0},
    {'1': 'OR', '2': 1},
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_Field$json = {
  '1': 'Field',
  '2': [
    {'1': 'field_name', '3': 1, '4': 1, '5': 9, '10': 'fieldName'},
    {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'mode',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.anki.search.SearchNode.FieldSearchMode',
      '10': 'mode'
    },
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_Flag$json = {
  '1': 'Flag',
  '2': [
    {'1': 'FLAG_NONE', '2': 0},
    {'1': 'FLAG_ANY', '2': 1},
    {'1': 'FLAG_RED', '2': 2},
    {'1': 'FLAG_ORANGE', '2': 3},
    {'1': 'FLAG_GREEN', '2': 4},
    {'1': 'FLAG_BLUE', '2': 5},
    {'1': 'FLAG_PINK', '2': 6},
    {'1': 'FLAG_TURQUOISE', '2': 7},
    {'1': 'FLAG_PURPLE', '2': 8},
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_Rating$json = {
  '1': 'Rating',
  '2': [
    {'1': 'RATING_ANY', '2': 0},
    {'1': 'RATING_AGAIN', '2': 1},
    {'1': 'RATING_HARD', '2': 2},
    {'1': 'RATING_GOOD', '2': 3},
    {'1': 'RATING_EASY', '2': 4},
    {'1': 'RATING_BY_RESCHEDULE', '2': 5},
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_CardState$json = {
  '1': 'CardState',
  '2': [
    {'1': 'CARD_STATE_NEW', '2': 0},
    {'1': 'CARD_STATE_LEARN', '2': 1},
    {'1': 'CARD_STATE_REVIEW', '2': 2},
    {'1': 'CARD_STATE_DUE', '2': 3},
    {'1': 'CARD_STATE_SUSPENDED', '2': 4},
    {'1': 'CARD_STATE_BURIED', '2': 5},
  ],
};

@$core.Deprecated('Use searchNodeDescriptor instead')
const SearchNode_FieldSearchMode$json = {
  '1': 'FieldSearchMode',
  '2': [
    {'1': 'FIELD_SEARCH_MODE_NORMAL', '2': 0},
    {'1': 'FIELD_SEARCH_MODE_REGEX', '2': 1},
    {'1': 'FIELD_SEARCH_MODE_NOCOMBINING', '2': 2},
  ],
};

/// Descriptor for `SearchNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchNodeDescriptor = $convert.base64Decode(
    'CgpTZWFyY2hOb2RlEjUKBWdyb3VwGAEgASgLMh0uYW5raS5zZWFyY2guU2VhcmNoTm9kZS5Hcm'
    '91cEgAUgVncm91cBIzCgduZWdhdGVkGAIgASgLMhcuYW5raS5zZWFyY2guU2VhcmNoTm9kZUgA'
    'UgduZWdhdGVkEiUKDXBhcnNhYmxlX3RleHQYAyABKAlIAFIMcGFyc2FibGVUZXh0EhwKCHRlbX'
    'BsYXRlGAQgASgNSABSCHRlbXBsYXRlEhIKA25pZBgFIAEoA0gAUgNuaWQSMgoEZHVwZRgGIAEo'
    'CzIcLmFua2kuc2VhcmNoLlNlYXJjaE5vZGUuRHVwZUgAUgRkdXBlEh8KCmZpZWxkX25hbWUYBy'
    'ABKAlIAFIJZmllbGROYW1lEjUKBXJhdGVkGAggASgLMh0uYW5raS5zZWFyY2guU2VhcmNoTm9k'
    'ZS5SYXRlZEgAUgVyYXRlZBIkCg1hZGRlZF9pbl9kYXlzGAkgASgNSABSC2FkZGVkSW5EYXlzEi'
    'AKC2R1ZV9pbl9kYXlzGAogASgFSABSCWR1ZUluRGF5cxIyCgRmbGFnGAsgASgOMhwuYW5raS5z'
    'ZWFyY2guU2VhcmNoTm9kZS5GbGFnSABSBGZsYWcSQgoKY2FyZF9zdGF0ZRgMIAEoDjIhLmFua2'
    'kuc2VhcmNoLlNlYXJjaE5vZGUuQ2FyZFN0YXRlSABSCWNhcmRTdGF0ZRI0CgRuaWRzGA0gASgL'
    'Mh4uYW5raS5zZWFyY2guU2VhcmNoTm9kZS5JZExpc3RIAFIEbmlkcxImCg5lZGl0ZWRfaW5fZG'
    'F5cxgOIAEoDUgAUgxlZGl0ZWRJbkRheXMSFAoEZGVjaxgPIAEoCUgAUgRkZWNrEh4KCmR1ZV9v'
    'bl9kYXkYECABKAVIAFIIZHVlT25EYXkSEgoDdGFnGBEgASgJSABSA3RhZxIUCgRub3RlGBIgAS'
    'gJSABSBG5vdGUSLgoSaW50cm9kdWNlZF9pbl9kYXlzGBMgASgNSABSEGludHJvZHVjZWRJbkRh'
    'eXMSNQoFZmllbGQYFCABKAsyHS5hbmtpLnNlYXJjaC5TZWFyY2hOb2RlLkZpZWxkSABSBWZpZW'
    'xkEiMKDGxpdGVyYWxfdGV4dBgVIAEoCUgAUgtsaXRlcmFsVGV4dBpICgREdXBlEh8KC25vdGV0'
    'eXBlX2lkGAEgASgDUgpub3RldHlwZUlkEh8KC2ZpcnN0X2ZpZWxkGAIgASgJUgpmaXJzdEZpZW'
    'xkGlMKBVJhdGVkEhIKBGRheXMYASABKA1SBGRheXMSNgoGcmF0aW5nGAIgASgOMh4uYW5raS5z'
    'ZWFyY2guU2VhcmNoTm9kZS5SYXRpbmdSBnJhdGluZxoaCgZJZExpc3QSEAoDaWRzGAEgAygDUg'
    'NpZHMajwEKBUdyb3VwEi0KBW5vZGVzGAEgAygLMhcuYW5raS5zZWFyY2guU2VhcmNoTm9kZVIF'
    'bm9kZXMSPAoGam9pbmVyGAIgASgOMiQuYW5raS5zZWFyY2guU2VhcmNoTm9kZS5Hcm91cC5Kb2'
    'luZXJSBmpvaW5lciIZCgZKb2luZXISBwoDQU5EEAASBgoCT1IQARp3CgVGaWVsZBIdCgpmaWVs'
    'ZF9uYW1lGAEgASgJUglmaWVsZE5hbWUSEgoEdGV4dBgCIAEoCVIEdGV4dBI7CgRtb2RlGAMgAS'
    'gOMicuYW5raS5zZWFyY2guU2VhcmNoTm9kZS5GaWVsZFNlYXJjaE1vZGVSBG1vZGUilQEKBEZs'
    'YWcSDQoJRkxBR19OT05FEAASDAoIRkxBR19BTlkQARIMCghGTEFHX1JFRBACEg8KC0ZMQUdfT1'
    'JBTkdFEAMSDgoKRkxBR19HUkVFThAEEg0KCUZMQUdfQkxVRRAFEg0KCUZMQUdfUElOSxAGEhIK'
    'DkZMQUdfVFVSUVVPSVNFEAcSDwoLRkxBR19QVVJQTEUQCCJ3CgZSYXRpbmcSDgoKUkFUSU5HX0'
    'FOWRAAEhAKDFJBVElOR19BR0FJThABEg8KC1JBVElOR19IQVJEEAISDwoLUkFUSU5HX0dPT0QQ'
    'AxIPCgtSQVRJTkdfRUFTWRAEEhgKFFJBVElOR19CWV9SRVNDSEVEVUxFEAUikQEKCUNhcmRTdG'
    'F0ZRISCg5DQVJEX1NUQVRFX05FVxAAEhQKEENBUkRfU1RBVEVfTEVBUk4QARIVChFDQVJEX1NU'
    'QVRFX1JFVklFVxACEhIKDkNBUkRfU1RBVEVfRFVFEAMSGAoUQ0FSRF9TVEFURV9TVVNQRU5ERU'
    'QQBBIVChFDQVJEX1NUQVRFX0JVUklFRBAFIm8KD0ZpZWxkU2VhcmNoTW9kZRIcChhGSUVMRF9T'
    'RUFSQ0hfTU9ERV9OT1JNQUwQABIbChdGSUVMRF9TRUFSQ0hfTU9ERV9SRUdFWBABEiEKHUZJRU'
    'xEX1NFQVJDSF9NT0RFX05PQ09NQklOSU5HEAJCCAoGZmlsdGVy');

@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest$json = {
  '1': 'SearchRequest',
  '2': [
    {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
    {
      '1': 'order',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SortOrder',
      '10': 'order'
    },
  ],
};

/// Descriptor for `SearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hSZXF1ZXN0EhYKBnNlYXJjaBgBIAEoCVIGc2VhcmNoEiwKBW9yZGVyGAIgASgLMh'
    'YuYW5raS5zZWFyY2guU29ydE9yZGVyUgVvcmRlcg==');

@$core.Deprecated('Use searchResponseDescriptor instead')
const SearchResponse$json = {
  '1': 'SearchResponse',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 3, '10': 'ids'},
  ],
};

/// Descriptor for `SearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResponseDescriptor =
    $convert.base64Decode('Cg5TZWFyY2hSZXNwb25zZRIQCgNpZHMYASADKANSA2lkcw==');

@$core.Deprecated('Use sortOrderDescriptor instead')
const SortOrder$json = {
  '1': 'SortOrder',
  '2': [
    {
      '1': 'none',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.generic.Empty',
      '9': 0,
      '10': 'none'
    },
    {'1': 'custom', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'custom'},
    {
      '1': 'builtin',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SortOrder.Builtin',
      '9': 0,
      '10': 'builtin'
    },
  ],
  '3': [SortOrder_Builtin$json],
  '8': [
    {'1': 'value'},
  ],
};

@$core.Deprecated('Use sortOrderDescriptor instead')
const SortOrder_Builtin$json = {
  '1': 'Builtin',
  '2': [
    {'1': 'column', '3': 1, '4': 1, '5': 9, '10': 'column'},
    {'1': 'reverse', '3': 2, '4': 1, '5': 8, '10': 'reverse'},
  ],
};

/// Descriptor for `SortOrder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sortOrderDescriptor = $convert.base64Decode(
    'CglTb3J0T3JkZXISKQoEbm9uZRgBIAEoCzITLmFua2kuZ2VuZXJpYy5FbXB0eUgAUgRub25lEh'
    'gKBmN1c3RvbRgCIAEoCUgAUgZjdXN0b20SOgoHYnVpbHRpbhgDIAEoCzIeLmFua2kuc2VhcmNo'
    'LlNvcnRPcmRlci5CdWlsdGluSABSB2J1aWx0aW4aOwoHQnVpbHRpbhIWCgZjb2x1bW4YASABKA'
    'lSBmNvbHVtbhIYCgdyZXZlcnNlGAIgASgIUgdyZXZlcnNlQgcKBXZhbHVl');

@$core.Deprecated('Use joinSearchNodesRequestDescriptor instead')
const JoinSearchNodesRequest$json = {
  '1': 'JoinSearchNodesRequest',
  '2': [
    {
      '1': 'joiner',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.search.SearchNode.Group.Joiner',
      '10': 'joiner'
    },
    {
      '1': 'existing_node',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode',
      '10': 'existingNode'
    },
    {
      '1': 'additional_node',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode',
      '10': 'additionalNode'
    },
  ],
};

/// Descriptor for `JoinSearchNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinSearchNodesRequestDescriptor = $convert.base64Decode(
    'ChZKb2luU2VhcmNoTm9kZXNSZXF1ZXN0EjwKBmpvaW5lchgBIAEoDjIkLmFua2kuc2VhcmNoLl'
    'NlYXJjaE5vZGUuR3JvdXAuSm9pbmVyUgZqb2luZXISPAoNZXhpc3Rpbmdfbm9kZRgCIAEoCzIX'
    'LmFua2kuc2VhcmNoLlNlYXJjaE5vZGVSDGV4aXN0aW5nTm9kZRJACg9hZGRpdGlvbmFsX25vZG'
    'UYAyABKAsyFy5hbmtpLnNlYXJjaC5TZWFyY2hOb2RlUg5hZGRpdGlvbmFsTm9kZQ==');

@$core.Deprecated('Use replaceSearchNodeRequestDescriptor instead')
const ReplaceSearchNodeRequest$json = {
  '1': 'ReplaceSearchNodeRequest',
  '2': [
    {
      '1': 'existing_node',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode',
      '10': 'existingNode'
    },
    {
      '1': 'replacement_node',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.search.SearchNode',
      '10': 'replacementNode'
    },
  ],
};

/// Descriptor for `ReplaceSearchNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replaceSearchNodeRequestDescriptor = $convert.base64Decode(
    'ChhSZXBsYWNlU2VhcmNoTm9kZVJlcXVlc3QSPAoNZXhpc3Rpbmdfbm9kZRgBIAEoCzIXLmFua2'
    'kuc2VhcmNoLlNlYXJjaE5vZGVSDGV4aXN0aW5nTm9kZRJCChByZXBsYWNlbWVudF9ub2RlGAIg'
    'ASgLMhcuYW5raS5zZWFyY2guU2VhcmNoTm9kZVIPcmVwbGFjZW1lbnROb2Rl');

@$core.Deprecated('Use findAndReplaceRequestDescriptor instead')
const FindAndReplaceRequest$json = {
  '1': 'FindAndReplaceRequest',
  '2': [
    {'1': 'nids', '3': 1, '4': 3, '5': 3, '10': 'nids'},
    {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
    {'1': 'replacement', '3': 3, '4': 1, '5': 9, '10': 'replacement'},
    {'1': 'regex', '3': 4, '4': 1, '5': 8, '10': 'regex'},
    {'1': 'match_case', '3': 5, '4': 1, '5': 8, '10': 'matchCase'},
    {'1': 'field_name', '3': 6, '4': 1, '5': 9, '10': 'fieldName'},
  ],
};

/// Descriptor for `FindAndReplaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findAndReplaceRequestDescriptor = $convert.base64Decode(
    'ChVGaW5kQW5kUmVwbGFjZVJlcXVlc3QSEgoEbmlkcxgBIAMoA1IEbmlkcxIWCgZzZWFyY2gYAi'
    'ABKAlSBnNlYXJjaBIgCgtyZXBsYWNlbWVudBgDIAEoCVILcmVwbGFjZW1lbnQSFAoFcmVnZXgY'
    'BCABKAhSBXJlZ2V4Eh0KCm1hdGNoX2Nhc2UYBSABKAhSCW1hdGNoQ2FzZRIdCgpmaWVsZF9uYW'
    '1lGAYgASgJUglmaWVsZE5hbWU=');

@$core.Deprecated('Use browserColumnsDescriptor instead')
const BrowserColumns$json = {
  '1': 'BrowserColumns',
  '2': [
    {
      '1': 'columns',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.search.BrowserColumns.Column',
      '10': 'columns'
    },
  ],
  '3': [BrowserColumns_Column$json],
  '4': [BrowserColumns_Sorting$json, BrowserColumns_Alignment$json],
};

@$core.Deprecated('Use browserColumnsDescriptor instead')
const BrowserColumns_Column$json = {
  '1': 'Column',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'cards_mode_label', '3': 2, '4': 1, '5': 9, '10': 'cardsModeLabel'},
    {'1': 'notes_mode_label', '3': 3, '4': 1, '5': 9, '10': 'notesModeLabel'},
    {
      '1': 'sorting_cards',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.anki.search.BrowserColumns.Sorting',
      '10': 'sortingCards'
    },
    {
      '1': 'sorting_notes',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.anki.search.BrowserColumns.Sorting',
      '10': 'sortingNotes'
    },
    {'1': 'uses_cell_font', '3': 5, '4': 1, '5': 8, '10': 'usesCellFont'},
    {
      '1': 'alignment',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.anki.search.BrowserColumns.Alignment',
      '10': 'alignment'
    },
    {
      '1': 'cards_mode_tooltip',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'cardsModeTooltip'
    },
    {
      '1': 'notes_mode_tooltip',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'notesModeTooltip'
    },
  ],
};

@$core.Deprecated('Use browserColumnsDescriptor instead')
const BrowserColumns_Sorting$json = {
  '1': 'Sorting',
  '2': [
    {'1': 'SORTING_NONE', '2': 0},
    {'1': 'SORTING_ASCENDING', '2': 1},
    {'1': 'SORTING_DESCENDING', '2': 2},
  ],
};

@$core.Deprecated('Use browserColumnsDescriptor instead')
const BrowserColumns_Alignment$json = {
  '1': 'Alignment',
  '2': [
    {'1': 'ALIGNMENT_START', '2': 0},
    {'1': 'ALIGNMENT_CENTER', '2': 1},
  ],
};

/// Descriptor for `BrowserColumns`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List browserColumnsDescriptor = $convert.base64Decode(
    'Cg5Ccm93c2VyQ29sdW1ucxI8Cgdjb2x1bW5zGAEgAygLMiIuYW5raS5zZWFyY2guQnJvd3Nlck'
    'NvbHVtbnMuQ29sdW1uUgdjb2x1bW5zGskDCgZDb2x1bW4SEAoDa2V5GAEgASgJUgNrZXkSKAoQ'
    'Y2FyZHNfbW9kZV9sYWJlbBgCIAEoCVIOY2FyZHNNb2RlTGFiZWwSKAoQbm90ZXNfbW9kZV9sYW'
    'JlbBgDIAEoCVIObm90ZXNNb2RlTGFiZWwSSAoNc29ydGluZ19jYXJkcxgEIAEoDjIjLmFua2ku'
    'c2VhcmNoLkJyb3dzZXJDb2x1bW5zLlNvcnRpbmdSDHNvcnRpbmdDYXJkcxJICg1zb3J0aW5nX2'
    '5vdGVzGAkgASgOMiMuYW5raS5zZWFyY2guQnJvd3NlckNvbHVtbnMuU29ydGluZ1IMc29ydGlu'
    'Z05vdGVzEiQKDnVzZXNfY2VsbF9mb250GAUgASgIUgx1c2VzQ2VsbEZvbnQSQwoJYWxpZ25tZW'
    '50GAYgASgOMiUuYW5raS5zZWFyY2guQnJvd3NlckNvbHVtbnMuQWxpZ25tZW50UglhbGlnbm1l'
    'bnQSLAoSY2FyZHNfbW9kZV90b29sdGlwGAcgASgJUhBjYXJkc01vZGVUb29sdGlwEiwKEm5vdG'
    'VzX21vZGVfdG9vbHRpcBgIIAEoCVIQbm90ZXNNb2RlVG9vbHRpcCJKCgdTb3J0aW5nEhAKDFNP'
    'UlRJTkdfTk9ORRAAEhUKEVNPUlRJTkdfQVNDRU5ESU5HEAESFgoSU09SVElOR19ERVNDRU5ESU'
    '5HEAIiNgoJQWxpZ25tZW50EhMKD0FMSUdOTUVOVF9TVEFSVBAAEhQKEEFMSUdOTUVOVF9DRU5U'
    'RVIQAQ==');

@$core.Deprecated('Use browserRowDescriptor instead')
const BrowserRow$json = {
  '1': 'BrowserRow',
  '2': [
    {
      '1': 'cells',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.search.BrowserRow.Cell',
      '10': 'cells'
    },
    {
      '1': 'color',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.search.BrowserRow.Color',
      '10': 'color'
    },
    {'1': 'font_name', '3': 3, '4': 1, '5': 9, '10': 'fontName'},
    {'1': 'font_size', '3': 4, '4': 1, '5': 13, '10': 'fontSize'},
  ],
  '3': [BrowserRow_Cell$json],
  '4': [BrowserRow_Color$json],
};

@$core.Deprecated('Use browserRowDescriptor instead')
const BrowserRow_Cell$json = {
  '1': 'Cell',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'is_rtl', '3': 2, '4': 1, '5': 8, '10': 'isRtl'},
    {
      '1': 'elide_mode',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.anki.search.BrowserRow.Cell.TextElideMode',
      '10': 'elideMode'
    },
  ],
  '4': [BrowserRow_Cell_TextElideMode$json],
};

@$core.Deprecated('Use browserRowDescriptor instead')
const BrowserRow_Cell_TextElideMode$json = {
  '1': 'TextElideMode',
  '2': [
    {'1': 'ElideLeft', '2': 0},
    {'1': 'ElideRight', '2': 1},
    {'1': 'ElideMiddle', '2': 2},
    {'1': 'ElideNone', '2': 3},
  ],
};

@$core.Deprecated('Use browserRowDescriptor instead')
const BrowserRow_Color$json = {
  '1': 'Color',
  '2': [
    {'1': 'COLOR_DEFAULT', '2': 0},
    {'1': 'COLOR_MARKED', '2': 1},
    {'1': 'COLOR_SUSPENDED', '2': 2},
    {'1': 'COLOR_FLAG_RED', '2': 3},
    {'1': 'COLOR_FLAG_ORANGE', '2': 4},
    {'1': 'COLOR_FLAG_GREEN', '2': 5},
    {'1': 'COLOR_FLAG_BLUE', '2': 6},
    {'1': 'COLOR_FLAG_PINK', '2': 7},
    {'1': 'COLOR_FLAG_TURQUOISE', '2': 8},
    {'1': 'COLOR_FLAG_PURPLE', '2': 9},
    {'1': 'COLOR_BURIED', '2': 10},
  ],
};

/// Descriptor for `BrowserRow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List browserRowDescriptor = $convert.base64Decode(
    'CgpCcm93c2VyUm93EjIKBWNlbGxzGAEgAygLMhwuYW5raS5zZWFyY2guQnJvd3NlclJvdy5DZW'
    'xsUgVjZWxscxIzCgVjb2xvchgCIAEoDjIdLmFua2kuc2VhcmNoLkJyb3dzZXJSb3cuQ29sb3JS'
    'BWNvbG9yEhsKCWZvbnRfbmFtZRgDIAEoCVIIZm9udE5hbWUSGwoJZm9udF9zaXplGAQgASgNUg'
    'hmb250U2l6ZRrMAQoEQ2VsbBISCgR0ZXh0GAEgASgJUgR0ZXh0EhUKBmlzX3J0bBgCIAEoCFIF'
    'aXNSdGwSSQoKZWxpZGVfbW9kZRgDIAEoDjIqLmFua2kuc2VhcmNoLkJyb3dzZXJSb3cuQ2VsbC'
    '5UZXh0RWxpZGVNb2RlUgllbGlkZU1vZGUiTgoNVGV4dEVsaWRlTW9kZRINCglFbGlkZUxlZnQQ'
    'ABIOCgpFbGlkZVJpZ2h0EAESDwoLRWxpZGVNaWRkbGUQAhINCglFbGlkZU5vbmUQAyLvAQoFQ2'
    '9sb3ISEQoNQ09MT1JfREVGQVVMVBAAEhAKDENPTE9SX01BUktFRBABEhMKD0NPTE9SX1NVU1BF'
    'TkRFRBACEhIKDkNPTE9SX0ZMQUdfUkVEEAMSFQoRQ09MT1JfRkxBR19PUkFOR0UQBBIUChBDT0'
    'xPUl9GTEFHX0dSRUVOEAUSEwoPQ09MT1JfRkxBR19CTFVFEAYSEwoPQ09MT1JfRkxBR19QSU5L'
    'EAcSGAoUQ09MT1JfRkxBR19UVVJRVU9JU0UQCBIVChFDT0xPUl9GTEFHX1BVUlBMRRAJEhAKDE'
    'NPTE9SX0JVUklFRBAK');

const $core.Map<$core.String, $core.dynamic> SearchServiceBase$json = {
  '1': 'SearchService',
  '2': [
    {
      '1': 'BuildSearchString',
      '2': '.anki.search.SearchNode',
      '3': '.anki.generic.String'
    },
    {
      '1': 'SearchCards',
      '2': '.anki.search.SearchRequest',
      '3': '.anki.search.SearchResponse'
    },
    {
      '1': 'SearchNotes',
      '2': '.anki.search.SearchRequest',
      '3': '.anki.search.SearchResponse'
    },
    {
      '1': 'JoinSearchNodes',
      '2': '.anki.search.JoinSearchNodesRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'ReplaceSearchNode',
      '2': '.anki.search.ReplaceSearchNodeRequest',
      '3': '.anki.generic.String'
    },
    {
      '1': 'FindAndReplace',
      '2': '.anki.search.FindAndReplaceRequest',
      '3': '.anki.collection.OpChangesWithCount'
    },
    {
      '1': 'AllBrowserColumns',
      '2': '.anki.generic.Empty',
      '3': '.anki.search.BrowserColumns'
    },
    {
      '1': 'BrowserRowForId',
      '2': '.anki.generic.Int64',
      '3': '.anki.search.BrowserRow'
    },
    {
      '1': 'SetActiveBrowserColumns',
      '2': '.anki.generic.StringList',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use searchServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SearchServiceBase$messageJson = {
  '.anki.search.SearchNode': SearchNode$json,
  '.anki.search.SearchNode.Group': SearchNode_Group$json,
  '.anki.search.SearchNode.Dupe': SearchNode_Dupe$json,
  '.anki.search.SearchNode.Rated': SearchNode_Rated$json,
  '.anki.search.SearchNode.IdList': SearchNode_IdList$json,
  '.anki.search.SearchNode.Field': SearchNode_Field$json,
  '.anki.generic.String': $0.String$json,
  '.anki.search.SearchRequest': SearchRequest$json,
  '.anki.search.SortOrder': SortOrder$json,
  '.anki.generic.Empty': $0.Empty$json,
  '.anki.search.SortOrder.Builtin': SortOrder_Builtin$json,
  '.anki.search.SearchResponse': SearchResponse$json,
  '.anki.search.JoinSearchNodesRequest': JoinSearchNodesRequest$json,
  '.anki.search.ReplaceSearchNodeRequest': ReplaceSearchNodeRequest$json,
  '.anki.search.FindAndReplaceRequest': FindAndReplaceRequest$json,
  '.anki.collection.OpChangesWithCount': $1.OpChangesWithCount$json,
  '.anki.collection.OpChanges': $1.OpChanges$json,
  '.anki.search.BrowserColumns': BrowserColumns$json,
  '.anki.search.BrowserColumns.Column': BrowserColumns_Column$json,
  '.anki.generic.Int64': $0.Int64$json,
  '.anki.search.BrowserRow': BrowserRow$json,
  '.anki.search.BrowserRow.Cell': BrowserRow_Cell$json,
  '.anki.generic.StringList': $0.StringList$json,
};

/// Descriptor for `SearchService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List searchServiceDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hTZXJ2aWNlEkIKEUJ1aWxkU2VhcmNoU3RyaW5nEhcuYW5raS5zZWFyY2guU2Vhcm'
    'NoTm9kZRoULmFua2kuZ2VuZXJpYy5TdHJpbmcSRgoLU2VhcmNoQ2FyZHMSGi5hbmtpLnNlYXJj'
    'aC5TZWFyY2hSZXF1ZXN0GhsuYW5raS5zZWFyY2guU2VhcmNoUmVzcG9uc2USRgoLU2VhcmNoTm'
    '90ZXMSGi5hbmtpLnNlYXJjaC5TZWFyY2hSZXF1ZXN0GhsuYW5raS5zZWFyY2guU2VhcmNoUmVz'
    'cG9uc2USTAoPSm9pblNlYXJjaE5vZGVzEiMuYW5raS5zZWFyY2guSm9pblNlYXJjaE5vZGVzUm'
    'VxdWVzdBoULmFua2kuZ2VuZXJpYy5TdHJpbmcSUAoRUmVwbGFjZVNlYXJjaE5vZGUSJS5hbmtp'
    'LnNlYXJjaC5SZXBsYWNlU2VhcmNoTm9kZVJlcXVlc3QaFC5hbmtpLmdlbmVyaWMuU3RyaW5nEl'
    'kKDkZpbmRBbmRSZXBsYWNlEiIuYW5raS5zZWFyY2guRmluZEFuZFJlcGxhY2VSZXF1ZXN0GiMu'
    'YW5raS5jb2xsZWN0aW9uLk9wQ2hhbmdlc1dpdGhDb3VudBJFChFBbGxCcm93c2VyQ29sdW1ucx'
    'ITLmFua2kuZ2VuZXJpYy5FbXB0eRobLmFua2kuc2VhcmNoLkJyb3dzZXJDb2x1bW5zEj8KD0Jy'
    'b3dzZXJSb3dGb3JJZBITLmFua2kuZ2VuZXJpYy5JbnQ2NBoXLmFua2kuc2VhcmNoLkJyb3dzZX'
    'JSb3cSSAoXU2V0QWN0aXZlQnJvd3NlckNvbHVtbnMSGC5hbmtpLmdlbmVyaWMuU3RyaW5nTGlz'
    'dBoTLmFua2kuZ2VuZXJpYy5FbXB0eQ==');

const $core.Map<$core.String, $core.dynamic> BackendSearchServiceBase$json = {
  '1': 'BackendSearchService'
};

@$core.Deprecated('Use backendSearchServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendSearchServiceBase$messageJson = {};

/// Descriptor for `BackendSearchService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendSearchServiceDescriptor =
    $convert.base64Decode('ChRCYWNrZW5kU2VhcmNoU2VydmljZQ==');
