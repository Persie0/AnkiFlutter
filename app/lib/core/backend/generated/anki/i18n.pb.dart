// This is a generated file - do not edit.
//
// Generated from anki/i18n.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'generic.pb.dart' as $0;
import 'i18n.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'i18n.pbenum.dart';

class TranslateStringRequest extends $pb.GeneratedMessage {
  factory TranslateStringRequest({
    $core.int? moduleIndex,
    $core.int? messageIndex,
    $core.Iterable<$core.MapEntry<$core.String, TranslateArgValue>>? args,
  }) {
    final result = TranslateStringRequest._();
    if (moduleIndex != null) result.moduleIndex = moduleIndex;
    if (messageIndex != null) result.messageIndex = messageIndex;
    if (args != null) result.args.addEntries(args);
    return result;
  }

  TranslateStringRequest._();

  factory TranslateStringRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TranslateStringRequest()..mergeFromBuffer(data, registry);
  factory TranslateStringRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TranslateStringRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TranslateStringRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.i18n'),
      createEmptyInstance: TranslateStringRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'moduleIndex',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'messageIndex',
        fieldType: $pb.PbFieldType.OU3)
    ..m<$core.String, TranslateArgValue>(3, _omitFieldNames ? '' : 'args',
        entryClassName: 'TranslateStringRequest.ArgsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TranslateArgValue.$_createMessage,
        valueDefaultOrMaker: TranslateArgValue.getDefault,
        packageName: const $pb.PackageName('anki.i18n'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslateStringRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslateStringRequest copyWith(
          void Function(TranslateStringRequest) updates) =>
      super.copyWith((message) => updates(message as TranslateStringRequest))
          as TranslateStringRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use TranslateStringRequest() / TranslateStringRequest.new instead')
  static TranslateStringRequest create() => TranslateStringRequest._();
  static $pb.GeneratedMessage $_createMessage() => TranslateStringRequest._();
  @$core.override
  TranslateStringRequest createEmptyInstance() => TranslateStringRequest._();
  @$core.pragma('dart2js:noInline')
  static TranslateStringRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TranslateStringRequest>(
          TranslateStringRequest.$_createMessage);
  static TranslateStringRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get moduleIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set moduleIndex($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasModuleIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearModuleIndex() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get messageIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set messageIndex($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageIndex() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, TranslateArgValue> get args => $_getMap(2);
}

enum TranslateArgValue_Value { str, number, notSet }

class TranslateArgValue extends $pb.GeneratedMessage {
  factory TranslateArgValue({
    $core.String? str,
    $core.double? number,
  }) {
    final result = TranslateArgValue._();
    if (str != null) result.str = str;
    if (number != null) result.number = number;
    return result;
  }

  TranslateArgValue._();

  factory TranslateArgValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TranslateArgValue()..mergeFromBuffer(data, registry);
  factory TranslateArgValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TranslateArgValue()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, TranslateArgValue_Value>
      _TranslateArgValue_ValueByTag = {
    1: TranslateArgValue_Value.str,
    2: TranslateArgValue_Value.number,
    0: TranslateArgValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TranslateArgValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.i18n'),
      createEmptyInstance: TranslateArgValue.$_createMessage)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'str')
    ..aD(2, _omitFieldNames ? '' : 'number')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslateArgValue clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslateArgValue copyWith(void Function(TranslateArgValue) updates) =>
      super.copyWith((message) => updates(message as TranslateArgValue))
          as TranslateArgValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TranslateArgValue() / TranslateArgValue.new instead')
  static TranslateArgValue create() => TranslateArgValue._();
  static $pb.GeneratedMessage $_createMessage() => TranslateArgValue._();
  @$core.override
  TranslateArgValue createEmptyInstance() => TranslateArgValue._();
  @$core.pragma('dart2js:noInline')
  static TranslateArgValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranslateArgValue>(
          TranslateArgValue.$_createMessage);
  static TranslateArgValue? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  TranslateArgValue_Value whichValue() =>
      _TranslateArgValue_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get str => $_getSZ(0);
  @$pb.TagNumber(1)
  set str($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStr() => $_has(0);
  @$pb.TagNumber(1)
  void clearStr() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get number => $_getN(1);
  @$pb.TagNumber(2)
  set number($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => $_clearField(2);
}

class FormatTimespanRequest extends $pb.GeneratedMessage {
  factory FormatTimespanRequest({
    $core.double? seconds,
    FormatTimespanRequest_Context? context,
  }) {
    final result = FormatTimespanRequest._();
    if (seconds != null) result.seconds = seconds;
    if (context != null) result.context = context;
    return result;
  }

  FormatTimespanRequest._();

  factory FormatTimespanRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FormatTimespanRequest()..mergeFromBuffer(data, registry);
  factory FormatTimespanRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FormatTimespanRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FormatTimespanRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.i18n'),
      createEmptyInstance: FormatTimespanRequest.$_createMessage)
    ..aD(1, _omitFieldNames ? '' : 'seconds', fieldType: $pb.PbFieldType.OF)
    ..aE<FormatTimespanRequest_Context>(2, _omitFieldNames ? '' : 'context',
        enumValues: FormatTimespanRequest_Context.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormatTimespanRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormatTimespanRequest copyWith(
          void Function(FormatTimespanRequest) updates) =>
      super.copyWith((message) => updates(message as FormatTimespanRequest))
          as FormatTimespanRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FormatTimespanRequest() / FormatTimespanRequest.new instead')
  static FormatTimespanRequest create() => FormatTimespanRequest._();
  static $pb.GeneratedMessage $_createMessage() => FormatTimespanRequest._();
  @$core.override
  FormatTimespanRequest createEmptyInstance() => FormatTimespanRequest._();
  @$core.pragma('dart2js:noInline')
  static FormatTimespanRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FormatTimespanRequest>(
          FormatTimespanRequest.$_createMessage);
  static FormatTimespanRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get seconds => $_getN(0);
  @$pb.TagNumber(1)
  set seconds($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  FormatTimespanRequest_Context get context => $_getN(1);
  @$pb.TagNumber(2)
  set context(FormatTimespanRequest_Context value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasContext() => $_has(1);
  @$pb.TagNumber(2)
  void clearContext() => $_clearField(2);
}

class I18nResourcesRequest extends $pb.GeneratedMessage {
  factory I18nResourcesRequest({
    $core.Iterable<$core.String>? modules,
  }) {
    final result = I18nResourcesRequest._();
    if (modules != null) result.modules.addAll(modules);
    return result;
  }

  I18nResourcesRequest._();

  factory I18nResourcesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      I18nResourcesRequest()..mergeFromBuffer(data, registry);
  factory I18nResourcesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      I18nResourcesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'I18nResourcesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.i18n'),
      createEmptyInstance: I18nResourcesRequest.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'modules')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  I18nResourcesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  I18nResourcesRequest copyWith(void Function(I18nResourcesRequest) updates) =>
      super.copyWith((message) => updates(message as I18nResourcesRequest))
          as I18nResourcesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use I18nResourcesRequest() / I18nResourcesRequest.new instead')
  static I18nResourcesRequest create() => I18nResourcesRequest._();
  static $pb.GeneratedMessage $_createMessage() => I18nResourcesRequest._();
  @$core.override
  I18nResourcesRequest createEmptyInstance() => I18nResourcesRequest._();
  @$core.pragma('dart2js:noInline')
  static I18nResourcesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<I18nResourcesRequest>(
          I18nResourcesRequest.$_createMessage);
  static I18nResourcesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get modules => $_getList(0);
}

class I18nServiceApi {
  final $pb.RpcClient _client;

  I18nServiceApi(this._client);

  $async.Future<$0.String> translateString(
          $pb.ClientContext? ctx, TranslateStringRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'I18nService', 'TranslateString', request, $0.String());
  $async.Future<$0.String> formatTimespan(
          $pb.ClientContext? ctx, FormatTimespanRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'I18nService', 'FormatTimespan', request, $0.String());
  $async.Future<$0.Json> i18nResources(
          $pb.ClientContext? ctx, I18nResourcesRequest request) =>
      _client.invoke<$0.Json>(
          ctx, 'I18nService', 'I18nResources', request, $0.Json());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendI18nServiceApi {
  final $pb.RpcClient _client;

  BackendI18nServiceApi(this._client);

  $async.Future<$0.String> translateString(
          $pb.ClientContext? ctx, TranslateStringRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'BackendI18nService', 'TranslateString', request, $0.String());
  $async.Future<$0.String> formatTimespan(
          $pb.ClientContext? ctx, FormatTimespanRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'BackendI18nService', 'FormatTimespan', request, $0.String());
  $async.Future<$0.Json> i18nResources(
          $pb.ClientContext? ctx, I18nResourcesRequest request) =>
      _client.invoke<$0.Json>(
          ctx, 'BackendI18nService', 'I18nResources', request, $0.Json());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
