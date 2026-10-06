import 'dart:async';

import 'package:anki_flutter/features/card_info/card_info_page.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/review_card_info_lifecycle.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/surface/card_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ReviewNoteEditor = Future<bool> Function(int noteId);
typedef ReviewCreateCopyOpener = Future<void> Function(
  ReviewCreateCopyTarget target,
);
typedef ReviewDeckOptionsOpener = Future<void> Function(
  ReviewDeckOptionsTarget target,
);
typedef ReviewCardInfoOpener = Future<void> Function(ReviewCardInfoTarget target);

final class ReviewCreateCopyTarget {
  const ReviewCreateCopyTarget({
    required this.noteId,
    required this.deckId,
    required this.deckName,
  });

  final int noteId;
  final int deckId;
  final String deckName;
}

final class ReviewDeckOptionsTarget {
  const ReviewDeckOptionsTarget({
    required this.deckId,
    required this.filtered,
  });

  final int deckId;
  final bool filtered;
}

final class ReviewCardInfoTarget {
  const ReviewCardInfoTarget({required this.kind, required this.cardId});

  final CardInfoKind kind;
  final int? cardId;
}

enum _ReviewAction {
  editNote,
  createCopy,
  setFlag,
  toggleMark,
  forgetCard,
  setDueDate,
  options,
  cardInfo,
  previousCardInfo,
  deleteNote,
  undo,
  buryCard,
  buryNote,
  suspendCard,
  suspendNote,
  recordOwnVoice,
  replayOwnVoice,
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
    this.onEditNote,
    this.onCreateCopy,
    this.studyDeckId,
    this.onOpenDeckOptions,
    this.onOpenCardInfo,
    super.key,
  });

  final ReviewController controller;
  final VoidCallback onFinished;
  final Widget Function(BuildContext context, String html)? cardSurfaceBuilder;
  final Uri? mediaBaseUri;
  final ReviewNoteEditor? onEditNote;
  final ReviewCreateCopyOpener? onCreateCopy;
  final int? studyDeckId;
  final ReviewDeckOptionsOpener? onOpenDeckOptions;
  final ReviewCardInfoOpener? onOpenCardInfo;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final FocusNode _typedAnswerFocusNode = FocusNode();
  bool _finishedNotified = false;
  bool _manualActionInProgress = false;

  @override
  void initState() {
    super.initState();
    widget.controller.enableCardInfoLifecycleTracking();
    _typedAnswerFocusNode.addListener(_onTypedAnswerFocusChanged);
  }

  void _onTypedAnswerFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _typedAnswerFocusNode.removeListener(_onTypedAnswerFocusChanged);
    _typedAnswerFocusNode.dispose();
    super.dispose();
  }

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

  void _flagShortcut(int flag) {
    unawaited(_setFlag(flag));
  }

  Map<ShortcutActivator, VoidCallback> get _shortcuts {
    if (_typedAnswerFocusNode.hasFocus) {
      return const {};
    }
    return {
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
      const SingleActivator(LogicalKeyboardKey.digit1, control: true): () =>
          _flagShortcut(1),
      const SingleActivator(LogicalKeyboardKey.digit2, control: true): () =>
          _flagShortcut(2),
      const SingleActivator(LogicalKeyboardKey.digit3, control: true): () =>
          _flagShortcut(3),
      const SingleActivator(LogicalKeyboardKey.digit4, control: true): () =>
          _flagShortcut(4),
      const SingleActivator(LogicalKeyboardKey.digit5, control: true): () =>
          _flagShortcut(5),
      const SingleActivator(LogicalKeyboardKey.digit6, control: true): () =>
          _flagShortcut(6),
      const SingleActivator(LogicalKeyboardKey.digit7, control: true): () =>
          _flagShortcut(7),
      const SingleActivator(LogicalKeyboardKey.keyE): () =>
          _actionShortcut(_ReviewAction.editNote),
      const SingleActivator(
        LogicalKeyboardKey.keyE,
        control: true,
        alt: true,
      ): () => _actionShortcut(_ReviewAction.createCopy),
      const SingleActivator(LogicalKeyboardKey.keyO): () =>
          _actionShortcut(_ReviewAction.options),
      const SingleActivator(
        LogicalKeyboardKey.keyI,
        control: true,
        alt: true,
      ): () => _actionShortcut(_ReviewAction.previousCardInfo),
      const SingleActivator(LogicalKeyboardKey.keyI): () =>
          _actionShortcut(_ReviewAction.cardInfo),
      const SingleActivator(LogicalKeyboardKey.keyV, shift: true): () =>
          _actionShortcut(_ReviewAction.recordOwnVoice),
      const SingleActivator(LogicalKeyboardKey.keyV): () =>
          _actionShortcut(_ReviewAction.replayOwnVoice),
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
      const SingleActivator(LogicalKeyboardKey.digit8, shift: true): () =>
          _actionShortcut(_ReviewAction.toggleMark),
      const SingleActivator(
        LogicalKeyboardKey.keyN,
        control: true,
        alt: true,
      ): () => _actionShortcut(_ReviewAction.forgetCard),
      const SingleActivator(
        LogicalKeyboardKey.keyD,
        control: true,
        shift: true,
      ): () => _actionShortcut(_ReviewAction.setDueDate),
      if (Theme.of(context).platform == TargetPlatform.macOS)
        const SingleActivator(LogicalKeyboardKey.backspace, control: true): () =>
            _actionShortcut(_ReviewAction.deleteNote)
      else
        const SingleActivator(LogicalKeyboardKey.delete, control: true): () =>
            _actionShortcut(_ReviewAction.deleteNote),
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
  }

  ReviewCard? _currentCard() => switch (widget.controller.state) {
    ReviewQuestion(:final card) => card,
    ReviewAnswer(:final card) => card,
    _ => null,
  };

  int? _currentNoteId() => _currentCard()?.noteId;

  Future<ReviewDeckOptionsTarget?> _chooseDeckOptionsTarget(
    ReviewCard card,
  ) async {
    final studyDeckId = widget.studyDeckId;
    if (studyDeckId == null) return null;

    if (card.originalDeckId != 0) {
      return ReviewDeckOptionsTarget(
        deckId: card.storageDeckId,
        filtered: true,
      );
    }
    if (card.storageDeckId == studyDeckId) {
      return ReviewDeckOptionsTarget(
        deckId: card.storageDeckId,
        filtered: false,
      );
    }

    return showDialog<ReviewDeckOptionsTarget>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Which deck?'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.of(dialogContext).pop(
              ReviewDeckOptionsTarget(deckId: studyDeckId, filtered: false),
            ),
            child: const Text('Study Options'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(dialogContext).pop(
              ReviewDeckOptionsTarget(
                deckId: card.storageDeckId,
                filtered: false,
              ),
            ),
            child: Text('${card.deckName} Options'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _setFlag(int flag) async {
    if (_manualActionInProgress || !widget.controller.supportsFlags) return;
    setState(() => _manualActionInProgress = true);
    try {
      await widget.controller.setCurrentFlag(flag);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not set flag: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _manualActionInProgress = false);
    }
  }

  Future<int?> _chooseFlag() => showDialog<int>(
    context: context,
    builder: (dialogContext) => SimpleDialog(
      title: const Text('Set flag'),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.of(dialogContext).pop(0),
          child: const Text('Clear flag'),
        ),
        for (var flag = 1; flag <= 7; flag++)
          SimpleDialogOption(
            onPressed: () => Navigator.of(dialogContext).pop(flag),
            child: Text('Flag $flag'),
          ),
      ],
    ),
  );

  Future<ReviewForgetCardOptions?> _chooseForgetCardOptions() async {
    final defaults = await widget.controller.forgetCurrentCardDefaults();
    if (!mounted) return null;
    var restoreOriginalPosition = defaults.restoreOriginalPosition;
    var resetRepetitionAndLapseCounts =
        defaults.resetRepetitionAndLapseCounts;

    return showDialog<ReviewForgetCardOptions>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Forget card…'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: restoreOriginalPosition,
                onChanged: (value) => setDialogState(
                  () => restoreOriginalPosition =
                      value ?? restoreOriginalPosition,
                ),
                title: const Text('Restore original position where possible'),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: resetRepetitionAndLapseCounts,
                onChanged: (value) => setDialogState(
                  () => resetRepetitionAndLapseCounts =
                      value ?? resetRepetitionAndLapseCounts,
                ),
                title: const Text('Reset repetition and lapse counts'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(
                ReviewForgetCardOptions(
                  restoreOriginalPosition: restoreOriginalPosition,
                  resetRepetitionAndLapseCounts:
                      resetRepetitionAndLapseCounts,
                ),
              ),
              child: const Text('Forget'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _chooseDueDate() async {
    final defaultValue = await widget.controller.currentCardDueDateDefault();
    if (!mounted) return null;
    var value = defaultValue;
    return showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Set Due Date'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Show card in how many days?'),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: defaultValue,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onChanged: (text) => value = text,
              onFieldSubmitted: (text) =>
                  Navigator.of(dialogContext).pop(text),
            ),
            const SizedBox(height: 8),
            const Text(
              '0 = today\n'
              '1! = tomorrow + change interval to 1\n'
              '3-7 = random choice of 3-7 days',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(value),
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }

  Future<void> _openCardInfo(CardInfoKind kind) async {
    final opener = widget.onOpenCardInfo;
    if (opener == null) return;
    final target = ReviewCardInfoTarget(
      kind: kind,
      cardId: kind == CardInfoKind.current
          ? widget.controller.currentCardId
          : widget.controller.previousCardId,
    );
    final token = widget.controller.pauseForSecondarySurface();
    if (token == null) return;
    try {
      await opener(target);
    } finally {
      widget.controller.resumeAfterSecondarySurface(token);
    }
  }

  Future<void> _recordOwnVoice() async {
    if (!widget.controller.canRecordOwnVoice) return;
    final token = widget.controller.pauseForSecondarySurface();
    if (token == null) return;
    _OwnVoiceDialogResult? result;
    try {
      result = await showDialog<_OwnVoiceDialogResult>(
        context: context,
        barrierDismissible: false,
        builder: (_) => _OwnVoiceRecordingDialog(
          controller: widget.controller,
        ),
      );
    } finally {
      widget.controller.resumeAfterSecondarySurface(token);
    }
    if (!mounted || result == null) return;
    switch (result.kind) {
      case _OwnVoiceDialogResultKind.completed:
      case _OwnVoiceDialogResultKind.cancelled:
        return;
      case _OwnVoiceDialogResultKind.permissionDenied:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Microphone permission is required to record your voice.',
            ),
          ),
        );
      case _OwnVoiceDialogResultKind.error:
        throw result.error ?? StateError('Voice recording failed');
    }
  }

  Future<void> _runReviewAction(_ReviewAction action) async {
    if (_manualActionInProgress) return;
    setState(() => _manualActionInProgress = true);
    try {
      switch (action) {
        case _ReviewAction.editNote:
          final editor = widget.onEditNote;
          final noteId = _currentNoteId();
          if (editor == null || noteId == null) return;
          final autoAdvanceWasEnabled = widget.controller.autoAdvanceEnabled;
          if (autoAdvanceWasEnabled) {
            await widget.controller.toggleAutoAdvance();
          }
          try {
            final changed = await editor(noteId);
            if (changed) await widget.controller.refreshCurrentCard();
          } finally {
            if (autoAdvanceWasEnabled && !widget.controller.autoAdvanceEnabled) {
              await widget.controller.toggleAutoAdvance();
            }
          }
          break;
        case _ReviewAction.createCopy:
          final opener = widget.onCreateCopy;
          final card = _currentCard();
          if (opener == null || card == null) return;
          final token = widget.controller.pauseForSecondarySurface();
          if (token == null) return;
          try {
            await opener(
              ReviewCreateCopyTarget(
                noteId: card.noteId,
                deckId: card.currentDeckId,
                deckName: card.deckName,
              ),
            );
          } finally {
            widget.controller.resumeAfterSecondarySurface(token);
          }
          break;
        case _ReviewAction.setFlag:
          final flag = await _chooseFlag();
          if (flag != null) await widget.controller.setCurrentFlag(flag);
          break;
        case _ReviewAction.toggleMark:
          await widget.controller.toggleCurrentMarked();
          break;
        case _ReviewAction.forgetCard:
          final options = await _chooseForgetCardOptions();
          if (options != null) await widget.controller.forgetCurrentCard(options);
          break;
        case _ReviewAction.setDueDate:
          final days = await _chooseDueDate();
          if (days != null && days.trim().isNotEmpty) {
            await widget.controller.setCurrentCardDueDate(days);
          }
          break;
        case _ReviewAction.options:
          final opener = widget.onOpenDeckOptions;
          final card = _currentCard();
          if (opener == null || card == null || widget.studyDeckId == null) return;
          final target = await _chooseDeckOptionsTarget(card);
          if (target == null) return;
          final autoAdvanceWasEnabled = widget.controller.autoAdvanceEnabled;
          if (autoAdvanceWasEnabled) {
            await widget.controller.toggleAutoAdvance();
          }
          try {
            await opener(target);
            await widget.controller.refreshCurrentDeckSettings();
          } finally {
            if (autoAdvanceWasEnabled && !widget.controller.autoAdvanceEnabled) {
              await widget.controller.toggleAutoAdvance();
            }
          }
          break;
        case _ReviewAction.cardInfo:
          await _openCardInfo(CardInfoKind.current);
          break;
        case _ReviewAction.previousCardInfo:
          await _openCardInfo(CardInfoKind.previous);
          break;
        case _ReviewAction.deleteNote:
          await widget.controller.deleteCurrentNote();
          break;
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
        case _ReviewAction.recordOwnVoice:
          await _recordOwnVoice();
          break;
        case _ReviewAction.replayOwnVoice:
          final replayed = await widget.controller.replayOwnVoice();
          if (!replayed && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("You haven't recorded your voice yet."),
              ),
            );
          }
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
    if (widget.onEditNote != null) ...[
      const PopupMenuItem(
        value: _ReviewAction.editNote,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.edit_outlined),
          title: Text('Edit note'),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.controller.supportsMarking) ...[
      PopupMenuItem(
        value: _ReviewAction.toggleMark,
        child: ListTile(
          dense: true,
          leading: Icon(
            widget.controller.currentMarked ? Icons.star : Icons.star_border,
          ),
          title: Text(
            widget.controller.currentMarked ? 'Unmark note' : 'Mark note',
          ),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.controller.supportsFlags) ...[
      const PopupMenuItem(
        value: _ReviewAction.setFlag,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.flag_outlined),
          title: Text('Set flag…'),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.controller.supportsForgetCard) ...[
      const PopupMenuItem(
        value: _ReviewAction.forgetCard,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.restart_alt),
          title: Text('Forget card…'),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.controller.supportsSetDueDate) ...[
      const PopupMenuItem(
        value: _ReviewAction.setDueDate,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.event_outlined),
          title: Text('Set Due Date…'),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.onOpenDeckOptions != null && widget.studyDeckId != null) ...[
      const PopupMenuItem(
        value: _ReviewAction.options,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.settings_outlined),
          title: Text('Options'),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.onOpenCardInfo != null) ...[
      const PopupMenuItem(
        value: _ReviewAction.cardInfo,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.info_outline),
          title: Text('Card Info'),
        ),
      ),
      const PopupMenuItem(
        value: _ReviewAction.previousCardInfo,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.history),
          title: Text('Previous Card Info'),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.onCreateCopy != null) ...[
      const PopupMenuItem(
        value: _ReviewAction.createCopy,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.copy_outlined),
          title: Text('Create Copy…'),
        ),
      ),
      const PopupMenuDivider(),
    ],
    if (widget.controller.supportsDeleteNote) ...[
      const PopupMenuItem(
        value: _ReviewAction.deleteNote,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.delete_outline),
          title: Text('Delete note'),
        ),
      ),
      const PopupMenuDivider(),
    ],
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
    if (widget.controller.canRecordOwnVoice) ...[
      const PopupMenuDivider(),
      const PopupMenuItem(
        value: _ReviewAction.recordOwnVoice,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.mic_outlined),
          title: Text('Record Own Voice'),
        ),
      ),
      const PopupMenuItem(
        value: _ReviewAction.replayOwnVoice,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.record_voice_over_outlined),
          title: Text('Replay Own Voice'),
        ),
      ),
    ],
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
            final flag = widget.controller.currentFlag;
            final typedPrompt = widget.controller.typedAnswerPrompt;
            return Scaffold(
              appBar: AppBar(
                title: Text(card.deckName),
                actions: [
                  if (settings.showTimer) ...[
                    Center(child: _ReviewTimer(controller: widget.controller)),
                    const SizedBox(width: 12),
                  ],
                  if (widget.controller.currentMarked) ...[
                    const Tooltip(
                      message: 'Marked note',
                      child: Icon(Icons.star),
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (flag != 0) ...[
                    Tooltip(
                      message: 'Flag $flag',
                      child: const Icon(Icons.flag),
                    ),
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
                    if (!isAnswer && widget.controller.hasTypedAnswerInput)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 720),
                          child: TextField(
                            key: const ValueKey('typed-answer-input'),
                            focusNode: _typedAnswerFocusNode,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                              fontFamily: typedPrompt != null &&
                                      typedPrompt.fontName.isNotEmpty
                                  ? typedPrompt.fontName
                                  : null,
                              fontSize: typedPrompt != null &&
                                      typedPrompt.fontSize > 0
                                  ? typedPrompt.fontSize.toDouble()
                                  : null,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Type your answer',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: widget.controller.updateTypedAnswer,
                            onSubmitted: (_) =>
                                unawaited(widget.controller.showAnswer()),
                          ),
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

enum _OwnVoiceDialogResultKind {
  completed,
  cancelled,
  permissionDenied,
  error,
}

final class _OwnVoiceDialogResult {
  const _OwnVoiceDialogResult(this.kind, [this.error]);

  final _OwnVoiceDialogResultKind kind;
  final Object? error;
}

class _OwnVoiceRecordingDialog extends StatefulWidget {
  const _OwnVoiceRecordingDialog({required this.controller});

  final ReviewController controller;

  @override
  State<_OwnVoiceRecordingDialog> createState() =>
      _OwnVoiceRecordingDialogState();
}

class _OwnVoiceRecordingDialogState extends State<_OwnVoiceRecordingDialog> {
  bool _recording = false;
  bool _finishing = false;
  bool _terminal = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_begin()));
  }

  Future<void> _begin() async {
    try {
      final result = await widget.controller.beginOwnVoiceRecording();
      if (!mounted) return;
      if (result == ReviewOwnVoiceStartResult.permissionDenied) {
        _terminal = true;
        Navigator.of(context).pop(
          const _OwnVoiceDialogResult(
            _OwnVoiceDialogResultKind.permissionDenied,
          ),
        );
        return;
      }
      setState(() => _recording = true);
    } catch (error) {
      if (!mounted) return;
      _terminal = true;
      Navigator.of(context).pop(
        _OwnVoiceDialogResult(_OwnVoiceDialogResultKind.error, error),
      );
    }
  }

  Future<void> _stopAndClose() async {
    if (_finishing || _terminal || !_recording) return;
    setState(() => _finishing = true);
    try {
      await widget.controller.stopOwnVoiceRecording();
      if (!mounted) return;
      _terminal = true;
      Navigator.of(context).pop(
        const _OwnVoiceDialogResult(_OwnVoiceDialogResultKind.completed),
      );
    } catch (error) {
      if (!mounted) return;
      _terminal = true;
      Navigator.of(context).pop(
        _OwnVoiceDialogResult(_OwnVoiceDialogResultKind.error, error),
      );
    }
  }

  Future<void> _cancelAndClose() async {
    if (_finishing || _terminal) return;
    setState(() => _finishing = true);
    try {
      await widget.controller.cancelOwnVoiceRecording();
      if (!mounted) return;
      _terminal = true;
      Navigator.of(context).pop(
        const _OwnVoiceDialogResult(_OwnVoiceDialogResultKind.cancelled),
      );
    } catch (error) {
      if (!mounted) return;
      _terminal = true;
      Navigator.of(context).pop(
        _OwnVoiceDialogResult(_OwnVoiceDialogResultKind.error, error),
      );
    }
  }

  @override
  void dispose() {
    if (!_terminal && !_finishing) {
      unawaited(widget.controller.cancelOwnVoiceRecording());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) unawaited(_cancelAndClose());
    },
    child: AlertDialog(
      title: Text(_recording ? 'Recording your voice' : 'Preparing microphone…'),
      content: _recording
          ? StreamBuilder<Duration>(
              stream: widget.controller.ownVoiceRecordingElapsed,
              initialData: Duration.zero,
              builder: (context, snapshot) => Text(
                _formatVoiceElapsed(snapshot.data ?? Duration.zero),
                key: const ValueKey('own-voice-recording-elapsed'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )
          : const SizedBox(
              width: 36,
              height: 36,
              child: Center(child: CircularProgressIndicator()),
            ),
      actions: _recording
          ? [
              TextButton(
                onPressed: _finishing
                    ? null
                    : () => unawaited(_cancelAndClose()),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: _finishing
                    ? null
                    : () => unawaited(_stopAndClose()),
                child: const Text('Stop'),
              ),
            ]
          : null,
    ),
  );
}

String _formatVoiceElapsed(Duration elapsed) {
  final totalSeconds = elapsed.inSeconds;
  final minutes = totalSeconds ~/ 60;
  final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
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