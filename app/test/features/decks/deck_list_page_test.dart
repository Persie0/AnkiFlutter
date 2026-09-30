import 'dart:async';

import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const nestedDecks = [
    DeckNode(
      id: 1,
      name: 'Languages',
      newCount: 12,
      learnCount: 3,
      reviewCount: 45,
      filtered: false,
      children: [
        DeckNode(
          id: 2,
          name: 'Norwegian',
          newCount: 4,
          learnCount: 1,
          reviewCount: 8,
          filtered: false,
          children: [
            DeckNode(
              id: 3,
              name: 'Verbs',
              newCount: 2,
              learnCount: 0,
              reviewCount: 5,
              filtered: false,
              children: [],
            ),
          ],
        ),
      ],
    ),
  ];

  testWidgets('initial screen offers opening an Anki collection', (tester) async {
    final controller = DeckListController(repository: _FixedRepository(const []));

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => null,
      openCollection: (_) async {},
    ));

    expect(find.text('Open Anki Collection'), findsOneWidget);
    expect(find.text('Decks'), findsNothing);
  });

  testWidgets('picker cancellation leaves initial screen without an error', (tester) async {
    var openCalls = 0;
    final controller = DeckListController(repository: _FixedRepository(const []));

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => null,
      openCollection: (_) async => openCalls++,
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(openCalls, 0);
    expect(find.text('Open Anki Collection'), findsOneWidget);
    expect(find.byKey(const ValueKey('collection-error')), findsNothing);
  });

  testWidgets('an open collection can be switched without leaving the deck list', (tester) async {
    final controller = DeckListController(repository: _FixedRepository(nestedDecks));
    final selectedPaths = <String?>[
      '/tmp/collection.anki2',
      '/tmp/next.anki2',
    ];
    final openedPaths = <String>[];

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => selectedPaths.removeAt(0),
      openCollection: (path) async => openedPaths.add(path),
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Switch collection'));
    await tester.pumpAndSettle();

    expect(openedPaths, ['/tmp/collection.anki2', '/tmp/next.anki2']);
    expect(find.text('Languages'), findsOneWidget);
    expect(find.byTooltip('Switch collection'), findsOneWidget);
  });

  testWidgets('a failed switch keeps the current deck list visible', (tester) async {
    final controller = DeckListController(repository: _FixedRepository(nestedDecks));
    final selectedPaths = <String?>[
      '/tmp/collection.anki2',
      '/tmp/broken.anki2',
    ];

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => selectedPaths.removeAt(0),
      openCollection: (path) async {
        if (path == '/tmp/broken.anki2') {
          throw StateError('collection is unavailable');
        }
      },
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Switch collection'));
    await tester.pumpAndSettle();

    expect(find.text('Languages'), findsOneWidget);
    expect(find.byKey(const ValueKey('collection-operation-error')), findsOneWidget);
  });

  testWidgets('closing a collection returns to the open collection screen', (tester) async {
    final controller = DeckListController(repository: _FixedRepository(nestedDecks));
    var closeCalls = 0;

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => '/tmp/collection.anki2',
      openCollection: (_) async {},
      closeCollection: () async => closeCalls++,
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Close collection'));
    await tester.pumpAndSettle();

    expect(closeCalls, 1);
    expect(find.text('Open Anki Collection'), findsOneWidget);
    expect(find.text('Languages'), findsNothing);
  });

  testWidgets('opening and loading a collection shows progress', (tester) async {
    final completer = Completer<List<DeckNode>>();
    final controller = DeckListController(repository: _CompleterRepository(completer));

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => '/tmp/collection.anki2',
      openCollection: (_) async {},
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    completer.complete(const []);
    await tester.pumpAndSettle();
  });

  testWidgets('ready state shows exact Anki counts and hierarchy indentation', (tester) async {
    final controller = DeckListController(repository: _FixedRepository(nestedDecks));

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => '/tmp/collection.anki2',
      openCollection: (_) async {},
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(find.text('New'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);
    expect(find.text('Review'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('45'), findsOneWidget);

    final parentPadding = tester.widget<Padding>(find.byKey(const ValueKey('deck-row-1'))).padding as EdgeInsets;
    final childPadding = tester.widget<Padding>(find.byKey(const ValueKey('deck-row-2'))).padding as EdgeInsets;
    final grandchildPadding = tester.widget<Padding>(find.byKey(const ValueKey('deck-row-3'))).padding as EdgeInsets;
    expect(childPadding.left, greaterThan(parentPadding.left));
    expect(grandchildPadding.left, greaterThan(childPadding.left));
  });

  testWidgets('deck load failure is readable and Retry can recover', (tester) async {
    final repository = _SequenceRepository([StateError('broken deck tree'), nestedDecks]);
    final controller = DeckListController(repository: repository);

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => '/tmp/collection.anki2',
      openCollection: (_) async {},
    ));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(find.textContaining('broken deck tree'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(repository.calls, 2);
    expect(find.text('Languages'), findsOneWidget);
  });

  testWidgets('backend startup error is actionable', (tester) async {
    final controller = DeckListController(repository: _FixedRepository(const []));

    await tester.pumpWidget(_app(
      controller: controller,
      pickCollection: () async => null,
      openCollection: (_) async {},
      startupError: StateError('native library unavailable'),
    ));

    expect(find.textContaining('Anki backend'), findsOneWidget);
    expect(find.textContaining('native library unavailable'), findsOneWidget);
  });
}

Widget _app({
  required DeckListController controller,
  required Future<String?> Function() pickCollection,
  required Future<void> Function(String path) openCollection,
  Future<void> Function()? closeCollection,
  Object? startupError,
}) {
  return MaterialApp(
    home: DeckListPage(
      controller: controller,
      pickCollection: pickCollection,
      openCollection: openCollection,
      closeCollection: closeCollection,
      startupError: startupError,
    ),
  );
}

class _FixedRepository implements DeckRepository {
  _FixedRepository(this.decks);
  final List<DeckNode> decks;

  @override
  Future<List<DeckNode>> loadDeckTree() async => decks;
}

class _CompleterRepository implements DeckRepository {
  _CompleterRepository(this.completer);
  final Completer<List<DeckNode>> completer;

  @override
  Future<List<DeckNode>> loadDeckTree() => completer.future;
}

class _SequenceRepository implements DeckRepository {
  _SequenceRepository(this.outcomes);
  final List<Object> outcomes;
  int calls = 0;

  @override
  Future<List<DeckNode>> loadDeckTree() async {
    final outcome = outcomes[calls++];
    if (outcome is Error) {
      throw outcome;
    }
    return outcome as List<DeckNode>;
  }
}
