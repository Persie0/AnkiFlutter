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
