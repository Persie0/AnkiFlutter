import 'dart:async';

import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';
import 'package:anki_flutter/features/reviewer/audio/review_tts_service.dart';
import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:flutter/foundation.dart';

abstract interface class ReviewTimerHandle {
  bool get isActive;

  void cancel();
}

typedef ReviewTimerFactory = ReviewTimerHandle Function(
  Duration delay,
  Future<void> Function() callback,
);

class ReviewController extends ChangeNotifier {
  ReviewController({
    required this._repository,
    required this._renderer,
    required this._wallClockMillis,
    required this._stopwatchFactory,
    this._audio,
    this._tts,
    this._mediaUriFor,
    this._timerFactory,
  }) {
    _audio?.playingChanges.listen(_onPlayingChanged);
  }

  final ReviewRepository _repository;
  final CardRenderRepository _renderer;
  final int Function() _wallClockMillis;
  final Stopwatch Function() _stopwatchFactory;
  final ReviewAudioService? _audio;
  final ReviewTtsService? _tts;
  final Uri Function(String filename)? _mediaUriFor;
  final ReviewTimerFactory? _timerFactory;

  ReviewSessionState _state = const ReviewInitial();
  Stopwatch? _answerStopwatch;
  ReviewTimerHandle? _autoAdvanceTimer;
  _DeferredAutoAdvance? _deferredAutoAdvance;
  bool _autoAdvanceEnabled = false;
  int _generation = 0;

  ReviewSessionState get state => _state;

  Future<void> start(int deckId) async {
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    final generationId = ++_generation;
    _setState(const ReviewLoading());

    await _repository.selectDeck(deckId);
    if (!_isCurrentGeneration(generationId)) {
      return;
    }

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
    _scheduleAutoAdvanceForCurrentState();

    if (current.settings.autoplay) {
      final tags = current.settings.skipQuestionWhenReplayingAnswer
          ? current.content.answerAudio
          : <ReviewAudioTag>[
              ...current.content.questionAudio,
              ...current.content.answerAudio,
            ];
      await _playTags(tags, current.generationId);
    }
  }

