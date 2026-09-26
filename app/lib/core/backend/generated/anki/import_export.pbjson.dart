// This is a generated file - do not edit.
//
// Generated from anki/import_export.proto.

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

import 'cards.pbjson.dart' as $3;
import 'collection.pbjson.dart' as $0;
import 'generic.pbjson.dart' as $2;
import 'notes.pbjson.dart' as $1;

@$core.Deprecated('Use importAnkiPackageUpdateConditionDescriptor instead')
const ImportAnkiPackageUpdateCondition$json = {
  '1': 'ImportAnkiPackageUpdateCondition',
  '2': [
    {'1': 'IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER', '2': 0},
    {'1': 'IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_ALWAYS', '2': 1},
    {'1': 'IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_NEVER', '2': 2},
  ],
};

/// Descriptor for `ImportAnkiPackageUpdateCondition`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List importAnkiPackageUpdateConditionDescriptor =
    $convert.base64Decode(
        'CiBJbXBvcnRBbmtpUGFja2FnZVVwZGF0ZUNvbmRpdGlvbhIxCi1JTVBPUlRfQU5LSV9QQUNLQU'
        'dFX1VQREFURV9DT05ESVRJT05fSUZfTkVXRVIQABIvCitJTVBPUlRfQU5LSV9QQUNLQUdFX1VQ'
        'REFURV9DT05ESVRJT05fQUxXQVlTEAESLgoqSU1QT1JUX0FOS0lfUEFDS0FHRV9VUERBVEVfQ0'
        '9ORElUSU9OX05FVkVSEAI=');

@$core.Deprecated('Use importCollectionPackageRequestDescriptor instead')
const ImportCollectionPackageRequest$json = {
  '1': 'ImportCollectionPackageRequest',
  '2': [
    {'1': 'col_path', '3': 1, '4': 1, '5': 9, '10': 'colPath'},
    {'1': 'backup_path', '3': 2, '4': 1, '5': 9, '10': 'backupPath'},
    {'1': 'media_folder', '3': 3, '4': 1, '5': 9, '10': 'mediaFolder'},
    {'1': 'media_db', '3': 4, '4': 1, '5': 9, '10': 'mediaDb'},
  ],
};

/// Descriptor for `ImportCollectionPackageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importCollectionPackageRequestDescriptor =
    $convert.base64Decode(
        'Ch5JbXBvcnRDb2xsZWN0aW9uUGFja2FnZVJlcXVlc3QSGQoIY29sX3BhdGgYASABKAlSB2NvbF'
        'BhdGgSHwoLYmFja3VwX3BhdGgYAiABKAlSCmJhY2t1cFBhdGgSIQoMbWVkaWFfZm9sZGVyGAMg'
        'ASgJUgttZWRpYUZvbGRlchIZCghtZWRpYV9kYhgEIAEoCVIHbWVkaWFEYg==');

@$core.Deprecated('Use exportCollectionPackageRequestDescriptor instead')
const ExportCollectionPackageRequest$json = {
  '1': 'ExportCollectionPackageRequest',
  '2': [
    {'1': 'out_path', '3': 1, '4': 1, '5': 9, '10': 'outPath'},
    {'1': 'include_media', '3': 2, '4': 1, '5': 8, '10': 'includeMedia'},
    {'1': 'legacy', '3': 3, '4': 1, '5': 8, '10': 'legacy'},
  ],
};

/// Descriptor for `ExportCollectionPackageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportCollectionPackageRequestDescriptor =
    $convert.base64Decode(
        'Ch5FeHBvcnRDb2xsZWN0aW9uUGFja2FnZVJlcXVlc3QSGQoIb3V0X3BhdGgYASABKAlSB291dF'
        'BhdGgSIwoNaW5jbHVkZV9tZWRpYRgCIAEoCFIMaW5jbHVkZU1lZGlhEhYKBmxlZ2FjeRgDIAEo'
        'CFIGbGVnYWN5');

@$core.Deprecated('Use importAnkiPackageOptionsDescriptor instead')
const ImportAnkiPackageOptions$json = {
  '1': 'ImportAnkiPackageOptions',
  '2': [
    {'1': 'merge_notetypes', '3': 1, '4': 1, '5': 8, '10': 'mergeNotetypes'},
    {
      '1': 'update_notes',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.ImportAnkiPackageUpdateCondition',
      '10': 'updateNotes'
    },
    {
      '1': 'update_notetypes',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.ImportAnkiPackageUpdateCondition',
      '10': 'updateNotetypes'
    },
    {'1': 'with_scheduling', '3': 4, '4': 1, '5': 8, '10': 'withScheduling'},
    {'1': 'with_deck_configs', '3': 5, '4': 1, '5': 8, '10': 'withDeckConfigs'},
  ],
};

