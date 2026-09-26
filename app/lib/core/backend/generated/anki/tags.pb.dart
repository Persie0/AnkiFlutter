// This is a generated file - do not edit.
//
// Generated from anki/tags.proto.

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

import 'collection.pb.dart' as $1;
import 'generic.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SetTagCollapsedRequest extends $pb.GeneratedMessage {
  factory SetTagCollapsedRequest({
    $core.String? name,
    $core.bool? collapsed,
  }) {
    final result = SetTagCollapsedRequest._();
    if (name != null) result.name = name;
    if (collapsed != null) result.collapsed = collapsed;
    return result;
  }

  SetTagCollapsedRequest._();

  factory SetTagCollapsedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetTagCollapsedRequest()..mergeFromBuffer(data, registry);
  factory SetTagCollapsedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetTagCollapsedRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetTagCollapsedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: SetTagCollapsedRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'collapsed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetTagCollapsedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetTagCollapsedRequest copyWith(
          void Function(SetTagCollapsedRequest) updates) =>
      super.copyWith((message) => updates(message as SetTagCollapsedRequest))
          as SetTagCollapsedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetTagCollapsedRequest() / SetTagCollapsedRequest.new instead')
  static SetTagCollapsedRequest create() => SetTagCollapsedRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetTagCollapsedRequest._();
  @$core.override
  SetTagCollapsedRequest createEmptyInstance() => SetTagCollapsedRequest._();
  @$core.pragma('dart2js:noInline')
  static SetTagCollapsedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetTagCollapsedRequest>(
          SetTagCollapsedRequest.$_createMessage);
  static SetTagCollapsedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get collapsed => $_getBF(1);
  @$pb.TagNumber(2)
  set collapsed($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCollapsed() => $_has(1);
  @$pb.TagNumber(2)
  void clearCollapsed() => $_clearField(2);
}

class TagTreeNode extends $pb.GeneratedMessage {
  factory TagTreeNode({
    $core.String? name,
    $core.Iterable<TagTreeNode>? children,
    $core.int? level,
    $core.bool? collapsed,
  }) {
    final result = TagTreeNode._();
    if (name != null) result.name = name;
    if (children != null) result.children.addAll(children);
    if (level != null) result.level = level;
    if (collapsed != null) result.collapsed = collapsed;
    return result;
  }

  TagTreeNode._();

