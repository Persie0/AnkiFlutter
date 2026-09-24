import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:anki_flutter/features/decks/anki_deck_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps the Anki deck tree recursively without changing names or counts', () async {
    final backend = _FakeBackend(
      DeckTreeNode(
        deckId: Int64.ZERO,
        name: 'root',
        children: [
          DeckTreeNode(
            deckId: Int64(10),
            name: 'Languages::Norwegian',
            newCount: 12,
            learnCount: 3,
            reviewCount: 45,
            children: [
              DeckTreeNode(
                deckId: Int64(11),
                name: 'Nested::Literal',
                newCount: 1,
                learnCount: 2,
                reviewCount: 3,
                filtered: true,
              ),
            ],
          ),
          DeckTreeNode(
            deckId: Int64(20),
            name: 'Work',
            newCount: 7,
            learnCount: 8,
            reviewCount: 9,
          ),
        ],
      ).writeToBuffer(),
    );
    final repository = AnkiDeckRepository(
      backend: backend,
      unixSeconds: () => 1800000000,
    );

    final decks = await repository.loadDeckTree();

    expect(decks, hasLength(2));
    expect(decks.first.id, 10);
    expect(decks.first.name, 'Languages::Norwegian');
    expect(decks.first.newCount, 12);
    expect(decks.first.learnCount, 3);
    expect(decks.first.reviewCount, 45);
    expect(decks.first.filtered, isFalse);
    expect(decks.first.children, hasLength(1));
    expect(decks.first.children.single.id, 11);
    expect(decks.first.children.single.name, 'Nested::Literal');
    expect(decks.first.children.single.newCount, 1);
    expect(decks.first.children.single.learnCount, 2);
    expect(decks.first.children.single.reviewCount, 3);
    expect(decks.first.children.single.filtered, isTrue);
    expect(decks.last.id, 20);
    expect(decks.last.name, 'Work');
  });

  test('requests Anki deck counts at the injected current timestamp', () async {
    final backend = _FakeBackend(
      DeckTreeNode(deckId: Int64.ZERO, name: 'root').writeToBuffer(),
    );
    final repository = AnkiDeckRepository(
      backend: backend,
      unixSeconds: () => 1800000000,
    );

    await repository.loadDeckTree();

    expect(backend.operation, BackendOperation.deckTree);
    final request = DeckTreeRequest.fromBuffer(backend.request!);
    expect(request.now.toInt(), 1800000000);
  });
}

class _FakeBackend implements BackendInvoker {
  _FakeBackend(List<int> response) : response = Uint8List.fromList(response);

  final Uint8List response;
  BackendOperation? operation;
  Uint8List? request;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    this.operation = operation;
    this.request = request;
    return response;
  }
}
