import 'dart:async';

import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';
import 'package:anki_flutter/features/reviewer/audio/review_tts_service.dart';
import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/models/review_typed_answer_preparation.dart';
import 'package:anki_flutter/features/reviewer/models/review_typed_answer_prompt.dart';
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
    required ReviewRepository repository,
    required CardRenderRepository renderer,
    required int Function() wallClockMillis,
    required Stopwatch Function() stopwatchFactory,
    ReviewAudioService? audio,
    ReviewTtsService? tts,
    Uri Function(String filename)? mediaUriFor,
    ReviewTimerFactory? timerFactory,
  }) {
    _repository = repository;
    _renderer = renderer;
    _wallClockMillis = wallClockMillis;
    _stopwatchFactory = stopwatchFactory;
    _audio = audio;
    _tts = tts;
    _mediaUriFor = mediaUriFor;
    _timerFactory = timerFactory;
    _playingSubscription = _audio?.playingChanges.listen(_onPlayingChanged);
  }

  static final RegExp _typedAnswerMarker = RegExp(r'\[\[type:(.+?)\]\]');

  late final ReviewRepository _repository;
  late final CardRenderRepository _renderer;
  late final int Function() _wallClockMillis;
  late final Stopwatch Function() _stopwatchFactory;
  late final ReviewAudioService? _audio;
  late final ReviewTtsService? _tts;
  late final Uri Function(String filename)? _mediaUriFor;
  late final ReviewTimerFactory? _timerFactory;
  late final StreamSubscription<bool>? _playingSubscription;

  ReviewSessionState _state = const ReviewInitial();
  Stopwatch? _answerStopwatch;
  int? _frozenVisibleTimerMilliseconds;
  ReviewTimerHandle? _autoAdvanceTimer;
  _DeferredAutoAdvance? _deferredAutoAdvance;
  bool _autoAdvanceEnabled = false;
  String? _autoAdvanceReminder;
  bool _currentMarked = false;
  int _generation = 0;
  int? _selectedDeckId;
  String? _typedAnswerPattern;
  ReviewTypedAnswerPrompt? _typedAnswerPrompt;
  String _typedAnswerProvided = '';
  String? _typedAnswerComparisonHtml;
  bool _showAnswerInProgress = false;

  ReviewSessionState get state => _state;
  bool get autoAdvanceEnabled => _autoAdvanceEnabled;
  String? get autoAdvanceReminder => _autoAdvanceReminder;
  bool get isAudioPlaying => _audio?.isPlaying ?? false;
  bool get supportsFlags => _repository is ReviewFlagRepository;
  bool get supportsMarking => _repository is ReviewMarkRepository;
  bool get supportsDeleteNote => _repository is ReviewDeleteNoteRepository;
  bool get supportsForgetCard => _repository is ReviewForgetCardRepository;
  bool get supportsSetDueDate => _repository is ReviewSetDueDateRepository;
  bool get currentMarked => _currentMarked;
  ReviewTypedAnswerPrompt? get typedAnswerPrompt => _typedAnswerPrompt;
  bool get hasTypedAnswerInput {
    if (_state is! ReviewQuestion || _typedAnswerPattern == null) return false;
    if (_repository is ReviewTypedAnswerRepository) {
      return _typedAnswerPrompt != null;
    }
    return true;
  }

  int get currentFlag => switch (_state) {
    ReviewQuestion(:final card) => card.flag,
    ReviewAnswer(:final card) => card.flag,
    ReviewTransition(:final card) => card.flag,
    _ => 0,
  };

  Duration get reviewTimerElapsed {
    final current = _state;
    final ReviewDeckSettings? settings = switch (current) {
      ReviewQuestion(:final settings) => settings,
      ReviewAnswer(:final settings) => settings,
      ReviewTransition(:final settings) => settings,
      _ => null,
    };
    if (settings == null) return Duration.zero;

    final elapsed = switch (current) {
      ReviewAnswer() when settings.stopTimerOnAnswer =>
        _frozenVisibleTimerMilliseconds ??
            (_answerStopwatch?.elapsedMilliseconds ?? 0),
      ReviewTransition() =>
        _frozenVisibleTimerMilliseconds ??
            (_answerStopwatch?.elapsedMilliseconds ?? 0),
      _ => _answerStopwatch?.elapsedMilliseconds ?? 0,
    };
    return Duration(
      milliseconds: _capElapsedMilliseconds(
        elapsed,
        settings.answerTimeLimitSeconds,
      ),
    );
  }

  bool get hasReplayableAudio {
    if (_audio == null) return false;
    return _replayTagsForCurrentState().any((tag) => switch (tag) {
      ReviewMediaTag() => _mediaUriFor != null,
      ReviewTtsTag() => _tts != null,
    });
  }

  @override
  void dispose() {
    _generation++;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    unawaited(_playingSubscription?.cancel());
    unawaited(_audio?.dispose());
    unawaited(_tts?.dispose());
    super.dispose();
  }

  Future<void> start(int deckId) async {
    _selectedDeckId = deckId;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    _frozenVisibleTimerMilliseconds = null;
    _autoAdvanceReminder = null;
    _currentMarked = false;
    _resetTypedAnswer();
    final generationId = ++_generation;
    _setState(const ReviewLoading());

    try {
      await _repository.selectDeck(deckId);
      if (!_isCurrentGeneration(generationId)) return;
      await _loadNextCard(generationId);
    } catch (error) {
      if (_isCurrentGeneration(generationId)) {
        _setState(ReviewFailure(error));
      }
    }
  }

  Future<void> retry() async {
    final deckId = _selectedDeckId;
    if (deckId != null) await start(deckId);
  }

  void updateTypedAnswer(String value) {
    _typedAnswerProvided = value;
  }

  Future<void> showAnswer() async {
    final current = _state;
    if (current is! ReviewQuestion || _showAnswerInProgress) {
      return;
    }

    _showAnswerInProgress = true;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    _autoAdvanceReminder = null;
    if (current.settings.stopTimerOnAnswer) {
      _frozenVisibleTimerMilliseconds =
          _answerStopwatch?.elapsedMilliseconds ?? 0;
    }

    try {
      var comparison = '';
      final prompt = _typedAnswerPrompt;
      final repository = _repository;
      if (_typedAnswerPattern != null &&
          prompt != null &&
          repository is ReviewTypedAnswerRepository) {
        final compared = await repository.compareTypedAnswer(
          expected: prompt.expected,
          provided: _typedAnswerProvided,
          combining: prompt.combining,
        );
        if (!_isCurrentQuestion(current)) return;
        comparison =
            '<div style="font-family: \'${prompt.fontName}\'; font-size: ${prompt.fontSize}px">$compared</div>';
      }
      _typedAnswerComparisonHtml = comparison;

      final answerContent = _contentWith(
        current.content,
        answerHtml: current.content.answerHtml.replaceAll(
          _typedAnswerMarker,
          comparison,
        ),
      );
      _setState(
        ReviewAnswer(
          card: current.card,
          content: answerContent,
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
    } finally {
      _showAnswerInProgress = false;
    }
  }

  Future<void> refreshCurrentCard() async {
    final current = _state;
    final ReviewCard card;
    final int generationId;
    final bool answerSide;
    final ReviewDeckSettings settings;
    final Object? answerError;
    if (current is ReviewQuestion) {
      card = current.card;
      generationId = current.generationId;
      answerSide = false;
      settings = current.settings;
      answerError = null;
    } else if (current is ReviewAnswer) {
      card = current.card;
      generationId = current.generationId;
      answerSide = true;
      settings = current.settings;
      answerError = current.error;
    } else {
      return;
    }

    final rawContent = await _renderer.render(card.cardId);
    if (!_isCurrentGeneration(generationId)) return;
    ReviewCardContent content;
    if (answerSide) {
      content = _contentWith(
        rawContent,
        questionHtml: rawContent.questionHtml.replaceAll(_typedAnswerMarker, ''),
        answerHtml: rawContent.answerHtml.replaceAll(
          _typedAnswerMarker,
          _typedAnswerComparisonHtml ?? '',
        ),
      );
    } else {
      final prepared = await _prepareQuestionContent(
        card,
        rawContent,
        generationId,
      );
      if (prepared == null) return;
      content = prepared;
    }

    var marked = _currentMarked;
    if (_repository case final ReviewMarkRepository repository) {
      marked = await repository.isMarked(card);
      if (!_isCurrentGeneration(generationId)) return;
    }

    final latest = _state;
    final stillSameCard = switch (latest) {
      ReviewQuestion(
        card: final latestCard,
        generationId: final latestGeneration,
      ) when !answerSide =>
        latestCard.cardId == card.cardId && latestGeneration == generationId,
      ReviewAnswer(
        card: final latestCard,
        generationId: final latestGeneration,
      ) when answerSide =>
        latestCard.cardId == card.cardId && latestGeneration == generationId,
      _ => false,
    };
    if (!stillSameCard) return;

    _currentMarked = marked;
    if (answerSide) {
      _setState(
        ReviewAnswer(
          card: card,
          content: content,
          settings: settings,
          generationId: generationId,
          error: answerError,
        ),
      );
    } else {
      _setState(
        ReviewQuestion(
          card: card,
          content: content,
          settings: settings,
          generationId: generationId,
        ),
      );
    }
  }

  Future<void> rate(ReviewRating rating) async {
    final current = _state;
    if (current is! ReviewAnswer ||
        !_isCurrentGeneration(current.generationId)) {
      return;
    }

    _autoAdvanceReminder = null;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    final generationId = current.generationId;
    final rawMillisecondsTaken = _answerStopwatch?.elapsedMilliseconds ?? 0;
    _frozenVisibleTimerMilliseconds ??= rawMillisecondsTaken;
    _setState(
      ReviewTransition(
        card: current.card,
        content: current.content,
        settings: current.settings,
        generationId: generationId,
      ),
    );

    final answeredAtMillis = _wallClockMillis();
    final millisecondsTaken = _capElapsedMilliseconds(
      rawMillisecondsTaken,
      current.settings.answerTimeLimitSeconds,
    );

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

  Future<bool> canUndo() => _repository.canUndo();

  Future<void> undo() async {
    _autoAdvanceReminder = null;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    await _repository.undo();
    await _loadNextCard(++_generation);
  }

  Future<void> buryCurrentCard() => _runCurrentCardAction(_repository.buryCard);

  Future<void> buryCurrentNote() => _runCurrentCardAction(_repository.buryNote);

  Future<void> suspendCurrentCard() =>
      _runCurrentCardAction(_repository.suspendCard);

  Future<void> suspendCurrentNote() =>
      _runCurrentCardAction(_repository.suspendNote);

  Future<void> deleteCurrentNote() {
    if (_repository case final ReviewDeleteNoteRepository repository) {
      return _runCurrentCardAction(repository.deleteNote);
    }
    return Future<void>.value();
  }

  Future<ReviewForgetCardOptions> forgetCurrentCardDefaults() {
    if (_repository case final ReviewForgetCardRepository repository) {
      return repository.forgetCardDefaults();
    }
    return Future<ReviewForgetCardOptions>.error(
      UnsupportedError('Forget card is not supported by this repository'),
    );
  }

  Future<void> forgetCurrentCard(ReviewForgetCardOptions options) {
    if (_repository case final ReviewForgetCardRepository repository) {
      return _runCurrentCardAction((card) => repository.forgetCard(card, options));
    }
    return Future<void>.value();
  }

  Future<String> currentCardDueDateDefault() {
    if (_repository case final ReviewSetDueDateRepository repository) {
      return repository.dueDateDefault();
    }
    return Future<String>.error(
      UnsupportedError('Set due date is not supported by this repository'),
    );
  }

  Future<void> setCurrentCardDueDate(String days) {
    if (_repository case final ReviewSetDueDateRepository repository) {
      return _runCurrentCardAction((card) => repository.setDueDate(card, days));
    }
    return Future<void>.value();
  }

  Future<void> setCurrentFlag(int flag) async {
    if (flag < 0 || flag > 7) {
      throw ArgumentError.value(flag, 'flag', 'must be between 0 and 7');
    }
    final ReviewFlagRepository flagRepository;
    if (_repository case final ReviewFlagRepository repository) {
      flagRepository = repository;
    } else {
      return;
    }

    final current = _state;
    final ReviewCard card;
    final int generationId;
    final bool answerSide;
    final ReviewCardContent content;
    final ReviewDeckSettings settings;
    final Object? answerError;
    if (current is ReviewQuestion) {
      card = current.card;
      generationId = current.generationId;
      answerSide = false;
      content = current.content;
      settings = current.settings;
      answerError = null;
    } else if (current is ReviewAnswer) {
      card = current.card;
      generationId = current.generationId;
      answerSide = true;
      content = current.content;
      settings = current.settings;
      answerError = current.error;
    } else {
      return;
    }

    await flagRepository.setFlag(card, flag);
    if (!_isCurrentGeneration(generationId)) return;
    final latest = _state;
    final stillSameCard = switch (latest) {
      ReviewQuestion(
        card: final latestCard,
        generationId: final latestGeneration,
      ) when !answerSide =>
        latestCard.cardId == card.cardId && latestGeneration == generationId,
      ReviewAnswer(
        card: final latestCard,
        generationId: final latestGeneration,
      ) when answerSide =>
        latestCard.cardId == card.cardId && latestGeneration == generationId,
      _ => false,
    };
    if (!stillSameCard) return;

    final updatedCard = card.withFlag(flag);
    if (answerSide) {
      _setState(
        ReviewAnswer(
          card: updatedCard,
          content: content,
          settings: settings,
          generationId: generationId,
          error: answerError,
        ),
      );
    } else {
      _setState(
        ReviewQuestion(
          card: updatedCard,
          content: content,
          settings: settings,
          generationId: generationId,
        ),
      );
    }
  }

  Future<void> toggleCurrentMarked() async {
    final ReviewMarkRepository markRepository;
    if (_repository case final ReviewMarkRepository repository) {
      markRepository = repository;
    } else {
      return;
    }

    final current = _state;
    final ReviewCard card;
    final int generationId;
    if (current is ReviewQuestion) {
      card = current.card;
      generationId = current.generationId;
    } else if (current is ReviewAnswer) {
      card = current.card;
      generationId = current.generationId;
    } else {
      return;
    }
    if (!_isCurrentGeneration(generationId)) return;

    final marked = !_currentMarked;
    await markRepository.setMarked(card, marked);
    if (!_isCurrentGeneration(generationId)) return;
    final latest = _state;
    final stillSameCard = switch (latest) {
      ReviewQuestion(
        card: final latestCard,
        generationId: final latestGeneration,
      ) => latestCard.cardId == card.cardId && latestGeneration == generationId,
      ReviewAnswer(
        card: final latestCard,
        generationId: final latestGeneration,
      ) => latestCard.cardId == card.cardId && latestGeneration == generationId,
      _ => false,
    };
    if (!stillSameCard) return;

    _currentMarked = marked;
    notifyListeners();
  }

  Future<void> _runCurrentCardAction(
    Future<void> Function(ReviewCard card) action,
  ) async {
    final current = _state;
    final ReviewCard card;
    final int generationId;
    if (current is ReviewQuestion) {
      card = current.card;
      generationId = current.generationId;
    } else if (current is ReviewAnswer) {
      card = current.card;
      generationId = current.generationId;
    } else {
      return;
    }
    if (!_isCurrentGeneration(generationId)) return;

    _autoAdvanceReminder = null;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    try {
      await action(card);
    } catch (_) {
      if (_isCurrentGeneration(generationId)) {
        _scheduleAutoAdvanceForCurrentState();
      }
      rethrow;
    }
    if (!_isCurrentGeneration(generationId)) return;
    await _loadNextCard(++_generation);
  }

  Future<void> replayAudio() async {
    final generationId = _currentGenerationId();
    if (generationId == null || _audio == null) return;
    await _playTags(_replayTagsForCurrentState(), generationId);
  }

  Future<void> toggleAudioPause() async {
    await _audio?.togglePause();
  }

  Future<void> seekAudio(Duration delta) async {
    await _audio?.seekRelative(delta);
  }

  List<ReviewAudioTag> _replayTagsForCurrentState() {
    final current = _state;
    if (current is ReviewQuestion) {
      return current.content.questionAudio;
    }
    if (current is ReviewAnswer) {
      if (current.settings.skipQuestionWhenReplayingAnswer) {
        return current.content.answerAudio;
      }
      return <ReviewAudioTag>[
        ...current.content.questionAudio,
        ...current.content.answerAudio,
      ];
    }
    return const [];
  }

  int? _currentGenerationId() => switch (_state) {
    ReviewQuestion(:final generationId) => generationId,
    ReviewAnswer(:final generationId) => generationId,
    _ => null,
  };

  Future<void> toggleAutoAdvance() async {
    _autoAdvanceEnabled = !_autoAdvanceEnabled;
    _autoAdvanceReminder = null;
    _clearAutoAdvanceTimer();
    _deferredAutoAdvance = null;
    if (_autoAdvanceEnabled) {
      _scheduleAutoAdvanceForCurrentState();
    }
    notifyListeners();
  }

  Future<void> _loadNextCard(int generationId) async {
    try {
      final card = await _repository.nextCard();
      if (!_isCurrentGeneration(generationId)) {
        return;
      }

      if (card == null) {
        _clearAutoAdvanceTimer();
        _deferredAutoAdvance = null;
        _answerStopwatch = null;
        _frozenVisibleTimerMilliseconds = null;
        _autoAdvanceReminder = null;
        _currentMarked = false;
        _resetTypedAnswer();
        _setState(const ReviewFinished());
        return;
      }

      var marked = false;
      if (_repository case final ReviewMarkRepository repository) {
        marked = await repository.isMarked(card);
        if (!_isCurrentGeneration(generationId)) return;
      }

      final settings = await _repository.settingsForDeck(card.currentDeckId);
      if (!_isCurrentGeneration(generationId)) {
        return;
      }

      final rawContent = await _renderer.render(card.cardId);
      if (!_isCurrentGeneration(generationId)) {
        return;
      }
      final content = await _prepareQuestionContent(
        card,
        rawContent,
        generationId,
      );
      if (content == null || !_isCurrentGeneration(generationId)) {
        return;
      }

      final stopwatch = _stopwatchFactory()..start();
      _answerStopwatch = stopwatch;
      _frozenVisibleTimerMilliseconds = null;
      _autoAdvanceReminder = null;
      _currentMarked = marked;

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
    } catch (error) {
      if (_isCurrentGeneration(generationId)) _setState(ReviewFailure(error));
    }
  }

  Future<ReviewCardContent?> _prepareQuestionContent(
    ReviewCard card,
    ReviewCardContent rawContent,
    int generationId,
  ) async {
    _resetTypedAnswer();
    final match = _typedAnswerMarker.firstMatch(rawContent.questionHtml);
    if (match == null) return rawContent;

    final pattern = match.group(1);
    if (pattern == null || pattern.isEmpty) {
      return _contentWith(
        rawContent,
        questionHtml: rawContent.questionHtml.replaceAll(_typedAnswerMarker, ''),
      );
    }

    var replacement = '';
    final repository = _repository;
    if (repository is ReviewTypedAnswerRepository) {
      final preparation = await repository.prepareTypedAnswer(card, pattern);
      if (!_isCurrentGeneration(generationId)) return null;
      switch (preparation) {
        case ReviewTypedAnswerReady(:final prompt):
          _typedAnswerPattern = pattern;
          _typedAnswerPrompt = prompt;
        case ReviewTypedAnswerWarning(:final message):
          replacement = message;
        case ReviewTypedAnswerEmpty():
          break;
      }
    } else {
      _typedAnswerPattern = pattern;
    }

    return _contentWith(
      rawContent,
      questionHtml: rawContent.questionHtml.replaceAll(
        _typedAnswerMarker,
        replacement,
      ),
    );
  }

  ReviewCardContent _contentWith(
    ReviewCardContent content, {
    String? questionHtml,
    String? answerHtml,
  }) {
    return ReviewCardContent(
      questionHtml: questionHtml ?? content.questionHtml,
      answerHtml: answerHtml ?? content.answerHtml,
      css: content.css,
      questionAudio: content.questionAudio,
      answerAudio: content.answerAudio,
    );
  }

  void _resetTypedAnswer() {
    _typedAnswerPattern = null;
    _typedAnswerPrompt = null;
    _typedAnswerProvided = '';
    _typedAnswerComparisonHtml = null;
  }

  bool _isCurrentQuestion(ReviewQuestion original) {
    if (!_isCurrentGeneration(original.generationId)) return false;
    final current = _state;
    return current is ReviewQuestion &&
        current.generationId == original.generationId &&
        current.card.cardId == original.card.cardId;
  }

  int _capElapsedMilliseconds(int elapsed, int limitSeconds) {
    if (limitSeconds <= 0) return elapsed;
    final limitMilliseconds = limitSeconds * 1000;
    return elapsed > limitMilliseconds ? limitMilliseconds : elapsed;
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
      } else {
        _showAutoAdvanceReminder('Question time elapsed');
      }
      return;
    }

    switch (settings.answerAction) {
      case ReviewAnswerAction.buryCard:
        await buryCurrentCard();
        break;
      case ReviewAnswerAction.answerAgain:
        await rate(ReviewRating.again);
        break;
      case ReviewAnswerAction.answerGood:
        await rate(ReviewRating.good);
        break;
      case ReviewAnswerAction.answerHard:
        await rate(ReviewRating.hard);
        break;
      case ReviewAnswerAction.showReminder:
        _showAutoAdvanceReminder('Answer time elapsed');
        break;
    }
  }

  void _showAutoAdvanceReminder(String message) {
    _autoAdvanceReminder = message;
    notifyListeners();
  }

  void _onPlayingChanged(bool isPlaying) {
    if (!isPlaying) {
      final deferred = _deferredAutoAdvance;
      if (deferred != null) {
        _deferredAutoAdvance = null;
        unawaited(_onAutoAdvanceTimeout(deferred.side, deferred.generationId));
      }
    }
    notifyListeners();
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
  _DartReviewTimerHandle(Duration delay, Future<void> Function() callback)
    : _timer = Timer(delay, () => unawaited(callback()));

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
