import 'dart:async';

import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/features/notes/note_editor_page.dart';
import 'package:flutter/material.dart';

class CardBrowserPage extends StatefulWidget {
  const CardBrowserPage({
    required this.repository,
    required this.noteRepository,
    this.stateStore,
    super.key,
  });

  final CardBrowserRepository repository;
  final NoteEntryRepository noteRepository;
  final BrowserStateStore? stateStore;

  @override
  State<CardBrowserPage> createState() => _CardBrowserPageState();
}

class _CardBrowserPageState extends State<CardBrowserPage> {
  final TextEditingController _queryController = TextEditingController();
  late final BrowserStateStore _stateStore;
  CardBrowserSearchResult? _result;
  Object? _error;
  int _generation = 0;
  bool _loading = true;
  bool _bulkActionInProgress = false;
  final Set<int> _selectedCardIds = <int>{};
  List<CardBrowserSortOption> _sortOptions = const [];
  CardBrowserSortOption? _selectedSortOption;
  CardBrowserSort? _sort;

  @override
  void initState() {
    super.initState();
    _stateStore = widget.stateStore ?? FileBrowserStateStore();
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    CardBrowserState? savedState;
    List<CardBrowserSortOption> options = const [];
    try {
      savedState = await _stateStore.load();
    } catch (_) {
      // Browser state is a convenience; browsing must still work without it.
    }
    try {
      options = await widget.repository.sortOptions();
    } catch (_) {
      // Keep searching with Anki's default ordering if metadata is unavailable.
    }
    if (!mounted) return;

    CardBrowserSortOption? selectedSortOption;
    CardBrowserSort? restoredSort;
    if (savedState case final state?) {
      _queryController.text = state.query;
      final sortColumn = state.sortColumn;
      if (sortColumn != null) {
        for (final option in options) {
          if (option.column == sortColumn) {
            selectedSortOption = option;
            restoredSort = CardBrowserSort(
              column: option.column,
              reverse: state.reverse,
            );
            break;
          }
        }
      }
    }

    setState(() {
      _sortOptions = options;
      _selectedSortOption = selectedSortOption;
      _sort = restoredSort;
    });
    await _search(persistState: false);
  }

  Future<void> _persistState() async {
    try {
      await _stateStore.save(
        CardBrowserState(
          query: _queryController.text,
          sortColumn: _sort?.column,
          reverse: _sort?.reverse ?? false,
        ),
      );
    } catch (_) {
      // Persisted browser state must never block browsing.
    }
  }

  void _selectSortOption(CardBrowserSortOption? option) {
    setState(() {
      _selectedSortOption = option;
      _sort = option == null
          ? null
          : CardBrowserSort(
              column: option.column,
              reverse: option.reverseByDefault,
            );
    });
    unawaited(_search(clearSelection: true));
  }

  void _toggleSortDirection() {
    final sort = _sort;
    if (sort == null) return;
    setState(() {
      _sort = CardBrowserSort(
        column: sort.column,
        reverse: !sort.reverse,
      );
    });
    unawaited(_search(clearSelection: true));
  }

  Future<void> _search({
    bool clearSelection = false,
    bool persistState = true,
  }) async {
    if (_bulkActionInProgress) return;
    if (persistState) await _persistState();
    final generation = ++_generation;
    setState(() {
      if (clearSelection) _selectedCardIds.clear();
      _loading = true;
      _error = null;
    });
    try {
      final result = await widget.repository.search(
        _queryController.text,
        sort: _sort,
      );
      if (!mounted || generation != _generation) return;
      setState(() {
        _result = result;
        _loading = false;
      });
    } catch (error) {
      if (!mounted || generation != _generation) return;
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  Future<void> _editNote(int cardId) async {
    try {
      final noteId = await widget.repository.noteIdForCard(cardId);
      if (!mounted) return;
      final saved = await Navigator.of(context).push<bool>(
        MaterialPageRoute<bool>(
          builder: (_) => NoteEditorPage.edit(
            noteId: noteId,
            repository: widget.noteRepository,
          ),
        ),
      );
      if (saved == true && mounted) await _search();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open note editor: $error')),
        );
      }
    }
  }

  Future<void> _confirmBulkAction(CardBulkAction action) async {
    if (_selectedCardIds.isEmpty || _bulkActionInProgress) return;

    final cardIds = _selectedCardIds.toList(growable: false);
    final actionName = switch (action) {
      CardBulkAction.suspend => 'Suspend',
      CardBulkAction.bury => 'Bury',
      CardBulkAction.delete => 'Delete',
    };
    final cardLabel = cardIds.length == 1 ? 'card' : 'cards';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('$actionName ${cardIds.length} $cardLabel?'),
        content: Text(switch (action) {
          CardBulkAction.suspend =>
            'These cards will be suspended until you unsuspend them.',
          CardBulkAction.bury =>
            'These cards will be buried for the current day.',
          CardBulkAction.delete =>
            'Delete these cards from the collection? Their notes will remain.',
        }),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('confirm-card-bulk-action'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(actionName),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _bulkActionInProgress = true);
    try {
      await widget.repository.applyBulkAction(cardIds, action);
      if (!mounted) return;
      setState(() {
        _selectedCardIds.clear();
        _bulkActionInProgress = false;
      });
      await _search();
    } catch (error) {
      if (!mounted) return;
      setState(() => _bulkActionInProgress = false);
      final verb = switch (action) {
        CardBulkAction.suspend => 'suspend',
        CardBulkAction.bury => 'bury',
        CardBulkAction.delete => 'delete',
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not $verb selected cards: $error')),
      );
    }
  }

