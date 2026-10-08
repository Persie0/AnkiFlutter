import 'dart:async';

import 'package:anki_flutter/features/decks/data/anki_filtered_deck_repository.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const filteredDeck = DeckNode(
    id: 108,
    name: 'Exam review',
    newCount: 3,
    learnCount: 2,
    reviewCount: 7,
    filtered: true,
    children: [],
  );
  const normalDeck = DeckNode(
    id: 109,
    name: 'Normal',
    newCount: 1,
    learnCount: 0,
    reviewCount: 2,
    filtered: false,
    children: [],
  );

  testWidgets('rebuild shows native card count and refreshes deck list', (
    tester,
  ) async {
    final backend = _FakeFilteredRepo()..rebuildResult = 5;
    var updates = 0;
    await tester.pumpWidget(_page(
      filteredDeck,
      backend,
      onChanged: () async => updates++,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('filtered-deck-rebuild')));
    await tester.pumpAndSettle();

    expect(backend.rebuildIds, [108]);
    expect(backend.emptyIds, isEmpty);
    expect(updates, 1);
    expect(find.text('Rebuilt filtered deck: 5 cards.'), findsOneWidget);
  });

  testWidgets('empty requires confirmation; cancel never calls scheduler', (
    tester,
  ) async {
    final backend = _FakeFilteredRepo();
    var updates = 0;
    await tester.pumpWidget(_page(
      filteredDeck,
      backend,
      onChanged: () async => updates++,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('filtered-deck-empty')));
    await tester.pumpAndSettle();
    expect(find.text('Empty filtered deck?'), findsOneWidget);
    expect(find.textContaining('review history will not be deleted'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(backend.emptyIds, isEmpty);
    expect(updates, 0);

    await tester.tap(find.byKey(const ValueKey('filtered-deck-empty')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('filtered-deck-confirm-empty')));
    await tester.pumpAndSettle();

    expect(backend.emptyIds, [108]);
    expect(updates, 1);
    expect(
      find.text('Emptied filtered deck. Cards returned to original decks.'),
      findsOneWidget,
    );
  });

  testWidgets('native rebuild errors do not refresh or claim success', (
    tester,
  ) async {
    final backend = _FakeFilteredRepo()..fail = true;
    var updates = 0;
    await tester.pumpWidget(_page(
      filteredDeck,
      backend,
      onChanged: () async => updates++,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('filtered-deck-rebuild')));
    await tester.pumpAndSettle();
    expect(backend.rebuildIds, [108]);
    expect(updates, 0);
    expect(find.textContaining('Could not update filtered deck:'), findsOneWidget);
    expect(find.textContaining('Rebuilt filtered deck:'), findsNothing);
  });

  testWidgets('buttons are disabled during in-flight native operation', (
    tester,
  ) async {
    final backend = _FakeFilteredRepo();
    final completer = Completer<int>();
    backend.rebuildPending = completer.future;
    await tester.pumpWidget(_page(filteredDeck, backend));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('filtered-deck-rebuild')));
    await tester.pump();
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('filtered-deck-rebuild')),
      ).onPressed,
      isNull,
    );
    expect(
      tester.widget<TextButton>(
        find.byKey(const ValueKey('filtered-deck-empty')),
      ).onPressed,
      isNull,
    );
    completer.complete(1);
    await tester.pumpAndSettle();
    expect(backend.rebuildIds, [108]);
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('filtered-deck-rebuild')),
      ).onPressed,
      isNotNull,
    );
    expect(find.text('Rebuilt filtered deck: 1 card.'), findsOneWidget);
  });

  testWidgets('normal decks never expose filtered deck actions', (tester) async {
    final backend = _FakeFilteredRepo();
    await tester.pumpWidget(_page(normalDeck, backend));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('filtered-deck-rebuild')), findsNothing);
    expect(find.byKey(const ValueKey('filtered-deck-empty')), findsNothing);
    expect(find.text('Study'), findsOneWidget);
  });

  testWidgets('filtered deck with no backend does not show inert controls', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: DeckOverviewPage(deck: filteredDeck)),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('filtered-deck-rebuild')), findsNothing);
    expect(find.byKey(const ValueKey('filtered-deck-empty')), findsNothing);
  });
}

Widget _page(
  DeckNode deck,
  FilteredDeckRepository repository, {
  Future<void> Function()? onChanged,
}) => MaterialApp(
  home: DeckOverviewPage(
    deck: deck,
    filteredDeckRepository: repository,
    onChanged: onChanged,
  ),
);

class _FakeFilteredRepo implements FilteredDeckRepository {
  final rebuildIds = <int>[];
  final emptyIds = <int>[];
  bool fail = false;
  int rebuildResult = 0;
  Future<int>? rebuildPending;

  @override
  Future<void> empty(int deckId) async {
    emptyIds.add(deckId);
    if (fail) throw StateError('scheduler error');
  }

  @override
  Future<int> rebuild(int deckId) async {
    rebuildIds.add(deckId);
    if (fail) throw StateError('scheduler error');
    return rebuildPending ?? Future<int>.value(rebuildResult);
  }
}
