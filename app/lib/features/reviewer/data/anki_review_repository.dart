import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/card_rendering.pb.dart'
    as card_rendering_pb;
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards_pb;
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection_pb;
import 'package:anki_flutter/core/backend/generated/anki/deck_config.pb.dart'
    as deck_config_pb;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes_pb;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler_pb;
import 'package:anki_flutter/core/backend/generated/anki/tags.pb.dart' as tags_pb;
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_typed_answer_preparation.dart';
import 'package:anki_flutter/features/reviewer/models/review_typed_answer_prompt.dart';
import 'package:fixnum/fixnum.dart';

class AnkiReviewRepository
    implements
        ReviewRepository,
        ReviewFlagRepository,
        ReviewMarkRepository,
        ReviewDeleteNoteRepository,
        ReviewForgetCardRepository,
        ReviewTypedAnswerRepository {
  AnkiReviewRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<void> selectDeck(int deckId) async {
    final request = decks_pb.DeckId(did: Int64(deckId));
    await backend.invoke(
      BackendOperation.setCurrentDeck,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
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
      originalDeckId: queued.card.originalDeckId.toInt(),
      templateOrdinal: queued.card.templateIdx,
      flag: queued.card.flags & 0x7,
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

  @override
  Future<void> setFlag(ReviewCard card, int flag) async {
    final request = cards_pb.SetFlagRequest(
      cardIds: [Int64(card.cardId)],
      flag: flag,
    );
    await backend.invoke(
      BackendOperation.setFlag,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<bool> isMarked(ReviewCard card) async {
    final response = await backend.invoke(
      BackendOperation.getNote,
      Uint8List.fromList(
        notes_pb.NoteId(nid: Int64(card.noteId)).writeToBuffer(),
      ),
    );
    return notes_pb.Note.fromBuffer(response).tags.contains('marked');
  }

  @override
  Future<void> setMarked(ReviewCard card, bool marked) async {
    final request = tags_pb.NoteIdsAndTagsRequest(
      noteIds: [Int64(card.noteId)],
      tags: 'marked',
    );
    await backend.invoke(
      marked ? BackendOperation.addNoteTags : BackendOperation.removeNoteTags,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<void> deleteNote(ReviewCard card) async {
    final request = notes_pb.RemoveNotesRequest(
      noteIds: [Int64(card.noteId)],
    );
    await backend.invoke(
      BackendOperation.removeNotes,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<ReviewForgetCardOptions> forgetCardDefaults() async {
    final request = scheduler_pb.ScheduleCardsAsNewDefaultsRequest(
      context: scheduler_pb.ScheduleCardsAsNewRequest_Context.REVIEWER,
    );
    final response = await backend.invoke(
      BackendOperation.scheduleCardsAsNewDefaults,
      Uint8List.fromList(request.writeToBuffer()),
    );
    final defaults = scheduler_pb.ScheduleCardsAsNewDefaultsResponse.fromBuffer(
      response,
    );
    return ReviewForgetCardOptions(
      restoreOriginalPosition: defaults.restorePosition,
      resetRepetitionAndLapseCounts: defaults.resetCounts,
    );
  }

  @override
  Future<void> forgetCard(
    ReviewCard card,
    ReviewForgetCardOptions options,
  ) async {
    final request = scheduler_pb.ScheduleCardsAsNewRequest(
      cardIds: [Int64(card.cardId)],
      log: true,
      restorePosition: options.restoreOriginalPosition,
      resetCounts: options.resetRepetitionAndLapseCounts,
      context: scheduler_pb.ScheduleCardsAsNewRequest_Context.REVIEWER,
    );
    await backend.invoke(
      BackendOperation.scheduleCardsAsNew,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<ReviewTypedAnswerPreparation> prepareTypedAnswer(
    ReviewCard card,
    String pattern,
  ) async {
    var fieldName = pattern;
    var cloze = false;
    var combining = true;

    if (fieldName.startsWith('cloze:')) {
      cloze = true;
      fieldName = fieldName.substring('cloze:'.length);
    }
    if (fieldName.startsWith('nc:')) {
      combining = false;
      fieldName = fieldName.substring('nc:'.length);
    }

    final noteBytes = await backend.invoke(
      BackendOperation.getNote,
      Uint8List.fromList(
        notes_pb.NoteId(nid: Int64(card.noteId)).writeToBuffer(),
      ),
    );
    final note = notes_pb.Note.fromBuffer(noteBytes);

    final notetypeBytes = await backend.invoke(
      BackendOperation.getNotetype,
      Uint8List.fromList(
        notetypes_pb.NotetypeId(ntid: note.notetypeId).writeToBuffer(),
      ),
    );
    final notetype = notetypes_pb.Notetype.fromBuffer(notetypeBytes);

    final matchingFields = notetype.fields.where(
      (field) => field.name == fieldName,
    );
    if (matchingFields.isEmpty) {
      return cloze
          ? const ReviewTypedAnswerWarning('Please run Tools>Empty Cards')
          : ReviewTypedAnswerWarning('Type answer: unknown field $fieldName');
    }

    final field = matchingFields.first;
    final fieldOrdinal = field.ord.val;
    if (fieldOrdinal >= note.fields.length) {
      return const ReviewTypedAnswerEmpty();
    }

    var expected = note.fields[fieldOrdinal];
    if (cloze) {
      final request = card_rendering_pb.ExtractClozeForTypingRequest(
        text: expected,
        ordinal: card.templateOrdinal + 1,
      );
      final response = await backend.invoke(
        BackendOperation.extractClozeForTyping,
        Uint8List.fromList(request.writeToBuffer()),
      );
      expected = generic_pb.String.fromBuffer(response).val;
      if (expected.isEmpty) {
        return const ReviewTypedAnswerWarning('Please run Tools>Empty Cards');
      }
    } else if (expected.isEmpty) {
      return const ReviewTypedAnswerEmpty();
    }

    return ReviewTypedAnswerReady(
      ReviewTypedAnswerPrompt(
        pattern: pattern,
        fieldName: fieldName,
        expected: expected,
        combining: combining,
        fontName: field.config.fontName,
        fontSize: field.config.fontSize,
      ),
    );
  }

  @override
  Future<String> compareTypedAnswer({
    required String expected,
    required String provided,
    required bool combining,
  }) async {
    final request = card_rendering_pb.CompareAnswerRequest(
      expected: expected,
      provided: provided,
      combining: combining,
    );
    final response = await backend.invoke(
      BackendOperation.compareAnswer,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return generic_pb.String.fromBuffer(response).val;
  }

  @override
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

  @override
  Future<bool> stateIsLeech(ReviewAnswerChoice choice) async {
    final state = scheduler_pb.SchedulingState.fromBuffer(
      choice.schedulingStateBytes,
    );
    final response = await backend.invoke(
      BackendOperation.stateIsLeech,
      Uint8List.fromList(state.writeToBuffer()),
    );
    return generic_pb.Bool.fromBuffer(response).val;
  }

  @override
  Future<void> buryCard(ReviewCard card) {
    return _buryOrSuspend(
      cardIds: [card.cardId],
      mode: scheduler_pb.BuryOrSuspendCardsRequest_Mode.BURY_USER,
    );
  }

  @override
  Future<void> buryNote(ReviewCard card) {
    return _buryOrSuspend(
      noteIds: [card.noteId],
      mode: scheduler_pb.BuryOrSuspendCardsRequest_Mode.BURY_USER,
    );
  }

  @override
  Future<void> suspendCard(ReviewCard card) {
    return _buryOrSuspend(
      cardIds: [card.cardId],
      mode: scheduler_pb.BuryOrSuspendCardsRequest_Mode.SUSPEND,
    );
  }

  @override
  Future<void> suspendNote(ReviewCard card) {
    return _buryOrSuspend(
      noteIds: [card.noteId],
      mode: scheduler_pb.BuryOrSuspendCardsRequest_Mode.SUSPEND,
    );
  }

  @override
  Future<bool> canUndo() async {
    final response = await backend.invoke(
      BackendOperation.getUndoStatus,
      Uint8List.fromList(generic_pb.Empty().writeToBuffer()),
    );
    return collection_pb.UndoStatus.fromBuffer(response).undo.isNotEmpty;
  }

  @override
  Future<void> undo() async {
    if (!await canUndo()) {
      return;
    }
    await backend.invoke(
      BackendOperation.undo,
      Uint8List.fromList(generic_pb.Empty().writeToBuffer()),
    );
  }

  Future<void> _buryOrSuspend({
    Iterable<int> cardIds = const [],
    Iterable<int> noteIds = const [],
    required scheduler_pb.BuryOrSuspendCardsRequest_Mode mode,
  }) async {
    final request = scheduler_pb.BuryOrSuspendCardsRequest(
      cardIds: cardIds.map(Int64.new),
      noteIds: noteIds.map(Int64.new),
      mode: mode,
    );
    await backend.invoke(
      BackendOperation.buryOrSuspendCards,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async {
    final request = decks_pb.DeckId(did: Int64(deckId));
    final bytes = await backend.invoke(
      BackendOperation.getDeckConfigsForUpdate,
      Uint8List.fromList(request.writeToBuffer()),
    );
    final response = deck_config_pb.DeckConfigsForUpdate.fromBuffer(bytes);

    var config = response.defaults.config;
    final currentConfigId = response.currentDeck.configId.toInt();
    for (final entry in response.allConfig) {
      if (entry.config.id.toInt() == currentConfigId) {
        config = entry.config.config;
        break;
      }
    }

    return ReviewDeckSettings(
      autoplay: !config.disableAutoplay,
      showTimer: config.showTimer,
      stopTimerOnAnswer: config.stopTimerOnAnswer,
      answerTimeLimitSeconds: config.capAnswerTimeToSecs,
      secondsToShowQuestion: config.secondsToShowQuestion,
      secondsToShowAnswer: config.secondsToShowAnswer,
      waitForAudio: config.waitForAudio,
      skipQuestionWhenReplayingAnswer: config.skipQuestionWhenReplayingAnswer,
      questionAction: _questionAction(config.questionAction),
      answerAction: _answerAction(config.answerAction),
    );
  }

  ReviewQuestionAction _questionAction(
    deck_config_pb.DeckConfig_Config_QuestionAction action,
  ) {
    if (action ==
        deck_config_pb.DeckConfig_Config_QuestionAction
            .QUESTION_ACTION_SHOW_REMINDER) {
      return ReviewQuestionAction.showReminder;
    }
    return ReviewQuestionAction.showAnswer;
  }

  ReviewAnswerAction _answerAction(
    deck_config_pb.DeckConfig_Config_AnswerAction action,
  ) {
    if (action ==
        deck_config_pb.DeckConfig_Config_AnswerAction.ANSWER_ACTION_ANSWER_AGAIN) {
      return ReviewAnswerAction.answerAgain;
    }
    if (action ==
        deck_config_pb.DeckConfig_Config_AnswerAction.ANSWER_ACTION_ANSWER_GOOD) {
      return ReviewAnswerAction.answerGood;
    }
    if (action ==
        deck_config_pb.DeckConfig_Config_AnswerAction.ANSWER_ACTION_ANSWER_HARD) {
      return ReviewAnswerAction.answerHard;
    }
    if (action ==
        deck_config_pb.DeckConfig_Config_AnswerAction.ANSWER_ACTION_SHOW_REMINDER) {
      return ReviewAnswerAction.showReminder;
    }
    return ReviewAnswerAction.buryCard;
  }
}
