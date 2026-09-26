// This is a generated file - do not edit.
//
// Generated from anki/frontend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'frontend.pbenum.dart';
import 'generic.pb.dart' as $1;
import 'links.pbenum.dart' as $3;
import 'scheduler.pb.dart' as $0;
import 'search.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'frontend.pbenum.dart';

class SchedulingStatesWithContext extends $pb.GeneratedMessage {
  factory SchedulingStatesWithContext({
    $0.SchedulingStates? states,
    $0.SchedulingContext? context,
  }) {
    final result = SchedulingStatesWithContext._();
    if (states != null) result.states = states;
    if (context != null) result.context = context;
    return result;
  }

  SchedulingStatesWithContext._();

  factory SchedulingStatesWithContext.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SchedulingStatesWithContext()..mergeFromBuffer(data, registry);
  factory SchedulingStatesWithContext.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SchedulingStatesWithContext()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SchedulingStatesWithContext',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: SchedulingStatesWithContext.$_createMessage)
    ..aOM<$0.SchedulingStates>(1, _omitFieldNames ? '' : 'states',
        subBuilder: $0.SchedulingStates.$_createMessage)
    ..aOM<$0.SchedulingContext>(2, _omitFieldNames ? '' : 'context',
        subBuilder: $0.SchedulingContext.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SchedulingStatesWithContext clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SchedulingStatesWithContext copyWith(
          void Function(SchedulingStatesWithContext) updates) =>
      super.copyWith(
              (message) => updates(message as SchedulingStatesWithContext))
          as SchedulingStatesWithContext;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SchedulingStatesWithContext() / SchedulingStatesWithContext.new instead')
  static SchedulingStatesWithContext create() =>
      SchedulingStatesWithContext._();
  static $pb.GeneratedMessage $_createMessage() =>
      SchedulingStatesWithContext._();
  @$core.override
  SchedulingStatesWithContext createEmptyInstance() =>
      SchedulingStatesWithContext._();
  @$core.pragma('dart2js:noInline')
  static SchedulingStatesWithContext getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SchedulingStatesWithContext>(
          SchedulingStatesWithContext.$_createMessage);
  static SchedulingStatesWithContext? _defaultInstance;

  @$pb.TagNumber(1)
  $0.SchedulingStates get states => $_getN(0);
  @$pb.TagNumber(1)
  set states($0.SchedulingStates value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStates() => $_has(0);
  @$pb.TagNumber(1)
  void clearStates() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.SchedulingStates ensureStates() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.SchedulingContext get context => $_getN(1);
  @$pb.TagNumber(2)
  set context($0.SchedulingContext value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasContext() => $_has(1);
  @$pb.TagNumber(2)
  void clearContext() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.SchedulingContext ensureContext() => $_ensure(1);
}

class SetSchedulingStatesRequest extends $pb.GeneratedMessage {
  factory SetSchedulingStatesRequest({
    $core.String? key,
    $0.SchedulingStates? states,
  }) {
    final result = SetSchedulingStatesRequest._();
    if (key != null) result.key = key;
    if (states != null) result.states = states;
    return result;
  }

  SetSchedulingStatesRequest._();

  factory SetSchedulingStatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetSchedulingStatesRequest()..mergeFromBuffer(data, registry);
  factory SetSchedulingStatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetSchedulingStatesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetSchedulingStatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: SetSchedulingStatesRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOM<$0.SchedulingStates>(2, _omitFieldNames ? '' : 'states',
        subBuilder: $0.SchedulingStates.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetSchedulingStatesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetSchedulingStatesRequest copyWith(
          void Function(SetSchedulingStatesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SetSchedulingStatesRequest))
          as SetSchedulingStatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetSchedulingStatesRequest() / SetSchedulingStatesRequest.new instead')
  static SetSchedulingStatesRequest create() => SetSchedulingStatesRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      SetSchedulingStatesRequest._();
  @$core.override
  SetSchedulingStatesRequest createEmptyInstance() =>
      SetSchedulingStatesRequest._();
  @$core.pragma('dart2js:noInline')
  static SetSchedulingStatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetSchedulingStatesRequest>(
          SetSchedulingStatesRequest.$_createMessage);
  static SetSchedulingStatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.SchedulingStates get states => $_getN(1);
  @$pb.TagNumber(2)
  set states($0.SchedulingStates value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStates() => $_has(1);
  @$pb.TagNumber(2)
  void clearStates() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.SchedulingStates ensureStates() => $_ensure(1);
}

class ConvertPastedImageRequest extends $pb.GeneratedMessage {
  factory ConvertPastedImageRequest({
    $core.List<$core.int>? data,
    $core.String? ext,
  }) {
    final result = ConvertPastedImageRequest._();
    if (data != null) result.data = data;
    if (ext != null) result.ext = ext;
    return result;
  }

  ConvertPastedImageRequest._();

  factory ConvertPastedImageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertPastedImageRequest()..mergeFromBuffer(data, registry);
  factory ConvertPastedImageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertPastedImageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertPastedImageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: ConvertPastedImageRequest.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'ext')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertPastedImageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertPastedImageRequest copyWith(
          void Function(ConvertPastedImageRequest) updates) =>
      super.copyWith((message) => updates(message as ConvertPastedImageRequest))
          as ConvertPastedImageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ConvertPastedImageRequest() / ConvertPastedImageRequest.new instead')
  static ConvertPastedImageRequest create() => ConvertPastedImageRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ConvertPastedImageRequest._();
  @$core.override
  ConvertPastedImageRequest createEmptyInstance() =>
      ConvertPastedImageRequest._();
  @$core.pragma('dart2js:noInline')
  static ConvertPastedImageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertPastedImageRequest>(
          ConvertPastedImageRequest.$_createMessage);
  static ConvertPastedImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ext => $_getSZ(1);
  @$pb.TagNumber(2)
  set ext($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExt() => $_has(1);
  @$pb.TagNumber(2)
  void clearExt() => $_clearField(2);
}

class ConvertPastedImageResponse extends $pb.GeneratedMessage {
  factory ConvertPastedImageResponse({
    $core.List<$core.int>? data,
  }) {
    final result = ConvertPastedImageResponse._();
    if (data != null) result.data = data;
    return result;
  }

  ConvertPastedImageResponse._();

  factory ConvertPastedImageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertPastedImageResponse()..mergeFromBuffer(data, registry);
  factory ConvertPastedImageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ConvertPastedImageResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertPastedImageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: ConvertPastedImageResponse.$_createMessage)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertPastedImageResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertPastedImageResponse copyWith(
          void Function(ConvertPastedImageResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ConvertPastedImageResponse))
          as ConvertPastedImageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ConvertPastedImageResponse() / ConvertPastedImageResponse.new instead')
  static ConvertPastedImageResponse create() => ConvertPastedImageResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ConvertPastedImageResponse._();
  @$core.override
  ConvertPastedImageResponse createEmptyInstance() =>
      ConvertPastedImageResponse._();
  @$core.pragma('dart2js:noInline')
  static ConvertPastedImageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertPastedImageResponse>(
          ConvertPastedImageResponse.$_createMessage);
  static ConvertPastedImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
}

class SetSettingJsonRequest extends $pb.GeneratedMessage {
  factory SetSettingJsonRequest({
    $core.String? key,
    $core.List<$core.int>? valueJson,
  }) {
    final result = SetSettingJsonRequest._();
    if (key != null) result.key = key;
    if (valueJson != null) result.valueJson = valueJson;
    return result;
  }

  SetSettingJsonRequest._();

  factory SetSettingJsonRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetSettingJsonRequest()..mergeFromBuffer(data, registry);
  factory SetSettingJsonRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetSettingJsonRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetSettingJsonRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: SetSettingJsonRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'valueJson', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetSettingJsonRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetSettingJsonRequest copyWith(
          void Function(SetSettingJsonRequest) updates) =>
      super.copyWith((message) => updates(message as SetSettingJsonRequest))
          as SetSettingJsonRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetSettingJsonRequest() / SetSettingJsonRequest.new instead')
  static SetSettingJsonRequest create() => SetSettingJsonRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetSettingJsonRequest._();
  @$core.override
  SetSettingJsonRequest createEmptyInstance() => SetSettingJsonRequest._();
  @$core.pragma('dart2js:noInline')
  static SetSettingJsonRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetSettingJsonRequest>(
          SetSettingJsonRequest.$_createMessage);
  static SetSettingJsonRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get valueJson => $_getN(1);
  @$pb.TagNumber(2)
  set valueJson($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValueJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueJson() => $_clearField(2);
}

class openFilePickerRequest extends $pb.GeneratedMessage {
  factory openFilePickerRequest({
    $core.String? title,
    $core.String? key,
    $core.String? filterDescription,
    $core.Iterable<$core.String>? extensions,
  }) {
    final result = openFilePickerRequest._();
    if (title != null) result.title = title;
    if (key != null) result.key = key;
    if (filterDescription != null) result.filterDescription = filterDescription;
    if (extensions != null) result.extensions.addAll(extensions);
    return result;
  }

  openFilePickerRequest._();

  factory openFilePickerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      openFilePickerRequest()..mergeFromBuffer(data, registry);
  factory openFilePickerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      openFilePickerRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'openFilePickerRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: openFilePickerRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'key')
    ..aOS(3, _omitFieldNames ? '' : 'filterDescription')
    ..pPS(4, _omitFieldNames ? '' : 'extensions')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  openFilePickerRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  openFilePickerRequest copyWith(
          void Function(openFilePickerRequest) updates) =>
      super.copyWith((message) => updates(message as openFilePickerRequest))
          as openFilePickerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use openFilePickerRequest() / openFilePickerRequest.new instead')
  static openFilePickerRequest create() => openFilePickerRequest._();
  static $pb.GeneratedMessage $_createMessage() => openFilePickerRequest._();
  @$core.override
  openFilePickerRequest createEmptyInstance() => openFilePickerRequest._();
  @$core.pragma('dart2js:noInline')
  static openFilePickerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<openFilePickerRequest>(
          openFilePickerRequest.$_createMessage);
  static openFilePickerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get key => $_getSZ(1);
  @$pb.TagNumber(2)
  set key($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get filterDescription => $_getSZ(2);
  @$pb.TagNumber(3)
  set filterDescription($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFilterDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilterDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get extensions => $_getList(3);
}

class ReadClipboardRequest extends $pb.GeneratedMessage {
  factory ReadClipboardRequest({
    $core.Iterable<$core.String>? types,
  }) {
    final result = ReadClipboardRequest._();
    if (types != null) result.types.addAll(types);
    return result;
  }

  ReadClipboardRequest._();

  factory ReadClipboardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadClipboardRequest()..mergeFromBuffer(data, registry);
  factory ReadClipboardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadClipboardRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadClipboardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: ReadClipboardRequest.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'types')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadClipboardRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadClipboardRequest copyWith(void Function(ReadClipboardRequest) updates) =>
      super.copyWith((message) => updates(message as ReadClipboardRequest))
          as ReadClipboardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReadClipboardRequest() / ReadClipboardRequest.new instead')
  static ReadClipboardRequest create() => ReadClipboardRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReadClipboardRequest._();
  @$core.override
  ReadClipboardRequest createEmptyInstance() => ReadClipboardRequest._();
  @$core.pragma('dart2js:noInline')
  static ReadClipboardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadClipboardRequest>(
          ReadClipboardRequest.$_createMessage);
  static ReadClipboardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get types => $_getList(0);
}

class ReadClipboardResponse extends $pb.GeneratedMessage {
  factory ReadClipboardResponse({
    $core.Iterable<$core.MapEntry<$core.String, $core.List<$core.int>>>? data,
  }) {
    final result = ReadClipboardResponse._();
    if (data != null) result.data.addEntries(data);
    return result;
  }

  ReadClipboardResponse._();

  factory ReadClipboardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadClipboardResponse()..mergeFromBuffer(data, registry);
  factory ReadClipboardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadClipboardResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadClipboardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: ReadClipboardResponse.$_createMessage)
    ..m<$core.String, $core.List<$core.int>>(1, _omitFieldNames ? '' : 'data',
        entryClassName: 'ReadClipboardResponse.DataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('anki.frontend'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadClipboardResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadClipboardResponse copyWith(
          void Function(ReadClipboardResponse) updates) =>
      super.copyWith((message) => updates(message as ReadClipboardResponse))
          as ReadClipboardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReadClipboardResponse() / ReadClipboardResponse.new instead')
  static ReadClipboardResponse create() => ReadClipboardResponse._();
  static $pb.GeneratedMessage $_createMessage() => ReadClipboardResponse._();
  @$core.override
  ReadClipboardResponse createEmptyInstance() => ReadClipboardResponse._();
  @$core.pragma('dart2js:noInline')
  static ReadClipboardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadClipboardResponse>(
          ReadClipboardResponse.$_createMessage);
  static ReadClipboardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.List<$core.int>> get data => $_getMap(0);
}

class WriteClipboardRequest extends $pb.GeneratedMessage {
  factory WriteClipboardRequest({
    $core.Iterable<$core.MapEntry<$core.String, $core.List<$core.int>>>? data,
  }) {
    final result = WriteClipboardRequest._();
    if (data != null) result.data.addEntries(data);
    return result;
  }

  WriteClipboardRequest._();

  factory WriteClipboardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WriteClipboardRequest()..mergeFromBuffer(data, registry);
  factory WriteClipboardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      WriteClipboardRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WriteClipboardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: WriteClipboardRequest.$_createMessage)
    ..m<$core.String, $core.List<$core.int>>(1, _omitFieldNames ? '' : 'data',
        entryClassName: 'WriteClipboardRequest.DataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('anki.frontend'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteClipboardRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteClipboardRequest copyWith(
          void Function(WriteClipboardRequest) updates) =>
      super.copyWith((message) => updates(message as WriteClipboardRequest))
          as WriteClipboardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use WriteClipboardRequest() / WriteClipboardRequest.new instead')
  static WriteClipboardRequest create() => WriteClipboardRequest._();
  static $pb.GeneratedMessage $_createMessage() => WriteClipboardRequest._();
  @$core.override
  WriteClipboardRequest createEmptyInstance() => WriteClipboardRequest._();
  @$core.pragma('dart2js:noInline')
  static WriteClipboardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteClipboardRequest>(
          WriteClipboardRequest.$_createMessage);
  static WriteClipboardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.List<$core.int>> get data => $_getMap(0);
}

enum Help_Value { helpPage, helpLink, notSet }

class Help extends $pb.GeneratedMessage {
  factory Help({
    $3.HelpPageLinkRequest_HelpPage? helpPage,
    $core.String? helpLink,
  }) {
    final result = Help._();
    if (helpPage != null) result.helpPage = helpPage;
    if (helpLink != null) result.helpLink = helpLink;
    return result;
  }

  Help._();

  factory Help.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Help()..mergeFromBuffer(data, registry);
  factory Help.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Help()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Help_Value> _Help_ValueByTag = {
    1: Help_Value.helpPage,
    2: Help_Value.helpLink,
    0: Help_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Help',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: Help.$_createMessage)
    ..oo(0, [1, 2])
    ..aE<$3.HelpPageLinkRequest_HelpPage>(1, _omitFieldNames ? '' : 'helpPage',
        enumValues: $3.HelpPageLinkRequest_HelpPage.values)
    ..aOS(2, _omitFieldNames ? '' : 'helpLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Help clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Help copyWith(void Function(Help) updates) =>
      super.copyWith((message) => updates(message as Help)) as Help;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Help() / Help.new instead')
  static Help create() => Help._();
  static $pb.GeneratedMessage $_createMessage() => Help._();
  @$core.override
  Help createEmptyInstance() => Help._();
  @$core.pragma('dart2js:noInline')
  static Help getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Help>(Help.$_createMessage);
  static Help? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  Help_Value whichValue() => _Help_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $3.HelpPageLinkRequest_HelpPage get helpPage => $_getN(0);
  @$pb.TagNumber(1)
  set helpPage($3.HelpPageLinkRequest_HelpPage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHelpPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearHelpPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get helpLink => $_getSZ(1);
  @$pb.TagNumber(2)
  set helpLink($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHelpLink() => $_has(1);
  @$pb.TagNumber(2)
  void clearHelpLink() => $_clearField(2);
}

class AskUserRequest extends $pb.GeneratedMessage {
  factory AskUserRequest({
    $core.String? text,
    Help? help,
    $core.String? title,
    $core.bool? defaultNo,
  }) {
    final result = AskUserRequest._();
    if (text != null) result.text = text;
    if (help != null) result.help = help;
    if (title != null) result.title = title;
    if (defaultNo != null) result.defaultNo = defaultNo;
    return result;
  }

  AskUserRequest._();

  factory AskUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AskUserRequest()..mergeFromBuffer(data, registry);
  factory AskUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AskUserRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AskUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: AskUserRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOM<Help>(2, _omitFieldNames ? '' : 'help',
        subBuilder: Help.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOB(5, _omitFieldNames ? '' : 'defaultNo')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AskUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AskUserRequest copyWith(void Function(AskUserRequest) updates) =>
      super.copyWith((message) => updates(message as AskUserRequest))
          as AskUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AskUserRequest() / AskUserRequest.new instead')
  static AskUserRequest create() => AskUserRequest._();
  static $pb.GeneratedMessage $_createMessage() => AskUserRequest._();
  @$core.override
  AskUserRequest createEmptyInstance() => AskUserRequest._();
  @$core.pragma('dart2js:noInline')
  static AskUserRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AskUserRequest>(
          AskUserRequest.$_createMessage);
  static AskUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  Help get help => $_getN(1);
  @$pb.TagNumber(2)
  set help(Help value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasHelp() => $_has(1);
  @$pb.TagNumber(2)
  void clearHelp() => $_clearField(2);
  @$pb.TagNumber(2)
  Help ensureHelp() => $_ensure(1);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(4)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(4)
  void clearTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get defaultNo => $_getBF(3);
  @$pb.TagNumber(5)
  set defaultNo($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(5)
  $core.bool hasDefaultNo() => $_has(3);
  @$pb.TagNumber(5)
  void clearDefaultNo() => $_clearField(5);
}

class ShowMessageBoxRequest extends $pb.GeneratedMessage {
  factory ShowMessageBoxRequest({
    $core.String? text,
    MessageBoxType? type,
    Help? help,
    $core.String? title,
    $core.String? textFormat,
  }) {
    final result = ShowMessageBoxRequest._();
    if (text != null) result.text = text;
    if (type != null) result.type = type;
    if (help != null) result.help = help;
    if (title != null) result.title = title;
    if (textFormat != null) result.textFormat = textFormat;
    return result;
  }

  ShowMessageBoxRequest._();

  factory ShowMessageBoxRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ShowMessageBoxRequest()..mergeFromBuffer(data, registry);
  factory ShowMessageBoxRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ShowMessageBoxRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ShowMessageBoxRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.frontend'),
      createEmptyInstance: ShowMessageBoxRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aE<MessageBoxType>(2, _omitFieldNames ? '' : 'type',
        enumValues: MessageBoxType.values)
    ..aOM<Help>(3, _omitFieldNames ? '' : 'help',
        subBuilder: Help.$_createMessage)
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOS(5, _omitFieldNames ? '' : 'textFormat')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShowMessageBoxRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShowMessageBoxRequest copyWith(
          void Function(ShowMessageBoxRequest) updates) =>
      super.copyWith((message) => updates(message as ShowMessageBoxRequest))
          as ShowMessageBoxRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ShowMessageBoxRequest() / ShowMessageBoxRequest.new instead')
  static ShowMessageBoxRequest create() => ShowMessageBoxRequest._();
  static $pb.GeneratedMessage $_createMessage() => ShowMessageBoxRequest._();
  @$core.override
  ShowMessageBoxRequest createEmptyInstance() => ShowMessageBoxRequest._();
  @$core.pragma('dart2js:noInline')
  static ShowMessageBoxRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ShowMessageBoxRequest>(
          ShowMessageBoxRequest.$_createMessage);
  static ShowMessageBoxRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  MessageBoxType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(MessageBoxType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  Help get help => $_getN(2);
  @$pb.TagNumber(3)
  set help(Help value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasHelp() => $_has(2);
  @$pb.TagNumber(3)
  void clearHelp() => $_clearField(3);
  @$pb.TagNumber(3)
  Help ensureHelp() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get textFormat => $_getSZ(4);
  @$pb.TagNumber(5)
  set textFormat($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTextFormat() => $_has(4);
  @$pb.TagNumber(5)
  void clearTextFormat() => $_clearField(5);
}

class FrontendServiceApi {
  final $pb.RpcClient _client;

  FrontendServiceApi(this._client);

  /// Returns values from the reviewer
  $async.Future<SchedulingStatesWithContext> getSchedulingStatesWithContext(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<SchedulingStatesWithContext>(
          ctx,
          'FrontendService',
          'GetSchedulingStatesWithContext',
          request,
          SchedulingStatesWithContext());

  /// Updates reviewer state
  $async.Future<$1.Empty> setSchedulingStates(
          $pb.ClientContext? ctx, SetSchedulingStatesRequest request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'SetSchedulingStates', request, $1.Empty());

  /// Notify Qt layer so window modality can be updated.
  $async.Future<$1.Empty> importDone(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'ImportDone', request, $1.Empty());
  $async.Future<$1.Empty> searchInBrowser(
          $pb.ClientContext? ctx, $2.SearchNode request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'SearchInBrowser', request, $1.Empty());

  /// Force closing the deck options.
  $async.Future<$1.Empty> deckOptionsRequireClose(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(ctx, 'FrontendService',
          'deckOptionsRequireClose', request, $1.Empty());

  /// Warns python that the deck option web view is ready to receive requests.
  $async.Future<$1.Empty> deckOptionsReady(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'deckOptionsReady', request, $1.Empty());

  /// Editor
  $async.Future<ConvertPastedImageResponse> convertPastedImage(
          $pb.ClientContext? ctx, ConvertPastedImageRequest request) =>
      _client.invoke<ConvertPastedImageResponse>(ctx, 'FrontendService',
          'ConvertPastedImage', request, ConvertPastedImageResponse());
  $async.Future<$1.String> openFilePicker(
          $pb.ClientContext? ctx, openFilePickerRequest request) =>
      _client.invoke<$1.String>(
          ctx, 'FrontendService', 'OpenFilePicker', request, $1.String());
  $async.Future<$1.Empty> openMedia(
          $pb.ClientContext? ctx, $1.String request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'OpenMedia', request, $1.Empty());
  $async.Future<$1.Empty> showInMediaFolder(
          $pb.ClientContext? ctx, $1.String request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'ShowInMediaFolder', request, $1.Empty());
  $async.Future<$1.String> recordAudio(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.String>(
          ctx, 'FrontendService', 'RecordAudio', request, $1.String());
  $async.Future<$1.Empty> playFile($pb.ClientContext? ctx, $1.String request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'PlayFile', request, $1.Empty());
  $async.Future<$1.Empty> closeAddCards(
          $pb.ClientContext? ctx, $1.Bool request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'CloseAddCards', request, $1.Empty());
  $async.Future<$1.Empty> closeEditCurrent(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'CloseEditCurrent', request, $1.Empty());
  $async.Future<$1.Empty> openLink($pb.ClientContext? ctx, $1.String request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'OpenLink', request, $1.Empty());
  $async.Future<$1.Bool> askUser(
          $pb.ClientContext? ctx, AskUserRequest request) =>
      _client.invoke<$1.Bool>(
          ctx, 'FrontendService', 'AskUser', request, $1.Bool());
  $async.Future<$1.Empty> showMessageBox(
          $pb.ClientContext? ctx, ShowMessageBoxRequest request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'ShowMessageBox', request, $1.Empty());
  $async.Future<$1.Empty> openFieldsDialog(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'OpenFieldsDialog', request, $1.Empty());
  $async.Future<$1.Empty> openCardsDialog(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'OpenCardsDialog', request, $1.Empty());

  /// Profile config
  $async.Future<$1.Json> getProfileConfigJson(
          $pb.ClientContext? ctx, $1.String request) =>
      _client.invoke<$1.Json>(
          ctx, 'FrontendService', 'GetProfileConfigJson', request, $1.Json());
  $async.Future<$1.Empty> setProfileConfigJson(
          $pb.ClientContext? ctx, SetSettingJsonRequest request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'SetProfileConfigJson', request, $1.Empty());

  /// Metadata
  $async.Future<$1.Json> getMetaJson(
          $pb.ClientContext? ctx, $1.String request) =>
      _client.invoke<$1.Json>(
          ctx, 'FrontendService', 'GetMetaJson', request, $1.Json());
  $async.Future<$1.Empty> setMetaJson(
          $pb.ClientContext? ctx, SetSettingJsonRequest request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'SetMetaJson', request, $1.Empty());

  /// Clipboard
  $async.Future<ReadClipboardResponse> readClipboard(
          $pb.ClientContext? ctx, ReadClipboardRequest request) =>
      _client.invoke<ReadClipboardResponse>(ctx, 'FrontendService',
          'ReadClipboard', request, ReadClipboardResponse());
  $async.Future<$1.Empty> writeClipboard(
          $pb.ClientContext? ctx, WriteClipboardRequest request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'WriteClipboard', request, $1.Empty());

  /// Save colour picker's custom colour palette
  $async.Future<$1.Empty> saveCustomColours(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(
          ctx, 'FrontendService', 'SaveCustomColours', request, $1.Empty());

  /// CSV import
  $async.Future<$1.Empty> importDialogRequireClose(
          $pb.ClientContext? ctx, $1.Empty request) =>
      _client.invoke<$1.Empty>(ctx, 'FrontendService',
          'ImportDialogRequireClose', request, $1.Empty());
}

class BackendFrontendServiceApi {
  final $pb.RpcClient _client;

  BackendFrontendServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
