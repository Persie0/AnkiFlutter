import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:flutter/foundation.dart';

class ReviewController extends ChangeNotifier {
  ReviewController({
    required this._repository,
    required this._renderer,
    required int Function() wallClockMillis,
    required this._stopwatchFactory,
  }) : _wallClockMillis = wallClockMillis;

  final ReviewRepository _repository;
  final CardRenderRepository _renderer;
  final int Function() _wallClockMillis;
  final Stopwatch Function() _stopwatchFactory;

  ReviewSessionState _state = const ReviewInitial();
  Stopwatch? _answerStopwatch;
  int _generation = 0;

  ReviewSessionState get state => _state;

  Future<void> start(int deckId) async {
    final generationId = ++_generation;
    _setState(const ReviewLoading());

    await _repository.selectDeck(deckId);
    await _loadNextCard(generationId);
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

  Future<void> rate(ReviewRating rating) async {
    final current = _state;
    if (current is! ReviewAnswer) {
      return;
    }

    _setState(
      ReviewTransition(
        card: current.card,
        content: current.content,
        settings: current.settings,
        generationId: current.generationId,
      ),
    );

    final answeredAtMillis = _wallClockMillis();
    final millisecondsTaken = _answerStopwatch?.elapsedMilliseconds ?? 0;

    try {
      await _repository.answer(
        current.card,
        rating,
        answeredAtMillis: answeredAtMillis,
        millisecondsTaken: millisecondsTaken,
      );
    } catch (error) {
      _setState(
        ReviewAnswer(
          card: current.card,
          content: current.content,
          settings: current.settings,
          generationId: current.generationId,
          error: error,
        ),
      );
      return;
    }

    await _loadNextCard(++_generation);
  }

  Future<void> _loadNextCard(int generationId) async {
    final card = await _repository.nextCard();
    if (card == null) {
      _answerStopwatch = null;
      _setState(const ReviewFinished());
      return;
    }

    final settings = await _repository.settingsForDeck(card.deckId);
    final content = await _renderer.render(card.cardId);
    final stopwatch = _stopwatchFactory()..start();
    _answerStopwatch = stopwatch;

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
