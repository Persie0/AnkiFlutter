import 'dart:async';

import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_state.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:flutter/material.dart';

typedef CollectionPicker = Future<String?> Function();
typedef CollectionOpener = Future<void> Function(String path);

class DeckListPage extends StatefulWidget {
  const DeckListPage({
    required this.controller,
    required this.pickCollection,
    required this.openCollection,
    this.startupError,
    super.key,
  });

  final DeckListController controller;
  final CollectionPicker pickCollection;
  final CollectionOpener openCollection;
  final Object? startupError;

  @override
  State<DeckListPage> createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  bool _opening = false;
  bool _collectionOpened = false;
  Object? _collectionError;

  Future<void> _chooseCollection() async {
    setState(() {
      _opening = true;
      _collectionError = null;
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
        _collectionError = error;
      });
    }
  }

  void _openDeck(DeckNode deck) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => DeckOverviewPage(deck: deck)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnkiFlutter')),
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
              if (_collectionError case final error?) ...[
                const SizedBox(height: 16),
                Text(
                  'Could not open collection: $error',
                  key: const ValueKey('collection-error'),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return switch (widget.controller.state) {
          DeckListInitial() || DeckListLoading() =>
            const Center(child: CircularProgressIndicator()),
          DeckListFailure(:final error) => _CenteredMessage(
              icon: Icons.error_outline,
              title: 'Could not load decks',
              message: error.toString(),
              action: FilledButton.tonal(
                onPressed: () => unawaited(widget.controller.load()),
                child: const Text('Retry'),
              ),
            ),
          DeckListReady(:final decks) =>
            _DeckTree(decks: decks, onDeckTap: _openDeck),
        };
      },
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
                child: Text('Decks', style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(width: 56, child: Text('New', textAlign: TextAlign.end)),
              const SizedBox(width: 56, child: Text('Learn', textAlign: TextAlign.end)),
              const SizedBox(width: 64, child: Text('Review', textAlign: TextAlign.end)),
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
                SizedBox(width: 56, child: Text('${node.newCount}', textAlign: TextAlign.end)),
                SizedBox(width: 56, child: Text('${node.learnCount}', textAlign: TextAlign.end)),
                SizedBox(width: 64, child: Text('${node.reviewCount}', textAlign: TextAlign.end)),
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
