import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/card_info/data/card_info_repository.dart';
import 'package:anki_flutter/features/card_info/models/card_info_data.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens selected browser card info and retains browser state', (
    tester,
  ) async {
    final browser = _Browser();
    final info = _CardInfo();
    await tester.pumpWidget(_app(browser, info));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'tag:important',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-77')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-card-info-88')));
    await tester.pumpAndSettle();

    expect(find.text('Card Info'), findsOneWidget);
    expect(find.text('Physics::Energy'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Review history'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Review history'), findsOneWidget);
    expect(info.requestedIds, [88]);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('88 title'), findsOneWidget);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(browser.queries, ['', 'tag:important']);
    expect(
      tester
          .widget<TextField>(find.byKey(const ValueKey('card-browser-search')))
          .controller
          ?.text,
      'tag:important',
    );
  });

  testWidgets('retry of card info error keeps original card ID and browser', (
    tester,
  ) async {
    final browser = _Browser();
    final info = _CardInfo()..failOnce = true;
    await tester.pumpWidget(_app(browser, info));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-card-info-77')));
    await tester.pumpAndSettle();
    expect(find.text('Could not load card information'), findsOneWidget);
    expect(find.textContaining('card not available'), findsOneWidget);
    expect(info.requestedIds, [77]);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Physics::Energy'), findsOneWidget);
    expect(info.requestedIds, [77, 77]);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('77 title'), findsOneWidget);
    expect(browser.queries, ['']);
  });

  testWidgets('without Card Info capability no action is shown', (
    tester,
  ) async {
    final browser = _Browser();
    await tester.pumpWidget(_app(browser, null));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Card info'), findsNothing);
    expect(find.byKey(const ValueKey('browser-card-info-77')), findsNothing);
    expect(find.byTooltip('Edit note'), findsNWidgets(2));
  });
}

Widget _app(_Browser browser, CardInfoRepository? info) => MaterialApp(
  home: CardBrowserPage(
    repository: browser,
    noteRepository: _NoNotes(),
    cardInfoRepository: info,
    stateStore: _StateStore(),
  ),
);

class _Browser implements CardBrowserRepository {
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
        CardBrowserResult(cardId: 77, cells: ['77 title']),
        CardBrowserResult(cardId: 88, cells: ['88 title']),
      ],
      matchingCardIds: [77, 88],
    );
  }

  @override
  Future<int> noteIdForCard(int cardId) async => cardId + 100;

  @override
  Future<void> applyBulkAction(
    List<int> cardIds,
    CardBulkAction action,
  ) async {}
}

class _CardInfo implements CardInfoRepository {
  bool failOnce = false;
  final requestedIds = <int>[];

  @override
  Future<CardInfoData> load(int cardId) async {
    requestedIds.add(cardId);
    if (failOnce) {
      failOnce = false;
      throw StateError('card not available');
    }
    return CardInfoData(
      cardId: cardId,
      noteId: cardId + 100,
      deck: 'Physics::Energy',
      cardType: 'Card 1',
      noteType: 'Basic',
      preset: 'Default',
      addedUnixSeconds: 1700000000,
      duePosition: 5,
      intervalDays: 0,
      easePermille: 0,
      reviews: 0,
      lapses: 0,
      averageSeconds: 0,
      totalSeconds: 0,
      customData: '',
      fsrsParameters: const [],
      reviewHistory: const [],
    );
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
