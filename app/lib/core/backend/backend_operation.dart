enum BackendOperation {
  openCollection(1),
  closeCollection(2),
  deckTree(3),
  setCurrentDeck(4),
  getQueuedCards(5),
  describeNextStates(6),
  answerCard(7),
  stateIsLeech(8),
  buryOrSuspendCards(9),
  getUndoStatus(10),
  undo(11),
  renderExistingCard(12),
  extractAvTags(13),
  allTtsVoices(14),
  writeTtsStream(15),
  getDeckConfigsForUpdate(16),
  encodeIriPaths(17),
  renameDeck(18),
  removeDecks(19);

  const BackendOperation(this.nativeId);
  final int nativeId;
}
