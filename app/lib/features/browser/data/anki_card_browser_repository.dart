import 'dart:convert';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pbenum.dart'
    as backend_proto;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart'
    as anki_cards;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as anki_search;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as anki_scheduler;
import 'package:fixnum/fixnum.dart';

enum CardBulkAction { suspend, bury, delete }

abstract interface class CardBrowserRepository {
  Future<List<CardBrowserSortOption>> sortOptions();

  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  });

  Future<int> noteIdForCard(int cardId);

  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action);
}

class CardBrowserSortOption {
  const CardBrowserSortOption({
    required this.column,
    required this.label,
    required this.reverseByDefault,
  });

  final String column;
  final String label;
  final bool reverseByDefault;
}

class CardBrowserSort {
  const CardBrowserSort({required this.column, required this.reverse});

  final String column;
  final bool reverse;
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
  Future<List<CardBrowserSortOption>> sortOptions() async {
    final responseBytes = await backend.invoke(
      BackendOperation.allBrowserColumns,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    final columns = anki_search.BrowserColumns.fromBuffer(responseBytes).columns;
    return List.unmodifiable(
      columns
          .where(
            (column) =>
                column.sortingCards !=
                anki_search.BrowserColumns_Sorting.SORTING_NONE,
          )
          .map(
            (column) => CardBrowserSortOption(
              column: column.key,
              label: column.cardsModeLabel.isEmpty
                  ? column.key
                  : column.cardsModeLabel,
              reverseByDefault:
                  column.sortingCards ==
                  anki_search.BrowserColumns_Sorting.SORTING_DESCENDING,
            ),
          ),
    );
  }

  @override
  Future<CardBrowserSearchResult> search(
    String query, {
    CardBrowserSort? sort,
  }) async {
    final request = anki_search.SearchRequest(search: query);
    if (sort != null) {
      request.order = anki_search.SortOrder(
        builtin: anki_search.SortOrder_Builtin(
          column: sort.column,
          reverse: sort.reverse,
        ),
      );
    }
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

  @override
  Future<void> applyBulkAction(List<int> cardIds, CardBulkAction action) async {
    if (cardIds.isEmpty) return;

    if (action == CardBulkAction.delete) {
      final request = anki_cards.RemoveCardsRequest(
        cardIds: cardIds.map((cardId) => Int64(cardId)),
      );
      await backend.invoke(
        BackendOperation.removeCards,
        Uint8List.fromList(request.writeToBuffer()),
      );
      return;
    }

    final request = anki_scheduler.BuryOrSuspendCardsRequest(
      cardIds: cardIds.map((cardId) => Int64(cardId)),
      mode: switch (action) {
        CardBulkAction.suspend =>
          anki_scheduler.BuryOrSuspendCardsRequest_Mode.SUSPEND,
        CardBulkAction.bury =>
          anki_scheduler.BuryOrSuspendCardsRequest_Mode.BURY_USER,
        CardBulkAction.delete => throw StateError(
          'Card deletion is handled above.',
        ),
      },
    );
    await backend.invoke(
      BackendOperation.buryOrSuspendCards,
      Uint8List.fromList(request.writeToBuffer()),
    );
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
