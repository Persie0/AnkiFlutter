import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('confirmation applies chosen Find & Replace settings', (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-find-replace')));
    await tester.pumpAndSettle();
    final confirm = find.byKey(const ValueKey('browser-confirm-find-replace'));
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
    await tester.enterText(
      find.byKey(const ValueKey('browser-find-text')), 'A+',
    );
    await tester.enterText(
      find.byKey(const ValueKey('browser-replacement-text')), 'B',
    );
    await tester.enterText(
      find.byKey(const ValueKey('browser-replacement-field')), 'Front',
    );
    await tester.tap(find.byKey(const ValueKey('browser-replacement-regex')));
    await tester.tap(find.byKey(const ValueKey('browser-replacement-case')));
    await tester.pumpAndSettle();
    await tester.tap(confirm);
    await tester.pumpAndSettle();

    expect(repo.replacements, hasLength(1));
    expect(repo.replacements.single.ids, [10]);
    expect(repo.replacements.single.options.search, 'A+');
    expect(repo.replacements.single.options.replacement, 'B');
    expect(repo.replacements.single.options.fieldName, 'Front');
    expect(repo.replacements.single.options.regex, isTrue);
    expect(repo.replacements.single.options.matchCase, isTrue);
    expect(repo.queries, ['', '']);
    expect(find.text('1 card selected'), findsNothing);
    expect(find.text('Updated 1 note.'), findsOneWidget);
  });

  testWidgets('cancel leaves card selection untouched and never mutates notes',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-find-replace')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repo.replacements, isEmpty);
    expect(find.text('1 card selected'), findsOneWidget);
  });

  testWidgets('backend regex failure preserves selection for retry',
      (tester) async {
    final repo = _Repository()..fail = true;
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-find-replace')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('browser-find-text')), '*');
    await tester.pumpAndSettle();
    expect(
      tester.widget<FilledButton>(
        find.byKey(const ValueKey('browser-confirm-find-replace')),
      ).onPressed,
      isNotNull,
    );
    await tester.tap(find.byKey(const ValueKey('browser-confirm-find-replace')));
    await tester.pumpAndSettle();

    expect(find.textContaining('invalid regex'), findsOneWidget);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(repo.queries, ['']);
    repo.fail = false;
    await tester.tap(find.byKey(const ValueKey('browser-find-replace')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('browser-find-text')), 'A');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-find-replace')));
    await tester.pumpAndSettle();
    expect(repo.replacements, hasLength(2));
    expect(repo.queries, ['', '']);
  });

  testWidgets('all matching cards can be targeted without loading every row',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-select-all-matches')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-find-replace')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('browser-find-text')), 'A');
    await tester.tap(find.byKey(const ValueKey('browser-confirm-find-replace')));
    await tester.pumpAndSettle();
    expect(repo.replacements.single.ids, [10, 20, 30]);
  });

  testWidgets('legacy browser without capability has no Find & Replace action',
      (tester) async {
    await tester.pumpWidget(_app(_LegacyRepository()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('browser-find-replace')), findsNothing);
  });
}

Widget _app(CardBrowserRepository repo) => MaterialApp(
  home: CardBrowserPage(
    repository: repo,
    noteRepository: _NoNotes(),
    stateStore: _StateStore(),
  ),
);

class _Call {
  _Call(this.ids, this.options);
  final List<int> ids;
  final CardBrowserFindReplaceOptions options;
}

class _LegacyRepository implements CardBrowserRepository {
  final queries = <String>[];

  @override
  Future<List<CardBrowserSortOption>> sortOptions() async => [];

  @override
  Future<CardBrowserSearchResult> search(String query, {CardBrowserSort? sort}) async {
    queries.add(query);
    return const CardBrowserSearchResult(
      totalCount: 3,
      matchingCardIds: [10, 20, 30],
      cards: [
        CardBrowserResult(cardId: 10, cells: ['first']),
        CardBrowserResult(cardId: 20, cells: ['second']),
      ],
    );
  }

  @override
  Future<int> noteIdForCard(int cardId) async => 42;

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {}
}

class _Repository extends _LegacyRepository implements CardBrowserFindReplaceRepository {
  final replacements = <_Call>[];
  bool fail = false;

  @override
  Future<int> findAndReplaceSelected(
    List<int> cardIds,
    CardBrowserFindReplaceOptions options,
  ) async {
    replacements.add(_Call(List.of(cardIds), options));
    if (fail) throw StateError('invalid regex');
    return 1;
  }
}

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}
