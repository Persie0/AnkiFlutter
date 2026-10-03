import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart'
    as search;
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'open collection deck screen can navigate to shared card browser',
    (tester) async {
      final backend = _Backend();
      final controller = DeckListController(repository: _DeckRepository());
      await tester.pumpWidget(
        MaterialApp(
          home: DeckListPage(
            controller: controller,
            backend: backend,
            pickCollection: () async => '/collection.anki2',
            openCollection: (_) async {},
          ),
        ),
      );

      await tester.tap(find.text('Open Anki Collection'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Browse cards'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Browse cards'), findsOneWidget);
      controller.dispose();
    },
  );
}

class _Backend implements BackendInvoker {
  final operations = <BackendOperation>[];

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    operations.add(operation);
    return switch (operation) {
      BackendOperation.allBrowserColumns =>
        Uint8List.fromList(search.BrowserColumns().writeToBuffer()),
      BackendOperation.searchCards =>
        Uint8List.fromList(search.SearchResponse().writeToBuffer()),
      _ => Uint8List(0),
    };
  }
}

class _DeckRepository implements DeckRepository {
  @override
  Future<List<DeckNode>> loadDeckTree() async => const [];
}
