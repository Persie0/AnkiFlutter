enum BackendOperation {
  openCollection(1),
  closeCollection(2),
  deckTree(3);

  const BackendOperation(this.nativeId);
  final int nativeId;
}
