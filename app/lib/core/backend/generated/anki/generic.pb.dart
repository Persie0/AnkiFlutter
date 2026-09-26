// This is a generated file - do not edit.
//
// Generated from anki/generic.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Empty extends $pb.GeneratedMessage {
  factory Empty() => Empty._();

  Empty._();

  factory Empty.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Empty()..mergeFromBuffer(data, registry);
  factory Empty.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Empty()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Empty',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: Empty.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty copyWith(void Function(Empty) updates) =>
      super.copyWith((message) => updates(message as Empty)) as Empty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Empty() / Empty.new instead')
  static Empty create() => Empty._();
  static $pb.GeneratedMessage $_createMessage() => Empty._();
  @$core.override
  Empty createEmptyInstance() => Empty._();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Empty>(Empty.$_createMessage);
  static Empty? _defaultInstance;
}

class Int32 extends $pb.GeneratedMessage {
  factory Int32({
    $core.int? val,
  }) {
    final result = Int32._();
    if (val != null) result.val = val;
    return result;
  }

  Int32._();

  factory Int32.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Int32()..mergeFromBuffer(data, registry);
  factory Int32.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Int32()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Int32',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: Int32.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'val', fieldType: $pb.PbFieldType.OS3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Int32 clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Int32 copyWith(void Function(Int32) updates) =>
      super.copyWith((message) => updates(message as Int32)) as Int32;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Int32() / Int32.new instead')
  static Int32 create() => Int32._();
  static $pb.GeneratedMessage $_createMessage() => Int32._();
  @$core.override
  Int32 createEmptyInstance() => Int32._();
  @$core.pragma('dart2js:noInline')
  static Int32 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Int32>(Int32.$_createMessage);
  static Int32? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get val => $_getIZ(0);
  @$pb.TagNumber(1)
  set val($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVal() => $_has(0);
  @$pb.TagNumber(1)
  void clearVal() => $_clearField(1);
}

class UInt32 extends $pb.GeneratedMessage {
  factory UInt32({
    $core.int? val,
  }) {
    final result = UInt32._();
    if (val != null) result.val = val;
    return result;
  }

  UInt32._();

  factory UInt32.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UInt32()..mergeFromBuffer(data, registry);
  factory UInt32.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UInt32()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UInt32',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: UInt32.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'val', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UInt32 clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UInt32 copyWith(void Function(UInt32) updates) =>
      super.copyWith((message) => updates(message as UInt32)) as UInt32;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UInt32() / UInt32.new instead')
  static UInt32 create() => UInt32._();
  static $pb.GeneratedMessage $_createMessage() => UInt32._();
  @$core.override
  UInt32 createEmptyInstance() => UInt32._();
  @$core.pragma('dart2js:noInline')
  static UInt32 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UInt32>(UInt32.$_createMessage);
  static UInt32? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get val => $_getIZ(0);
  @$pb.TagNumber(1)
  set val($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVal() => $_has(0);
  @$pb.TagNumber(1)
  void clearVal() => $_clearField(1);
}

class Int64 extends $pb.GeneratedMessage {
  factory Int64({
    $fixnum.Int64? val,
  }) {
    final result = Int64._();
    if (val != null) result.val = val;
    return result;
  }

  Int64._();

  factory Int64.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Int64()..mergeFromBuffer(data, registry);
  factory Int64.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Int64()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Int64',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: Int64.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'val')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Int64 clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Int64 copyWith(void Function(Int64) updates) =>
      super.copyWith((message) => updates(message as Int64)) as Int64;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Int64() / Int64.new instead')
  static Int64 create() => Int64._();
  static $pb.GeneratedMessage $_createMessage() => Int64._();
  @$core.override
  Int64 createEmptyInstance() => Int64._();
  @$core.pragma('dart2js:noInline')
  static Int64 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Int64>(Int64.$_createMessage);
  static Int64? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get val => $_getI64(0);
  @$pb.TagNumber(1)
  set val($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVal() => $_has(0);
  @$pb.TagNumber(1)
  void clearVal() => $_clearField(1);
}

class String extends $pb.GeneratedMessage {
  factory String({
    $core.String? val,
  }) {
    final result = String._();
    if (val != null) result.val = val;
    return result;
  }

