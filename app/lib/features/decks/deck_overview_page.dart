import 'dart:async';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/features/deck_options/data/anki_deck_options_repository.dart';
import 'package:anki_flutter/features/deck_options/deck_options_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/reviewer/data/anki_card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:anki_flutter/features/statistics/data/anki_statistics_repository.dart';
import 'package:anki_flutter/features/statistics/statistics_page.dart';
import 'package:anki_flutter/features/study/custom_study_page.dart';
import 'package:anki_flutter/features/study/data/anki_custom_study_repository.dart';
import 'package:flutter/material.dart';

typedef ReviewControllerBuilder = ReviewController Function();

class DeckOverviewPage extends StatefulWidget {
  const DeckOverviewPage({
    required this.deck,
    this.backend,
    this.mediaBaseUri,
    this.onRename,
    this.onRemove,
    this.onChanged,
    this.onAddNote,
    this.reviewControllerBuilder,
    super.key,
  });

  final DeckNode deck;
  final BackendInvoker? backend;
  final Uri? mediaBaseUri;
  final Future<void> Function(String name)? onRename;
  final Future<void> Function()? onRemove;
  final Future<void> Function()? onChanged;
  final Future<void> Function()? onAddNote;
  final ReviewControllerBuilder? reviewControllerBuilder;

  @override
  State<DeckOverviewPage> createState() => _DeckOverviewPageState();
}

class _DeckOverviewPageState extends State<DeckOverviewPage> {
  ReviewController? _reviewController;
  bool _mutating = false;

  Future<void> _rename() async {
    final rename = widget.onRename;
    if (rename == null) return;
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: widget.deck.name);
        return AlertDialog(
          title: const Text('Rename deck'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Deck name'),
            onSubmitted: (value) => Navigator.of(context).pop(value.trim()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (name == null || name.isEmpty || name == widget.deck.name) return;
    await _runMutation(() => rename(name));
  }

  Future<void> _remove() async {
    final remove = widget.onRemove;
    if (remove == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete deck?'),
        content: Text('Delete “${widget.deck.name}” and its cards?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _runMutation(remove);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _runMutation(Future<void> Function() mutation) async {
    setState(() => _mutating = true);
    try {
      await mutation();
      await widget.onChanged?.call();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not update deck: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _mutating = false);
    }
  }

  void _study() {
    final controller =
        widget.reviewControllerBuilder?.call() ??
        _createDefaultReviewController();
    if (controller == null) return;
    _reviewController = controller;
    unawaited(
      Navigator.of(context)
          .push(
            MaterialPageRoute<void>(
              builder: (_) => ReviewPage(
                controller: controller,
                mediaBaseUri: widget.mediaBaseUri,
                onFinished: () {
                  unawaited(widget.onChanged?.call());
                  Navigator.of(context).maybePop();
                },
              ),
            ),
          )
          .whenComplete(() {
            if (identical(_reviewController, controller)) {
              _reviewController = null;
            }
            controller.dispose();
          }),
    );
    unawaited(controller.start(widget.deck.id));
  }

  Future<void> _addNote() async {
    await widget.onAddNote?.call();
    await widget.onChanged?.call();
  }

  Future<void> _customStudy() async {
    final backend = widget.backend;
    if (backend == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CustomStudyPage(
          deckId: widget.deck.id,
          deckName: widget.deck.name,
          repository: AnkiCustomStudyRepository(backend: backend),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  Future<void> _statistics() async {
    final backend = widget.backend;
    if (backend == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StatisticsPage(
          repository: AnkiStatisticsRepository(backend: backend),
          search: _deckStatsSearch(widget.deck.name),
        ),
      ),
    );
  }

  Future<void> _deckOptions() async {
    final backend = widget.backend;
    if (backend == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DeckOptionsPage(
          deckId: widget.deck.id,
          repository: AnkiDeckOptionsRepository(backend: backend),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  ReviewController? _createDefaultReviewController() {
    final backend = widget.backend;
    if (backend == null) return null;
    return ReviewController(
      repository: AnkiReviewRepository(backend: backend),
      renderer: AnkiCardRenderRepository(backend: backend),
      wallClockMillis: () => DateTime.now().millisecondsSinceEpoch,
      stopwatchFactory: Stopwatch.new,
    );
  }

  @override
  void dispose() {
    _reviewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deck = widget.deck;
    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name),
        actions: [
          if (widget.backend != null)
            IconButton(
              tooltip: 'Deck options',
              onPressed: _mutating ? null : _deckOptions,
              icon: const Icon(Icons.settings_outlined),
            ),
          if (widget.backend != null)
            IconButton(
              tooltip: 'Custom study',
              onPressed: _mutating ? null : _customStudy,
              icon: const Icon(Icons.tune),
            ),
          if (widget.backend != null)
            IconButton(
              tooltip: 'Deck statistics',
              onPressed: _mutating ? null : _statistics,
              icon: const Icon(Icons.bar_chart_outlined),
            ),
          if (widget.onAddNote != null)
            IconButton(
              tooltip: 'Add note',
              onPressed: () => unawaited(_addNote()),
              icon: const Icon(Icons.note_add_outlined),
            ),
          if (widget.onRename != null)
            IconButton(
              tooltip: 'Rename deck',
              onPressed: _mutating ? null : _rename,
              icon: const Icon(Icons.edit_outlined),
            ),
          if (widget.onRemove != null)
            IconButton(
              tooltip: 'Delete deck',
              onPressed: _mutating ? null : _remove,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('New ${deck.newCount}'),
              const SizedBox(height: 8),
              Text('Learn ${deck.learnCount}'),
              const SizedBox(height: 8),
              Text('Review ${deck.reviewCount}'),
              const SizedBox(height: 24),
              FilledButton(
                onPressed:
                    widget.backend == null &&
                        widget.reviewControllerBuilder == null
                    ? null
                    : _study,
                child: const Text('Study'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _deckStatsSearch(String deckName) {
  final escaped = deckName.replaceAll(r'\', r'\\').replaceAll('"', r'\"');
  return 'deck:"$escaped"';
}
