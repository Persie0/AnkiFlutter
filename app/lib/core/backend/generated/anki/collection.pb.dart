// This is a generated file - do not edit.
//
// Generated from anki/collection.proto.

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

import 'generic.pb.dart' as $0;
import 'sync.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class OpenCollectionRequest extends $pb.GeneratedMessage {
  factory OpenCollectionRequest({
    $core.String? collectionPath,
    $core.String? mediaFolderPath,
    $core.String? mediaDbPath,
  }) {
    final result = OpenCollectionRequest._();
    if (collectionPath != null) result.collectionPath = collectionPath;
    if (mediaFolderPath != null) result.mediaFolderPath = mediaFolderPath;
    if (mediaDbPath != null) result.mediaDbPath = mediaDbPath;
    return result;
  }

  OpenCollectionRequest._();

  factory OpenCollectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpenCollectionRequest()..mergeFromBuffer(data, registry);
  factory OpenCollectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpenCollectionRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenCollectionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: OpenCollectionRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'collectionPath')
    ..aOS(2, _omitFieldNames ? '' : 'mediaFolderPath')
    ..aOS(3, _omitFieldNames ? '' : 'mediaDbPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenCollectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenCollectionRequest copyWith(
          void Function(OpenCollectionRequest) updates) =>
      super.copyWith((message) => updates(message as OpenCollectionRequest))
          as OpenCollectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use OpenCollectionRequest() / OpenCollectionRequest.new instead')
  static OpenCollectionRequest create() => OpenCollectionRequest._();
  static $pb.GeneratedMessage $_createMessage() => OpenCollectionRequest._();
  @$core.override
  OpenCollectionRequest createEmptyInstance() => OpenCollectionRequest._();
  @$core.pragma('dart2js:noInline')
  static OpenCollectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenCollectionRequest>(
          OpenCollectionRequest.$_createMessage);
  static OpenCollectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get collectionPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set collectionPath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCollectionPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearCollectionPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get mediaFolderPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set mediaFolderPath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMediaFolderPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearMediaFolderPath() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mediaDbPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaDbPath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMediaDbPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaDbPath() => $_clearField(3);
}

class CloseCollectionRequest extends $pb.GeneratedMessage {
  factory CloseCollectionRequest({
    $core.bool? downgradeToSchema11,
  }) {
    final result = CloseCollectionRequest._();
    if (downgradeToSchema11 != null)
      result.downgradeToSchema11 = downgradeToSchema11;
    return result;
  }

  CloseCollectionRequest._();

  factory CloseCollectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CloseCollectionRequest()..mergeFromBuffer(data, registry);
  factory CloseCollectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CloseCollectionRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseCollectionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: CloseCollectionRequest.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'downgradeToSchema11')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseCollectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseCollectionRequest copyWith(
          void Function(CloseCollectionRequest) updates) =>
      super.copyWith((message) => updates(message as CloseCollectionRequest))
          as CloseCollectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CloseCollectionRequest() / CloseCollectionRequest.new instead')
  static CloseCollectionRequest create() => CloseCollectionRequest._();
  static $pb.GeneratedMessage $_createMessage() => CloseCollectionRequest._();
  @$core.override
  CloseCollectionRequest createEmptyInstance() => CloseCollectionRequest._();
  @$core.pragma('dart2js:noInline')
  static CloseCollectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseCollectionRequest>(
          CloseCollectionRequest.$_createMessage);
  static CloseCollectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get downgradeToSchema11 => $_getBF(0);
  @$pb.TagNumber(1)
  set downgradeToSchema11($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDowngradeToSchema11() => $_has(0);
  @$pb.TagNumber(1)
  void clearDowngradeToSchema11() => $_clearField(1);
}

class CheckDatabaseResponse extends $pb.GeneratedMessage {
  factory CheckDatabaseResponse({
    $core.Iterable<$core.String>? problems,
  }) {
    final result = CheckDatabaseResponse._();
    if (problems != null) result.problems.addAll(problems);
    return result;
  }

  CheckDatabaseResponse._();

  factory CheckDatabaseResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckDatabaseResponse()..mergeFromBuffer(data, registry);
  factory CheckDatabaseResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckDatabaseResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckDatabaseResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: CheckDatabaseResponse.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'problems')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckDatabaseResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckDatabaseResponse copyWith(
          void Function(CheckDatabaseResponse) updates) =>
      super.copyWith((message) => updates(message as CheckDatabaseResponse))
          as CheckDatabaseResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckDatabaseResponse() / CheckDatabaseResponse.new instead')
  static CheckDatabaseResponse create() => CheckDatabaseResponse._();
  static $pb.GeneratedMessage $_createMessage() => CheckDatabaseResponse._();
  @$core.override
  CheckDatabaseResponse createEmptyInstance() => CheckDatabaseResponse._();
  @$core.pragma('dart2js:noInline')
  static CheckDatabaseResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckDatabaseResponse>(
          CheckDatabaseResponse.$_createMessage);
  static CheckDatabaseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get problems => $_getList(0);
}

class OpChanges extends $pb.GeneratedMessage {
  factory OpChanges({
    $core.bool? card,
    $core.bool? note,
    $core.bool? deck,
    $core.bool? tag,
    $core.bool? notetype,
    $core.bool? config,
    $core.bool? browserTable,
    $core.bool? browserSidebar,
    $core.bool? noteText,
    $core.bool? studyQueues,
    $core.bool? deckConfig,
    $core.bool? mtime,
  }) {
    final result = OpChanges._();
    if (card != null) result.card = card;
    if (note != null) result.note = note;
    if (deck != null) result.deck = deck;
    if (tag != null) result.tag = tag;
    if (notetype != null) result.notetype = notetype;
    if (config != null) result.config = config;
    if (browserTable != null) result.browserTable = browserTable;
    if (browserSidebar != null) result.browserSidebar = browserSidebar;
    if (noteText != null) result.noteText = noteText;
    if (studyQueues != null) result.studyQueues = studyQueues;
    if (deckConfig != null) result.deckConfig = deckConfig;
    if (mtime != null) result.mtime = mtime;
    return result;
  }

  OpChanges._();

