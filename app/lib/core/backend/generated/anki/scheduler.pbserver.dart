// This is a generated file - do not edit.
//
// Generated from anki/scheduler.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'cards.pb.dart' as $0;
import 'collection.pb.dart' as $2;
import 'decks.pb.dart' as $4;
import 'generic.pb.dart' as $3;
import 'scheduler.pb.dart' as $6;
import 'scheduler.pbjson.dart';

export 'scheduler.pb.dart';

abstract class SchedulerServiceBase extends $pb.GeneratedService {
  $async.Future<$6.QueuedCards> getQueuedCards(
      $pb.ServerContext ctx, $6.GetQueuedCardsRequest request);
  $async.Future<$2.OpChanges> answerCard(
      $pb.ServerContext ctx, $6.CardAnswer request);
  $async.Future<$6.SchedTimingTodayResponse> schedTimingToday(
      $pb.ServerContext ctx, $3.Empty request);
  $async.Future<$3.String> studiedToday(
      $pb.ServerContext ctx, $3.Empty request);
  $async.Future<$3.String> studiedTodayMessage(
      $pb.ServerContext ctx, $6.StudiedTodayMessageRequest request);
  $async.Future<$3.Empty> updateStats(
      $pb.ServerContext ctx, $6.UpdateStatsRequest request);
  $async.Future<$3.Empty> extendLimits(
      $pb.ServerContext ctx, $6.ExtendLimitsRequest request);
  $async.Future<$6.CountsForDeckTodayResponse> countsForDeckToday(
      $pb.ServerContext ctx, $4.DeckId request);
  $async.Future<$6.CongratsInfoResponse> congratsInfo(
      $pb.ServerContext ctx, $3.Empty request);
  $async.Future<$2.OpChanges> restoreBuriedAndSuspendedCards(
      $pb.ServerContext ctx, $0.CardIds request);
  $async.Future<$2.OpChanges> unburyDeck(
      $pb.ServerContext ctx, $6.UnburyDeckRequest request);
  $async.Future<$2.OpChangesWithCount> buryOrSuspendCards(
      $pb.ServerContext ctx, $6.BuryOrSuspendCardsRequest request);
  $async.Future<$2.OpChanges> emptyFilteredDeck(
      $pb.ServerContext ctx, $4.DeckId request);
  $async.Future<$2.OpChangesWithCount> rebuildFilteredDeck(
      $pb.ServerContext ctx, $4.DeckId request);
  $async.Future<$2.OpChanges> scheduleCardsAsNew(
      $pb.ServerContext ctx, $6.ScheduleCardsAsNewRequest request);
  $async.Future<$6.ScheduleCardsAsNewDefaultsResponse>
      scheduleCardsAsNewDefaults(
          $pb.ServerContext ctx, $6.ScheduleCardsAsNewDefaultsRequest request);
  $async.Future<$2.OpChanges> setDueDate(
      $pb.ServerContext ctx, $6.SetDueDateRequest request);
  $async.Future<$2.OpChanges> gradeNow(
      $pb.ServerContext ctx, $6.GradeNowRequest request);
  $async.Future<$2.OpChangesWithCount> sortCards(
      $pb.ServerContext ctx, $6.SortCardsRequest request);
  $async.Future<$2.OpChangesWithCount> sortDeck(
      $pb.ServerContext ctx, $6.SortDeckRequest request);
  $async.Future<$6.SchedulingStates> getSchedulingStates(
      $pb.ServerContext ctx, $0.CardId request);
  $async.Future<$3.StringList> describeNextStates(
      $pb.ServerContext ctx, $6.SchedulingStates request);
  $async.Future<$3.Bool> stateIsLeech(
      $pb.ServerContext ctx, $6.SchedulingState request);
  $async.Future<$3.Empty> upgradeScheduler(
      $pb.ServerContext ctx, $3.Empty request);
  $async.Future<$2.OpChanges> customStudy(
      $pb.ServerContext ctx, $6.CustomStudyRequest request);
  $async.Future<$6.CustomStudyDefaultsResponse> customStudyDefaults(
      $pb.ServerContext ctx, $6.CustomStudyDefaultsRequest request);
  $async.Future<$6.RepositionDefaultsResponse> repositionDefaults(
      $pb.ServerContext ctx, $3.Empty request);
  $async.Future<$6.ComputeFsrsParamsResponse> computeFsrsParams(
      $pb.ServerContext ctx, $6.ComputeFsrsParamsRequest request);
  $async.Future<$6.GetOptimalRetentionParametersResponse>
      getOptimalRetentionParameters($pb.ServerContext ctx,
          $6.GetOptimalRetentionParametersRequest request);
  $async.Future<$6.ComputeOptimalRetentionResponse> computeOptimalRetention(
      $pb.ServerContext ctx, $6.SimulateFsrsReviewRequest request);
  $async.Future<$6.SimulateFsrsReviewResponse> simulateFsrsReview(
      $pb.ServerContext ctx, $6.SimulateFsrsReviewRequest request);
  $async.Future<$6.SimulateFsrsWorkloadResponse> simulateFsrsWorkload(
      $pb.ServerContext ctx, $6.SimulateFsrsReviewRequest request);
  $async.Future<$6.EvaluateParamsResponse> evaluateParams(
      $pb.ServerContext ctx, $6.EvaluateParamsRequest request);
  $async.Future<$6.EvaluateParamsResponse> evaluateParamsLegacy(
      $pb.ServerContext ctx, $6.EvaluateParamsLegacyRequest request);
  $async.Future<$6.ComputeMemoryStateResponse> computeMemoryState(
      $pb.ServerContext ctx, $0.CardId request);
  $async.Future<$6.FuzzDeltaResponse> fuzzDelta(
      $pb.ServerContext ctx, $6.FuzzDeltaRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetQueuedCards':
        return $6.GetQueuedCardsRequest();
      case 'AnswerCard':
        return $6.CardAnswer();
      case 'SchedTimingToday':
        return $3.Empty();
      case 'StudiedToday':
        return $3.Empty();
      case 'StudiedTodayMessage':
        return $6.StudiedTodayMessageRequest();
      case 'UpdateStats':
        return $6.UpdateStatsRequest();
      case 'ExtendLimits':
        return $6.ExtendLimitsRequest();
      case 'CountsForDeckToday':
        return $4.DeckId();
      case 'CongratsInfo':
        return $3.Empty();
      case 'RestoreBuriedAndSuspendedCards':
        return $0.CardIds();
      case 'UnburyDeck':
        return $6.UnburyDeckRequest();
      case 'BuryOrSuspendCards':
        return $6.BuryOrSuspendCardsRequest();
      case 'EmptyFilteredDeck':
        return $4.DeckId();
      case 'RebuildFilteredDeck':
        return $4.DeckId();
      case 'ScheduleCardsAsNew':
        return $6.ScheduleCardsAsNewRequest();
      case 'ScheduleCardsAsNewDefaults':
        return $6.ScheduleCardsAsNewDefaultsRequest();
      case 'SetDueDate':
        return $6.SetDueDateRequest();
      case 'GradeNow':
        return $6.GradeNowRequest();
      case 'SortCards':
        return $6.SortCardsRequest();
      case 'SortDeck':
        return $6.SortDeckRequest();
      case 'GetSchedulingStates':
        return $0.CardId();
      case 'DescribeNextStates':
        return $6.SchedulingStates();
      case 'StateIsLeech':
        return $6.SchedulingState();
      case 'UpgradeScheduler':
        return $3.Empty();
      case 'CustomStudy':
        return $6.CustomStudyRequest();
      case 'CustomStudyDefaults':
        return $6.CustomStudyDefaultsRequest();
      case 'RepositionDefaults':
        return $3.Empty();
      case 'ComputeFsrsParams':
        return $6.ComputeFsrsParamsRequest();
      case 'GetOptimalRetentionParameters':
        return $6.GetOptimalRetentionParametersRequest();
      case 'ComputeOptimalRetention':
        return $6.SimulateFsrsReviewRequest();
      case 'SimulateFsrsReview':
        return $6.SimulateFsrsReviewRequest();
      case 'SimulateFsrsWorkload':
        return $6.SimulateFsrsReviewRequest();
      case 'EvaluateParams':
        return $6.EvaluateParamsRequest();
      case 'EvaluateParamsLegacy':
        return $6.EvaluateParamsLegacyRequest();
      case 'ComputeMemoryState':
        return $0.CardId();
      case 'FuzzDelta':
        return $6.FuzzDeltaRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetQueuedCards':
        return getQueuedCards(ctx, request as $6.GetQueuedCardsRequest);
      case 'AnswerCard':
        return answerCard(ctx, request as $6.CardAnswer);
      case 'SchedTimingToday':
        return schedTimingToday(ctx, request as $3.Empty);
      case 'StudiedToday':
        return studiedToday(ctx, request as $3.Empty);
      case 'StudiedTodayMessage':
        return studiedTodayMessage(
            ctx, request as $6.StudiedTodayMessageRequest);
      case 'UpdateStats':
        return updateStats(ctx, request as $6.UpdateStatsRequest);
      case 'ExtendLimits':
        return extendLimits(ctx, request as $6.ExtendLimitsRequest);
      case 'CountsForDeckToday':
        return countsForDeckToday(ctx, request as $4.DeckId);
      case 'CongratsInfo':
        return congratsInfo(ctx, request as $3.Empty);
      case 'RestoreBuriedAndSuspendedCards':
        return restoreBuriedAndSuspendedCards(ctx, request as $0.CardIds);
      case 'UnburyDeck':
        return unburyDeck(ctx, request as $6.UnburyDeckRequest);
      case 'BuryOrSuspendCards':
        return buryOrSuspendCards(ctx, request as $6.BuryOrSuspendCardsRequest);
      case 'EmptyFilteredDeck':
        return emptyFilteredDeck(ctx, request as $4.DeckId);
      case 'RebuildFilteredDeck':
        return rebuildFilteredDeck(ctx, request as $4.DeckId);
      case 'ScheduleCardsAsNew':
        return scheduleCardsAsNew(ctx, request as $6.ScheduleCardsAsNewRequest);
      case 'ScheduleCardsAsNewDefaults':
        return scheduleCardsAsNewDefaults(
            ctx, request as $6.ScheduleCardsAsNewDefaultsRequest);
      case 'SetDueDate':
        return setDueDate(ctx, request as $6.SetDueDateRequest);
      case 'GradeNow':
        return gradeNow(ctx, request as $6.GradeNowRequest);
      case 'SortCards':
        return sortCards(ctx, request as $6.SortCardsRequest);
      case 'SortDeck':
        return sortDeck(ctx, request as $6.SortDeckRequest);
      case 'GetSchedulingStates':
        return getSchedulingStates(ctx, request as $0.CardId);
      case 'DescribeNextStates':
        return describeNextStates(ctx, request as $6.SchedulingStates);
      case 'StateIsLeech':
        return stateIsLeech(ctx, request as $6.SchedulingState);
      case 'UpgradeScheduler':
        return upgradeScheduler(ctx, request as $3.Empty);
      case 'CustomStudy':
        return customStudy(ctx, request as $6.CustomStudyRequest);
      case 'CustomStudyDefaults':
        return customStudyDefaults(
            ctx, request as $6.CustomStudyDefaultsRequest);
      case 'RepositionDefaults':
        return repositionDefaults(ctx, request as $3.Empty);
      case 'ComputeFsrsParams':
        return computeFsrsParams(ctx, request as $6.ComputeFsrsParamsRequest);
      case 'GetOptimalRetentionParameters':
        return getOptimalRetentionParameters(
            ctx, request as $6.GetOptimalRetentionParametersRequest);
      case 'ComputeOptimalRetention':
        return computeOptimalRetention(
            ctx, request as $6.SimulateFsrsReviewRequest);
      case 'SimulateFsrsReview':
        return simulateFsrsReview(ctx, request as $6.SimulateFsrsReviewRequest);
      case 'SimulateFsrsWorkload':
        return simulateFsrsWorkload(
            ctx, request as $6.SimulateFsrsReviewRequest);
      case 'EvaluateParams':
        return evaluateParams(ctx, request as $6.EvaluateParamsRequest);
      case 'EvaluateParamsLegacy':
        return evaluateParamsLegacy(
            ctx, request as $6.EvaluateParamsLegacyRequest);
      case 'ComputeMemoryState':
        return computeMemoryState(ctx, request as $0.CardId);
      case 'FuzzDelta':
        return fuzzDelta(ctx, request as $6.FuzzDeltaRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SchedulerServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SchedulerServiceBase$messageJson;
}

abstract class BackendSchedulerServiceBase extends $pb.GeneratedService {
  $async.Future<$6.ComputeFsrsParamsResponse> computeFsrsParamsFromItems(
      $pb.ServerContext ctx, $6.ComputeFsrsParamsFromItemsRequest request);
  $async.Future<$6.FsrsBenchmarkResponse> fsrsBenchmark(
      $pb.ServerContext ctx, $6.FsrsBenchmarkRequest request);
  $async.Future<$3.Empty> exportDataset(
      $pb.ServerContext ctx, $6.ExportDatasetRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ComputeFsrsParamsFromItems':
        return $6.ComputeFsrsParamsFromItemsRequest();
      case 'FsrsBenchmark':
        return $6.FsrsBenchmarkRequest();
      case 'ExportDataset':
        return $6.ExportDatasetRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ComputeFsrsParamsFromItems':
        return computeFsrsParamsFromItems(
            ctx, request as $6.ComputeFsrsParamsFromItemsRequest);
      case 'FsrsBenchmark':
        return fsrsBenchmark(ctx, request as $6.FsrsBenchmarkRequest);
      case 'ExportDataset':
        return exportDataset(ctx, request as $6.ExportDatasetRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      BackendSchedulerServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => BackendSchedulerServiceBase$messageJson;
}
