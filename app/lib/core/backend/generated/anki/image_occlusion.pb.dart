// This is a generated file - do not edit.
//
// Generated from anki/image_occlusion.proto.

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

class GetImageForOcclusionRequest extends $pb.GeneratedMessage {
  factory GetImageForOcclusionRequest({
    $core.String? path,
  }) {
    final result = GetImageForOcclusionRequest._();
    if (path != null) result.path = path;
    return result;
  }

  GetImageForOcclusionRequest._();

  factory GetImageForOcclusionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageForOcclusionRequest()..mergeFromBuffer(data, registry);
  factory GetImageForOcclusionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageForOcclusionRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageForOcclusionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: GetImageForOcclusionRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageForOcclusionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageForOcclusionRequest copyWith(
          void Function(GetImageForOcclusionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetImageForOcclusionRequest))
          as GetImageForOcclusionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageForOcclusionRequest() / GetImageForOcclusionRequest.new instead')
  static GetImageForOcclusionRequest create() =>
      GetImageForOcclusionRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageForOcclusionRequest._();
  @$core.override
  GetImageForOcclusionRequest createEmptyInstance() =>
      GetImageForOcclusionRequest._();
  @$core.pragma('dart2js:noInline')
  static GetImageForOcclusionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImageForOcclusionRequest>(
          GetImageForOcclusionRequest.$_createMessage);
  static GetImageForOcclusionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => $_clearField(1);
}

class GetImageForOcclusionResponse extends $pb.GeneratedMessage {
  factory GetImageForOcclusionResponse({
    $core.List<$core.int>? data,
    $core.String? name,
  }) {
    final result = GetImageForOcclusionResponse._();
    if (data != null) result.data = data;
    if (name != null) result.name = name;
    return result;
  }

  GetImageForOcclusionResponse._();

