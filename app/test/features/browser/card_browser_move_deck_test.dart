import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selects and clears only the cards shown in browser results', (tester) async {
    final repository = _BrowserRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.text('Select visible (2)'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('browser-select-visible')));
    await tester.pumpAndSettle();

    expect(find.text('2 cards selected'), findsOneWidget);
    expect(tester.widget<Checkbox>(
      find.byKey(const ValueKey('select-card-10')),
    ).value, isTrue);
    expect(tester.widget<Checkbox>(
      find.byKey(const ValueKey('select-card-20')),
    ).value, isTrue);

    await tester.tap(find.byKey(const ValueKey('browser-clear-selection')));
    await tester.pumpAndSettle();
    expect(find.text('2 cards selected'), findsNothing);
    expect(repository.searchQueries, ['']);
  });

  testWidgets('moves selected cards to a chosen regular destination', (tester) async {
    final repository = _BrowserRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-move-deck')));
    await tester.pumpAndSettle();

    expect(find.text('Move 2 cards to deck'), findsOneWidget);
    final confirm = find.byKey(const ValueKey('browser-confirm-move'));
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);

    await tester.tap(find.byKey(const ValueKey('browser-move-target')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Languages::French').last);
    await tester.pumpAndSettle();
    await tester.tap(confirm);
    await tester.pumpAndSettle();

    expect(repository.moves, hasLength(1));
    expect(repository.moves.single.ids, [10, 20]);
    expect(repository.moves.single.deckId, 2);
    expect(repository.searchQueries, ['', '']);
    expect(find.text('2 cards selected'), findsNothing);
  });

  testWidgets('canceling the move preserves selection', (tester) async {
    final repository = _BrowserRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-move-deck')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repository.moves, isEmpty);
    expect(repository.searchQueries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('browser-move-deck')),
      ).onPressed,
      isNotNull,
    );
  });

  testWidgets('backend move failure leaves selection intact', (tester) async {
    final repository = _BrowserRepository()..moveError = StateError('move rejected');
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-move-deck')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-move-target')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Default').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-move')));
    await tester.pumpAndSettle();

    expect(repository.moves, hasLength(1));
    expect(repository.searchQueries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('move rejected'), findsOneWidget);
  });

  testWidgets('failed destination lookup keeps selection recoverable', (tester) async {
    final repository = _BrowserRepository()..targetsError = StateError('no tree');
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-move-deck')));
    await tester.pumpAndSettle();

    expect(repository.moves, isEmpty);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('no tree'), findsOneWidget);
  });
}

Widget _app(_BrowserRepository repository) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _UnusedNoteRepository(),
    stateStore: _StateStore(),
  ),
);

class _MoveCall {
  const _MoveCall(this.ids, this.deckId);
  final List<int> ids;
  final int deckId;
}

class _BrowserRepository
    implements CardBrowserRepository, CardBrowserDeckMoveRepository {
  final List<String> searchQueries = [];
  final List<_MoveCall> moves = [];
  Object? moveError;
  Object? targetsError;

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

  @override
  Future<CardBrowserSearchResult> search(String query, {CardBrowserSort? sort}) async {
    searchQueries.add(query);
    return const CardBrowserSearchResult(
      totalCount: 100,
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
  Future<List<CardBrowserDeckTarget>> moveTargets() async {
    if (targetsError case final error?) throw error;
    return const [
      CardBrowserDeckTarget(id: 1, label: 'Default'),
      CardBrowserDeckTarget(id: 2, label: 'Languages::French'),
    ];
  }

  @override
  Future<void> moveCardsToDeck(List<int> cardIds, int deckId) async {
    moves.add(_MoveCall(List.of(cardIds), deckId));
    if (moveError case final error?) throw error;
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _UnusedNoteRepository extends Fake implements NoteEntryRepository {}