  factory OpChanges.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChanges()..mergeFromBuffer(data, registry);
  factory OpChanges.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChanges()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpChanges',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: OpChanges.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'card')
    ..aOB(2, _omitFieldNames ? '' : 'note')
    ..aOB(3, _omitFieldNames ? '' : 'deck')
    ..aOB(4, _omitFieldNames ? '' : 'tag')
    ..aOB(5, _omitFieldNames ? '' : 'notetype')
    ..aOB(6, _omitFieldNames ? '' : 'config')
    ..aOB(7, _omitFieldNames ? '' : 'browserTable')
    ..aOB(8, _omitFieldNames ? '' : 'browserSidebar')
    ..aOB(9, _omitFieldNames ? '' : 'noteText')
    ..aOB(10, _omitFieldNames ? '' : 'studyQueues')
    ..aOB(11, _omitFieldNames ? '' : 'deckConfig')
    ..aOB(12, _omitFieldNames ? '' : 'mtime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChanges clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChanges copyWith(void Function(OpChanges) updates) =>
      super.copyWith((message) => updates(message as OpChanges)) as OpChanges;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OpChanges() / OpChanges.new instead')
  static OpChanges create() => OpChanges._();
  static $pb.GeneratedMessage $_createMessage() => OpChanges._();
  @$core.override
  OpChanges createEmptyInstance() => OpChanges._();
  @$core.pragma('dart2js:noInline')
  static OpChanges getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpChanges>(OpChanges.$_createMessage);
  static OpChanges? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get card => $_getBF(0);
  @$pb.TagNumber(1)
  set card($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get note => $_getBF(1);
  @$pb.TagNumber(2)
  set note($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNote() => $_has(1);
  @$pb.TagNumber(2)
  void clearNote() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get deck => $_getBF(2);
  @$pb.TagNumber(3)
  set deck($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeck() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeck() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get tag => $_getBF(3);
  @$pb.TagNumber(4)
  set tag($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTag() => $_has(3);
  @$pb.TagNumber(4)
  void clearTag() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get notetype => $_getBF(4);
  @$pb.TagNumber(5)
  set notetype($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotetype() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotetype() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get config => $_getBF(5);
  @$pb.TagNumber(6)
  set config($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasConfig() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfig() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get browserTable => $_getBF(6);
  @$pb.TagNumber(7)
  set browserTable($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBrowserTable() => $_has(6);
  @$pb.TagNumber(7)
  void clearBrowserTable() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get browserSidebar => $_getBF(7);
  @$pb.TagNumber(8)
  set browserSidebar($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBrowserSidebar() => $_has(7);
  @$pb.TagNumber(8)
  void clearBrowserSidebar() => $_clearField(8);

  /// editor and displayed card in review screen
  @$pb.TagNumber(9)
  $core.bool get noteText => $_getBF(8);
  @$pb.TagNumber(9)
  set noteText($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNoteText() => $_has(8);
  @$pb.TagNumber(9)
  void clearNoteText() => $_clearField(9);

  /// whether to call .reset() and getCard()
  @$pb.TagNumber(10)
  $core.bool get studyQueues => $_getBF(9);
  @$pb.TagNumber(10)
  set studyQueues($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStudyQueues() => $_has(9);
  @$pb.TagNumber(10)
  void clearStudyQueues() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get deckConfig => $_getBF(10);
  @$pb.TagNumber(11)
  set deckConfig($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDeckConfig() => $_has(10);
  @$pb.TagNumber(11)
  void clearDeckConfig() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get mtime => $_getBF(11);
  @$pb.TagNumber(12)
  set mtime($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMtime() => $_has(11);
  @$pb.TagNumber(12)
  void clearMtime() => $_clearField(12);
}

/// Allows frontend code to extract changes from other messages like
/// ImportResponse without decoding other potentially large fields.
class OpChangesOnly extends $pb.GeneratedMessage {
  factory OpChangesOnly({
    OpChanges? changes,
  }) {
    final result = OpChangesOnly._();
    if (changes != null) result.changes = changes;
    return result;
  }

  OpChangesOnly._();

  factory OpChangesOnly.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesOnly()..mergeFromBuffer(data, registry);
  factory OpChangesOnly.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesOnly()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpChangesOnly',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: OpChangesOnly.$_createMessage)
    ..aOM<OpChanges>(1, _omitFieldNames ? '' : 'changes',
        subBuilder: OpChanges.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesOnly clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesOnly copyWith(void Function(OpChangesOnly) updates) =>
      super.copyWith((message) => updates(message as OpChangesOnly))
          as OpChangesOnly;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OpChangesOnly() / OpChangesOnly.new instead')
  static OpChangesOnly create() => OpChangesOnly._();
  static $pb.GeneratedMessage $_createMessage() => OpChangesOnly._();
  @$core.override
  OpChangesOnly createEmptyInstance() => OpChangesOnly._();
  @$core.pragma('dart2js:noInline')
  static OpChangesOnly getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpChangesOnly>(
          OpChangesOnly.$_createMessage);
  static OpChangesOnly? _defaultInstance;

  @$pb.TagNumber(1)
  OpChanges get changes => $_getN(0);
  @$pb.TagNumber(1)
  set changes(OpChanges value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChanges() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanges() => $_clearField(1);
  @$pb.TagNumber(1)
  OpChanges ensureChanges() => $_ensure(0);
}

class NestedOpChanges extends $pb.GeneratedMessage {
  factory NestedOpChanges({
    OpChangesOnly? changes,
  }) {
    final result = NestedOpChanges._();
    if (changes != null) result.changes = changes;
    return result;
  }

  NestedOpChanges._();

  factory NestedOpChanges.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NestedOpChanges()..mergeFromBuffer(data, registry);
  factory NestedOpChanges.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NestedOpChanges()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NestedOpChanges',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: NestedOpChanges.$_createMessage)
    ..aOM<OpChangesOnly>(1, _omitFieldNames ? '' : 'changes',
        subBuilder: OpChangesOnly.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestedOpChanges clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestedOpChanges copyWith(void Function(NestedOpChanges) updates) =>
      super.copyWith((message) => updates(message as NestedOpChanges))
          as NestedOpChanges;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use NestedOpChanges() / NestedOpChanges.new instead')
  static NestedOpChanges create() => NestedOpChanges._();
  static $pb.GeneratedMessage $_createMessage() => NestedOpChanges._();
  @$core.override
  NestedOpChanges createEmptyInstance() => NestedOpChanges._();
  @$core.pragma('dart2js:noInline')
  static NestedOpChanges getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NestedOpChanges>(
          NestedOpChanges.$_createMessage);
  static NestedOpChanges? _defaultInstance;

  @$pb.TagNumber(1)
  OpChangesOnly get changes => $_getN(0);
  @$pb.TagNumber(1)
  set changes(OpChangesOnly value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChanges() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanges() => $_clearField(1);
  @$pb.TagNumber(1)
  OpChangesOnly ensureChanges() => $_ensure(0);
}

class OpChangesWithCount extends $pb.GeneratedMessage {
  factory OpChangesWithCount({
    OpChanges? changes,
    $core.int? count,
  }) {
    final result = OpChangesWithCount._();
    if (changes != null) result.changes = changes;
    if (count != null) result.count = count;
    return result;
  }

  OpChangesWithCount._();

  factory OpChangesWithCount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesWithCount()..mergeFromBuffer(data, registry);
  factory OpChangesWithCount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesWithCount()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpChangesWithCount',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: OpChangesWithCount.$_createMessage)
    ..aOM<OpChanges>(1, _omitFieldNames ? '' : 'changes',
        subBuilder: OpChanges.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'count', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesWithCount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesWithCount copyWith(void Function(OpChangesWithCount) updates) =>
      super.copyWith((message) => updates(message as OpChangesWithCount))
          as OpChangesWithCount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OpChangesWithCount() / OpChangesWithCount.new instead')
  static OpChangesWithCount create() => OpChangesWithCount._();
  static $pb.GeneratedMessage $_createMessage() => OpChangesWithCount._();
  @$core.override
  OpChangesWithCount createEmptyInstance() => OpChangesWithCount._();
  @$core.pragma('dart2js:noInline')
  static OpChangesWithCount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpChangesWithCount>(
          OpChangesWithCount.$_createMessage);
  static OpChangesWithCount? _defaultInstance;

  @$pb.TagNumber(1)
  OpChanges get changes => $_getN(0);
  @$pb.TagNumber(1)
  set changes(OpChanges value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChanges() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanges() => $_clearField(1);
  @$pb.TagNumber(1)
  OpChanges ensureChanges() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get count => $_getIZ(1);
  @$pb.TagNumber(2)
  set count($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => $_clearField(2);
}

class OpChangesWithId extends $pb.GeneratedMessage {
  factory OpChangesWithId({
    OpChanges? changes,
    $fixnum.Int64? id,
  }) {
    final result = OpChangesWithId._();
    if (changes != null) result.changes = changes;
    if (id != null) result.id = id;
    return result;
  }

  OpChangesWithId._();

  factory OpChangesWithId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesWithId()..mergeFromBuffer(data, registry);
  factory OpChangesWithId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesWithId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpChangesWithId',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: OpChangesWithId.$_createMessage)
    ..aOM<OpChanges>(1, _omitFieldNames ? '' : 'changes',
        subBuilder: OpChanges.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesWithId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesWithId copyWith(void Function(OpChangesWithId) updates) =>
      super.copyWith((message) => updates(message as OpChangesWithId))
          as OpChangesWithId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OpChangesWithId() / OpChangesWithId.new instead')
  static OpChangesWithId create() => OpChangesWithId._();
  static $pb.GeneratedMessage $_createMessage() => OpChangesWithId._();
  @$core.override
  OpChangesWithId createEmptyInstance() => OpChangesWithId._();
  @$core.pragma('dart2js:noInline')
  static OpChangesWithId getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpChangesWithId>(
          OpChangesWithId.$_createMessage);
  static OpChangesWithId? _defaultInstance;

  @$pb.TagNumber(1)
  OpChanges get changes => $_getN(0);
  @$pb.TagNumber(1)
  set changes(OpChanges value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChanges() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanges() => $_clearField(1);
  @$pb.TagNumber(1)
  OpChanges ensureChanges() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get id => $_getI64(1);
  @$pb.TagNumber(2)
  set id($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);
}

class UndoStatus extends $pb.GeneratedMessage {
  factory UndoStatus({
    $core.String? undo,
    $core.String? redo,
    $core.int? lastStep,
  }) {
    final result = UndoStatus._();
    if (undo != null) result.undo = undo;
    if (redo != null) result.redo = redo;
    if (lastStep != null) result.lastStep = lastStep;
    return result;
  }

  UndoStatus._();

  factory UndoStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UndoStatus()..mergeFromBuffer(data, registry);
  factory UndoStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UndoStatus()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndoStatus',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: UndoStatus.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'undo')
    ..aOS(2, _omitFieldNames ? '' : 'redo')
    ..aI(3, _omitFieldNames ? '' : 'lastStep', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UndoStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UndoStatus copyWith(void Function(UndoStatus) updates) =>
      super.copyWith((message) => updates(message as UndoStatus)) as UndoStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UndoStatus() / UndoStatus.new instead')
  static UndoStatus create() => UndoStatus._();
  static $pb.GeneratedMessage $_createMessage() => UndoStatus._();
  @$core.override
  UndoStatus createEmptyInstance() => UndoStatus._();
  @$core.pragma('dart2js:noInline')
  static UndoStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UndoStatus>(UndoStatus.$_createMessage);
  static UndoStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get undo => $_getSZ(0);
  @$pb.TagNumber(1)
  set undo($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUndo() => $_has(0);
  @$pb.TagNumber(1)
  void clearUndo() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get redo => $_getSZ(1);
  @$pb.TagNumber(2)
  set redo($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRedo() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedo() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get lastStep => $_getIZ(2);
  @$pb.TagNumber(3)
  set lastStep($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastStep() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastStep() => $_clearField(3);
}

class OpChangesAfterUndo extends $pb.GeneratedMessage {
  factory OpChangesAfterUndo({
    OpChanges? changes,
    $core.String? operation,
    $fixnum.Int64? revertedToTimestamp,
    UndoStatus? newStatus,
    $core.int? counter,
  }) {
    final result = OpChangesAfterUndo._();
    if (changes != null) result.changes = changes;
    if (operation != null) result.operation = operation;
    if (revertedToTimestamp != null)
      result.revertedToTimestamp = revertedToTimestamp;
    if (newStatus != null) result.newStatus = newStatus;
    if (counter != null) result.counter = counter;
    return result;
  }

  OpChangesAfterUndo._();

  factory OpChangesAfterUndo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesAfterUndo()..mergeFromBuffer(data, registry);
  factory OpChangesAfterUndo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      OpChangesAfterUndo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpChangesAfterUndo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: OpChangesAfterUndo.$_createMessage)
    ..aOM<OpChanges>(1, _omitFieldNames ? '' : 'changes',
        subBuilder: OpChanges.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'operation')
    ..aInt64(3, _omitFieldNames ? '' : 'revertedToTimestamp')
    ..aOM<UndoStatus>(4, _omitFieldNames ? '' : 'newStatus',
        subBuilder: UndoStatus.$_createMessage)
    ..aI(5, _omitFieldNames ? '' : 'counter', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesAfterUndo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpChangesAfterUndo copyWith(void Function(OpChangesAfterUndo) updates) =>
      super.copyWith((message) => updates(message as OpChangesAfterUndo))
          as OpChangesAfterUndo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use OpChangesAfterUndo() / OpChangesAfterUndo.new instead')
  static OpChangesAfterUndo create() => OpChangesAfterUndo._();
  static $pb.GeneratedMessage $_createMessage() => OpChangesAfterUndo._();
  @$core.override
  OpChangesAfterUndo createEmptyInstance() => OpChangesAfterUndo._();
  @$core.pragma('dart2js:noInline')
  static OpChangesAfterUndo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpChangesAfterUndo>(
          OpChangesAfterUndo.$_createMessage);
  static OpChangesAfterUndo? _defaultInstance;

  @$pb.TagNumber(1)
  OpChanges get changes => $_getN(0);
  @$pb.TagNumber(1)
  set changes(OpChanges value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChanges() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanges() => $_clearField(1);
  @$pb.TagNumber(1)
  OpChanges ensureChanges() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get operation => $_getSZ(1);
  @$pb.TagNumber(2)
  set operation($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperation() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get revertedToTimestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set revertedToTimestamp($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRevertedToTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearRevertedToTimestamp() => $_clearField(3);

  @$pb.TagNumber(4)
  UndoStatus get newStatus => $_getN(3);
  @$pb.TagNumber(4)
  set newStatus(UndoStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasNewStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewStatus() => $_clearField(4);
  @$pb.TagNumber(4)
  UndoStatus ensureNewStatus() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get counter => $_getIZ(4);
  @$pb.TagNumber(5)
  set counter($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCounter() => $_has(4);
  @$pb.TagNumber(5)
  void clearCounter() => $_clearField(5);
}

class Progress_FullSync extends $pb.GeneratedMessage {
  factory Progress_FullSync({
    $core.int? transferred,
    $core.int? total,
  }) {
    final result = Progress_FullSync._();
    if (transferred != null) result.transferred = transferred;
    if (total != null) result.total = total;
    return result;
  }

  Progress_FullSync._();

  factory Progress_FullSync.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress_FullSync()..mergeFromBuffer(data, registry);
  factory Progress_FullSync.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress_FullSync()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Progress.FullSync',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: Progress_FullSync.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'transferred',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'total', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress_FullSync clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress_FullSync copyWith(void Function(Progress_FullSync) updates) =>
      super.copyWith((message) => updates(message as Progress_FullSync))
          as Progress_FullSync;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Progress_FullSync() / Progress_FullSync.new instead')
  static Progress_FullSync create() => Progress_FullSync._();
  static $pb.GeneratedMessage $_createMessage() => Progress_FullSync._();
  @$core.override
  Progress_FullSync createEmptyInstance() => Progress_FullSync._();
  @$core.pragma('dart2js:noInline')
  static Progress_FullSync getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Progress_FullSync>(
          Progress_FullSync.$_createMessage);
  static Progress_FullSync? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get transferred => $_getIZ(0);
  @$pb.TagNumber(1)
  set transferred($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransferred() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransferred() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class Progress_NormalSync extends $pb.GeneratedMessage {
  factory Progress_NormalSync({
    $core.String? stage,
    $core.String? added,
    $core.String? removed,
  }) {
    final result = Progress_NormalSync._();
    if (stage != null) result.stage = stage;
    if (added != null) result.added = added;
    if (removed != null) result.removed = removed;
    return result;
  }

  Progress_NormalSync._();

  factory Progress_NormalSync.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress_NormalSync()..mergeFromBuffer(data, registry);
  factory Progress_NormalSync.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress_NormalSync()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Progress.NormalSync',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: Progress_NormalSync.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'stage')
    ..aOS(2, _omitFieldNames ? '' : 'added')
    ..aOS(3, _omitFieldNames ? '' : 'removed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress_NormalSync clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress_NormalSync copyWith(void Function(Progress_NormalSync) updates) =>
      super.copyWith((message) => updates(message as Progress_NormalSync))
          as Progress_NormalSync;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use Progress_NormalSync() / Progress_NormalSync.new instead')
  static Progress_NormalSync create() => Progress_NormalSync._();
  static $pb.GeneratedMessage $_createMessage() => Progress_NormalSync._();
  @$core.override
  Progress_NormalSync createEmptyInstance() => Progress_NormalSync._();
  @$core.pragma('dart2js:noInline')
  static Progress_NormalSync getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Progress_NormalSync>(
          Progress_NormalSync.$_createMessage);
  static Progress_NormalSync? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stage => $_getSZ(0);
  @$pb.TagNumber(1)
  set stage($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStage() => $_has(0);
  @$pb.TagNumber(1)
  void clearStage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get added => $_getSZ(1);
  @$pb.TagNumber(2)
  set added($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAdded() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdded() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get removed => $_getSZ(2);
  @$pb.TagNumber(3)
  set removed($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRemoved() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemoved() => $_clearField(3);
}

class Progress_DatabaseCheck extends $pb.GeneratedMessage {
  factory Progress_DatabaseCheck({
    $core.String? stage,
    $core.int? stageTotal,
    $core.int? stageCurrent,
  }) {
    final result = Progress_DatabaseCheck._();
    if (stage != null) result.stage = stage;
    if (stageTotal != null) result.stageTotal = stageTotal;
    if (stageCurrent != null) result.stageCurrent = stageCurrent;
    return result;
  }

  Progress_DatabaseCheck._();

  factory Progress_DatabaseCheck.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress_DatabaseCheck()..mergeFromBuffer(data, registry);
  factory Progress_DatabaseCheck.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress_DatabaseCheck()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Progress.DatabaseCheck',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: Progress_DatabaseCheck.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'stage')
    ..aI(2, _omitFieldNames ? '' : 'stageTotal', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'stageCurrent',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress_DatabaseCheck clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress_DatabaseCheck copyWith(
          void Function(Progress_DatabaseCheck) updates) =>
      super.copyWith((message) => updates(message as Progress_DatabaseCheck))
          as Progress_DatabaseCheck;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use Progress_DatabaseCheck() / Progress_DatabaseCheck.new instead')
  static Progress_DatabaseCheck create() => Progress_DatabaseCheck._();
  static $pb.GeneratedMessage $_createMessage() => Progress_DatabaseCheck._();
  @$core.override
  Progress_DatabaseCheck createEmptyInstance() => Progress_DatabaseCheck._();
  @$core.pragma('dart2js:noInline')
  static Progress_DatabaseCheck getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Progress_DatabaseCheck>(
          Progress_DatabaseCheck.$_createMessage);
  static Progress_DatabaseCheck? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stage => $_getSZ(0);
  @$pb.TagNumber(1)
  set stage($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStage() => $_has(0);
  @$pb.TagNumber(1)
  void clearStage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get stageTotal => $_getIZ(1);
  @$pb.TagNumber(2)
  set stageTotal($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStageTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearStageTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get stageCurrent => $_getIZ(2);
  @$pb.TagNumber(3)
  set stageCurrent($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStageCurrent() => $_has(2);
  @$pb.TagNumber(3)
  void clearStageCurrent() => $_clearField(3);
}

enum Progress_Value {
  none,
  mediaSync,
  mediaCheck,
  fullSync,
  normalSync,
  databaseCheck,
  importing,
  exporting,
  computeParams,
  computeRetention,
  computeMemory,
  downloadUpdate,
  notSet
}

class Progress extends $pb.GeneratedMessage {
  factory Progress({
    $0.Empty? none,
    $1.MediaSyncProgress? mediaSync,
    $core.String? mediaCheck,
    Progress_FullSync? fullSync,
    Progress_NormalSync? normalSync,
    Progress_DatabaseCheck? databaseCheck,
    $core.String? importing,
    $core.String? exporting,
    ComputeParamsProgress? computeParams,
    ComputeRetentionProgress? computeRetention,
    ComputeMemoryProgress? computeMemory,
    DownloadUpdateProgress? downloadUpdate,
  }) {
    final result = Progress._();
    if (none != null) result.none = none;
    if (mediaSync != null) result.mediaSync = mediaSync;
    if (mediaCheck != null) result.mediaCheck = mediaCheck;
    if (fullSync != null) result.fullSync = fullSync;
    if (normalSync != null) result.normalSync = normalSync;
    if (databaseCheck != null) result.databaseCheck = databaseCheck;
    if (importing != null) result.importing = importing;
    if (exporting != null) result.exporting = exporting;
    if (computeParams != null) result.computeParams = computeParams;
    if (computeRetention != null) result.computeRetention = computeRetention;
    if (computeMemory != null) result.computeMemory = computeMemory;
    if (downloadUpdate != null) result.downloadUpdate = downloadUpdate;
    return result;
  }

  Progress._();

  factory Progress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress()..mergeFromBuffer(data, registry);
  factory Progress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Progress()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Progress_Value> _Progress_ValueByTag = {
    1: Progress_Value.none,
    2: Progress_Value.mediaSync,
    3: Progress_Value.mediaCheck,
    4: Progress_Value.fullSync,
    5: Progress_Value.normalSync,
    6: Progress_Value.databaseCheck,
    7: Progress_Value.importing,
    8: Progress_Value.exporting,
    9: Progress_Value.computeParams,
    10: Progress_Value.computeRetention,
    11: Progress_Value.computeMemory,
    12: Progress_Value.downloadUpdate,
    0: Progress_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Progress',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: Progress.$_createMessage)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    ..aOM<$0.Empty>(1, _omitFieldNames ? '' : 'none',
        subBuilder: $0.Empty.$_createMessage)
    ..aOM<$1.MediaSyncProgress>(2, _omitFieldNames ? '' : 'mediaSync',
        subBuilder: $1.MediaSyncProgress.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'mediaCheck')
    ..aOM<Progress_FullSync>(4, _omitFieldNames ? '' : 'fullSync',
        subBuilder: Progress_FullSync.$_createMessage)
    ..aOM<Progress_NormalSync>(5, _omitFieldNames ? '' : 'normalSync',
        subBuilder: Progress_NormalSync.$_createMessage)
    ..aOM<Progress_DatabaseCheck>(6, _omitFieldNames ? '' : 'databaseCheck',
        subBuilder: Progress_DatabaseCheck.$_createMessage)
    ..aOS(7, _omitFieldNames ? '' : 'importing')
    ..aOS(8, _omitFieldNames ? '' : 'exporting')
    ..aOM<ComputeParamsProgress>(9, _omitFieldNames ? '' : 'computeParams',
        subBuilder: ComputeParamsProgress.$_createMessage)
    ..aOM<ComputeRetentionProgress>(
        10, _omitFieldNames ? '' : 'computeRetention',
        subBuilder: ComputeRetentionProgress.$_createMessage)
    ..aOM<ComputeMemoryProgress>(11, _omitFieldNames ? '' : 'computeMemory',
        subBuilder: ComputeMemoryProgress.$_createMessage)
    ..aOM<DownloadUpdateProgress>(12, _omitFieldNames ? '' : 'downloadUpdate',
        subBuilder: DownloadUpdateProgress.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Progress copyWith(void Function(Progress) updates) =>
      super.copyWith((message) => updates(message as Progress)) as Progress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Progress() / Progress.new instead')
  static Progress create() => Progress._();
  static $pb.GeneratedMessage $_createMessage() => Progress._();
  @$core.override
  Progress createEmptyInstance() => Progress._();
  @$core.pragma('dart2js:noInline')
  static Progress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Progress>(Progress.$_createMessage);
  static Progress? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  Progress_Value whichValue() => _Progress_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.Empty get none => $_getN(0);
  @$pb.TagNumber(1)
  set none($0.Empty value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNone() => $_has(0);
  @$pb.TagNumber(1)
  void clearNone() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Empty ensureNone() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.MediaSyncProgress get mediaSync => $_getN(1);
  @$pb.TagNumber(2)
  set mediaSync($1.MediaSyncProgress value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMediaSync() => $_has(1);
  @$pb.TagNumber(2)
  void clearMediaSync() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.MediaSyncProgress ensureMediaSync() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get mediaCheck => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaCheck($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMediaCheck() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaCheck() => $_clearField(3);

  @$pb.TagNumber(4)
  Progress_FullSync get fullSync => $_getN(3);
  @$pb.TagNumber(4)
  set fullSync(Progress_FullSync value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFullSync() => $_has(3);
  @$pb.TagNumber(4)
  void clearFullSync() => $_clearField(4);
  @$pb.TagNumber(4)
  Progress_FullSync ensureFullSync() => $_ensure(3);

  @$pb.TagNumber(5)
  Progress_NormalSync get normalSync => $_getN(4);
  @$pb.TagNumber(5)
  set normalSync(Progress_NormalSync value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasNormalSync() => $_has(4);
  @$pb.TagNumber(5)
  void clearNormalSync() => $_clearField(5);
  @$pb.TagNumber(5)
  Progress_NormalSync ensureNormalSync() => $_ensure(4);

  @$pb.TagNumber(6)
  Progress_DatabaseCheck get databaseCheck => $_getN(5);
  @$pb.TagNumber(6)
  set databaseCheck(Progress_DatabaseCheck value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDatabaseCheck() => $_has(5);
  @$pb.TagNumber(6)
  void clearDatabaseCheck() => $_clearField(6);
  @$pb.TagNumber(6)
  Progress_DatabaseCheck ensureDatabaseCheck() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get importing => $_getSZ(6);
  @$pb.TagNumber(7)
  set importing($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasImporting() => $_has(6);
  @$pb.TagNumber(7)
  void clearImporting() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get exporting => $_getSZ(7);
  @$pb.TagNumber(8)
  set exporting($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasExporting() => $_has(7);
  @$pb.TagNumber(8)
  void clearExporting() => $_clearField(8);

  @$pb.TagNumber(9)
  ComputeParamsProgress get computeParams => $_getN(8);
  @$pb.TagNumber(9)
  set computeParams(ComputeParamsProgress value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasComputeParams() => $_has(8);
  @$pb.TagNumber(9)
  void clearComputeParams() => $_clearField(9);
  @$pb.TagNumber(9)
  ComputeParamsProgress ensureComputeParams() => $_ensure(8);

  @$pb.TagNumber(10)
  ComputeRetentionProgress get computeRetention => $_getN(9);
  @$pb.TagNumber(10)
  set computeRetention(ComputeRetentionProgress value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasComputeRetention() => $_has(9);
  @$pb.TagNumber(10)
  void clearComputeRetention() => $_clearField(10);
  @$pb.TagNumber(10)
  ComputeRetentionProgress ensureComputeRetention() => $_ensure(9);

  @$pb.TagNumber(11)
  ComputeMemoryProgress get computeMemory => $_getN(10);
  @$pb.TagNumber(11)
  set computeMemory(ComputeMemoryProgress value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasComputeMemory() => $_has(10);
  @$pb.TagNumber(11)
  void clearComputeMemory() => $_clearField(11);
  @$pb.TagNumber(11)
  ComputeMemoryProgress ensureComputeMemory() => $_ensure(10);

  @$pb.TagNumber(12)
  DownloadUpdateProgress get downloadUpdate => $_getN(11);
  @$pb.TagNumber(12)
  set downloadUpdate(DownloadUpdateProgress value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasDownloadUpdate() => $_has(11);
  @$pb.TagNumber(12)
  void clearDownloadUpdate() => $_clearField(12);
  @$pb.TagNumber(12)
  DownloadUpdateProgress ensureDownloadUpdate() => $_ensure(11);
}

class ComputeParamsProgress extends $pb.GeneratedMessage {
  factory ComputeParamsProgress({
    $core.int? current,
    $core.int? total,
    $core.int? reviews,
    $core.int? currentPreset,
    $core.int? totalPresets,
  }) {
    final result = ComputeParamsProgress._();
    if (current != null) result.current = current;
    if (total != null) result.total = total;
    if (reviews != null) result.reviews = reviews;
    if (currentPreset != null) result.currentPreset = currentPreset;
    if (totalPresets != null) result.totalPresets = totalPresets;
    return result;
  }

  ComputeParamsProgress._();

  factory ComputeParamsProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ComputeParamsProgress()..mergeFromBuffer(data, registry);
  factory ComputeParamsProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ComputeParamsProgress()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComputeParamsProgress',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: ComputeParamsProgress.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'current', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'total', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'reviews', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'currentPreset',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'totalPresets',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComputeParamsProgress clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComputeParamsProgress copyWith(
          void Function(ComputeParamsProgress) updates) =>
      super.copyWith((message) => updates(message as ComputeParamsProgress))
          as ComputeParamsProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ComputeParamsProgress() / ComputeParamsProgress.new instead')
  static ComputeParamsProgress create() => ComputeParamsProgress._();
  static $pb.GeneratedMessage $_createMessage() => ComputeParamsProgress._();
  @$core.override
  ComputeParamsProgress createEmptyInstance() => ComputeParamsProgress._();
  @$core.pragma('dart2js:noInline')
  static ComputeParamsProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComputeParamsProgress>(
          ComputeParamsProgress.$_createMessage);
  static ComputeParamsProgress? _defaultInstance;

  /// Current iteration
  @$pb.TagNumber(1)
  $core.int get current => $_getIZ(0);
  @$pb.TagNumber(1)
  set current($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrent() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrent() => $_clearField(1);

  /// Total iterations
  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get reviews => $_getIZ(2);
  @$pb.TagNumber(3)
  set reviews($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReviews() => $_has(2);
  @$pb.TagNumber(3)
  void clearReviews() => $_clearField(3);

  /// Only used in 'compute all params' case
  @$pb.TagNumber(4)
  $core.int get currentPreset => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentPreset($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentPreset() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentPreset() => $_clearField(4);

  /// Only used in 'compute all params' case
  @$pb.TagNumber(5)
  $core.int get totalPresets => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalPresets($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPresets() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPresets() => $_clearField(5);
}

class ComputeRetentionProgress extends $pb.GeneratedMessage {
  factory ComputeRetentionProgress({
    $core.int? current,
    $core.int? total,
  }) {
    final result = ComputeRetentionProgress._();
    if (current != null) result.current = current;
    if (total != null) result.total = total;
    return result;
  }

  ComputeRetentionProgress._();

  factory ComputeRetentionProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ComputeRetentionProgress()..mergeFromBuffer(data, registry);
  factory ComputeRetentionProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ComputeRetentionProgress()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComputeRetentionProgress',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: ComputeRetentionProgress.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'current', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'total', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComputeRetentionProgress clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComputeRetentionProgress copyWith(
          void Function(ComputeRetentionProgress) updates) =>
      super.copyWith((message) => updates(message as ComputeRetentionProgress))
          as ComputeRetentionProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ComputeRetentionProgress() / ComputeRetentionProgress.new instead')
  static ComputeRetentionProgress create() => ComputeRetentionProgress._();
  static $pb.GeneratedMessage $_createMessage() => ComputeRetentionProgress._();
  @$core.override
  ComputeRetentionProgress createEmptyInstance() =>
      ComputeRetentionProgress._();
  @$core.pragma('dart2js:noInline')
  static ComputeRetentionProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComputeRetentionProgress>(
          ComputeRetentionProgress.$_createMessage);
  static ComputeRetentionProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get current => $_getIZ(0);
  @$pb.TagNumber(1)
  set current($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrent() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrent() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class ComputeMemoryProgress extends $pb.GeneratedMessage {
  factory ComputeMemoryProgress({
    $core.int? currentCards,
    $core.int? totalCards,
    $core.String? label,
  }) {
    final result = ComputeMemoryProgress._();
    if (currentCards != null) result.currentCards = currentCards;
    if (totalCards != null) result.totalCards = totalCards;
    if (label != null) result.label = label;
    return result;
  }

  ComputeMemoryProgress._();

  factory ComputeMemoryProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ComputeMemoryProgress()..mergeFromBuffer(data, registry);
  factory ComputeMemoryProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ComputeMemoryProgress()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComputeMemoryProgress',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: ComputeMemoryProgress.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'currentCards',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'totalCards', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComputeMemoryProgress clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComputeMemoryProgress copyWith(
          void Function(ComputeMemoryProgress) updates) =>
      super.copyWith((message) => updates(message as ComputeMemoryProgress))
          as ComputeMemoryProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ComputeMemoryProgress() / ComputeMemoryProgress.new instead')
  static ComputeMemoryProgress create() => ComputeMemoryProgress._();
  static $pb.GeneratedMessage $_createMessage() => ComputeMemoryProgress._();
  @$core.override
  ComputeMemoryProgress createEmptyInstance() => ComputeMemoryProgress._();
  @$core.pragma('dart2js:noInline')
  static ComputeMemoryProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComputeMemoryProgress>(
          ComputeMemoryProgress.$_createMessage);
  static ComputeMemoryProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentCards => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentCards($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentCards() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentCards() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalCards => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCards($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCards() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCards() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => $_clearField(3);
}

class CreateBackupRequest extends $pb.GeneratedMessage {
  factory CreateBackupRequest({
    $core.String? backupFolder,
    $core.bool? force,
    $core.bool? waitForCompletion,
  }) {
    final result = CreateBackupRequest._();
    if (backupFolder != null) result.backupFolder = backupFolder;
    if (force != null) result.force = force;
    if (waitForCompletion != null) result.waitForCompletion = waitForCompletion;
    return result;
  }

  CreateBackupRequest._();

  factory CreateBackupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateBackupRequest()..mergeFromBuffer(data, registry);
  factory CreateBackupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateBackupRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateBackupRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: CreateBackupRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'backupFolder')
    ..aOB(2, _omitFieldNames ? '' : 'force')
    ..aOB(3, _omitFieldNames ? '' : 'waitForCompletion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBackupRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBackupRequest copyWith(void Function(CreateBackupRequest) updates) =>
      super.copyWith((message) => updates(message as CreateBackupRequest))
          as CreateBackupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use CreateBackupRequest() / CreateBackupRequest.new instead')
  static CreateBackupRequest create() => CreateBackupRequest._();
  static $pb.GeneratedMessage $_createMessage() => CreateBackupRequest._();
  @$core.override
  CreateBackupRequest createEmptyInstance() => CreateBackupRequest._();
  @$core.pragma('dart2js:noInline')
  static CreateBackupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateBackupRequest>(
          CreateBackupRequest.$_createMessage);
  static CreateBackupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get backupFolder => $_getSZ(0);
  @$pb.TagNumber(1)
  set backupFolder($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBackupFolder() => $_has(0);
  @$pb.TagNumber(1)
  void clearBackupFolder() => $_clearField(1);

  /// Create a backup even if the configured interval hasn't elapsed yet.
  @$pb.TagNumber(2)
  $core.bool get force => $_getBF(1);
  @$pb.TagNumber(2)
  set force($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasForce() => $_has(1);
  @$pb.TagNumber(2)
  void clearForce() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get waitForCompletion => $_getBF(2);
  @$pb.TagNumber(3)
  set waitForCompletion($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWaitForCompletion() => $_has(2);
  @$pb.TagNumber(3)
  void clearWaitForCompletion() => $_clearField(3);
}

class GetCustomColoursResponse extends $pb.GeneratedMessage {
  factory GetCustomColoursResponse({
    $core.Iterable<$core.String>? colours,
  }) {
    final result = GetCustomColoursResponse._();
    if (colours != null) result.colours.addAll(colours);
    return result;
  }

  GetCustomColoursResponse._();

  factory GetCustomColoursResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetCustomColoursResponse()..mergeFromBuffer(data, registry);
  factory GetCustomColoursResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetCustomColoursResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomColoursResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: GetCustomColoursResponse.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'colours')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomColoursResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomColoursResponse copyWith(
          void Function(GetCustomColoursResponse) updates) =>
      super.copyWith((message) => updates(message as GetCustomColoursResponse))
          as GetCustomColoursResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetCustomColoursResponse() / GetCustomColoursResponse.new instead')
  static GetCustomColoursResponse create() => GetCustomColoursResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetCustomColoursResponse._();
  @$core.override
  GetCustomColoursResponse createEmptyInstance() =>
      GetCustomColoursResponse._();
  @$core.pragma('dart2js:noInline')
  static GetCustomColoursResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomColoursResponse>(
          GetCustomColoursResponse.$_createMessage);
  static GetCustomColoursResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get colours => $_getList(0);
}

class DownloadUpdateProgress extends $pb.GeneratedMessage {
  factory DownloadUpdateProgress({
    $core.int? downloadedBytes,
    $core.int? totalBytes,
  }) {
    final result = DownloadUpdateProgress._();
    if (downloadedBytes != null) result.downloadedBytes = downloadedBytes;
    if (totalBytes != null) result.totalBytes = totalBytes;
    return result;
  }

  DownloadUpdateProgress._();

  factory DownloadUpdateProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DownloadUpdateProgress()..mergeFromBuffer(data, registry);
  factory DownloadUpdateProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DownloadUpdateProgress()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadUpdateProgress',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'anki.collection'),
      createEmptyInstance: DownloadUpdateProgress.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'downloadedBytes',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'totalBytes', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DownloadUpdateProgress clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DownloadUpdateProgress copyWith(
          void Function(DownloadUpdateProgress) updates) =>
      super.copyWith((message) => updates(message as DownloadUpdateProgress))
          as DownloadUpdateProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DownloadUpdateProgress() / DownloadUpdateProgress.new instead')
  static DownloadUpdateProgress create() => DownloadUpdateProgress._();
  static $pb.GeneratedMessage $_createMessage() => DownloadUpdateProgress._();
  @$core.override
  DownloadUpdateProgress createEmptyInstance() => DownloadUpdateProgress._();
  @$core.pragma('dart2js:noInline')
  static DownloadUpdateProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadUpdateProgress>(
          DownloadUpdateProgress.$_createMessage);
  static DownloadUpdateProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get downloadedBytes => $_getIZ(0);
  @$pb.TagNumber(1)
  set downloadedBytes($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDownloadedBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearDownloadedBytes() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalBytes => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalBytes($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalBytes() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalBytes() => $_clearField(2);
}

class CollectionServiceApi {
  final $pb.RpcClient _client;

  CollectionServiceApi(this._client);

  $async.Future<CheckDatabaseResponse> checkDatabase(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<CheckDatabaseResponse>(ctx, 'CollectionService',
          'CheckDatabase', request, CheckDatabaseResponse());
  $async.Future<UndoStatus> getUndoStatus(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<UndoStatus>(
          ctx, 'CollectionService', 'GetUndoStatus', request, UndoStatus());
  $async.Future<OpChangesAfterUndo> undo(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<OpChangesAfterUndo>(
          ctx, 'CollectionService', 'Undo', request, OpChangesAfterUndo());
  $async.Future<OpChangesAfterUndo> redo(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<OpChangesAfterUndo>(
          ctx, 'CollectionService', 'Redo', request, OpChangesAfterUndo());
  $async.Future<$0.UInt32> addCustomUndoEntry(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$0.UInt32>(
          ctx, 'CollectionService', 'AddCustomUndoEntry', request, $0.UInt32());
  $async.Future<OpChanges> mergeUndoEntries(
          $pb.ClientContext? ctx, $0.UInt32 request) =>
      _client.invoke<OpChanges>(
          ctx, 'CollectionService', 'MergeUndoEntries', request, OpChanges());
  $async.Future<Progress> latestProgress(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<Progress>(
          ctx, 'CollectionService', 'LatestProgress', request, Progress());
  $async.Future<$0.Empty> setWantsAbort(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(
          ctx, 'CollectionService', 'SetWantsAbort', request, $0.Empty());
  $async.Future<OpChanges> setLoadBalancerEnabled(
          $pb.ClientContext? ctx, $0.Bool request) =>
      _client.invoke<OpChanges>(ctx, 'CollectionService',
          'SetLoadBalancerEnabled', request, OpChanges());
  $async.Future<GetCustomColoursResponse> getCustomColours(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<GetCustomColoursResponse>(ctx, 'CollectionService',
          'GetCustomColours', request, GetCustomColoursResponse());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendCollectionServiceApi {
  final $pb.RpcClient _client;

  BackendCollectionServiceApi(this._client);

  $async.Future<$0.Empty> openCollection(
          $pb.ClientContext? ctx, OpenCollectionRequest request) =>
      _client.invoke<$0.Empty>(ctx, 'BackendCollectionService',
          'OpenCollection', request, $0.Empty());
  $async.Future<$0.Empty> closeCollection(
          $pb.ClientContext? ctx, CloseCollectionRequest request) =>
      _client.invoke<$0.Empty>(ctx, 'BackendCollectionService',
          'CloseCollection', request, $0.Empty());

  /// Create a no-media backup. Caller must ensure there is no active
  /// transaction. Unlike a collection export, does not require reopening the DB,
  /// as there is no downgrade step.
  /// Returns false if it's not time to make a backup yet.
  $async.Future<$0.Bool> createBackup(
          $pb.ClientContext? ctx, CreateBackupRequest request) =>
      _client.invoke<$0.Bool>(
          ctx, 'BackendCollectionService', 'CreateBackup', request, $0.Bool());

  /// If a backup is running, wait for it to complete. Will return an error
  /// if the backup encountered an error.
  $async.Future<$0.Empty> awaitBackupCompletion(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(ctx, 'BackendCollectionService',
          'AwaitBackupCompletion', request, $0.Empty());
  $async.Future<Progress> latestProgress(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<Progress>(ctx, 'BackendCollectionService',
          'LatestProgress', request, Progress());
  $async.Future<$0.Empty> setWantsAbort(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(ctx, 'BackendCollectionService', 'SetWantsAbort',
          request, $0.Empty());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
