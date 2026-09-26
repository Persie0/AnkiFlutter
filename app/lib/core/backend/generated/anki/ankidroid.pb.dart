// This is a generated file - do not edit.
//
// Generated from anki/ankidroid.proto.

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
import 'scheduler.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DebugActiveDatabaseSequenceNumbersResponse extends $pb.GeneratedMessage {
  factory DebugActiveDatabaseSequenceNumbersResponse({
    $core.Iterable<$core.int>? sequenceNumbers,
  }) {
    final result = DebugActiveDatabaseSequenceNumbersResponse._();
    if (sequenceNumbers != null) result.sequenceNumbers.addAll(sequenceNumbers);
    return result;
  }

  DebugActiveDatabaseSequenceNumbersResponse._();

  factory DebugActiveDatabaseSequenceNumbersResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebugActiveDatabaseSequenceNumbersResponse()
        ..mergeFromBuffer(data, registry);
  factory DebugActiveDatabaseSequenceNumbersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DebugActiveDatabaseSequenceNumbersResponse()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebugActiveDatabaseSequenceNumbersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance:
          DebugActiveDatabaseSequenceNumbersResponse.$_createMessage)
    ..p<$core.int>(
        1, _omitFieldNames ? '' : 'sequenceNumbers', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebugActiveDatabaseSequenceNumbersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DebugActiveDatabaseSequenceNumbersResponse copyWith(
          void Function(DebugActiveDatabaseSequenceNumbersResponse) updates) =>
      super.copyWith((message) =>
              updates(message as DebugActiveDatabaseSequenceNumbersResponse))
          as DebugActiveDatabaseSequenceNumbersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DebugActiveDatabaseSequenceNumbersResponse() / DebugActiveDatabaseSequenceNumbersResponse.new instead')
  static DebugActiveDatabaseSequenceNumbersResponse create() =>
      DebugActiveDatabaseSequenceNumbersResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      DebugActiveDatabaseSequenceNumbersResponse._();
  @$core.override
  DebugActiveDatabaseSequenceNumbersResponse createEmptyInstance() =>
      DebugActiveDatabaseSequenceNumbersResponse._();
  @$core.pragma('dart2js:noInline')
  static DebugActiveDatabaseSequenceNumbersResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
              DebugActiveDatabaseSequenceNumbersResponse>(
          DebugActiveDatabaseSequenceNumbersResponse.$_createMessage);
  static DebugActiveDatabaseSequenceNumbersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get sequenceNumbers => $_getList(0);
}

class SchedTimingTodayLegacyRequest extends $pb.GeneratedMessage {
  factory SchedTimingTodayLegacyRequest({
    $fixnum.Int64? createdSecs,
    $core.int? createdMinsWest,
    $fixnum.Int64? nowSecs,
    $core.int? nowMinsWest,
    $core.int? rolloverHour,
  }) {
    final result = SchedTimingTodayLegacyRequest._();
    if (createdSecs != null) result.createdSecs = createdSecs;
    if (createdMinsWest != null) result.createdMinsWest = createdMinsWest;
    if (nowSecs != null) result.nowSecs = nowSecs;
    if (nowMinsWest != null) result.nowMinsWest = nowMinsWest;
    if (rolloverHour != null) result.rolloverHour = rolloverHour;
    return result;
  }

  SchedTimingTodayLegacyRequest._();

  factory SchedTimingTodayLegacyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SchedTimingTodayLegacyRequest()..mergeFromBuffer(data, registry);
  factory SchedTimingTodayLegacyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SchedTimingTodayLegacyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SchedTimingTodayLegacyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance: SchedTimingTodayLegacyRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'createdSecs')
    ..aI(2, _omitFieldNames ? '' : 'createdMinsWest',
        fieldType: $pb.PbFieldType.OS3)
    ..aInt64(3, _omitFieldNames ? '' : 'nowSecs')
    ..aI(4, _omitFieldNames ? '' : 'nowMinsWest',
        fieldType: $pb.PbFieldType.OS3)
    ..aI(5, _omitFieldNames ? '' : 'rolloverHour',
        fieldType: $pb.PbFieldType.OS3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SchedTimingTodayLegacyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SchedTimingTodayLegacyRequest copyWith(
          void Function(SchedTimingTodayLegacyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SchedTimingTodayLegacyRequest))
          as SchedTimingTodayLegacyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SchedTimingTodayLegacyRequest() / SchedTimingTodayLegacyRequest.new instead')
  static SchedTimingTodayLegacyRequest create() =>
      SchedTimingTodayLegacyRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      SchedTimingTodayLegacyRequest._();
  @$core.override
  SchedTimingTodayLegacyRequest createEmptyInstance() =>
      SchedTimingTodayLegacyRequest._();
  @$core.pragma('dart2js:noInline')
  static SchedTimingTodayLegacyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SchedTimingTodayLegacyRequest>(
          SchedTimingTodayLegacyRequest.$_createMessage);
  static SchedTimingTodayLegacyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get createdSecs => $_getI64(0);
  @$pb.TagNumber(1)
  set createdSecs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCreatedSecs() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatedSecs() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get createdMinsWest => $_getIZ(1);
  @$pb.TagNumber(2)
  set createdMinsWest($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatedMinsWest() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedMinsWest() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get nowSecs => $_getI64(2);
  @$pb.TagNumber(3)
  set nowSecs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNowSecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearNowSecs() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get nowMinsWest => $_getIZ(3);
  @$pb.TagNumber(4)
  set nowMinsWest($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNowMinsWest() => $_has(3);
  @$pb.TagNumber(4)
  void clearNowMinsWest() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get rolloverHour => $_getIZ(4);
  @$pb.TagNumber(5)
  set rolloverHour($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRolloverHour() => $_has(4);
  @$pb.TagNumber(5)
  void clearRolloverHour() => $_clearField(5);
}

enum SqlValue_Data { stringValue, longValue, doubleValue, blobValue, notSet }

/// We expect in Java: Null, String, Short, Int, Long, Float, Double, Boolean,
/// Blob (unused) We get: DbResult (Null, String, i64, f64, Vec<u8>), which
/// matches SQLite documentation
class SqlValue extends $pb.GeneratedMessage {
  factory SqlValue({
    $core.String? stringValue,
    $fixnum.Int64? longValue,
    $core.double? doubleValue,
    $core.List<$core.int>? blobValue,
  }) {
    final result = SqlValue._();
    if (stringValue != null) result.stringValue = stringValue;
    if (longValue != null) result.longValue = longValue;
    if (doubleValue != null) result.doubleValue = doubleValue;
    if (blobValue != null) result.blobValue = blobValue;
    return result;
  }

  SqlValue._();

  factory SqlValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SqlValue()..mergeFromBuffer(data, registry);
  factory SqlValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SqlValue()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SqlValue_Data> _SqlValue_DataByTag = {
    1: SqlValue_Data.stringValue,
    2: SqlValue_Data.longValue,
    3: SqlValue_Data.doubleValue,
    4: SqlValue_Data.blobValue,
    0: SqlValue_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SqlValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance: SqlValue.$_createMessage)
    ..oo(0, [1, 2, 3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'stringValue', protoName: 'stringValue')
    ..aInt64(2, _omitFieldNames ? '' : 'longValue', protoName: 'longValue')
    ..aD(3, _omitFieldNames ? '' : 'doubleValue', protoName: 'doubleValue')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'blobValue', $pb.PbFieldType.OY,
        protoName: 'blobValue')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SqlValue clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SqlValue copyWith(void Function(SqlValue) updates) =>
      super.copyWith((message) => updates(message as SqlValue)) as SqlValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SqlValue() / SqlValue.new instead')
  static SqlValue create() => SqlValue._();
  static $pb.GeneratedMessage $_createMessage() => SqlValue._();
  @$core.override
  SqlValue createEmptyInstance() => SqlValue._();
  @$core.pragma('dart2js:noInline')
  static SqlValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SqlValue>(SqlValue.$_createMessage);
  static SqlValue? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  SqlValue_Data whichData() => _SqlValue_DataByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearData() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get longValue => $_getI64(1);
  @$pb.TagNumber(2)
  set longValue($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get doubleValue => $_getN(2);
  @$pb.TagNumber(3)
  set doubleValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDoubleValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get blobValue => $_getN(3);
  @$pb.TagNumber(4)
  set blobValue($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBlobValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearBlobValue() => $_clearField(4);
}

class Row extends $pb.GeneratedMessage {
  factory Row({
    $core.Iterable<SqlValue>? fields,
  }) {
    final result = Row._();
    if (fields != null) result.fields.addAll(fields);
    return result;
  }

  Row._();

  factory Row.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Row()..mergeFromBuffer(data, registry);
  factory Row.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Row()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Row',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance: Row.$_createMessage)
    ..pPM<SqlValue>(1, _omitFieldNames ? '' : 'fields',
        subBuilder: SqlValue.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Row clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Row copyWith(void Function(Row) updates) =>
      super.copyWith((message) => updates(message as Row)) as Row;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Row() / Row.new instead')
  static Row create() => Row._();
  static $pb.GeneratedMessage $_createMessage() => Row._();
  @$core.override
  Row createEmptyInstance() => Row._();
  @$core.pragma('dart2js:noInline')
  static Row getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Row>(Row.$_createMessage);
  static Row? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SqlValue> get fields => $_getList(0);
}

class DbResult extends $pb.GeneratedMessage {
  factory DbResult({
    $core.Iterable<Row>? rows,
  }) {
    final result = DbResult._();
    if (rows != null) result.rows.addAll(rows);
    return result;
  }

  DbResult._();

  factory DbResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DbResult()..mergeFromBuffer(data, registry);
  factory DbResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DbResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DbResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance: DbResult.$_createMessage)
    ..pPM<Row>(1, _omitFieldNames ? '' : 'rows',
        subBuilder: Row.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DbResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DbResult copyWith(void Function(DbResult) updates) =>
      super.copyWith((message) => updates(message as DbResult)) as DbResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DbResult() / DbResult.new instead')
  static DbResult create() => DbResult._();
  static $pb.GeneratedMessage $_createMessage() => DbResult._();
  @$core.override
  DbResult createEmptyInstance() => DbResult._();
  @$core.pragma('dart2js:noInline')
  static DbResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DbResult>(DbResult.$_createMessage);
  static DbResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Row> get rows => $_getList(0);
}

class DbResponse extends $pb.GeneratedMessage {
  factory DbResponse({
    DbResult? result,
    $core.int? sequenceNumber,
    $core.int? rowCount,
    $fixnum.Int64? startIndex,
  }) {
    final result$ = DbResponse._();
    if (result != null) result$.result = result;
    if (sequenceNumber != null) result$.sequenceNumber = sequenceNumber;
    if (rowCount != null) result$.rowCount = rowCount;
    if (startIndex != null) result$.startIndex = startIndex;
    return result$;
  }

  DbResponse._();

  factory DbResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DbResponse()..mergeFromBuffer(data, registry);
  factory DbResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DbResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DbResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance: DbResponse.$_createMessage)
    ..aOM<DbResult>(1, _omitFieldNames ? '' : 'result',
        subBuilder: DbResult.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'sequenceNumber',
        protoName: 'sequenceNumber')
    ..aI(3, _omitFieldNames ? '' : 'rowCount', protoName: 'rowCount')
    ..aInt64(4, _omitFieldNames ? '' : 'startIndex', protoName: 'startIndex')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DbResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DbResponse copyWith(void Function(DbResponse) updates) =>
      super.copyWith((message) => updates(message as DbResponse)) as DbResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DbResponse() / DbResponse.new instead')
  static DbResponse create() => DbResponse._();
  static $pb.GeneratedMessage $_createMessage() => DbResponse._();
  @$core.override
  DbResponse createEmptyInstance() => DbResponse._();
  @$core.pragma('dart2js:noInline')
  static DbResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DbResponse>(DbResponse.$_createMessage);
  static DbResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DbResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(DbResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  DbResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get sequenceNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set sequenceNumber($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSequenceNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequenceNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get rowCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set rowCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRowCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRowCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get startIndex => $_getI64(3);
  @$pb.TagNumber(4)
  set startIndex($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartIndex() => $_clearField(4);
}

class GetNextResultPageRequest extends $pb.GeneratedMessage {
  factory GetNextResultPageRequest({
    $core.int? sequence,
    $fixnum.Int64? index,
  }) {
    final result = GetNextResultPageRequest._();
    if (sequence != null) result.sequence = sequence;
    if (index != null) result.index = index;
    return result;
  }

  GetNextResultPageRequest._();

  factory GetNextResultPageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetNextResultPageRequest()..mergeFromBuffer(data, registry);
  factory GetNextResultPageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetNextResultPageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetNextResultPageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance: GetNextResultPageRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'sequence')
    ..aInt64(2, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNextResultPageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetNextResultPageRequest copyWith(
          void Function(GetNextResultPageRequest) updates) =>
      super.copyWith((message) => updates(message as GetNextResultPageRequest))
          as GetNextResultPageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetNextResultPageRequest() / GetNextResultPageRequest.new instead')
  static GetNextResultPageRequest create() => GetNextResultPageRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetNextResultPageRequest._();
  @$core.override
  GetNextResultPageRequest createEmptyInstance() =>
      GetNextResultPageRequest._();
  @$core.pragma('dart2js:noInline')
  static GetNextResultPageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetNextResultPageRequest>(
          GetNextResultPageRequest.$_createMessage);
  static GetNextResultPageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get index => $_getI64(1);
  @$pb.TagNumber(2)
  set index($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => $_clearField(2);
}

class GetActiveSequenceNumbersResponse extends $pb.GeneratedMessage {
  factory GetActiveSequenceNumbersResponse({
    $core.Iterable<$core.int>? numbers,
  }) {
    final result = GetActiveSequenceNumbersResponse._();
    if (numbers != null) result.numbers.addAll(numbers);
    return result;
  }

  GetActiveSequenceNumbersResponse._();

  factory GetActiveSequenceNumbersResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetActiveSequenceNumbersResponse()..mergeFromBuffer(data, registry);
  factory GetActiveSequenceNumbersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetActiveSequenceNumbersResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetActiveSequenceNumbersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.ankidroid'),
      createEmptyInstance: GetActiveSequenceNumbersResponse.$_createMessage)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'numbers', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActiveSequenceNumbersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActiveSequenceNumbersResponse copyWith(
          void Function(GetActiveSequenceNumbersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetActiveSequenceNumbersResponse))
          as GetActiveSequenceNumbersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetActiveSequenceNumbersResponse() / GetActiveSequenceNumbersResponse.new instead')
  static GetActiveSequenceNumbersResponse create() =>
      GetActiveSequenceNumbersResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetActiveSequenceNumbersResponse._();
  @$core.override
  GetActiveSequenceNumbersResponse createEmptyInstance() =>
      GetActiveSequenceNumbersResponse._();
  @$core.pragma('dart2js:noInline')
  static GetActiveSequenceNumbersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetActiveSequenceNumbersResponse>(
          GetActiveSequenceNumbersResponse.$_createMessage);
  static GetActiveSequenceNumbersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get numbers => $_getList(0);
}

class AnkidroidServiceApi {
  final $pb.RpcClient _client;

  AnkidroidServiceApi(this._client);

  $async.Future<$0.Json> runDbCommand(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<$0.Json>(
          ctx, 'AnkidroidService', 'RunDbCommand', request, $0.Json());
  $async.Future<DbResponse> runDbCommandProto(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<DbResponse>(
          ctx, 'AnkidroidService', 'RunDbCommandProto', request, DbResponse());
  $async.Future<$0.Int64> insertForId(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<$0.Int64>(
          ctx, 'AnkidroidService', 'InsertForId', request, $0.Int64());
  $async.Future<$0.Int64> runDbCommandForRowCount(
          $pb.ClientContext? ctx, $0.Json request) =>
      _client.invoke<$0.Int64>(ctx, 'AnkidroidService',
          'RunDbCommandForRowCount', request, $0.Int64());
  $async.Future<$0.Empty> flushAllQueries(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<$0.Empty>(
          ctx, 'AnkidroidService', 'FlushAllQueries', request, $0.Empty());
  $async.Future<$0.Empty> flushQuery(
          $pb.ClientContext? ctx, $0.Int32 request) =>
      _client.invoke<$0.Empty>(
          ctx, 'AnkidroidService', 'FlushQuery', request, $0.Empty());
  $async.Future<DbResponse> getNextResultPage(
          $pb.ClientContext? ctx, GetNextResultPageRequest request) =>
      _client.invoke<DbResponse>(
          ctx, 'AnkidroidService', 'GetNextResultPage', request, DbResponse());
  $async.Future<$0.StringList> getColumnNamesFromQuery(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$0.StringList>(ctx, 'AnkidroidService',
          'GetColumnNamesFromQuery', request, $0.StringList());
  $async.Future<GetActiveSequenceNumbersResponse> getActiveSequenceNumbers(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<GetActiveSequenceNumbersResponse>(
          ctx,
          'AnkidroidService',
          'GetActiveSequenceNumbers',
          request,
          GetActiveSequenceNumbersResponse());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendAnkidroidServiceApi {
  final $pb.RpcClient _client;

  BackendAnkidroidServiceApi(this._client);

  $async.Future<$1.SchedTimingTodayResponse> schedTimingTodayLegacy(
          $pb.ClientContext? ctx, SchedTimingTodayLegacyRequest request) =>
      _client.invoke<$1.SchedTimingTodayResponse>(
          ctx,
          'BackendAnkidroidService',
          'SchedTimingTodayLegacy',
          request,
          $1.SchedTimingTodayResponse());
  $async.Future<$0.Int32> localMinutesWestLegacy(
          $pb.ClientContext? ctx, $0.Int64 request) =>
      _client.invoke<$0.Int32>(ctx, 'BackendAnkidroidService',
          'LocalMinutesWestLegacy', request, $0.Int32());
  $async.Future<$0.Empty> setPageSize(
          $pb.ClientContext? ctx, $0.Int64 request) =>
      _client.invoke<$0.Empty>(
          ctx, 'BackendAnkidroidService', 'SetPageSize', request, $0.Empty());
  $async.Future<$0.Empty> debugProduceError(
          $pb.ClientContext? ctx, $0.String request) =>
      _client.invoke<$0.Empty>(ctx, 'BackendAnkidroidService',
          'DebugProduceError', request, $0.Empty());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
