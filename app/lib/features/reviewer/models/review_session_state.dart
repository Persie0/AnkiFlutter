import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';

sealed class ReviewSessionState {
  const ReviewSessionState();
}

final class ReviewInitial extends ReviewSessionState {
  const ReviewInitial();
}

final class ReviewLoading extends ReviewSessionState {
  const ReviewLoading();
}

final class ReviewQuestion extends ReviewSessionState {
  const ReviewQuestion({
    required this.card,
    required this.content,
    required this.settings,
    required this.generationId,
  });

  final ReviewCard card;
  final ReviewCardContent content;
  final ReviewDeckSettings settings;
  final int generationId;
}

final class ReviewFinished extends ReviewSessionState {
  const ReviewFinished();
}
