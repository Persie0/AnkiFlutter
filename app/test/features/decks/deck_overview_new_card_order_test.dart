import 'dart:async';

import 'package:anki_flutter/features/decks/data/anki_deck_new_card_order_repository.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cancel never reorders; confirmed shuffle refreshes counts',
      (tester) async {
    final repository = _OrderRepository();
    var changes = 0;
    await tester.pumpWidget(_page(repository, onChanged: () async => changes++));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('deck-shuffle-new-cards')));
    await tester.pumpAndSettle();
    expect(find.text('Shuffle new cards?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repository.calls, isEmpty);

    await tester.tap(find.byKey(const ValueKey('deck-shuffle-new-cards')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-new-card-order')));
    await tester.pumpAndSettle();
    expect(repository.calls, [(23, true)]);
    expect(changes, 1);
    expect(find.text('Shuffled 3 new cards.'), findsOneWidget);
  });

  testWidgets('restore passes false and shows result', (tester) async {
    final repository = _OrderRepository();
    await tester.pumpWidget(_page(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('deck-restore-new-card-order')));
    await tester.pumpAndSettle();
    expect(find.text('Restore new-card order?'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('confirm-new-card-order')));
    await tester.pumpAndSettle();
    expect(repository.calls, [(23, false)]);
    expect(find.text('Restored order of 3 new cards.'), findsOneWidget);
  });

  testWidgets('pending sort disables both buttons', (tester) async {
    final repository = _OrderRepository();
    final result = Completer<int>();
    repository.pending = result.future;
    await tester.pumpWidget(_page(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('deck-shuffle-new-cards')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-new-card-order')));
    await tester.pump();
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('deck-shuffle-new-cards')),
      ).onPressed,
      isNull,
    );
    expect(
      tester.widget<TextButton>(
        find.byKey(const ValueKey('deck-restore-new-card-order')),
      ).onPressed,
      isNull,
    );
    result.complete(3);
    await tester.pumpAndSettle();
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('deck-shuffle-new-cards')),
      ).onPressed,
      isNotNull,
    );
  });

  testWidgets('native errors do not claim success', (tester) async {
    final repository = _OrderRepository()..fail = true;
    var changes = 0;
    await tester.pumpWidget(_page(repository, onChanged: () async => changes++));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('deck-shuffle-new-cards')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-new-card-order')));
    await tester.pumpAndSettle();
    expect(changes, 0);
    expect(find.textContaining('Could not reorder new cards:'), findsOneWidget);
  });

  testWidgets('filtered decks never expose new-card ordering', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DeckOverviewPage(
        deck: const DeckNode(
          id: 23, name: 'Filtered', newCount: 1,
          learnCount: 0, reviewCount: 0, filtered: true, children: [],
        ),
        newCardOrderRepository: _OrderRepository(),
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('deck-shuffle-new-cards')), findsNothing);
    expect(find.byKey(const ValueKey('deck-restore-new-card-order')), findsNothing);
  });
}

Widget _page(
  DeckNewCardOrderRepository repository, {
  Future<void> Function()? onChanged,
}) => MaterialApp(
  home: DeckOverviewPage(
    deck: const DeckNode(
      id: 23,
      name: 'History',
      newCount: 3,
      learnCount: 1,
      reviewCount: 2,
      filtered: false,
      children: [],
    ),
    newCardOrderRepository: repository,
    onChanged: onChanged,
  ),
);

class _OrderRepository implements DeckNewCardOrderRepository {
  final calls = <(int, bool)>[];
  Future<int>? pending;
  bool fail = false;

  @override
  Future<int> reorder(int deckId, {required bool randomize}) async {
    calls.add((deckId, randomize));
    if (fail) throw StateError('native error');
    return pending == null ? 3 : await pending!;
  }
}
