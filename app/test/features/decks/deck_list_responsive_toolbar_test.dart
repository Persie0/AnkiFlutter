import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('narrow screens move secondary collection actions into overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final controller = DeckListController(repository: _Repository());
    await tester.pumpWidget(
      MaterialApp(
        home: DeckListPage(
          controller: controller,
          backend: _Backend(),
          pickCollection: () async => '/tmp/collection.anki2',
          openCollection: (_) async {},
          closeCollection: () async {},
        ),
      ),
    );
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byTooltip('Switch collection'), findsOneWidget);
    expect(find.byTooltip('More actions'), findsOneWidget);
    expect(find.byTooltip('Collection statistics'), findsNothing);

    await tester.tap(find.byTooltip('More actions'));
    await tester.pumpAndSettle();

    expect(find.text('Collection statistics'), findsOneWidget);
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Manage note types'), findsOneWidget);
    expect(find.text('Import & export'), findsOneWidget);
    expect(find.text('Sync'), findsOneWidget);
    expect(find.text('Browse cards'), findsOneWidget);
  });

  testWidgets('wide screens keep collection tools directly accessible', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final controller = DeckListController(repository: _Repository());
    await tester.pumpWidget(
      MaterialApp(
        home: DeckListPage(
          controller: controller,
          backend: _Backend(),
          pickCollection: () async => '/tmp/collection.anki2',
          openCollection: (_) async {},
        ),
      ),
    );
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Collection statistics'), findsOneWidget);
    expect(find.byTooltip('Preferences'), findsOneWidget);
    expect(find.byTooltip('Browse cards'), findsOneWidget);
    expect(find.byTooltip('More actions'), findsNothing);
  });
}

class _Repository implements DeckRepository {
  @override
  Future<List<DeckNode>> loadDeckTree() async => const [];
}

class _Backend implements BackendInvoker {
  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async => Uint8List(0);
}