  void _toggleCardSelection(int cardId, bool selected) {
    setState(() {
      if (selected) {
        _selectedCardIds.add(cardId);
      } else {
        _selectedCardIds.remove(cardId);
      }
    });
  }

  @override
  void dispose() {
    _generation++;
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse cards')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                key: const ValueKey('card-browser-search'),
                controller: _queryController,
                enabled: !_bulkActionInProgress,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  labelText: 'Search cards',
                  hintText: 'Anki search syntax',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    tooltip: 'Search',
                    onPressed: _loading || _bulkActionInProgress
                        ? null
                        : () => unawaited(_search(clearSelection: true)),
                    icon: const Icon(Icons.search),
                  ),
                ),
                onSubmitted: (_) {
                  if (!_bulkActionInProgress) {
                    unawaited(_search(clearSelection: true));
                  }
                },
              ),
            ),
            if (_sortOptions.isNotEmpty) _buildSortControls(),
            if (_selectedCardIds.isNotEmpty) _buildSelectionActions(),
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildSortControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Sort by',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<CardBrowserSortOption?>(
                  key: const ValueKey('card-browser-sort-column'),
                  isExpanded: true,
                  value: _selectedSortOption,
                  hint: const Text('Anki default order'),
                  items: [
                    const DropdownMenuItem<CardBrowserSortOption?>(
                      value: null,
                      child: Text('Anki default order'),
                    ),
                    ..._sortOptions.map(
                      (option) => DropdownMenuItem<CardBrowserSortOption?>(
                        value: option,
                        child: Text(option.label),
                      ),
                    ),
                  ],
                  onChanged: _loading || _bulkActionInProgress
                      ? null
                      : _selectSortOption,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            key: const ValueKey('card-browser-sort-direction'),
            tooltip: 'Reverse sort order',
            onPressed: _sort == null || _loading || _bulkActionInProgress
                ? null
                : _toggleSortDirection,
            icon: Icon(
              _sort?.reverse == true
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionActions() {
    final count = _selectedCardIds.length;
    final cardLabel = count == 1 ? 'card' : 'cards';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$count $cardLabel selected'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: _loading || _bulkActionInProgress
                    ? null
                    : () =>
                          unawaited(_confirmBulkAction(CardBulkAction.suspend)),
                child: const Text('Suspend selected'),
              ),
              OutlinedButton(
                onPressed: _loading || _bulkActionInProgress
                    ? null
                    : () => unawaited(_confirmBulkAction(CardBulkAction.bury)),
                child: const Text('Bury selected'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: _loading || _bulkActionInProgress
                    ? null
                    : () =>
                          unawaited(_confirmBulkAction(CardBulkAction.delete)),
                child: const Text('Delete selected'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error case final error?) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Could not search cards: $error',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: () => unawaited(_search()),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final result = _result;
    if (result == null || result.cards.isEmpty) {
      return const Center(child: Text('No cards match this search.'));
    }

    final truncated = result.cards.length < result.totalCount;
    return ListView.builder(
      itemCount: result.cards.length + (truncated ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == result.cards.length) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Showing ${result.cards.length} of ${result.totalCount} matches. Refine your search.',
              textAlign: TextAlign.center,
            ),
          );
        }

        final card = result.cards[index];
        final cells = card.cells
            .where((cell) => cell.trim().isNotEmpty)
            .toList(growable: false);
        final title = cells.isEmpty ? 'Card ${card.cardId}' : cells.first;
        final subtitle = cells.length < 2 ? null : cells.skip(1).join(' · ');
        return ListTile(
          key: ValueKey('card-browser-result-${card.cardId}'),
          leading: Checkbox(
            key: ValueKey('select-card-${card.cardId}'),
            value: _selectedCardIds.contains(card.cardId),
            onChanged: _loading || _bulkActionInProgress
                ? null
                : (selected) =>
                      _toggleCardSelection(card.cardId, selected ?? false),
          ),
          title: Text(title),
          subtitle: subtitle == null ? null : Text(subtitle),
          trailing: IconButton(
            tooltip: 'Edit note',
            onPressed: _bulkActionInProgress
                ? null
                : () => unawaited(_editNote(card.cardId)),
            icon: const Icon(Icons.edit_outlined),
          ),
        );
      },
    );
  }
}
