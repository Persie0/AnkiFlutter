final class CardInfoMemoryState {
  const CardInfoMemoryState({
    required this.stability,
    required this.difficulty,
  });

  final double stability;
  final double difficulty;
}

final class CardReviewHistoryEntry {
  const CardReviewHistoryEntry({
    required this.unixSeconds,
    required this.reviewKindValue,
    required this.buttonChosen,
    required this.intervalSeconds,
    required this.lastIntervalSeconds,
    required this.easePermille,
    required this.takenSeconds,
    this.memoryState,
  });

  final int unixSeconds;
  final int reviewKindValue;
  final int buttonChosen;
  final int intervalSeconds;
  final int lastIntervalSeconds;
  final int easePermille;
  final double takenSeconds;
  final CardInfoMemoryState? memoryState;
}

final class CardInfoData {
  CardInfoData({
    required this.cardId,
    required this.noteId,
    required this.deck,
    required this.cardType,
    required this.noteType,
    required this.preset,
    required this.addedUnixSeconds,
    required this.intervalDays,
    required this.easePermille,
    required this.reviews,
    required this.lapses,
    required this.averageSeconds,
    required this.totalSeconds,
    required this.customData,
    required List<double> fsrsParameters,
    required List<CardReviewHistoryEntry> reviewHistory,
    this.originalDeck,
    this.firstReviewUnixSeconds,
    this.latestReviewUnixSeconds,
    this.dueUnixSeconds,
    this.duePosition,
    this.memoryState,
    this.retrievability,
    this.desiredRetention,
  }) : fsrsParameters = List<double>.unmodifiable(fsrsParameters),
       reviewHistory = List<CardReviewHistoryEntry>.unmodifiable(reviewHistory);

  final int cardId;
  final int noteId;
  final String deck;
  final String? originalDeck;
  final String cardType;
  final String noteType;
  final String preset;
  final int addedUnixSeconds;
  final int? firstReviewUnixSeconds;
  final int? latestReviewUnixSeconds;
  final int? dueUnixSeconds;
  final int? duePosition;
  final int intervalDays;
  final int easePermille;
  final int reviews;
  final int lapses;
  final double averageSeconds;
  final double totalSeconds;
  final String customData;
  final CardInfoMemoryState? memoryState;
  final double? retrievability;
  final double? desiredRetention;
  final List<double> fsrsParameters;
  final List<CardReviewHistoryEntry> reviewHistory;
}
