import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:flutter/foundation.dart';

class ReviewController extends ChangeNotifier {
  ReviewController({
    required ReviewRepository repository,
    required CardRenderRepository renderer,
    required int Function() wallClockMillis,
    required Stopwatch Function() stopwatchFactory,
  })  : _repository = repository,
        _renderer = renderer,
        _stopwatchFactory = stopwatchFactory;

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
      throw StateError('Anki returned no queued card');
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

  void _setState(ReviewSessionState state) {
    _state = state;
    notifyListeners();
  }
}
