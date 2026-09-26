import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:flutter/foundation.dart';

class ReviewController extends ChangeNotifier {
  ReviewController({
    required this._repository,
    required this._renderer,
    required int Function() wallClockMillis,
    required this._stopwatchFactory,
  });

  final ReviewRepository _repository;
  final CardRenderRepository _renderer;
  final Stopwatch Function() _stopwatchFactory;

  ReviewSessionState _state = const ReviewInitial();
  int _generation = 0;

  ReviewSessionState get state => _state;

  Future<void> start(int deckId) async {
    final generationId = ++_generation;
    _setState(const ReviewLoading());

    await _repository.selectDeck(deckId);
    final card = await _repository.nextCard();
    if (card == null) {
      _setState(const ReviewFinished());
      return;
    }

    final settings = await _repository.settingsForDeck(card.deckId);
    final content = await _renderer.render(card.cardId);
    _stopwatchFactory().start();

    _setState(
      ReviewQuestion(
        card: card,
        content: content,
        settings: settings,
        generationId: generationId,
      ),
    );
  }

  Future<void> showAnswer() async {
    final current = _state;
    if (current is! ReviewQuestion) {
      return;
    }

    _setState(
      ReviewAnswer(
        card: current.card,
        content: current.content,
        settings: current.settings,
        generationId: current.generationId,
      ),
    );
  }

  void _setState(ReviewSessionState state) {
    _state = state;
    notifyListeners();
  }
}
