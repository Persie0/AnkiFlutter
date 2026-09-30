import 'dart:async';

import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_state.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:anki_flutter/features/decks/data/deck_mutation_repository.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/add_note_page.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:flutter/material.dart';

typedef CollectionPicker = Future<String?> Function();
typedef CollectionOpener = Future<void> Function(String path);
typedef CollectionCloser = Future<void> Function();

class DeckListPage extends StatefulWidget {
  const DeckListPage({
    required this.controller,
    required this.pickCollection,
    required this.openCollection,
    this.closeCollection,
    this.collectionIsOpen,
    this.backend,
    this.mediaBaseUri,
    this.reviewControllerBuilder,
    this.startupError,
    super.key,
  });

  final DeckListController controller;
  final CollectionPicker pickCollection;
  final CollectionOpener openCollection;
  final CollectionCloser? closeCollection;
  final bool Function()? collectionIsOpen;
  final BackendInvoker? backend;
  final Uri? Function()? mediaBaseUri;
  final ReviewControllerBuilder? reviewControllerBuilder;
  final Object? startupError;

  @override
  State<DeckListPage> createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  bool _opening = false;
  bool _collectionOpened = false;
  String? _collectionErrorMessage;

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

      await widget.openCollection(path);
      if (!mounted) {
        return;
      }
      setState(() {
        _opening = false;
        _collectionOpened = true;
      });
      await widget.controller.load();
    } catch (error) {
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

  void _openDeck(DeckNode deck) {
    Navigator.of(context).push(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnkiFlutter'),
        actions: [
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
              tooltip: 'Browse cards',
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => CardBrowserPage(
                      repository: AnkiCardBrowserRepository(
                        backend: widget.backend!,
                      ),
                      noteRepository: AnkiNoteRepository(
                        backend: widget.backend!,
                      ),
                    ),
                  ),
                );
              },
            ),
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton.icon(
                onPressed: _chooseCollection,
                icon: const Icon(Icons.folder_open),
                label: const Text('Open Anki Collection'),
              ),
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

class _DeckTree extends StatelessWidget {
  const _DeckTree({required this.decks, required this.onDeckTap});

  final List<DeckNode> decks;
  final ValueChanged<DeckNode> onDeckTap;

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
              ? const Center(child: Text('No decks'))
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
