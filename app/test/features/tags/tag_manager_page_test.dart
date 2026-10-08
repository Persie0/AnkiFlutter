import 'package:anki_flutter/features/tags/data/anki_tag_manager_repository.dart';
import 'package:anki_flutter/features/tags/tag_manager_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tag filter and browse delegate escaped exact native query', (
    tester,
  ) async {
    final repo = _Tags();
    final searches = <String>[];
    await tester.pumpWidget(_app(repo, onBrowse: searches.add));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('tag-row-French')), findsOneWidget);
    expect(find.byKey(const ValueKey('tag-row-Exam')), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('tag-filter')), 'verbs');
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('tag-row-French::verbs')), findsOneWidget);
    expect(find.byKey(const ValueKey('tag-row-Exam')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('tag-row-French::verbs')));
    await tester.pump();
    expect(searches, ['tag:"French::verbs"']);
  });

  testWidgets('rename shows native result and refreshes the list', (
    tester,
  ) async {
    final repo = _Tags();
    var changed = 0;
    await tester.pumpWidget(_app(repo, onChanged: () async { changed++; }));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('tag-actions-French')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rename').last);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('tag-rename-input')),
      'Languages::French',
    );
    await tester.tap(find.byKey(const ValueKey('tag-rename-confirm')));
    await tester.pumpAndSettle();
    expect(repo.renames, ['French => Languages::French']);
    expect(find.byKey(const ValueKey('tag-row-Languages::French')),
        findsOneWidget);
    expect(changed, 1);
    expect(find.textContaining('Renamed "French"'), findsOneWidget);
  });

  testWidgets('removing tags is confirmed and never deletes notes', (
    tester,
  ) async {
    final repo = _Tags();
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tag-actions-Exam')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove').last);
    await tester.pumpAndSettle();
    expect(find.text('Remove tag?'), findsOneWidget);
    expect(find.textContaining('Cards and notes will not be deleted'),
        findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repo.deleted, isEmpty);
    await tester.tap(find.byKey(const ValueKey('tag-actions-Exam')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tag-delete-confirm')));
    await tester.pumpAndSettle();
    expect(repo.deleted, ['Exam']);
    expect(find.byKey(const ValueKey('tag-row-Exam')), findsNothing);
  });

  testWidgets('unused-tag cleanup is confirmed before native operation', (
    tester,
  ) async {
    final repo = _Tags();
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tag-cleanup')));
    await tester.pumpAndSettle();
    expect(find.text('Remove unused tags?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repo.cleanupCount, 0);

    await tester.tap(find.byKey(const ValueKey('tag-cleanup')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tag-cleanup-confirm')));
    await tester.pumpAndSettle();
    expect(repo.cleanupCount, 1);
    expect(find.byKey(const ValueKey('tag-row-Exam')), findsNothing);
  });

  testWidgets('native rename errors keep screen open and display failure', (
    tester,
  ) async {
    final repo = _Tags()..fail = true;
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tag-actions-French')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rename').last);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('tag-rename-input')), 'German',
    );
    await tester.tap(find.byKey(const ValueKey('tag-rename-confirm')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Could not change tags:'), findsOneWidget);
    expect(find.byKey(const ValueKey('tag-row-French')), findsOneWidget);
  });
}

Widget _app(
  _Tags repository, {
  ValueChanged<String>? onBrowse,
  Future<void> Function()? onChanged,
}) => MaterialApp(
  home: TagManagerPage(
    repository: repository,
    onBrowse: onBrowse,
    onChanged: onChanged,
  ),
);

class _Tags implements TagManagerRepository {
  final tags = ['Exam', 'French', 'French::verbs'];
  final renames = <String>[];
  final deleted = <String>[];
  int cleanupCount = 0;
  bool fail = false;

  @override
  Future<List<String>> allTags() async => List.of(tags);

  @override
  Future<int> rename(String oldName, String newName) async {
    if (fail) throw StateError('Anki database rejected rename');
    renames.add('$oldName => $newName');
    tags[tags.indexOf(oldName)] = newName;
    return 1;
  }

  @override
  Future<int> remove(String name) async {
    if (fail) throw StateError('Native error');
    deleted.add(name);
    tags.remove(name);
    return 1;
  }

  @override
  Future<int> clearUnused() async {
    if (fail) throw StateError('Native error');
    cleanupCount++;
    tags.remove('Exam');
    return 1;
  }
}