  Future<void> rate(ReviewRating rating) async {
    final current = _state;
    if (current is! ReviewAnswer ||
        !_isCurrentGeneration(current.generationId)) {
      return;
    }

    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    final generationId = current.generationId;
    _setState(
      ReviewTransition(
        card: current.card,
        content: current.content,
        settings: current.settings,
        generationId: generationId,
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
      if (!_isCurrentGeneration(generationId)) {
        return;
      }
      _setState(
        ReviewAnswer(
          card: current.card,
          content: current.content,
          settings: current.settings,
          generationId: generationId,
          error: error,
        ),
      );
      _scheduleAutoAdvanceForCurrentState();
      return;
    }

    if (!_isCurrentGeneration(generationId)) {
      return;
    }

    await _loadNextCard(++_generation);
  }

  Future<void> toggleAutoAdvance() async {
    _autoAdvanceEnabled = !_autoAdvanceEnabled;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    if (_autoAdvanceEnabled) {
      _scheduleAutoAdvanceForCurrentState();
    }
  }

  Future<void> _loadNextCard(int generationId) async {
    final card = await _repository.nextCard();
    if (!_isCurrentGeneration(generationId)) {
      return;
    }

    if (card == null) {
      _clearAutoAdvanceTimer();
      _deferredAutoAdvance = null;
      _answerStopwatch = null;
      _setState(const ReviewFinished());
      return;
    }

    final settings = await _repository.settingsForDeck(card.currentDeckId);
    if (!_isCurrentGeneration(generationId)) {
      return;
    }

    final content = await _renderer.render(card.cardId);
    if (!_isCurrentGeneration(generationId)) {
      return;
    }

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
    _scheduleAutoAdvanceForCurrentState();

    if (settings.autoplay) {
      await _playTags(content.questionAudio, generationId);
    }
  }

  void _scheduleAutoAdvanceForCurrentState() {
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    if (!_autoAdvanceEnabled) {
      return;
    }

    final current = _state;
    if (current is ReviewQuestion) {
      _scheduleAutoAdvance(
        seconds: current.settings.secondsToShowQuestion,
        side: _AutoAdvanceSide.question,
        generationId: current.generationId,
      );
    } else if (current is ReviewAnswer) {
      _scheduleAutoAdvance(
        seconds: current.settings.secondsToShowAnswer,
        side: _AutoAdvanceSide.answer,
        generationId: current.generationId,
      );
    }
  }

  void _scheduleAutoAdvance({
    required double seconds,
    required _AutoAdvanceSide side,
    required int generationId,
  }) {
    if (seconds <= 0) {
      return;
    }
    final delay = Duration(milliseconds: (seconds * 1000).toInt());
    final factory = _timerFactory ?? _defaultReviewTimerFactory;
    _autoAdvanceTimer = factory(
      delay,
      () => _onAutoAdvanceTimeout(side, generationId),
    );
  }

  Future<void> _onAutoAdvanceTimeout(
    _AutoAdvanceSide side,
    int generationId,
  ) async {
    _autoAdvanceTimer = null;
    if (!_autoAdvanceEnabled || !_isCurrentGeneration(generationId)) {
      return;
    }

    final current = _state;
    final ReviewDeckSettings? settings;
    if (side == _AutoAdvanceSide.question && current is ReviewQuestion) {
      settings = current.settings;
    } else if (side == _AutoAdvanceSide.answer && current is ReviewAnswer) {
      settings = current.settings;
    } else {
      return;
    }

    if (settings.waitForAudio && (_audio?.isPlaying ?? false)) {
      _deferredAutoAdvance = _DeferredAutoAdvance(side, generationId);
      return;
    }
    _deferredAutoAdvance = null;

    if (side == _AutoAdvanceSide.question) {
      if (settings.questionAction == ReviewQuestionAction.showAnswer) {
        await showAnswer();
      }
      return;
    }

    if (settings.answerAction == ReviewAnswerAction.answerGood) {
      await rate(ReviewRating.good);
    }
  }

  void _onPlayingChanged(bool isPlaying) {
    if (isPlaying) {
      return;
    }
    final deferred = _deferredAutoAdvance;
    if (deferred == null) {
      return;
    }
    _deferredAutoAdvance = null;
    unawaited(_onAutoAdvanceTimeout(deferred.side, deferred.generationId));
  }

  void _clearAutoAdvanceTimer() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
  }

  Future<void> _playTags(List<ReviewAudioTag> tags, int generationId) async {
    final audio = _audio;
    if (audio == null || tags.isEmpty) {
      return;
    }

    final uris = <Uri>[];
    for (final tag in tags) {
      if (!_isCurrentGeneration(generationId)) {
        return;
      }

      if (tag is ReviewMediaTag) {
        final resolver = _mediaUriFor;
        if (resolver != null) {
          uris.add(resolver(tag.filename));
        }
      } else if (tag is ReviewTtsTag) {
        final tts = _tts;
        if (tts != null) {
          final uri = await tts.materialize(tag);
          if (!_isCurrentGeneration(generationId)) {
            return;
          }
          if (uri != null) {
            uris.add(uri);
          }
        }
      }
    }

    if (uris.isNotEmpty && _isCurrentGeneration(generationId)) {
      await audio.playQueue(uris);
    }
  }

  bool _isCurrentGeneration(int generationId) => generationId == _generation;

  void _setState(ReviewSessionState state) {
    _state = state;
    notifyListeners();
  }
}

class _DartReviewTimerHandle implements ReviewTimerHandle {
  _DartReviewTimerHandle(
    Duration delay,
    Future<void> Function() callback,
  ) : _timer = Timer(delay, () => unawaited(callback()));

  final Timer _timer;

  @override
  bool get isActive => _timer.isActive;

  @override
  void cancel() => _timer.cancel();
}

ReviewTimerHandle _defaultReviewTimerFactory(
  Duration delay,
  Future<void> Function() callback,
) {
  return _DartReviewTimerHandle(delay, callback);
}

enum _AutoAdvanceSide { question, answer }

class _DeferredAutoAdvance {
  const _DeferredAutoAdvance(this.side, this.generationId);

  final _AutoAdvanceSide side;
  final int generationId;
}
