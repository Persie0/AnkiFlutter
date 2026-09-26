// This is a generated file - do not edit.
//
// Generated from anki/backend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'backend.pbenum.dart';
import 'links.pbenum.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'backend.pbenum.dart';

class BackendInit extends $pb.GeneratedMessage {
  factory BackendInit({
    $core.Iterable<$core.String>? preferredLangs,
    $core.String? localeFolderPath,
    $core.bool? server,
  }) {
    final result = BackendInit._();
    if (preferredLangs != null) result.preferredLangs.addAll(preferredLangs);
    if (localeFolderPath != null) result.localeFolderPath = localeFolderPath;
    if (server != null) result.server = server;
    return result;
  }

  BackendInit._();

  factory BackendInit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BackendInit()..mergeFromBuffer(data, registry);
  factory BackendInit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BackendInit()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BackendInit',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.backend'),
      createEmptyInstance: BackendInit.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'preferredLangs')
    ..aOS(2, _omitFieldNames ? '' : 'localeFolderPath')
    ..aOB(3, _omitFieldNames ? '' : 'server')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BackendInit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BackendInit copyWith(void Function(BackendInit) updates) =>
      super.copyWith((message) => updates(message as BackendInit))
          as BackendInit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BackendInit() / BackendInit.new instead')
  static BackendInit create() => BackendInit._();
  static $pb.GeneratedMessage $_createMessage() => BackendInit._();
  @$core.override
  BackendInit createEmptyInstance() => BackendInit._();
  @$core.pragma('dart2js:noInline')
  static BackendInit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BackendInit>(
          BackendInit.$_createMessage);
  static BackendInit? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get preferredLangs => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get localeFolderPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set localeFolderPath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLocaleFolderPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocaleFolderPath() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get server => $_getBF(2);
  @$pb.TagNumber(3)
  set server($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServer() => $_has(2);
  @$pb.TagNumber(3)
  void clearServer() => $_clearField(3);
}

class I18nBackendInit extends $pb.GeneratedMessage {
  factory I18nBackendInit({
    $core.Iterable<$core.String>? preferredLangs,
    $core.String? localeFolderPath,
  }) {
    final result = I18nBackendInit._();
    if (preferredLangs != null) result.preferredLangs.addAll(preferredLangs);
    if (localeFolderPath != null) result.localeFolderPath = localeFolderPath;
    return result;
  }

  I18nBackendInit._();

  factory I18nBackendInit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      I18nBackendInit()..mergeFromBuffer(data, registry);
  factory I18nBackendInit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      I18nBackendInit()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'I18nBackendInit',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.backend'),
      createEmptyInstance: I18nBackendInit.$_createMessage)
    ..pPS(4, _omitFieldNames ? '' : 'preferredLangs')
    ..aOS(5, _omitFieldNames ? '' : 'localeFolderPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  I18nBackendInit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  I18nBackendInit copyWith(void Function(I18nBackendInit) updates) =>
      super.copyWith((message) => updates(message as I18nBackendInit))
          as I18nBackendInit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use I18nBackendInit() / I18nBackendInit.new instead')
  static I18nBackendInit create() => I18nBackendInit._();
  static $pb.GeneratedMessage $_createMessage() => I18nBackendInit._();
  @$core.override
  I18nBackendInit createEmptyInstance() => I18nBackendInit._();
  @$core.pragma('dart2js:noInline')
  static I18nBackendInit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<I18nBackendInit>(
          I18nBackendInit.$_createMessage);
  static I18nBackendInit? _defaultInstance;

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get preferredLangs => $_getList(0);

  @$pb.TagNumber(5)
  $core.String get localeFolderPath => $_getSZ(1);
  @$pb.TagNumber(5)
  set localeFolderPath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(5)
  $core.bool hasLocaleFolderPath() => $_has(1);
  @$pb.TagNumber(5)
  void clearLocaleFolderPath() => $_clearField(5);
}

class BackendError extends $pb.GeneratedMessage {
  factory BackendError({
    $core.String? message,
    BackendError_Kind? kind,
    $0.HelpPageLinkRequest_HelpPage? helpPage,
    $core.String? context,
    $core.String? backtrace,
  }) {
    final result = BackendError._();
    if (message != null) result.message = message;
    if (kind != null) result.kind = kind;
    if (helpPage != null) result.helpPage = helpPage;
    if (context != null) result.context = context;
    if (backtrace != null) result.backtrace = backtrace;
    return result;
  }

  BackendError._();

  factory BackendError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BackendError()..mergeFromBuffer(data, registry);
  factory BackendError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BackendError()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BackendError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.backend'),
      createEmptyInstance: BackendError.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aE<BackendError_Kind>(2, _omitFieldNames ? '' : 'kind',
        enumValues: BackendError_Kind.values)
    ..aE<$0.HelpPageLinkRequest_HelpPage>(3, _omitFieldNames ? '' : 'helpPage',
        enumValues: $0.HelpPageLinkRequest_HelpPage.values)
    ..aOS(4, _omitFieldNames ? '' : 'context')
    ..aOS(5, _omitFieldNames ? '' : 'backtrace')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BackendError clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BackendError copyWith(void Function(BackendError) updates) =>
      super.copyWith((message) => updates(message as BackendError))
          as BackendError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BackendError() / BackendError.new instead')
  static BackendError create() => BackendError._();
  static $pb.GeneratedMessage $_createMessage() => BackendError._();
  @$core.override
  BackendError createEmptyInstance() => BackendError._();
  @$core.pragma('dart2js:noInline')
  static BackendError getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BackendError>(
          BackendError.$_createMessage);
  static BackendError? _defaultInstance;

  /// error description, usually localized, suitable for displaying to the user
  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  /// the error subtype
  @$pb.TagNumber(2)
  BackendError_Kind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(BackendError_Kind value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  /// optional page in the manual
  @$pb.TagNumber(3)
  $0.HelpPageLinkRequest_HelpPage get helpPage => $_getN(2);
  @$pb.TagNumber(3)
  set helpPage($0.HelpPageLinkRequest_HelpPage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasHelpPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearHelpPage() => $_clearField(3);

  /// additional information about the context in which the error occurred
  @$pb.TagNumber(4)
  $core.String get context => $_getSZ(3);
  @$pb.TagNumber(4)
  set context($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContext() => $_has(3);
  @$pb.TagNumber(4)
  void clearContext() => $_clearField(4);

  /// a backtrace of the underlying error; requires RUST_BACKTRACE to be set
  @$pb.TagNumber(5)
  $core.String get backtrace => $_getSZ(4);
  @$pb.TagNumber(5)
  set backtrace($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBacktrace() => $_has(4);
  @$pb.TagNumber(5)
  void clearBacktrace() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
