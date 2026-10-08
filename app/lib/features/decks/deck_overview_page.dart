import 'dart:async';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/features/card_info/card_info_page.dart';
import 'package:anki_flutter/features/card_info/data/anki_card_info_repository.dart';
import 'package:anki_flutter/features/deck_options/data/anki_deck_options_repository.dart';
import 'package:anki_flutter/features/deck_options/deck_options_page.dart';
import 'package:anki_flutter/features/deck_options/filtered_deck_options_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/data/anki_filtered_deck_repository.dart';
import 'package:anki_flutter/features/decks/data/anki_filtered_deck_options_repository.dart';
import 'package:anki_flutter/features/notes/add_note_page.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/features/notes/note_editor_page.dart';
import 'package:anki_flutter/features/preferences/data/anki_preferences_repository.dart';
import 'package:anki_flutter/features/preferences/preferences_page.dart';
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

enum _DeckBrowseFilter { all, due, newCards, suspended }

class DeckOverviewPage extends StatefulWidget {
  const DeckOverviewPage({
    required this.deck,
    this.backend,
    this.mediaBaseUri,
    this.onRename,
    this.onRemove,
    this.onChanged,
    this.onAddNote,
    this.onBrowse,
    this.filteredDeckRepository,
    this.filteredDeckOptionsRepository,
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

  /// Opens the collection browser with native Anki search syntax.
  final void Function(String query)? onBrowse;

  /// Overrides the native repository in tests or custom backend integrations.
  final FilteredDeckRepository? filteredDeckRepository;
  final FilteredDeckOptionsRepository? filteredDeckOptionsRepository;
  final ReviewControllerBuilder? reviewControllerBuilder;

  @override
  State<DeckOverviewPage> createState() => _DeckOverviewPageState();
}

class _DeckOverviewPageState extends State<DeckOverviewPage> {
  ReviewController? _reviewController;
  bool _mutating = false;

  FilteredDeckRepository? get _filteredDeckRepository {
    if (!widget.deck.filtered) return null;
    final provided = widget.filteredDeckRepository;
    if (provided != null) return provided;
    final backend = widget.backend;
    return backend == null ? null : AnkiFilteredDeckRepository(backend: backend);
  }

  Future<void> _performFilteredDeckOperation(
    Future<String> Function(FilteredDeckRepository repository) operation,
  ) async {
    final repository = _filteredDeckRepository;
    if (repository == null || _mutating) return;
    setState(() => _mutating = true);
    try {
      final summary = await operation(repository);
      if (!mounted) return;
      await widget.onChanged?.call();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(summary)),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update filtered deck: $error')),
      );
    } finally {
      if (mounted) setState(() => _mutating = false);
    }
  }

  Future<void> _rebuildFilteredDeck() async {
    await _performFilteredDeckOperation((repository) async {
      final count = await repository.rebuild(widget.deck.id);
      return count == 1
          ? 'Rebuilt filtered deck: 1 card.'
          : 'Rebuilt filtered deck: $count cards.';
    });
  }

