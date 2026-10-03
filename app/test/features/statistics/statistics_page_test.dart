import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart' as stats;
import 'package:anki_flutter/features/statistics/data/anki_statistics_repository.dart';
import 'package:anki_flutter/features/statistics/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows backend statistics and reloads when range changes', (
    tester,
  ) async {
    final repository = _Repository();
    await tester.pumpWidget(
      MaterialApp(home: StatisticsPage(repository: repository)),
    );
    await tester.pumpAndSettle();

    expect(repository.requestedDays, [30]);
    expect(find.text('42'), findsOneWidget);
    expect(find.text('83%'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(find.text('120'), findsOneWidget);

    final statisticsList = find.descendant(
      of: find.byType(RefreshIndicator),
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      find.text('True retention'),
      200,
      scrollable: statisticsList,
    );
    expect(find.text('True retention'), findsOneWidget);
    expect(find.text('90%'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('stats-range-365')));
    await tester.pumpAndSettle();

    expect(repository.requestedDays, [30, 365]);
  });

  testWidgets('surfaces graph loading errors and can retry', (tester) async {
    final repository = _Repository(failOnce: true);
    await tester.pumpWidget(
      MaterialApp(home: StatisticsPage(repository: repository)),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Could not load statistics'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('statistics-retry')));
    await tester.pumpAndSettle();

    expect(repository.requestedDays, [30, 30]);
    expect(find.text('42'), findsOneWidget);
  });
}

class _Repository implements StatisticsRepository {
  _Repository({this.failOnce = false});

  final bool failOnce;
  final requestedDays = <int>[];
  var _failed = false;

  @override
  Future<stats.GraphsResponse> graphs({String search = '', int days = 0}) async {
    requestedDays.add(days);
    if (failOnce && !_failed) {
      _failed = true;
      throw StateError('backend failed');
    }
    return stats.GraphsResponse(
      today: stats.GraphsResponse_Today(
        answerCount: 42,
        answerMillis: 120000,
        correctCount: 35,
        learnCount: 5,
        reviewCount: 30,
        relearnCount: 7,
      ),
      cardCounts: stats.GraphsResponse_CardCounts(
        excludingInactive: stats.GraphsResponse_CardCounts_Counts(
          newCards: 120,
          learn: 12,
          relearn: 3,
          young: 80,
          mature: 200,
          suspended: 4,
          buried: 2,
        ),
      ),
      trueRetention: stats.GraphsResponse_TrueRetentionStats(
        month: stats.GraphsResponse_TrueRetentionStats_TrueRetention(
          youngPassed: 72,
          youngFailed: 8,
          maturePassed: 18,
          matureFailed: 2,
        ),
      ),
    );
  }
}
