import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('deck opens overview and back keeps collection loaded', (tester) async {
    const deck = DeckNode(
      id: 7,
      name: 'Norwegian',
      newCount: 12,
      learnCount: 3,
      reviewCount: 45,
      filtered: false,
      children: [],
    );
    var openCalls = 0;
    final controller = DeckListController(repository: _FixedRepository(const [deck]));

    await tester.pumpWidget(MaterialApp(
      home: DeckListPage(
        controller: controller,
        pickCollection: () async => '/tmp/collection.anki2',
        openCollection: (_) async => openCalls++,
      ),
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    expect(openCalls, 1);

    await tester.tap(find.text('Norwegian'));
    await tester.pumpAndSettle();

    expect(find.text('Norwegian'), findsOneWidget);
    expect(find.text('New 12'), findsOneWidget);
    expect(find.text('Learn 3'), findsOneWidget);
    expect(find.text('Review 45'), findsOneWidget);
    expect(find.byTooltip('Reviewer coming next'), findsOneWidget);
    final study = tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Study'));
    expect(study.onPressed, isNull);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(openCalls, 1);
    expect(find.text('Decks'), findsOneWidget);
    expect(find.text('Norwegian'), findsOneWidget);
  });
}

class _FixedRepository implements DeckRepository {
  _FixedRepository(this.decks);
  final List<DeckNode> decks;

  @override
  Future<List<DeckNode>> loadDeckTree() async => decks;
}
