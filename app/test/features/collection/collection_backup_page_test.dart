import 'dart:async';

import 'package:anki_flutter/features/collection/collection_backup_page.dart';
import 'package:anki_flutter/features/collection/data/anki_collection_backup_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selects folder, confirms, and reports actual native success',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(_app(repo, () async => '/tmp/backups'));
    await tester.tap(find.byKey(const ValueKey('collection-backup-run')));
    await tester.pumpAndSettle();

    expect(repo.folders, isEmpty);
    expect(find.textContaining('Media files are not included'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('collection-backup-confirm')));
    await tester.pumpAndSettle();

    expect(repo.folders, ['/tmp/backups']);
    expect(find.text('Backup completed in /tmp/backups'), findsOneWidget);
  });

  testWidgets('canceled picker never calls Anki and stays retryable',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(_app(repo, () async => null));
    await tester.tap(find.byKey(const ValueKey('collection-backup-run')));
    await tester.pumpAndSettle();

    expect(repo.folders, isEmpty);
    expect(find.byKey(const ValueKey('collection-backup-result')), findsNothing);
    expect(tester.widget<FilledButton>(
      find.byKey(const ValueKey('collection-backup-run')),
    ).onPressed, isNotNull);
  });

  testWidgets('declining confirmation leaves collection unchanged', (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(_app(repo, () async => '/tmp/backups'));
    await tester.tap(find.byKey(const ValueKey('collection-backup-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repo.folders, isEmpty);
    expect(find.byKey(const ValueKey('collection-backup-result')), findsNothing);
  });

  testWidgets('native false result never claims backup completed', (tester) async {
    final repo = _Repository()..created = false;
    await tester.pumpWidget(_app(repo, () async => '/tmp/backups'));
    await tester.tap(find.byKey(const ValueKey('collection-backup-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('collection-backup-confirm')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Anki did not create a backup'), findsOneWidget);
    expect(find.textContaining('Backup completed'), findsNothing);
  });

  testWidgets('native failure is reported and retry remains enabled', (tester) async {
    final repo = _Repository()..fail = true;
    await tester.pumpWidget(_app(repo, () async => '/tmp/backups'));
    await tester.tap(find.byKey(const ValueKey('collection-backup-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('collection-backup-confirm')));
    await tester.pumpAndSettle();

    expect(find.textContaining('backup failed'), findsOneWidget);
    expect(find.byKey(const ValueKey('collection-backup-result')), findsNothing);
    expect(tester.widget<FilledButton>(
      find.byKey(const ValueKey('collection-backup-run')),
    ).onPressed, isNotNull);
  });

  testWidgets('native backup blocks repeated requests while in progress',
      (tester) async {
    final repo = _Repository();
    final pending = Completer<bool>();
    repo.pending = pending;
    await tester.pumpWidget(_app(repo, () async => '/tmp/backups'));
    await tester.tap(find.byKey(const ValueKey('collection-backup-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('collection-backup-confirm')));
    await tester.pump();

    expect(repo.folders, ['/tmp/backups']);
    expect(tester.widget<FilledButton>(
      find.byKey(const ValueKey('collection-backup-run')),
    ).onPressed, isNull);
    pending.complete(true);
    await tester.pumpAndSettle();
    expect(find.text('Backup completed in /tmp/backups'), findsOneWidget);
  });
}

Widget _app(_Repository repo, BackupDirectoryPicker picker) => MaterialApp(
  home: CollectionBackupPage(repository: repo, pickDirectory: picker),
);

class _Repository implements CollectionBackupRepository {
  final List<String> folders = [];
  bool created = true;
  bool fail = false;
  Completer<bool>? pending;

  @override
  Future<bool> createBackup(String backupDirectory) async {
    folders.add(backupDirectory);
    if (fail) throw StateError('backup failed');
    if (pending case final p?) return p.future;
    return created;
  }
}
