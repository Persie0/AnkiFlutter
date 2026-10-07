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

abstract interface class ReviewLeechRepository {
  Future<bool> isCardSuspended(ReviewCard card);
}

abstract interface class ReviewFlagRepository {
  Future<void> setFlag(ReviewCard card, int flag);
}

abstract interface class ReviewMarkRepository {
  Future<bool> isMarked(ReviewCard card);

  Future<void> setMarked(ReviewCard card, bool marked);
}

abstract interface class ReviewDeleteNoteRepository {
  Future<void> deleteNote(ReviewCard card);
}

final class ReviewForgetCardOptions {
  const ReviewForgetCardOptions({
    required this.restoreOriginalPosition,
    required this.resetRepetitionAndLapseCounts,
  });

  final bool restoreOriginalPosition;
  final bool resetRepetitionAndLapseCounts;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewForgetCardOptions &&
          other.restoreOriginalPosition == restoreOriginalPosition &&
          other.resetRepetitionAndLapseCounts == resetRepetitionAndLapseCounts;

  @override
  int get hashCode => Object.hash(
    restoreOriginalPosition,
    resetRepetitionAndLapseCounts,
  );
}

abstract interface class ReviewForgetCardRepository {
  Future<ReviewForgetCardOptions> forgetCardDefaults();

  Future<void> forgetCard(
    ReviewCard card,
    ReviewForgetCardOptions options,
  );
}

abstract interface class ReviewSetDueDateRepository {
  Future<String> dueDateDefault();

  Future<void> setDueDate(ReviewCard card, String days);
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
  Future<ReviewTypedAnswerPreparation> prepareTypedAnswer(
    ReviewCard card,
    String pattern,
  ) {
    if (this case final ReviewTypedAnswerRepository repository) {
      return repository.prepareTypedAnswer(card, pattern);
    }
    throw UnsupportedError('Typed answers are not supported by this repository');
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