/// Descriptor for `ImportAnkiPackageOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importAnkiPackageOptionsDescriptor = $convert.base64Decode(
    'ChhJbXBvcnRBbmtpUGFja2FnZU9wdGlvbnMSJwoPbWVyZ2Vfbm90ZXR5cGVzGAEgASgIUg5tZX'
    'JnZU5vdGV0eXBlcxJXCgx1cGRhdGVfbm90ZXMYAiABKA4yNC5hbmtpLmltcG9ydF9leHBvcnQu'
    'SW1wb3J0QW5raVBhY2thZ2VVcGRhdGVDb25kaXRpb25SC3VwZGF0ZU5vdGVzEl8KEHVwZGF0ZV'
    '9ub3RldHlwZXMYAyABKA4yNC5hbmtpLmltcG9ydF9leHBvcnQuSW1wb3J0QW5raVBhY2thZ2VV'
    'cGRhdGVDb25kaXRpb25SD3VwZGF0ZU5vdGV0eXBlcxInCg93aXRoX3NjaGVkdWxpbmcYBCABKA'
    'hSDndpdGhTY2hlZHVsaW5nEioKEXdpdGhfZGVja19jb25maWdzGAUgASgIUg93aXRoRGVja0Nv'
    'bmZpZ3M=');

@$core.Deprecated('Use importAnkiPackageRequestDescriptor instead')
const ImportAnkiPackageRequest$json = {
  '1': 'ImportAnkiPackageRequest',
  '2': [
    {'1': 'package_path', '3': 1, '4': 1, '5': 9, '10': 'packagePath'},
    {
      '1': 'options',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.ImportAnkiPackageOptions',
      '10': 'options'
    },
  ],
};

/// Descriptor for `ImportAnkiPackageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importAnkiPackageRequestDescriptor = $convert.base64Decode(
    'ChhJbXBvcnRBbmtpUGFja2FnZVJlcXVlc3QSIQoMcGFja2FnZV9wYXRoGAEgASgJUgtwYWNrYW'
    'dlUGF0aBJGCgdvcHRpb25zGAIgASgLMiwuYW5raS5pbXBvcnRfZXhwb3J0LkltcG9ydEFua2lQ'
    'YWNrYWdlT3B0aW9uc1IHb3B0aW9ucw==');

@$core.Deprecated('Use importResponseDescriptor instead')
const ImportResponse$json = {
  '1': 'ImportResponse',
  '2': [
    {
      '1': 'changes',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.collection.OpChanges',
      '10': 'changes'
    },
    {
      '1': 'log',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Log',
      '10': 'log'
    },
  ],
  '3': [ImportResponse_Note$json, ImportResponse_Log$json],
};

@$core.Deprecated('Use importResponseDescriptor instead')
const ImportResponse_Note$json = {
  '1': 'Note',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.anki.notes.NoteId', '10': 'id'},
    {'1': 'fields', '3': 2, '4': 3, '5': 9, '10': 'fields'},
  ],
};

@$core.Deprecated('Use importResponseDescriptor instead')
const ImportResponse_Log$json = {
  '1': 'Log',
  '2': [
    {
      '1': 'new',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'new'
    },
    {
      '1': 'updated',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'updated'
    },
    {
      '1': 'duplicate',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'duplicate'
    },
    {
      '1': 'conflicting',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'conflicting'
    },
    {
      '1': 'first_field_match',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'firstFieldMatch'
    },
    {
      '1': 'missing_notetype',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'missingNotetype'
    },
    {
      '1': 'missing_deck',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'missingDeck'
    },
    {
      '1': 'empty_first_field',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.ImportResponse.Note',
      '10': 'emptyFirstField'
    },
    {
      '1': 'dupe_resolution',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.CsvMetadata.DupeResolution',
      '10': 'dupeResolution'
    },
    {'1': 'found_notes', '3': 10, '4': 1, '5': 13, '10': 'foundNotes'},
  ],
};

