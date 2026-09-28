import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('backend operation ids match the stable native bridge contract', () {
    expect(
      {
        for (final operation in BackendOperation.values)
          operation.name: operation.nativeId,
      },
      {
        'openCollection': 1,
        'closeCollection': 2,
        'deckTree': 3,
        'setCurrentDeck': 4,
        'getQueuedCards': 5,
        'describeNextStates': 6,
        'answerCard': 7,
        'stateIsLeech': 8,
        'buryOrSuspendCards': 9,
        'getUndoStatus': 10,
        'undo': 11,
        'renderExistingCard': 12,
        'extractAvTags': 13,
        'allTtsVoices': 14,
        'writeTtsStream': 15,
        'getDeckConfigsForUpdate': 16,
        'encodeIriPaths': 17,
        'renameDeck': 18,
        'removeDecks': 19,
        'getNotetypeNamesAndCounts': 20,
        'newNote': 21,
        'addNote': 22,
        'getNotetype': 23,
        'defaultsForAdding': 24,
        'searchCards': 25,
        'browserRowForId': 26,
        'setActiveBrowserColumns': 27,
        'getConfigJson': 28,
        'getNote': 29,
        'updateNotes': 30,
        'getCard': 31,
      },
    );

    final ids = BackendOperation.values
        .map((operation) => operation.nativeId)
        .toList();
    expect(ids.toSet().length, ids.length);
  });
}
