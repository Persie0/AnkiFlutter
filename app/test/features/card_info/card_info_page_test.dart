import 'dart:async';

import 'package:anki_flutter/features/card_info/card_info_formatters.dart';
import 'package:anki_flutter/features/card_info/card_info_page.dart';
import 'package:anki_flutter/features/card_info/data/card_info_repository.dart';
import 'package:anki_flutter/features/card_info/models/card_info_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('previous Card Info without a target is an empty state', (
    tester,
  ) async {
    final repository = _QueueRepository([]);

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: null,
          kind: CardInfoKind.previous,
        ),
      ),
    );

    expect(find.text('Previous Card Info'), findsOneWidget);
    expect(find.text('No previous card available'), findsOneWidget);
    expect(repository.cardIds, isEmpty);
  });

  testWidgets('current Card Info loads captured card exactly once', (
    tester,
  ) async {
    final repository = _QueueRepository([() async => _data()]);

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: 123,
          kind: CardInfoKind.current,
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text('Current Card Info'), findsOneWidget);
    expect(repository.cardIds, [123]);
    expect(find.text('Identity'), findsOneWidget);
    expect(find.text('French::Verbs'), findsOneWidget);
    expect(find.text('French'), findsOneWidget);
    expect(find.text('Card 1'), findsOneWidget);
    expect(find.text('Basic'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);
  });

  testWidgets('load error stays inside Card Info and Retry uses same card', (
    tester,
  ) async {
    final repository = _QueueRepository([
      () async => throw StateError('card was deleted'),
      () async => _data(),
    ]);

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: 77,
          kind: CardInfoKind.previous,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Could not load card information'), findsOneWidget);
    expect(find.textContaining('card was deleted'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(repository.cardIds, [77, 77]);
    expect(find.text('French::Verbs'), findsOneWidget);
  });

  testWidgets('disposing while load is in flight does not update stale UI', (
    tester,
  ) async {
    final completer = Completer<CardInfoData>();
    final repository = _QueueRepository([() => completer.future]);

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: 123,
          kind: CardInfoKind.current,
        ),
      ),
    );
    await tester.pump();
    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));

    completer.complete(_data());
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('renders scheduling timing FSRS and review history', (
    tester,
  ) async {
    final data = _data(
      history: [
        const CardReviewHistoryEntry(
          unixSeconds: 1_700_001_000,
          reviewKindValue: 1,
          buttonChosen: 3,
          intervalSeconds: 86_400,
          lastIntervalSeconds: 43_200,
          easePermille: 2500,
          takenSeconds: 3.25,
          memoryState: CardInfoMemoryState(stability: 11, difficulty: 4),
        ),
        const CardReviewHistoryEntry(
          unixSeconds: 1_700_000_100,
          reviewKindValue: 99,
          buttonChosen: 1,
          intervalSeconds: 600,
          lastIntervalSeconds: 60,
          easePermille: 0,
          takenSeconds: 5.75,
        ),
      ],
    );
    final repository = _QueueRepository([() async => data]);

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: 123,
          kind: CardInfoKind.current,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Scheduling'), findsOneWidget);
    expect(find.text(formatCardInfoTimestamp(data.dueUnixSeconds!)), findsOneWidget);
    expect(find.text('30 days'), findsOneWidget);
    expect(find.text('250%'), findsWidgets);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('{"x":1}'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Timing'),
      300,
      scrollable: _cardInfoScrollable(),
    );
    expect(find.text(formatCardInfoTimestamp(data.addedUnixSeconds)), findsOneWidget);
    expect(find.text('4.5s'), findsOneWidget);
    expect(find.text('54s'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('FSRS'),
      300,
      scrollable: _cardInfoScrollable(),
    );
    expect(find.textContaining('12.50'), findsOneWidget);
    expect(find.textContaining('4.25'), findsOneWidget);
    expect(find.textContaining('91'), findsOneWidget);
    expect(find.textContaining('90'), findsOneWidget);
    expect(find.text('FSRS parameters'), findsOneWidget);
    await tester.tap(find.text('FSRS parameters'));
    await tester.pumpAndSettle();
    expect(find.textContaining('0.4000'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Review history'),
      300,
      scrollable: _cardInfoScrollable(),
    );
    expect(find.text('Review'), findsOneWidget);
    expect(find.text('Unknown (99)'), findsOneWidget);
    expect(find.text('Button 3'), findsOneWidget);
    expect(find.text('1d'), findsOneWidget);
  });

  testWidgets('shows due position and hides absent optional FSRS fields', (
    tester,
  ) async {
    final data = CardInfoData(
      cardId: 1,
      noteId: 2,
      deck: 'Default',
      cardType: 'Card 1',
      noteType: 'Basic',
      preset: 'Default',
      addedUnixSeconds: 1_700_000_000,
      duePosition: 42,
      intervalDays: 0,
      easePermille: 0,
      reviews: 0,
      lapses: 0,
      averageSeconds: 0,
      totalSeconds: 0,
      customData: '',
      fsrsParameters: const [],
      reviewHistory: const [],
    );
    final repository = _QueueRepository([() async => data]);

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: 1,
          kind: CardInfoKind.current,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Due position'), findsOneWidget);
    expect(find.text('42'), findsOneWidget);
    expect(find.text('FSRS'), findsNothing);
    await tester.scrollUntilVisible(
      find.text('Review history'),
      300,
      scrollable: _cardInfoScrollable(),
    );
    expect(find.text('No review history yet.'), findsOneWidget);
  });

  testWidgets('renders 200 history entries in backend order without overflow', (
    tester,
  ) async {
    final history = [
      for (var index = 0; index < 200; index++)
        CardReviewHistoryEntry(
          unixSeconds: 1_700_100_000 - index,
          reviewKindValue: 1,
          buttonChosen: 3,
          intervalSeconds: 86_400,
          lastIntervalSeconds: 43_200,
          easePermille: 2500,
          takenSeconds: 2,
        ),
    ];
    final repository = _QueueRepository([
      () async => _data(history: history),
    ]);
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: 123,
          kind: CardInfoKind.current,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('card-info-review-0')),
      600,
      scrollable: _cardInfoScrollable(),
    );
    expect(find.byKey(const ValueKey('card-info-review-0')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('card-info-review-199')),
      600,
      scrollable: _cardInfoScrollable(),
    );
    expect(find.byKey(const ValueKey('card-info-review-199')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('wide Card Info layout renders without overflow', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final repository = _QueueRepository([() async => _data()]);

    await tester.pumpWidget(
      _app(
        CardInfoPage(
          repository: repository,
          cardId: 123,
          kind: CardInfoKind.current,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Current Card Info'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Finder _cardInfoScrollable() => find.byType(Scrollable).first;

Widget _app(Widget child) => MaterialApp(home: child);

CardInfoData _data({List<CardReviewHistoryEntry> history = const []}) =>
    CardInfoData(
      cardId: 123,
      noteId: 456,
      deck: 'French::Verbs',
      originalDeck: 'French',
      cardType: 'Card 1',
      noteType: 'Basic',
      preset: 'Default',
      addedUnixSeconds: 1_700_000_000,
      firstReviewUnixSeconds: 1_700_000_100,
      latestReviewUnixSeconds: 1_700_001_000,
      dueUnixSeconds: 1_700_100_000,
      intervalDays: 30,
      easePermille: 2500,
      reviews: 12,
      lapses: 2,
      averageSeconds: 4.5,
      totalSeconds: 54,
      customData: '{"x":1}',
      memoryState: const CardInfoMemoryState(stability: 12.5, difficulty: 4.25),
      retrievability: 0.91,
      desiredRetention: 0.9,
      fsrsParameters: const [0.4, 1.2, 3.5],
      reviewHistory: history,
    );

final class _QueueRepository implements CardInfoRepository {
  _QueueRepository(this.responses);

  final List<Future<CardInfoData> Function()> responses;
  final cardIds = <int>[];
  var _index = 0;

  @override
  Future<CardInfoData> load(int cardId) {
    cardIds.add(cardId);
    return responses[_index++]();
  }
}
