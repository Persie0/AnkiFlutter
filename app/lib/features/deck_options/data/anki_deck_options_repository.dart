import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/deck_config.pb.dart' as deck_config;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks;
import 'package:fixnum/fixnum.dart';

abstract interface class DeckOptionsRepository {
  Future<deck_config.DeckConfigsForUpdate> load(int deckId);

  Future<void> save(
    int deckId, {
    required deck_config.DeckConfigsForUpdate snapshot,
    required deck_config.DeckConfig selectedConfig,
    required bool fsrsReschedule,
  });
}

class AnkiDeckOptionsRepository implements DeckOptionsRepository {
  const AnkiDeckOptionsRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<deck_config.DeckConfigsForUpdate> load(int deckId) async {
    final response = await backend.invoke(
      BackendOperation.getDeckConfigsForUpdate,
      Uint8List.fromList(decks.DeckId(did: Int64(deckId)).writeToBuffer()),
    );
    return deck_config.DeckConfigsForUpdate.fromBuffer(response);
  }

  @override
  Future<void> save(
    int deckId, {
    required deck_config.DeckConfigsForUpdate snapshot,
    required deck_config.DeckConfig selectedConfig,
    required bool fsrsReschedule,
  }) async {
    final request = deck_config.UpdateDeckConfigsRequest(
      targetDeckId: Int64(deckId),
      configs: [selectedConfig.deepCopy()],
      mode: deck_config.UpdateDeckConfigsMode.UPDATE_DECK_CONFIGS_MODE_NORMAL,
      cardStateCustomizer: snapshot.cardStateCustomizer,
      limits: snapshot.currentDeck.limits.deepCopy(),
      newCardsIgnoreReviewLimit: snapshot.newCardsIgnoreReviewLimit,
      fsrs: snapshot.fsrs,
      applyAllParentLimits: snapshot.applyAllParentLimits,
      fsrsReschedule: fsrsReschedule,
      fsrsHealthCheck: snapshot.fsrsHealthCheck,
    );
    await backend.invoke(
      BackendOperation.updateDeckConfigs,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }
}
