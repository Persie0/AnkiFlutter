import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler_pb;
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:fixnum/fixnum.dart';

class AnkiReviewRepository {
  AnkiReviewRepository({required this.backend});

  final BackendInvoker backend;

  Future<void> selectDeck(int deckId) async {
    final request = decks_pb.DeckId(did: Int64(deckId));
    await backend.invoke(
      BackendOperation.setCurrentDeck,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  Future<ReviewCard?> nextCard() async {
    final request = scheduler_pb.GetQueuedCardsRequest(
      fetchLimit: 1,
      intradayLearningOnly: false,
    );
    final response = await backend.invoke(
      BackendOperation.getQueuedCards,
      Uint8List.fromList(request.writeToBuffer()),
    );
    final queuedCards = scheduler_pb.QueuedCards.fromBuffer(response);
    if (queuedCards.cards.isEmpty) {
      return null;
    }

    final queued = queuedCards.cards.first;
    final intervalResponse = await backend.invoke(
      BackendOperation.describeNextStates,
      Uint8List.fromList(queued.states.writeToBuffer()),
    );
    final intervalLabels = generic_pb.StringList.fromBuffer(intervalResponse).vals;

    final currentState = scheduler_pb.SchedulingState.fromBuffer(
      queued.states.current.writeToBuffer(),
    )..customData = queued.card.customData;

    final choiceStates = [
      queued.states.again,
      queued.states.hard,
      queued.states.good,
      queued.states.easy,
    ];
    final choices = <ReviewAnswerChoice>[
      for (var index = 0; index < ReviewRating.values.length; index++)
        ReviewAnswerChoice(
          rating: ReviewRating.values[index],
          intervalLabel: intervalLabels[index],
          schedulingStateBytes: Uint8List.fromList(
            choiceStates[index].writeToBuffer(),
          ),
        ),
    ];

    return ReviewCard(
      cardId: queued.card.id.toInt(),
      noteId: queued.card.noteId.toInt(),
      deckId: queued.card.deckId.toInt(),
      counts: ReviewCounts(
        newCount: queuedCards.newCount,
        learningCount: queuedCards.learningCount,
        reviewCount: queuedCards.reviewCount,
      ),
      currentStateBytes: Uint8List.fromList(currentState.writeToBuffer()),
      choices: choices,
      deckName: queued.context.deckName,
    );
  }

  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {
    final choice = card.choices.singleWhere((choice) => choice.rating == rating);
    final request = scheduler_pb.CardAnswer(
      cardId: Int64(card.cardId),
      currentState: scheduler_pb.SchedulingState.fromBuffer(
        card.currentStateBytes,
      ),
      newState: scheduler_pb.SchedulingState.fromBuffer(
        choice.schedulingStateBytes,
      ),
      rating: switch (rating) {
        ReviewRating.again => scheduler_pb.CardAnswer_Rating.AGAIN,
        ReviewRating.hard => scheduler_pb.CardAnswer_Rating.HARD,
        ReviewRating.good => scheduler_pb.CardAnswer_Rating.GOOD,
        ReviewRating.easy => scheduler_pb.CardAnswer_Rating.EASY,
      },
      answeredAtMillis: Int64(answeredAtMillis),
      millisecondsTaken: millisecondsTaken,
    );
    await backend.invoke(
      BackendOperation.answerCard,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }
}
