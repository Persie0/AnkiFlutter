import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:flutter/material.dart';
import 'package:anki_flutter/features/reviewer/data/anki_card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';

class DeckOverviewPage extends StatefulWidget {
  const DeckOverviewPage({
    required this.deck,
    this.backend,
    this.mediaBaseUri,
    this.onRename,
    this.onRemove,
    this.onChanged,
    super.key,
  });

  final DeckNode deck;
  final BackendInvoker? backend;
  final Uri? mediaBaseUri;
  final Future<void> Function(String name)? onRename;
  final Future<void> Function()? onRemove;
  final Future<void> Function()? onChanged;

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
              onPressed: () => Navigator.of(context).pop(controller.text.trim()),
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
    final backend = widget.backend;
    if (backend == null) return;
    final controller = ReviewController(
      repository: AnkiReviewRepository(backend: backend),
      renderer: AnkiCardRenderRepository(backend: backend),
      wallClockMillis: () => DateTime.now().millisecondsSinceEpoch,
      stopwatchFactory: Stopwatch.new,
    );
    _reviewController = controller;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ReviewPage(
          controller: controller,
          mediaBaseUri: widget.mediaBaseUri,
          onFinished: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
    controller.start(widget.deck.id);
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
                onPressed: widget.backend == null ? null : _study,
                child: const Text('Study'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
