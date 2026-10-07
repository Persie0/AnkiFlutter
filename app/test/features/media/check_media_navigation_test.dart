import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opened collection exposes read-only Check media action', (tester) async {
    final backend = _Backend();
    await tester.pumpWidget(
      MaterialApp(
        home: DeckListPage(
          controller: DeckListController(repository: _EmptyDeckRepository()),
          pickCollection: () async => '/tmp/a.anki2',
          openCollection: (_) async {},
          backend: backend,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Check media'));
    await tester.pumpAndSettle();

    expect(find.text('Collection media audit'), findsOneWidget);
    expect(backend.operations, isEmpty);
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    expect(backend.operations, [BackendOperation.checkMedia]);
    expect(find.text('Missing files: 1'), findsOneWidget);
    expect(find.text('lost.mp3'), findsOneWidget);
  });
}

class _EmptyDeckRepository implements DeckRepository {
  @override
  Future<List<DeckNode>> loadDeckTree() async => const [];
}

class _Backend implements BackendInvoker {
  final List<BackendOperation> operations = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    operations.add(operation);
    if (operation == BackendOperation.checkMedia) {
      return Uint8List.fromList(
        media.CheckMediaResponse(missing: ['lost.mp3']).writeToBuffer(),
      );
    }
    return Uint8List(0);
  }
}