  Future<void> _emptyFilteredDeck() async {
    if (_filteredDeckRepository == null || _mutating) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Empty filtered deck?'),
        content: const Text(
          'Return its cards to their original decks? '
          'Cards and review history will not be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('filtered-deck-confirm-empty'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Empty deck'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    await _performFilteredDeckOperation((repository) async {
      await repository.empty(widget.deck.id);
      return 'Emptied filtered deck. Cards returned to original decks.';
    });
  }

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
                onEditNote: widget.backend == null ? null : _editReviewNote,
                onCreateCopy: widget.backend == null ? null : _openReviewCreateCopy,
                studyDeckId: widget.deck.id,
                onOpenDeckOptions: widget.backend == null
                    ? null
                    : _openReviewDeckOptions,
                onOpenCardInfo: widget.backend == null
                    ? null
                    : _openReviewCardInfo,
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

  Future<bool> _editReviewNote(int noteId) async {
    final backend = widget.backend;
    if (backend == null) return false;
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NoteEditorPage.edit(
          noteId: noteId,
          repository: AnkiNoteRepository(backend: backend),
        ),
      ),
    );
    return saved == true;
  }

  Future<void> _openReviewCreateCopy(ReviewCreateCopyTarget target) async {
    final backend = widget.backend;
    if (backend == null) return;
    final deck = DeckNode(
      id: target.deckId,
      name: target.deckName,
      newCount: 0,
      learnCount: 0,
      reviewCount: 0,
      filtered: false,
      children: const [],
    );
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AddNotePage(
          deck: deck,
          repository: AnkiNoteRepository(backend: backend),
          sourceNoteId: target.noteId,
        ),
      ),
    );
    await widget.onChanged?.call();
  }

  Future<void> _openReviewDeckOptions(ReviewDeckOptionsTarget target) async {
    final backend = widget.backend;
    if (backend == null) return;
    if (target.filtered) {
      await _openFilteredOptions(target.deckId);
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DeckOptionsPage(
          deckId: target.deckId,
          repository: AnkiDeckOptionsRepository(backend: backend),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  Future<void> _openReviewCardInfo(ReviewCardInfoTarget target) async {
    final backend = widget.backend;
    if (backend == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CardInfoPage(
          repository: AnkiCardInfoRepository(backend: backend),
          cardId: target.cardId,
          kind: target.kind,
        ),
      ),
    );
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

  void _browseDeck(_DeckBrowseFilter filter) {
    final onBrowse = widget.onBrowse;
    if (onBrowse == null || _mutating) return;
    final deckFilter = _deckStatsSearch(widget.deck.name);
    final query = switch (filter) {
      _DeckBrowseFilter.all => deckFilter,
      _DeckBrowseFilter.due => '$deckFilter is:due',
      _DeckBrowseFilter.newCards => '$deckFilter is:new',
      _DeckBrowseFilter.suspended => '$deckFilter is:suspended',
    };
    onBrowse(query);
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

  Future<void> _preferences() async {
    final backend = widget.backend;
    if (backend == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PreferencesPage(
          repository: AnkiPreferencesRepository(backend: backend),
        ),
      ),
    );
  }

  Future<void> _openFilteredOptions(int deckId) async {
    final backend = widget.backend;
    final repository = widget.filteredDeckOptionsRepository ??
        (backend == null ? null : AnkiFilteredDeckOptionsRepository(backend: backend));
    if (repository == null || _mutating) return;
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => FilteredDeckOptionsPage(
          deckId: deckId,
          repository: repository,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  Future<void> _deckOptions() async {
    if (widget.deck.filtered) {
      await _openFilteredOptions(widget.deck.id);
      return;
    }
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
    final compactToolbar = MediaQuery.sizeOf(context).width < 720;
    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name, overflow: TextOverflow.ellipsis),
        actions: [
          if (widget.onBrowse != null)
            PopupMenuButton<_DeckBrowseFilter>(
              key: const ValueKey('deck-browse-menu'),
              tooltip: 'Browse deck cards',
              enabled: !_mutating,
              icon: const Icon(Icons.manage_search),
              onSelected: _browseDeck,
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: _DeckBrowseFilter.all,
                  child: Text('All cards in deck'),
                ),
                PopupMenuItem(
                  value: _DeckBrowseFilter.due,
                  child: Text('Due cards in deck'),
                ),
                PopupMenuItem(
                  value: _DeckBrowseFilter.newCards,
                  child: Text('New cards in deck'),
                ),
                PopupMenuItem(
                  value: _DeckBrowseFilter.suspended,
                  child: Text('Suspended cards in deck'),
                ),
              ],
            ),
          if (widget.backend != null ||
              (widget.deck.filtered &&
                  widget.filteredDeckOptionsRepository != null))
            IconButton(
              tooltip: widget.deck.filtered ? 'Filtered deck options' : 'Deck options',
              onPressed: _mutating ? null : _deckOptions,
              icon: const Icon(Icons.settings_outlined),
            ),
          if (widget.backend != null)
            IconButton(
              tooltip: 'Preferences',
              onPressed: _mutating ? null : _preferences,
              icon: const Icon(Icons.settings_suggest_outlined),
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, bounds) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: bounds.maxHeight),
              child: Center(
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
              if (_filteredDeckRepository != null) ...[
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  key: const ValueKey('filtered-deck-rebuild'),
                  onPressed: _mutating ? null : _rebuildFilteredDeck,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Rebuild filtered deck'),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  key: const ValueKey('filtered-deck-empty'),
                  onPressed: _mutating ? null : _emptyFilteredDeck,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Empty filtered deck'),
                ),
              ],
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
            ),
          ),
        ),
      ),
    );
  }
}

String _deckStatsSearch(String deckName) {
  final escaped = deckName.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
  return 'deck:"$escaped"';
}
