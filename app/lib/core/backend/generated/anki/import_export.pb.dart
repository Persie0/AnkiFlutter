// This is a generated file - do not edit.
//
// Generated from anki/import_export.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'cards.pb.dart' as $3;
import 'collection.pb.dart' as $0;
import 'generic.pb.dart' as $2;
import 'import_export.pbenum.dart';
import 'notes.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'import_export.pbenum.dart';

class ImportCollectionPackageRequest extends $pb.GeneratedMessage {
  factory ImportCollectionPackageRequest({
    $core.String? colPath,
    $core.String? backupPath,
    $core.String? mediaFolder,
    $core.String? mediaDb,
  }) {
    final result = ImportCollectionPackageRequest._();
    if (colPath != null) result.colPath = colPath;
    if (backupPath != null) result.backupPath = backupPath;
    if (mediaFolder != null) result.mediaFolder = mediaFolder;
    if (mediaDb != null) result.mediaDb = mediaDb;
    return result;
  }

  ImportCollectionPackageRequest._();

  factory ImportCollectionPackageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportCollectionPackageRequest()..mergeFromBuffer(data, registry);
  factory ImportCollectionPackageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportCollectionPackageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportCollectionPackageRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ImportCollectionPackageRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'colPath')
    ..aOS(2, _omitFieldNames ? '' : 'backupPath')
    ..aOS(3, _omitFieldNames ? '' : 'mediaFolder')
    ..aOS(4, _omitFieldNames ? '' : 'mediaDb')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportCollectionPackageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportCollectionPackageRequest copyWith(
          void Function(ImportCollectionPackageRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ImportCollectionPackageRequest))
          as ImportCollectionPackageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ImportCollectionPackageRequest() / ImportCollectionPackageRequest.new instead')
  static ImportCollectionPackageRequest create() =>
      ImportCollectionPackageRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ImportCollectionPackageRequest._();
  @$core.override
  ImportCollectionPackageRequest createEmptyInstance() =>
      ImportCollectionPackageRequest._();
  @$core.pragma('dart2js:noInline')
  static ImportCollectionPackageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportCollectionPackageRequest>(
          ImportCollectionPackageRequest.$_createMessage);
  static ImportCollectionPackageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get colPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set colPath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasColPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearColPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get backupPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set backupPath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBackupPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackupPath() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mediaFolder => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaFolder($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMediaFolder() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaFolder() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get mediaDb => $_getSZ(3);
  @$pb.TagNumber(4)
  set mediaDb($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMediaDb() => $_has(3);
  @$pb.TagNumber(4)
  void clearMediaDb() => $_clearField(4);
}

class ExportCollectionPackageRequest extends $pb.GeneratedMessage {
  factory ExportCollectionPackageRequest({
    $core.String? outPath,
    $core.bool? includeMedia,
    $core.bool? legacy,
  }) {
    final result = ExportCollectionPackageRequest._();
    if (outPath != null) result.outPath = outPath;
    if (includeMedia != null) result.includeMedia = includeMedia;
    if (legacy != null) result.legacy = legacy;
    return result;
  }

  ExportCollectionPackageRequest._();

  factory ExportCollectionPackageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportCollectionPackageRequest()..mergeFromBuffer(data, registry);
  factory ExportCollectionPackageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportCollectionPackageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportCollectionPackageRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ExportCollectionPackageRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'outPath')
    ..aOB(2, _omitFieldNames ? '' : 'includeMedia')
    ..aOB(3, _omitFieldNames ? '' : 'legacy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportCollectionPackageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportCollectionPackageRequest copyWith(
          void Function(ExportCollectionPackageRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ExportCollectionPackageRequest))
          as ExportCollectionPackageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExportCollectionPackageRequest() / ExportCollectionPackageRequest.new instead')
  static ExportCollectionPackageRequest create() =>
      ExportCollectionPackageRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ExportCollectionPackageRequest._();
  @$core.override
  ExportCollectionPackageRequest createEmptyInstance() =>
      ExportCollectionPackageRequest._();
  @$core.pragma('dart2js:noInline')
  static ExportCollectionPackageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportCollectionPackageRequest>(
          ExportCollectionPackageRequest.$_createMessage);
  static ExportCollectionPackageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get outPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set outPath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOutPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get includeMedia => $_getBF(1);
  @$pb.TagNumber(2)
  set includeMedia($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncludeMedia() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeMedia() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get legacy => $_getBF(2);
  @$pb.TagNumber(3)
  set legacy($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLegacy() => $_has(2);
  @$pb.TagNumber(3)
  void clearLegacy() => $_clearField(3);
}

class ImportAnkiPackageOptions extends $pb.GeneratedMessage {
  factory ImportAnkiPackageOptions({
    $core.bool? mergeNotetypes,
    ImportAnkiPackageUpdateCondition? updateNotes,
    ImportAnkiPackageUpdateCondition? updateNotetypes,
    $core.bool? withScheduling,
    $core.bool? withDeckConfigs,
  }) {
    final result = ImportAnkiPackageOptions._();
    if (mergeNotetypes != null) result.mergeNotetypes = mergeNotetypes;
    if (updateNotes != null) result.updateNotes = updateNotes;
    if (updateNotetypes != null) result.updateNotetypes = updateNotetypes;
    if (withScheduling != null) result.withScheduling = withScheduling;
    if (withDeckConfigs != null) result.withDeckConfigs = withDeckConfigs;
    return result;
  }

  ImportAnkiPackageOptions._();

  factory ImportAnkiPackageOptions.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportAnkiPackageOptions()..mergeFromBuffer(data, registry);
  factory ImportAnkiPackageOptions.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportAnkiPackageOptions()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportAnkiPackageOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ImportAnkiPackageOptions.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'mergeNotetypes')
    ..aE<ImportAnkiPackageUpdateCondition>(
        2, _omitFieldNames ? '' : 'updateNotes',
        enumValues: ImportAnkiPackageUpdateCondition.values)
    ..aE<ImportAnkiPackageUpdateCondition>(
        3, _omitFieldNames ? '' : 'updateNotetypes',
        enumValues: ImportAnkiPackageUpdateCondition.values)
    ..aOB(4, _omitFieldNames ? '' : 'withScheduling')
    ..aOB(5, _omitFieldNames ? '' : 'withDeckConfigs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportAnkiPackageOptions clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportAnkiPackageOptions copyWith(
          void Function(ImportAnkiPackageOptions) updates) =>
      super.copyWith((message) => updates(message as ImportAnkiPackageOptions))
          as ImportAnkiPackageOptions;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ImportAnkiPackageOptions() / ImportAnkiPackageOptions.new instead')
  static ImportAnkiPackageOptions create() => ImportAnkiPackageOptions._();
  static $pb.GeneratedMessage $_createMessage() => ImportAnkiPackageOptions._();
  @$core.override
  ImportAnkiPackageOptions createEmptyInstance() =>
      ImportAnkiPackageOptions._();
  @$core.pragma('dart2js:noInline')
  static ImportAnkiPackageOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportAnkiPackageOptions>(
          ImportAnkiPackageOptions.$_createMessage);
  static ImportAnkiPackageOptions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get mergeNotetypes => $_getBF(0);
  @$pb.TagNumber(1)
  set mergeNotetypes($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMergeNotetypes() => $_has(0);
  @$pb.TagNumber(1)
  void clearMergeNotetypes() => $_clearField(1);

  @$pb.TagNumber(2)
  ImportAnkiPackageUpdateCondition get updateNotes => $_getN(1);
  @$pb.TagNumber(2)
  set updateNotes(ImportAnkiPackageUpdateCondition value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUpdateNotes() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateNotes() => $_clearField(2);

  @$pb.TagNumber(3)
  ImportAnkiPackageUpdateCondition get updateNotetypes => $_getN(2);
  @$pb.TagNumber(3)
  set updateNotetypes(ImportAnkiPackageUpdateCondition value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdateNotetypes() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateNotetypes() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get withScheduling => $_getBF(3);
  @$pb.TagNumber(4)
  set withScheduling($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasWithScheduling() => $_has(3);
  @$pb.TagNumber(4)
  void clearWithScheduling() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get withDeckConfigs => $_getBF(4);
  @$pb.TagNumber(5)
  set withDeckConfigs($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWithDeckConfigs() => $_has(4);
  @$pb.TagNumber(5)
  void clearWithDeckConfigs() => $_clearField(5);
}

class ImportAnkiPackageRequest extends $pb.GeneratedMessage {
  factory ImportAnkiPackageRequest({
    $core.String? packagePath,
    ImportAnkiPackageOptions? options,
  }) {
    final result = ImportAnkiPackageRequest._();
    if (packagePath != null) result.packagePath = packagePath;
    if (options != null) result.options = options;
    return result;
  }

  ImportAnkiPackageRequest._();

  factory ImportAnkiPackageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportAnkiPackageRequest()..mergeFromBuffer(data, registry);
  factory ImportAnkiPackageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportAnkiPackageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportAnkiPackageRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ImportAnkiPackageRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'packagePath')
    ..aOM<ImportAnkiPackageOptions>(2, _omitFieldNames ? '' : 'options',
        subBuilder: ImportAnkiPackageOptions.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportAnkiPackageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportAnkiPackageRequest copyWith(
          void Function(ImportAnkiPackageRequest) updates) =>
      super.copyWith((message) => updates(message as ImportAnkiPackageRequest))
          as ImportAnkiPackageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ImportAnkiPackageRequest() / ImportAnkiPackageRequest.new instead')
  static ImportAnkiPackageRequest create() => ImportAnkiPackageRequest._();
  static $pb.GeneratedMessage $_createMessage() => ImportAnkiPackageRequest._();
  @$core.override
  ImportAnkiPackageRequest createEmptyInstance() =>
      ImportAnkiPackageRequest._();
  @$core.pragma('dart2js:noInline')
  static ImportAnkiPackageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportAnkiPackageRequest>(
          ImportAnkiPackageRequest.$_createMessage);
  static ImportAnkiPackageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get packagePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set packagePath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackagePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackagePath() => $_clearField(1);

  @$pb.TagNumber(2)
  ImportAnkiPackageOptions get options => $_getN(1);
  @$pb.TagNumber(2)
  set options(ImportAnkiPackageOptions value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOptions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptions() => $_clearField(2);
  @$pb.TagNumber(2)
  ImportAnkiPackageOptions ensureOptions() => $_ensure(1);
}

class ImportResponse_Note extends $pb.GeneratedMessage {
  factory ImportResponse_Note({
    $1.NoteId? id,
    $core.Iterable<$core.String>? fields,
  }) {
    final result = ImportResponse_Note._();
    if (id != null) result.id = id;
    if (fields != null) result.fields.addAll(fields);
    return result;
  }

  ImportResponse_Note._();

  factory ImportResponse_Note.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportResponse_Note()..mergeFromBuffer(data, registry);
  factory ImportResponse_Note.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportResponse_Note()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportResponse.Note',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ImportResponse_Note.$_createMessage)
    ..aOM<$1.NoteId>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $1.NoteId.$_createMessage)
    ..pPS(2, _omitFieldNames ? '' : 'fields')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportResponse_Note clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportResponse_Note copyWith(void Function(ImportResponse_Note) updates) =>
      super.copyWith((message) => updates(message as ImportResponse_Note))
          as ImportResponse_Note;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ImportResponse_Note() / ImportResponse_Note.new instead')
  static ImportResponse_Note create() => ImportResponse_Note._();
  static $pb.GeneratedMessage $_createMessage() => ImportResponse_Note._();
  @$core.override
  ImportResponse_Note createEmptyInstance() => ImportResponse_Note._();
  @$core.pragma('dart2js:noInline')
  static ImportResponse_Note getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportResponse_Note>(
          ImportResponse_Note.$_createMessage);
  static ImportResponse_Note? _defaultInstance;

  @$pb.TagNumber(1)
  $1.NoteId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($1.NoteId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.NoteId ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get fields => $_getList(1);
}

class ImportResponse_Log extends $pb.GeneratedMessage {
  factory ImportResponse_Log({
    $core.Iterable<ImportResponse_Note>? new_1,
    $core.Iterable<ImportResponse_Note>? updated,
    $core.Iterable<ImportResponse_Note>? duplicate,
    $core.Iterable<ImportResponse_Note>? conflicting,
    $core.Iterable<ImportResponse_Note>? firstFieldMatch,
    $core.Iterable<ImportResponse_Note>? missingNotetype,
    $core.Iterable<ImportResponse_Note>? missingDeck,
    $core.Iterable<ImportResponse_Note>? emptyFirstField,
    CsvMetadata_DupeResolution? dupeResolution,
    $core.int? foundNotes,
  }) {
    final result = ImportResponse_Log._();
    if (new_1 != null) result.new_1.addAll(new_1);
    if (updated != null) result.updated.addAll(updated);
    if (duplicate != null) result.duplicate.addAll(duplicate);
    if (conflicting != null) result.conflicting.addAll(conflicting);
    if (firstFieldMatch != null) result.firstFieldMatch.addAll(firstFieldMatch);
    if (missingNotetype != null) result.missingNotetype.addAll(missingNotetype);
    if (missingDeck != null) result.missingDeck.addAll(missingDeck);
    if (emptyFirstField != null) result.emptyFirstField.addAll(emptyFirstField);
    if (dupeResolution != null) result.dupeResolution = dupeResolution;
    if (foundNotes != null) result.foundNotes = foundNotes;
    return result;
  }

  ImportResponse_Log._();

  factory ImportResponse_Log.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportResponse_Log()..mergeFromBuffer(data, registry);
  factory ImportResponse_Log.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportResponse_Log()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportResponse.Log',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ImportResponse_Log.$_createMessage)
    ..pPM<ImportResponse_Note>(1, _omitFieldNames ? '' : 'new',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..pPM<ImportResponse_Note>(2, _omitFieldNames ? '' : 'updated',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..pPM<ImportResponse_Note>(3, _omitFieldNames ? '' : 'duplicate',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..pPM<ImportResponse_Note>(4, _omitFieldNames ? '' : 'conflicting',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..pPM<ImportResponse_Note>(5, _omitFieldNames ? '' : 'firstFieldMatch',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..pPM<ImportResponse_Note>(6, _omitFieldNames ? '' : 'missingNotetype',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..pPM<ImportResponse_Note>(7, _omitFieldNames ? '' : 'missingDeck',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..pPM<ImportResponse_Note>(8, _omitFieldNames ? '' : 'emptyFirstField',
        subBuilder: ImportResponse_Note.$_createMessage)
    ..aE<CsvMetadata_DupeResolution>(9, _omitFieldNames ? '' : 'dupeResolution',
        enumValues: CsvMetadata_DupeResolution.values)
    ..aI(10, _omitFieldNames ? '' : 'foundNotes',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportResponse_Log clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportResponse_Log copyWith(void Function(ImportResponse_Log) updates) =>
      super.copyWith((message) => updates(message as ImportResponse_Log))
          as ImportResponse_Log;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ImportResponse_Log() / ImportResponse_Log.new instead')
  static ImportResponse_Log create() => ImportResponse_Log._();
  static $pb.GeneratedMessage $_createMessage() => ImportResponse_Log._();
  @$core.override
  ImportResponse_Log createEmptyInstance() => ImportResponse_Log._();
  @$core.pragma('dart2js:noInline')
  static ImportResponse_Log getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportResponse_Log>(
          ImportResponse_Log.$_createMessage);
  static ImportResponse_Log? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ImportResponse_Note> get new_1 => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<ImportResponse_Note> get updated => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<ImportResponse_Note> get duplicate => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<ImportResponse_Note> get conflicting => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<ImportResponse_Note> get firstFieldMatch => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<ImportResponse_Note> get missingNotetype => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<ImportResponse_Note> get missingDeck => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<ImportResponse_Note> get emptyFirstField => $_getList(7);

  @$pb.TagNumber(9)
  CsvMetadata_DupeResolution get dupeResolution => $_getN(8);
  @$pb.TagNumber(9)
  set dupeResolution(CsvMetadata_DupeResolution value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasDupeResolution() => $_has(8);
  @$pb.TagNumber(9)
  void clearDupeResolution() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get foundNotes => $_getIZ(9);
  @$pb.TagNumber(10)
  set foundNotes($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasFoundNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearFoundNotes() => $_clearField(10);
}

class ImportResponse extends $pb.GeneratedMessage {
  factory ImportResponse({
    $0.OpChanges? changes,
    ImportResponse_Log? log,
  }) {
    final result = ImportResponse._();
    if (changes != null) result.changes = changes;
    if (log != null) result.log = log;
    return result;
  }

  ImportResponse._();

  factory ImportResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportResponse()..mergeFromBuffer(data, registry);
  factory ImportResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ImportResponse.$_createMessage)
    ..aOM<$0.OpChanges>(1, _omitFieldNames ? '' : 'changes',
        subBuilder: $0.OpChanges.$_createMessage)
    ..aOM<ImportResponse_Log>(2, _omitFieldNames ? '' : 'log',
        subBuilder: ImportResponse_Log.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportResponse copyWith(void Function(ImportResponse) updates) =>
      super.copyWith((message) => updates(message as ImportResponse))
          as ImportResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ImportResponse() / ImportResponse.new instead')
  static ImportResponse create() => ImportResponse._();
  static $pb.GeneratedMessage $_createMessage() => ImportResponse._();
  @$core.override
  ImportResponse createEmptyInstance() => ImportResponse._();
  @$core.pragma('dart2js:noInline')
  static ImportResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportResponse>(
          ImportResponse.$_createMessage);
  static ImportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $0.OpChanges get changes => $_getN(0);
  @$pb.TagNumber(1)
  set changes($0.OpChanges value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChanges() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanges() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.OpChanges ensureChanges() => $_ensure(0);

  @$pb.TagNumber(2)
  ImportResponse_Log get log => $_getN(1);
  @$pb.TagNumber(2)
  set log(ImportResponse_Log value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLog() => $_has(1);
  @$pb.TagNumber(2)
  void clearLog() => $_clearField(2);
  @$pb.TagNumber(2)
  ImportResponse_Log ensureLog() => $_ensure(1);
}

class ExportAnkiPackageRequest extends $pb.GeneratedMessage {
  factory ExportAnkiPackageRequest({
    $core.String? outPath,
    ExportAnkiPackageOptions? options,
    ExportLimit? limit,
  }) {
    final result = ExportAnkiPackageRequest._();
    if (outPath != null) result.outPath = outPath;
    if (options != null) result.options = options;
    if (limit != null) result.limit = limit;
    return result;
  }

  ExportAnkiPackageRequest._();

  factory ExportAnkiPackageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportAnkiPackageRequest()..mergeFromBuffer(data, registry);
  factory ExportAnkiPackageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportAnkiPackageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportAnkiPackageRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ExportAnkiPackageRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'outPath')
    ..aOM<ExportAnkiPackageOptions>(2, _omitFieldNames ? '' : 'options',
        subBuilder: ExportAnkiPackageOptions.$_createMessage)
    ..aOM<ExportLimit>(3, _omitFieldNames ? '' : 'limit',
        subBuilder: ExportLimit.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportAnkiPackageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportAnkiPackageRequest copyWith(
          void Function(ExportAnkiPackageRequest) updates) =>
      super.copyWith((message) => updates(message as ExportAnkiPackageRequest))
          as ExportAnkiPackageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExportAnkiPackageRequest() / ExportAnkiPackageRequest.new instead')
  static ExportAnkiPackageRequest create() => ExportAnkiPackageRequest._();
  static $pb.GeneratedMessage $_createMessage() => ExportAnkiPackageRequest._();
  @$core.override
  ExportAnkiPackageRequest createEmptyInstance() =>
      ExportAnkiPackageRequest._();
  @$core.pragma('dart2js:noInline')
  static ExportAnkiPackageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportAnkiPackageRequest>(
          ExportAnkiPackageRequest.$_createMessage);
  static ExportAnkiPackageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get outPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set outPath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOutPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutPath() => $_clearField(1);

  @$pb.TagNumber(2)
  ExportAnkiPackageOptions get options => $_getN(1);
  @$pb.TagNumber(2)
  set options(ExportAnkiPackageOptions value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOptions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptions() => $_clearField(2);
  @$pb.TagNumber(2)
  ExportAnkiPackageOptions ensureOptions() => $_ensure(1);

  @$pb.TagNumber(3)
  ExportLimit get limit => $_getN(2);
  @$pb.TagNumber(3)
  set limit(ExportLimit value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
  @$pb.TagNumber(3)
  ExportLimit ensureLimit() => $_ensure(2);
}

class ExportAnkiPackageOptions extends $pb.GeneratedMessage {
  factory ExportAnkiPackageOptions({
    $core.bool? withScheduling,
    $core.bool? withDeckConfigs,
    $core.bool? withMedia,
    $core.bool? legacy,
  }) {
    final result = ExportAnkiPackageOptions._();
    if (withScheduling != null) result.withScheduling = withScheduling;
    if (withDeckConfigs != null) result.withDeckConfigs = withDeckConfigs;
    if (withMedia != null) result.withMedia = withMedia;
    if (legacy != null) result.legacy = legacy;
    return result;
  }

  ExportAnkiPackageOptions._();

  factory ExportAnkiPackageOptions.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportAnkiPackageOptions()..mergeFromBuffer(data, registry);
  factory ExportAnkiPackageOptions.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportAnkiPackageOptions()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportAnkiPackageOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ExportAnkiPackageOptions.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'withScheduling')
    ..aOB(2, _omitFieldNames ? '' : 'withDeckConfigs')
    ..aOB(3, _omitFieldNames ? '' : 'withMedia')
    ..aOB(4, _omitFieldNames ? '' : 'legacy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportAnkiPackageOptions clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportAnkiPackageOptions copyWith(
          void Function(ExportAnkiPackageOptions) updates) =>
      super.copyWith((message) => updates(message as ExportAnkiPackageOptions))
          as ExportAnkiPackageOptions;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExportAnkiPackageOptions() / ExportAnkiPackageOptions.new instead')
  static ExportAnkiPackageOptions create() => ExportAnkiPackageOptions._();
  static $pb.GeneratedMessage $_createMessage() => ExportAnkiPackageOptions._();
  @$core.override
  ExportAnkiPackageOptions createEmptyInstance() =>
      ExportAnkiPackageOptions._();
  @$core.pragma('dart2js:noInline')
  static ExportAnkiPackageOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportAnkiPackageOptions>(
          ExportAnkiPackageOptions.$_createMessage);
  static ExportAnkiPackageOptions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get withScheduling => $_getBF(0);
  @$pb.TagNumber(1)
  set withScheduling($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWithScheduling() => $_has(0);
  @$pb.TagNumber(1)
  void clearWithScheduling() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get withDeckConfigs => $_getBF(1);
  @$pb.TagNumber(2)
  set withDeckConfigs($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWithDeckConfigs() => $_has(1);
  @$pb.TagNumber(2)
  void clearWithDeckConfigs() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get withMedia => $_getBF(2);
  @$pb.TagNumber(3)
  set withMedia($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWithMedia() => $_has(2);
  @$pb.TagNumber(3)
  void clearWithMedia() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get legacy => $_getBF(3);
  @$pb.TagNumber(4)
  set legacy($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLegacy() => $_has(3);
  @$pb.TagNumber(4)
  void clearLegacy() => $_clearField(4);
}

class PackageMetadata extends $pb.GeneratedMessage {
  factory PackageMetadata({
    PackageMetadata_Version? version,
  }) {
    final result = PackageMetadata._();
    if (version != null) result.version = version;
    return result;
  }

  PackageMetadata._();

  factory PackageMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PackageMetadata()..mergeFromBuffer(data, registry);
  factory PackageMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PackageMetadata()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PackageMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: PackageMetadata.$_createMessage)
    ..aE<PackageMetadata_Version>(1, _omitFieldNames ? '' : 'version',
        enumValues: PackageMetadata_Version.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageMetadata clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageMetadata copyWith(void Function(PackageMetadata) updates) =>
      super.copyWith((message) => updates(message as PackageMetadata))
          as PackageMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PackageMetadata() / PackageMetadata.new instead')
  static PackageMetadata create() => PackageMetadata._();
  static $pb.GeneratedMessage $_createMessage() => PackageMetadata._();
  @$core.override
  PackageMetadata createEmptyInstance() => PackageMetadata._();
  @$core.pragma('dart2js:noInline')
  static PackageMetadata getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackageMetadata>(
          PackageMetadata.$_createMessage);
  static PackageMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  PackageMetadata_Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version(PackageMetadata_Version value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
}

class MediaEntries_MediaEntry extends $pb.GeneratedMessage {
  factory MediaEntries_MediaEntry({
    $core.String? name,
    $core.int? size,
    $core.List<$core.int>? sha1,
    $core.int? legacyZipFilename,
  }) {
    final result = MediaEntries_MediaEntry._();
    if (name != null) result.name = name;
    if (size != null) result.size = size;
    if (sha1 != null) result.sha1 = sha1;
    if (legacyZipFilename != null) result.legacyZipFilename = legacyZipFilename;
    return result;
  }

  MediaEntries_MediaEntry._();

  factory MediaEntries_MediaEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaEntries_MediaEntry()..mergeFromBuffer(data, registry);
  factory MediaEntries_MediaEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaEntries_MediaEntry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaEntries.MediaEntry',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: MediaEntries_MediaEntry.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aI(2, _omitFieldNames ? '' : 'size', fieldType: $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'sha1', $pb.PbFieldType.OY)
    ..aI(255, _omitFieldNames ? '' : 'legacyZipFilename',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaEntries_MediaEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaEntries_MediaEntry copyWith(
          void Function(MediaEntries_MediaEntry) updates) =>
      super.copyWith((message) => updates(message as MediaEntries_MediaEntry))
          as MediaEntries_MediaEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use MediaEntries_MediaEntry() / MediaEntries_MediaEntry.new instead')
  static MediaEntries_MediaEntry create() => MediaEntries_MediaEntry._();
  static $pb.GeneratedMessage $_createMessage() => MediaEntries_MediaEntry._();
  @$core.override
  MediaEntries_MediaEntry createEmptyInstance() => MediaEntries_MediaEntry._();
  @$core.pragma('dart2js:noInline')
  static MediaEntries_MediaEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaEntries_MediaEntry>(
          MediaEntries_MediaEntry.$_createMessage);
  static MediaEntries_MediaEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get size => $_getIZ(1);
  @$pb.TagNumber(2)
  set size($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get sha1 => $_getN(2);
  @$pb.TagNumber(3)
  set sha1($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSha1() => $_has(2);
  @$pb.TagNumber(3)
  void clearSha1() => $_clearField(3);

  /// / Legacy media maps may include gaps in the media list, so the original
  /// / file index is recorded when importing from a HashMap. This field is not
  /// / set when exporting.
  @$pb.TagNumber(255)
  $core.int get legacyZipFilename => $_getIZ(3);
  @$pb.TagNumber(255)
  set legacyZipFilename($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(255)
  $core.bool hasLegacyZipFilename() => $_has(3);
  @$pb.TagNumber(255)
  void clearLegacyZipFilename() => $_clearField(255);
}

class MediaEntries extends $pb.GeneratedMessage {
  factory MediaEntries({
    $core.Iterable<MediaEntries_MediaEntry>? entries,
  }) {
    final result = MediaEntries._();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  MediaEntries._();

  factory MediaEntries.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaEntries()..mergeFromBuffer(data, registry);
  factory MediaEntries.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaEntries()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaEntries',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: MediaEntries.$_createMessage)
    ..pPM<MediaEntries_MediaEntry>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: MediaEntries_MediaEntry.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaEntries clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaEntries copyWith(void Function(MediaEntries) updates) =>
      super.copyWith((message) => updates(message as MediaEntries))
          as MediaEntries;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MediaEntries() / MediaEntries.new instead')
  static MediaEntries create() => MediaEntries._();
  static $pb.GeneratedMessage $_createMessage() => MediaEntries._();
  @$core.override
  MediaEntries createEmptyInstance() => MediaEntries._();
  @$core.pragma('dart2js:noInline')
  static MediaEntries getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaEntries>(
          MediaEntries.$_createMessage);
  static MediaEntries? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MediaEntries_MediaEntry> get entries => $_getList(0);
}

class ImportCsvRequest extends $pb.GeneratedMessage {
  factory ImportCsvRequest({
    $core.String? path,
    CsvMetadata? metadata,
  }) {
    final result = ImportCsvRequest._();
    if (path != null) result.path = path;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  ImportCsvRequest._();

  factory ImportCsvRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportCsvRequest()..mergeFromBuffer(data, registry);
  factory ImportCsvRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportCsvRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportCsvRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ImportCsvRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOM<CsvMetadata>(2, _omitFieldNames ? '' : 'metadata',
        subBuilder: CsvMetadata.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportCsvRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportCsvRequest copyWith(void Function(ImportCsvRequest) updates) =>
      super.copyWith((message) => updates(message as ImportCsvRequest))
          as ImportCsvRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ImportCsvRequest() / ImportCsvRequest.new instead')
  static ImportCsvRequest create() => ImportCsvRequest._();
  static $pb.GeneratedMessage $_createMessage() => ImportCsvRequest._();
  @$core.override
  ImportCsvRequest createEmptyInstance() => ImportCsvRequest._();
  @$core.pragma('dart2js:noInline')
  static ImportCsvRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportCsvRequest>(
          ImportCsvRequest.$_createMessage);
  static ImportCsvRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => $_clearField(1);

  @$pb.TagNumber(2)
  CsvMetadata get metadata => $_getN(1);
  @$pb.TagNumber(2)
  set metadata(CsvMetadata value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetadata() => $_clearField(2);
  @$pb.TagNumber(2)
  CsvMetadata ensureMetadata() => $_ensure(1);
}

class CsvMetadataRequest extends $pb.GeneratedMessage {
  factory CsvMetadataRequest({
    $core.String? path,
    CsvMetadata_Delimiter? delimiter,
    $fixnum.Int64? notetypeId,
    $fixnum.Int64? deckId,
    $core.bool? isHtml,
  }) {
    final result = CsvMetadataRequest._();
    if (path != null) result.path = path;
    if (delimiter != null) result.delimiter = delimiter;
    if (notetypeId != null) result.notetypeId = notetypeId;
    if (deckId != null) result.deckId = deckId;
    if (isHtml != null) result.isHtml = isHtml;
    return result;
  }

  CsvMetadataRequest._();

  factory CsvMetadataRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CsvMetadataRequest()..mergeFromBuffer(data, registry);
  factory CsvMetadataRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CsvMetadataRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CsvMetadataRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: CsvMetadataRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aE<CsvMetadata_Delimiter>(2, _omitFieldNames ? '' : 'delimiter',
        enumValues: CsvMetadata_Delimiter.values)
    ..aInt64(3, _omitFieldNames ? '' : 'notetypeId')
    ..aInt64(4, _omitFieldNames ? '' : 'deckId')
    ..aOB(5, _omitFieldNames ? '' : 'isHtml')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CsvMetadataRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CsvMetadataRequest copyWith(void Function(CsvMetadataRequest) updates) =>
      super.copyWith((message) => updates(message as CsvMetadataRequest))
          as CsvMetadataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CsvMetadataRequest() / CsvMetadataRequest.new instead')
  static CsvMetadataRequest create() => CsvMetadataRequest._();
  static $pb.GeneratedMessage $_createMessage() => CsvMetadataRequest._();
  @$core.override
  CsvMetadataRequest createEmptyInstance() => CsvMetadataRequest._();
  @$core.pragma('dart2js:noInline')
  static CsvMetadataRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CsvMetadataRequest>(
          CsvMetadataRequest.$_createMessage);
  static CsvMetadataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => $_clearField(1);

  @$pb.TagNumber(2)
  CsvMetadata_Delimiter get delimiter => $_getN(1);
  @$pb.TagNumber(2)
  set delimiter(CsvMetadata_Delimiter value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDelimiter() => $_has(1);
  @$pb.TagNumber(2)
  void clearDelimiter() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get notetypeId => $_getI64(2);
  @$pb.TagNumber(3)
  set notetypeId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNotetypeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotetypeId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get deckId => $_getI64(3);
  @$pb.TagNumber(4)
  set deckId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDeckId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeckId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isHtml => $_getBF(4);
  @$pb.TagNumber(5)
  set isHtml($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsHtml() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsHtml() => $_clearField(5);
}

class CsvMetadata_MappedNotetype extends $pb.GeneratedMessage {
  factory CsvMetadata_MappedNotetype({
    $fixnum.Int64? id,
    $core.Iterable<$core.int>? fieldColumns,
  }) {
    final result = CsvMetadata_MappedNotetype._();
    if (id != null) result.id = id;
    if (fieldColumns != null) result.fieldColumns.addAll(fieldColumns);
    return result;
  }

  CsvMetadata_MappedNotetype._();

  factory CsvMetadata_MappedNotetype.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CsvMetadata_MappedNotetype()..mergeFromBuffer(data, registry);
  factory CsvMetadata_MappedNotetype.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CsvMetadata_MappedNotetype()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CsvMetadata.MappedNotetype',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: CsvMetadata_MappedNotetype.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..p<$core.int>(
        2, _omitFieldNames ? '' : 'fieldColumns', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CsvMetadata_MappedNotetype clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CsvMetadata_MappedNotetype copyWith(
          void Function(CsvMetadata_MappedNotetype) updates) =>
      super.copyWith(
              (message) => updates(message as CsvMetadata_MappedNotetype))
          as CsvMetadata_MappedNotetype;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CsvMetadata_MappedNotetype() / CsvMetadata_MappedNotetype.new instead')
  static CsvMetadata_MappedNotetype create() => CsvMetadata_MappedNotetype._();
  static $pb.GeneratedMessage $_createMessage() =>
      CsvMetadata_MappedNotetype._();
  @$core.override
  CsvMetadata_MappedNotetype createEmptyInstance() =>
      CsvMetadata_MappedNotetype._();
  @$core.pragma('dart2js:noInline')
  static CsvMetadata_MappedNotetype getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CsvMetadata_MappedNotetype>(
          CsvMetadata_MappedNotetype.$_createMessage);
  static CsvMetadata_MappedNotetype? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Source column indices for note fields. One-based. 0 means n/a.
  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get fieldColumns => $_getList(1);
}

enum CsvMetadata_Deck { deckId, deckColumn, deckName, notSet }

enum CsvMetadata_Notetype { globalNotetype, notetypeColumn, notSet }

/// Column indices are 1-based to make working with them in TS easier, where
/// unset numerical fields default to 0.
class CsvMetadata extends $pb.GeneratedMessage {
  factory CsvMetadata({
    CsvMetadata_Delimiter? delimiter,
    $core.bool? isHtml,
    $core.Iterable<$core.String>? globalTags,
    $core.Iterable<$core.String>? updatedTags,
    $core.Iterable<$core.String>? columnLabels,
    $fixnum.Int64? deckId,
    $core.int? deckColumn,
    CsvMetadata_MappedNotetype? globalNotetype,
    $core.int? notetypeColumn,
    $core.int? tagsColumn,
    $core.bool? forceDelimiter,
    $core.bool? forceIsHtml,
    $core.Iterable<$2.StringList>? preview,
    $core.int? guidColumn,
    CsvMetadata_DupeResolution? dupeResolution,
    CsvMetadata_MatchScope? matchScope,
    $core.String? deckName,
  }) {
    final result = CsvMetadata._();
    if (delimiter != null) result.delimiter = delimiter;
    if (isHtml != null) result.isHtml = isHtml;
    if (globalTags != null) result.globalTags.addAll(globalTags);
    if (updatedTags != null) result.updatedTags.addAll(updatedTags);
    if (columnLabels != null) result.columnLabels.addAll(columnLabels);
    if (deckId != null) result.deckId = deckId;
    if (deckColumn != null) result.deckColumn = deckColumn;
    if (globalNotetype != null) result.globalNotetype = globalNotetype;
    if (notetypeColumn != null) result.notetypeColumn = notetypeColumn;
    if (tagsColumn != null) result.tagsColumn = tagsColumn;
    if (forceDelimiter != null) result.forceDelimiter = forceDelimiter;
    if (forceIsHtml != null) result.forceIsHtml = forceIsHtml;
    if (preview != null) result.preview.addAll(preview);
    if (guidColumn != null) result.guidColumn = guidColumn;
    if (dupeResolution != null) result.dupeResolution = dupeResolution;
    if (matchScope != null) result.matchScope = matchScope;
    if (deckName != null) result.deckName = deckName;
    return result;
  }

  CsvMetadata._();

  factory CsvMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CsvMetadata()..mergeFromBuffer(data, registry);
  factory CsvMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CsvMetadata()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, CsvMetadata_Deck> _CsvMetadata_DeckByTag = {
    6: CsvMetadata_Deck.deckId,
    7: CsvMetadata_Deck.deckColumn,
    17: CsvMetadata_Deck.deckName,
    0: CsvMetadata_Deck.notSet
  };
  static const $core.Map<$core.int, CsvMetadata_Notetype>
      _CsvMetadata_NotetypeByTag = {
    8: CsvMetadata_Notetype.globalNotetype,
    9: CsvMetadata_Notetype.notetypeColumn,
    0: CsvMetadata_Notetype.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CsvMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: CsvMetadata.$_createMessage)
    ..oo(0, [6, 7, 17])
    ..oo(1, [8, 9])
    ..aE<CsvMetadata_Delimiter>(1, _omitFieldNames ? '' : 'delimiter',
        enumValues: CsvMetadata_Delimiter.values)
    ..aOB(2, _omitFieldNames ? '' : 'isHtml')
    ..pPS(3, _omitFieldNames ? '' : 'globalTags')
    ..pPS(4, _omitFieldNames ? '' : 'updatedTags')
    ..pPS(5, _omitFieldNames ? '' : 'columnLabels')
    ..aInt64(6, _omitFieldNames ? '' : 'deckId')
    ..aI(7, _omitFieldNames ? '' : 'deckColumn', fieldType: $pb.PbFieldType.OU3)
    ..aOM<CsvMetadata_MappedNotetype>(
        8, _omitFieldNames ? '' : 'globalNotetype',
        subBuilder: CsvMetadata_MappedNotetype.$_createMessage)
    ..aI(9, _omitFieldNames ? '' : 'notetypeColumn',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(10, _omitFieldNames ? '' : 'tagsColumn',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(11, _omitFieldNames ? '' : 'forceDelimiter')
    ..aOB(12, _omitFieldNames ? '' : 'forceIsHtml')
    ..pPM<$2.StringList>(13, _omitFieldNames ? '' : 'preview',
        subBuilder: $2.StringList.$_createMessage)
    ..aI(14, _omitFieldNames ? '' : 'guidColumn',
        fieldType: $pb.PbFieldType.OU3)
    ..aE<CsvMetadata_DupeResolution>(
        15, _omitFieldNames ? '' : 'dupeResolution',
        enumValues: CsvMetadata_DupeResolution.values)
    ..aE<CsvMetadata_MatchScope>(16, _omitFieldNames ? '' : 'matchScope',
        enumValues: CsvMetadata_MatchScope.values)
    ..aOS(17, _omitFieldNames ? '' : 'deckName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CsvMetadata clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CsvMetadata copyWith(void Function(CsvMetadata) updates) =>
      super.copyWith((message) => updates(message as CsvMetadata))
          as CsvMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CsvMetadata() / CsvMetadata.new instead')
  static CsvMetadata create() => CsvMetadata._();
  static $pb.GeneratedMessage $_createMessage() => CsvMetadata._();
  @$core.override
  CsvMetadata createEmptyInstance() => CsvMetadata._();
  @$core.pragma('dart2js:noInline')
  static CsvMetadata getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CsvMetadata>(
          CsvMetadata.$_createMessage);
  static CsvMetadata? _defaultInstance;

  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(17)
  CsvMetadata_Deck whichDeck() => _CsvMetadata_DeckByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(17)
  void clearDeck() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  CsvMetadata_Notetype whichNotetype() =>
      _CsvMetadata_NotetypeByTag[$_whichOneof(1)]!;
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  void clearNotetype() => $_clearField($_whichOneof(1));

  @$pb.TagNumber(1)
  CsvMetadata_Delimiter get delimiter => $_getN(0);
  @$pb.TagNumber(1)
  set delimiter(CsvMetadata_Delimiter value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDelimiter() => $_has(0);
  @$pb.TagNumber(1)
  void clearDelimiter() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isHtml => $_getBF(1);
  @$pb.TagNumber(2)
  set isHtml($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsHtml() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsHtml() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get globalTags => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get updatedTags => $_getList(3);

  /// Column names as defined by the file or empty strings otherwise. Also used
  /// to determine the number of columns.
  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get columnLabels => $_getList(4);

  /// id of an existing deck
  @$pb.TagNumber(6)
  $fixnum.Int64 get deckId => $_getI64(5);
  @$pb.TagNumber(6)
  set deckId($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDeckId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeckId() => $_clearField(6);

  /// One-based. 0 means n/a.
  @$pb.TagNumber(7)
  $core.int get deckColumn => $_getIZ(6);
  @$pb.TagNumber(7)
  set deckColumn($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeckColumn() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeckColumn() => $_clearField(7);

  /// One notetype for all rows with given column mapping.
  @$pb.TagNumber(8)
  CsvMetadata_MappedNotetype get globalNotetype => $_getN(7);
  @$pb.TagNumber(8)
  set globalNotetype(CsvMetadata_MappedNotetype value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasGlobalNotetype() => $_has(7);
  @$pb.TagNumber(8)
  void clearGlobalNotetype() => $_clearField(8);
  @$pb.TagNumber(8)
  CsvMetadata_MappedNotetype ensureGlobalNotetype() => $_ensure(7);

  /// Row-specific notetypes with automatic mapping by index.
  /// One-based. 0 means n/a.
  @$pb.TagNumber(9)
  $core.int get notetypeColumn => $_getIZ(8);
  @$pb.TagNumber(9)
  set notetypeColumn($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNotetypeColumn() => $_has(8);
  @$pb.TagNumber(9)
  void clearNotetypeColumn() => $_clearField(9);

  /// One-based. 0 means n/a.
  @$pb.TagNumber(10)
  $core.int get tagsColumn => $_getIZ(9);
  @$pb.TagNumber(10)
  set tagsColumn($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTagsColumn() => $_has(9);
  @$pb.TagNumber(10)
  void clearTagsColumn() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get forceDelimiter => $_getBF(10);
  @$pb.TagNumber(11)
  set forceDelimiter($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasForceDelimiter() => $_has(10);
  @$pb.TagNumber(11)
  void clearForceDelimiter() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get forceIsHtml => $_getBF(11);
  @$pb.TagNumber(12)
  set forceIsHtml($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasForceIsHtml() => $_has(11);
  @$pb.TagNumber(12)
  void clearForceIsHtml() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbList<$2.StringList> get preview => $_getList(12);

  @$pb.TagNumber(14)
  $core.int get guidColumn => $_getIZ(13);
  @$pb.TagNumber(14)
  set guidColumn($core.int value) => $_setUnsignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasGuidColumn() => $_has(13);
  @$pb.TagNumber(14)
  void clearGuidColumn() => $_clearField(14);

  @$pb.TagNumber(15)
  CsvMetadata_DupeResolution get dupeResolution => $_getN(14);
  @$pb.TagNumber(15)
  set dupeResolution(CsvMetadata_DupeResolution value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasDupeResolution() => $_has(14);
  @$pb.TagNumber(15)
  void clearDupeResolution() => $_clearField(15);

  @$pb.TagNumber(16)
  CsvMetadata_MatchScope get matchScope => $_getN(15);
  @$pb.TagNumber(16)
  set matchScope(CsvMetadata_MatchScope value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasMatchScope() => $_has(15);
  @$pb.TagNumber(16)
  void clearMatchScope() => $_clearField(16);

  /// name of new deck to be created
  @$pb.TagNumber(17)
  $core.String get deckName => $_getSZ(16);
  @$pb.TagNumber(17)
  set deckName($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasDeckName() => $_has(16);
  @$pb.TagNumber(17)
  void clearDeckName() => $_clearField(17);
}

class ExportCardCsvRequest extends $pb.GeneratedMessage {
  factory ExportCardCsvRequest({
    $core.String? outPath,
    $core.bool? withHtml,
    ExportLimit? limit,
  }) {
    final result = ExportCardCsvRequest._();
    if (outPath != null) result.outPath = outPath;
    if (withHtml != null) result.withHtml = withHtml;
    if (limit != null) result.limit = limit;
    return result;
  }

  ExportCardCsvRequest._();

  factory ExportCardCsvRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportCardCsvRequest()..mergeFromBuffer(data, registry);
  factory ExportCardCsvRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportCardCsvRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportCardCsvRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ExportCardCsvRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'outPath')
    ..aOB(2, _omitFieldNames ? '' : 'withHtml')
    ..aOM<ExportLimit>(3, _omitFieldNames ? '' : 'limit',
        subBuilder: ExportLimit.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportCardCsvRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportCardCsvRequest copyWith(void Function(ExportCardCsvRequest) updates) =>
      super.copyWith((message) => updates(message as ExportCardCsvRequest))
          as ExportCardCsvRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExportCardCsvRequest() / ExportCardCsvRequest.new instead')
  static ExportCardCsvRequest create() => ExportCardCsvRequest._();
  static $pb.GeneratedMessage $_createMessage() => ExportCardCsvRequest._();
  @$core.override
  ExportCardCsvRequest createEmptyInstance() => ExportCardCsvRequest._();
  @$core.pragma('dart2js:noInline')
  static ExportCardCsvRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportCardCsvRequest>(
          ExportCardCsvRequest.$_createMessage);
  static ExportCardCsvRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get outPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set outPath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOutPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get withHtml => $_getBF(1);
  @$pb.TagNumber(2)
  set withHtml($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWithHtml() => $_has(1);
  @$pb.TagNumber(2)
  void clearWithHtml() => $_clearField(2);

  @$pb.TagNumber(3)
  ExportLimit get limit => $_getN(2);
  @$pb.TagNumber(3)
  set limit(ExportLimit value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
  @$pb.TagNumber(3)
  ExportLimit ensureLimit() => $_ensure(2);
}

class ExportNoteCsvRequest extends $pb.GeneratedMessage {
  factory ExportNoteCsvRequest({
    $core.String? outPath,
    $core.bool? withHtml,
    $core.bool? withTags,
    $core.bool? withDeck,
    $core.bool? withNotetype,
    $core.bool? withGuid,
    ExportLimit? limit,
  }) {
    final result = ExportNoteCsvRequest._();
    if (outPath != null) result.outPath = outPath;
    if (withHtml != null) result.withHtml = withHtml;
    if (withTags != null) result.withTags = withTags;
    if (withDeck != null) result.withDeck = withDeck;
    if (withNotetype != null) result.withNotetype = withNotetype;
    if (withGuid != null) result.withGuid = withGuid;
    if (limit != null) result.limit = limit;
    return result;
  }

  ExportNoteCsvRequest._();

  factory ExportNoteCsvRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportNoteCsvRequest()..mergeFromBuffer(data, registry);
  factory ExportNoteCsvRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportNoteCsvRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportNoteCsvRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ExportNoteCsvRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'outPath')
    ..aOB(2, _omitFieldNames ? '' : 'withHtml')
    ..aOB(3, _omitFieldNames ? '' : 'withTags')
    ..aOB(4, _omitFieldNames ? '' : 'withDeck')
    ..aOB(5, _omitFieldNames ? '' : 'withNotetype')
    ..aOB(6, _omitFieldNames ? '' : 'withGuid')
    ..aOM<ExportLimit>(7, _omitFieldNames ? '' : 'limit',
        subBuilder: ExportLimit.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportNoteCsvRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportNoteCsvRequest copyWith(void Function(ExportNoteCsvRequest) updates) =>
      super.copyWith((message) => updates(message as ExportNoteCsvRequest))
          as ExportNoteCsvRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ExportNoteCsvRequest() / ExportNoteCsvRequest.new instead')
  static ExportNoteCsvRequest create() => ExportNoteCsvRequest._();
  static $pb.GeneratedMessage $_createMessage() => ExportNoteCsvRequest._();
  @$core.override
  ExportNoteCsvRequest createEmptyInstance() => ExportNoteCsvRequest._();
  @$core.pragma('dart2js:noInline')
  static ExportNoteCsvRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportNoteCsvRequest>(
          ExportNoteCsvRequest.$_createMessage);
  static ExportNoteCsvRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get outPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set outPath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOutPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get withHtml => $_getBF(1);
  @$pb.TagNumber(2)
  set withHtml($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWithHtml() => $_has(1);
  @$pb.TagNumber(2)
  void clearWithHtml() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get withTags => $_getBF(2);
  @$pb.TagNumber(3)
  set withTags($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWithTags() => $_has(2);
  @$pb.TagNumber(3)
  void clearWithTags() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get withDeck => $_getBF(3);
  @$pb.TagNumber(4)
  set withDeck($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasWithDeck() => $_has(3);
  @$pb.TagNumber(4)
  void clearWithDeck() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get withNotetype => $_getBF(4);
  @$pb.TagNumber(5)
  set withNotetype($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWithNotetype() => $_has(4);
  @$pb.TagNumber(5)
  void clearWithNotetype() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get withGuid => $_getBF(5);
  @$pb.TagNumber(6)
  set withGuid($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasWithGuid() => $_has(5);
  @$pb.TagNumber(6)
  void clearWithGuid() => $_clearField(6);

  @$pb.TagNumber(7)
  ExportLimit get limit => $_getN(6);
  @$pb.TagNumber(7)
  set limit(ExportLimit value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearLimit() => $_clearField(7);
  @$pb.TagNumber(7)
  ExportLimit ensureLimit() => $_ensure(6);
}

enum ExportLimit_Limit { wholeCollection, deckId, noteIds, cardIds, notSet }

class ExportLimit extends $pb.GeneratedMessage {
  factory ExportLimit({
    $2.Empty? wholeCollection,
    $fixnum.Int64? deckId,
    $1.NoteIds? noteIds,
    $3.CardIds? cardIds,
  }) {
    final result = ExportLimit._();
    if (wholeCollection != null) result.wholeCollection = wholeCollection;
    if (deckId != null) result.deckId = deckId;
    if (noteIds != null) result.noteIds = noteIds;
    if (cardIds != null) result.cardIds = cardIds;
    return result;
  }

  ExportLimit._();

  factory ExportLimit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportLimit()..mergeFromBuffer(data, registry);
  factory ExportLimit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ExportLimit()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ExportLimit_Limit> _ExportLimit_LimitByTag =
      {
    1: ExportLimit_Limit.wholeCollection,
    2: ExportLimit_Limit.deckId,
    3: ExportLimit_Limit.noteIds,
    4: ExportLimit_Limit.cardIds,
    0: ExportLimit_Limit.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportLimit',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.import_export'),
      createEmptyInstance: ExportLimit.$_createMessage)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<$2.Empty>(1, _omitFieldNames ? '' : 'wholeCollection',
        subBuilder: $2.Empty.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'deckId')
    ..aOM<$1.NoteIds>(3, _omitFieldNames ? '' : 'noteIds',
        subBuilder: $1.NoteIds.$_createMessage)
    ..aOM<$3.CardIds>(4, _omitFieldNames ? '' : 'cardIds',
        subBuilder: $3.CardIds.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportLimit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportLimit copyWith(void Function(ExportLimit) updates) =>
      super.copyWith((message) => updates(message as ExportLimit))
          as ExportLimit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ExportLimit() / ExportLimit.new instead')
  static ExportLimit create() => ExportLimit._();
  static $pb.GeneratedMessage $_createMessage() => ExportLimit._();
  @$core.override
  ExportLimit createEmptyInstance() => ExportLimit._();
  @$core.pragma('dart2js:noInline')
  static ExportLimit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportLimit>(
          ExportLimit.$_createMessage);
  static ExportLimit? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  ExportLimit_Limit whichLimit() => _ExportLimit_LimitByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $2.Empty get wholeCollection => $_getN(0);
  @$pb.TagNumber(1)
  set wholeCollection($2.Empty value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWholeCollection() => $_has(0);
  @$pb.TagNumber(1)
  void clearWholeCollection() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Empty ensureWholeCollection() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get deckId => $_getI64(1);
  @$pb.TagNumber(2)
  set deckId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeckId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeckId() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.NoteIds get noteIds => $_getN(2);
  @$pb.TagNumber(3)
  set noteIds($1.NoteIds value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNoteIds() => $_has(2);
  @$pb.TagNumber(3)
  void clearNoteIds() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.NoteIds ensureNoteIds() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.CardIds get cardIds => $_getN(3);
  @$pb.TagNumber(4)
  set cardIds($3.CardIds value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCardIds() => $_has(3);
  @$pb.TagNumber(4)
  void clearCardIds() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.CardIds ensureCardIds() => $_ensure(3);
}

class ImportExportServiceApi {
  final $pb.RpcClient _client;

  ImportExportServiceApi(this._client);

  $async.Future<ImportResponse> importAnkiPackage(
          $pb.ClientContext? ctx, ImportAnkiPackageRequest request) =>
      _client.invoke<ImportResponse>(ctx, 'ImportExportService',
          'ImportAnkiPackage', request, ImportResponse());
  $async.Future<ImportAnkiPackageOptions> getImportAnkiPackagePresets(
          $pb.ClientContext? ctx, $2.Empty request) =>
      _client.invoke<ImportAnkiPackageOptions>(ctx, 'ImportExportService',
          'GetImportAnkiPackagePresets', request, ImportAnkiPackageOptions());
  $async.Future<$2.UInt32> exportAnkiPackage(
          $pb.ClientContext? ctx, ExportAnkiPackageRequest request) =>
      _client.invoke<$2.UInt32>(ctx, 'ImportExportService', 'ExportAnkiPackage',
          request, $2.UInt32());
  $async.Future<CsvMetadata> getCsvMetadata(
          $pb.ClientContext? ctx, CsvMetadataRequest request) =>
      _client.invoke<CsvMetadata>(
          ctx, 'ImportExportService', 'GetCsvMetadata', request, CsvMetadata());
  $async.Future<ImportResponse> importCsv(
          $pb.ClientContext? ctx, ImportCsvRequest request) =>
      _client.invoke<ImportResponse>(
          ctx, 'ImportExportService', 'ImportCsv', request, ImportResponse());
  $async.Future<$2.UInt32> exportNoteCsv(
          $pb.ClientContext? ctx, ExportNoteCsvRequest request) =>
      _client.invoke<$2.UInt32>(
          ctx, 'ImportExportService', 'ExportNoteCsv', request, $2.UInt32());
  $async.Future<$2.UInt32> exportCardCsv(
          $pb.ClientContext? ctx, ExportCardCsvRequest request) =>
      _client.invoke<$2.UInt32>(
          ctx, 'ImportExportService', 'ExportCardCsv', request, $2.UInt32());
  $async.Future<ImportResponse> importJsonFile(
          $pb.ClientContext? ctx, $2.String request) =>
      _client.invoke<ImportResponse>(ctx, 'ImportExportService',
          'ImportJsonFile', request, ImportResponse());
  $async.Future<ImportResponse> importJsonString(
          $pb.ClientContext? ctx, $2.String request) =>
      _client.invoke<ImportResponse>(ctx, 'ImportExportService',
          'ImportJsonString', request, ImportResponse());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendImportExportServiceApi {
  final $pb.RpcClient _client;

  BackendImportExportServiceApi(this._client);

  $async.Future<$2.Empty> importCollectionPackage(
          $pb.ClientContext? ctx, ImportCollectionPackageRequest request) =>
      _client.invoke<$2.Empty>(ctx, 'BackendImportExportService',
          'ImportCollectionPackage', request, $2.Empty());
  $async.Future<$2.Empty> exportCollectionPackage(
          $pb.ClientContext? ctx, ExportCollectionPackageRequest request) =>
      _client.invoke<$2.Empty>(ctx, 'BackendImportExportService',
          'ExportCollectionPackage', request, $2.Empty());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
