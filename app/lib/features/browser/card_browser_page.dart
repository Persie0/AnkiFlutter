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
  bool _loadingMore = false;
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
      _loadingMore = false;
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

  Future<void> _loadMore() async {
    final pagingRepository = widget.repository is CardBrowserPagingRepository
        ? widget.repository as CardBrowserPagingRepository
        : null;
    final current = _result;
    if (pagingRepository == null ||
        current == null ||
        _loading ||
        _loadingMore ||
        _bulkActionInProgress ||
        current.matchingCardIds.length != current.totalCount ||
        current.cards.length >= current.totalCount) {
      return;
    }

    final nextIds = current.matchingCardIds
        .skip(current.cards.length)
        .take(pagingRepository.pageSize)
        .toList(growable: false);
    if (nextIds.isEmpty) return;
    final generation = _generation;
    setState(() => _loadingMore = true);
    try {
      final nextRows = await pagingRepository.renderMore(nextIds);
      if (!mounted || generation != _generation) return;
      if (nextRows.length != nextIds.length) {
        throw StateError('Backend returned an incomplete page.');
      }
      setState(() {
        _result = CardBrowserSearchResult(
          totalCount: current.totalCount,
          cards: List.unmodifiable([...current.cards, ...nextRows]),
          matchingCardIds: current.matchingCardIds,
        );
      });
    } catch (error) {
      if (!mounted || generation != _generation) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load more cards: $error')),
      );
    } finally {
      if (mounted && generation == _generation) {
        setState(() => _loadingMore = false);
      }
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

  Future<void> _tagSelectedCards({required bool remove}) async {
    final tagRepository = widget.repository is CardBrowserTagRepository
        ? widget.repository as CardBrowserTagRepository
        : null;
    if (tagRepository == null ||
        _selectedCardIds.isEmpty ||
        _bulkActionInProgress) {
      return;
    }

    final selectedIds = _selectedCardIds.toList(growable: false);
    final tags = await showDialog<String>(
      context: context,
      builder: (_) => _BrowserTagsDialog(remove: remove),
    );
    if (!mounted || tags == null || _bulkActionInProgress) return;

    setState(() => _bulkActionInProgress = true);
    try {
      await tagRepository.applyTagsToCards(
        selectedIds,
        tags,
        remove: remove,
      );
      if (!mounted) return;
      setState(() {
        _selectedCardIds.clear();
        _bulkActionInProgress = false;
      });
      await _search();
    } catch (error) {
      if (!mounted) return;
      setState(() => _bulkActionInProgress = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not ${remove ? 'remove' : 'add'} tags: $error'),
        ),
      );
    }
  }

  Future<void> _setSelectedFlags() async {
    final flagRepository = widget.repository is CardBrowserFlagRepository
        ? widget.repository as CardBrowserFlagRepository
        : null;
    if (flagRepository == null ||
        _selectedCardIds.isEmpty ||
        _bulkActionInProgress) {
      return;
    }

    final cardIds = _selectedCardIds.toList(growable: false);
    setState(() => _bulkActionInProgress = true);
    try {
      final flag = await showDialog<int>(
        context: context,
        builder: (dialogContext) => SimpleDialog(
          title: const Text('Set card flags'),
          children: [
            SimpleDialogOption(
              key: const ValueKey('browser-flag-choice-0'),
              onPressed: () => Navigator.of(dialogContext).pop(0),
              child: const Text('Clear flags'),
            ),
            for (var index = 1; index <= 7; index++)
              SimpleDialogOption(
                key: ValueKey('browser-flag-choice-$index'),
                onPressed: () => Navigator.of(dialogContext).pop(index),
                child: Text('Flag $index'),
              ),
          ],
        ),
      );
      if (!mounted || flag == null) return;

      await flagRepository.setCardsFlag(cardIds, flag);
      if (!mounted) return;
      setState(() => _selectedCardIds.clear());
      await _searchAfterBulkMove();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not set selected card flags: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
    }
  }

  Future<void> _moveSelectedCards() async {
    final deckRepository = widget.repository is CardBrowserDeckMoveRepository
        ? widget.repository as CardBrowserDeckMoveRepository
        : null;
    if (deckRepository == null ||
        _selectedCardIds.isEmpty ||
        _bulkActionInProgress) {
      return;
    }

    // Freeze the selection while the destination is being fetched/chosen.
    final cardIds = _selectedCardIds.toList(growable: false);
    setState(() => _bulkActionInProgress = true);
    try {
      final targets = await deckRepository.moveTargets();
      if (!mounted) return;
      if (targets.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No regular destination decks found.')),
        );
        return;
      }
      final deckId = await showDialog<int>(
        context: context,
        builder: (_) => _BrowserMoveDeckDialog(
          targets: targets,
          cardCount: cardIds.length,
        ),
      );
      if (!mounted || deckId == null) return;

      await deckRepository.moveCardsToDeck(cardIds, deckId);
      if (!mounted) return;
      setState(() => _selectedCardIds.clear());
      await _searchAfterBulkMove();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not move selected cards: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
    }
  }

  Future<void> _searchAfterBulkMove() async {
    // _search normally blocks requests while a bulk operation is active.
    // Release the lock only once the native setDeck operation has completed.
    setState(() => _bulkActionInProgress = false);
    await _search();
  }

  void _selectVisibleCards() {
    final result = _result;
    if (_loading || _bulkActionInProgress || result == null) return;
    setState(() {
      _selectedCardIds.addAll(result.cards.map((card) => card.cardId));
    });
  }

  void _clearCardSelection() {
    if (_bulkActionInProgress) return;
    setState(() => _selectedCardIds.clear());
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
            if (!_loading && _error == null && _result?.cards.isNotEmpty == true)
              _buildSelectionToolbar(),
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

  Widget _buildSelectionToolbar() {
    final cards = _result!.cards;
    final allVisibleSelected = cards.every(
      (card) => _selectedCardIds.contains(card.cardId),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            TextButton.icon(
              key: const ValueKey('browser-select-visible'),
              onPressed: allVisibleSelected || _bulkActionInProgress
                  ? null
                  : _selectVisibleCards,
              icon: const Icon(Icons.select_all),
              label: Text('Select visible (${cards.length})'),
            ),
            if (_selectedCardIds.isNotEmpty)
              TextButton(
                key: const ValueKey('browser-clear-selection'),
                onPressed: _bulkActionInProgress ? null : _clearCardSelection,
                child: const Text('Clear selection'),
              ),
          ],
        ),
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
              if (widget.repository is CardBrowserFlagRepository)
                OutlinedButton(
                  key: const ValueKey('browser-set-flags'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_setSelectedFlags()),
                  child: const Text('Set flags'),
                ),
              if (widget.repository is CardBrowserDeckMoveRepository)
                OutlinedButton(
                  key: const ValueKey('browser-move-deck'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_moveSelectedCards()),
                  child: const Text('Change deck'),
                ),
              if (widget.repository is CardBrowserTagRepository) ...[
                OutlinedButton(
                  key: const ValueKey('browser-add-tags'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_tagSelectedCards(remove: false)),
                  child: const Text('Add tags'),
                ),
                OutlinedButton(
                  key: const ValueKey('browser-remove-tags'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_tagSelectedCards(remove: true)),
                  child: const Text('Remove tags'),
                ),
              ],
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
    final canLoadMore = widget.repository is CardBrowserPagingRepository &&
        result.matchingCardIds.length == result.totalCount;
    return ListView.builder(
      itemCount: result.cards.length + (truncated ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == result.cards.length) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Showing ${result.cards.length} of ${result.totalCount} matches.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                if (canLoadMore)
                  OutlinedButton(
                    key: const ValueKey('browser-load-more'),
                    onPressed: _loadingMore || _bulkActionInProgress
                        ? null
                        : () => unawaited(_loadMore()),
                    child: _loadingMore
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Load more'),
                  )
                else
                  const Text(
                    'Refine your search.',
                    textAlign: TextAlign.center,
                  ),
              ],
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

class _BrowserTagsDialog extends StatefulWidget {
  const _BrowserTagsDialog({required this.remove});

  final bool remove;

  @override
  State<_BrowserTagsDialog> createState() => _BrowserTagsDialogState();
}

class _BrowserTagsDialogState extends State<_BrowserTagsDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String value) {
    final tags = value.trim();
    if (tags.isNotEmpty) Navigator.of(context).pop(tags);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.remove
          ? 'Remove tags from selected notes'
          : 'Add tags to selected notes'),
      content: TextField(
        key: const ValueKey('browser-tags-input'),
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Tags (separated by spaces)',
        ),
        onSubmitted: _submit,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, _) => FilledButton(
            key: const ValueKey('browser-apply-tags'),
            onPressed: value.text.trim().isEmpty
                ? null
                : () => _submit(value.text),
            child: Text(widget.remove ? 'Remove tags' : 'Add tags'),
          ),
        ),
      ],
    );
  }
}

