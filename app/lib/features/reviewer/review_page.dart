import 'dart:async';

import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/surface/card_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum _ReviewAction {
  undo,
  buryCard,
  buryNote,
  suspendCard,
  suspendNote,
  replayAudio,
  toggleAudioPause,
  seekAudioBack,
  seekAudioForward,
  autoAdvance,
}

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    required this.controller,
    required this.onFinished,
    this.cardSurfaceBuilder,
    this.mediaBaseUri,
    super.key,
  });

  final ReviewController controller;
  final VoidCallback onFinished;
  final Widget Function(BuildContext context, String html)? cardSurfaceBuilder;
  final Uri? mediaBaseUri;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool _finishedNotified = false;
  bool _manualActionInProgress = false;

  void _defaultShortcut() {
    final state = widget.controller.state;
    if (state is ReviewQuestion) {
      unawaited(widget.controller.showAnswer());
    } else if (state is ReviewAnswer) {
      unawaited(widget.controller.rate(ReviewRating.good));
    }
  }

  void _rateShortcut(ReviewRating rating) {
    if (widget.controller.state is ReviewAnswer) {
      unawaited(widget.controller.rate(rating));
    }
  }

  void _actionShortcut(_ReviewAction action) {
    unawaited(_runReviewAction(action));
  }

  Map<ShortcutActivator, VoidCallback> get _shortcuts => {
    const SingleActivator(LogicalKeyboardKey.space): _defaultShortcut,
    const SingleActivator(LogicalKeyboardKey.enter): _defaultShortcut,
    const SingleActivator(LogicalKeyboardKey.numpadEnter): _defaultShortcut,
    const SingleActivator(LogicalKeyboardKey.digit1): () =>
        _rateShortcut(ReviewRating.again),
    const SingleActivator(LogicalKeyboardKey.digit2): () =>
        _rateShortcut(ReviewRating.hard),
    const SingleActivator(LogicalKeyboardKey.digit3): () =>
        _rateShortcut(ReviewRating.good),
    const SingleActivator(LogicalKeyboardKey.digit4): () =>
        _rateShortcut(ReviewRating.easy),
    const SingleActivator(LogicalKeyboardKey.numpad1): () =>
        _rateShortcut(ReviewRating.again),
    const SingleActivator(LogicalKeyboardKey.numpad2): () =>
        _rateShortcut(ReviewRating.hard),
    const SingleActivator(LogicalKeyboardKey.numpad3): () =>
        _rateShortcut(ReviewRating.good),
    const SingleActivator(LogicalKeyboardKey.numpad4): () =>
        _rateShortcut(ReviewRating.easy),
    const SingleActivator(LogicalKeyboardKey.keyR): () =>
        _actionShortcut(_ReviewAction.replayAudio),
    const SingleActivator(LogicalKeyboardKey.f5): () =>
        _actionShortcut(_ReviewAction.replayAudio),
    const SingleActivator(LogicalKeyboardKey.digit5): () =>
        _actionShortcut(_ReviewAction.toggleAudioPause),
    const SingleActivator(LogicalKeyboardKey.digit6): () =>
        _actionShortcut(_ReviewAction.seekAudioBack),
    const SingleActivator(LogicalKeyboardKey.digit7): () =>
        _actionShortcut(_ReviewAction.seekAudioForward),
    const SingleActivator(LogicalKeyboardKey.keyA, shift: true): () =>
        _actionShortcut(_ReviewAction.autoAdvance),
    const SingleActivator(LogicalKeyboardKey.keyU): () =>
        _actionShortcut(_ReviewAction.undo),
    const SingleActivator(LogicalKeyboardKey.minus): () =>
        _actionShortcut(_ReviewAction.buryCard),
    const SingleActivator(LogicalKeyboardKey.equal): () =>
        _actionShortcut(_ReviewAction.buryNote),
    const SingleActivator(LogicalKeyboardKey.digit1, shift: true): () =>
        _actionShortcut(_ReviewAction.suspendNote),
    const SingleActivator(LogicalKeyboardKey.digit2, shift: true): () =>
        _actionShortcut(_ReviewAction.suspendCard),
  };

  Future<void> _runReviewAction(_ReviewAction action) async {
    if (_manualActionInProgress) return;
    setState(() => _manualActionInProgress = true);
    try {
      switch (action) {
        case _ReviewAction.undo:
          if (!await widget.controller.canUndo()) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nothing to undo.')),
              );
            }
            return;
          }
          await widget.controller.undo();
          break;
        case _ReviewAction.buryCard:
          await widget.controller.buryCurrentCard();
          break;
        case _ReviewAction.buryNote:
          await widget.controller.buryCurrentNote();
          break;
        case _ReviewAction.suspendCard:
          await widget.controller.suspendCurrentCard();
          break;
        case _ReviewAction.suspendNote:
          await widget.controller.suspendCurrentNote();
          break;
        case _ReviewAction.replayAudio:
          await widget.controller.replayAudio();
          break;
        case _ReviewAction.toggleAudioPause:
          await widget.controller.toggleAudioPause();
          break;
        case _ReviewAction.seekAudioBack:
          await widget.controller.seekAudio(const Duration(seconds: -5));
          break;
        case _ReviewAction.seekAudioForward:
          await widget.controller.seekAudio(const Duration(seconds: 5));
          break;
        case _ReviewAction.autoAdvance:
          await widget.controller.toggleAutoAdvance();
          break;
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not apply review action: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _manualActionInProgress = false);
    }
  }

  List<PopupMenuEntry<_ReviewAction>> _reviewActionItems() => [
    const PopupMenuItem(
      value: _ReviewAction.undo,
      child: ListTile(
        dense: true,
        leading: Icon(Icons.undo),
        title: Text('Undo'),
      ),
    ),
    const PopupMenuDivider(),
    const PopupMenuItem(
      value: _ReviewAction.buryCard,
      child: ListTile(
        dense: true,
        leading: Icon(Icons.visibility_off_outlined),
        title: Text('Bury card'),
      ),
    ),
    const PopupMenuItem(
      value: _ReviewAction.buryNote,
      child: ListTile(
        dense: true,
        leading: Icon(Icons.layers_clear_outlined),
        title: Text('Bury note'),
      ),
    ),
    const PopupMenuItem(
      value: _ReviewAction.suspendCard,
      child: ListTile(
        dense: true,
        leading: Icon(Icons.pause_circle_outline),
        title: Text('Suspend card'),
      ),
    ),
    const PopupMenuItem(
      value: _ReviewAction.suspendNote,
      child: ListTile(
        dense: true,
        leading: Icon(Icons.pause_circle_filled_outlined),
        title: Text('Suspend note'),
      ),
    ),
    if (widget.controller.hasReplayableAudio) ...[
      const PopupMenuDivider(),
      const PopupMenuItem(
        value: _ReviewAction.replayAudio,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.replay),
          title: Text('Replay audio'),
        ),
      ),
      const PopupMenuItem(
        value: _ReviewAction.toggleAudioPause,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.play_circle_outline),
          title: Text('Play / pause audio'),
        ),
      ),
      const PopupMenuItem(
        value: _ReviewAction.seekAudioBack,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.fast_rewind),
          title: Text('Back 5 seconds'),
        ),
      ),
      const PopupMenuItem(
        value: _ReviewAction.seekAudioForward,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.fast_forward),
          title: Text('Forward 5 seconds'),
        ),
      ),
    ],
    const PopupMenuDivider(),
    CheckedPopupMenuItem(
      value: _ReviewAction.autoAdvance,
      checked: widget.controller.autoAdvanceEnabled,
      child: const Text('Auto advance'),
    ),
  ];

  @override
  Widget build(BuildContext context) => CallbackShortcuts(
    bindings: _shortcuts,
    child: Focus(
      autofocus: true,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final state = widget.controller.state;
          if (state is ReviewFinished) {
            if (!_finishedNotified) {
              _finishedNotified = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) widget.onFinished();
              });
            }
            return const Scaffold(
              body: Center(child: Text('You have finished this deck for now.')),
            );
          }
          if (state is ReviewLoading || state is ReviewInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state case ReviewFailure(:final error)) {
            return Scaffold(
              appBar: AppBar(title: const Text('Reviewer')),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Could not load card: $error'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => unawaited(widget.controller.retry()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is ReviewQuestion ||
              state is ReviewAnswer ||
              state is ReviewTransition) {
            final isAnswer = state is ReviewAnswer || state is ReviewTransition;
            final card = switch (state) {
              ReviewQuestion(:final card) => card,
              ReviewAnswer(:final card) => card,
              ReviewTransition(:final card) => card,
              _ => throw StateError('Unexpected reviewer state'),
            };
            final content = switch (state) {
              ReviewQuestion(:final content) => content,
              ReviewAnswer(:final content) => content,
              ReviewTransition(:final content) => content,
              _ => throw StateError('Unexpected reviewer state'),
            };
            final settings = switch (state) {
              ReviewQuestion(:final settings) => settings,
              ReviewAnswer(:final settings) => settings,
              ReviewTransition(:final settings) => settings,
              _ => throw StateError('Unexpected reviewer state'),
            };
            final error = state is ReviewAnswer ? state.error : null;
            final reminder = widget.controller.autoAdvanceReminder;
            return Scaffold(
              appBar: AppBar(
                title: Text(card.deckName),
                actions: [
                  if (settings.showTimer) ...[
                    Center(child: _ReviewTimer(controller: widget.controller)),
                    const SizedBox(width: 12),
                  ],
                  Center(
                    child: Semantics(
                      label:
                          '${card.counts.newCount} new, '
                          '${card.counts.learningCount} learning, '
                          '${card.counts.reviewCount} review cards remaining',
                      excludeSemantics: true,
                      child: Text(
                        'New ${card.counts.newCount}  Learn ${card.counts.learningCount}  Review ${card.counts.reviewCount}',
                      ),
                    ),
                  ),
                  PopupMenuButton<_ReviewAction>(
                    tooltip: 'Review actions',
                    enabled: !_manualActionInProgress &&
                        state is! ReviewTransition,
                    onSelected: (action) => unawaited(_runReviewAction(action)),
                    itemBuilder: (_) => _reviewActionItems(),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: CardSurface(
                        content: content,
                        showAnswer: isAnswer,
                        mediaBaseUri: widget.mediaBaseUri,
                        builder: widget.cardSurfaceBuilder,
                      ),
                    ),
                    if (reminder != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Text(
                          reminder,
                          key: const ValueKey('auto-advance-reminder'),
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (error != null) Text('Could not answer card: $error'),
                    if (!isAnswer)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Semantics(
                          label:
                              'Show answer, keyboard shortcut Space or Enter',
                          button: true,
                          excludeSemantics: true,
                          child: FilledButton(
                            onPressed: _manualActionInProgress
                                ? null
                                : () => unawaited(
                                    widget.controller.showAnswer(),
                                  ),
                            child: const Text('Show Answer'),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          children: [
                            for (final rating in ReviewRating.values)
                              Semantics(
                                label: _ratingSemantics(
                                  rating,
                                  card.choices
                                      .firstWhere(
                                        (choice) => choice.rating == rating,
                                      )
                                      .intervalLabel,
                                ),
                                button: true,
                                excludeSemantics: true,
                                child: FilledButton.tonal(
                                  onPressed: state is ReviewTransition ||
                                          _manualActionInProgress
                                      ? null
                                      : () => unawaited(
                                          widget.controller.rate(rating),
                                        ),
                                  child: Text(
                                    _label(
                                      rating,
                                      card.choices
                                          .firstWhere(
                                            (choice) => choice.rating == rating,
                                          )
                                          .intervalLabel,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: Text('Reviewer unavailable')),
          );
        },
      ),
    ),
  );

  String _ratingName(ReviewRating rating) => switch (rating) {
    ReviewRating.again => 'Again',
    ReviewRating.hard => 'Hard',
    ReviewRating.good => 'Good',
    ReviewRating.easy => 'Easy',
  };

  int _ratingShortcut(ReviewRating rating) => switch (rating) {
    ReviewRating.again => 1,
    ReviewRating.hard => 2,
    ReviewRating.good => 3,
    ReviewRating.easy => 4,
  };

  String _ratingSemantics(ReviewRating rating, String interval) =>
      '${_ratingName(rating)}, next interval $interval, keyboard shortcut ${_ratingShortcut(rating)}';

  String _label(ReviewRating rating, String interval) =>
      '${_ratingName(rating)}\n$interval';
}

class _ReviewTimer extends StatefulWidget {
  const _ReviewTimer({required this.controller});

  final ReviewController controller;

  @override
  State<_ReviewTimer> createState() => _ReviewTimerState();
}

class _ReviewTimerState extends State<_ReviewTimer> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = widget.controller.reviewTimerElapsed;
    final totalSeconds = elapsed.inSeconds;
    final minutes = totalSeconds ~/ 60;
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    final label = '$minutes:$seconds';
    return Semantics(
      label: 'Review time $label',
      excludeSemantics: true,
      child: Text(label, key: const ValueKey('review-timer')),
    );
  }
}
