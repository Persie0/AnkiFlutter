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
  testWidgets('collection menu navigates to confirmed native database check',
      (tester) async {
    final backend = _Backend();
    final decks = _Decks();
    await tester.pumpWidget(MaterialApp(
      home: DeckListPage(
        controller: DeckListController(repository: decks),
        pickCollection: () async => '/tmp/collection.anki2',
        openCollection: (_) async {},
        backend: backend,
      ),
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('More actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Check database').last);
    await tester.pumpAndSettle();
    expect(find.text('Collection integrity'), findsOneWidget);
    expect(backend.checks, 0);

    await tester.tap(find.byKey(const ValueKey('database-check-run')));
    await tester.pumpAndSettle();
    expect(backend.checks, 0);
    await tester.tap(find.byKey(const ValueKey('database-check-confirm')));
    await tester.pumpAndSettle();

    expect(backend.checks, 1);
    expect(find.text('Check completed: no problems reported.'), findsOneWidget);
    expect(decks.loads, 2); // Collection open + successful check refresh.
  });
}

class _Decks implements DeckRepository {
  int loads = 0;
  @override
  Future<List<DeckNode>> loadDeckTree() async {
    loads++;
    return const [];
  }
}

class _Backend implements BackendInvoker {
  int checks = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    if (operation == BackendOperation.getUndoStatus) {
      return Uint8List.fromList(collection.UndoStatus().writeToBuffer());
    }
    if (operation == BackendOperation.checkDatabase) {
      checks++;
      return Uint8List.fromList(
        collection.CheckDatabaseResponse().writeToBuffer(),
      );
    }
    throw StateError('Unexpected operation: $operation');
  }
}
