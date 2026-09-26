// This is a generated file - do not edit.
//
// Generated from anki/cards.proto.

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

import 'collection.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CardId extends $pb.GeneratedMessage {
  factory CardId({
    $fixnum.Int64? cid,
  }) {
    final result = CardId._();
    if (cid != null) result.cid = cid;
    return result;
  }

  CardId._();

  factory CardId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardId()..mergeFromBuffer(data, registry);
  factory CardId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardId()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardId',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: CardId.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'cid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardId copyWith(void Function(CardId) updates) =>
      super.copyWith((message) => updates(message as CardId)) as CardId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CardId() / CardId.new instead')
  static CardId create() => CardId._();
  static $pb.GeneratedMessage $_createMessage() => CardId._();
  @$core.override
  CardId createEmptyInstance() => CardId._();
  @$core.pragma('dart2js:noInline')
  static CardId getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CardId>(CardId.$_createMessage);
  static CardId? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get cid => $_getI64(0);
  @$pb.TagNumber(1)
  set cid($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => $_clearField(1);
}

class CardIds extends $pb.GeneratedMessage {
  factory CardIds({
    $core.Iterable<$fixnum.Int64>? cids,
  }) {
    final result = CardIds._();
    if (cids != null) result.cids.addAll(cids);
    return result;
  }

  CardIds._();

  factory CardIds.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardIds()..mergeFromBuffer(data, registry);
  factory CardIds.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CardIds()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CardIds',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: CardIds.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'cids', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardIds clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CardIds copyWith(void Function(CardIds) updates) =>
      super.copyWith((message) => updates(message as CardIds)) as CardIds;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CardIds() / CardIds.new instead')
  static CardIds create() => CardIds._();
  static $pb.GeneratedMessage $_createMessage() => CardIds._();
  @$core.override
  CardIds createEmptyInstance() => CardIds._();
  @$core.pragma('dart2js:noInline')
  static CardIds getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CardIds>(CardIds.$_createMessage);
  static CardIds? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get cids => $_getList(0);
}

class Card extends $pb.GeneratedMessage {
  factory Card({
    $fixnum.Int64? id,
    $fixnum.Int64? noteId,
    $fixnum.Int64? deckId,
    $core.int? templateIdx,
    $fixnum.Int64? mtimeSecs,
    $core.int? usn,
    $core.int? ctype,
    $core.int? queue,
    $core.int? due,
    $core.int? interval,
    $core.int? easeFactor,
    $core.int? reps,
    $core.int? lapses,
    $core.int? remainingSteps,
    $core.int? originalDue,
    $fixnum.Int64? originalDeckId,
    $core.int? flags,
    $core.int? originalPosition,
    $core.String? customData,
    FsrsMemoryState? memoryState,
    $core.double? desiredRetention,
    $core.double? decay,
    $fixnum.Int64? lastReviewTimeSecs,
  }) {
    final result = Card._();
    if (id != null) result.id = id;
    if (noteId != null) result.noteId = noteId;
    if (deckId != null) result.deckId = deckId;
    if (templateIdx != null) result.templateIdx = templateIdx;
    if (mtimeSecs != null) result.mtimeSecs = mtimeSecs;
    if (usn != null) result.usn = usn;
    if (ctype != null) result.ctype = ctype;
    if (queue != null) result.queue = queue;
    if (due != null) result.due = due;
    if (interval != null) result.interval = interval;
    if (easeFactor != null) result.easeFactor = easeFactor;
    if (reps != null) result.reps = reps;
    if (lapses != null) result.lapses = lapses;
    if (remainingSteps != null) result.remainingSteps = remainingSteps;
    if (originalDue != null) result.originalDue = originalDue;
    if (originalDeckId != null) result.originalDeckId = originalDeckId;
    if (flags != null) result.flags = flags;
    if (originalPosition != null) result.originalPosition = originalPosition;
    if (customData != null) result.customData = customData;
    if (memoryState != null) result.memoryState = memoryState;
    if (desiredRetention != null) result.desiredRetention = desiredRetention;
    if (decay != null) result.decay = decay;
    if (lastReviewTimeSecs != null)
      result.lastReviewTimeSecs = lastReviewTimeSecs;
    return result;
  }

