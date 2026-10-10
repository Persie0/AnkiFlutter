import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart'
    as stats;
import 'package:anki_flutter/features/statistics/statistics_extra_graphs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> show(
    WidgetTester tester,
    stats.GraphsResponse graphs, {
    int days = 30,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: StatisticsExtraGraphs(graphs: graphs, days: days),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders real history and distributions from native graph maps',
      (tester) async {
    final graphs = stats.GraphsResponse(
      added: stats.GraphsResponse_Added(added: [
        const MapEntry(-2, 3),
        const MapEntry(0, 5),
      ]),
      reviews: stats.GraphsResponse_ReviewCountsAndTimes(count: [
        MapEntry(-1, stats.GraphsResponse_ReviewCountsAndTimes_Reviews(
          learn: 2, relearn: 1, young: 3, mature: 4, filtered: 5,
        )),
      ]),
      intervals: stats.GraphsResponse_Intervals(intervals: [
        const MapEntry(1, 8),
        const MapEntry(7, 2),
      ]),
      buttons: stats.GraphsResponse_Buttons(
        oneMonth: stats.GraphsResponse_Buttons_ButtonCounts(
          learning: [1, 2, 3, 4],
          young: [2, 3, 4, 5],
          mature: [3, 4, 5, 6],
        ),
      ),
      hours: stats.GraphsResponse_Hours(
        oneMonth: List.generate(
          24,
          (i) => stats.GraphsResponse_Hours_Hour(total: i == 9 ? 7 : 0),
        ),
      ),
    );
    await show(tester, graphs);

    expect(find.byKey(const ValueKey('stats-added')), findsOneWidget);
    expect(find.text('Cards added'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('2d ago'), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-review-history')), findsOneWidget);
    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-study-hours')), findsOneWidget);
    expect(find.text('09:00'), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-answer-buttons')), findsOneWidget);
    expect(find.text('Again'), findsOneWidget);
    expect(find.text('Hard'), findsOneWidget);
    expect(find.text('Good'), findsOneWidget);
    expect(find.text('Easy'), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-intervals')), findsOneWidget);
    expect(find.text('7d'), findsOneWidget);
  });

  testWidgets('matches selected date range without using other hour buckets',
      (tester) async {
    final graphs = stats.GraphsResponse(
      hours: stats.GraphsResponse_Hours(
        oneMonth: [stats.GraphsResponse_Hours_Hour(total: 0)],
        oneYear: [
          stats.GraphsResponse_Hours_Hour(total: 0),
          stats.GraphsResponse_Hours_Hour(total: 6),
        ],
      ),
    );
    await show(tester, graphs);
    expect(find.byKey(const ValueKey('stats-study-hours')), findsNothing);
    await show(tester, graphs, days: 365);
    expect(find.byKey(const ValueKey('stats-study-hours')), findsOneWidget);
    expect(find.text('01:00'), findsOneWidget);
  });

  testWidgets('FSRS graphs are shown only for an FSRS collection',
      (tester) async {
    final graphs = stats.GraphsResponse(
      fsrs: true,
      difficulty: stats.GraphsResponse_Eases(eases: [
        const MapEntry(5, 8),
      ]),
      stability: stats.GraphsResponse_Intervals(intervals: [
        const MapEntry(30, 2),
      ]),
      retrievability: stats.GraphsResponse_Retrievability(retrievability: [
        const MapEntry(90, 4),
      ]),
    );
    await show(tester, graphs);
    expect(find.byKey(const ValueKey('stats-fsrs-difficulty')), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-fsrs-stability')), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-fsrs-retrievability')),
        findsOneWidget);

    graphs.fsrs = false;
    await show(tester, graphs);
    expect(find.byKey(const ValueKey('stats-fsrs-difficulty')), findsNothing);
    expect(find.byKey(const ValueKey('stats-fsrs-stability')), findsNothing);
    expect(find.byKey(const ValueKey('stats-fsrs-retrievability')), findsNothing);
  });

  testWidgets('long histograms can expand without losing totals',
      (tester) async {
    final graphs = stats.GraphsResponse(
      added: stats.GraphsResponse_Added(
        added: [
          for (var i = -19; i <= 0; i++) MapEntry(i, 1),
        ],
      ),
    );
    await show(tester, graphs);
    expect(find.text('20 total'), findsOneWidget);
    expect(find.text('19d ago'), findsNothing);
    await tester.ensureVisible(
        find.byKey(const ValueKey('stats-show-more-Cards added')));
    await tester.tap(find.byKey(const ValueKey('stats-show-more-Cards added')));
    await tester.pumpAndSettle();
    expect(find.text('19d ago'), findsOneWidget);
    expect(find.text('20 total'), findsOneWidget);
  });

  testWidgets('no backend graph data produces no made-up chart',
      (tester) async {
    await show(tester, stats.GraphsResponse());
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(find.byType(Card), findsNothing);
  });
}