/// Descriptor for `ImportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importResponseDescriptor = $convert.base64Decode(
    'Cg5JbXBvcnRSZXNwb25zZRI0CgdjaGFuZ2VzGAEgASgLMhouYW5raS5jb2xsZWN0aW9uLk9wQ2'
    'hhbmdlc1IHY2hhbmdlcxI4CgNsb2cYAiABKAsyJi5hbmtpLmltcG9ydF9leHBvcnQuSW1wb3J0'
    'UmVzcG9uc2UuTG9nUgNsb2caQgoETm90ZRIiCgJpZBgBIAEoCzISLmFua2kubm90ZXMuTm90ZU'
    'lkUgJpZBIWCgZmaWVsZHMYAiADKAlSBmZpZWxkcxrZBQoDTG9nEjkKA25ldxgBIAMoCzInLmFu'
    'a2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRSZXNwb25zZS5Ob3RlUgNuZXcSQQoHdXBkYXRlZBgCIA'
    'MoCzInLmFua2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRSZXNwb25zZS5Ob3RlUgd1cGRhdGVkEkUK'
    'CWR1cGxpY2F0ZRgDIAMoCzInLmFua2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRSZXNwb25zZS5Ob3'
    'RlUglkdXBsaWNhdGUSSQoLY29uZmxpY3RpbmcYBCADKAsyJy5hbmtpLmltcG9ydF9leHBvcnQu'
    'SW1wb3J0UmVzcG9uc2UuTm90ZVILY29uZmxpY3RpbmcSUwoRZmlyc3RfZmllbGRfbWF0Y2gYBS'
    'ADKAsyJy5hbmtpLmltcG9ydF9leHBvcnQuSW1wb3J0UmVzcG9uc2UuTm90ZVIPZmlyc3RGaWVs'
    'ZE1hdGNoElIKEG1pc3Npbmdfbm90ZXR5cGUYBiADKAsyJy5hbmtpLmltcG9ydF9leHBvcnQuSW'
    '1wb3J0UmVzcG9uc2UuTm90ZVIPbWlzc2luZ05vdGV0eXBlEkoKDG1pc3NpbmdfZGVjaxgHIAMo'
    'CzInLmFua2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRSZXNwb25zZS5Ob3RlUgttaXNzaW5nRGVjax'
    'JTChFlbXB0eV9maXJzdF9maWVsZBgIIAMoCzInLmFua2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRS'
    'ZXNwb25zZS5Ob3RlUg9lbXB0eUZpcnN0RmllbGQSVwoPZHVwZV9yZXNvbHV0aW9uGAkgASgOMi'
    '4uYW5raS5pbXBvcnRfZXhwb3J0LkNzdk1ldGFkYXRhLkR1cGVSZXNvbHV0aW9uUg5kdXBlUmVz'
    'b2x1dGlvbhIfCgtmb3VuZF9ub3RlcxgKIAEoDVIKZm91bmROb3Rlcw==');

@$core.Deprecated('Use exportAnkiPackageRequestDescriptor instead')
const ExportAnkiPackageRequest$json = {
  '1': 'ExportAnkiPackageRequest',
  '2': [
    {'1': 'out_path', '3': 1, '4': 1, '5': 9, '10': 'outPath'},
    {
      '1': 'options',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.ExportAnkiPackageOptions',
      '10': 'options'
    },
    {
      '1': 'limit',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.ExportLimit',
      '10': 'limit'
    },
  ],
};

/// Descriptor for `ExportAnkiPackageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportAnkiPackageRequestDescriptor = $convert.base64Decode(
    'ChhFeHBvcnRBbmtpUGFja2FnZVJlcXVlc3QSGQoIb3V0X3BhdGgYASABKAlSB291dFBhdGgSRg'
    'oHb3B0aW9ucxgCIAEoCzIsLmFua2kuaW1wb3J0X2V4cG9ydC5FeHBvcnRBbmtpUGFja2FnZU9w'
    'dGlvbnNSB29wdGlvbnMSNQoFbGltaXQYAyABKAsyHy5hbmtpLmltcG9ydF9leHBvcnQuRXhwb3'
    'J0TGltaXRSBWxpbWl0');

@$core.Deprecated('Use exportAnkiPackageOptionsDescriptor instead')
const ExportAnkiPackageOptions$json = {
  '1': 'ExportAnkiPackageOptions',
  '2': [
    {'1': 'with_scheduling', '3': 1, '4': 1, '5': 8, '10': 'withScheduling'},
    {'1': 'with_deck_configs', '3': 2, '4': 1, '5': 8, '10': 'withDeckConfigs'},
    {'1': 'with_media', '3': 3, '4': 1, '5': 8, '10': 'withMedia'},
    {'1': 'legacy', '3': 4, '4': 1, '5': 8, '10': 'legacy'},
  ],
};

/// Descriptor for `ExportAnkiPackageOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportAnkiPackageOptionsDescriptor = $convert.base64Decode(
    'ChhFeHBvcnRBbmtpUGFja2FnZU9wdGlvbnMSJwoPd2l0aF9zY2hlZHVsaW5nGAEgASgIUg53aX'
    'RoU2NoZWR1bGluZxIqChF3aXRoX2RlY2tfY29uZmlncxgCIAEoCFIPd2l0aERlY2tDb25maWdz'
    'Eh0KCndpdGhfbWVkaWEYAyABKAhSCXdpdGhNZWRpYRIWCgZsZWdhY3kYBCABKAhSBmxlZ2FjeQ'
    '==');

@$core.Deprecated('Use packageMetadataDescriptor instead')
const PackageMetadata$json = {
  '1': 'PackageMetadata',
  '2': [
    {
      '1': 'version',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.PackageMetadata.Version',
      '10': 'version'
    },
  ],
  '4': [PackageMetadata_Version$json],
};

@$core.Deprecated('Use packageMetadataDescriptor instead')
const PackageMetadata_Version$json = {
  '1': 'Version',
  '2': [
    {'1': 'VERSION_UNKNOWN', '2': 0},
    {'1': 'VERSION_LEGACY_1', '2': 1},
    {'1': 'VERSION_LEGACY_2', '2': 2},
    {'1': 'VERSION_LATEST', '2': 3},
  ],
};

