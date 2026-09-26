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

import 'package:protobuf/protobuf.dart' as $pb;

import 'generic.pb.dart' as $2;
import 'import_export.pb.dart' as $4;
import 'import_export.pbjson.dart';

export 'import_export.pb.dart';

abstract class ImportExportServiceBase extends $pb.GeneratedService {
  $async.Future<$4.ImportResponse> importAnkiPackage(
      $pb.ServerContext ctx, $4.ImportAnkiPackageRequest request);
  $async.Future<$4.ImportAnkiPackageOptions> getImportAnkiPackagePresets(
      $pb.ServerContext ctx, $2.Empty request);
  $async.Future<$2.UInt32> exportAnkiPackage(
      $pb.ServerContext ctx, $4.ExportAnkiPackageRequest request);
  $async.Future<$4.CsvMetadata> getCsvMetadata(
      $pb.ServerContext ctx, $4.CsvMetadataRequest request);
  $async.Future<$4.ImportResponse> importCsv(
      $pb.ServerContext ctx, $4.ImportCsvRequest request);
  $async.Future<$2.UInt32> exportNoteCsv(
      $pb.ServerContext ctx, $4.ExportNoteCsvRequest request);
  $async.Future<$2.UInt32> exportCardCsv(
      $pb.ServerContext ctx, $4.ExportCardCsvRequest request);
  $async.Future<$4.ImportResponse> importJsonFile(
      $pb.ServerContext ctx, $2.String request);
  $async.Future<$4.ImportResponse> importJsonString(
      $pb.ServerContext ctx, $2.String request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ImportAnkiPackage':
        return $4.ImportAnkiPackageRequest();
      case 'GetImportAnkiPackagePresets':
        return $2.Empty();
      case 'ExportAnkiPackage':
        return $4.ExportAnkiPackageRequest();
      case 'GetCsvMetadata':
        return $4.CsvMetadataRequest();
      case 'ImportCsv':
        return $4.ImportCsvRequest();
      case 'ExportNoteCsv':
        return $4.ExportNoteCsvRequest();
      case 'ExportCardCsv':
        return $4.ExportCardCsvRequest();
      case 'ImportJsonFile':
        return $2.String();
      case 'ImportJsonString':
        return $2.String();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ImportAnkiPackage':
        return importAnkiPackage(ctx, request as $4.ImportAnkiPackageRequest);
      case 'GetImportAnkiPackagePresets':
        return getImportAnkiPackagePresets(ctx, request as $2.Empty);
      case 'ExportAnkiPackage':
        return exportAnkiPackage(ctx, request as $4.ExportAnkiPackageRequest);
      case 'GetCsvMetadata':
        return getCsvMetadata(ctx, request as $4.CsvMetadataRequest);
      case 'ImportCsv':
        return importCsv(ctx, request as $4.ImportCsvRequest);
      case 'ExportNoteCsv':
        return exportNoteCsv(ctx, request as $4.ExportNoteCsvRequest);
      case 'ExportCardCsv':
        return exportCardCsv(ctx, request as $4.ExportCardCsvRequest);
      case 'ImportJsonFile':
        return importJsonFile(ctx, request as $2.String);
      case 'ImportJsonString':
        return importJsonString(ctx, request as $2.String);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      ImportExportServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ImportExportServiceBase$messageJson;
}

abstract class BackendImportExportServiceBase extends $pb.GeneratedService {
  $async.Future<$2.Empty> importCollectionPackage(
      $pb.ServerContext ctx, $4.ImportCollectionPackageRequest request);
  $async.Future<$2.Empty> exportCollectionPackage(
      $pb.ServerContext ctx, $4.ExportCollectionPackageRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ImportCollectionPackage':
        return $4.ImportCollectionPackageRequest();
      case 'ExportCollectionPackage':
        return $4.ExportCollectionPackageRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ImportCollectionPackage':
        return importCollectionPackage(
            ctx, request as $4.ImportCollectionPackageRequest);
      case 'ExportCollectionPackage':
        return exportCollectionPackage(
            ctx, request as $4.ExportCollectionPackageRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendImportExportServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendImportExportServiceBase$messageJson;
}
