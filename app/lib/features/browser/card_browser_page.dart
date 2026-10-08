import 'dart:async';

import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/browser_search_history.dart';
import 'package:anki_flutter/features/browser/browser_card_preview_page.dart';
import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/browser/browser_card_export.dart';
import 'package:anki_flutter/features/browser/browser_find_replace_dialog.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/card_info/card_info_page.dart';
import 'package:anki_flutter/features/card_info/data/card_info_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/features/notes/note_editor_page.dart';
import 'package:flutter/material.dart';

class CardBrowserPage extends StatefulWidget {
  const CardBrowserPage({
    required this.repository,
    required this.noteRepository,
    this.cardInfoRepository,
    this.previewRepository,
    this.previewMediaBaseUri,
    this.previewSurfaceBuilder,
    this.stateStore,
    this.cardExporter,
    this.initialQuery,
    super.key,
  });

  final CardBrowserRepository repository;
  final NoteEntryRepository noteRepository;

  /// Optional native card statistics and review history access.
  final CardInfoRepository? cardInfoRepository;

  /// Read-only browser rendering is opt-in for legacy/mock repositories.
  final CardRenderRepository? previewRepository;
  final Uri? previewMediaBaseUri;
  final Widget Function(BuildContext context, String html)?
      previewSurfaceBuilder;
  final BrowserStateStore? stateStore;
  final BrowserCardExporter? cardExporter;

  /// One-time entry-point filter. Overrides a saved search without immediately
  /// overwriting the user's persistent browser preferences.
  final String? initialQuery;

  @override
  State<CardBrowserPage> createState() => _CardBrowserPageState();
}

class _CardBrowserPageState extends State<CardBrowserPage> {
  final TextEditingController _queryController = TextEditingController();
  final BrowserSearchHistory _history = BrowserSearchHistory();
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
  List<BrowserSavedSearch> _savedSearches = const [];
  String? _activeSavedSearchName;

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
      _queryController.text = widget.initialQuery ?? state.query;
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

    // A deep link from Check Media must also work for first-time browser use
    // with no persisted query.
    if (savedState == null && widget.initialQuery != null) {
      _queryController.text = widget.initialQuery!;
    }

