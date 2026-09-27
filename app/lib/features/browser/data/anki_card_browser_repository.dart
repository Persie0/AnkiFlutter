import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as anki_search;

abstract interface class CardBrowserRepository {
  Future<CardBrowserSearchResult> search(String query);
}

class CardBrowserSearchResult {
  const CardBrowserSearchResult({
    required this.totalCount,
    required this.cards,
  });

  final int totalCount;
  final List<CardBrowserResult> cards;
}

class CardBrowserResult {
  const CardBrowserResult({required this.cardId, required this.cells});

  final int cardId;
  final List<String> cells;
}

class AnkiCardBrowserRepository implements CardBrowserRepository {
  const AnkiCardBrowserRepository({required this.backend, this.maxRows = 50});

  final BackendInvoker backend;
  final int maxRows;

  @override
  Future<CardBrowserSearchResult> search(String query) async {
    final request = anki_search.SearchRequest(search: query);
    final responseBytes = await backend.invoke(
      BackendOperation.searchCards,
      Uint8List.fromList(request.writeToBuffer()),
    );
    final ids = anki_search.SearchResponse.fromBuffer(responseBytes).ids;
    final cards = <CardBrowserResult>[];

    for (final id in ids.take(maxRows)) {
      final rowBytes = await backend.invoke(
        BackendOperation.browserRowForId,
        Uint8List.fromList(generic.Int64(val: id).writeToBuffer()),
      );
      final row = anki_search.BrowserRow.fromBuffer(rowBytes);
      cards.add(
        CardBrowserResult(
          cardId: id.toInt(),
          cells: List.unmodifiable(row.cells.map((cell) => cell.text)),
        ),
      );
    }

    return CardBrowserSearchResult(
      totalCount: ids.length,
      cards: List.unmodifiable(cards),
    );
  }
}