  Card._();

  factory Card.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Card()..mergeFromBuffer(data, registry);
  factory Card.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Card()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Card',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: Card.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'noteId')
    ..aInt64(3, _omitFieldNames ? '' : 'deckId')
    ..aI(4, _omitFieldNames ? '' : 'templateIdx',
        fieldType: $pb.PbFieldType.OU3)
    ..aInt64(5, _omitFieldNames ? '' : 'mtimeSecs')
    ..aI(6, _omitFieldNames ? '' : 'usn', fieldType: $pb.PbFieldType.OS3)
    ..aI(7, _omitFieldNames ? '' : 'ctype', fieldType: $pb.PbFieldType.OU3)
    ..aI(8, _omitFieldNames ? '' : 'queue', fieldType: $pb.PbFieldType.OS3)
    ..aI(9, _omitFieldNames ? '' : 'due', fieldType: $pb.PbFieldType.OS3)
    ..aI(10, _omitFieldNames ? '' : 'interval', fieldType: $pb.PbFieldType.OU3)
    ..aI(11, _omitFieldNames ? '' : 'easeFactor',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(12, _omitFieldNames ? '' : 'reps', fieldType: $pb.PbFieldType.OU3)
    ..aI(13, _omitFieldNames ? '' : 'lapses', fieldType: $pb.PbFieldType.OU3)
    ..aI(14, _omitFieldNames ? '' : 'remainingSteps',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(15, _omitFieldNames ? '' : 'originalDue',
        fieldType: $pb.PbFieldType.OS3)
    ..aInt64(16, _omitFieldNames ? '' : 'originalDeckId')
    ..aI(17, _omitFieldNames ? '' : 'flags', fieldType: $pb.PbFieldType.OU3)
    ..aI(18, _omitFieldNames ? '' : 'originalPosition',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(19, _omitFieldNames ? '' : 'customData')
    ..aOM<FsrsMemoryState>(20, _omitFieldNames ? '' : 'memoryState',
        subBuilder: FsrsMemoryState.$_createMessage)
    ..aD(21, _omitFieldNames ? '' : 'desiredRetention',
        fieldType: $pb.PbFieldType.OF)
    ..aD(22, _omitFieldNames ? '' : 'decay', fieldType: $pb.PbFieldType.OF)
    ..aInt64(23, _omitFieldNames ? '' : 'lastReviewTimeSecs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Card clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Card copyWith(void Function(Card) updates) =>
      super.copyWith((message) => updates(message as Card)) as Card;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Card() / Card.new instead')
  static Card create() => Card._();
  static $pb.GeneratedMessage $_createMessage() => Card._();
  @$core.override
  Card createEmptyInstance() => Card._();
  @$core.pragma('dart2js:noInline')
  static Card getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Card>(Card.$_createMessage);
  static Card? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get noteId => $_getI64(1);
  @$pb.TagNumber(2)
  set noteId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNoteId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoteId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get deckId => $_getI64(2);
  @$pb.TagNumber(3)
  set deckId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeckId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeckId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get templateIdx => $_getIZ(3);
  @$pb.TagNumber(4)
  set templateIdx($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTemplateIdx() => $_has(3);
  @$pb.TagNumber(4)
  void clearTemplateIdx() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get mtimeSecs => $_getI64(4);
  @$pb.TagNumber(5)
  set mtimeSecs($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMtimeSecs() => $_has(4);
  @$pb.TagNumber(5)
  void clearMtimeSecs() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get usn => $_getIZ(5);
  @$pb.TagNumber(6)
  set usn($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUsn() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsn() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get ctype => $_getIZ(6);
  @$pb.TagNumber(7)
  set ctype($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCtype() => $_has(6);
  @$pb.TagNumber(7)
  void clearCtype() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get queue => $_getIZ(7);
  @$pb.TagNumber(8)
  set queue($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasQueue() => $_has(7);
  @$pb.TagNumber(8)
  void clearQueue() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get due => $_getIZ(8);
  @$pb.TagNumber(9)
  set due($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDue() => $_has(8);
  @$pb.TagNumber(9)
  void clearDue() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get interval => $_getIZ(9);
  @$pb.TagNumber(10)
  set interval($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInterval() => $_has(9);
  @$pb.TagNumber(10)
  void clearInterval() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get easeFactor => $_getIZ(10);
  @$pb.TagNumber(11)
  set easeFactor($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasEaseFactor() => $_has(10);
  @$pb.TagNumber(11)
  void clearEaseFactor() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get reps => $_getIZ(11);
  @$pb.TagNumber(12)
  set reps($core.int value) => $_setUnsignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasReps() => $_has(11);
  @$pb.TagNumber(12)
  void clearReps() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get lapses => $_getIZ(12);
  @$pb.TagNumber(13)
  set lapses($core.int value) => $_setUnsignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasLapses() => $_has(12);
  @$pb.TagNumber(13)
  void clearLapses() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get remainingSteps => $_getIZ(13);
  @$pb.TagNumber(14)
  set remainingSteps($core.int value) => $_setUnsignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasRemainingSteps() => $_has(13);
  @$pb.TagNumber(14)
  void clearRemainingSteps() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get originalDue => $_getIZ(14);
  @$pb.TagNumber(15)
  set originalDue($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasOriginalDue() => $_has(14);
  @$pb.TagNumber(15)
  void clearOriginalDue() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get originalDeckId => $_getI64(15);
  @$pb.TagNumber(16)
  set originalDeckId($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasOriginalDeckId() => $_has(15);
  @$pb.TagNumber(16)
  void clearOriginalDeckId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get flags => $_getIZ(16);
  @$pb.TagNumber(17)
  set flags($core.int value) => $_setUnsignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasFlags() => $_has(16);
  @$pb.TagNumber(17)
  void clearFlags() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get originalPosition => $_getIZ(17);
  @$pb.TagNumber(18)
  set originalPosition($core.int value) => $_setUnsignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasOriginalPosition() => $_has(17);
  @$pb.TagNumber(18)
  void clearOriginalPosition() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get customData => $_getSZ(18);
  @$pb.TagNumber(19)
  set customData($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCustomData() => $_has(18);
  @$pb.TagNumber(19)
  void clearCustomData() => $_clearField(19);

  @$pb.TagNumber(20)
  FsrsMemoryState get memoryState => $_getN(19);
  @$pb.TagNumber(20)
  set memoryState(FsrsMemoryState value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasMemoryState() => $_has(19);
  @$pb.TagNumber(20)
  void clearMemoryState() => $_clearField(20);
  @$pb.TagNumber(20)
  FsrsMemoryState ensureMemoryState() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.double get desiredRetention => $_getN(20);
  @$pb.TagNumber(21)
  set desiredRetention($core.double value) => $_setFloat(20, value);
  @$pb.TagNumber(21)
  $core.bool hasDesiredRetention() => $_has(20);
  @$pb.TagNumber(21)
  void clearDesiredRetention() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get decay => $_getN(21);
  @$pb.TagNumber(22)
  set decay($core.double value) => $_setFloat(21, value);
  @$pb.TagNumber(22)
  $core.bool hasDecay() => $_has(21);
  @$pb.TagNumber(22)
  void clearDecay() => $_clearField(22);

  @$pb.TagNumber(23)
  $fixnum.Int64 get lastReviewTimeSecs => $_getI64(22);
  @$pb.TagNumber(23)
  set lastReviewTimeSecs($fixnum.Int64 value) => $_setInt64(22, value);
  @$pb.TagNumber(23)
  $core.bool hasLastReviewTimeSecs() => $_has(22);
  @$pb.TagNumber(23)
  void clearLastReviewTimeSecs() => $_clearField(23);
}

class FsrsMemoryState extends $pb.GeneratedMessage {
  factory FsrsMemoryState({
    $core.double? stability,
    $core.double? difficulty,
  }) {
    final result = FsrsMemoryState._();
    if (stability != null) result.stability = stability;
    if (difficulty != null) result.difficulty = difficulty;
    return result;
  }

  FsrsMemoryState._();

  factory FsrsMemoryState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FsrsMemoryState()..mergeFromBuffer(data, registry);
  factory FsrsMemoryState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FsrsMemoryState()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FsrsMemoryState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: FsrsMemoryState.$_createMessage)
    ..aD(1, _omitFieldNames ? '' : 'stability', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'difficulty', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FsrsMemoryState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FsrsMemoryState copyWith(void Function(FsrsMemoryState) updates) =>
      super.copyWith((message) => updates(message as FsrsMemoryState))
          as FsrsMemoryState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use FsrsMemoryState() / FsrsMemoryState.new instead')
  static FsrsMemoryState create() => FsrsMemoryState._();
  static $pb.GeneratedMessage $_createMessage() => FsrsMemoryState._();
  @$core.override
  FsrsMemoryState createEmptyInstance() => FsrsMemoryState._();
  @$core.pragma('dart2js:noInline')
  static FsrsMemoryState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FsrsMemoryState>(
          FsrsMemoryState.$_createMessage);
  static FsrsMemoryState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get stability => $_getN(0);
  @$pb.TagNumber(1)
  set stability($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStability() => $_has(0);
  @$pb.TagNumber(1)
  void clearStability() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get difficulty => $_getN(1);
  @$pb.TagNumber(2)
  set difficulty($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDifficulty() => $_has(1);
  @$pb.TagNumber(2)
  void clearDifficulty() => $_clearField(2);
}

class UpdateCardsRequest extends $pb.GeneratedMessage {
  factory UpdateCardsRequest({
    $core.Iterable<Card>? cards,
    $core.bool? skipUndoEntry,
  }) {
    final result = UpdateCardsRequest._();
    if (cards != null) result.cards.addAll(cards);
    if (skipUndoEntry != null) result.skipUndoEntry = skipUndoEntry;
    return result;
  }

  UpdateCardsRequest._();

  factory UpdateCardsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateCardsRequest()..mergeFromBuffer(data, registry);
  factory UpdateCardsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateCardsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCardsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: UpdateCardsRequest.$_createMessage)
    ..pPM<Card>(1, _omitFieldNames ? '' : 'cards',
        subBuilder: Card.$_createMessage)
    ..aOB(2, _omitFieldNames ? '' : 'skipUndoEntry')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCardsRequest copyWith(void Function(UpdateCardsRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateCardsRequest))
          as UpdateCardsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UpdateCardsRequest() / UpdateCardsRequest.new instead')
  static UpdateCardsRequest create() => UpdateCardsRequest._();
  static $pb.GeneratedMessage $_createMessage() => UpdateCardsRequest._();
  @$core.override
  UpdateCardsRequest createEmptyInstance() => UpdateCardsRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateCardsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCardsRequest>(
          UpdateCardsRequest.$_createMessage);
  static UpdateCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Card> get cards => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get skipUndoEntry => $_getBF(1);
  @$pb.TagNumber(2)
  set skipUndoEntry($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSkipUndoEntry() => $_has(1);
  @$pb.TagNumber(2)
  void clearSkipUndoEntry() => $_clearField(2);
}

class RemoveCardsRequest extends $pb.GeneratedMessage {
  factory RemoveCardsRequest({
    $core.Iterable<$fixnum.Int64>? cardIds,
  }) {
    final result = RemoveCardsRequest._();
    if (cardIds != null) result.cardIds.addAll(cardIds);
    return result;
  }

  RemoveCardsRequest._();

  factory RemoveCardsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RemoveCardsRequest()..mergeFromBuffer(data, registry);
  factory RemoveCardsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RemoveCardsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveCardsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: RemoveCardsRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'cardIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveCardsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveCardsRequest copyWith(void Function(RemoveCardsRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveCardsRequest))
          as RemoveCardsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RemoveCardsRequest() / RemoveCardsRequest.new instead')
  static RemoveCardsRequest create() => RemoveCardsRequest._();
  static $pb.GeneratedMessage $_createMessage() => RemoveCardsRequest._();
  @$core.override
  RemoveCardsRequest createEmptyInstance() => RemoveCardsRequest._();
  @$core.pragma('dart2js:noInline')
  static RemoveCardsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveCardsRequest>(
          RemoveCardsRequest.$_createMessage);
  static RemoveCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get cardIds => $_getList(0);
}

class SetDeckRequest extends $pb.GeneratedMessage {
  factory SetDeckRequest({
    $core.Iterable<$fixnum.Int64>? cardIds,
    $fixnum.Int64? deckId,
  }) {
    final result = SetDeckRequest._();
    if (cardIds != null) result.cardIds.addAll(cardIds);
    if (deckId != null) result.deckId = deckId;
    return result;
  }

  SetDeckRequest._();

  factory SetDeckRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDeckRequest()..mergeFromBuffer(data, registry);
  factory SetDeckRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDeckRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDeckRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: SetDeckRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'cardIds', $pb.PbFieldType.K6)
    ..aInt64(2, _omitFieldNames ? '' : 'deckId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDeckRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDeckRequest copyWith(void Function(SetDeckRequest) updates) =>
      super.copyWith((message) => updates(message as SetDeckRequest))
          as SetDeckRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetDeckRequest() / SetDeckRequest.new instead')
  static SetDeckRequest create() => SetDeckRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetDeckRequest._();
  @$core.override
  SetDeckRequest createEmptyInstance() => SetDeckRequest._();
  @$core.pragma('dart2js:noInline')
  static SetDeckRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetDeckRequest>(
          SetDeckRequest.$_createMessage);
  static SetDeckRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get cardIds => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get deckId => $_getI64(1);
  @$pb.TagNumber(2)
  set deckId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeckId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeckId() => $_clearField(2);
}

class SetFlagRequest extends $pb.GeneratedMessage {
  factory SetFlagRequest({
    $core.Iterable<$fixnum.Int64>? cardIds,
    $core.int? flag,
  }) {
    final result = SetFlagRequest._();
    if (cardIds != null) result.cardIds.addAll(cardIds);
    if (flag != null) result.flag = flag;
    return result;
  }

  SetFlagRequest._();

  factory SetFlagRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetFlagRequest()..mergeFromBuffer(data, registry);
  factory SetFlagRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetFlagRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetFlagRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'anki.cards'),
      createEmptyInstance: SetFlagRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'cardIds', $pb.PbFieldType.K6)
    ..aI(2, _omitFieldNames ? '' : 'flag', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetFlagRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetFlagRequest copyWith(void Function(SetFlagRequest) updates) =>
      super.copyWith((message) => updates(message as SetFlagRequest))
          as SetFlagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetFlagRequest() / SetFlagRequest.new instead')
  static SetFlagRequest create() => SetFlagRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetFlagRequest._();
  @$core.override
  SetFlagRequest createEmptyInstance() => SetFlagRequest._();
  @$core.pragma('dart2js:noInline')
  static SetFlagRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetFlagRequest>(
          SetFlagRequest.$_createMessage);
  static SetFlagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get cardIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get flag => $_getIZ(1);
  @$pb.TagNumber(2)
  set flag($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFlag() => $_has(1);
  @$pb.TagNumber(2)
  void clearFlag() => $_clearField(2);
}

class CardsServiceApi {
  final $pb.RpcClient _client;

  CardsServiceApi(this._client);

  $async.Future<Card> getCard($pb.ClientContext? ctx, CardId request) =>
      _client.invoke<Card>(ctx, 'CardsService', 'GetCard', request, Card());
  $async.Future<$0.OpChanges> updateCards(
          $pb.ClientContext? ctx, UpdateCardsRequest request) =>
      _client.invoke<$0.OpChanges>(
          ctx, 'CardsService', 'UpdateCards', request, $0.OpChanges());
  $async.Future<$0.OpChangesWithCount> removeCards(
          $pb.ClientContext? ctx, RemoveCardsRequest request) =>
      _client.invoke<$0.OpChangesWithCount>(
          ctx, 'CardsService', 'RemoveCards', request, $0.OpChangesWithCount());
  $async.Future<$0.OpChangesWithCount> setDeck(
          $pb.ClientContext? ctx, SetDeckRequest request) =>
      _client.invoke<$0.OpChangesWithCount>(
          ctx, 'CardsService', 'SetDeck', request, $0.OpChangesWithCount());
  $async.Future<$0.OpChangesWithCount> setFlag(
          $pb.ClientContext? ctx, SetFlagRequest request) =>
      _client.invoke<$0.OpChangesWithCount>(
          ctx, 'CardsService', 'SetFlag', request, $0.OpChangesWithCount());
}

/// Implicitly includes any of the above methods that are not listed in the
/// backend service.
class BackendCardsServiceApi {
  final $pb.RpcClient _client;

  BackendCardsServiceApi(this._client);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
