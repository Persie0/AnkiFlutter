import 'dart:convert';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart' as search;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns all matching IDs but renders only the initial native page', () async {
    final backend = _Backend([
      search.SearchResponse(ids: [Int64(1), Int64(2), Int64(3), Int64(4)])
          .writeToBuffer(),
      generic.Json(
        json: utf8.encode(jsonEncode(['noteFld'])),
      ).writeToBuffer(),
      Uint8List(0),
      search.BrowserRow(
        cells: [search.BrowserRow_Cell(text: 'First')],
      ).writeToBuffer(),
      search.BrowserRow(
        cells: [search.BrowserRow_Cell(text: 'Second')],
      ).writeToBuffer(),
      search.BrowserRow(
        cells: [search.BrowserRow_Cell(text: 'Third')],
      ).writeToBuffer(),
      search.BrowserRow(
        cells: [search.BrowserRow_Cell(text: 'Fourth')],
      ).writeToBuffer(),
    ]);
    final repository = AnkiCardBrowserRepository(backend: backend, maxRows: 2);

    final initial = await repository.search('deck:Test');
    expect(initial.totalCount, 4);
    expect(initial.matchingCardIds, [1, 2, 3, 4]);
    expect(initial.cards.map((card) => card.cardId), [1, 2]);
    expect(repository.pageSize, 2);

    final extra = await repository.renderMore([3, 4]);
    expect(extra.map((card) => card.cardId), [3, 4]);
    expect(extra.map((card) => card.cells.single), ['Third', 'Fourth']);
    expect(backend.calls.map((call) => call.operation), [
      BackendOperation.searchCards,
      BackendOperation.getConfigJson,
      BackendOperation.setActiveBrowserColumns,
      BackendOperation.browserRowForId,
      BackendOperation.browserRowForId,
      BackendOperation.browserRowForId,
      BackendOperation.browserRowForId,
    ]);
    expect(
      generic.Int64.fromBuffer(backend.calls.last.request).val,
      Int64(4),
    );
  });

  test('an empty next page never invokes the native backend', () async {
    final backend = _Backend([]);

    final extra = await AnkiCardBrowserRepository(backend: backend)
        .renderMore([]);

    expect(extra, isEmpty);
    expect(backend.calls, isEmpty);
  });

  test('backend rendering errors propagate to keep the original page intact', () async {
    final backend = _Backend([], failureAt: 0);

    await expectLater(
      AnkiCardBrowserRepository(backend: backend).renderMore([12]),
      throwsStateError,
    );
    expect(backend.calls.single.operation, BackendOperation.browserRowForId);
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.responses, {this.failureAt});
  final List<Uint8List> responses;
  final int? failureAt;
  final List<_Call> calls = [];
  var _index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    final index = _index++;
    if (index == failureAt) throw StateError('page render failed');
    return responses[index];
  }
}