  String._();

  factory String.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      String()..mergeFromBuffer(data, registry);
  factory String.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      String()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'String',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: String.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'val')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  String clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  String copyWith(void Function(String) updates) =>
      super.copyWith((message) => updates(message as String)) as String;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use String() / String.new instead')
  static String create() => String._();
  static $pb.GeneratedMessage $_createMessage() => String._();
  @$core.override
  String createEmptyInstance() => String._();
  @$core.pragma('dart2js:noInline')
  static String getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<String>(String.$_createMessage);
  static String? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get val => $_getSZ(0);
  @$pb.TagNumber(1)
  set val($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVal() => $_has(0);
  @$pb.TagNumber(1)
  void clearVal() => $_clearField(1);
}

class Json extends $pb.GeneratedMessage {
  factory Json({
    $core.List<$core.int>? json,
  }) {
    final result = Json._();
    if (json != null) result.json = json;
    return result;
  }

  Json._();

  factory Json.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Json()..mergeFromBuffer(data, registry);
  factory Json.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Json()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Json',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: Json.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'json', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Json clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Json copyWith(void Function(Json) updates) =>
      super.copyWith((message) => updates(message as Json)) as Json;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Json() / Json.new instead')
  static Json create() => Json._();
  static $pb.GeneratedMessage $_createMessage() => Json._();
  @$core.override
  Json createEmptyInstance() => Json._();
  @$core.pragma('dart2js:noInline')
  static Json getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Json>(Json.$_createMessage);
  static Json? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get json => $_getN(0);
  @$pb.TagNumber(1)
  set json($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearJson() => $_clearField(1);
}

class Bool extends $pb.GeneratedMessage {
  factory Bool({
    $core.bool? val,
  }) {
    final result = Bool._();
    if (val != null) result.val = val;
    return result;
  }

  Bool._();

  factory Bool.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Bool()..mergeFromBuffer(data, registry);
  factory Bool.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Bool()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Bool',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: Bool.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'val')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Bool clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Bool copyWith(void Function(Bool) updates) =>
      super.copyWith((message) => updates(message as Bool)) as Bool;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Bool() / Bool.new instead')
  static Bool create() => Bool._();
  static $pb.GeneratedMessage $_createMessage() => Bool._();
  @$core.override
  Bool createEmptyInstance() => Bool._();
  @$core.pragma('dart2js:noInline')
  static Bool getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Bool>(Bool.$_createMessage);
  static Bool? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get val => $_getBF(0);
  @$pb.TagNumber(1)
  set val($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVal() => $_has(0);
  @$pb.TagNumber(1)
  void clearVal() => $_clearField(1);
}

class StringList extends $pb.GeneratedMessage {
  factory StringList({
    $core.Iterable<$core.String>? vals,
  }) {
    final result = StringList._();
    if (vals != null) result.vals.addAll(vals);
    return result;
  }

  StringList._();

  factory StringList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StringList()..mergeFromBuffer(data, registry);
  factory StringList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StringList()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StringList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.generic'),
      createEmptyInstance: StringList.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'vals')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StringList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StringList copyWith(void Function(StringList) updates) =>
      super.copyWith((message) => updates(message as StringList)) as StringList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StringList() / StringList.new instead')
  static StringList create() => StringList._();
  static $pb.GeneratedMessage $_createMessage() => StringList._();
  @$core.override
  StringList createEmptyInstance() => StringList._();
  @$core.pragma('dart2js:noInline')
  static StringList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StringList>(StringList.$_createMessage);
  static StringList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get vals => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
