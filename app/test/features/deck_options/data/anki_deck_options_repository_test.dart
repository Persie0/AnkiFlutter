import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/deck_config.pb.dart' as deck_config;
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as decks;
import 'package:anki_flutter/features/deck_options/data/anki_deck_options_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads deck configs for the target deck', () async {
    final expected = deck_config.DeckConfigsForUpdate(
      currentDeck: deck_config.DeckConfigsForUpdate_CurrentDeck(
        name: 'Default',
        configId: Int64(1),
      ),
    );
    final backend = _BackendQueue([expected.writeToBuffer()]);
    final repository = AnkiDeckOptionsRepository(backend: backend);

    final result = await repository.load(123);

    expect(result, expected);
    expect(backend.calls.single.operation, BackendOperation.getDeckConfigsForUpdate);
    expect(decks.DeckId.fromBuffer(backend.calls.single.request).did, Int64(123));
  });

  test('preserves global and per-deck state when updating selected config', () async {
    final snapshot = deck_config.DeckConfigsForUpdate(
      currentDeck: deck_config.DeckConfigsForUpdate_CurrentDeck(
        name: 'Deck',
        configId: Int64(1),
        limits: deck_config.DeckConfigsForUpdate_CurrentDeck_Limits(
          review: 200,
          new_2: 30,
          desiredRetention: 0.91,
        ),
      ),
      cardStateCustomizer: 'return states;',
      newCardsIgnoreReviewLimit: true,
      fsrs: true,
      applyAllParentLimits: true,
    );
    final config = deck_config.DeckConfig(
      id: Int64(1),
      name: 'Default',
      config: deck_config.DeckConfig_Config(newPerDay: 25),
    );
    final backend = _BackendQueue([Uint8List(0)]);
    final repository = AnkiDeckOptionsRepository(backend: backend);

    await repository.save(
      123,
      snapshot: snapshot,
      selectedConfig: config,
      fsrsReschedule: false,
    );

    expect(backend.calls.single.operation, BackendOperation.updateDeckConfigs);
    final request = deck_config.UpdateDeckConfigsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.targetDeckId, Int64(123));
    expect(request.configs.single.config.newPerDay, 25);
    expect(request.limits.review, 200);
    expect(request.limits.new_2, 30);
    expect(request.newCardsIgnoreReviewLimit, isTrue);
    expect(request.fsrs, isTrue);
    expect(request.applyAllParentLimits, isTrue);
    expect(request.cardStateCustomizer, 'return states;');
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _BackendQueue implements BackendInvoker {
  _BackendQueue(this.responses);
  final List<Uint8List> responses;
  final calls = <_Call>[];
  var _index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    return responses[_index++];
  }
}
