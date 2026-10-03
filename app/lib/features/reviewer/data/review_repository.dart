import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_typed_answer_preparation.dart';

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

  Future<bool> canUndo();

  Future<void> undo();

  Future<void> buryCard(ReviewCard card);

  Future<void> buryNote(ReviewCard card);

  Future<void> suspendCard(ReviewCard card);

  Future<void> suspendNote(ReviewCard card);

  Future<ReviewDeckSettings> settingsForDeck(int deckId);
}

abstract interface class ReviewFlagRepository {
  Future<void> setFlag(ReviewCard card, int flag);
}

abstract interface class ReviewTypedAnswerRepository {
  Future<ReviewTypedAnswerPreparation> prepareTypedAnswer(
    ReviewCard card,
    String pattern,
  );

  Future<String> compareTypedAnswer({
    required String expected,
    required String provided,
    required bool combining,
  });
}

extension ReviewTypedAnswerCapability on ReviewRepository {
  Future<ReviewTypedAnswerPreparation?> prepareTypedAnswerIfSupported(
    ReviewCard card,
    String pattern,
  ) {
    if (this case final ReviewTypedAnswerRepository repository) {
      return repository.prepareTypedAnswer(card, pattern);
    }
    return Future.value();
  }

  Future<String> compareTypedAnswer({
    required String expected,
    required String provided,
    required bool combining,
  }) {
    if (this case final ReviewTypedAnswerRepository repository) {
      return repository.compareTypedAnswer(
        expected: expected,
        provided: provided,
        combining: combining,
      );
    }
    throw UnsupportedError('Typed answers are not supported by this repository');
  }
}
