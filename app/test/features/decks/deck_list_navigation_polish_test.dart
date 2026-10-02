import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('open collection exposes collection-wide statistics and preferences', (
    tester,
  ) async {
    final controller = DeckListController(repository: _Repository());
    final backend = _Backend();

    await tester.pumpWidget(
      MaterialApp(
        home: DeckListPage(
          controller: controller,
          backend: backend,
          pickCollection: () async => '/tmp/collection.anki2',
          openCollection: (_) async {},
        ),
      ),
    );
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Collection statistics'), findsOneWidget);
    expect(find.byTooltip('Preferences'), findsOneWidget);
  });

  testWidgets('empty collection offers a first-deck call to action', (tester) async {
    final controller = DeckListController(repository: _Repository());
    final backend = _Backend();

    await tester.pumpWidget(
      MaterialApp(
        home: DeckListPage(
          controller: controller,
          backend: backend,
          pickCollection: () async => '/tmp/collection.anki2',
          openCollection: (_) async {},
        ),
      ),
    );
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(find.text('No decks yet'), findsOneWidget);
    expect(find.text('Create your first deck'), findsOneWidget);

    await tester.tap(find.text('Create your first deck'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('create-deck-name')),
      'First deck',
    );
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(
      backend.calls.map((call) => call.operation),
      [BackendOperation.newDeck, BackendOperation.addDeck],
    );
  });
}

class _Repository implements DeckRepository {
  @override
  Future<List<DeckNode>> loadDeckTree() async => const [];
}

class _Call {
  const _Call(this.operation);

  final BackendOperation operation;
}

class _Backend implements BackendInvoker {
  final calls = <_Call>[];

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation));
    if (operation == BackendOperation.newDeck) {
      return Uint8List.fromList(
        Deck(common: Deck_Common(), normal: Deck_Normal()).writeToBuffer(),
      );
    }
    if (operation == BackendOperation.addDeck) {
      return Uint8List.fromList(OpChangesWithId(id: Int64(1)).writeToBuffer());
    }
    return Uint8List(0);
  }
}
