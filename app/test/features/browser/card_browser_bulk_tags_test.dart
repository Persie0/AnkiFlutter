import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('adds tags to selected notes and reloads the current search', (tester) async {
    final repository = _BrowserRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-add-tags')));
    await tester.pumpAndSettle();
    expect(find.text('Add tags to selected notes'), findsOneWidget);
    final apply = find.byKey(const ValueKey('browser-apply-tags'));
    expect(tester.widget<FilledButton>(apply).onPressed, isNull);

    await tester.enterText(find.byKey(const ValueKey('browser-tags-input')), ' language exam ');
    await tester.pumpAndSettle();
    await tester.tap(apply);
    await tester.pumpAndSettle();

    expect(repository.calls, hasLength(1));
    expect(repository.calls.single.cardIds, [10, 20]);
    expect(repository.calls.single.tags, 'language exam');
    expect(repository.calls.single.remove, isFalse);
    expect(repository.searchQueries, ['', '']);
    expect(find.text('2 cards selected'), findsNothing);
  });

  testWidgets('removes tags from selected notes', (tester) async {
    final repository = _BrowserRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-remove-tags')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('browser-tags-input')), 'obsolete');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-apply-tags')));
    await tester.pumpAndSettle();

    expect(repository.calls.single.remove, isTrue);
    expect(repository.calls.single.tags, 'obsolete');
  });

  testWidgets('canceling tag edit preserves the selection', (tester) async {
    final repository = _BrowserRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-add-tags')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.calls, isEmpty);
    expect(find.text('1 card selected'), findsOneWidget);
  });

  testWidgets('tag mutation failure retains selection and shows an error', (tester) async {
    final repository = _BrowserRepository()..tagError = StateError('tagging unavailable');
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-add-tags')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('browser-tags-input')), 'exam');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-apply-tags')));
    await tester.pumpAndSettle();

    expect(repository.calls, hasLength(1));
    expect(repository.searchQueries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('tagging unavailable'), findsOneWidget);
  });
}

Widget _app(_BrowserRepository repository) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _UnusedNoteRepository(),
    stateStore: _StateStore(),
  ),
);

class _TagCall {
  const _TagCall(this.cardIds, this.tags, this.remove);
  final List<int> cardIds;
  final String tags;
  final bool remove;
}

class _BrowserRepository implements CardBrowserRepository, CardBrowserTagRepository {
  final List<String> searchQueries = [];
  final List<_TagCall> calls = [];
  Object? tagError;

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
  Future<int> noteIdForCard(int cardId) async => 42;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}

  @override
  Future<void> applyTagsToCards(List<int> cardIds, String tags, {required bool remove}) async {
    calls.add(_TagCall(List.of(cardIds), tags, remove));
    if (tagError case final error?) throw error;
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _UnusedNoteRepository extends Fake implements NoteEntryRepository {}