/// Descriptor for `PackageMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageMetadataDescriptor = $convert.base64Decode(
    'Cg9QYWNrYWdlTWV0YWRhdGESRQoHdmVyc2lvbhgBIAEoDjIrLmFua2kuaW1wb3J0X2V4cG9ydC'
    '5QYWNrYWdlTWV0YWRhdGEuVmVyc2lvblIHdmVyc2lvbiJeCgdWZXJzaW9uEhMKD1ZFUlNJT05f'
    'VU5LTk9XThAAEhQKEFZFUlNJT05fTEVHQUNZXzEQARIUChBWRVJTSU9OX0xFR0FDWV8yEAISEg'
    'oOVkVSU0lPTl9MQVRFU1QQAw==');

@$core.Deprecated('Use mediaEntriesDescriptor instead')
const MediaEntries$json = {
  '1': 'MediaEntries',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.anki.import_export.MediaEntries.MediaEntry',
      '10': 'entries'
    },
  ],
  '3': [MediaEntries_MediaEntry$json],
};

@$core.Deprecated('Use mediaEntriesDescriptor instead')
const MediaEntries_MediaEntry$json = {
  '1': 'MediaEntry',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'size', '3': 2, '4': 1, '5': 13, '10': 'size'},
    {'1': 'sha1', '3': 3, '4': 1, '5': 12, '10': 'sha1'},
    {
      '1': 'legacy_zip_filename',
      '3': 255,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'legacyZipFilename',
      '17': true
    },
  ],
  '8': [
    {'1': '_legacy_zip_filename'},
  ],
};

/// Descriptor for `MediaEntries`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaEntriesDescriptor = $convert.base64Decode(
    'CgxNZWRpYUVudHJpZXMSRQoHZW50cmllcxgBIAMoCzIrLmFua2kuaW1wb3J0X2V4cG9ydC5NZW'
    'RpYUVudHJpZXMuTWVkaWFFbnRyeVIHZW50cmllcxqWAQoKTWVkaWFFbnRyeRISCgRuYW1lGAEg'
    'ASgJUgRuYW1lEhIKBHNpemUYAiABKA1SBHNpemUSEgoEc2hhMRgDIAEoDFIEc2hhMRI0ChNsZW'
    'dhY3lfemlwX2ZpbGVuYW1lGP8BIAEoDUgAUhFsZWdhY3laaXBGaWxlbmFtZYgBAUIWChRfbGVn'
    'YWN5X3ppcF9maWxlbmFtZQ==');

@$core.Deprecated('Use importCsvRequestDescriptor instead')
const ImportCsvRequest$json = {
  '1': 'ImportCsvRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {
      '1': 'metadata',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.CsvMetadata',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `ImportCsvRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importCsvRequestDescriptor = $convert.base64Decode(
    'ChBJbXBvcnRDc3ZSZXF1ZXN0EhIKBHBhdGgYASABKAlSBHBhdGgSOwoIbWV0YWRhdGEYAiABKA'
    'syHy5hbmtpLmltcG9ydF9leHBvcnQuQ3N2TWV0YWRhdGFSCG1ldGFkYXRh');

@$core.Deprecated('Use csvMetadataRequestDescriptor instead')
const CsvMetadataRequest$json = {
  '1': 'CsvMetadataRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {
      '1': 'delimiter',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.CsvMetadata.Delimiter',
      '9': 0,
      '10': 'delimiter',
      '17': true
    },
    {
      '1': 'notetype_id',
      '3': 3,
      '4': 1,
      '5': 3,
      '9': 1,
      '10': 'notetypeId',
      '17': true
    },
    {
      '1': 'deck_id',
      '3': 4,
      '4': 1,
      '5': 3,
      '9': 2,
      '10': 'deckId',
      '17': true
    },
    {
      '1': 'is_html',
      '3': 5,
      '4': 1,
      '5': 8,
      '9': 3,
      '10': 'isHtml',
      '17': true
    },
  ],
  '8': [
    {'1': '_delimiter'},
    {'1': '_notetype_id'},
    {'1': '_deck_id'},
    {'1': '_is_html'},
  ],
};

/// Descriptor for `CsvMetadataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List csvMetadataRequestDescriptor = $convert.base64Decode(
    'ChJDc3ZNZXRhZGF0YVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBJMCglkZWxpbWl0ZXIYAi'
    'ABKA4yKS5hbmtpLmltcG9ydF9leHBvcnQuQ3N2TWV0YWRhdGEuRGVsaW1pdGVySABSCWRlbGlt'
    'aXRlcogBARIkCgtub3RldHlwZV9pZBgDIAEoA0gBUgpub3RldHlwZUlkiAEBEhwKB2RlY2tfaW'
    'QYBCABKANIAlIGZGVja0lkiAEBEhwKB2lzX2h0bWwYBSABKAhIA1IGaXNIdG1siAEBQgwKCl9k'
    'ZWxpbWl0ZXJCDgoMX25vdGV0eXBlX2lkQgoKCF9kZWNrX2lkQgoKCF9pc19odG1s');

