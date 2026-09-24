import 'package:anki_flutter/features/decks/deck_node.dart';

sealed class DeckListState {
  const DeckListState();
}

final class DeckListInitial extends DeckListState {
  const DeckListInitial();
}

final class DeckListLoading extends DeckListState {
  const DeckListLoading();
}

final class DeckListReady extends DeckListState {
  const DeckListReady(this.decks);

  final List<DeckNode> decks;
}

final class DeckListFailure extends DeckListState {
  const DeckListFailure(this.error);

  final Object error;
}
