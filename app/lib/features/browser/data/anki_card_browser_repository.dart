import 'dart:convert';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pbenum.dart'
    as backend_proto;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as anki_cards;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as anki_search;

abstract interface class CardBrowserRepository {
  Future<CardBrowserSearchResult> search(String query);

  Future<int> noteIdForCard(int cardId);
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
  static const _defaultColumns = ['noteFld', 'template', 'cardDue', 'deck'];

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

    if (ids.isNotEmpty) {
      final configuredColumns = await _loadColumns();
      await backend.invoke(
        BackendOperation.setActiveBrowserColumns,
        Uint8List.fromList(
          generic.StringList(vals: configuredColumns).writeToBuffer(),
        ),
      );
    }

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

  @override
  Future<int> noteIdForCard(int cardId) async {
    final request = anki_cards.CardId(cid: Int64(cardId));
    final response = await backend.invoke(
      BackendOperation.getCard,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return anki_cards.Card.fromBuffer(response).noteId.toInt();
  }

  List<String> _decodeColumns(Uint8List responseBytes) {
    try {
      final jsonBytes = generic.Json.fromBuffer(responseBytes).json;
      final decoded = jsonDecode(utf8.decode(jsonBytes));
      if (decoded is List &&
          decoded.isNotEmpty &&
          decoded.every((column) => column is String)) {
        return List.unmodifiable(decoded.cast<String>());
      }
    } on FormatException {
      // Use Anki's default browser columns for absent or invalid config.
    }
    return _defaultColumns;
  }

  Future<List<String>> _loadColumns() async {
    try {
      final configBytes = await backend.invoke(
        BackendOperation.getConfigJson,
        Uint8List.fromList(generic.String(val: 'activeCols').writeToBuffer()),
      );
      return _decodeColumns(configBytes);
    } on AnkiBackendException catch (error) {
      if (error.kind != backend_proto.BackendError_Kind.NOT_FOUND_ERROR.value) {
        rethrow;
      }
      return _defaultColumns;
    }
  }
}
