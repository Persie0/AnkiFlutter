import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selected cards receive only confirmed due date', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('browser-set-due')));
    await tester.tap(find.byKey(const ValueKey('browser-set-due')));
    await tester.pumpAndSettle();

    expect(repository.defaultsRequested, 1);
    expect(find.text('Set due date for 2 cards?'), findsOneWidget);
    expect(find.text('3-7'), findsOneWidget);
    expect(repository.dueDates, isEmpty);

    await tester.enterText(
      find.byKey(const ValueKey('browser-due-days')),
      '1!',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-due')));
    await tester.pumpAndSettle();

    expect(repository.dueDates, [[10, 20]]);
    expect(repository.days, ['1!']);
    expect(repository.queries, ['', '']);
    expect(find.text('2 cards selected'), findsNothing);
  });

  testWidgets('empty due date cannot be submitted', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('browser-set-due')));
    await tester.tap(find.byKey(const ValueKey('browser-set-due')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('browser-due-days')),
      '  ',
    );
    await tester.pumpAndSettle();
    final submit = tester.widget<FilledButton>(
      find.byKey(const ValueKey('browser-confirm-due')),
    );
    expect(submit.onPressed, isNull);
    expect(repository.dueDates, isEmpty);
  });

  testWidgets('cancel keeps selection and avoids native mutation',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('browser-set-due')));
    await tester.tap(find.byKey(const ValueKey('browser-set-due')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.dueDates, isEmpty);
    expect(repository.queries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
  });

  testWidgets('native failure leaves selection available for retry',
      (tester) async {
    final repository = _Repository()..fail = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('browser-set-due')));
    await tester.tap(find.byKey(const ValueKey('browser-set-due')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-due')));
    await tester.pumpAndSettle();

    expect(find.textContaining('native due date failed'), findsOneWidget);
    expect(repository.queries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);

    repository.fail = false;
    await tester.tap(find.byKey(const ValueKey('browser-set-due')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-due')));
    await tester.pumpAndSettle();

    expect(repository.dueDates, [[10], [10]]);
    expect(repository.queries, ['', '']);
  });

  testWidgets('legacy browser does not render due date action',
      (tester) async {
    await tester.pumpWidget(_app(_LegacyRepository()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('browser-set-due')), findsNothing);
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
    implements CardBrowserSetDueDateRepository {
  final dueDates = <List<int>>[];
  final days = <String>[];
  int defaultsRequested = 0;
  bool fail = false;

  @override
  Future<String> setDueDateDefault() async {
    defaultsRequested++;
    return '3-7';
  }

  @override
  Future<void> setCardsDueDate(List<int> cardIds, String dayRange) async {
    dueDates.add(List.of(cardIds));
    days.add(dayRange);
    if (fail) throw StateError('native due date failed');
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
