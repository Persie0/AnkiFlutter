import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pinned Anki DeckTreeNode protobuf round-trips counts and children', () {
    final node = DeckTreeNode(
      deckId: Int64(42),
      name: 'Languages',
      newCount: 3,
      learnCount: 2,
      reviewCount: 7,
      children: [DeckTreeNode(deckId: Int64(43), name: 'Norwegian')],
    );

    final decoded = DeckTreeNode.fromBuffer(node.writeToBuffer());
    expect(decoded.deckId.toInt(), 42);
    expect(decoded.name, 'Languages');
    expect(decoded.newCount, 3);
    expect(decoded.learnCount, 2);
    expect(decoded.reviewCount, 7);
    expect(decoded.children.single.name, 'Norwegian');
  });
}