@$core.Deprecated('Use csvMetadataDescriptor instead')
const CsvMetadata$json = {
  '1': 'CsvMetadata',
  '2': [
    {
      '1': 'delimiter',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.CsvMetadata.Delimiter',
      '10': 'delimiter'
    },
    {'1': 'is_html', '3': 2, '4': 1, '5': 8, '10': 'isHtml'},
    {'1': 'global_tags', '3': 3, '4': 3, '5': 9, '10': 'globalTags'},
    {'1': 'updated_tags', '3': 4, '4': 3, '5': 9, '10': 'updatedTags'},
    {'1': 'column_labels', '3': 5, '4': 3, '5': 9, '10': 'columnLabels'},
    {'1': 'deck_id', '3': 6, '4': 1, '5': 3, '9': 0, '10': 'deckId'},
    {'1': 'deck_column', '3': 7, '4': 1, '5': 13, '9': 0, '10': 'deckColumn'},
    {'1': 'deck_name', '3': 17, '4': 1, '5': 9, '9': 0, '10': 'deckName'},
    {
      '1': 'global_notetype',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.CsvMetadata.MappedNotetype',
      '9': 1,
      '10': 'globalNotetype'
    },
    {
      '1': 'notetype_column',
      '3': 9,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'notetypeColumn'
    },
    {'1': 'tags_column', '3': 10, '4': 1, '5': 13, '10': 'tagsColumn'},
    {'1': 'force_delimiter', '3': 11, '4': 1, '5': 8, '10': 'forceDelimiter'},
    {'1': 'force_is_html', '3': 12, '4': 1, '5': 8, '10': 'forceIsHtml'},
    {
      '1': 'preview',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.anki.generic.StringList',
      '10': 'preview'
    },
    {'1': 'guid_column', '3': 14, '4': 1, '5': 13, '10': 'guidColumn'},
    {
      '1': 'dupe_resolution',
      '3': 15,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.CsvMetadata.DupeResolution',
      '10': 'dupeResolution'
    },
    {
      '1': 'match_scope',
      '3': 16,
      '4': 1,
      '5': 14,
      '6': '.anki.import_export.CsvMetadata.MatchScope',
      '10': 'matchScope'
    },
  ],
  '3': [CsvMetadata_MappedNotetype$json],
  '4': [
    CsvMetadata_DupeResolution$json,
    CsvMetadata_Delimiter$json,
    CsvMetadata_MatchScope$json
  ],
  '8': [
    {'1': 'deck'},
    {'1': 'notetype'},
  ],
};

@$core.Deprecated('Use csvMetadataDescriptor instead')
const CsvMetadata_MappedNotetype$json = {
  '1': 'MappedNotetype',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'field_columns', '3': 2, '4': 3, '5': 13, '10': 'fieldColumns'},
  ],
};

@$core.Deprecated('Use csvMetadataDescriptor instead')
const CsvMetadata_DupeResolution$json = {
  '1': 'DupeResolution',
  '2': [
    {'1': 'UPDATE', '2': 0},
    {'1': 'PRESERVE', '2': 1},
    {'1': 'DUPLICATE', '2': 2},
  ],
};

@$core.Deprecated('Use csvMetadataDescriptor instead')
const CsvMetadata_Delimiter$json = {
  '1': 'Delimiter',
  '2': [
    {'1': 'TAB', '2': 0},
    {'1': 'PIPE', '2': 1},
    {'1': 'SEMICOLON', '2': 2},
    {'1': 'COLON', '2': 3},
    {'1': 'COMMA', '2': 4},
    {'1': 'SPACE', '2': 5},
  ],
};

@$core.Deprecated('Use csvMetadataDescriptor instead')
const CsvMetadata_MatchScope$json = {
  '1': 'MatchScope',
  '2': [
    {'1': 'NOTETYPE', '2': 0},
    {'1': 'NOTETYPE_AND_DECK', '2': 1},
  ],
};

