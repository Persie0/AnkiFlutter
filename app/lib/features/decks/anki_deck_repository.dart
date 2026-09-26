import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart' as pb;
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:fixnum/fixnum.dart';

class AnkiDeckRepository implements DeckRepository {
  AnkiDeckRepository({
    required this.backend,
    required this.unixSeconds,
  });

  final BackendInvoker backend;
  final int Function() unixSeconds;

  @override
  Future<List<DeckNode>> loadDeckTree() async {
    final request = pb.DeckTreeRequest(now: Int64(unixSeconds()));
    final response = await backend.invoke(
      BackendOperation.deckTree,
      Uint8List.fromList(request.writeToBuffer()),
    );
    final root = pb.DeckTreeNode.fromBuffer(response);
    return root.children.map(_mapNode).toList(growable: false);
  }

  DeckNode _mapNode(pb.DeckTreeNode node) {
    return DeckNode(
      id: node.deckId.toInt(),
      name: node.name,
      newCount: node.newCount,
      learnCount: node.learnCount,
      reviewCount: node.reviewCount,
      filtered: node.filtered,
      children: node.children.map(_mapNode).toList(growable: false),
    );
  }
}
