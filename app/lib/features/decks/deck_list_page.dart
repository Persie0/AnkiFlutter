import 'dart:async';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/browser_card_export.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/collection/recent_collection_store.dart';
import 'package:anki_flutter/features/collection/data/anki_collection_history_repository.dart';
import 'package:anki_flutter/features/collection/data/anki_database_check_repository.dart';
import 'package:anki_flutter/features/collection/check_database_page.dart';
import 'package:anki_flutter/features/decks/data/deck_mutation_repository.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_state.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:anki_flutter/features/import_export/native_package_file_transfer.dart';
import 'package:anki_flutter/features/import_export/package_transfer_page.dart';
import 'package:anki_flutter/features/media/check_media_page.dart';
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:anki_flutter/features/notes/add_note_page.dart';
import 'package:anki_flutter/features/notes/note_editor_page.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/features/notetypes/data/anki_notetype_repository.dart';
import 'package:anki_flutter/features/notetypes/notetype_list_page.dart';
import 'package:anki_flutter/features/preferences/data/anki_preferences_repository.dart';
import 'package:anki_flutter/features/preferences/preferences_page.dart';
import 'package:anki_flutter/features/statistics/data/anki_statistics_repository.dart';
import 'package:anki_flutter/features/statistics/statistics_page.dart';
import 'package:anki_flutter/features/sync/data/anki_sync_repository.dart';
import 'package:anki_flutter/features/sync/data/sync_auth_store.dart';
import 'package:anki_flutter/features/sync/sync_page.dart';
import 'package:flutter/material.dart';

typedef CollectionPicker = Future<String?> Function();
typedef CollectionOpener = Future<void> Function(String path);
typedef CollectionCloser = Future<void> Function();

enum _CollectionAction {
  statistics,
  preferences,
  noteTypes,
  importExport,
  mediaCheck,
  databaseCheck,
  sync,
  browse,
}

class DeckListPage extends StatefulWidget {
  const DeckListPage({
    required this.controller,
    required this.pickCollection,
    required this.openCollection,
    this.closeCollection,
    this.collectionIsOpen,
    this.recentCollectionsStore,
    this.backend,
    this.mediaBaseUri,
    this.browserStateStore,
    this.reviewControllerBuilder,
    this.startupError,
    super.key,
  });

  final DeckListController controller;
  final CollectionPicker pickCollection;
  final CollectionOpener openCollection;
  final CollectionCloser? closeCollection;
  final bool Function()? collectionIsOpen;
  final RecentCollectionStore? recentCollectionsStore;
  final BackendInvoker? backend;
  final Uri? Function()? mediaBaseUri;
  final BrowserStateStore? browserStateStore;
  final ReviewControllerBuilder? reviewControllerBuilder;
  final Object? startupError;

  @override
  State<DeckListPage> createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  bool _opening = false;
  bool _collectionOpened = false;
  String? _collectionErrorMessage;
  List<String> _recentCollections = const [];
  CollectionHistoryStatus _historyStatus = const CollectionHistoryStatus(
    undoLabel: '',
    redoLabel: '',
  );
  bool _historyBusy = false;
  int _historyGeneration = 0;

  Future<void> _refreshHistory() async {
    final backend = widget.backend;
    if (!_collectionOpened || backend == null) return;
    final generation = ++_historyGeneration;
    try {
      final status = await AnkiCollectionHistoryRepository(
        backend: backend,
      ).status();
      if (!mounted || generation != _historyGeneration) return;
      setState(() => _historyStatus = status);
    } catch (_) {
      // Undo history must not block normal collection workflows.
      if (!mounted || generation != _historyGeneration) return;
      setState(() => _historyStatus = const CollectionHistoryStatus(
        undoLabel: '',
        redoLabel: '',
      ));
    }
  }

