import 'dart:async';

import 'package:anki_flutter/features/collection/check_database_page.dart';
import 'package:anki_flutter/features/collection/data/anki_database_check_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('requires explicit confirmation before invoking native check',
      (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(repository.calls, 0);
    await tester.tap(find.byKey(const ValueKey('database-check-run')));
    await tester.pumpAndSettle();
    expect(find.text('Check Anki database?'), findsOneWidget);
    expect(repository.calls, 0);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repository.calls, 0);
    expect(find.text('Anki reported no database problems.'), findsNothing);

    await _confirm(tester);
    expect(repository.calls, 1);
    expect(find.text('Anki reported 2 messages.'), findsOneWidget);
    expect(find.text('Unused database entry corrected'), findsOneWidget);
    expect(find.text('Indexes checked'), findsOneWidget);
  });

  testWidgets('refreshes caller after successful database check', (tester) async {
    final repository = _Repository()..messages = [];
    var refreshes = 0;
    await tester.pumpWidget(_app(
      repository,
      onCollectionChanged: () async => refreshes++,
    ));
    await tester.pumpAndSettle();
    await _confirm(tester);

    expect(refreshes, 1);
    expect(find.text('Anki reported no database problems.'), findsOneWidget);
  });

  testWidgets('deck-list refresh error does not misreport a successful Anki check',
      (tester) async {
    final repository = _Repository()..messages = [];
    await tester.pumpWidget(_app(
      repository,
      onCollectionChanged: () async => throw StateError('refresh blocked'),
    ));
    await tester.pumpAndSettle();
    await _confirm(tester);
    expect(repository.calls, 1);
    expect(find.text('Anki reported no database problems.'), findsOneWidget);
    expect(find.textContaining('refresh blocked'), findsOneWidget);
    expect(find.textContaining('Database check failed:'), findsNothing);
  });

  testWidgets('failure shows error and retains ability to retry',
      (tester) async {
    final repository = _Repository()..fail = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await _confirm(tester);

    expect(find.textContaining('native database failure'), findsOneWidget);
    expect(find.text('Anki reported no database problems.'), findsNothing);
    repository.fail = false;
    await _confirm(tester);
    expect(repository.calls, 2);
    expect(find.text('Anki reported 2 messages.'), findsOneWidget);
  });

  testWidgets('long problem reports are paged without dropping messages',
      (tester) async {
    final repository = _Repository()
      ..messages = List.generate(55, (i) => 'Database message $i');
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await _confirm(tester);

    expect(find.text('Database message 0'), findsOneWidget);
    final pageScroll = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Database message 49'),
      260,
      scrollable: pageScroll,
    );
    expect(find.text('Database message 49'), findsOneWidget);
    expect(find.text('Database message 54'), findsNothing);

    final more = find.byKey(const ValueKey('database-check-more'));
    await tester.scrollUntilVisible(more, 260, scrollable: pageScroll);
    await tester.tap(more);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Database message 54'),
      260,
      scrollable: pageScroll,
    );
    expect(find.text('Database message 54'), findsOneWidget);
  });

  testWidgets('native check locks out overlapping checks', (tester) async {
    final repository = _Repository();
    final pending = Completer<List<String>>();
    repository.pending = pending;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('database-check-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('database-check-confirm')));
    await tester.pump();

    expect(repository.calls, 1);
    expect(
      tester.widget<FilledButton>(
        find.byKey(const ValueKey('database-check-run')),
      ).onPressed,
      isNull,
    );
    pending.complete(const []);
    await tester.pumpAndSettle();
    expect(find.text('Anki reported no database problems.'), findsOneWidget);
  });
}

Future<void> _confirm(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('database-check-run')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('database-check-confirm')));
  await tester.pumpAndSettle();
}

Widget _app(_Repository repository, {Future<void> Function()? onCollectionChanged}) =>
    MaterialApp(
      home: CheckDatabasePage(
        repository: repository,
        onCollectionChanged: onCollectionChanged,
      ),
    );

class _Repository implements DatabaseCheckRepository {
  int calls = 0;
  bool fail = false;
  List<String> messages = ['Unused database entry corrected', 'Indexes checked'];
  Completer<List<String>>? pending;

  @override
  Future<List<String>> checkDatabase() async {
    calls++;
    if (fail) throw StateError('native database failure');
    if (pending case final waiting?) return waiting.future;
    return messages;
  }
}
