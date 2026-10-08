import 'dart:async';

import 'package:anki_flutter/features/collection/check_database_page.dart';
import 'package:anki_flutter/features/collection/data/anki_collection_integrity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('requires confirmation before checking a collection', (tester) async {
    final repository = _Repository();
    var refreshes = 0;
    await tester.pumpWidget(_app(repository, () async => refreshes++));

    expect(repository.checks, 0);
    await tester.tap(find.byKey(const ValueKey('database-check-run')));
    await tester.pumpAndSettle();
    expect(repository.checks, 0);
    expect(find.textContaining('Make a collection backup'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repository.checks, 0);

    await tester.tap(find.byKey(const ValueKey('database-check-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('database-check-confirm')));
    await tester.pumpAndSettle();

    expect(repository.checks, 1);
    expect(refreshes, 1);
    expect(find.text('Check completed: 2 problems reported.'), findsOneWidget);
    expect(find.text('Orphan note'), findsOneWidget);
    expect(find.byKey(const ValueKey('database-check-copy')), findsOneWidget);
  });

  testWidgets('clean collection shows explicit no-problems result', (tester) async {
    final repo = _Repository()..problems = [];
    await tester.pumpWidget(_app(repo));
    await _confirmCheck(tester);
    expect(find.text('Check completed: no problems reported.'), findsOneWidget);
    expect(repo.checks, 1);
  });

  testWidgets('failed checker retains retry and does not report clean collection',
      (tester) async {
    final repo = _Repository()..fail = true;
    await tester.pumpWidget(_app(repo));
    await _confirmCheck(tester);
    expect(find.textContaining('native check failed'), findsOneWidget);
    expect(find.text('Check completed: no problems reported.'), findsNothing);
    expect(find.byKey(const ValueKey('database-check-copy')), findsNothing);

    repo.fail = false;
    await _confirmCheck(tester);
    expect(repo.checks, 2);
    expect(find.text('Check completed: 2 problems reported.'), findsOneWidget);
  });

  testWidgets('in-flight checker disables duplicate runs and refreshes once',
      (tester) async {
    final repo = _Repository();
    final pending = Completer<List<String>>();
    repo.pending = pending;
    var refreshes = 0;
    await tester.pumpWidget(_app(repo, () async => refreshes++));
    await tester.tap(find.byKey(const ValueKey('database-check-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('database-check-confirm')));
    await tester.pump();

    final button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('database-check-run')),
    );
    expect(button.onPressed, isNull);
    expect(repo.checks, 1);
    pending.complete([]);
    await tester.pumpAndSettle();
    expect(repo.checks, 1);
    expect(refreshes, 1);
    expect(find.text('Check completed: no problems reported.'), findsOneWidget);
  });

  testWidgets('deck refresh error is separate from the successful native check',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(
      _app(repo, () async => throw StateError('deck reload failed')),
    );
    await _confirmCheck(tester);
    expect(find.text('Check completed: 2 problems reported.'), findsOneWidget);
    expect(find.textContaining('deck reload failed'), findsOneWidget);
  });

  testWidgets('more than 50 problems are progressively shown', (tester) async {
    final repo = _Repository()
      ..problems = List.generate(65, (i) => 'Problem $i');
    await tester.pumpWidget(_app(repo));
    await _confirmCheck(tester);
    expect(find.text('Check completed: 65 problems reported.'), findsOneWidget);

    final more = find.byKey(const ValueKey('database-check-more'));
    await tester.ensureVisible(more);
    await tester.pumpAndSettle();
    await tester.tap(more);
    await tester.pumpAndSettle();
    expect(more, findsNothing);
    expect(repo.checks, 1);
  });
}

Future<void> _confirmCheck(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('database-check-run')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('database-check-confirm')));
  await tester.pumpAndSettle();
}

Widget _app(_Repository repository, [Future<void> Function()? onChanged]) =>
    MaterialApp(
      home: CheckDatabasePage(
        repository: repository,
        onCollectionChanged: onChanged,
      ),
    );

class _Repository implements CollectionIntegrityRepository {
  var checks = 0;
  var fail = false;
  List<String> problems = ['Invalid card scheduling', 'Orphan note'];
  Completer<List<String>>? pending;

  @override
  Future<List<String>> checkDatabase() async {
    checks++;
    if (fail) throw StateError('native check failed');
    if (pending case final completer?) return completer.future;
    return problems;
  }
}
