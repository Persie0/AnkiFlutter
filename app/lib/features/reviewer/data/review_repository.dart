import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';

abstract interface class ReviewRepository {
  Future<void> selectDeck(int deckId);

  Future<ReviewCard?> nextCard();

  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  });

  Future<bool> stateIsLeech(ReviewAnswerChoice choice);

  Future<ReviewDeckSettings> settingsForDeck(int deckId);
}
