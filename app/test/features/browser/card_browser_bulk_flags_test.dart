import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sets a chosen flag and refreshes browser results', (tester) async {
    final repository = _FlagRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-set-flags')));
    await tester.pumpAndSettle();

    expect(find.text('Set card flags'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('browser-flag-choice-3')));
    await tester.pumpAndSettle();

    expect(repository.calls, hasLength(1));
    expect(repository.calls.single.cardIds, [10, 20]);
    expect(repository.calls.single.flag, 3);
    expect(repository.searchQueries, ['', '']);
    expect(find.text('2 cards selected'), findsNothing);
  });

  testWidgets('clears all selected flags via choice zero', (tester) async {
    final repository = _FlagRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-set-flags')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-flag-choice-0')));
    await tester.pumpAndSettle();

    expect(repository.calls.single.flag, 0);
  });

  testWidgets('dismissing the flag dialog keeps selection and does not write', (tester) async {
    final repository = _FlagRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-set-flags')));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(1, 1));
    await tester.pumpAndSettle();

    expect(repository.calls, isEmpty);
    expect(repository.searchQueries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('browser-set-flags')),
      ).onPressed,
      isNotNull,
    );
  });

  testWidgets('native flag errors preserve selected cards and show feedback', (tester) async {
    final repository = _FlagRepository()..fail = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-set-flags')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-flag-choice-2')));
    await tester.pumpAndSettle();

    expect(repository.calls, hasLength(1));
    expect(repository.searchQueries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('flag rejected'), findsOneWidget);
  });
}

Widget _app(_FlagRepository repository) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _UnusedNoteRepository(),
    stateStore: _StateStore(),
  ),
);

class _FlagCall {
  const _FlagCall(this.cardIds, this.flag);
  final List<int> cardIds;
  final int flag;
}

class _FlagRepository implements CardBrowserRepository, CardBrowserFlagRepository {
  final List<String> searchQueries = [];
  final List<_FlagCall> calls = [];
  bool fail = false;

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

  @override
  Future<CardBrowserSearchResult> search(String query, {CardBrowserSort? sort}) async {
    searchQueries.add(query);
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

  @override
  Future<void> setCardsFlag(List<int> cardIds, int flag) async {
    calls.add(_FlagCall(List.of(cardIds), flag));
    if (fail) throw StateError('flag rejected');
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _UnusedNoteRepository extends Fake implements NoteEntryRepository {}
