// This is a generated file - do not edit.
//
// Generated from anki/search.proto.

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
import 'search.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'search.pbenum.dart';

class SearchNode_Dupe extends $pb.GeneratedMessage {
  factory SearchNode_Dupe({
    $fixnum.Int64? notetypeId,
    $core.String? firstField,
  }) {
    final result = SearchNode_Dupe._();
    if (notetypeId != null) result.notetypeId = notetypeId;
    if (firstField != null) result.firstField = firstField;
    return result;
  }

  SearchNode_Dupe._();

  factory SearchNode_Dupe.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Dupe()..mergeFromBuffer(data, registry);
  factory SearchNode_Dupe.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Dupe()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchNode.Dupe',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchNode_Dupe.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'notetypeId')
    ..aOS(2, _omitFieldNames ? '' : 'firstField')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Dupe clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Dupe copyWith(void Function(SearchNode_Dupe) updates) =>
      super.copyWith((message) => updates(message as SearchNode_Dupe))
          as SearchNode_Dupe;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchNode_Dupe() / SearchNode_Dupe.new instead')
  static SearchNode_Dupe create() => SearchNode_Dupe._();
  static $pb.GeneratedMessage $_createMessage() => SearchNode_Dupe._();
  @$core.override
  SearchNode_Dupe createEmptyInstance() => SearchNode_Dupe._();
  @$core.pragma('dart2js:noInline')
  static SearchNode_Dupe getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchNode_Dupe>(
          SearchNode_Dupe.$_createMessage);
  static SearchNode_Dupe? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get notetypeId => $_getI64(0);
  @$pb.TagNumber(1)
  set notetypeId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNotetypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotetypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstField => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstField($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirstField() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstField() => $_clearField(2);
}

class SearchNode_Rated extends $pb.GeneratedMessage {
  factory SearchNode_Rated({
    $core.int? days,
    SearchNode_Rating? rating,
  }) {
    final result = SearchNode_Rated._();
    if (days != null) result.days = days;
    if (rating != null) result.rating = rating;
    return result;
  }

  SearchNode_Rated._();

