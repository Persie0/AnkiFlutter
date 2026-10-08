import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('repositions selected cards in browser order with native defaults',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-reposition-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-reposition-selected')));
    await tester.pumpAndSettle();

    expect(find.text('Reposition 2 selected cards?'), findsOneWidget);
    expect(repository.defaultsRequested, 1);
    expect(repository.selected, isEmpty);
    expect(find.text('Shift existing new cards'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('browser-reposition-start')),
      '12',
    );
    await tester.enterText(
      find.byKey(const ValueKey('browser-reposition-step')),
      '2',
    );
    await tester.tap(find.byKey(const ValueKey('browser-confirm-reposition')));
    await tester.pumpAndSettle();

    expect(repository.selected, [[20, 10]]);
    expect(repository.options.single.startingFrom, 12);
    expect(repository.options.single.stepSize, 2);
    expect(repository.options.single.randomize, isFalse);
    expect(repository.options.single.shiftExisting, isTrue);
    expect(repository.queries, ['', '']);
    expect(find.text('2 cards selected'), findsNothing);
  });

  testWidgets('cannot confirm blank, zero or invalid step', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-reposition-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-reposition-selected')));
    await tester.pumpAndSettle();
    final button = find.byKey(const ValueKey('browser-confirm-reposition'));
    await tester.enterText(
      find.byKey(const ValueKey('browser-reposition-start')),
      '0',
    );
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(button).onPressed, isNull);
    await tester.enterText(
      find.byKey(const ValueKey('browser-reposition-start')),
      '1',
    );
    await tester.enterText(
      find.byKey(const ValueKey('browser-reposition-step')),
      'abc',
    );
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(button).onPressed, isNull);
    expect(repository.selected, isEmpty);
  });

  testWidgets('canceled dialog preserves selection and makes no changes',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-reposition-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-reposition-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repository.selected, isEmpty);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(repository.queries, ['']);
  });

  testWidgets('failed native operation keeps selection for retry',
      (tester) async {
    final repository = _Repository()..fail = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-reposition-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-reposition-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-reposition')));
    await tester.pumpAndSettle();

    expect(find.textContaining('native reposition failed'), findsOneWidget);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(repository.queries, ['']);

    repository.fail = false;
    await tester.tap(find.byKey(const ValueKey('browser-reposition-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-reposition')));
    await tester.pumpAndSettle();
    expect(repository.selected, [[10], [10]]);
    expect(repository.queries, ['', '']);
  });

  testWidgets('no eligible cards leaves selection and explains result',
      (tester) async {
    final repository = _Repository()..changedCount = 0;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-reposition-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-reposition-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-reposition')));
    await tester.pumpAndSettle();
    expect(find.textContaining('No selected new cards'), findsOneWidget);
    expect(repository.queries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
  });

  testWidgets('legacy browser does not display reposition action',
      (tester) async {
    await tester.pumpWidget(_app(_LegacyRepository()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('browser-reposition-selected')),
      findsNothing,
    );
  });
}

Widget _app(CardBrowserRepository repository) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _NoNotes(),
    stateStore: _StateStore(),
  ),
);

class _LegacyRepository implements CardBrowserRepository {
  final queries = <String>[];
  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

  @override
  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  }) async {
    queries.add(query);
    return const CardBrowserSearchResult(
      totalCount: 2,
      cards: [
        CardBrowserResult(cardId: 10, cells: ['Card 10']),
        CardBrowserResult(cardId: 20, cells: ['Card 20']),
      ],
      matchingCardIds: [20, 10],
    );
  }

  @override
  Future<int> noteIdForCard(int cardId) async => 10;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}
}

class _Repository extends _LegacyRepository
    implements CardBrowserRepositionRepository {
  int defaultsRequested = 0;
  bool fail = false;
  int? changedCount;
  final selected = <List<int>>[];
  final options = <CardBrowserRepositionOptions>[];

  @override
  Future<CardBrowserRepositionDefaults> repositionDefaults() async {
    defaultsRequested++;
    return const CardBrowserRepositionDefaults(
      randomize: false,
      shiftExisting: true,
    );
  }

  @override
  Future<int> repositionNewCards(
    List<int> cardIds,
    CardBrowserRepositionOptions value,
  ) async {
    selected.add(List.of(cardIds));
    options.add(value);
    if (fail) throw StateError('native reposition failed');
    return changedCount ?? cardIds.length;
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;
  @override
  Future<void> save(CardBrowserState state) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
