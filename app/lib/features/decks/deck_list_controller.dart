import 'package:anki_flutter/features/decks/deck_list_state.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/foundation.dart';

class DeckListController extends ChangeNotifier {
  DeckListController({required this.repository});

  final DeckRepository repository;
  DeckListState _state = const DeckListInitial();

  DeckListState get state => _state;

  Future<void> load() async {
    _setState(const DeckListLoading());
    try {
      final decks = await repository.loadDeckTree();
      _setState(DeckListReady(decks));
    } catch (error) {
      _setState(DeckListFailure(error));
    }
  }

  void _setState(DeckListState state) {
    _state = state;
    notifyListeners();
  }
}
