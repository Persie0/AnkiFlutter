// This is a generated file - do not edit.
//
// Generated from anki/links.proto.

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
import 'links.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'links.pbenum.dart';

class HelpPageLinkRequest extends $pb.GeneratedMessage {
  factory HelpPageLinkRequest({
    HelpPageLinkRequest_HelpPage? page,
  }) {
    final result = HelpPageLinkRequest._();
    if (page != null) result.page = page;
    return result;
  }

  HelpPageLinkRequest._();

  factory HelpPageLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HelpPageLinkRequest()..mergeFromBuffer(data, registry);
  factory HelpPageLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HelpPageLinkRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HelpPageLinkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.links'),
      createEmptyInstance: HelpPageLinkRequest.$_createMessage)
    ..aE<HelpPageLinkRequest_HelpPage>(1, _omitFieldNames ? '' : 'page',
        enumValues: HelpPageLinkRequest_HelpPage.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HelpPageLinkRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HelpPageLinkRequest copyWith(void Function(HelpPageLinkRequest) updates) =>
      super.copyWith((message) => updates(message as HelpPageLinkRequest))
          as HelpPageLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use HelpPageLinkRequest() / HelpPageLinkRequest.new instead')
  static HelpPageLinkRequest create() => HelpPageLinkRequest._();
  static $pb.GeneratedMessage $_createMessage() => HelpPageLinkRequest._();
  @$core.override
  HelpPageLinkRequest createEmptyInstance() => HelpPageLinkRequest._();
  @$core.pragma('dart2js:noInline')
  static HelpPageLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HelpPageLinkRequest>(
          HelpPageLinkRequest.$_createMessage);
  static HelpPageLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  HelpPageLinkRequest_HelpPage get page => $_getN(0);
  @$pb.TagNumber(1)
  set page(HelpPageLinkRequest_HelpPage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);
}

class LinksServiceApi {
  final $pb.RpcClient _client;

  LinksServiceApi(this._client);

  $async.Future<$0.String> helpPageLink(
          $pb.ClientContext? ctx, HelpPageLinkRequest request) =>
      _client.invoke<$0.String>(
          ctx, 'LinksService', 'HelpPageLink', request, $0.String());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendLinksServiceApi {
  final $pb.RpcClient _client;

  BackendLinksServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
