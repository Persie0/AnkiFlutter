import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards;
import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart' as stats;
import 'package:anki_flutter/features/card_info/data/card_info_repository.dart';
import 'package:anki_flutter/features/card_info/models/card_info_data.dart';
import 'package:fixnum/fixnum.dart';

final class AnkiCardInfoRepository implements CardInfoRepository {
  const AnkiCardInfoRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<CardInfoData> load(int cardId) async {
    final responseBytes = await backend.invoke(
      BackendOperation.cardStats,
      Uint8List.fromList(cards.CardId(cid: Int64(cardId)).writeToBuffer()),
    );
    return _mapCardStats(stats.CardStatsResponse.fromBuffer(responseBytes));
  }
}

CardInfoData _mapCardStats(stats.CardStatsResponse response) => CardInfoData(
  cardId: response.cardId.toInt(),
  noteId: response.noteId.toInt(),
  deck: response.deck,
  originalDeck: response.hasOriginalDeck() ? response.originalDeck : null,
  cardType: response.cardType,
  noteType: response.notetype,
  preset: response.preset,
  addedUnixSeconds: response.added.toInt(),
  firstReviewUnixSeconds: response.hasFirstReview()
      ? response.firstReview.toInt()
      : null,
  latestReviewUnixSeconds: response.hasLatestReview()
      ? response.latestReview.toInt()
      : null,
  dueUnixSeconds: response.hasDueDate() ? response.dueDate.toInt() : null,
  duePosition: response.hasDuePosition() ? response.duePosition : null,
  intervalDays: response.interval,
  easePermille: response.ease,
  reviews: response.reviews,
  lapses: response.lapses,
  averageSeconds: response.averageSecs,
  totalSeconds: response.totalSecs,
  customData: response.customData,
  memoryState: response.hasMemoryState()
      ? _mapMemoryState(response.memoryState)
      : null,
  retrievability: response.hasFsrsRetrievability()
      ? response.fsrsRetrievability
      : null,
  desiredRetention: response.hasDesiredRetention()
      ? response.desiredRetention
      : null,
  fsrsParameters: response.fsrsParams,
  reviewHistory: response.revlog.map(_mapReviewHistoryEntry).toList(),
);

CardReviewHistoryEntry _mapReviewHistoryEntry(
  stats.CardStatsResponse_StatsRevlogEntry entry,
) => CardReviewHistoryEntry(
  unixSeconds: entry.time.toInt(),
  reviewKindValue: entry.reviewKind.value,
  buttonChosen: entry.buttonChosen,
  intervalSeconds: entry.interval,
  lastIntervalSeconds: entry.lastInterval,
  easePermille: entry.ease,
  takenSeconds: entry.takenSecs,
  memoryState: entry.hasMemoryState() ? _mapMemoryState(entry.memoryState) : null,
);

CardInfoMemoryState _mapMemoryState(cards.FsrsMemoryState state) =>
    CardInfoMemoryState(
      stability: state.stability,
      difficulty: state.difficulty,
    );