class _BrowserMoveDeckDialog extends StatefulWidget {
  const _BrowserMoveDeckDialog({
    required this.targets,
    required this.cardCount,
  });

  final List<CardBrowserDeckTarget> targets;
  final int cardCount;

  @override
  State<_BrowserMoveDeckDialog> createState() => _BrowserMoveDeckDialogState();
}

class _BrowserMoveDeckDialogState extends State<_BrowserMoveDeckDialog> {
  int? _selectedDeckId;

  @override
  Widget build(BuildContext context) {
    final count = widget.cardCount;
    return AlertDialog(
      title: Text('Move $count ${count == 1 ? 'card' : 'cards'} to deck'),
      content: SizedBox(
        width: 420,
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Destination deck',
            border: OutlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              key: const ValueKey('browser-move-target'),
              value: _selectedDeckId,
              isExpanded: true,
              hint: const Text('Choose a regular deck'),
              items: widget.targets
                  .map(
                    (deck) => DropdownMenuItem<int>(
                      value: deck.id,
                      child: Text(deck.label, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (id) => setState(() => _selectedDeckId = id),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const ValueKey('browser-confirm-move'),
          onPressed: _selectedDeckId == null
              ? null
              : () => Navigator.of(context).pop(_selectedDeckId),
          child: const Text('Move cards'),
        ),
      ],
    );
  }
}