/// Descriptor for `CsvMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List csvMetadataDescriptor = $convert.base64Decode(
    'CgtDc3ZNZXRhZGF0YRJHCglkZWxpbWl0ZXIYASABKA4yKS5hbmtpLmltcG9ydF9leHBvcnQuQ3'
    'N2TWV0YWRhdGEuRGVsaW1pdGVyUglkZWxpbWl0ZXISFwoHaXNfaHRtbBgCIAEoCFIGaXNIdG1s'
    'Eh8KC2dsb2JhbF90YWdzGAMgAygJUgpnbG9iYWxUYWdzEiEKDHVwZGF0ZWRfdGFncxgEIAMoCV'
    'ILdXBkYXRlZFRhZ3MSIwoNY29sdW1uX2xhYmVscxgFIAMoCVIMY29sdW1uTGFiZWxzEhkKB2Rl'
    'Y2tfaWQYBiABKANIAFIGZGVja0lkEiEKC2RlY2tfY29sdW1uGAcgASgNSABSCmRlY2tDb2x1bW'
    '4SHQoJZGVja19uYW1lGBEgASgJSABSCGRlY2tOYW1lElkKD2dsb2JhbF9ub3RldHlwZRgIIAEo'
    'CzIuLmFua2kuaW1wb3J0X2V4cG9ydC5Dc3ZNZXRhZGF0YS5NYXBwZWROb3RldHlwZUgBUg5nbG'
    '9iYWxOb3RldHlwZRIpCg9ub3RldHlwZV9jb2x1bW4YCSABKA1IAVIObm90ZXR5cGVDb2x1bW4S'
    'HwoLdGFnc19jb2x1bW4YCiABKA1SCnRhZ3NDb2x1bW4SJwoPZm9yY2VfZGVsaW1pdGVyGAsgAS'
    'gIUg5mb3JjZURlbGltaXRlchIiCg1mb3JjZV9pc19odG1sGAwgASgIUgtmb3JjZUlzSHRtbBIy'
    'CgdwcmV2aWV3GA0gAygLMhguYW5raS5nZW5lcmljLlN0cmluZ0xpc3RSB3ByZXZpZXcSHwoLZ3'
    'VpZF9jb2x1bW4YDiABKA1SCmd1aWRDb2x1bW4SVwoPZHVwZV9yZXNvbHV0aW9uGA8gASgOMi4u'
    'YW5raS5pbXBvcnRfZXhwb3J0LkNzdk1ldGFkYXRhLkR1cGVSZXNvbHV0aW9uUg5kdXBlUmVzb2'
    'x1dGlvbhJLCgttYXRjaF9zY29wZRgQIAEoDjIqLmFua2kuaW1wb3J0X2V4cG9ydC5Dc3ZNZXRh'
    'ZGF0YS5NYXRjaFNjb3BlUgptYXRjaFNjb3BlGkUKDk1hcHBlZE5vdGV0eXBlEg4KAmlkGAEgAS'
    'gDUgJpZBIjCg1maWVsZF9jb2x1bW5zGAIgAygNUgxmaWVsZENvbHVtbnMiOQoORHVwZVJlc29s'
    'dXRpb24SCgoGVVBEQVRFEAASDAoIUFJFU0VSVkUQARINCglEVVBMSUNBVEUQAiJOCglEZWxpbW'
    'l0ZXISBwoDVEFCEAASCAoEUElQRRABEg0KCVNFTUlDT0xPThACEgkKBUNPTE9OEAMSCQoFQ09N'
    'TUEQBBIJCgVTUEFDRRAFIjEKCk1hdGNoU2NvcGUSDAoITk9URVRZUEUQABIVChFOT1RFVFlQRV'
    '9BTkRfREVDSxABQgYKBGRlY2tCCgoIbm90ZXR5cGU=');

@$core.Deprecated('Use exportCardCsvRequestDescriptor instead')
const ExportCardCsvRequest$json = {
  '1': 'ExportCardCsvRequest',
  '2': [
    {'1': 'out_path', '3': 1, '4': 1, '5': 9, '10': 'outPath'},
    {'1': 'with_html', '3': 2, '4': 1, '5': 8, '10': 'withHtml'},
    {
      '1': 'limit',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.ExportLimit',
      '10': 'limit'
    },
  ],
};

/// Descriptor for `ExportCardCsvRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportCardCsvRequestDescriptor = $convert.base64Decode(
    'ChRFeHBvcnRDYXJkQ3N2UmVxdWVzdBIZCghvdXRfcGF0aBgBIAEoCVIHb3V0UGF0aBIbCgl3aX'
    'RoX2h0bWwYAiABKAhSCHdpdGhIdG1sEjUKBWxpbWl0GAMgASgLMh8uYW5raS5pbXBvcnRfZXhw'
    'b3J0LkV4cG9ydExpbWl0UgVsaW1pdA==');

@$core.Deprecated('Use exportNoteCsvRequestDescriptor instead')
const ExportNoteCsvRequest$json = {
  '1': 'ExportNoteCsvRequest',
  '2': [
    {'1': 'out_path', '3': 1, '4': 1, '5': 9, '10': 'outPath'},
    {'1': 'with_html', '3': 2, '4': 1, '5': 8, '10': 'withHtml'},
    {'1': 'with_tags', '3': 3, '4': 1, '5': 8, '10': 'withTags'},
    {'1': 'with_deck', '3': 4, '4': 1, '5': 8, '10': 'withDeck'},
    {'1': 'with_notetype', '3': 5, '4': 1, '5': 8, '10': 'withNotetype'},
    {'1': 'with_guid', '3': 6, '4': 1, '5': 8, '10': 'withGuid'},
    {
      '1': 'limit',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.anki.import_export.ExportLimit',
      '10': 'limit'
    },
  ],
};

