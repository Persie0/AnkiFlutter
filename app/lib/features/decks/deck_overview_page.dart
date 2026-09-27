import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:flutter/material.dart';
import 'package:anki_flutter/features/reviewer/data/anki_card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';

class DeckOverviewPage extends StatefulWidget {
  const DeckOverviewPage({required this.deck, this.backend, super.key});

  final DeckNode deck;
  final BackendInvoker? backend;

  @override
  State<DeckOverviewPage> createState() => _DeckOverviewPageState();
}

class _DeckOverviewPageState extends State<DeckOverviewPage> {
  ReviewController? _reviewController;

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
      appBar: AppBar(title: Text(deck.name)),
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
