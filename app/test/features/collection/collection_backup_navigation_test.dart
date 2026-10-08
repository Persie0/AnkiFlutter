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
  testWidgets('open collection exposes manual backup screen without starting backup',
      (tester) async {
    final backend = _Backend();
    await tester.pumpWidget(MaterialApp(
      home: DeckListPage(
        controller: DeckListController(repository: _Decks()),
        backend: backend,
        pickCollection: () async => '/tmp/collection.anki2',
        openCollection: (_) async {},
      ),
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Create backup'));
    await tester.pumpAndSettle();

    expect(find.text('Back up collection'), findsOneWidget);
    expect(find.textContaining('not media files'), findsNothing);
    expect(find.textContaining('does not'), findsNothing);
    expect(find.byKey(const ValueKey('collection-backup-run')), findsOneWidget);
    expect(backend.calls, isNot(contains(BackendOperation.createBackup)));
  });

  testWidgets('narrow collection toolbar exposes backup in overflow', (tester) async {
    final backend = _Backend();
    await tester.binding.setSurfaceSize(const Size(420, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      home: DeckListPage(
        controller: DeckListController(repository: _Decks()),
        backend: backend,
        pickCollection: () async => '/tmp/collection.anki2',
        openCollection: (_) async {},
      ),
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('More actions'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create backup'));
    await tester.pumpAndSettle();
    expect(find.text('Back up collection'), findsOneWidget);
    expect(backend.calls, isNot(contains(BackendOperation.createBackup)));
  });
}

class _Decks implements DeckRepository {
  @override
  Future<List<DeckNode>> loadDeckTree() async => const [];
}

class _Backend implements BackendInvoker {
  final calls = <BackendOperation>[];
  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(operation);
    if (operation == BackendOperation.getUndoStatus) {
      return Uint8List.fromList(collection.UndoStatus().writeToBuffer());
    }
    throw StateError('Unexpected operation: $operation');
  }
}
