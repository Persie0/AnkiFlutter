import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as search;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'uses Anki search and browser rows to map ordered card previews',
    () async {
      final backend = _Backend([
        search.SearchResponse(ids: [Int64(21), Int64(34)]).writeToBuffer(),
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
        BackendOperation.setActiveBrowserColumns,
        BackendOperation.browserRowForId,
        BackendOperation.browserRowForId,
      ]);
      expect(
        search.SearchRequest.fromBuffer(backend.calls.first.request).search,
        'deck:Language',
      );
      expect(generic.StringList.fromBuffer(backend.calls[1].request).vals, [
        'noteFld',
        'template',
        'cardDue',
        'deck',
      ]);
      expect(generic.Int64.fromBuffer(backend.calls[2].request).val, Int64(21));
      expect(result.totalCount, 2);
      expect(result.cards.map((card) => card.cardId), [21, 34]);
      expect(result.cards.first.cells, ['Question one', 'Language']);
      expect(result.cards.last.cells, ['Question two', 'History']);
    },
  );

  test(
    'loads only the first 50 browser rows and reports the full count',
    () async {
      final ids = [for (var id = 1; id <= 52; id++) Int64(id)];
      final backend = _Backend([
        search.SearchResponse(ids: ids).writeToBuffer(),
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
      expect(backend.calls, hasLength(52));
    },
  );
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.responses);
  final List<Uint8List> responses;
  final calls = <_Call>[];
  var _index = 0;

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    return responses[_index++];
  }
}