  factory SearchNode_Rated.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Rated()..mergeFromBuffer(data, registry);
  factory SearchNode_Rated.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Rated()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchNode.Rated',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchNode_Rated.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'days', fieldType: $pb.PbFieldType.OU3)
    ..aE<SearchNode_Rating>(2, _omitFieldNames ? '' : 'rating',
        enumValues: SearchNode_Rating.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Rated clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Rated copyWith(void Function(SearchNode_Rated) updates) =>
      super.copyWith((message) => updates(message as SearchNode_Rated))
          as SearchNode_Rated;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchNode_Rated() / SearchNode_Rated.new instead')
  static SearchNode_Rated create() => SearchNode_Rated._();
  static $pb.GeneratedMessage $_createMessage() => SearchNode_Rated._();
  @$core.override
  SearchNode_Rated createEmptyInstance() => SearchNode_Rated._();
  @$core.pragma('dart2js:noInline')
  static SearchNode_Rated getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchNode_Rated>(
          SearchNode_Rated.$_createMessage);
  static SearchNode_Rated? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get days => $_getIZ(0);
  @$pb.TagNumber(1)
  set days($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDays() => $_has(0);
  @$pb.TagNumber(1)
  void clearDays() => $_clearField(1);

  @$pb.TagNumber(2)
  SearchNode_Rating get rating => $_getN(1);
  @$pb.TagNumber(2)
  set rating(SearchNode_Rating value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRating() => $_has(1);
  @$pb.TagNumber(2)
  void clearRating() => $_clearField(2);
}

class SearchNode_IdList extends $pb.GeneratedMessage {
  factory SearchNode_IdList({
    $core.Iterable<$fixnum.Int64>? ids,
  }) {
    final result = SearchNode_IdList._();
    if (ids != null) result.ids.addAll(ids);
    return result;
  }

  SearchNode_IdList._();

  factory SearchNode_IdList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_IdList()..mergeFromBuffer(data, registry);
  factory SearchNode_IdList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_IdList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchNode.IdList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchNode_IdList.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'ids', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_IdList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_IdList copyWith(void Function(SearchNode_IdList) updates) =>
      super.copyWith((message) => updates(message as SearchNode_IdList))
          as SearchNode_IdList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchNode_IdList() / SearchNode_IdList.new instead')
  static SearchNode_IdList create() => SearchNode_IdList._();
  static $pb.GeneratedMessage $_createMessage() => SearchNode_IdList._();
  @$core.override
  SearchNode_IdList createEmptyInstance() => SearchNode_IdList._();
  @$core.pragma('dart2js:noInline')
  static SearchNode_IdList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchNode_IdList>(
          SearchNode_IdList.$_createMessage);
  static SearchNode_IdList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get ids => $_getList(0);
}

class SearchNode_Group extends $pb.GeneratedMessage {
  factory SearchNode_Group({
    $core.Iterable<SearchNode>? nodes,
    SearchNode_Group_Joiner? joiner,
  }) {
    final result = SearchNode_Group._();
    if (nodes != null) result.nodes.addAll(nodes);
    if (joiner != null) result.joiner = joiner;
    return result;
  }

  SearchNode_Group._();

  factory SearchNode_Group.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Group()..mergeFromBuffer(data, registry);
  factory SearchNode_Group.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Group()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchNode.Group',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchNode_Group.$_createMessage)
    ..pPM<SearchNode>(1, _omitFieldNames ? '' : 'nodes',
        subBuilder: SearchNode.$_createMessage)
    ..aE<SearchNode_Group_Joiner>(2, _omitFieldNames ? '' : 'joiner',
        enumValues: SearchNode_Group_Joiner.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Group clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Group copyWith(void Function(SearchNode_Group) updates) =>
      super.copyWith((message) => updates(message as SearchNode_Group))
          as SearchNode_Group;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchNode_Group() / SearchNode_Group.new instead')
  static SearchNode_Group create() => SearchNode_Group._();
  static $pb.GeneratedMessage $_createMessage() => SearchNode_Group._();
  @$core.override
  SearchNode_Group createEmptyInstance() => SearchNode_Group._();
  @$core.pragma('dart2js:noInline')
  static SearchNode_Group getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchNode_Group>(
          SearchNode_Group.$_createMessage);
  static SearchNode_Group? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SearchNode> get nodes => $_getList(0);

  @$pb.TagNumber(2)
  SearchNode_Group_Joiner get joiner => $_getN(1);
  @$pb.TagNumber(2)
  set joiner(SearchNode_Group_Joiner value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasJoiner() => $_has(1);
  @$pb.TagNumber(2)
  void clearJoiner() => $_clearField(2);
}

class SearchNode_Field extends $pb.GeneratedMessage {
  factory SearchNode_Field({
    $core.String? fieldName,
    $core.String? text,
    SearchNode_FieldSearchMode? mode,
  }) {
    final result = SearchNode_Field._();
    if (fieldName != null) result.fieldName = fieldName;
    if (text != null) result.text = text;
    if (mode != null) result.mode = mode;
    return result;
  }

  SearchNode_Field._();

  factory SearchNode_Field.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Field()..mergeFromBuffer(data, registry);
  factory SearchNode_Field.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode_Field()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchNode.Field',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchNode_Field.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'fieldName')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..aE<SearchNode_FieldSearchMode>(3, _omitFieldNames ? '' : 'mode',
        enumValues: SearchNode_FieldSearchMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Field clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode_Field copyWith(void Function(SearchNode_Field) updates) =>
      super.copyWith((message) => updates(message as SearchNode_Field))
          as SearchNode_Field;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchNode_Field() / SearchNode_Field.new instead')
  static SearchNode_Field create() => SearchNode_Field._();
  static $pb.GeneratedMessage $_createMessage() => SearchNode_Field._();
  @$core.override
  SearchNode_Field createEmptyInstance() => SearchNode_Field._();
  @$core.pragma('dart2js:noInline')
  static SearchNode_Field getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchNode_Field>(
          SearchNode_Field.$_createMessage);
  static SearchNode_Field? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fieldName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fieldName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFieldName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFieldName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => $_clearField(2);

  @$pb.TagNumber(3)
  SearchNode_FieldSearchMode get mode => $_getN(2);
  @$pb.TagNumber(3)
  set mode(SearchNode_FieldSearchMode value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMode() => $_has(2);
  @$pb.TagNumber(3)
  void clearMode() => $_clearField(3);
}

enum SearchNode_Filter {
  group,
  negated,
  parsableText,
  template,
  nid,
  dupe,
  fieldName,
  rated,
  addedInDays,
  dueInDays,
  flag,
  cardState,
  nids,
  editedInDays,
  deck,
  dueOnDay,
  tag,
  note,
  introducedInDays,
  field_20,
  literalText,
  notSet
}

class SearchNode extends $pb.GeneratedMessage {
  factory SearchNode({
    SearchNode_Group? group,
    SearchNode? negated,
    $core.String? parsableText,
    $core.int? template,
    $fixnum.Int64? nid,
    SearchNode_Dupe? dupe,
    $core.String? fieldName,
    SearchNode_Rated? rated,
    $core.int? addedInDays,
    $core.int? dueInDays,
    SearchNode_Flag? flag,
    SearchNode_CardState? cardState,
    SearchNode_IdList? nids,
    $core.int? editedInDays,
    $core.String? deck,
    $core.int? dueOnDay,
    $core.String? tag,
    $core.String? note,
    $core.int? introducedInDays,
    SearchNode_Field? field_20,
    $core.String? literalText,
  }) {
    final result = SearchNode._();
    if (group != null) result.group = group;
    if (negated != null) result.negated = negated;
    if (parsableText != null) result.parsableText = parsableText;
    if (template != null) result.template = template;
    if (nid != null) result.nid = nid;
    if (dupe != null) result.dupe = dupe;
    if (fieldName != null) result.fieldName = fieldName;
    if (rated != null) result.rated = rated;
    if (addedInDays != null) result.addedInDays = addedInDays;
    if (dueInDays != null) result.dueInDays = dueInDays;
    if (flag != null) result.flag = flag;
    if (cardState != null) result.cardState = cardState;
    if (nids != null) result.nids = nids;
    if (editedInDays != null) result.editedInDays = editedInDays;
    if (deck != null) result.deck = deck;
    if (dueOnDay != null) result.dueOnDay = dueOnDay;
    if (tag != null) result.tag = tag;
    if (note != null) result.note = note;
    if (introducedInDays != null) result.introducedInDays = introducedInDays;
    if (field_20 != null) result.field_20 = field_20;
    if (literalText != null) result.literalText = literalText;
    return result;
  }

  SearchNode._();

  factory SearchNode.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode()..mergeFromBuffer(data, registry);
  factory SearchNode.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchNode()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SearchNode_Filter> _SearchNode_FilterByTag =
      {
    1: SearchNode_Filter.group,
    2: SearchNode_Filter.negated,
    3: SearchNode_Filter.parsableText,
    4: SearchNode_Filter.template,
    5: SearchNode_Filter.nid,
    6: SearchNode_Filter.dupe,
    7: SearchNode_Filter.fieldName,
    8: SearchNode_Filter.rated,
    9: SearchNode_Filter.addedInDays,
    10: SearchNode_Filter.dueInDays,
    11: SearchNode_Filter.flag,
    12: SearchNode_Filter.cardState,
    13: SearchNode_Filter.nids,
    14: SearchNode_Filter.editedInDays,
    15: SearchNode_Filter.deck,
    16: SearchNode_Filter.dueOnDay,
    17: SearchNode_Filter.tag,
    18: SearchNode_Filter.note,
    19: SearchNode_Filter.introducedInDays,
    20: SearchNode_Filter.field_20,
    21: SearchNode_Filter.literalText,
    0: SearchNode_Filter.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchNode',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchNode.$_createMessage)
    ..oo(0, [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21
    ])
    ..aOM<SearchNode_Group>(1, _omitFieldNames ? '' : 'group',
        subBuilder: SearchNode_Group.$_createMessage)
    ..aOM<SearchNode>(2, _omitFieldNames ? '' : 'negated',
        subBuilder: SearchNode.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'parsableText')
    ..aI(4, _omitFieldNames ? '' : 'template', fieldType: $pb.PbFieldType.OU3)
    ..aInt64(5, _omitFieldNames ? '' : 'nid')
    ..aOM<SearchNode_Dupe>(6, _omitFieldNames ? '' : 'dupe',
        subBuilder: SearchNode_Dupe.$_createMessage)
    ..aOS(7, _omitFieldNames ? '' : 'fieldName')
    ..aOM<SearchNode_Rated>(8, _omitFieldNames ? '' : 'rated',
        subBuilder: SearchNode_Rated.$_createMessage)
    ..aI(9, _omitFieldNames ? '' : 'addedInDays',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(10, _omitFieldNames ? '' : 'dueInDays')
    ..aE<SearchNode_Flag>(11, _omitFieldNames ? '' : 'flag',
        enumValues: SearchNode_Flag.values)
    ..aE<SearchNode_CardState>(12, _omitFieldNames ? '' : 'cardState',
        enumValues: SearchNode_CardState.values)
    ..aOM<SearchNode_IdList>(13, _omitFieldNames ? '' : 'nids',
        subBuilder: SearchNode_IdList.$_createMessage)
    ..aI(14, _omitFieldNames ? '' : 'editedInDays',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(15, _omitFieldNames ? '' : 'deck')
    ..aI(16, _omitFieldNames ? '' : 'dueOnDay')
    ..aOS(17, _omitFieldNames ? '' : 'tag')
    ..aOS(18, _omitFieldNames ? '' : 'note')
    ..aI(19, _omitFieldNames ? '' : 'introducedInDays',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<SearchNode_Field>(20, _omitFieldNames ? '' : 'field',
        subBuilder: SearchNode_Field.$_createMessage)
    ..aOS(21, _omitFieldNames ? '' : 'literalText')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchNode copyWith(void Function(SearchNode) updates) =>
      super.copyWith((message) => updates(message as SearchNode)) as SearchNode;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchNode() / SearchNode.new instead')
  static SearchNode create() => SearchNode._();
  static $pb.GeneratedMessage $_createMessage() => SearchNode._();
  @$core.override
  SearchNode createEmptyInstance() => SearchNode._();
  @$core.pragma('dart2js:noInline')
  static SearchNode getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchNode>(SearchNode.$_createMessage);
  static SearchNode? _defaultInstance;

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
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  SearchNode_Filter whichFilter() => _SearchNode_FilterByTag[$_whichOneof(0)]!;
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
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  void clearFilter() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  SearchNode_Group get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(SearchNode_Group value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => $_clearField(1);
  @$pb.TagNumber(1)
  SearchNode_Group ensureGroup() => $_ensure(0);

  @$pb.TagNumber(2)
  SearchNode get negated => $_getN(1);
  @$pb.TagNumber(2)
  set negated(SearchNode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNegated() => $_has(1);
  @$pb.TagNumber(2)
  void clearNegated() => $_clearField(2);
  @$pb.TagNumber(2)
  SearchNode ensureNegated() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get parsableText => $_getSZ(2);
  @$pb.TagNumber(3)
  set parsableText($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasParsableText() => $_has(2);
  @$pb.TagNumber(3)
  void clearParsableText() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get template => $_getIZ(3);
  @$pb.TagNumber(4)
  set template($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTemplate() => $_has(3);
  @$pb.TagNumber(4)
  void clearTemplate() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get nid => $_getI64(4);
  @$pb.TagNumber(5)
  set nid($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNid() => $_has(4);
  @$pb.TagNumber(5)
  void clearNid() => $_clearField(5);

  @$pb.TagNumber(6)
  SearchNode_Dupe get dupe => $_getN(5);
  @$pb.TagNumber(6)
  set dupe(SearchNode_Dupe value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDupe() => $_has(5);
  @$pb.TagNumber(6)
  void clearDupe() => $_clearField(6);
  @$pb.TagNumber(6)
  SearchNode_Dupe ensureDupe() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get fieldName => $_getSZ(6);
  @$pb.TagNumber(7)
  set fieldName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFieldName() => $_has(6);
  @$pb.TagNumber(7)
  void clearFieldName() => $_clearField(7);

  @$pb.TagNumber(8)
  SearchNode_Rated get rated => $_getN(7);
  @$pb.TagNumber(8)
  set rated(SearchNode_Rated value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasRated() => $_has(7);
  @$pb.TagNumber(8)
  void clearRated() => $_clearField(8);
  @$pb.TagNumber(8)
  SearchNode_Rated ensureRated() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.int get addedInDays => $_getIZ(8);
  @$pb.TagNumber(9)
  set addedInDays($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAddedInDays() => $_has(8);
  @$pb.TagNumber(9)
  void clearAddedInDays() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get dueInDays => $_getIZ(9);
  @$pb.TagNumber(10)
  set dueInDays($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDueInDays() => $_has(9);
  @$pb.TagNumber(10)
  void clearDueInDays() => $_clearField(10);

  @$pb.TagNumber(11)
  SearchNode_Flag get flag => $_getN(10);
  @$pb.TagNumber(11)
  set flag(SearchNode_Flag value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasFlag() => $_has(10);
  @$pb.TagNumber(11)
  void clearFlag() => $_clearField(11);

  @$pb.TagNumber(12)
  SearchNode_CardState get cardState => $_getN(11);
  @$pb.TagNumber(12)
  set cardState(SearchNode_CardState value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCardState() => $_has(11);
  @$pb.TagNumber(12)
  void clearCardState() => $_clearField(12);

  @$pb.TagNumber(13)
  SearchNode_IdList get nids => $_getN(12);
  @$pb.TagNumber(13)
  set nids(SearchNode_IdList value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasNids() => $_has(12);
  @$pb.TagNumber(13)
  void clearNids() => $_clearField(13);
  @$pb.TagNumber(13)
  SearchNode_IdList ensureNids() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.int get editedInDays => $_getIZ(13);
  @$pb.TagNumber(14)
  set editedInDays($core.int value) => $_setUnsignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasEditedInDays() => $_has(13);
  @$pb.TagNumber(14)
  void clearEditedInDays() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get deck => $_getSZ(14);
  @$pb.TagNumber(15)
  set deck($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasDeck() => $_has(14);
  @$pb.TagNumber(15)
  void clearDeck() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get dueOnDay => $_getIZ(15);
  @$pb.TagNumber(16)
  set dueOnDay($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasDueOnDay() => $_has(15);
  @$pb.TagNumber(16)
  void clearDueOnDay() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get tag => $_getSZ(16);
  @$pb.TagNumber(17)
  set tag($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasTag() => $_has(16);
  @$pb.TagNumber(17)
  void clearTag() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get note => $_getSZ(17);
  @$pb.TagNumber(18)
  set note($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasNote() => $_has(17);
  @$pb.TagNumber(18)
  void clearNote() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get introducedInDays => $_getIZ(18);
  @$pb.TagNumber(19)
  set introducedInDays($core.int value) => $_setUnsignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasIntroducedInDays() => $_has(18);
  @$pb.TagNumber(19)
  void clearIntroducedInDays() => $_clearField(19);

  @$pb.TagNumber(20)
  SearchNode_Field get field_20 => $_getN(19);
  @$pb.TagNumber(20)
  set field_20(SearchNode_Field value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasField_20() => $_has(19);
  @$pb.TagNumber(20)
  void clearField_20() => $_clearField(20);
  @$pb.TagNumber(20)
  SearchNode_Field ensureField_20() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.String get literalText => $_getSZ(20);
  @$pb.TagNumber(21)
  set literalText($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasLiteralText() => $_has(20);
  @$pb.TagNumber(21)
  void clearLiteralText() => $_clearField(21);
}

class SearchRequest extends $pb.GeneratedMessage {
  factory SearchRequest({
    $core.String? search,
    SortOrder? order,
  }) {
    final result = SearchRequest._();
    if (search != null) result.search = search;
    if (order != null) result.order = order;
    return result;
  }

  SearchRequest._();

  factory SearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchRequest()..mergeFromBuffer(data, registry);
  factory SearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'search')
    ..aOM<SortOrder>(2, _omitFieldNames ? '' : 'order',
        subBuilder: SortOrder.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequest copyWith(void Function(SearchRequest) updates) =>
      super.copyWith((message) => updates(message as SearchRequest))
          as SearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchRequest() / SearchRequest.new instead')
  static SearchRequest create() => SearchRequest._();
  static $pb.GeneratedMessage $_createMessage() => SearchRequest._();
  @$core.override
  SearchRequest createEmptyInstance() => SearchRequest._();
  @$core.pragma('dart2js:noInline')
  static SearchRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchRequest>(
          SearchRequest.$_createMessage);
  static SearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get search => $_getSZ(0);
  @$pb.TagNumber(1)
  set search($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSearch() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearch() => $_clearField(1);

  @$pb.TagNumber(2)
  SortOrder get order => $_getN(1);
  @$pb.TagNumber(2)
  set order(SortOrder value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOrder() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrder() => $_clearField(2);
  @$pb.TagNumber(2)
  SortOrder ensureOrder() => $_ensure(1);
}

class SearchResponse extends $pb.GeneratedMessage {
  factory SearchResponse({
    $core.Iterable<$fixnum.Int64>? ids,
  }) {
    final result = SearchResponse._();
    if (ids != null) result.ids.addAll(ids);
    return result;
  }

  SearchResponse._();

  factory SearchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchResponse()..mergeFromBuffer(data, registry);
  factory SearchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SearchResponse.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'ids', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResponse copyWith(void Function(SearchResponse) updates) =>
      super.copyWith((message) => updates(message as SearchResponse))
          as SearchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchResponse() / SearchResponse.new instead')
  static SearchResponse create() => SearchResponse._();
  static $pb.GeneratedMessage $_createMessage() => SearchResponse._();
  @$core.override
  SearchResponse createEmptyInstance() => SearchResponse._();
  @$core.pragma('dart2js:noInline')
  static SearchResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchResponse>(
          SearchResponse.$_createMessage);
  static SearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get ids => $_getList(0);
}

class SortOrder_Builtin extends $pb.GeneratedMessage {
  factory SortOrder_Builtin({
    $core.String? column,
    $core.bool? reverse,
  }) {
    final result = SortOrder_Builtin._();
    if (column != null) result.column = column;
    if (reverse != null) result.reverse = reverse;
    return result;
  }

  SortOrder_Builtin._();

  factory SortOrder_Builtin.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SortOrder_Builtin()..mergeFromBuffer(data, registry);
  factory SortOrder_Builtin.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SortOrder_Builtin()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SortOrder.Builtin',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SortOrder_Builtin.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'column')
    ..aOB(2, _omitFieldNames ? '' : 'reverse')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SortOrder_Builtin clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SortOrder_Builtin copyWith(void Function(SortOrder_Builtin) updates) =>
      super.copyWith((message) => updates(message as SortOrder_Builtin))
          as SortOrder_Builtin;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SortOrder_Builtin() / SortOrder_Builtin.new instead')
  static SortOrder_Builtin create() => SortOrder_Builtin._();
  static $pb.GeneratedMessage $_createMessage() => SortOrder_Builtin._();
  @$core.override
  SortOrder_Builtin createEmptyInstance() => SortOrder_Builtin._();
  @$core.pragma('dart2js:noInline')
  static SortOrder_Builtin getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SortOrder_Builtin>(
          SortOrder_Builtin.$_createMessage);
  static SortOrder_Builtin? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get column => $_getSZ(0);
  @$pb.TagNumber(1)
  set column($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasColumn() => $_has(0);
  @$pb.TagNumber(1)
  void clearColumn() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get reverse => $_getBF(1);
  @$pb.TagNumber(2)
  set reverse($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReverse() => $_has(1);
  @$pb.TagNumber(2)
  void clearReverse() => $_clearField(2);
}

enum SortOrder_Value { none, custom, builtin, notSet }

class SortOrder extends $pb.GeneratedMessage {
  factory SortOrder({
    $0.Empty? none,
    $core.String? custom,
    SortOrder_Builtin? builtin,
  }) {
    final result = SortOrder._();
    if (none != null) result.none = none;
    if (custom != null) result.custom = custom;
    if (builtin != null) result.builtin = builtin;
    return result;
  }

  SortOrder._();

  factory SortOrder.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SortOrder()..mergeFromBuffer(data, registry);
  factory SortOrder.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SortOrder()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SortOrder_Value> _SortOrder_ValueByTag = {
    1: SortOrder_Value.none,
    2: SortOrder_Value.custom,
    3: SortOrder_Value.builtin,
    0: SortOrder_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SortOrder',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: SortOrder.$_createMessage)
    ..oo(0, [1, 2, 3])
    ..aOM<$0.Empty>(1, _omitFieldNames ? '' : 'none',
        subBuilder: $0.Empty.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'custom')
    ..aOM<SortOrder_Builtin>(3, _omitFieldNames ? '' : 'builtin',
        subBuilder: SortOrder_Builtin.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SortOrder clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SortOrder copyWith(void Function(SortOrder) updates) =>
      super.copyWith((message) => updates(message as SortOrder)) as SortOrder;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SortOrder() / SortOrder.new instead')
  static SortOrder create() => SortOrder._();
  static $pb.GeneratedMessage $_createMessage() => SortOrder._();
  @$core.override
  SortOrder createEmptyInstance() => SortOrder._();
  @$core.pragma('dart2js:noInline')
  static SortOrder getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SortOrder>(SortOrder.$_createMessage);
  static SortOrder? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  SortOrder_Value whichValue() => _SortOrder_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
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
  $core.String get custom => $_getSZ(1);
  @$pb.TagNumber(2)
  set custom($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCustom() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustom() => $_clearField(2);

  @$pb.TagNumber(3)
  SortOrder_Builtin get builtin => $_getN(2);
  @$pb.TagNumber(3)
  set builtin(SortOrder_Builtin value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBuiltin() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuiltin() => $_clearField(3);
  @$pb.TagNumber(3)
  SortOrder_Builtin ensureBuiltin() => $_ensure(2);
}

class JoinSearchNodesRequest extends $pb.GeneratedMessage {
  factory JoinSearchNodesRequest({
    SearchNode_Group_Joiner? joiner,
    SearchNode? existingNode,
    SearchNode? additionalNode,
  }) {
    final result = JoinSearchNodesRequest._();
    if (joiner != null) result.joiner = joiner;
    if (existingNode != null) result.existingNode = existingNode;
    if (additionalNode != null) result.additionalNode = additionalNode;
    return result;
  }

  JoinSearchNodesRequest._();

  factory JoinSearchNodesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinSearchNodesRequest()..mergeFromBuffer(data, registry);
  factory JoinSearchNodesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinSearchNodesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinSearchNodesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: JoinSearchNodesRequest.$_createMessage)
    ..aE<SearchNode_Group_Joiner>(1, _omitFieldNames ? '' : 'joiner',
        enumValues: SearchNode_Group_Joiner.values)
    ..aOM<SearchNode>(2, _omitFieldNames ? '' : 'existingNode',
        subBuilder: SearchNode.$_createMessage)
    ..aOM<SearchNode>(3, _omitFieldNames ? '' : 'additionalNode',
        subBuilder: SearchNode.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinSearchNodesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinSearchNodesRequest copyWith(
          void Function(JoinSearchNodesRequest) updates) =>
      super.copyWith((message) => updates(message as JoinSearchNodesRequest))
          as JoinSearchNodesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use JoinSearchNodesRequest() / JoinSearchNodesRequest.new instead')
  static JoinSearchNodesRequest create() => JoinSearchNodesRequest._();
  static $pb.GeneratedMessage $_createMessage() => JoinSearchNodesRequest._();
  @$core.override
  JoinSearchNodesRequest createEmptyInstance() => JoinSearchNodesRequest._();
  @$core.pragma('dart2js:noInline')
  static JoinSearchNodesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinSearchNodesRequest>(
          JoinSearchNodesRequest.$_createMessage);
  static JoinSearchNodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SearchNode_Group_Joiner get joiner => $_getN(0);
  @$pb.TagNumber(1)
  set joiner(SearchNode_Group_Joiner value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasJoiner() => $_has(0);
  @$pb.TagNumber(1)
  void clearJoiner() => $_clearField(1);

  @$pb.TagNumber(2)
  SearchNode get existingNode => $_getN(1);
  @$pb.TagNumber(2)
  set existingNode(SearchNode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasExistingNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearExistingNode() => $_clearField(2);
  @$pb.TagNumber(2)
  SearchNode ensureExistingNode() => $_ensure(1);

  @$pb.TagNumber(3)
  SearchNode get additionalNode => $_getN(2);
  @$pb.TagNumber(3)
  set additionalNode(SearchNode value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAdditionalNode() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdditionalNode() => $_clearField(3);
  @$pb.TagNumber(3)
  SearchNode ensureAdditionalNode() => $_ensure(2);
}

class ReplaceSearchNodeRequest extends $pb.GeneratedMessage {
  factory ReplaceSearchNodeRequest({
    SearchNode? existingNode,
    SearchNode? replacementNode,
  }) {
    final result = ReplaceSearchNodeRequest._();
    if (existingNode != null) result.existingNode = existingNode;
    if (replacementNode != null) result.replacementNode = replacementNode;
    return result;
  }

  ReplaceSearchNodeRequest._();

  factory ReplaceSearchNodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplaceSearchNodeRequest()..mergeFromBuffer(data, registry);
  factory ReplaceSearchNodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReplaceSearchNodeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplaceSearchNodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: ReplaceSearchNodeRequest.$_createMessage)
    ..aOM<SearchNode>(1, _omitFieldNames ? '' : 'existingNode',
        subBuilder: SearchNode.$_createMessage)
    ..aOM<SearchNode>(2, _omitFieldNames ? '' : 'replacementNode',
        subBuilder: SearchNode.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceSearchNodeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplaceSearchNodeRequest copyWith(
          void Function(ReplaceSearchNodeRequest) updates) =>
      super.copyWith((message) => updates(message as ReplaceSearchNodeRequest))
          as ReplaceSearchNodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReplaceSearchNodeRequest() / ReplaceSearchNodeRequest.new instead')
  static ReplaceSearchNodeRequest create() => ReplaceSearchNodeRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReplaceSearchNodeRequest._();
  @$core.override
  ReplaceSearchNodeRequest createEmptyInstance() =>
      ReplaceSearchNodeRequest._();
  @$core.pragma('dart2js:noInline')
  static ReplaceSearchNodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplaceSearchNodeRequest>(
          ReplaceSearchNodeRequest.$_createMessage);
  static ReplaceSearchNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SearchNode get existingNode => $_getN(0);
  @$pb.TagNumber(1)
  set existingNode(SearchNode value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasExistingNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearExistingNode() => $_clearField(1);
  @$pb.TagNumber(1)
  SearchNode ensureExistingNode() => $_ensure(0);

  @$pb.TagNumber(2)
  SearchNode get replacementNode => $_getN(1);
  @$pb.TagNumber(2)
  set replacementNode(SearchNode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReplacementNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplacementNode() => $_clearField(2);
  @$pb.TagNumber(2)
  SearchNode ensureReplacementNode() => $_ensure(1);
}

class FindAndReplaceRequest extends $pb.GeneratedMessage {
  factory FindAndReplaceRequest({
    $core.Iterable<$fixnum.Int64>? nids,
    $core.String? search,
    $core.String? replacement,
    $core.bool? regex,
    $core.bool? matchCase,
    $core.String? fieldName,
  }) {
    final result = FindAndReplaceRequest._();
    if (nids != null) result.nids.addAll(nids);
    if (search != null) result.search = search;
    if (replacement != null) result.replacement = replacement;
    if (regex != null) result.regex = regex;
    if (matchCase != null) result.matchCase = matchCase;
    if (fieldName != null) result.fieldName = fieldName;
    return result;
  }

  FindAndReplaceRequest._();

  factory FindAndReplaceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FindAndReplaceRequest()..mergeFromBuffer(data, registry);
  factory FindAndReplaceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FindAndReplaceRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindAndReplaceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: FindAndReplaceRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'nids', $pb.PbFieldType.K6)
    ..aOS(2, _omitFieldNames ? '' : 'search')
    ..aOS(3, _omitFieldNames ? '' : 'replacement')
    ..aOB(4, _omitFieldNames ? '' : 'regex')
    ..aOB(5, _omitFieldNames ? '' : 'matchCase')
    ..aOS(6, _omitFieldNames ? '' : 'fieldName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindAndReplaceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindAndReplaceRequest copyWith(
          void Function(FindAndReplaceRequest) updates) =>
      super.copyWith((message) => updates(message as FindAndReplaceRequest))
          as FindAndReplaceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FindAndReplaceRequest() / FindAndReplaceRequest.new instead')
  static FindAndReplaceRequest create() => FindAndReplaceRequest._();
  static $pb.GeneratedMessage $_createMessage() => FindAndReplaceRequest._();
  @$core.override
  FindAndReplaceRequest createEmptyInstance() => FindAndReplaceRequest._();
  @$core.pragma('dart2js:noInline')
  static FindAndReplaceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindAndReplaceRequest>(
          FindAndReplaceRequest.$_createMessage);
  static FindAndReplaceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get nids => $_getList(0);

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

  @$pb.TagNumber(6)
  $core.String get fieldName => $_getSZ(5);
  @$pb.TagNumber(6)
  set fieldName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFieldName() => $_has(5);
  @$pb.TagNumber(6)
  void clearFieldName() => $_clearField(6);
}

class BrowserColumns_Column extends $pb.GeneratedMessage {
  factory BrowserColumns_Column({
    $core.String? key,
    $core.String? cardsModeLabel,
    $core.String? notesModeLabel,
    BrowserColumns_Sorting? sortingCards,
    $core.bool? usesCellFont,
    BrowserColumns_Alignment? alignment,
    $core.String? cardsModeTooltip,
    $core.String? notesModeTooltip,
    BrowserColumns_Sorting? sortingNotes,
  }) {
    final result = BrowserColumns_Column._();
    if (key != null) result.key = key;
    if (cardsModeLabel != null) result.cardsModeLabel = cardsModeLabel;
    if (notesModeLabel != null) result.notesModeLabel = notesModeLabel;
    if (sortingCards != null) result.sortingCards = sortingCards;
    if (usesCellFont != null) result.usesCellFont = usesCellFont;
    if (alignment != null) result.alignment = alignment;
    if (cardsModeTooltip != null) result.cardsModeTooltip = cardsModeTooltip;
    if (notesModeTooltip != null) result.notesModeTooltip = notesModeTooltip;
    if (sortingNotes != null) result.sortingNotes = sortingNotes;
    return result;
  }

  BrowserColumns_Column._();

  factory BrowserColumns_Column.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserColumns_Column()..mergeFromBuffer(data, registry);
  factory BrowserColumns_Column.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserColumns_Column()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BrowserColumns.Column',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: BrowserColumns_Column.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'cardsModeLabel')
    ..aOS(3, _omitFieldNames ? '' : 'notesModeLabel')
    ..aE<BrowserColumns_Sorting>(4, _omitFieldNames ? '' : 'sortingCards',
        enumValues: BrowserColumns_Sorting.values)
    ..aOB(5, _omitFieldNames ? '' : 'usesCellFont')
    ..aE<BrowserColumns_Alignment>(6, _omitFieldNames ? '' : 'alignment',
        enumValues: BrowserColumns_Alignment.values)
    ..aOS(7, _omitFieldNames ? '' : 'cardsModeTooltip')
    ..aOS(8, _omitFieldNames ? '' : 'notesModeTooltip')
    ..aE<BrowserColumns_Sorting>(9, _omitFieldNames ? '' : 'sortingNotes',
        enumValues: BrowserColumns_Sorting.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserColumns_Column clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserColumns_Column copyWith(
          void Function(BrowserColumns_Column) updates) =>
      super.copyWith((message) => updates(message as BrowserColumns_Column))
          as BrowserColumns_Column;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use BrowserColumns_Column() / BrowserColumns_Column.new instead')
  static BrowserColumns_Column create() => BrowserColumns_Column._();
  static $pb.GeneratedMessage $_createMessage() => BrowserColumns_Column._();
  @$core.override
  BrowserColumns_Column createEmptyInstance() => BrowserColumns_Column._();
  @$core.pragma('dart2js:noInline')
  static BrowserColumns_Column getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BrowserColumns_Column>(
          BrowserColumns_Column.$_createMessage);
  static BrowserColumns_Column? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardsModeLabel => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardsModeLabel($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardsModeLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardsModeLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get notesModeLabel => $_getSZ(2);
  @$pb.TagNumber(3)
  set notesModeLabel($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNotesModeLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotesModeLabel() => $_clearField(3);

  /// The default sort order
  @$pb.TagNumber(4)
  BrowserColumns_Sorting get sortingCards => $_getN(3);
  @$pb.TagNumber(4)
  set sortingCards(BrowserColumns_Sorting value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSortingCards() => $_has(3);
  @$pb.TagNumber(4)
  void clearSortingCards() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get usesCellFont => $_getBF(4);
  @$pb.TagNumber(5)
  set usesCellFont($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUsesCellFont() => $_has(4);
  @$pb.TagNumber(5)
  void clearUsesCellFont() => $_clearField(5);

  @$pb.TagNumber(6)
  BrowserColumns_Alignment get alignment => $_getN(5);
  @$pb.TagNumber(6)
  set alignment(BrowserColumns_Alignment value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasAlignment() => $_has(5);
  @$pb.TagNumber(6)
  void clearAlignment() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get cardsModeTooltip => $_getSZ(6);
  @$pb.TagNumber(7)
  set cardsModeTooltip($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCardsModeTooltip() => $_has(6);
  @$pb.TagNumber(7)
  void clearCardsModeTooltip() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get notesModeTooltip => $_getSZ(7);
  @$pb.TagNumber(8)
  set notesModeTooltip($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNotesModeTooltip() => $_has(7);
  @$pb.TagNumber(8)
  void clearNotesModeTooltip() => $_clearField(8);

  @$pb.TagNumber(9)
  BrowserColumns_Sorting get sortingNotes => $_getN(8);
  @$pb.TagNumber(9)
  set sortingNotes(BrowserColumns_Sorting value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSortingNotes() => $_has(8);
  @$pb.TagNumber(9)
  void clearSortingNotes() => $_clearField(9);
}

class BrowserColumns extends $pb.GeneratedMessage {
  factory BrowserColumns({
    $core.Iterable<BrowserColumns_Column>? columns,
  }) {
    final result = BrowserColumns._();
    if (columns != null) result.columns.addAll(columns);
    return result;
  }

  BrowserColumns._();

  factory BrowserColumns.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserColumns()..mergeFromBuffer(data, registry);
  factory BrowserColumns.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserColumns()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BrowserColumns',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: BrowserColumns.$_createMessage)
    ..pPM<BrowserColumns_Column>(1, _omitFieldNames ? '' : 'columns',
        subBuilder: BrowserColumns_Column.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserColumns clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserColumns copyWith(void Function(BrowserColumns) updates) =>
      super.copyWith((message) => updates(message as BrowserColumns))
          as BrowserColumns;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BrowserColumns() / BrowserColumns.new instead')
  static BrowserColumns create() => BrowserColumns._();
  static $pb.GeneratedMessage $_createMessage() => BrowserColumns._();
  @$core.override
  BrowserColumns createEmptyInstance() => BrowserColumns._();
  @$core.pragma('dart2js:noInline')
  static BrowserColumns getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BrowserColumns>(
          BrowserColumns.$_createMessage);
  static BrowserColumns? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BrowserColumns_Column> get columns => $_getList(0);
}

class BrowserRow_Cell extends $pb.GeneratedMessage {
  factory BrowserRow_Cell({
    $core.String? text,
    $core.bool? isRtl,
    BrowserRow_Cell_TextElideMode? elideMode,
  }) {
    final result = BrowserRow_Cell._();
    if (text != null) result.text = text;
    if (isRtl != null) result.isRtl = isRtl;
    if (elideMode != null) result.elideMode = elideMode;
    return result;
  }

  BrowserRow_Cell._();

  factory BrowserRow_Cell.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserRow_Cell()..mergeFromBuffer(data, registry);
  factory BrowserRow_Cell.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserRow_Cell()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BrowserRow.Cell',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: BrowserRow_Cell.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOB(2, _omitFieldNames ? '' : 'isRtl')
    ..aE<BrowserRow_Cell_TextElideMode>(3, _omitFieldNames ? '' : 'elideMode',
        enumValues: BrowserRow_Cell_TextElideMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserRow_Cell clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserRow_Cell copyWith(void Function(BrowserRow_Cell) updates) =>
      super.copyWith((message) => updates(message as BrowserRow_Cell))
          as BrowserRow_Cell;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BrowserRow_Cell() / BrowserRow_Cell.new instead')
  static BrowserRow_Cell create() => BrowserRow_Cell._();
  static $pb.GeneratedMessage $_createMessage() => BrowserRow_Cell._();
  @$core.override
  BrowserRow_Cell createEmptyInstance() => BrowserRow_Cell._();
  @$core.pragma('dart2js:noInline')
  static BrowserRow_Cell getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BrowserRow_Cell>(
          BrowserRow_Cell.$_createMessage);
  static BrowserRow_Cell? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isRtl => $_getBF(1);
  @$pb.TagNumber(2)
  set isRtl($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsRtl() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsRtl() => $_clearField(2);

  @$pb.TagNumber(3)
  BrowserRow_Cell_TextElideMode get elideMode => $_getN(2);
  @$pb.TagNumber(3)
  set elideMode(BrowserRow_Cell_TextElideMode value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasElideMode() => $_has(2);
  @$pb.TagNumber(3)
  void clearElideMode() => $_clearField(3);
}

class BrowserRow extends $pb.GeneratedMessage {
  factory BrowserRow({
    $core.Iterable<BrowserRow_Cell>? cells,
    BrowserRow_Color? color,
    $core.String? fontName,
    $core.int? fontSize,
  }) {
    final result = BrowserRow._();
    if (cells != null) result.cells.addAll(cells);
    if (color != null) result.color = color;
    if (fontName != null) result.fontName = fontName;
    if (fontSize != null) result.fontSize = fontSize;
    return result;
  }

  BrowserRow._();

  factory BrowserRow.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserRow()..mergeFromBuffer(data, registry);
  factory BrowserRow.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BrowserRow()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BrowserRow',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.search'),
      createEmptyInstance: BrowserRow.$_createMessage)
    ..pPM<BrowserRow_Cell>(1, _omitFieldNames ? '' : 'cells',
        subBuilder: BrowserRow_Cell.$_createMessage)
    ..aE<BrowserRow_Color>(2, _omitFieldNames ? '' : 'color',
        enumValues: BrowserRow_Color.values)
    ..aOS(3, _omitFieldNames ? '' : 'fontName')
    ..aI(4, _omitFieldNames ? '' : 'fontSize', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserRow clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrowserRow copyWith(void Function(BrowserRow) updates) =>
      super.copyWith((message) => updates(message as BrowserRow)) as BrowserRow;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BrowserRow() / BrowserRow.new instead')
  static BrowserRow create() => BrowserRow._();
  static $pb.GeneratedMessage $_createMessage() => BrowserRow._();
  @$core.override
  BrowserRow createEmptyInstance() => BrowserRow._();
  @$core.pragma('dart2js:noInline')
  static BrowserRow getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BrowserRow>(BrowserRow.$_createMessage);
  static BrowserRow? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BrowserRow_Cell> get cells => $_getList(0);

  @$pb.TagNumber(2)
  BrowserRow_Color get color => $_getN(1);
  @$pb.TagNumber(2)
  set color(BrowserRow_Color value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fontName => $_getSZ(2);
  @$pb.TagNumber(3)
  set fontName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFontName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFontName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get fontSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set fontSize($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFontSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearFontSize() => $_clearField(4);
}

class SearchServiceApi {
  final $pb.RpcClient _client;

  SearchServiceApi(this._client);

  $async.Future<$0.String> buildSearchString(
          $pb.ClientContext? ctx, SearchNode request) =>
      _client.invoke<$0.String>(
          ctx, 'SearchService', 'BuildSearchString', request, $0.String());
  $async.Future<SearchResponse> searchCards(
          $pb.ClientContext? ctx, SearchRequest request) =>
      _client.invoke<SearchResponse>(
          ctx, 'SearchService', 'SearchCards', request, SearchResponse());
  $async.Future<SearchResponse> searchNotes(
          $pb.ClientContext? ctx, SearchRequest request) =>
      _client.invoke<SearchResponse>(
          ctx, 'SearchService', 'SearchNotes', request, SearchResponse());
  $async.Future<$0.String> joinSearchNodes(
          $pb.ClientContext? ctx, JoinSearchNodesRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'SearchService', 'JoinSearchNodes', request, $0.String());
  $async.Future<$0.String> replaceSearchNode(
          $pb.ClientContext? ctx, ReplaceSearchNodeRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'SearchService', 'ReplaceSearchNode', request, $0.String());
  $async.Future<$1.OpChangesWithCount> findAndReplace(
          $pb.ClientContext? ctx, FindAndReplaceRequest request) =>
      _client.invoke<$1.OpChangesWithCount>(ctx, 'SearchService',
          'FindAndReplace', request, $1.OpChangesWithCount());
  $async.Future<BrowserColumns> allBrowserColumns(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<BrowserColumns>(
          ctx, 'SearchService', 'AllBrowserColumns', request, BrowserColumns());
  $async.Future<BrowserRow> browserRowForId(
          $pb.ClientContext? ctx, $0.Int64 request) =>
      _client.invoke<BrowserRow>(
          ctx, 'SearchService', 'BrowserRowForId', request, BrowserRow());
  $async.Future<$0.Empty> setActiveBrowserColumns(
          $pb.ClientContext? ctx, $0.StringList request) =>
      _client.invoke<$0.Empty>(
          ctx, 'SearchService', 'SetActiveBrowserColumns', request, $0.Empty());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendSearchServiceApi {
  final $pb.RpcClient _client;

  BackendSearchServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
