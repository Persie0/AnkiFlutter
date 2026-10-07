import 'package:anki_flutter/features/browser/browser_card_export.dart';
import 'package:anki_flutter/features/browser/browser_state_store.dart';
import 'package:anki_flutter/features/browser/card_browser_page.dart';
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exports only selected cards, respecting media and scheduling', (tester) async {
    final repository = _BrowserRepository();
    final exporter = _Exporter();
    await tester.pumpWidget(_app(repository, exporter));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.tap(find.byKey(const ValueKey('select-card-20')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-export-selected')));
    await tester.pumpAndSettle();

    expect(find.text('Save 2 selected cards to an Anki package (.apkg).'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('browser-export-scheduling')));
    await tester.tap(find.byKey(const ValueKey('browser-export-media')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-export')));
    await tester.pumpAndSettle();

    expect(exporter.calls, hasLength(1));
    expect(exporter.calls.single.ids, [10, 20]);
    expect(exporter.calls.single.scheduling, isFalse);
    expect(exporter.calls.single.media, isFalse);
    expect(repository.queries, ['']); // No unnecessary re-search or mutation.
    expect(find.text('2 cards selected'), findsOneWidget);
    expect(find.textContaining('Exported 2 cards'), findsOneWidget);
  });

  testWidgets('canceling options preserves selection and does not call export',
      (tester) async {
    final repository = _BrowserRepository();
    final exporter = _Exporter();
    await tester.pumpWidget(_app(repository, exporter));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-export-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(exporter.calls, isEmpty);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('Exported 1 card'), findsNothing);
  });

  testWidgets('canceling the native save dialog does not report success',
      (tester) async {
    final exporter = _Exporter()..saved = false;
    await tester.pumpWidget(_app(_BrowserRepository(), exporter));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-export-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-export')));
    await tester.pumpAndSettle();

    expect(exporter.calls.single.ids, [10]);
    expect(exporter.calls.single.scheduling, isTrue);
    expect(exporter.calls.single.media, isTrue);
    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('Exported 1 card'), findsNothing);
  });

  testWidgets('Anki export error keeps selected cards and allows retry',
      (tester) async {
    final exporter = _Exporter()..error = StateError('save rejected');
    await tester.pumpWidget(_app(_BrowserRepository(), exporter));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('browser-export-selected')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browser-confirm-export')));
    await tester.pumpAndSettle();

    expect(find.text('1 card selected'), findsOneWidget);
    expect(find.textContaining('save rejected'), findsOneWidget);
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('browser-export-selected')),
      ).onPressed,
      isNotNull,
    );
  });

  testWidgets('no export action is exposed if the feature is unavailable',
      (tester) async {
    await tester.pumpWidget(_app(_BrowserRepository(), null));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('select-card-10')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('browser-export-selected')), findsNothing);
  });
}

Widget _app(_BrowserRepository repository, _Exporter? exporter) => MaterialApp(
  home: CardBrowserPage(
    repository: repository,
    noteRepository: _UnusedNoteRepository(),
    stateStore: _StateStore(),
    cardExporter: exporter,
  ),
);

class _ExportCall {
  const _ExportCall(this.ids, this.scheduling, this.media);
  final List<int> ids;
  final bool scheduling;
  final bool media;
}

class _Exporter implements BrowserCardExporter {
  final calls = <_ExportCall>[];
  bool saved = true;
  Object? error;

  @override
  Future<bool> exportCards(
    List<int> cardIds, {
    required bool withScheduling,
    required bool withMedia,
  }) async {
    calls.add(_ExportCall(List.of(cardIds), withScheduling, withMedia));
    if (error case final failure?) throw failure;
    return saved;
  }
}

class _BrowserRepository implements CardBrowserRepository {
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

class _StateStore implements BrowserStateStore {
  @override
  Future<CardBrowserState?> load() async => null;

  @override
  Future<void> save(CardBrowserState state) async {}
}

class _UnusedNoteRepository extends Fake implements NoteEntryRepository {}
