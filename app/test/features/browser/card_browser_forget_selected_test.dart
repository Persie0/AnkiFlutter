import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('forget selected uses browser defaults and confirms first',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-forget-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-forget-selected')));
    await tester.pumpAndSettle();
    expect(repository.defaultsRequested, 1);
    expect(find.text('Forget 2 selected cards?'), findsOneWidget);
    expect(repository.forgotten, isEmpty);
    expect(find.text('Restore original position'), findsOneWidget);
    expect(find.text('Reset review and lapse counts'), findsOneWidget);

    await tester.tap(find.text('Reset review and lapse counts'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-forget')));
    await tester.pumpAndSettle();

    expect(repository.forgotten, [[10, 20]]);
    expect(repository.appliedOptions.single.restoreOriginalPosition, isTrue);
    expect(repository.appliedOptions.single.resetRepetitionAndLapseCounts,
        isTrue);
    expect(repository.queries, ['', '']);
    expect(find.text('2 cards selected'), findsNothing);
  });

  testWidgets('canceling forget does not change the collection or selection',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-forget-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-forget-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.forgotten, isEmpty);
    expect(repository.queries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
  });

  testWidgets('native forget failure preserves selection and allows retry',
      (tester) async {
    final repository = _Repository()..failForget = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('browser-forget-selected')),
    );
    await tester.tap(find.byKey(const ValueKey('browser-forget-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-forget')));
    await tester.pumpAndSettle();

    expect(find.textContaining('native forget failed'), findsOneWidget);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(repository.queries, ['']);

    repository.failForget = false;
    await tester.tap(find.byKey(const ValueKey('browser-forget-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-forget')));
    await tester.pumpAndSettle();
    expect(repository.forgotten, [[10], [10]]);
    expect(repository.queries, ['', '']);
  });

  testWidgets('legacy browser without forget capability has no action',
      (tester) async {
    await tester.pumpWidget(_app(_LegacyRepository()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('browser-forget-selected')), findsNothing);
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
    );
  }

  @override
  Future<int> noteIdForCard(int cardId) async => 10;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}
}

class _Repository extends _LegacyRepository
    implements CardBrowserForgetRepository {
  final forgotten = <List<int>>[];
  final appliedOptions = <CardBrowserForgetOptions>[];
  int defaultsRequested = 0;
  bool failForget = false;

  @override
  Future<CardBrowserForgetOptions> forgetCardsDefaults() async {
    defaultsRequested++;
    return const CardBrowserForgetOptions(
      restoreOriginalPosition: true,
      resetRepetitionAndLapseCounts: false,
    );
  }

  @override
  Future<void> forgetCards(
    List<int> cardIds,
    CardBrowserForgetOptions options,
  ) async {
    forgotten.add(List.of(cardIds));
    appliedOptions.add(options);
    if (failForget) throw StateError('native forget failed');
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