    setState(() {
      _sortOptions = options;
      _selectedSortOption = selectedSortOption;
      _sort = restoredSort;
      _savedSearches = savedState?.savedSearches ?? const [];
    });
    await _search(persistState: false, recordHistory: true);
  }

  Future<void> _persistState() async {
    try {
      await _stateStore.save(
        CardBrowserState(
          query: _queryController.text,
          sortColumn: _sort?.column,
          reverse: _sort?.reverse ?? false,
          savedSearches: _savedSearches,
        ),
      );
    } catch (_) {
      // Persisted browser state must never block browsing.
    }
  }

  void _selectSortOption(CardBrowserSortOption? option) {
    setState(() {
      _activeSavedSearchName = null;
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
      _activeSavedSearchName = null;
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
    bool keepActiveSavedSearch = false,
    bool recordHistory = false,
  }) async {
    if (_bulkActionInProgress) return;
    if (recordHistory) {
      _history.record(_queryController.text);
    }
    // Changing a query manually does not modify the saved preset.
    if (!keepActiveSavedSearch) _activeSavedSearchName = null;
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

  void _navigateSearchHistory({required bool forward}) {
    if (_loading || _bulkActionInProgress) return;
    final query = forward ? _history.forward() : _history.back();
    if (query == null) return;
    setState(() {
      _queryController.text = query;
      _activeSavedSearchName = null;
    });
    // Browsing history is a replay, not a new search that forks history.
    unawaited(_search(clearSelection: true));
  }

  Future<void> _applySavedSearch(String? name) async {
    if (name == null || _loading || _bulkActionInProgress) return;
    BrowserSavedSearch? selected;
    for (final entry in _savedSearches) {
      if (entry.name == name) {
        selected = entry;
        break;
      }
    }
    if (selected == null) return;
    CardBrowserSortOption? sortOption;
    for (final option in _sortOptions) {
      if (option.column == selected.sortColumn) {
        sortOption = option;
        break;
      }
    }
    setState(() {
      _activeSavedSearchName = selected!.name;
      _queryController.text = selected.query;
      _selectedSortOption = sortOption;
      _sort = sortOption == null
          ? null
          : CardBrowserSort(
              column: sortOption.column,
              reverse: selected.reverse,
            );
    });
    await _search(
      clearSelection: true,
      keepActiveSavedSearch: true,
      recordHistory: true,
    );
  }

  Future<void> _saveNamedSearch() async {
    if (_bulkActionInProgress || _queryController.text.trim().isEmpty) {
      return;
    }
    final name = await showDialog<String>(
      context: context,
      builder: (_) => const _SaveBrowserSearchDialog(),
    );
    if (!mounted || name == null || name.trim().isEmpty) return;
    final trimmed = name.trim();
    final index = _savedSearches.indexWhere(
      (entry) => entry.name.toLowerCase() == trimmed.toLowerCase(),
    );
    if (index >= 0) {
      final overwrite = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Overwrite saved search?'),
          content: Text('Replace "${_savedSearches[index].name}" with the current query and sort order?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              key: const ValueKey('browser-confirm-overwrite-saved-search'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Overwrite'),
            ),
          ],
        ),
      );
      if (!mounted || overwrite != true) return;
    }
    final saved = BrowserSavedSearch(
      name: trimmed,
      query: _queryController.text,
      sortColumn: _sort?.column,
      reverse: _sort?.reverse ?? false,
    );
    final updated = [..._savedSearches];
    if (index >= 0) {
      updated[index] = saved;
    } else {
      updated.add(saved);
    }
    setState(() {
      _savedSearches = List.unmodifiable(updated);
      _activeSavedSearchName = saved.name;
    });
    await _persistState();
  }

  Future<void> _deleteSavedSearch() async {
    final name = _activeSavedSearchName;
    if (name == null || _bulkActionInProgress) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete saved search?'),
        content: Text('Delete "$name"? Your current browser query will remain unchanged.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('browser-confirm-delete-saved-search'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    setState(() {
      _savedSearches = List.unmodifiable(
        _savedSearches.where((entry) => entry.name != name),
      );
      _activeSavedSearchName = null;
    });
    await _persistState();
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

  Future<void> _previewCard(int cardId) async {
    final repository = widget.previewRepository;
    final result = _result;
    if (repository == null ||
        result == null ||
        _loading ||
        _bulkActionInProgress) {
      return;
    }

    // Native search returns every ordered matching ID even if the browser
    // has only rendered the first page. Fall back to visible rows when the
    // result is partial; never navigate outside the current search.
    final matchingIds = result.matchingCardIds;
    final orderedIds = matchingIds.length == result.totalCount &&
            matchingIds.contains(cardId)
        ? matchingIds
        : result.cards.map((card) => card.cardId).toList(growable: false);

    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => BrowserCardPreviewPage(
          cardId: cardId,
          repository: repository,
          orderedCardIds: orderedIds,
          cardInfoRepository: widget.cardInfoRepository,
          mediaBaseUri: widget.previewMediaBaseUri,
          surfaceBuilder: widget.previewSurfaceBuilder,
        ),
      ),
    );
  }

  Future<void> _openCardInfo(int cardId) async {
    final repository = widget.cardInfoRepository;
    if (repository == null || _bulkActionInProgress || _loading) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => CardInfoPage(
          repository: repository,
          cardId: cardId,
          kind: CardInfoKind.browser,
        ),
      ),
    );
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

  Future<void> _exportSelectedCards() async {
    final exporter = widget.cardExporter;
    if (exporter == null ||
        _selectedCardIds.isEmpty ||
        _loading ||
        _bulkActionInProgress) {
      return;
    }
    final selectedIds = _selectedCardIds.toList(growable: false);
    setState(() => _bulkActionInProgress = true);
    try {
      final options = await showDialog<_BrowserCardExportOptions>(
        context: context,
        builder: (_) => _BrowserCardExportDialog(cardCount: selectedIds.length),
      );
      if (!mounted || options == null) return;
      final saved = await exporter.exportCards(
        selectedIds,
        withScheduling: options.withScheduling,
        withMedia: options.withMedia,
      );
      if (!mounted || !saved) return;
      // Export does not change the collection; keep the selection in place.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Exported ${selectedIds.length} '
            '${selectedIds.length == 1 ? 'card' : 'cards'} to Anki package.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not export selected cards: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
    }
  }

  Future<void> _forgetSelectedCards() async {
    final repository = widget.repository is CardBrowserForgetRepository
        ? widget.repository as CardBrowserForgetRepository
        : null;
    if (repository == null ||
        _selectedCardIds.isEmpty ||
        _loading ||
        _bulkActionInProgress) {
      return;
    }

    final selectedIds = _selectedCardIds.toList(growable: false);
    setState(() => _bulkActionInProgress = true);
    try {
      final defaults = await repository.forgetCardsDefaults();
      if (!mounted) return;
      var restorePosition = defaults.restoreOriginalPosition;
      var resetCounts = defaults.resetRepetitionAndLapseCounts;
      final options = await showDialog<CardBrowserForgetOptions>(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: Text(
              'Forget ${selectedIds.length} selected '
              '${selectedIds.length == 1 ? 'card' : 'cards'}?',
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Return these cards to the new queue using Anki scheduling. '
                    'Existing review progress will be reset.',
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Restore original position'),
                    value: restorePosition,
                    onChanged: (value) => setDialogState(
                      () => restorePosition = value ?? false,
                    ),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Reset review and lapse counts'),
                    value: resetCounts,
                    onChanged: (value) => setDialogState(
                      () => resetCounts = value ?? false,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                key: const ValueKey('browser-confirm-forget'),
                onPressed: () => Navigator.of(dialogContext).pop(
                  CardBrowserForgetOptions(
                    restoreOriginalPosition: restorePosition,
                    resetRepetitionAndLapseCounts: resetCounts,
                  ),
                ),
                child: const Text('Forget cards'),
              ),
            ],
          ),
        ),
      );
      if (!mounted || options == null) return;

      await repository.forgetCards(selectedIds, options);
      if (!mounted) return;
      setState(() => _selectedCardIds.clear());
      await _searchAfterBulkMove();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not forget selected cards: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
    }
  }

  Future<void> _repositionSelectedCards() async {
    final repository = widget.repository is CardBrowserRepositionRepository
        ? widget.repository as CardBrowserRepositionRepository
        : null;
    if (repository == null ||
        _selectedCardIds.isEmpty ||
        _loading ||
        _bulkActionInProgress) {
      return;
    }

    // Reposition must respect browser search/sort order, not the order in
    // which the user happened to tap selection checkboxes.
    final orderedMatches = _result?.matchingCardIds ?? const <int>[];
    final cardIds = orderedMatches.isNotEmpty
        ? [
            for (final id in orderedMatches)
              if (_selectedCardIds.contains(id)) id,
          ]
        : _selectedCardIds.toList(growable: false);
    if (cardIds.length != _selectedCardIds.length) return;

    setState(() => _bulkActionInProgress = true);
    try {
      final defaults = await repository.repositionDefaults();
      if (!mounted) return;
      final options = await showDialog<CardBrowserRepositionOptions>(
        context: context,
        builder: (_) => _BrowserRepositionDialog(
          cardCount: cardIds.length,
          defaults: defaults,
        ),
      );
      if (!mounted || options == null) return;

      final changed = await repository.repositionNewCards(cardIds, options);
      if (!mounted) return;
      if (changed == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No selected new cards were changed.')),
        );
        return;
      }
      setState(() => _selectedCardIds.clear());
      await _searchAfterBulkMove();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Repositioned $changed new cards.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not reposition cards: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
    }
  }

  Future<void> _setSelectedCardsDueDate() async {
    final repository = widget.repository is CardBrowserSetDueDateRepository
        ? widget.repository as CardBrowserSetDueDateRepository
        : null;
    if (repository == null ||
        _selectedCardIds.isEmpty ||
        _loading ||
        _bulkActionInProgress) {
      return;
    }

    final selectedIds = _selectedCardIds.toList(growable: false);
    setState(() => _bulkActionInProgress = true);
    try {
      final defaultValue = await repository.setDueDateDefault();
      if (!mounted) return;

      var days = defaultValue;
      final confirmedDays = await showDialog<String>(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: Text(
              'Set due date for ${selectedIds.length} '
              '${selectedIds.length == 1 ? 'card' : 'cards'}?',
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reschedule the selected cards using Anki. '
                    'Existing due dates will change.',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const ValueKey('browser-due-days'),
                    initialValue: defaultValue,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Days until due',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setDialogState(() => days = value),
                    onFieldSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        Navigator.of(dialogContext).pop(value.trim());
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '0 = today\n'
                    '1! = tomorrow and change interval to 1\n'
                    '3-7 = random day between 3 and 7',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                key: const ValueKey('browser-confirm-due'),
                onPressed: days.trim().isEmpty
                    ? null
                    : () => Navigator.of(dialogContext).pop(days.trim()),
                child: const Text('Set due date'),
              ),
            ],
          ),
        ),
      );
      if (!mounted || confirmedDays == null) return;

      await repository.setCardsDueDate(selectedIds, confirmedDays);
      if (!mounted) return;
      setState(() => _selectedCardIds.clear());
      await _searchAfterBulkMove();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not set due date: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
    }
  }

  Future<void> _restoreSelectedCards() async {
    final repository = widget.repository is CardBrowserRestoreRepository
        ? widget.repository as CardBrowserRestoreRepository
        : null;
    if (repository == null ||
        _selectedCardIds.isEmpty ||
        _loading ||
        _bulkActionInProgress) {
      return;
    }
    final selectedIds = _selectedCardIds.toList(growable: false);
    setState(() => _bulkActionInProgress = true);
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('Restore ${selectedIds.length} selected cards?'),
          content: const Text(
            'Unsuspend or unbury these cards, using Anki scheduling. '
            'Cards that are not buried or suspended will remain unchanged.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              key: const ValueKey('browser-confirm-restore'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Restore cards'),
            ),
          ],
        ),
      );
      if (!mounted || confirmed != true) return;
      await repository.restoreCards(selectedIds);
      if (!mounted) return;
      setState(() => _selectedCardIds.clear());
      await _searchAfterBulkMove();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not restore selected cards: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
    }
  }

  Future<void> _findReplaceSelected() async {
    final repository = widget.repository is CardBrowserFindReplaceRepository
        ? widget.repository as CardBrowserFindReplaceRepository
        : null;
    if (repository == null ||
        _selectedCardIds.isEmpty ||
        _loading ||
        _bulkActionInProgress) {
      return;
    }
    final cardIds = List<int>.unmodifiable(_selectedCardIds);
    setState(() => _bulkActionInProgress = true);
    try {
      final options = await showDialog<CardBrowserFindReplaceOptions>(
        context: context,
        builder: (_) => BrowserFindReplaceDialog(cardCount: cardIds.length),
      );
      if (!mounted || options == null) return;

      final changed = await repository.findAndReplaceSelected(cardIds, options);
      if (!mounted) return;
      // The replaced text may no longer match the previous search. Do not
      // retain selections of invisible cards after editing their notes.
      setState(() => _selectedCardIds.clear());
      await _searchAfterBulkMove();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            changed == 0
                ? 'No matching text found in selected notes.'
                : 'Updated $changed ${changed == 1 ? 'note' : 'notes'}.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not find and replace: $error')),
      );
    } finally {
      if (mounted) setState(() => _bulkActionInProgress = false);
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

  void _selectAllMatchingCards() {
    final result = _result;
    if (_loading ||
        _bulkActionInProgress ||
        result == null ||
        result.matchingCardIds.length != result.totalCount ||
        result.matchingCardIds.isEmpty) {
      return;
    }
    // Search IDs are already returned in order by the native Anki backend,
    // including results not yet materialized by the paginated browser.
    setState(() => _selectedCardIds.addAll(result.matchingCardIds));
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
    final compactToolbar = MediaQuery.sizeOf(context).width < 650;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _activeSavedSearchName == null
              ? 'Browse cards'
              : 'Browse · $_activeSavedSearchName',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (compactToolbar)
            PopupMenuButton<int>(
              key: const ValueKey('browser-compact-actions'),
              tooltip: 'Browser actions',
              icon: const Icon(Icons.more_vert),
              enabled: !_bulkActionInProgress,
              itemBuilder: (_) => [
                PopupMenuItem<int>(
                  value: 0,
                  enabled: !_loading && _history.canGoBack,
                  child: const Text('Previous search'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  enabled: !_loading && _history.canGoForward,
                  child: const Text('Next search'),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 2,
                  enabled: _queryController.text.trim().isNotEmpty,
                  child: const Text('Save current search'),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  enabled: _activeSavedSearchName != null,
                  child: const Text('Delete selected saved search'),
                ),
                if (_savedSearches.isNotEmpty) const PopupMenuDivider(),
                for (var index = 0; index < _savedSearches.length; index++)
                  PopupMenuItem<int>(
                    value: index + 4,
                    enabled: !_loading,
                    child: Text('Load: ${_savedSearches[index].name}'),
                  ),
              ],
              onSelected: (choice) {
                switch (choice) {
                  case 0:
                    _navigateSearchHistory(forward: false);
                  case 1:
                    _navigateSearchHistory(forward: true);
                  case 2:
                    unawaited(_saveNamedSearch());
                  case 3:
                    unawaited(_deleteSavedSearch());
                  default:
                    final index = choice - 4;
                    if (index >= 0 && index < _savedSearches.length) {
                      unawaited(_applySavedSearch(_savedSearches[index].name));
                    }
                }
              },
            )
          else ...[
          IconButton(
            key: const ValueKey('browser-search-history-back'),
            tooltip: 'Previous search',
            onPressed: _loading ||
                    _bulkActionInProgress ||
                    !_history.canGoBack
                ? null
                : () => _navigateSearchHistory(forward: false),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          IconButton(
            key: const ValueKey('browser-search-history-forward'),
            tooltip: 'Next search',
            onPressed: _loading ||
                    _bulkActionInProgress ||
                    !_history.canGoForward
                ? null
                : () => _navigateSearchHistory(forward: true),
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          PopupMenuButton<String>(
            key: const ValueKey('browser-saved-search-picker'),
            tooltip: 'Load saved search',
            icon: const Icon(Icons.bookmarks_outlined),
            enabled: !_loading &&
                !_bulkActionInProgress &&
                _savedSearches.isNotEmpty,
            itemBuilder: (_) => [
              for (final entry in _savedSearches)
                PopupMenuItem<String>(
                  value: entry.name,
                  child: Text(entry.name),
                ),
            ],
            onSelected: (name) => unawaited(_applySavedSearch(name)),
          ),
          IconButton(
            key: const ValueKey('browser-save-search'),
            tooltip: 'Save current search',
            onPressed: _bulkActionInProgress ||
                    _queryController.text.trim().isEmpty
                ? null
                : () => unawaited(_saveNamedSearch()),
            icon: const Icon(Icons.bookmark_add_outlined),
          ),
          IconButton(
            key: const ValueKey('browser-delete-saved-search'),
            tooltip: 'Delete selected saved search',
            onPressed: _activeSavedSearchName == null ||
                    _bulkActionInProgress
                ? null
                : () => unawaited(_deleteSavedSearch()),
            icon: const Icon(Icons.delete_outline),
          ),
          ],
        ],
      ),
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
                        : () => unawaited(
                            _search(
                              clearSelection: true,
                              recordHistory: true,
                            ),
                          ),
                    icon: const Icon(Icons.search),
                  ),
                ),
                onSubmitted: (_) {
                  if (!_bulkActionInProgress) {
                    unawaited(
                      _search(clearSelection: true, recordHistory: true),
                    );
                  }
                },
                onChanged: (_) => setState(() => _activeSavedSearchName = null),
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
    final canSelectAllMatches =
        _result!.matchingCardIds.length == _result!.totalCount &&
        _result!.totalCount > cards.length;
    final allMatchingSelected = canSelectAllMatches &&
        _result!.matchingCardIds.every(_selectedCardIds.contains);
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
            if (canSelectAllMatches)
              TextButton.icon(
                key: const ValueKey('browser-select-all-matches'),
                onPressed: allMatchingSelected || _bulkActionInProgress
                    ? null
                    : _selectAllMatchingCards,
                icon: const Icon(Icons.done_all),
                label: Text('Select all matches (${_result!.totalCount})'),
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
              if (widget.cardExporter != null)
                OutlinedButton(
                  key: const ValueKey('browser-export-selected'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_exportSelectedCards()),
                  child: const Text('Export selected'),
                ),
              if (widget.repository is CardBrowserRestoreRepository)
                OutlinedButton(
                  key: const ValueKey('browser-restore-selected'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_restoreSelectedCards()),
                  child: const Text('Restore selected'),
                ),
              if (widget.repository is CardBrowserForgetRepository)
                OutlinedButton(
                  key: const ValueKey('browser-forget-selected'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_forgetSelectedCards()),
                  child: const Text('Forget selected'),
                ),
              if (widget.repository is CardBrowserRepositionRepository)
                OutlinedButton(
                  key: const ValueKey('browser-reposition-selected'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_repositionSelectedCards()),
                  child: const Text('Reposition new'),
                ),
              if (widget.repository is CardBrowserSetDueDateRepository)
                OutlinedButton(
                  key: const ValueKey('browser-set-due'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_setSelectedCardsDueDate()),
                  child: const Text('Set due date'),
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
              if (widget.repository is CardBrowserFindReplaceRepository)
                OutlinedButton(
                  key: const ValueKey('browser-find-replace'),
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_findReplaceSelected()),
                  child: const Text('Find & replace'),
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
            child: canLoadMore
                ? Column(
                    children: [
                      Text(
                        'Showing ${result.cards.length} of ${result.totalCount} matches.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
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
                      ),
                    ],
                  )
                : Text(
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
          onTap: widget.previewRepository == null ||
                  _loading ||
                  _bulkActionInProgress
              ? null
              : () => unawaited(_previewCard(card.cardId)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.cardInfoRepository != null)
                IconButton(
                  key: ValueKey('browser-card-info-${card.cardId}'),
                  tooltip: 'Card info',
                  onPressed: _loading || _bulkActionInProgress
                      ? null
                      : () => unawaited(_openCardInfo(card.cardId)),
                  icon: const Icon(Icons.info_outline),
                ),
              IconButton(
                tooltip: 'Edit note',
                onPressed: _bulkActionInProgress
                    ? null
                    : () => unawaited(_editNote(card.cardId)),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
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

class _BrowserCardExportOptions {
  const _BrowserCardExportOptions({
    required this.withScheduling,
    required this.withMedia,
  });

  final bool withScheduling;
  final bool withMedia;
}

class _BrowserCardExportDialog extends StatefulWidget {
  const _BrowserCardExportDialog({required this.cardCount});

  final int cardCount;

  @override
  State<_BrowserCardExportDialog> createState() => _BrowserCardExportDialogState();
}

class _BrowserCardExportDialogState extends State<_BrowserCardExportDialog> {
  bool _withScheduling = true;
  bool _withMedia = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Export selected cards'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Save ${widget.cardCount} selected '
              '${widget.cardCount == 1 ? 'card' : 'cards'} '
              'to an Anki package (.apkg).',
            ),
            SwitchListTile(
              key: const ValueKey('browser-export-scheduling'),
              contentPadding: EdgeInsets.zero,
              title: const Text('Include scheduling'),
              value: _withScheduling,
              onChanged: (value) => setState(() => _withScheduling = value),
            ),
            SwitchListTile(
              key: const ValueKey('browser-export-media'),
              contentPadding: EdgeInsets.zero,
              title: const Text('Include media'),
              value: _withMedia,
              onChanged: (value) => setState(() => _withMedia = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const ValueKey('browser-confirm-export'),
          onPressed: () => Navigator.of(context).pop(
            _BrowserCardExportOptions(
              withScheduling: _withScheduling,
              withMedia: _withMedia,
            ),
          ),
          child: const Text('Export'),
        ),
      ],
    );
  }
}

class _BrowserRepositionDialog extends StatefulWidget {
  const _BrowserRepositionDialog({
    required this.cardCount,
    required this.defaults,
  });

  final int cardCount;
  final CardBrowserRepositionDefaults defaults;

  @override
  State<_BrowserRepositionDialog> createState() =>
      _BrowserRepositionDialogState();
}

class _BrowserRepositionDialogState extends State<_BrowserRepositionDialog> {
  final TextEditingController _startingFrom = TextEditingController(text: '1');
  final TextEditingController _stepSize = TextEditingController(text: '1');
  late bool _randomize;
  late bool _shiftExisting;

  @override
  void initState() {
    super.initState();
    _randomize = widget.defaults.randomize;
    _shiftExisting = widget.defaults.shiftExisting;
  }

  @override
  void dispose() {
    _startingFrom.dispose();
    _stepSize.dispose();
    super.dispose();
  }

  int? _positiveUint32(String text) {
    final value = int.tryParse(text.trim());
    return value == null || value < 1 || value > 0xffffffff ? null : value;
  }

  void _confirm() {
    final start = _positiveUint32(_startingFrom.text);
    final step = _positiveUint32(_stepSize.text);
    if (start == null || step == null) return;
    Navigator.of(context).pop(
      CardBrowserRepositionOptions(
        startingFrom: start,
        stepSize: step,
        randomize: _randomize,
        shiftExisting: _shiftExisting,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final startValid = _positiveUint32(_startingFrom.text) != null;
    final stepValid = _positiveUint32(_stepSize.text) != null;
    return AlertDialog(
      title: Text(
        'Reposition ${widget.cardCount} selected '
        '${widget.cardCount == 1 ? 'card' : 'cards'}?',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Only new cards are repositioned, in browser order. '
              'Review and learning cards are unchanged.',
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const ValueKey('browser-reposition-start'),
              controller: _startingFrom,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Starting position',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const ValueKey('browser-reposition-step'),
              controller: _stepSize,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Step size',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Randomize selected order'),
              value: _randomize,
              onChanged: (value) =>
                  setState(() => _randomize = value ?? false),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Shift existing new cards'),
              value: _shiftExisting,
              onChanged: (value) =>
                  setState(() => _shiftExisting = value ?? false),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const ValueKey('browser-confirm-reposition'),
          onPressed: startValid && stepValid ? _confirm : null,
          child: const Text('Reposition'),
        ),
      ],
    );
  }
}

class _SaveBrowserSearchDialog extends StatefulWidget {
  const _SaveBrowserSearchDialog();

  @override
  State<_SaveBrowserSearchDialog> createState() => _SaveBrowserSearchDialogState();
}

class _SaveBrowserSearchDialogState extends State<_SaveBrowserSearchDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = _nameController.text.trim();
    return AlertDialog(
      title: const Text('Save current search'),
      content: TextField(
        key: const ValueKey('browser-saved-search-name'),
        controller: _nameController,
        autofocus: true,
        maxLength: 80,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          labelText: 'Search name',
          border: OutlineInputBorder(),
        ),
        onChanged: (_) => setState(() {}),
        onSubmitted: (_) {
          if (name.isNotEmpty) Navigator.of(context).pop(name);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const ValueKey('browser-confirm-save-search'),
          onPressed: name.isEmpty ? null : () => Navigator.of(context).pop(name),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