  Future<void> _changeHistory({required bool redo}) async {
    final backend = widget.backend;
    if (backend == null || !_collectionOpened || _historyBusy || _opening) {
      return;
    }
    if (redo ? !_historyStatus.canRedo : !_historyStatus.canUndo) return;
    setState(() => _historyBusy = true);
    final generation = ++_historyGeneration;
    try {
      final repository = AnkiCollectionHistoryRepository(backend: backend);
      final status = redo ? await repository.redo() : await repository.undo();
      if (!mounted || generation != _historyGeneration) return;
      setState(() => _historyStatus = status);
      await widget.controller.load();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not ${redo ? 'redo' : 'undo'}: $error')),
      );
      await _refreshHistory();
    } finally {
      if (mounted) {
        setState(() => _historyBusy = false);
      }
    }
  }

  Future<void> _onReturnedFromCollectionScreen() async {
    if (!mounted || !_collectionOpened) return;
    await _refreshHistory();
    if (mounted) await widget.controller.load();
  }


  @override
  void initState() {
    super.initState();
    unawaited(_loadRecentCollections());
  }

  Future<void> _loadRecentCollections() async {
    final store = widget.recentCollectionsStore;
    if (store == null) {
      return;
    }
    try {
      final paths = await store.load();
      if (mounted) {
        setState(() => _recentCollections = paths);
      }
    } catch (_) {
      // Recent paths are a convenience; opening a collection must still work.
    }
  }

  Future<void> _chooseCollection() async {
    final wasOpen = _collectionOpened;
    setState(() {
      _opening = true;
      _collectionErrorMessage = null;
    });

    try {
      final path = await widget.pickCollection();
      if (!mounted) {
        return;
      }
      if (path == null) {
        setState(() => _opening = false);
        return;
      }

      await _activateCollection(path);
    } catch (error) {
      _reportOpenFailure(error, wasOpen: wasOpen);
    }
  }

  Future<void> _openRecentCollection(String path) async {
    if (_opening) {
      return;
    }
    final wasOpen = _collectionOpened;
    setState(() {
      _opening = true;
      _collectionErrorMessage = null;
    });
    try {
      await _activateCollection(path);
    } catch (error) {
      _reportOpenFailure(error, wasOpen: wasOpen);
    }
  }

  Future<void> _activateCollection(String path) async {
    await widget.openCollection(path);
    if (!mounted) {
      return;
    }
    setState(() {
      _opening = false;
      _collectionOpened = true;
    });
    await widget.controller.load();
    await _refreshHistory();
    final store = widget.recentCollectionsStore;
    if (store != null) {
      try {
        await store.remember(path);
        await _loadRecentCollections();
      } catch (error) {
        if (mounted) {
          setState(
            () => _collectionErrorMessage =
                'Could not update recent collections: $error',
          );
        }
      }
    }
  }

  void _reportOpenFailure(Object error, {required bool wasOpen}) {
    if (!mounted) {
      return;
    }
    setState(() {
      _opening = false;
      _collectionErrorMessage = wasOpen
          ? 'Could not switch collection: $error'
          : 'Could not open collection: $error';
      _collectionOpened = widget.collectionIsOpen?.call() ?? wasOpen;
    });
    if (wasOpen) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(_collectionErrorMessage!)),
      );
    }
  }

  Future<void> _forgetRecentCollection(String path) async {
    final store = widget.recentCollectionsStore;
    if (store == null) {
      return;
    }
    try {
      await store.forget(path);
      await _loadRecentCollections();
    } catch (error) {
      if (mounted) {
        setState(
          () => _collectionErrorMessage =
              'Could not remove recent collection: $error',
        );
      }
    }
  }

  Future<void> _closeCollection() async {
    final closeCollection = widget.closeCollection;
    if (closeCollection == null) {
      return;
    }
    setState(() {
      _opening = true;
      _collectionErrorMessage = null;
    });
    try {
      await closeCollection();
      if (!mounted) {
        return;
      }
      setState(() {
        _opening = false;
        _collectionOpened = false;
        _historyStatus = const CollectionHistoryStatus(undoLabel: '', redoLabel: '');
        _historyGeneration++;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _opening = false;
        _collectionErrorMessage = 'Could not close collection: $error';
        _collectionOpened = widget.collectionIsOpen?.call() ?? true;
      });
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(_collectionErrorMessage!)),
      );
    }
  }

  Future<void> _createDeck() async {
    final backend = widget.backend;
    if (backend == null) {
      return;
    }
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => _CreateDeckDialog(
        onCreate: (name) =>
            DeckMutationRepository(backend: backend).addDeck(name),
      ),
    );
    if (created == true && mounted) {
      await widget.controller.load();
      await _refreshHistory();
    }
  }

  void _openCollectionStatistics() {
    final backend = widget.backend;
    if (backend == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StatisticsPage(
          repository: AnkiStatisticsRepository(backend: backend),
        ),
      ),
    );
  }

  void _openPreferences() {
    final backend = widget.backend;
    if (backend == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PreferencesPage(
          repository: AnkiPreferencesRepository(backend: backend),
        ),
      ),
    );
  }

  void _openNotetypes() {
    final backend = widget.backend;
    if (backend == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NotetypeListPage(
          repository: AnkiNotetypeRepository(backend: backend),
        ),
      ),
    );
  }

  void _openImportExport() {
    final backend = widget.backend;
    if (backend == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PackageTransferPage(
          repository: AnkiPackageRepository(backend: backend),
          fileTransfer: NativePackageFileTransfer(),
          onCollectionChanged: widget.controller.load,
        ),
      ),
    );
  }

  void _openMediaCheck() {
    final backend = widget.backend;
    if (backend == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CheckMediaPage(
          repository: AnkiMediaRepository(backend: backend),
          onOpenNote: (noteId) => Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(
              builder: (_) => NoteEditorPage.edit(
                noteId: noteId,
                repository: AnkiNoteRepository(backend: backend),
              ),
            ),
          ),
          onBrowseAffectedNotes: (noteIds) {
            // Use Anki's native note-ID search syntax. Every result remains
            // editable through the existing browser and note editor.
            _openBrowser(
              initialQuery: noteIds.map((id) => 'nid:$id').join(' or '),
            );
          },
        ),
      ),
    );
  }

  void _openDatabaseCheck() {
    final backend = widget.backend;
    if (backend == null) return;
    unawaited(Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CheckDatabasePage(
          repository: AnkiDatabaseCheckRepository(backend: backend),
          onCollectionChanged: () async {
            await widget.controller.load();
            await _refreshHistory();
          },
        ),
      ),
    ).then((_) => _onReturnedFromCollectionScreen()));
  }

  void _openSync() {
    final backend = widget.backend;
    if (backend == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SyncPage(
          repository: AnkiSyncRepository(backend: backend),
          authStore: FileSyncAuthStore(),
          onCollectionChanged: widget.controller.load,
        ),
      ),
    );
  }

  void _openBrowser({String? initialQuery}) {
    final backend = widget.backend;
    if (backend == null) return;
    unawaited(Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CardBrowserPage(
          initialQuery: initialQuery,
          stateStore: widget.browserStateStore,
          repository: AnkiCardBrowserRepository(backend: backend),
          noteRepository: AnkiNoteRepository(backend: backend),
          cardExporter: NativeBrowserCardExporter(
            repository: AnkiPackageRepository(backend: backend),
            fileTransfer: NativePackageFileTransfer(),
          ),
        ),
      ),
    ).then((_) => _onReturnedFromCollectionScreen()));
  }

  void _runCollectionAction(_CollectionAction action) {
    switch (action) {
      case _CollectionAction.statistics:
        _openCollectionStatistics();
        break;
      case _CollectionAction.preferences:
        _openPreferences();
        break;
      case _CollectionAction.noteTypes:
        _openNotetypes();
        break;
      case _CollectionAction.importExport:
        _openImportExport();
        break;
      case _CollectionAction.mediaCheck:
        _openMediaCheck();
        break;
      case _CollectionAction.databaseCheck:
        _openDatabaseCheck();
        break;
      case _CollectionAction.sync:
        _openSync();
        break;
      case _CollectionAction.browse:
        _openBrowser();
        break;
    }
  }

  void _openDeck(DeckNode deck) {
    unawaited(Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DeckOverviewPage(
          deck: deck,
          backend: widget.backend,
          mediaBaseUri: widget.mediaBaseUri?.call(),
          reviewControllerBuilder: widget.reviewControllerBuilder,
          onRename: widget.backend == null
              ? null
              : (name) =>
                    DeckMutationRepository(backend: widget.backend!)
                        .renameDeck(deck.id, name),
          onRemove: widget.backend == null
              ? null
              : () =>
                    DeckMutationRepository(backend: widget.backend!)
                        .removeDecks([deck.id]),
          onChanged: widget.controller.load,
          onAddNote: widget.backend == null
              ? null
              : () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => AddNotePage(
                        deck: deck,
                        repository: AnkiNoteRepository(
                          backend: widget.backend!,
                        ),
                      ),
                    ),
                  );
                },
        ),
      ),
    ).then((_) => _onReturnedFromCollectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final compactToolbar = MediaQuery.sizeOf(context).width < 700;
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnkiFlutter'),
        actions: [
          if (_collectionOpened && widget.backend != null) ...[
            IconButton(
              key: const ValueKey('collection-undo'),
              tooltip: _historyStatus.canUndo
                  ? 'Undo ${_historyStatus.undoLabel}'
                  : 'Undo',
              icon: const Icon(Icons.undo),
              onPressed: _opening || _historyBusy || !_historyStatus.canUndo
                  ? null
                  : () => unawaited(_changeHistory(redo: false)),
            ),
            IconButton(
              key: const ValueKey('collection-redo'),
              tooltip: _historyStatus.canRedo
                  ? 'Redo ${_historyStatus.redoLabel}'
                  : 'Redo',
              icon: const Icon(Icons.redo),
              onPressed: _opening || _historyBusy || !_historyStatus.canRedo
                  ? null
                  : () => unawaited(_changeHistory(redo: true)),
            ),
          ],
          if (_collectionOpened) ...[
            IconButton(
              tooltip: 'Switch collection',
              icon: const Icon(Icons.folder_open),
              onPressed: _opening ? null : _chooseCollection,
            ),
            if (widget.closeCollection != null)
              IconButton(
                tooltip: 'Close collection',
                icon: const Icon(Icons.close),
                onPressed: _opening ? null : _closeCollection,
              ),
          ],
          if (_collectionOpened && widget.backend != null)
            IconButton(
              tooltip: 'Create deck',
              icon: const Icon(Icons.add),
              onPressed: _opening ? null : _createDeck,
            ),
          if (_collectionOpened && widget.backend != null && compactToolbar)
            PopupMenuButton<_CollectionAction>(
              tooltip: 'More actions',
              icon: const Icon(Icons.more_vert),
              enabled: !_opening,
              onSelected: _runCollectionAction,
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _CollectionAction.statistics,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.bar_chart_outlined),
                    title: Text('Collection statistics'),
                  ),
                ),
                PopupMenuItem(
                  value: _CollectionAction.preferences,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.settings_outlined),
                    title: Text('Preferences'),
                  ),
                ),
                PopupMenuItem(
                  value: _CollectionAction.noteTypes,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.view_agenda_outlined),
                    title: Text('Manage note types'),
                  ),
                ),
                PopupMenuItem(
                  value: _CollectionAction.importExport,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.import_export),
                    title: Text('Import & export'),
                  ),
                ),
                PopupMenuItem(
                  value: _CollectionAction.mediaCheck,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.fact_check_outlined),
                    title: Text('Check media'),
                  ),
                ),
                PopupMenuItem(
                  value: _CollectionAction.databaseCheck,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.build_circle_outlined),
                    title: Text('Check database'),
                  ),
                ),
                PopupMenuItem(
                  value: _CollectionAction.sync,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.sync),
                    title: Text('Sync'),
                  ),
                ),
                PopupMenuItem(
                  value: _CollectionAction.browse,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.search),
                    title: Text('Browse cards'),
                  ),
                ),
              ],
            ),
          if (_collectionOpened &&
              widget.backend != null &&
              !compactToolbar) ...[
            IconButton(
              tooltip: 'Collection statistics',
              icon: const Icon(Icons.bar_chart_outlined),
              onPressed: _opening ? null : _openCollectionStatistics,
            ),
            IconButton(
              tooltip: 'Preferences',
              icon: const Icon(Icons.settings_outlined),
              onPressed: _opening ? null : _openPreferences,
            ),
            IconButton(
              tooltip: 'Manage note types',
              icon: const Icon(Icons.view_agenda_outlined),
              onPressed: _opening ? null : _openNotetypes,
            ),
            IconButton(
              tooltip: 'Import & export',
              icon: const Icon(Icons.import_export),
              onPressed: _opening ? null : _openImportExport,
            ),
            IconButton(
              tooltip: 'Check media',
              icon: const Icon(Icons.fact_check_outlined),
              onPressed: _opening ? null : _openMediaCheck,
            ),
            IconButton(
              tooltip: 'Check database',
              icon: const Icon(Icons.build_circle_outlined),
              onPressed: _opening ? null : _openDatabaseCheck,
            ),
            IconButton(
              tooltip: 'Sync',
              icon: const Icon(Icons.sync),
              onPressed: _opening ? null : _openSync,
            ),
            IconButton(
              tooltip: 'Browse cards',
              icon: const Icon(Icons.search),
              onPressed: _opening ? null : _openBrowser,
            ),
          ],
        ],
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    final startupError = widget.startupError;
    if (startupError != null) {
      return _CenteredMessage(
        icon: Icons.error_outline,
        title: 'Anki backend unavailable',
        message: startupError.toString(),
      );
    }

    if (!_collectionOpened) {
      if (_opening) {
        return const Center(child: CircularProgressIndicator());
      }
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 52,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Open an Anki profile',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose an existing profile or collection, or create a new profile to get started.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _chooseCollection,
                  icon: const Icon(Icons.folder_open),
                  label: const Text('Open Anki Collection'),
                ),
                if (_recentCollections.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Recent collections',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final path in _recentCollections)
                    ListTile(
                      key: ValueKey('recent-collection-$path'),
                      leading: const Icon(Icons.history),
                      title: Text(_collectionLabel(path)),
                      subtitle: Text(path),
                      onTap: _opening ? null : () => _openRecentCollection(path),
                      trailing: IconButton(
                        tooltip: 'Forget ${_collectionLabel(path)}',
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => _forgetRecentCollection(path),
                      ),
                    ),
                ],
                if (_collectionErrorMessage case final error?) ...[
                  const SizedBox(height: 16),
                  Text(
                    error,
                    key: const ValueKey('collection-error'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    final deckContent = AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return switch (widget.controller.state) {
          DeckListInitial() ||
          DeckListLoading() => const Center(child: CircularProgressIndicator()),
          DeckListFailure(:final error) => _CenteredMessage(
            icon: Icons.error_outline,
            title: 'Could not load decks',
            message: error.toString(),
            action: FilledButton.tonal(
              onPressed: () => unawaited(widget.controller.load()),
              child: const Text('Retry'),
            ),
          ),
          DeckListReady(:final decks) => _DeckTree(
            decks: decks,
            onDeckTap: _openDeck,
            onCreateDeck: widget.backend == null ? null : _createDeck,
          ),
        };
      },
    );
    final error = _collectionErrorMessage;
    if (error == null) {
      return deckContent;
    }
    return Column(
      children: [
        MaterialBanner(
          key: const ValueKey('collection-operation-error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => setState(() => _collectionErrorMessage = null),
              child: const Text('Dismiss'),
            ),
          ],
        ),
        Expanded(child: deckContent),
      ],
    );
  }
}