  factory GetImageForOcclusionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageForOcclusionResponse()..mergeFromBuffer(data, registry);
  factory GetImageForOcclusionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageForOcclusionResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageForOcclusionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: GetImageForOcclusionResponse.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageForOcclusionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageForOcclusionResponse copyWith(
          void Function(GetImageForOcclusionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetImageForOcclusionResponse))
          as GetImageForOcclusionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageForOcclusionResponse() / GetImageForOcclusionResponse.new instead')
  static GetImageForOcclusionResponse create() =>
      GetImageForOcclusionResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageForOcclusionResponse._();
  @$core.override
  GetImageForOcclusionResponse createEmptyInstance() =>
      GetImageForOcclusionResponse._();
  @$core.pragma('dart2js:noInline')
  static GetImageForOcclusionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImageForOcclusionResponse>(
          GetImageForOcclusionResponse.$_createMessage);
  static GetImageForOcclusionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class AddImageOcclusionNoteRequest extends $pb.GeneratedMessage {
  factory AddImageOcclusionNoteRequest({
    $core.String? imagePath,
    $core.String? occlusions,
    $core.String? header,
    $core.String? backExtra,
    $core.Iterable<$core.String>? tags,
    $fixnum.Int64? notetypeId,
  }) {
    final result = AddImageOcclusionNoteRequest._();
    if (imagePath != null) result.imagePath = imagePath;
    if (occlusions != null) result.occlusions = occlusions;
    if (header != null) result.header = header;
    if (backExtra != null) result.backExtra = backExtra;
    if (tags != null) result.tags.addAll(tags);
    if (notetypeId != null) result.notetypeId = notetypeId;
    return result;
  }

  AddImageOcclusionNoteRequest._();

  factory AddImageOcclusionNoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddImageOcclusionNoteRequest()..mergeFromBuffer(data, registry);
  factory AddImageOcclusionNoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddImageOcclusionNoteRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddImageOcclusionNoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: AddImageOcclusionNoteRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'imagePath')
    ..aOS(2, _omitFieldNames ? '' : 'occlusions')
    ..aOS(3, _omitFieldNames ? '' : 'header')
    ..aOS(4, _omitFieldNames ? '' : 'backExtra')
    ..pPS(5, _omitFieldNames ? '' : 'tags')
    ..aInt64(6, _omitFieldNames ? '' : 'notetypeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddImageOcclusionNoteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddImageOcclusionNoteRequest copyWith(
          void Function(AddImageOcclusionNoteRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AddImageOcclusionNoteRequest))
          as AddImageOcclusionNoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AddImageOcclusionNoteRequest() / AddImageOcclusionNoteRequest.new instead')
  static AddImageOcclusionNoteRequest create() =>
      AddImageOcclusionNoteRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      AddImageOcclusionNoteRequest._();
  @$core.override
  AddImageOcclusionNoteRequest createEmptyInstance() =>
      AddImageOcclusionNoteRequest._();
  @$core.pragma('dart2js:noInline')
  static AddImageOcclusionNoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddImageOcclusionNoteRequest>(
          AddImageOcclusionNoteRequest.$_createMessage);
  static AddImageOcclusionNoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imagePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set imagePath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImagePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearImagePath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get occlusions => $_getSZ(1);
  @$pb.TagNumber(2)
  set occlusions($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOcclusions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOcclusions() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get header => $_getSZ(2);
  @$pb.TagNumber(3)
  set header($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHeader() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeader() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get backExtra => $_getSZ(3);
  @$pb.TagNumber(4)
  set backExtra($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBackExtra() => $_has(3);
  @$pb.TagNumber(4)
  void clearBackExtra() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get tags => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get notetypeId => $_getI64(5);
  @$pb.TagNumber(6)
  set notetypeId($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNotetypeId() => $_has(5);
  @$pb.TagNumber(6)
  void clearNotetypeId() => $_clearField(6);
}

class GetImageOcclusionNoteRequest extends $pb.GeneratedMessage {
  factory GetImageOcclusionNoteRequest({
    $fixnum.Int64? noteId,
  }) {
    final result = GetImageOcclusionNoteRequest._();
    if (noteId != null) result.noteId = noteId;
    return result;
  }

  GetImageOcclusionNoteRequest._();

  factory GetImageOcclusionNoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteRequest()..mergeFromBuffer(data, registry);
  factory GetImageOcclusionNoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageOcclusionNoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: GetImageOcclusionNoteRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'noteId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteRequest copyWith(
          void Function(GetImageOcclusionNoteRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetImageOcclusionNoteRequest))
          as GetImageOcclusionNoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionNoteRequest() / GetImageOcclusionNoteRequest.new instead')
  static GetImageOcclusionNoteRequest create() =>
      GetImageOcclusionNoteRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionNoteRequest._();
  @$core.override
  GetImageOcclusionNoteRequest createEmptyInstance() =>
      GetImageOcclusionNoteRequest._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionNoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImageOcclusionNoteRequest>(
          GetImageOcclusionNoteRequest.$_createMessage);
  static GetImageOcclusionNoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get noteId => $_getI64(0);
  @$pb.TagNumber(1)
  set noteId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNoteId() => $_clearField(1);
}

class GetImageOcclusionNoteResponse_ImageOcclusionProperty
    extends $pb.GeneratedMessage {
  factory GetImageOcclusionNoteResponse_ImageOcclusionProperty({
    $core.String? name,
    $core.String? value,
  }) {
    final result = GetImageOcclusionNoteResponse_ImageOcclusionProperty._();
    if (name != null) result.name = name;
    if (value != null) result.value = value;
    return result;
  }

  GetImageOcclusionNoteResponse_ImageOcclusionProperty._();

  factory GetImageOcclusionNoteResponse_ImageOcclusionProperty.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusionProperty()
        ..mergeFromBuffer(data, registry);
  factory GetImageOcclusionNoteResponse_ImageOcclusionProperty.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusionProperty()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetImageOcclusionNoteResponse.ImageOcclusionProperty',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance:
          GetImageOcclusionNoteResponse_ImageOcclusionProperty.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusionProperty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusionProperty copyWith(
          void Function(GetImageOcclusionNoteResponse_ImageOcclusionProperty)
              updates) =>
      super.copyWith((message) => updates(
              message as GetImageOcclusionNoteResponse_ImageOcclusionProperty))
          as GetImageOcclusionNoteResponse_ImageOcclusionProperty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionNoteResponse_ImageOcclusionProperty() / GetImageOcclusionNoteResponse_ImageOcclusionProperty.new instead')
  static GetImageOcclusionNoteResponse_ImageOcclusionProperty create() =>
      GetImageOcclusionNoteResponse_ImageOcclusionProperty._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionNoteResponse_ImageOcclusionProperty._();
  @$core.override
  GetImageOcclusionNoteResponse_ImageOcclusionProperty createEmptyInstance() =>
      GetImageOcclusionNoteResponse_ImageOcclusionProperty._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionNoteResponse_ImageOcclusionProperty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetImageOcclusionNoteResponse_ImageOcclusionProperty>(
          GetImageOcclusionNoteResponse_ImageOcclusionProperty.$_createMessage);
  static GetImageOcclusionNoteResponse_ImageOcclusionProperty? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class GetImageOcclusionNoteResponse_ImageOcclusionShape
    extends $pb.GeneratedMessage {
  factory GetImageOcclusionNoteResponse_ImageOcclusionShape({
    $core.String? shape,
    $core.Iterable<GetImageOcclusionNoteResponse_ImageOcclusionProperty>?
        properties,
  }) {
    final result = GetImageOcclusionNoteResponse_ImageOcclusionShape._();
    if (shape != null) result.shape = shape;
    if (properties != null) result.properties.addAll(properties);
    return result;
  }

  GetImageOcclusionNoteResponse_ImageOcclusionShape._();

  factory GetImageOcclusionNoteResponse_ImageOcclusionShape.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusionShape()
        ..mergeFromBuffer(data, registry);
  factory GetImageOcclusionNoteResponse_ImageOcclusionShape.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusionShape()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetImageOcclusionNoteResponse.ImageOcclusionShape',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance:
          GetImageOcclusionNoteResponse_ImageOcclusionShape.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'shape')
    ..pPM<GetImageOcclusionNoteResponse_ImageOcclusionProperty>(
        2, _omitFieldNames ? '' : 'properties',
        subBuilder: GetImageOcclusionNoteResponse_ImageOcclusionProperty
            .$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusionShape clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusionShape copyWith(
          void Function(GetImageOcclusionNoteResponse_ImageOcclusionShape)
              updates) =>
      super.copyWith((message) => updates(
              message as GetImageOcclusionNoteResponse_ImageOcclusionShape))
          as GetImageOcclusionNoteResponse_ImageOcclusionShape;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionNoteResponse_ImageOcclusionShape() / GetImageOcclusionNoteResponse_ImageOcclusionShape.new instead')
  static GetImageOcclusionNoteResponse_ImageOcclusionShape create() =>
      GetImageOcclusionNoteResponse_ImageOcclusionShape._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionNoteResponse_ImageOcclusionShape._();
  @$core.override
  GetImageOcclusionNoteResponse_ImageOcclusionShape createEmptyInstance() =>
      GetImageOcclusionNoteResponse_ImageOcclusionShape._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionNoteResponse_ImageOcclusionShape getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetImageOcclusionNoteResponse_ImageOcclusionShape>(
          GetImageOcclusionNoteResponse_ImageOcclusionShape.$_createMessage);
  static GetImageOcclusionNoteResponse_ImageOcclusionShape? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shape => $_getSZ(0);
  @$pb.TagNumber(1)
  set shape($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasShape() => $_has(0);
  @$pb.TagNumber(1)
  void clearShape() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<GetImageOcclusionNoteResponse_ImageOcclusionProperty>
      get properties => $_getList(1);
}

class GetImageOcclusionNoteResponse_ImageOcclusion
    extends $pb.GeneratedMessage {
  factory GetImageOcclusionNoteResponse_ImageOcclusion({
    $core.Iterable<GetImageOcclusionNoteResponse_ImageOcclusionShape>? shapes,
    $core.int? ordinal,
  }) {
    final result = GetImageOcclusionNoteResponse_ImageOcclusion._();
    if (shapes != null) result.shapes.addAll(shapes);
    if (ordinal != null) result.ordinal = ordinal;
    return result;
  }

  GetImageOcclusionNoteResponse_ImageOcclusion._();

  factory GetImageOcclusionNoteResponse_ImageOcclusion.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusion()
        ..mergeFromBuffer(data, registry);
  factory GetImageOcclusionNoteResponse_ImageOcclusion.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusion()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageOcclusionNoteResponse.ImageOcclusion',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance:
          GetImageOcclusionNoteResponse_ImageOcclusion.$_createMessage)
    ..pPM<GetImageOcclusionNoteResponse_ImageOcclusionShape>(
        1, _omitFieldNames ? '' : 'shapes',
        subBuilder:
            GetImageOcclusionNoteResponse_ImageOcclusionShape.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'ordinal', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusion clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusion copyWith(
          void Function(GetImageOcclusionNoteResponse_ImageOcclusion)
              updates) =>
      super.copyWith((message) =>
              updates(message as GetImageOcclusionNoteResponse_ImageOcclusion))
          as GetImageOcclusionNoteResponse_ImageOcclusion;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionNoteResponse_ImageOcclusion() / GetImageOcclusionNoteResponse_ImageOcclusion.new instead')
  static GetImageOcclusionNoteResponse_ImageOcclusion create() =>
      GetImageOcclusionNoteResponse_ImageOcclusion._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionNoteResponse_ImageOcclusion._();
  @$core.override
  GetImageOcclusionNoteResponse_ImageOcclusion createEmptyInstance() =>
      GetImageOcclusionNoteResponse_ImageOcclusion._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionNoteResponse_ImageOcclusion getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetImageOcclusionNoteResponse_ImageOcclusion>(
          GetImageOcclusionNoteResponse_ImageOcclusion.$_createMessage);
  static GetImageOcclusionNoteResponse_ImageOcclusion? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GetImageOcclusionNoteResponse_ImageOcclusionShape> get shapes =>
      $_getList(0);

  @$pb.TagNumber(2)
  $core.int get ordinal => $_getIZ(1);
  @$pb.TagNumber(2)
  set ordinal($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrdinal() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrdinal() => $_clearField(2);
}

class GetImageOcclusionNoteResponse_ImageOcclusionNote
    extends $pb.GeneratedMessage {
  factory GetImageOcclusionNoteResponse_ImageOcclusionNote({
    $core.List<$core.int>? imageData,
    $core.Iterable<GetImageOcclusionNoteResponse_ImageOcclusion>? occlusions,
    $core.String? header,
    $core.String? backExtra,
    $core.Iterable<$core.String>? tags,
    $core.String? imageFileName,
    $core.bool? occludeInactive,
  }) {
    final result = GetImageOcclusionNoteResponse_ImageOcclusionNote._();
    if (imageData != null) result.imageData = imageData;
    if (occlusions != null) result.occlusions.addAll(occlusions);
    if (header != null) result.header = header;
    if (backExtra != null) result.backExtra = backExtra;
    if (tags != null) result.tags.addAll(tags);
    if (imageFileName != null) result.imageFileName = imageFileName;
    if (occludeInactive != null) result.occludeInactive = occludeInactive;
    return result;
  }

  GetImageOcclusionNoteResponse_ImageOcclusionNote._();

  factory GetImageOcclusionNoteResponse_ImageOcclusionNote.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusionNote()
        ..mergeFromBuffer(data, registry);
  factory GetImageOcclusionNoteResponse_ImageOcclusionNote.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse_ImageOcclusionNote()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'GetImageOcclusionNoteResponse.ImageOcclusionNote',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance:
          GetImageOcclusionNoteResponse_ImageOcclusionNote.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'imageData', $pb.PbFieldType.OY)
    ..pPM<GetImageOcclusionNoteResponse_ImageOcclusion>(
        2, _omitFieldNames ? '' : 'occlusions',
        subBuilder:
            GetImageOcclusionNoteResponse_ImageOcclusion.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'header')
    ..aOS(4, _omitFieldNames ? '' : 'backExtra')
    ..pPS(5, _omitFieldNames ? '' : 'tags')
    ..aOS(6, _omitFieldNames ? '' : 'imageFileName')
    ..aOB(7, _omitFieldNames ? '' : 'occludeInactive')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusionNote clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse_ImageOcclusionNote copyWith(
          void Function(GetImageOcclusionNoteResponse_ImageOcclusionNote)
              updates) =>
      super.copyWith((message) => updates(
              message as GetImageOcclusionNoteResponse_ImageOcclusionNote))
          as GetImageOcclusionNoteResponse_ImageOcclusionNote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionNoteResponse_ImageOcclusionNote() / GetImageOcclusionNoteResponse_ImageOcclusionNote.new instead')
  static GetImageOcclusionNoteResponse_ImageOcclusionNote create() =>
      GetImageOcclusionNoteResponse_ImageOcclusionNote._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionNoteResponse_ImageOcclusionNote._();
  @$core.override
  GetImageOcclusionNoteResponse_ImageOcclusionNote createEmptyInstance() =>
      GetImageOcclusionNoteResponse_ImageOcclusionNote._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionNoteResponse_ImageOcclusionNote getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              GetImageOcclusionNoteResponse_ImageOcclusionNote>(
          GetImageOcclusionNoteResponse_ImageOcclusionNote.$_createMessage);
  static GetImageOcclusionNoteResponse_ImageOcclusionNote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get imageData => $_getN(0);
  @$pb.TagNumber(1)
  set imageData($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImageData() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageData() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<GetImageOcclusionNoteResponse_ImageOcclusion> get occlusions =>
      $_getList(1);

  @$pb.TagNumber(3)
  $core.String get header => $_getSZ(2);
  @$pb.TagNumber(3)
  set header($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHeader() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeader() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get backExtra => $_getSZ(3);
  @$pb.TagNumber(4)
  set backExtra($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBackExtra() => $_has(3);
  @$pb.TagNumber(4)
  void clearBackExtra() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get tags => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get imageFileName => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageFileName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasImageFileName() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageFileName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get occludeInactive => $_getBF(6);
  @$pb.TagNumber(7)
  set occludeInactive($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOccludeInactive() => $_has(6);
  @$pb.TagNumber(7)
  void clearOccludeInactive() => $_clearField(7);
}

enum GetImageOcclusionNoteResponse_Value { note, error, notSet }

class GetImageOcclusionNoteResponse extends $pb.GeneratedMessage {
  factory GetImageOcclusionNoteResponse({
    GetImageOcclusionNoteResponse_ImageOcclusionNote? note,
    $core.String? error,
  }) {
    final result = GetImageOcclusionNoteResponse._();
    if (note != null) result.note = note;
    if (error != null) result.error = error;
    return result;
  }

  GetImageOcclusionNoteResponse._();

  factory GetImageOcclusionNoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse()..mergeFromBuffer(data, registry);
  factory GetImageOcclusionNoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionNoteResponse()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, GetImageOcclusionNoteResponse_Value>
      _GetImageOcclusionNoteResponse_ValueByTag = {
    1: GetImageOcclusionNoteResponse_Value.note,
    2: GetImageOcclusionNoteResponse_Value.error,
    0: GetImageOcclusionNoteResponse_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageOcclusionNoteResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: GetImageOcclusionNoteResponse.$_createMessage)
    ..oo(0, [1, 2])
    ..aOM<GetImageOcclusionNoteResponse_ImageOcclusionNote>(
        1, _omitFieldNames ? '' : 'note',
        subBuilder:
            GetImageOcclusionNoteResponse_ImageOcclusionNote.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionNoteResponse copyWith(
          void Function(GetImageOcclusionNoteResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetImageOcclusionNoteResponse))
          as GetImageOcclusionNoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionNoteResponse() / GetImageOcclusionNoteResponse.new instead')
  static GetImageOcclusionNoteResponse create() =>
      GetImageOcclusionNoteResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionNoteResponse._();
  @$core.override
  GetImageOcclusionNoteResponse createEmptyInstance() =>
      GetImageOcclusionNoteResponse._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionNoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImageOcclusionNoteResponse>(
          GetImageOcclusionNoteResponse.$_createMessage);
  static GetImageOcclusionNoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  GetImageOcclusionNoteResponse_Value whichValue() =>
      _GetImageOcclusionNoteResponse_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  GetImageOcclusionNoteResponse_ImageOcclusionNote get note => $_getN(0);
  @$pb.TagNumber(1)
  set note(GetImageOcclusionNoteResponse_ImageOcclusionNote value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNote() => $_has(0);
  @$pb.TagNumber(1)
  void clearNote() => $_clearField(1);
  @$pb.TagNumber(1)
  GetImageOcclusionNoteResponse_ImageOcclusionNote ensureNote() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class UpdateImageOcclusionNoteRequest extends $pb.GeneratedMessage {
  factory UpdateImageOcclusionNoteRequest({
    $fixnum.Int64? noteId,
    $core.String? occlusions,
    $core.String? header,
    $core.String? backExtra,
    $core.Iterable<$core.String>? tags,
  }) {
    final result = UpdateImageOcclusionNoteRequest._();
    if (noteId != null) result.noteId = noteId;
    if (occlusions != null) result.occlusions = occlusions;
    if (header != null) result.header = header;
    if (backExtra != null) result.backExtra = backExtra;
    if (tags != null) result.tags.addAll(tags);
    return result;
  }

  UpdateImageOcclusionNoteRequest._();

  factory UpdateImageOcclusionNoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateImageOcclusionNoteRequest()..mergeFromBuffer(data, registry);
  factory UpdateImageOcclusionNoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateImageOcclusionNoteRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateImageOcclusionNoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: UpdateImageOcclusionNoteRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'noteId')
    ..aOS(2, _omitFieldNames ? '' : 'occlusions')
    ..aOS(3, _omitFieldNames ? '' : 'header')
    ..aOS(4, _omitFieldNames ? '' : 'backExtra')
    ..pPS(5, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateImageOcclusionNoteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateImageOcclusionNoteRequest copyWith(
          void Function(UpdateImageOcclusionNoteRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateImageOcclusionNoteRequest))
          as UpdateImageOcclusionNoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateImageOcclusionNoteRequest() / UpdateImageOcclusionNoteRequest.new instead')
  static UpdateImageOcclusionNoteRequest create() =>
      UpdateImageOcclusionNoteRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      UpdateImageOcclusionNoteRequest._();
  @$core.override
  UpdateImageOcclusionNoteRequest createEmptyInstance() =>
      UpdateImageOcclusionNoteRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateImageOcclusionNoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateImageOcclusionNoteRequest>(
          UpdateImageOcclusionNoteRequest.$_createMessage);
  static UpdateImageOcclusionNoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get noteId => $_getI64(0);
  @$pb.TagNumber(1)
  set noteId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get occlusions => $_getSZ(1);
  @$pb.TagNumber(2)
  set occlusions($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOcclusions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOcclusions() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get header => $_getSZ(2);
  @$pb.TagNumber(3)
  set header($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHeader() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeader() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get backExtra => $_getSZ(3);
  @$pb.TagNumber(4)
  set backExtra($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBackExtra() => $_has(3);
  @$pb.TagNumber(4)
  void clearBackExtra() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get tags => $_getList(4);
}

class GetImageOcclusionFieldsRequest extends $pb.GeneratedMessage {
  factory GetImageOcclusionFieldsRequest({
    $fixnum.Int64? notetypeId,
  }) {
    final result = GetImageOcclusionFieldsRequest._();
    if (notetypeId != null) result.notetypeId = notetypeId;
    return result;
  }

  GetImageOcclusionFieldsRequest._();

  factory GetImageOcclusionFieldsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionFieldsRequest()..mergeFromBuffer(data, registry);
  factory GetImageOcclusionFieldsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionFieldsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageOcclusionFieldsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: GetImageOcclusionFieldsRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'notetypeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionFieldsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionFieldsRequest copyWith(
          void Function(GetImageOcclusionFieldsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetImageOcclusionFieldsRequest))
          as GetImageOcclusionFieldsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionFieldsRequest() / GetImageOcclusionFieldsRequest.new instead')
  static GetImageOcclusionFieldsRequest create() =>
      GetImageOcclusionFieldsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionFieldsRequest._();
  @$core.override
  GetImageOcclusionFieldsRequest createEmptyInstance() =>
      GetImageOcclusionFieldsRequest._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionFieldsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImageOcclusionFieldsRequest>(
          GetImageOcclusionFieldsRequest.$_createMessage);
  static GetImageOcclusionFieldsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get notetypeId => $_getI64(0);
  @$pb.TagNumber(1)
  set notetypeId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNotetypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotetypeId() => $_clearField(1);
}

class GetImageOcclusionFieldsResponse extends $pb.GeneratedMessage {
  factory GetImageOcclusionFieldsResponse({
    ImageOcclusionFieldIndexes? fields,
  }) {
    final result = GetImageOcclusionFieldsResponse._();
    if (fields != null) result.fields = fields;
    return result;
  }

  GetImageOcclusionFieldsResponse._();

  factory GetImageOcclusionFieldsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionFieldsResponse()..mergeFromBuffer(data, registry);
  factory GetImageOcclusionFieldsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetImageOcclusionFieldsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageOcclusionFieldsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: GetImageOcclusionFieldsResponse.$_createMessage)
    ..aOM<ImageOcclusionFieldIndexes>(1, _omitFieldNames ? '' : 'fields',
        subBuilder: ImageOcclusionFieldIndexes.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionFieldsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageOcclusionFieldsResponse copyWith(
          void Function(GetImageOcclusionFieldsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetImageOcclusionFieldsResponse))
          as GetImageOcclusionFieldsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetImageOcclusionFieldsResponse() / GetImageOcclusionFieldsResponse.new instead')
  static GetImageOcclusionFieldsResponse create() =>
      GetImageOcclusionFieldsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetImageOcclusionFieldsResponse._();
  @$core.override
  GetImageOcclusionFieldsResponse createEmptyInstance() =>
      GetImageOcclusionFieldsResponse._();
  @$core.pragma('dart2js:noInline')
  static GetImageOcclusionFieldsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImageOcclusionFieldsResponse>(
          GetImageOcclusionFieldsResponse.$_createMessage);
  static GetImageOcclusionFieldsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ImageOcclusionFieldIndexes get fields => $_getN(0);
  @$pb.TagNumber(1)
  set fields(ImageOcclusionFieldIndexes value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFields() => $_has(0);
  @$pb.TagNumber(1)
  void clearFields() => $_clearField(1);
  @$pb.TagNumber(1)
  ImageOcclusionFieldIndexes ensureFields() => $_ensure(0);
}

class ImageOcclusionFieldIndexes extends $pb.GeneratedMessage {
  factory ImageOcclusionFieldIndexes({
    $core.int? occlusions,
    $core.int? image,
    $core.int? header,
    $core.int? backExtra,
  }) {
    final result = ImageOcclusionFieldIndexes._();
    if (occlusions != null) result.occlusions = occlusions;
    if (image != null) result.image = image;
    if (header != null) result.header = header;
    if (backExtra != null) result.backExtra = backExtra;
    return result;
  }

  ImageOcclusionFieldIndexes._();

  factory ImageOcclusionFieldIndexes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImageOcclusionFieldIndexes()..mergeFromBuffer(data, registry);
  factory ImageOcclusionFieldIndexes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImageOcclusionFieldIndexes()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImageOcclusionFieldIndexes',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'anki.image_occlusion'),
      createEmptyInstance: ImageOcclusionFieldIndexes.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'occlusions', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'image', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'header', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'backExtra', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImageOcclusionFieldIndexes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImageOcclusionFieldIndexes copyWith(
          void Function(ImageOcclusionFieldIndexes) updates) =>
      super.copyWith(
              (message) => updates(message as ImageOcclusionFieldIndexes))
          as ImageOcclusionFieldIndexes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ImageOcclusionFieldIndexes() / ImageOcclusionFieldIndexes.new instead')
  static ImageOcclusionFieldIndexes create() => ImageOcclusionFieldIndexes._();
  static $pb.GeneratedMessage $_createMessage() =>
      ImageOcclusionFieldIndexes._();
  @$core.override
  ImageOcclusionFieldIndexes createEmptyInstance() =>
      ImageOcclusionFieldIndexes._();
  @$core.pragma('dart2js:noInline')
  static ImageOcclusionFieldIndexes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImageOcclusionFieldIndexes>(
          ImageOcclusionFieldIndexes.$_createMessage);
  static ImageOcclusionFieldIndexes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get occlusions => $_getIZ(0);
  @$pb.TagNumber(1)
  set occlusions($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOcclusions() => $_has(0);
  @$pb.TagNumber(1)
  void clearOcclusions() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get image => $_getIZ(1);
  @$pb.TagNumber(2)
  set image($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get header => $_getIZ(2);
  @$pb.TagNumber(3)
  set header($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHeader() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeader() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get backExtra => $_getIZ(3);
  @$pb.TagNumber(4)
  set backExtra($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBackExtra() => $_has(3);
  @$pb.TagNumber(4)
  void clearBackExtra() => $_clearField(4);
}

class ImageOcclusionServiceApi {
  final $pb.RpcClient _client;

  ImageOcclusionServiceApi(this._client);

  $async.Future<GetImageForOcclusionResponse> getImageForOcclusion(
          $pb.ClientContext? ctx, GetImageForOcclusionRequest request) =>
      _client.invoke<GetImageForOcclusionResponse>(ctx, 'ImageOcclusionService',
          'GetImageForOcclusion', request, GetImageForOcclusionResponse());
  $async.Future<GetImageOcclusionNoteResponse> getImageOcclusionNote(
          $pb.ClientContext? ctx, GetImageOcclusionNoteRequest request) =>
      _client.invoke<GetImageOcclusionNoteResponse>(
          ctx,
          'ImageOcclusionService',
          'GetImageOcclusionNote',
          request,
          GetImageOcclusionNoteResponse());
  $async.Future<GetImageOcclusionFieldsResponse> getImageOcclusionFields(
          $pb.ClientContext? ctx, GetImageOcclusionFieldsRequest request) =>
      _client.invoke<GetImageOcclusionFieldsResponse>(
          ctx,
          'ImageOcclusionService',
          'GetImageOcclusionFields',
          request,
          GetImageOcclusionFieldsResponse());

  /// Adds an I/O notetype if none exists in the collection.
  $async.Future<$1.OpChanges> addImageOcclusionNotetype(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$1.OpChanges>(ctx, 'ImageOcclusionService',
          'AddImageOcclusionNotetype', request, $1.OpChanges());

  /// These two are used by the standalone I/O page, but not used when using
  /// I/O inside Anki's editor
  $async.Future<$1.OpChanges> addImageOcclusionNote(
          $pb.ClientContext? ctx, AddImageOcclusionNoteRequest request) =>
      _client.invoke<$1.OpChanges>(ctx, 'ImageOcclusionService',
          'AddImageOcclusionNote', request, $1.OpChanges());
  $async.Future<$1.OpChanges> updateImageOcclusionNote(
          $pb.ClientContext? ctx, UpdateImageOcclusionNoteRequest request) =>
      _client.invoke<$1.OpChanges>(ctx, 'ImageOcclusionService',
          'UpdateImageOcclusionNote', request, $1.OpChanges());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendImageOcclusionServiceApi {
  final $pb.RpcClient _client;

  BackendImageOcclusionServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
