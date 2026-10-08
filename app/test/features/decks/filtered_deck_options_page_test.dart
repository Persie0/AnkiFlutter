import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart'
    as decks;
import 'package:anki_flutter/features/deck_options/filtered_deck_options_page.dart';
import 'package:anki_flutter/features/decks/data/anki_filtered_deck_options_repository.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_overview_page.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('new filtered deck editor validates name and saves zero-ID config',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(MaterialApp(
      home: FilteredDeckOptionsPage(deckId: 0, repository: repository),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Create filtered deck'), findsWidgets);
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-name')),
      'Revision session',
    );
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-query-0')),
      'is:due',
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey('filtered-options-save')),
    );
    await tester.tap(find.byKey(const ValueKey('filtered-options-save')));
    await tester.pumpAndSettle();

    expect(repository.loads, [0]);
    expect(repository.saved.single.id.toInt(), 0);
    expect(repository.saved.single.name, 'Revision session');
    expect(repository.saved.single.config.searchTerms.single.search, 'is:due');
  });

  testWidgets('overview opens editor and saves native config preserving extras',
      (tester) async {
    final repository = _Repository();
    var changed = 0;
    await tester.pumpWidget(MaterialApp(home: DeckOverviewPage(
      deck: _filtered,
      filteredDeckOptionsRepository: repository,
      onChanged: () async => changed++,
    )));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Filtered deck options'));
    await tester.pumpAndSettle();

    expect(find.text('Filtered deck options'), findsOneWidget);
    expect(find.text('French'), findsWidgets);
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-name')),
      'French exams',
    );
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-query-0')),
      'deck:French is:due',
    );
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-limit-0')),
      '250',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('filtered-options-reschedule')));
    await tester.tap(find.byKey(const ValueKey('filtered-options-reschedule')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('filtered-options-save')));
    await tester.tap(find.byKey(const ValueKey('filtered-options-save')));
    await tester.pumpAndSettle();

    expect(repository.loads, [7]);
    expect(repository.saved, hasLength(1));
    final saved = repository.saved.single;
    expect(saved.name, 'French exams');
    expect(saved.config.reschedule, isFalse);
    expect(saved.config.searchTerms.single.search, 'deck:French is:due');
    expect(saved.config.searchTerms.single.limit, 250);
    expect(saved.config.previewGoodSecs, 600);
    expect(saved.allowEmpty, isTrue);
    expect(changed, 1);
    expect(find.text('Filtered deck options'), findsNothing);
  });

  testWidgets('second search can be added, sorted and removed', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(MaterialApp(
      home: FilteredDeckOptionsPage(deckId: 7, repository: repository),
    ));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const ValueKey('filtered-options-add-search')));
    await tester.tap(find.byKey(const ValueKey('filtered-options-add-search')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('filtered-options-query-1')), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-query-1')),
      'is:due tag:verbs',
    );
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-limit-1')),
      '42',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('filtered-options-save')));
    await tester.tap(find.byKey(const ValueKey('filtered-options-save')));
    await tester.pumpAndSettle();
    expect(repository.saved.single.config.searchTerms, hasLength(2));
    expect(repository.saved.single.config.searchTerms.last.limit, 42);
  });

  testWidgets('invalid search and limit block native save', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(MaterialApp(
      home: FilteredDeckOptionsPage(deckId: 7, repository: repository),
    ));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-query-0')),
      '',
    );
    await tester.enterText(
      find.byKey(const ValueKey('filtered-options-limit-0')),
      'zero',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('filtered-options-save')));
    await tester.tap(find.byKey(const ValueKey('filtered-options-save')));
    await tester.pumpAndSettle();
    expect(find.text('Enter an Anki search query.'), findsOneWidget);
    expect(find.text('Enter a number from 1 to 1,000,000.'), findsOneWidget);
    expect(repository.saved, isEmpty);
  });

  testWidgets('save errors stay visible and do not close editor',
      (tester) async {
    final repository = _Repository()..fail = true;
    await tester.pumpWidget(MaterialApp(
      home: FilteredDeckOptionsPage(deckId: 7, repository: repository),
    ));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('filtered-options-save')));
    await tester.tap(find.byKey(const ValueKey('filtered-options-save')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Could not save filtered deck settings:'), findsOneWidget);
    expect(find.text('Filtered deck options'), findsOneWidget);
  });
}

const _filtered = DeckNode(
  id: 7,
  name: 'French',
  newCount: 1,
  learnCount: 2,
  reviewCount: 3,
  filtered: true,
  children: [],
);

class _Repository implements FilteredDeckOptionsRepository {
  final loads = <int>[];
  final saved = <decks.FilteredDeckForUpdate>[];
  bool fail = false;

  @override
  Future<decks.FilteredDeckForUpdate> load(int deckId) async {
    loads.add(deckId);
    return decks.FilteredDeckForUpdate(
      id: Int64(deckId),
      name: 'French',
      allowEmpty: true,
      config: decks.Deck_Filtered(
        reschedule: true,
        previewGoodSecs: 600,
        searchTerms: [
          decks.Deck_Filtered_SearchTerm(
            search: 'deck:French',
            limit: 100,
            order: decks.Deck_Filtered_SearchTerm_Order.DUE,
          ),
        ],
      ),
    );
  }

  @override
  Future<int> save(decks.FilteredDeckForUpdate draft) async {
    saved.add(draft.deepCopy());
    if (fail) throw StateError('native rejected config');
    return draft.id.toInt();
  }
}
