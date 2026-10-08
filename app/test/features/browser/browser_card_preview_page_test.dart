import 'dart:async';

import 'package:anki_flutter/features/browser/browser_card_preview_page.dart';
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('preview starts on question and flips without another render', (
    tester,
  ) async {
    final renderer = _Renderer();
    await tester.pumpWidget(
      MaterialApp(
        home: BrowserCardPreviewPage(
          cardId: 77,
          repository: renderer,
          surfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(renderer.ids, [77]);
    expect(find.text('Preview card 77'), findsOneWidget);
    expect(find.textContaining('front-77'), findsOneWidget);
    expect(find.textContaining('back-77'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('browser-preview-flip')));
    await tester.pumpAndSettle();
    expect(find.textContaining('back-77'), findsOneWidget);
    expect(find.text('Show question'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('browser-preview-flip')));
    await tester.pumpAndSettle();
    expect(find.textContaining('back-77'), findsNothing);
    expect(find.text('Show answer'), findsOneWidget);
    expect(renderer.ids, [77]);
  });

  testWidgets(
    'previous and next follow browser order, reset answer, and enforce bounds',
    (tester) async {
      final renderer = _Renderer();
      await tester.pumpWidget(
        MaterialApp(
          home: BrowserCardPreviewPage(
            cardId: 20,
            orderedCardIds: const [10, 20, 30],
            repository: renderer,
            surfaceBuilder: (_, html) => Text(html),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2 / 3'), findsOneWidget);
      expect(find.text('Preview card 20'), findsOneWidget);
      expect(renderer.ids, [20]);
      await tester.tap(find.byKey(const ValueKey('browser-preview-flip')));
      await tester.pumpAndSettle();
      expect(find.textContaining('back-20'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('browser-preview-next')));
      await tester.pumpAndSettle();
      expect(find.text('3 / 3'), findsOneWidget);
      expect(find.text('Preview card 30'), findsOneWidget);
      expect(find.textContaining('front-30'), findsOneWidget);
      expect(find.textContaining('back-30'), findsNothing);
      expect(
        tester.widget<IconButton>(
          find.byKey(const ValueKey('browser-preview-next')),
        ).onPressed,
        isNull,
      );
      await tester.tap(find.byKey(const ValueKey('browser-preview-previous')));
      await tester.pumpAndSettle();
      expect(find.text('2 / 3'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('browser-preview-previous')));
      await tester.pumpAndSettle();
      expect(find.text('1 / 3'), findsOneWidget);
      expect(
        tester.widget<IconButton>(
          find.byKey(const ValueKey('browser-preview-previous')),
        ).onPressed,
        isNull,
      );
      expect(renderer.ids, [20, 30, 20, 10]);
    },
  );

  testWidgets('stale render cannot replace a newly navigated preview', (
    tester,
  ) async {
    final oldResult = Completer<ReviewCardContent>();
    final renderer = _NavigationRenderer(oldResult.future);
    await tester.pumpWidget(
      MaterialApp(
        home: BrowserCardPreviewPage(
          cardId: 20,
          orderedCardIds: const [20, 30],
          repository: renderer,
          surfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('browser-preview-next')));
    await tester.pumpAndSettle();

    expect(find.text('Preview card 30'), findsOneWidget);
    expect(find.textContaining('front-30'), findsOneWidget);
    oldResult.complete(_content(20));
    await tester.pumpAndSettle();
    expect(find.textContaining('front-20'), findsNothing);
    expect(find.textContaining('front-30'), findsOneWidget);
    expect(renderer.ids, [20, 30]);
  });

  testWidgets('missing or partial ordering never navigates to foreign ID', (
    tester,
  ) async {
    final renderer = _Renderer();
    await tester.pumpWidget(
      MaterialApp(
        home: BrowserCardPreviewPage(
          cardId: 20,
          orderedCardIds: const [10, 11, 12],
          repository: renderer,
          surfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('browser-preview-next')), findsNothing);
    expect(renderer.ids, [20]);
  });

  testWidgets('missing card is retryable without entering reviewer', (
    tester,
  ) async {
    final renderer = _Renderer()..failOnce = true;
    await tester.pumpWidget(
      MaterialApp(
        home: BrowserCardPreviewPage(
          cardId: 99,
          repository: renderer,
          surfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Could not preview this card'), findsOneWidget);
    expect(find.textContaining('deleted card'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('browser-preview-retry')));
    await tester.pumpAndSettle();
    expect(renderer.ids, [99, 99]);
    expect(find.textContaining('front-99'), findsOneWidget);
    expect(find.text('Show answer'), findsOneWidget);
  });

  testWidgets('discarded preview ignores stale render completion', (
    tester,
  ) async {
    final future = Completer<ReviewCardContent>();
    final renderer = _Renderer()..pending = future.future;
    await tester.pumpWidget(
      MaterialApp(
        home: BrowserCardPreviewPage(
          cardId: 77,
          repository: renderer,
          surfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );
    await tester.pump();
    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
    future.complete(_content(77));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping browser row previews correct card and retains state', (
    tester,
  ) async {
    final renderer = _Renderer();
    final browser = _Browser();
    await tester.pumpWidget(
      MaterialApp(
        home: CardBrowserPage(
          repository: browser,
          noteRepository: _NoNotes(),
          stateStore: _StateStore(),
          previewRepository: renderer,
          previewMediaBaseUri: Uri.parse('http://localhost:9811/media/'),
          previewSurfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('card-browser-search')),
      'tag:science',
    );
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-77')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('card-browser-result-88')));
    await tester.pumpAndSettle();
    expect(renderer.ids, [88]);
    expect(find.textContaining('front-88'), findsOneWidget);
    expect(find.textContaining('http://localhost:9811/media/'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(browser.queries, ['', 'tag:science']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.text('Card 88'), findsOneWidget);
  });

  testWidgets('preview navigation reaches matches outside rendered pages', (
    tester,
  ) async {
    final renderer = _Renderer();
    final browser = _PagedBrowser();
    await tester.pumpWidget(
      MaterialApp(
        home: CardBrowserPage(
          repository: browser,
          noteRepository: _NoNotes(),
          stateStore: _StateStore(),
          previewRepository: renderer,
          previewSurfaceBuilder: (_, html) => Text(html),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-77')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('card-browser-result-88')));
    await tester.pumpAndSettle();
    expect(find.text('2 / 3'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('browser-preview-next')));
    await tester.pumpAndSettle();
    expect(find.text('Preview card 99'), findsOneWidget);
    expect(find.textContaining('front-99'), findsOneWidget);
    expect(renderer.ids, [88, 99]);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(browser.queries, ['']);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.byKey(const ValueKey('card-browser-result-99')), findsNothing);
  });

  testWidgets('browser with no renderer keeps rows non-previewable', (
    tester,
  ) async {
    final browser = _Browser();
    await tester.pumpWidget(
      MaterialApp(
        home: CardBrowserPage(
          repository: browser,
          noteRepository: _NoNotes(),
          stateStore: _StateStore(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final tile = tester.widget<ListTile>(
      find.byKey(const ValueKey('card-browser-result-88')),
    );
    expect(tile.onTap, isNull);
  });
}

ReviewCardContent _content(int id) => ReviewCardContent(
  questionHtml: '<p>front-$id</p>',
  answerHtml: '<p>back-$id</p>',
  css: '',
  questionAudio: const [],
  answerAudio: const [],
);

class _Renderer implements CardRenderRepository {
  bool failOnce = false;
  Future<ReviewCardContent>? pending;
  final ids = <int>[];

  @override
  Future<ReviewCardContent> render(int cardId) async {
    ids.add(cardId);
    if (failOnce) {
      failOnce = false;
      throw StateError('deleted card');
    }
    if (pending != null) return pending!;
    return _content(cardId);
  }
}

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
        CardBrowserResult(cardId: 77, cells: ['Card 77']),
        CardBrowserResult(cardId: 88, cells: ['Card 88']),
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

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _NoNotes extends Fake implements NoteEntryRepository {}

class _NavigationRenderer implements CardRenderRepository {
  _NavigationRenderer(this.firstPending);

  final Future<ReviewCardContent> firstPending;
  final ids = <int>[];

  @override
  Future<ReviewCardContent> render(int cardId) {
    ids.add(cardId);
    return cardId == 20 ? firstPending : Future.value(_content(cardId));
  }
}

class _PagedBrowser extends _Browser {
  @override
  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  }) async {
    queries.add(query);
    return const CardBrowserSearchResult(
      totalCount: 3,
      cards: [
        CardBrowserResult(cardId: 77, cells: ['Card 77']),
        CardBrowserResult(cardId: 88, cells: ['Card 88']),
      ],
      matchingCardIds: [77, 88, 99],
    );
  }
}