/// Descriptor for `ExportNoteCsvRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportNoteCsvRequestDescriptor = $convert.base64Decode(
    'ChRFeHBvcnROb3RlQ3N2UmVxdWVzdBIZCghvdXRfcGF0aBgBIAEoCVIHb3V0UGF0aBIbCgl3aX'
    'RoX2h0bWwYAiABKAhSCHdpdGhIdG1sEhsKCXdpdGhfdGFncxgDIAEoCFIId2l0aFRhZ3MSGwoJ'
    'd2l0aF9kZWNrGAQgASgIUgh3aXRoRGVjaxIjCg13aXRoX25vdGV0eXBlGAUgASgIUgx3aXRoTm'
    '90ZXR5cGUSGwoJd2l0aF9ndWlkGAYgASgIUgh3aXRoR3VpZBI1CgVsaW1pdBgHIAEoCzIfLmFu'
    'a2kuaW1wb3J0X2V4cG9ydC5FeHBvcnRMaW1pdFIFbGltaXQ=');

@$core.Deprecated('Use exportLimitDescriptor instead')
const ExportLimit$json = {
  '1': 'ExportLimit',
  '2': [
    {
      '1': 'whole_collection',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.anki.generic.Empty',
      '9': 0,
      '10': 'wholeCollection'
    },
    {'1': 'deck_id', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'deckId'},
    {
      '1': 'note_ids',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.anki.notes.NoteIds',
      '9': 0,
      '10': 'noteIds'
    },
    {
      '1': 'card_ids',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.anki.cards.CardIds',
      '9': 0,
      '10': 'cardIds'
    },
  ],
  '8': [
    {'1': 'limit'},
  ],
};

/// Descriptor for `ExportLimit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportLimitDescriptor = $convert.base64Decode(
    'CgtFeHBvcnRMaW1pdBJAChB3aG9sZV9jb2xsZWN0aW9uGAEgASgLMhMuYW5raS5nZW5lcmljLk'
    'VtcHR5SABSD3dob2xlQ29sbGVjdGlvbhIZCgdkZWNrX2lkGAIgASgDSABSBmRlY2tJZBIwCghu'
    'b3RlX2lkcxgDIAEoCzITLmFua2kubm90ZXMuTm90ZUlkc0gAUgdub3RlSWRzEjAKCGNhcmRfaW'
    'RzGAQgASgLMhMuYW5raS5jYXJkcy5DYXJkSWRzSABSB2NhcmRJZHNCBwoFbGltaXQ=');

const $core.Map<$core.String, $core.dynamic> ImportExportServiceBase$json = {
  '1': 'ImportExportService',
  '2': [
    {
      '1': 'ImportAnkiPackage',
      '2': '.anki.import_export.ImportAnkiPackageRequest',
      '3': '.anki.import_export.ImportResponse'
    },
    {
      '1': 'GetImportAnkiPackagePresets',
      '2': '.anki.generic.Empty',
      '3': '.anki.import_export.ImportAnkiPackageOptions'
    },
    {
      '1': 'ExportAnkiPackage',
      '2': '.anki.import_export.ExportAnkiPackageRequest',
      '3': '.anki.generic.UInt32'
    },
    {
      '1': 'GetCsvMetadata',
      '2': '.anki.import_export.CsvMetadataRequest',
      '3': '.anki.import_export.CsvMetadata'
    },
    {
      '1': 'ImportCsv',
      '2': '.anki.import_export.ImportCsvRequest',
      '3': '.anki.import_export.ImportResponse'
    },
    {
      '1': 'ExportNoteCsv',
      '2': '.anki.import_export.ExportNoteCsvRequest',
      '3': '.anki.generic.UInt32'
    },
    {
      '1': 'ExportCardCsv',
      '2': '.anki.import_export.ExportCardCsvRequest',
      '3': '.anki.generic.UInt32'
    },
    {
      '1': 'ImportJsonFile',
      '2': '.anki.generic.String',
      '3': '.anki.import_export.ImportResponse'
    },
    {
      '1': 'ImportJsonString',
      '2': '.anki.generic.String',
      '3': '.anki.import_export.ImportResponse'
    },
  ],
};

@$core.Deprecated('Use importExportServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ImportExportServiceBase$messageJson = {
  '.anki.import_export.ImportAnkiPackageRequest': ImportAnkiPackageRequest$json,
  '.anki.import_export.ImportAnkiPackageOptions': ImportAnkiPackageOptions$json,
  '.anki.import_export.ImportResponse': ImportResponse$json,
  '.anki.collection.OpChanges': $0.OpChanges$json,
  '.anki.import_export.ImportResponse.Log': ImportResponse_Log$json,
  '.anki.import_export.ImportResponse.Note': ImportResponse_Note$json,
  '.anki.notes.NoteId': $1.NoteId$json,
  '.anki.generic.Empty': $2.Empty$json,
  '.anki.import_export.ExportAnkiPackageRequest': ExportAnkiPackageRequest$json,
  '.anki.import_export.ExportAnkiPackageOptions': ExportAnkiPackageOptions$json,
  '.anki.import_export.ExportLimit': ExportLimit$json,
  '.anki.notes.NoteIds': $1.NoteIds$json,
  '.anki.cards.CardIds': $3.CardIds$json,
  '.anki.generic.UInt32': $2.UInt32$json,
  '.anki.import_export.CsvMetadataRequest': CsvMetadataRequest$json,
  '.anki.import_export.CsvMetadata': CsvMetadata$json,
  '.anki.import_export.CsvMetadata.MappedNotetype':
      CsvMetadata_MappedNotetype$json,
  '.anki.generic.StringList': $2.StringList$json,
  '.anki.import_export.ImportCsvRequest': ImportCsvRequest$json,
  '.anki.import_export.ExportNoteCsvRequest': ExportNoteCsvRequest$json,
  '.anki.import_export.ExportCardCsvRequest': ExportCardCsvRequest$json,
  '.anki.generic.String': $2.String$json,
};