String _collectionLabel(String path) {
  final filename = path.split(RegExp(r'[/\\]')).last;
  return filename.replaceFirst(RegExp(r'\.anki2$', caseSensitive: false), '');
}

class _CreateDeckDialog extends StatefulWidget {
  const _CreateDeckDialog({required this.onCreate});

  final Future<int> Function(String name) onCreate;

  @override
  State<_CreateDeckDialog> createState() => _CreateDeckDialogState();
}

class _CreateDeckDialogState extends State<_CreateDeckDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _creating = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_creating || !(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() {
      _creating = true;
      _error = null;
    });
    try {
      await widget.onCreate(_nameController.text.trim());
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _creating = false;
          _error = 'Could not create deck: $error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create deck'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const ValueKey('create-deck-name'),
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Deck name'),
              textCapitalization: TextCapitalization.sentences,
              onFieldSubmitted: (_) => _submit(),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter a deck name'
                  : null,
            ),
            if (_error case final error?) ...[
              const SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _creating ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _creating ? null : _submit,
          child: _creating
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}

class _DeckTree extends StatelessWidget {
  const _DeckTree({
    required this.decks,
    required this.onDeckTap,
    this.onCreateDeck,
  });

  final List<DeckNode> decks;
  final ValueChanged<DeckNode> onDeckTap;
  final VoidCallback? onCreateDeck;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Decks',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                width: 56,
                child: Text('New', textAlign: TextAlign.end),
              ),
              const SizedBox(
                width: 56,
                child: Text('Learn', textAlign: TextAlign.end),
              ),
              const SizedBox(
                width: 64,
                child: Text('Review', textAlign: TextAlign.end),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: decks.isEmpty
              ? _CenteredMessage(
                  icon: Icons.layers_outlined,
                  title: 'No decks yet',
                  message: 'Create a deck to start adding and studying cards.',
                  action: onCreateDeck == null
                      ? null
                      : FilledButton.icon(
                          onPressed: onCreateDeck,
                          icon: const Icon(Icons.add),
                          label: const Text('Create your first deck'),
                        ),
                )
              : ListView(children: _rows(decks, 0)),
        ),
      ],
    );
  }

  List<Widget> _rows(List<DeckNode> nodes, int depth) {
    final rows = <Widget>[];
    for (final node in nodes) {
      rows.add(
        Padding(
          key: ValueKey('deck-row-${node.id}'),
          padding: EdgeInsets.only(left: 8 + depth * 24.0),
          child: ListTile(
            onTap: () => onDeckTap(node),
            title: Text(node.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 56,
                  child: Text('${node.newCount}', textAlign: TextAlign.end),
                ),
                SizedBox(
                  width: 56,
                  child: Text('${node.learnCount}', textAlign: TextAlign.end),
                ),
                SizedBox(
                  width: 64,
                  child: Text('${node.reviewCount}', textAlign: TextAlign.end),
                ),
              ],
            ),
          ),
        ),
      );
      rows.addAll(_rows(node.children, depth + 1));
    }
    return rows;
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            if (action case final action?) ...[
              const SizedBox(height: 16),
              action,
            ],
          ],
        ),
      ),
    );
  }
}
