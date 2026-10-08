import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const deck = DeckNode(
    id: 29,
    name: 'A long collection deck name that should not overlap its menu',
    newCount: 8,
    learnCount: 3,
    reviewCount: 13,
    filtered: false,
    children: [],
  );

  testWidgets('narrow phone uses overflow and preserves deck actions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    String? searched;
    String? renamed;
    await tester.pumpWidget(MaterialApp(
      home: DeckOverviewPage(
        deck: deck,
        onBrowse: (query) => searched = query,
        onRename: (name) async => renamed = name,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('deck-overview-actions')), findsOneWidget);
    expect(find.byKey(const ValueKey('deck-browse-menu')), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const ValueKey('deck-overview-actions')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse due cards'));
    await tester.pumpAndSettle();
    expect(searched, 'deck:"A long collection deck name that should not overlap its menu" is:due');

    await tester.tap(find.byKey(const ValueKey('deck-overview-actions')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rename deck'));
    await tester.pumpAndSettle();
    expect(find.text('Rename deck'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Updated');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(renamed, 'Updated');
    expect(tester.takeException(), isNull);
  });

  testWidgets('short screens scroll rather than overflow', (tester) async {
    tester.view.physicalSize = const Size(320, 360);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(
      home: DeckOverviewPage(deck: deck),
    ));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Study'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('wide screens retain quick browse and deck action icons', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MaterialApp(
      home: DeckOverviewPage(
        deck: deck,
        onBrowse: (_) {},
        onRename: (_) async {},
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('deck-browse-menu')), findsOneWidget);
    expect(find.byTooltip('Rename deck'), findsOneWidget);
    expect(find.byKey(const ValueKey('deck-overview-actions')), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