/// Descriptor for `ImportExportService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List importExportServiceDescriptor = $convert.base64Decode(
    'ChNJbXBvcnRFeHBvcnRTZXJ2aWNlEmUKEUltcG9ydEFua2lQYWNrYWdlEiwuYW5raS5pbXBvcn'
    'RfZXhwb3J0LkltcG9ydEFua2lQYWNrYWdlUmVxdWVzdBoiLmFua2kuaW1wb3J0X2V4cG9ydC5J'
    'bXBvcnRSZXNwb25zZRJgChtHZXRJbXBvcnRBbmtpUGFja2FnZVByZXNldHMSEy5hbmtpLmdlbm'
    'VyaWMuRW1wdHkaLC5hbmtpLmltcG9ydF9leHBvcnQuSW1wb3J0QW5raVBhY2thZ2VPcHRpb25z'
    'ElcKEUV4cG9ydEFua2lQYWNrYWdlEiwuYW5raS5pbXBvcnRfZXhwb3J0LkV4cG9ydEFua2lQYW'
    'NrYWdlUmVxdWVzdBoULmFua2kuZ2VuZXJpYy5VSW50MzISWQoOR2V0Q3N2TWV0YWRhdGESJi5h'
    'bmtpLmltcG9ydF9leHBvcnQuQ3N2TWV0YWRhdGFSZXF1ZXN0Gh8uYW5raS5pbXBvcnRfZXhwb3'
    'J0LkNzdk1ldGFkYXRhElUKCUltcG9ydENzdhIkLmFua2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRD'
    'c3ZSZXF1ZXN0GiIuYW5raS5pbXBvcnRfZXhwb3J0LkltcG9ydFJlc3BvbnNlEk8KDUV4cG9ydE'
    '5vdGVDc3YSKC5hbmtpLmltcG9ydF9leHBvcnQuRXhwb3J0Tm90ZUNzdlJlcXVlc3QaFC5hbmtp'
    'LmdlbmVyaWMuVUludDMyEk8KDUV4cG9ydENhcmRDc3YSKC5hbmtpLmltcG9ydF9leHBvcnQuRX'
    'hwb3J0Q2FyZENzdlJlcXVlc3QaFC5hbmtpLmdlbmVyaWMuVUludDMyEkoKDkltcG9ydEpzb25G'
    'aWxlEhQuYW5raS5nZW5lcmljLlN0cmluZxoiLmFua2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRSZX'
    'Nwb25zZRJMChBJbXBvcnRKc29uU3RyaW5nEhQuYW5raS5nZW5lcmljLlN0cmluZxoiLmFua2ku'
    'aW1wb3J0X2V4cG9ydC5JbXBvcnRSZXNwb25zZQ==');

const $core.Map<$core.String, $core.dynamic>
    BackendImportExportServiceBase$json = {
  '1': 'BackendImportExportService',
  '2': [
    {
      '1': 'ImportCollectionPackage',
      '2': '.anki.import_export.ImportCollectionPackageRequest',
      '3': '.anki.generic.Empty'
    },
    {
      '1': 'ExportCollectionPackage',
      '2': '.anki.import_export.ExportCollectionPackageRequest',
      '3': '.anki.generic.Empty'
    },
  ],
};

@$core.Deprecated('Use backendImportExportServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BackendImportExportServiceBase$messageJson = {
  '.anki.import_export.ImportCollectionPackageRequest':
      ImportCollectionPackageRequest$json,
  '.anki.generic.Empty': $2.Empty$json,
  '.anki.import_export.ExportCollectionPackageRequest':
      ExportCollectionPackageRequest$json,
};

/// Descriptor for `BackendImportExportService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List backendImportExportServiceDescriptor = $convert.base64Decode(
    'ChpCYWNrZW5kSW1wb3J0RXhwb3J0U2VydmljZRJiChdJbXBvcnRDb2xsZWN0aW9uUGFja2FnZR'
    'IyLmFua2kuaW1wb3J0X2V4cG9ydC5JbXBvcnRDb2xsZWN0aW9uUGFja2FnZVJlcXVlc3QaEy5h'
    'bmtpLmdlbmVyaWMuRW1wdHkSYgoXRXhwb3J0Q29sbGVjdGlvblBhY2thZ2USMi5hbmtpLmltcG'
    '9ydF9leHBvcnQuRXhwb3J0Q29sbGVjdGlvblBhY2thZ2VSZXF1ZXN0GhMuYW5raS5nZW5lcmlj'
    'LkVtcHR5');
