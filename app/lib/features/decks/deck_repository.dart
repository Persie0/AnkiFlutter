import 'package:anki_flutter/features/decks/deck_node.dart';

abstract interface class DeckRepository {
  Future<List<DeckNode>> loadDeckTree();
}
