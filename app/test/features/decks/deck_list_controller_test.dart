import 'dart:async';

import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_state.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const decks = [
    DeckNode(
      id: 1,
      name: 'Default',
      newCount: 12,
      learnCount: 3,
      reviewCount: 45,
      filtered: false,
      children: [],
    ),
  ];

  test('load transitions Initial to Loading to Ready', () async {
    final completer = Completer<List<DeckNode>>();
    final repository = _CompleterRepository(completer);
    final controller = DeckListController(repository: repository);
    expect(controller.state, isA<DeckListInitial>());

    final load = controller.load();
    expect(controller.state, isA<DeckListLoading>());

    completer.complete(decks);
    await load;

    final ready = controller.state as DeckListReady;
    expect(ready.decks, decks);
    expect(repository.calls, 1);
  });

  test('repository error becomes DeckListFailure', () async {
    final repository = _SequenceRepository([StateError('broken')]);
    final controller = DeckListController(repository: repository);

    await controller.load();

    final failure = controller.state as DeckListFailure;
    expect(failure.error, isA<StateError>());
    expect(repository.calls, 1);
  });

  test('retry performs another request and can recover to Ready', () async {
    final repository = _SequenceRepository([StateError('first'), decks]);
    final controller = DeckListController(repository: repository);

    await controller.load();
    expect(controller.state, isA<DeckListFailure>());

    await controller.load();

    final ready = controller.state as DeckListReady;
    expect(ready.decks, decks);
    expect(repository.calls, 2);
  });
}

class _CompleterRepository implements DeckRepository {
  _CompleterRepository(this.completer);
  final Completer<List<DeckNode>> completer;
  int calls = 0;

  @override
  Future<List<DeckNode>> loadDeckTree() {
    calls += 1;
    return completer.future;
  }
}

class _SequenceRepository implements DeckRepository {
  _SequenceRepository(this.outcomes);
  final List<Object> outcomes;
  int calls = 0;

  @override
  Future<List<DeckNode>> loadDeckTree() async {
    final outcome = outcomes[calls++];
    if (outcome is Error) {
      throw outcome;
    }
    return outcome as List<DeckNode>;
  }
}
