import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const deck = DeckNode(
    id: 19,
    name: 'French::Verbs',
    newCount: 8,
    learnCount: 2,
    reviewCount: 11,
    filtered: false,
    children: [],
  );

  testWidgets('deck overview opens native Anki search for each card category', (
    tester,
  ) async {
    final queries = <String>[];
    await tester.pumpWidget(
      MaterialApp(
        home: DeckOverviewPage(
          deck: deck,
          onBrowse: queries.add,
        ),
      ),
    );
    await tester.pumpAndSettle();

    Future<void> select(String label) async {
      await tester.tap(find.byKey(const ValueKey('deck-browse-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
    }

    await select('All cards in deck');
    await select('Due cards in deck');
    await select('New cards in deck');
    await select('Suspended cards in deck');

    expect(queries, [
      'deck:"French::Verbs"',
      'deck:"French::Verbs" is:due',
      'deck:"French::Verbs" is:new',
      'deck:"French::Verbs" is:suspended',
    ]);
    expect(find.text('French::Verbs'), findsOneWidget);
    expect(find.text('Study'), findsOneWidget);
  });

  testWidgets('quoted and escaped deck name cannot leak out of deck filter', (
    tester,
  ) async {
    final queries = <String>[];
    await tester.pumpWidget(
      MaterialApp(
        home: DeckOverviewPage(
          deck: const DeckNode(
            id: 20,
            name: r'Languages\A "Deck"',
            newCount: 0,
            learnCount: 0,
            reviewCount: 0,
            filtered: false,
            children: [],
          ),
          onBrowse: queries.add,
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('deck-browse-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Due cards in deck'));
    await tester.pumpAndSettle();

    expect(queries.single, r'deck:"Languages\\A \"Deck\"" is:due');
  });

  testWidgets('deck browser entry is hidden when no navigation capability', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: DeckOverviewPage(deck: deck)),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('deck-browse-menu')), findsNothing);
    expect(find.text('Study'), findsOneWidget);
  });
}
