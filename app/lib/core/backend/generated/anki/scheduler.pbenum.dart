// This is a generated file - do not edit.
//
// Generated from anki/scheduler.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class QueuedCards_Queue extends $pb.ProtobufEnum {
  static const QueuedCards_Queue NEW =
      QueuedCards_Queue._(0, _omitEnumNames ? '' : 'NEW');
  static const QueuedCards_Queue LEARNING =
      QueuedCards_Queue._(1, _omitEnumNames ? '' : 'LEARNING');
  static const QueuedCards_Queue REVIEW =
      QueuedCards_Queue._(2, _omitEnumNames ? '' : 'REVIEW');

  static const $core.List<QueuedCards_Queue> values = <QueuedCards_Queue>[
    NEW,
    LEARNING,
    REVIEW,
  ];

  static final $core.List<QueuedCards_Queue?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static QueuedCards_Queue? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const QueuedCards_Queue._(super.value, super.name);
}

class UnburyDeckRequest_Mode extends $pb.ProtobufEnum {
  static const UnburyDeckRequest_Mode ALL =
      UnburyDeckRequest_Mode._(0, _omitEnumNames ? '' : 'ALL');
  static const UnburyDeckRequest_Mode SCHED_ONLY =
      UnburyDeckRequest_Mode._(1, _omitEnumNames ? '' : 'SCHED_ONLY');
  static const UnburyDeckRequest_Mode USER_ONLY =
      UnburyDeckRequest_Mode._(2, _omitEnumNames ? '' : 'USER_ONLY');

  static const $core.List<UnburyDeckRequest_Mode> values =
      <UnburyDeckRequest_Mode>[
    ALL,
    SCHED_ONLY,
    USER_ONLY,
  ];

  static final $core.List<UnburyDeckRequest_Mode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static UnburyDeckRequest_Mode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const UnburyDeckRequest_Mode._(super.value, super.name);
}

class BuryOrSuspendCardsRequest_Mode extends $pb.ProtobufEnum {
  static const BuryOrSuspendCardsRequest_Mode SUSPEND =
      BuryOrSuspendCardsRequest_Mode._(0, _omitEnumNames ? '' : 'SUSPEND');
  static const BuryOrSuspendCardsRequest_Mode BURY_SCHED =
      BuryOrSuspendCardsRequest_Mode._(1, _omitEnumNames ? '' : 'BURY_SCHED');
  static const BuryOrSuspendCardsRequest_Mode BURY_USER =
      BuryOrSuspendCardsRequest_Mode._(2, _omitEnumNames ? '' : 'BURY_USER');

  static const $core.List<BuryOrSuspendCardsRequest_Mode> values =
      <BuryOrSuspendCardsRequest_Mode>[
    SUSPEND,
    BURY_SCHED,
    BURY_USER,
  ];

  static final $core.List<BuryOrSuspendCardsRequest_Mode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BuryOrSuspendCardsRequest_Mode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BuryOrSuspendCardsRequest_Mode._(super.value, super.name);
}

class ScheduleCardsAsNewRequest_Context extends $pb.ProtobufEnum {
  static const ScheduleCardsAsNewRequest_Context BROWSER =
      ScheduleCardsAsNewRequest_Context._(0, _omitEnumNames ? '' : 'BROWSER');
  static const ScheduleCardsAsNewRequest_Context REVIEWER =
      ScheduleCardsAsNewRequest_Context._(1, _omitEnumNames ? '' : 'REVIEWER');

  static const $core.List<ScheduleCardsAsNewRequest_Context> values =
      <ScheduleCardsAsNewRequest_Context>[
    BROWSER,
    REVIEWER,
  ];

  static final $core.List<ScheduleCardsAsNewRequest_Context?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static ScheduleCardsAsNewRequest_Context? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ScheduleCardsAsNewRequest_Context._(super.value, super.name);
}

class CardAnswer_Rating extends $pb.ProtobufEnum {
  static const CardAnswer_Rating AGAIN =
      CardAnswer_Rating._(0, _omitEnumNames ? '' : 'AGAIN');
  static const CardAnswer_Rating HARD =
      CardAnswer_Rating._(1, _omitEnumNames ? '' : 'HARD');
  static const CardAnswer_Rating GOOD =
      CardAnswer_Rating._(2, _omitEnumNames ? '' : 'GOOD');
  static const CardAnswer_Rating EASY =
      CardAnswer_Rating._(3, _omitEnumNames ? '' : 'EASY');

  static const $core.List<CardAnswer_Rating> values = <CardAnswer_Rating>[
    AGAIN,
    HARD,
    GOOD,
    EASY,
  ];

  static final $core.List<CardAnswer_Rating?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static CardAnswer_Rating? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CardAnswer_Rating._(super.value, super.name);
}

class CustomStudyRequest_Cram_CramKind extends $pb.ProtobufEnum {
  /// due cards in due order
  static const CustomStudyRequest_Cram_CramKind CRAM_KIND_DUE =
      CustomStudyRequest_Cram_CramKind._(
          0, _omitEnumNames ? '' : 'CRAM_KIND_DUE');

  /// new cards in added order
  static const CustomStudyRequest_Cram_CramKind CRAM_KIND_NEW =
      CustomStudyRequest_Cram_CramKind._(
          1, _omitEnumNames ? '' : 'CRAM_KIND_NEW');

  /// review cards in random order
  static const CustomStudyRequest_Cram_CramKind CRAM_KIND_REVIEW =
      CustomStudyRequest_Cram_CramKind._(
          2, _omitEnumNames ? '' : 'CRAM_KIND_REVIEW');

  /// all cards in random order; no rescheduling
  static const CustomStudyRequest_Cram_CramKind CRAM_KIND_ALL =
      CustomStudyRequest_Cram_CramKind._(
          3, _omitEnumNames ? '' : 'CRAM_KIND_ALL');

  static const $core.List<CustomStudyRequest_Cram_CramKind> values =
      <CustomStudyRequest_Cram_CramKind>[
    CRAM_KIND_DUE,
    CRAM_KIND_NEW,
    CRAM_KIND_REVIEW,
    CRAM_KIND_ALL,
  ];

  static final $core.List<CustomStudyRequest_Cram_CramKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static CustomStudyRequest_Cram_CramKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CustomStudyRequest_Cram_CramKind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
