import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('restores selected cards via native scheduler and refreshes search',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-restore-selected')));
    await tester.pumpAndSettle();

    expect(find.text('Restore 2 selected cards?'), findsOneWidget);
    expect(repository.restores, isEmpty);
    await tester.tap(find.byKey(const ValueKey('browser-confirm-restore')));
    await tester.pumpAndSettle();

    expect(repository.restores, [[10, 20]]);
    expect(repository.queries, ['', '']);
    expect(find.text('2 cards selected'), findsNothing);
  });

  testWidgets('canceled restore preserves selection without a native call',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-restore-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.restores, isEmpty);
    expect(repository.queries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('browser-restore-selected')),
      ).onPressed,
      isNotNull,
    );
  });

  testWidgets('native failure leaves selection and allows retry', (tester) async {
    final repository = _Repository()..failRestore = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-restore-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-restore')));
    await tester.pumpAndSettle();

    expect(find.textContaining('native restore failed'), findsOneWidget);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(repository.queries, ['']);
    repository.failRestore = false;
    await tester.tap(find.byKey(const ValueKey('browser-restore-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-restore')));
    await tester.pumpAndSettle();
    expect(repository.restores, [[10], [10]]);
    expect(repository.queries, ['', '']);
  });

  testWidgets('restore button is absent when backend lacks capability',
      (tester) async {
    await tester.pumpWidget(_app(_LegacyRepository()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('browser-restore-selected')), findsNothing);
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
  Future<CardBrowserSearchResult> search(String query, {CardBrowserSort? sort}) async {
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

class _Repository extends _LegacyRepository implements CardBrowserRestoreRepository {
  final restores = <List<int>>[];
  bool failRestore = false;

  @override
  Future<void> restoreCards(List<int> cardIds) async {
    restores.add(List.of(cardIds));
    if (failRestore) throw StateError('native restore failed');
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
