import 'package:anki_flutter/features/browser/browser_card_export.dart';
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selects all search matches, not only rendered rows', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.text('Select visible (2)'), findsOneWidget);
    expect(find.text('Select all matches (5)'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('browser-select-all-matches')));
    await tester.pumpAndSettle();

    expect(find.text('5 cards selected'), findsOneWidget);
    expect(
      tester.widget<TextButton>(
        find.byKey(const ValueKey('browser-select-all-matches')),
      ).onPressed,
      isNull,
    );
    await tester.tap(find.byKey(const ValueKey('browser-set-flags')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-flag-choice-4')));
    await tester.pumpAndSettle();

    expect(repository.flagIds, [10, 20, 30, 40, 50]);
    expect(repository.searches, ['', '']);
    expect(find.text('5 cards selected'), findsNothing);
  });

  testWidgets('select all extends visible selection and clear removes it',
      (tester) async {
    await tester.pumpWidget(_app(_Repository()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-select-visible')));
    await tester.pumpAndSettle();
    expect(find.text('2 cards selected'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('browser-select-all-matches')));
    await tester.pumpAndSettle();
    expect(find.text('5 cards selected'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('browser-clear-selection')));
    await tester.pumpAndSettle();
    expect(find.text('5 cards selected'), findsNothing);
    expect(
      tester.widget<TextButton>(
        find.byKey(const ValueKey('browser-select-all-matches')),
      ).onPressed,
      isNotNull,
    );
  });

  testWidgets('all matching IDs can be exported without paging',
      (tester) async {
    final exporter = _Exporter();
    await tester.pumpWidget(_app(_Repository(), exporter: exporter));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-select-all-matches')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-export-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-export')));
    await tester.pumpAndSettle();

    expect(exporter.ids, [10, 20, 30, 40, 50]);
    expect(find.text('5 cards selected'), findsOneWidget);
  });

  testWidgets('legacy or partial ID list cannot offer select-all-matches',
      (tester) async {
    await tester.pumpWidget(_app(_Repository()..legacy = true));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('browser-select-all-matches')), findsNothing);
    expect(find.byKey(const ValueKey('browser-select-visible')), findsOneWidget);
  });

  testWidgets('new queries discard prior all-matches selection', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-select-all-matches')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('card-browser-search')), 'deck:Other');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(repository.searches, ['', 'deck:Other']);
    expect(find.text('5 cards selected'), findsNothing);
    expect(find.byKey(const ValueKey('browser-select-all-matches')), findsNothing);
  });
}

Widget _app(_Repository repository, {BrowserCardExporter? exporter}) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _UnusedNotes(),
    stateStore: _Store(),
    cardExporter: exporter,
  ),
);

class _Repository implements CardBrowserRepository, CardBrowserFlagRepository {
  final searches = <String>[];
  List<int>? flagIds;
  bool legacy = false;

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

  @override
  Future<CardBrowserSearchResult> search(String query, {CardBrowserSort? sort}) async {
    searches.add(query);
    if (query.isNotEmpty) {
      return const CardBrowserSearchResult(
        totalCount: 1,
        matchingCardIds: [100],
        cards: [CardBrowserResult(cardId: 100, cells: ['Other'])],
      );
    }
    return CardBrowserSearchResult(
      totalCount: 5,
      matchingCardIds: legacy ? const [] : const [10, 20, 30, 40, 50],
      cards: const [
        CardBrowserResult(cardId: 10, cells: ['First']),
        CardBrowserResult(cardId: 20, cells: ['Second']),
      ],
    );
  }

  @override
  Future<int> noteIdForCard(int cardId) async => 10;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}

  @override
  Future<void> setCardsFlag(List<int> cardIds, int flag) async {
    flagIds = List.of(cardIds);
  }
}

class _Exporter implements BrowserCardExporter {
  List<int>? ids;
  @override
  Future<bool> exportCards(
    List<int> cardIds, {
    required bool withScheduling,
    required bool withMedia,
  }) async {
    ids = List.of(cardIds);
    return true;
  }
}

class _Store implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _UnusedNotes extends Fake implements NoteEntryRepository {}
