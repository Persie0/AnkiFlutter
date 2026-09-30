import 'dart:convert';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pbenum.dart'
    as backend_proto;
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart'
    as cards;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as search;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resolves a browser card ID to its Anki note ID on demand', () async {
    final backend = _Backend([cards.Card(noteId: Int64(987)).writeToBuffer()]);

    final noteId = await AnkiCardBrowserRepository(backend: backend)
        .noteIdForCard(42);

    expect(noteId, 987);
    expect(backend.calls.single.operation, BackendOperation.getCard);
    expect(
      cards.CardId.fromBuffer(backend.calls.single.request),
      cards.CardId(cid: Int64(42)),
    );
  });

  test(
    'uses Anki search and browser rows to map ordered card previews',
    () async {
      final backend = _Backend([
        search.SearchResponse(ids: [Int64(21), Int64(34)]).writeToBuffer(),
        _activeColumns(['noteFld', 'template']),
        Uint8List(0),
        search.BrowserRow(
          cells: [
            search.BrowserRow_Cell(text: 'Question one'),
            search.BrowserRow_Cell(text: 'Language'),
          ],
        ).writeToBuffer(),
        search.BrowserRow(
          cells: [
            search.BrowserRow_Cell(text: 'Question two'),
            search.BrowserRow_Cell(text: 'History'),
          ],
        ).writeToBuffer(),
      ]);
      final repository = AnkiCardBrowserRepository(backend: backend);

      final result = await repository.search('deck:Language');

      expect(backend.calls.map((call) => call.operation), [
        BackendOperation.searchCards,
        BackendOperation.getConfigJson,
        BackendOperation.setActiveBrowserColumns,
        BackendOperation.browserRowForId,
        BackendOperation.browserRowForId,
      ]);
      expect(
        search.SearchRequest.fromBuffer(backend.calls.first.request).search,
        'deck:Language',
      );
      expect(
        generic.String.fromBuffer(backend.calls[1].request).val,
        'activeCols',
      );
      expect(generic.StringList.fromBuffer(backend.calls[2].request).vals, [
        'noteFld',
        'template',
      ]);
      expect(generic.Int64.fromBuffer(backend.calls[3].request).val, Int64(21));
      expect(result.totalCount, 2);
      expect(result.cards.map((card) => card.cardId), [21, 34]);
      expect(result.cards.first.cells, ['Question one', 'Language']);
      expect(result.cards.last.cells, ['Question two', 'History']);
    },
  );

  test('maps Anki card-sortable browser columns', () async {
    final backend = _Backend([
      search.BrowserColumns(
        columns: [
          search.BrowserColumns_Column(
            key: 'noteFld',
            cardsModeLabel: 'Sort field',
            sortingCards: search.BrowserColumns_Sorting.SORTING_ASCENDING,
          ),
          search.BrowserColumns_Column(
            key: 'cardDue',
            cardsModeLabel: 'Due',
            sortingCards: search.BrowserColumns_Sorting.SORTING_DESCENDING,
          ),
          search.BrowserColumns_Column(
            key: 'question',
            cardsModeLabel: 'Question',
            sortingCards: search.BrowserColumns_Sorting.SORTING_NONE,
          ),
        ],
      ).writeToBuffer(),
    ]);

    final options = await AnkiCardBrowserRepository(backend: backend)
        .sortOptions();

    expect(backend.calls.single.operation, BackendOperation.allBrowserColumns);
    expect(options.map((option) => option.column), ['noteFld', 'cardDue']);
    expect(options.map((option) => option.reverseByDefault), [false, true]);
    expect(options.map((option) => option.label), ['Sort field', 'Due']);
  });

  test('encodes selected card sort in Anki search request', () async {
    final backend = _Backend([
      search.SearchResponse(ids: [Int64(21)]).writeToBuffer(),
      _activeColumns(['noteFld']),
      Uint8List(0),
      search.BrowserRow(
        cells: [search.BrowserRow_Cell(text: 'Card 21')],
      ).writeToBuffer(),
    ]);

    await AnkiCardBrowserRepository(backend: backend).search(
      'deck:Language',
      sort: const CardBrowserSort(column: 'cardDue', reverse: true),
    );

    final request = search.SearchRequest.fromBuffer(
      backend.calls.first.request,
    );
    expect(backend.calls.first.operation, BackendOperation.searchCards);
    expect(request.search, 'deck:Language');
    expect(request.order.value, search.SortOrder_Value.builtin);
    expect(request.order.builtin.column, 'cardDue');
    expect(request.order.builtin.reverse, isTrue);
  });

  test(
    'loads only the first 50 browser rows and reports the full count',
    () async {
      final ids = [for (var id = 1; id <= 52; id++) Int64(id)];
      final backend = _Backend([
        search.SearchResponse(ids: ids).writeToBuffer(),
        _activeColumns(['noteFld', 'template', 'cardDue', 'deck']),
        Uint8List(0),
        for (var index = 0; index < 50; index++)
          search.BrowserRow(
            cells: [search.BrowserRow_Cell(text: 'Card $index')],
          ).writeToBuffer(),
      ]);
      final repository = AnkiCardBrowserRepository(backend: backend);

      final result = await repository.search('');

      expect(result.totalCount, 52);
      expect(result.cards, hasLength(50));
      expect(backend.calls, hasLength(53));
    },
  );

  test('uses Anki defaults when active columns have not been saved', () async {
    final backend = _Backend(
      [
        search.SearchResponse(ids: [Int64(5)]).writeToBuffer(),
        Uint8List(0),
        Uint8List(0),
        search.BrowserRow(
          cells: [search.BrowserRow_Cell(text: 'Default columns')],
        ).writeToBuffer(),
      ],
      failures: {
        1: AnkiBackendException(
          kind: backend_proto.BackendError_Kind.NOT_FOUND_ERROR.value,
          message: 'Config key not found',
          context: '',
        ),
      },
    );

    await AnkiCardBrowserRepository(backend: backend).search('');

    expect(generic.StringList.fromBuffer(backend.calls[2].request).vals, [
      'noteFld',
      'template',
      'cardDue',
      'deck',
    ]);
  });

  test(
    'encodes suspend and bury modes with only the requested card IDs',
    () async {
      final backend = _Backend([Uint8List(0), Uint8List(0)]);
      final repository = AnkiCardBrowserRepository(backend: backend);

      await repository.applyBulkAction([21, 34], CardBulkAction.suspend);
      await repository.applyBulkAction([21, 34], CardBulkAction.bury);

      expect(backend.calls.map((call) => call.operation), [
        BackendOperation.buryOrSuspendCards,
        BackendOperation.buryOrSuspendCards,
      ]);
      final suspend = scheduler.BuryOrSuspendCardsRequest.fromBuffer(
        backend.calls[0].request,
      );
      expect(suspend.cardIds, [Int64(21), Int64(34)]);
      expect(suspend.mode, scheduler.BuryOrSuspendCardsRequest_Mode.SUSPEND);

      final bury = scheduler.BuryOrSuspendCardsRequest.fromBuffer(
        backend.calls[1].request,
      );
      expect(bury.cardIds, [Int64(21), Int64(34)]);
      expect(bury.mode, scheduler.BuryOrSuspendCardsRequest_Mode.BURY_USER);
    },
  );

  test('encodes deletion with only the requested card IDs', () async {
    final backend = _Backend([Uint8List(0)]);
    final repository = AnkiCardBrowserRepository(backend: backend);

    await repository.applyBulkAction([21, 34], CardBulkAction.delete);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.removeCards);
    expect(
      cards.RemoveCardsRequest.fromBuffer(backend.calls.single.request).cardIds,
      [Int64(21), Int64(34)],
    );
  });

  test('does not call Anki when there are no selected cards', () async {
    final backend = _Backend([]);

    await AnkiCardBrowserRepository(backend: backend)
        .applyBulkAction([], CardBulkAction.delete);

    expect(backend.calls, isEmpty);
  });
}

Uint8List _activeColumns(List<String> columns) => Uint8List.fromList(
  generic.Json(json: utf8.encode(jsonEncode(columns))).writeToBuffer(),
);

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.responses, {this.failures = const {}});
  final List<Uint8List> responses;
  final Map<int, Object> failures;
  final calls = <_Call>[];
  var _index = 0;

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    final index = _index++;
    final failure = failures[index];
    if (failure != null) throw failure;
    return responses[index];
  }
}
