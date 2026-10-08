import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('open collection exposes database check but does not execute it',
      (tester) async {
    final backend = _Backend();
    await tester.pumpWidget(MaterialApp(
      home: DeckListPage(
        controller: DeckListController(repository: _EmptyDecks()),
        pickCollection: () async => '/tmp/collection.anki2',
        openCollection: (_) async {},
        backend: backend,
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Check database'));
    await tester.pumpAndSettle();

    expect(find.text('Collection database integrity'), findsOneWidget);
    expect(backend.calls, [BackendOperation.getUndoStatus]);

    await tester.tap(find.byKey(const ValueKey('database-check-run')));
    await tester.pumpAndSettle();
    expect(backend.calls, [BackendOperation.getUndoStatus]);
    await tester.tap(find.byKey(const ValueKey('database-check-confirm')));
    await tester.pumpAndSettle();

    expect(backend.calls.where((op) => op == BackendOperation.checkDatabase),
        hasLength(1));
    expect(find.text('Anki reported no database problems.'), findsOneWidget);
  });
}

class _EmptyDecks implements DeckRepository {
  @override
  Future<List<DeckNode>> loadDeckTree() async => const [];
}

class _Backend implements BackendInvoker {
  final calls = <BackendOperation>[];
  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(operation);
    if (operation == BackendOperation.checkDatabase) {
      return Uint8List.fromList(
        collection.CheckDatabaseResponse().writeToBuffer(),
      );
    }
    return Uint8List(0);
  }
}
