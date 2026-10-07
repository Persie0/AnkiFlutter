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
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart'
    as anki_decks;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as anki_search;
import 'package:anki_flutter/core/backend/generated/anki/tags.pb.dart'
    as anki_tags;
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

/// Optional capability for fetching additional rows without re-running search.
abstract interface class CardBrowserPagingRepository {
  int get pageSize;

  Future<List<CardBrowserResult>> renderMore(List<int> cardIds);
}

/// Optional capability for actions that operate on notes, not individual cards.
abstract interface class CardBrowserTagRepository {
  Future<void> applyTagsToCards(
    List<int> cardIds,
    String tags, {
    required bool remove,
  });
}

/// Optional browser capability for Anki's per-card flags (0 clears, 1-7 set).
abstract interface class CardBrowserFlagRepository {
  Future<void> setCardsFlag(List<int> cardIds, int flag);
}

/// Optional browser capability for moving cards into a regular deck.
abstract interface class CardBrowserDeckMoveRepository {
  Future<List<CardBrowserDeckTarget>> moveTargets();

  Future<void> moveCardsToDeck(List<int> cardIds, int deckId);
}

class CardBrowserDeckTarget {
  const CardBrowserDeckTarget({required this.id, required this.label});

  final int id;
  final String label;
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
    this.matchingCardIds = const [],
  });

  final int totalCount;
  final List<CardBrowserResult> cards;

  /// Full ordered search IDs, populated by native search implementations
  /// that support loading more without re-executing the query.
  final List<int> matchingCardIds;
}

class CardBrowserResult {
  const CardBrowserResult({required this.cardId, required this.cells});

  final int cardId;
  final List<String> cells;
}

class AnkiCardBrowserRepository
    implements
        CardBrowserRepository,
        CardBrowserTagRepository,
        CardBrowserDeckMoveRepository,
        CardBrowserFlagRepository,
        CardBrowserPagingRepository {
  static const _defaultColumns = ['noteFld', 'template', 'cardDue', 'deck'];

  const AnkiCardBrowserRepository({required this.backend, this.maxRows = 50});

  final BackendInvoker backend;
  final int maxRows;

  @override
  int get pageSize => maxRows;

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
      matchingCardIds: List.unmodifiable(ids.map((id) => id.toInt())),
    );
  }

  @override
  Future<List<CardBrowserResult>> renderMore(List<int> cardIds) async {
    final rows = <CardBrowserResult>[];
    for (final cardId in cardIds) {
      final rowBytes = await backend.invoke(
        BackendOperation.browserRowForId,
        Uint8List.fromList(generic.Int64(val: Int64(cardId)).writeToBuffer()),
      );
      final row = anki_search.BrowserRow.fromBuffer(rowBytes);
      rows.add(
        CardBrowserResult(
          cardId: cardId,
          cells: List.unmodifiable(row.cells.map((cell) => cell.text)),
        ),
      );
    }
    return List.unmodifiable(rows);
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

  @override
  Future<void> applyTagsToCards(
    List<int> cardIds,
    String tags, {
    required bool remove,
  }) async {
    final normalizedTags = tags.trim();
    if (cardIds.isEmpty || normalizedTags.isEmpty) return;

    // Anki tags belong to notes. Resolve all cards before writing so a
    // failed lookup never leaves a partially tagged selection.
    final noteIds = <int>{};
    for (final cardId in cardIds.toSet()) {
      noteIds.add(await noteIdForCard(cardId));
    }

    final request = anki_tags.NoteIdsAndTagsRequest(
      noteIds: noteIds.map(Int64.new),
      tags: normalizedTags,
    );
    await backend.invoke(
      remove ? BackendOperation.removeNoteTags : BackendOperation.addNoteTags,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<void> setCardsFlag(List<int> cardIds, int flag) async {
    if (flag < 0 || flag > 7) {
      throw ArgumentError.value(flag, 'flag', 'Anki card flags are 0 through 7.');
    }
    if (cardIds.isEmpty) return;

    final request = anki_cards.SetFlagRequest(
      cardIds: cardIds.toSet().map(Int64.new),
      flag: flag,
    );
    await backend.invoke(
      BackendOperation.setFlag,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<List<CardBrowserDeckTarget>> moveTargets() async {
    // Deck-tree counts are unnecessary for selecting a destination.
    final request = anki_decks.DeckTreeRequest();
    final response = await backend.invoke(
      BackendOperation.deckTree,
      Uint8List.fromList(request.writeToBuffer()),
    );
    final root = anki_decks.DeckTreeNode.fromBuffer(response);
    final targets = <CardBrowserDeckTarget>[];

    void collect(anki_decks.DeckTreeNode node, String parentName) {
      // Filtered decks cannot receive cards as their permanent home.
      if (node.filtered) return;
      final name = parentName.isEmpty
          ? node.name
          : '$parentName::${node.name}';
      if (node.deckId.toInt() > 0) {
        targets.add(
          CardBrowserDeckTarget(id: node.deckId.toInt(), label: name),
        );
      }
      for (final child in node.children) {
        collect(child, name);
      }
    }

    for (final child in root.children) {
      collect(child, '');
    }
    return List.unmodifiable(targets);
  }

  @override
  Future<void> moveCardsToDeck(List<int> cardIds, int deckId) async {
    if (cardIds.isEmpty) return;
    if (deckId <= 0) {
      throw ArgumentError.value(deckId, 'deckId', 'Choose a valid deck.');
    }
    final request = anki_cards.SetDeckRequest(
      cardIds: cardIds.toSet().map(Int64.new),
      deckId: Int64(deckId),
    );
    await backend.invoke(
      BackendOperation.setDeck,
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
