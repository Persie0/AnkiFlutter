import 'dart:async';

import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';

final class ReviewSecondarySurfaceToken {
  const ReviewSecondarySurfaceToken({
    required this.generationId,
    required this.cardId,
    required this.restoreAutoAdvance,
  });

  final int generationId;
  final int cardId;
  final bool restoreAutoAdvance;
}

final Expando<_ReviewCardInfoTracker> _cardInfoTrackers =
    Expando<_ReviewCardInfoTracker>('review-card-info-tracker');

extension ReviewCardInfoLifecycle on ReviewController {
  void enableCardInfoLifecycleTracking() {
    _tracker;
  }

  int? get currentCardId {
    _tracker;
    return _visibleCardId(state);
  }

  int? get previousCardId => _tracker.previousCardId;

  ReviewSecondarySurfaceToken? pauseForSecondarySurface() {
    final generationId = _visibleGenerationId(state);
    final cardId = currentCardId;
    if (generationId == null || cardId == null) return null;

    final restoreAutoAdvance = autoAdvanceEnabled;
    if (restoreAutoAdvance) {
      unawaited(toggleAutoAdvance());
    }
    return ReviewSecondarySurfaceToken(
      generationId: generationId,
      cardId: cardId,
      restoreAutoAdvance: restoreAutoAdvance,
    );
  }

  void resumeAfterSecondarySurface(ReviewSecondarySurfaceToken token) {
    if (!token.restoreAutoAdvance || autoAdvanceEnabled) return;
    if (_visibleGenerationId(state) != token.generationId ||
        currentCardId != token.cardId) {
      return;
    }
    unawaited(toggleAutoAdvance());
  }

  _ReviewCardInfoTracker get _tracker =>
      _cardInfoTrackers[this] ??= _ReviewCardInfoTracker(this);
}

final class _ReviewCardInfoTracker {
  _ReviewCardInfoTracker(this.controller) {
    _capture(controller.state, initial: true);
    controller.addListener(_onControllerChanged);
  }

  final ReviewController controller;
  int? previousCardId;
  int? _lastVisibleCardId;

  void _onControllerChanged() => _capture(controller.state);

  void _capture(ReviewSessionState state, {bool initial = false}) {
    if (state is ReviewLoading) {
      previousCardId = null;
      _lastVisibleCardId = null;
      return;
    }

    final cardId = _visibleCardId(state);
    if (cardId == null) return;
    if (_lastVisibleCardId == null) {
      _lastVisibleCardId = cardId;
      return;
    }
    if (_lastVisibleCardId != cardId) {
      previousCardId = _lastVisibleCardId;
      _lastVisibleCardId = cardId;
    } else if (initial) {
      _lastVisibleCardId = cardId;
    }
  }
}

int? _visibleCardId(ReviewSessionState state) => switch (state) {
  ReviewQuestion(:final card) => card.cardId,
  ReviewAnswer(:final card) => card.cardId,
  _ => null,
};

int? _visibleGenerationId(ReviewSessionState state) => switch (state) {
  ReviewQuestion(:final generationId) => generationId,
  ReviewAnswer(:final generationId) => generationId,
  _ => null,
};
