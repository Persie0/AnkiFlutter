import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:flutter/material.dart';

class DeckOverviewPage extends StatelessWidget {
  const DeckOverviewPage({required this.deck, super.key});

  final DeckNode deck;

  @override
  Widget build(BuildContext context) {
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
              Tooltip(
                message: 'Reviewer coming next',
                child: FilledButton(
                  onPressed: null,
                  child: const Text('Study'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