  factory TagTreeNode.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagTreeNode()..mergeFromBuffer(data, registry);
  factory TagTreeNode.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TagTreeNode()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TagTreeNode',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: TagTreeNode.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPM<TagTreeNode>(2, _omitFieldNames ? '' : 'children',
        subBuilder: TagTreeNode.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'level', fieldType: $pb.PbFieldType.OU3)
    ..aOB(4, _omitFieldNames ? '' : 'collapsed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagTreeNode clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TagTreeNode copyWith(void Function(TagTreeNode) updates) =>
      super.copyWith((message) => updates(message as TagTreeNode))
          as TagTreeNode;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TagTreeNode() / TagTreeNode.new instead')
  static TagTreeNode create() => TagTreeNode._();
  static $pb.GeneratedMessage $_createMessage() => TagTreeNode._();
  @$core.override
  TagTreeNode createEmptyInstance() => TagTreeNode._();
  @$core.pragma('dart2js:noInline')
  static TagTreeNode getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TagTreeNode>(
          TagTreeNode.$_createMessage);
  static TagTreeNode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<TagTreeNode> get children => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get level => $_getIZ(2);
  @$pb.TagNumber(3)
  set level($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLevel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get collapsed => $_getBF(3);
  @$pb.TagNumber(4)
  set collapsed($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCollapsed() => $_has(3);
  @$pb.TagNumber(4)
  void clearCollapsed() => $_clearField(4);
}

class ReparentTagsRequest extends $pb.GeneratedMessage {
  factory ReparentTagsRequest({
    $core.Iterable<$core.String>? tags,
    $core.String? newParent,
  }) {
    final result = ReparentTagsRequest._();
    if (tags != null) result.tags.addAll(tags);
    if (newParent != null) result.newParent = newParent;
    return result;
  }

  ReparentTagsRequest._();

  factory ReparentTagsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReparentTagsRequest()..mergeFromBuffer(data, registry);
  factory ReparentTagsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReparentTagsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReparentTagsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: ReparentTagsRequest.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'tags')
    ..aOS(2, _omitFieldNames ? '' : 'newParent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReparentTagsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReparentTagsRequest copyWith(void Function(ReparentTagsRequest) updates) =>
      super.copyWith((message) => updates(message as ReparentTagsRequest))
          as ReparentTagsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ReparentTagsRequest() / ReparentTagsRequest.new instead')
  static ReparentTagsRequest create() => ReparentTagsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReparentTagsRequest._();
  @$core.override
  ReparentTagsRequest createEmptyInstance() => ReparentTagsRequest._();
  @$core.pragma('dart2js:noInline')
  static ReparentTagsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReparentTagsRequest>(
          ReparentTagsRequest.$_createMessage);
  static ReparentTagsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get tags => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get newParent => $_getSZ(1);
  @$pb.TagNumber(2)
  set newParent($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewParent() => $_clearField(2);
}

class RenameTagsRequest extends $pb.GeneratedMessage {
  factory RenameTagsRequest({
    $core.String? currentPrefix,
    $core.String? newPrefix,
  }) {
    final result = RenameTagsRequest._();
    if (currentPrefix != null) result.currentPrefix = currentPrefix;
    if (newPrefix != null) result.newPrefix = newPrefix;
    return result;
  }

  RenameTagsRequest._();

  factory RenameTagsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenameTagsRequest()..mergeFromBuffer(data, registry);
  factory RenameTagsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RenameTagsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RenameTagsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: RenameTagsRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'currentPrefix')
    ..aOS(2, _omitFieldNames ? '' : 'newPrefix')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenameTagsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RenameTagsRequest copyWith(void Function(RenameTagsRequest) updates) =>
      super.copyWith((message) => updates(message as RenameTagsRequest))
          as RenameTagsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RenameTagsRequest() / RenameTagsRequest.new instead')
  static RenameTagsRequest create() => RenameTagsRequest._();
  static $pb.GeneratedMessage $_createMessage() => RenameTagsRequest._();
  @$core.override
  RenameTagsRequest createEmptyInstance() => RenameTagsRequest._();
  @$core.pragma('dart2js:noInline')
  static RenameTagsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameTagsRequest>(
          RenameTagsRequest.$_createMessage);
  static RenameTagsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentPrefix => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPrefix($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPrefix() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPrefix() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPrefix => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPrefix($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewPrefix() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPrefix() => $_clearField(2);
}

class NoteIdsAndTagsRequest extends $pb.GeneratedMessage {
  factory NoteIdsAndTagsRequest({
    $core.Iterable<$fixnum.Int64>? noteIds,
    $core.String? tags,
  }) {
    final result = NoteIdsAndTagsRequest._();
    if (noteIds != null) result.noteIds.addAll(noteIds);
    if (tags != null) result.tags = tags;
    return result;
  }

  NoteIdsAndTagsRequest._();

  factory NoteIdsAndTagsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NoteIdsAndTagsRequest()..mergeFromBuffer(data, registry);
  factory NoteIdsAndTagsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NoteIdsAndTagsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NoteIdsAndTagsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: NoteIdsAndTagsRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'noteIds', $pb.PbFieldType.K6)
    ..aOS(2, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NoteIdsAndTagsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NoteIdsAndTagsRequest copyWith(
          void Function(NoteIdsAndTagsRequest) updates) =>
      super.copyWith((message) => updates(message as NoteIdsAndTagsRequest))
          as NoteIdsAndTagsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use NoteIdsAndTagsRequest() / NoteIdsAndTagsRequest.new instead')
  static NoteIdsAndTagsRequest create() => NoteIdsAndTagsRequest._();
  static $pb.GeneratedMessage $_createMessage() => NoteIdsAndTagsRequest._();
  @$core.override
  NoteIdsAndTagsRequest createEmptyInstance() => NoteIdsAndTagsRequest._();
  @$core.pragma('dart2js:noInline')
  static NoteIdsAndTagsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NoteIdsAndTagsRequest>(
          NoteIdsAndTagsRequest.$_createMessage);
  static NoteIdsAndTagsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get noteIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get tags => $_getSZ(1);
  @$pb.TagNumber(2)
  set tags($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTags() => $_has(1);
  @$pb.TagNumber(2)
  void clearTags() => $_clearField(2);
}

class FindAndReplaceTagRequest extends $pb.GeneratedMessage {
  factory FindAndReplaceTagRequest({
    $core.Iterable<$fixnum.Int64>? noteIds,
    $core.String? search,
    $core.String? replacement,
    $core.bool? regex,
    $core.bool? matchCase,
  }) {
    final result = FindAndReplaceTagRequest._();
    if (noteIds != null) result.noteIds.addAll(noteIds);
    if (search != null) result.search = search;
    if (replacement != null) result.replacement = replacement;
    if (regex != null) result.regex = regex;
    if (matchCase != null) result.matchCase = matchCase;
    return result;
  }

  FindAndReplaceTagRequest._();

  factory FindAndReplaceTagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FindAndReplaceTagRequest()..mergeFromBuffer(data, registry);
  factory FindAndReplaceTagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FindAndReplaceTagRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindAndReplaceTagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: FindAndReplaceTagRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'noteIds', $pb.PbFieldType.K6)
    ..aOS(2, _omitFieldNames ? '' : 'search')
    ..aOS(3, _omitFieldNames ? '' : 'replacement')
    ..aOB(4, _omitFieldNames ? '' : 'regex')
    ..aOB(5, _omitFieldNames ? '' : 'matchCase')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindAndReplaceTagRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindAndReplaceTagRequest copyWith(
          void Function(FindAndReplaceTagRequest) updates) =>
      super.copyWith((message) => updates(message as FindAndReplaceTagRequest))
          as FindAndReplaceTagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FindAndReplaceTagRequest() / FindAndReplaceTagRequest.new instead')
  static FindAndReplaceTagRequest create() => FindAndReplaceTagRequest._();
  static $pb.GeneratedMessage $_createMessage() => FindAndReplaceTagRequest._();
  @$core.override
  FindAndReplaceTagRequest createEmptyInstance() =>
      FindAndReplaceTagRequest._();
  @$core.pragma('dart2js:noInline')
  static FindAndReplaceTagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindAndReplaceTagRequest>(
          FindAndReplaceTagRequest.$_createMessage);
  static FindAndReplaceTagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get noteIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get search => $_getSZ(1);
  @$pb.TagNumber(2)
  set search($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSearch() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearch() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get replacement => $_getSZ(2);
  @$pb.TagNumber(3)
  set replacement($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReplacement() => $_has(2);
  @$pb.TagNumber(3)
  void clearReplacement() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get regex => $_getBF(3);
  @$pb.TagNumber(4)
  set regex($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRegex() => $_has(3);
  @$pb.TagNumber(4)
  void clearRegex() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get matchCase => $_getBF(4);
  @$pb.TagNumber(5)
  set matchCase($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMatchCase() => $_has(4);
  @$pb.TagNumber(5)
  void clearMatchCase() => $_clearField(5);
}

class CompleteTagRequest extends $pb.GeneratedMessage {
  factory CompleteTagRequest({
    $core.String? input,
    $core.int? matchLimit,
  }) {
    final result = CompleteTagRequest._();
    if (input != null) result.input = input;
    if (matchLimit != null) result.matchLimit = matchLimit;
    return result;
  }

  CompleteTagRequest._();

  factory CompleteTagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteTagRequest()..mergeFromBuffer(data, registry);
  factory CompleteTagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteTagRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteTagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: CompleteTagRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'input')
    ..aI(2, _omitFieldNames ? '' : 'matchLimit', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTagRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTagRequest copyWith(void Function(CompleteTagRequest) updates) =>
      super.copyWith((message) => updates(message as CompleteTagRequest))
          as CompleteTagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CompleteTagRequest() / CompleteTagRequest.new instead')
  static CompleteTagRequest create() => CompleteTagRequest._();
  static $pb.GeneratedMessage $_createMessage() => CompleteTagRequest._();
  @$core.override
  CompleteTagRequest createEmptyInstance() => CompleteTagRequest._();
  @$core.pragma('dart2js:noInline')
  static CompleteTagRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteTagRequest>(
          CompleteTagRequest.$_createMessage);
  static CompleteTagRequest? _defaultInstance;

  /// a partial tag, optionally delimited with ::
  @$pb.TagNumber(1)
  $core.String get input => $_getSZ(0);
  @$pb.TagNumber(1)
  set input($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInput() => $_has(0);
  @$pb.TagNumber(1)
  void clearInput() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get matchLimit => $_getIZ(1);
  @$pb.TagNumber(2)
  set matchLimit($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMatchLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearMatchLimit() => $_clearField(2);
}

class CompleteTagResponse extends $pb.GeneratedMessage {
  factory CompleteTagResponse({
    $core.Iterable<$core.String>? tags,
  }) {
    final result = CompleteTagResponse._();
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  CompleteTagResponse._();

  factory CompleteTagResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteTagResponse()..mergeFromBuffer(data, registry);
  factory CompleteTagResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteTagResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteTagResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.tags'),
      createEmptyInstance: CompleteTagResponse.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTagResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTagResponse copyWith(void Function(CompleteTagResponse) updates) =>
      super.copyWith((message) => updates(message as CompleteTagResponse))
          as CompleteTagResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use CompleteTagResponse() / CompleteTagResponse.new instead')
  static CompleteTagResponse create() => CompleteTagResponse._();
  static $pb.GeneratedMessage $_createMessage() => CompleteTagResponse._();
  @$core.override
  CompleteTagResponse createEmptyInstance() => CompleteTagResponse._();
  @$core.pragma('dart2js:noInline')
  static CompleteTagResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteTagResponse>(
          CompleteTagResponse.$_createMessage);
  static CompleteTagResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get tags => $_getList(0);
}

class TagsServiceApi {
  final $pb.RpcClient _client;

  TagsServiceApi(this._client);

  $async.Future<$1.OpChangesWithCount> clearUnusedTags(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$1.OpChangesWithCount>(ctx, 'TagsService',
          'ClearUnusedTags', request, $1.OpChangesWithCount());
  $async.Future<$0.StringList> allTags(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.StringList>(
          ctx, 'TagsService', 'AllTags', request, $0.StringList());
  $async.Future<$1.OpChangesWithCount> removeTags(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$1.OpChangesWithCount>(
          ctx, 'TagsService', 'RemoveTags', request, $1.OpChangesWithCount());
  $async.Future<$1.OpChanges> setTagCollapsed(
          $pb.ClientContext? ctx, SetTagCollapsedRequest request) =>
      _client.invoke<$1.OpChanges>(
          ctx, 'TagsService', 'SetTagCollapsed', request, $1.OpChanges());
  $async.Future<TagTreeNode> tagTree(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<TagTreeNode>(
          ctx, 'TagsService', 'TagTree', request, TagTreeNode());
  $async.Future<$1.OpChangesWithCount> reparentTags(
          $pb.ClientContext? ctx, ReparentTagsRequest request) =>
      _client.invoke<$1.OpChangesWithCount>(
          ctx, 'TagsService', 'ReparentTags', request, $1.OpChangesWithCount());
  $async.Future<$1.OpChangesWithCount> renameTags(
          $pb.ClientContext? ctx, RenameTagsRequest request) =>
      _client.invoke<$1.OpChangesWithCount>(
          ctx, 'TagsService', 'RenameTags', request, $1.OpChangesWithCount());
  $async.Future<$1.OpChangesWithCount> addNoteTags(
          $pb.ClientContext? ctx, NoteIdsAndTagsRequest request) =>
      _client.invoke<$1.OpChangesWithCount>(
          ctx, 'TagsService', 'AddNoteTags', request, $1.OpChangesWithCount());
  $async.Future<$1.OpChangesWithCount> removeNoteTags(
          $pb.ClientContext? ctx, NoteIdsAndTagsRequest request) =>
      _client.invoke<$1.OpChangesWithCount>(ctx, 'TagsService',
          'RemoveNoteTags', request, $1.OpChangesWithCount());
  $async.Future<$1.OpChangesWithCount> findAndReplaceTag(
          $pb.ClientContext? ctx, FindAndReplaceTagRequest request) =>
      _client.invoke<$1.OpChangesWithCount>(ctx, 'TagsService',
          'FindAndReplaceTag', request, $1.OpChangesWithCount());
  $async.Future<CompleteTagResponse> completeTag(
          $pb.ClientContext? ctx, CompleteTagRequest request) =>
      _client.invoke<CompleteTagResponse>(
          ctx, 'TagsService', 'CompleteTag', request, CompleteTagResponse());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendTagsServiceApi {
  final $pb.RpcClient _client;

  BackendTagsServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
