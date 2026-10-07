import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/features/media/check_media_page.dart';
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('trashing unused media requires confirmation and preserves a cancel',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('media-trash-unused')));
    await tester.pumpAndSettle();
    expect(find.text('Move 2 unused files to trash?'), findsOneWidget);
    expect(repo.trashed, isEmpty);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repo.trashed, isEmpty);
    expect(repo.checks, 1);
    expect(find.byKey(const ValueKey('media-trash-unused')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('media-trash-unused')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-confirm-trash')));
    await tester.pumpAndSettle();

    expect(repo.trashed, [
      ['old.wav', 'unused.png'],
    ]);
    expect(repo.checks, 2);
    expect(find.text('Unused files: 0'), findsOneWidget);
    expect(find.byKey(const ValueKey('media-trash-unused')), findsNothing);
    expect(find.byKey(const ValueKey('media-restore-trash')), findsOneWidget);
  });

  testWidgets('restores previously trashed media after explicit confirmation',
      (tester) async {
    final repo = _Repository()
      ..current = media.CheckMediaResponse(haveTrash: true);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('media-restore-trash')));
    await tester.pumpAndSettle();
    expect(repo.restores, 0);
    await tester.tap(find.byKey(const ValueKey('media-confirm-restore')));
    await tester.pumpAndSettle();

    expect(repo.restores, 1);
    expect(repo.checks, 2);
    expect(find.byKey(const ValueKey('media-restore-trash')), findsNothing);
  });

  testWidgets('backend trash failure leaves last audit and offers retry',
      (tester) async {
    final repo = _Repository()..failTrash = true;
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('media-trash-unused')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-confirm-trash')));
    await tester.pumpAndSettle();

    expect(find.textContaining('trash service failed'), findsOneWidget);
    expect(find.text('Unused files: 2'), findsOneWidget);
    expect(repo.checks, 1);
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('media-trash-unused')),
      ).onPressed,
      isNotNull,
    );
    repo.failTrash = false;
    await tester.tap(find.byKey(const ValueKey('media-trash-unused')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-confirm-trash')));
    await tester.pumpAndSettle();
    expect(repo.checks, 2);
  });

  testWidgets('an in-progress native trash operation locks other mutations',
      (tester) async {
    final repo = _Repository();
    final pending = Completer<void>();
    repo.pendingTrash = pending;
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-trash-unused')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-confirm-trash')));
    await tester.pump();

    expect(
      tester.widget<FilledButton>(find.byKey(const ValueKey('media-check-run')))
          .onPressed,
      isNull,
    );
    expect(
      tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('media-trash-unused')),
      ).onPressed,
      isNull,
    );
    pending.complete();
    await tester.pumpAndSettle();
    expect(repo.checks, 2);
  });
}

Widget _app(_Repository repo) => MaterialApp(
  home: CheckMediaPage(repository: repo),
);

class _Repository implements MediaRepository, MediaTrashRepository {
  int checks = 0;
  int restores = 0;
  bool failTrash = false;
  Completer<void>? pendingTrash;
  final List<List<String>> trashed = [];
  media.CheckMediaResponse current = media.CheckMediaResponse(
    unused: ['old.wav', 'unused.png'],
    report: '2 unused',
  );

  @override
  Future<media.CheckMediaResponse> checkMedia() async {
    checks++;
    return current;
  }

  @override
  Future<void> trashMediaFiles(List<String> filenames) async {
    trashed.add(List.of(filenames));
    if (failTrash) throw StateError('trash service failed');
    if (pendingTrash case final pending?) await pending.future;
    current = media.CheckMediaResponse(
      haveTrash: true,
      report: 'Files in trash',
    );
  }

  @override
  Future<void> restoreMediaTrash() async {
    restores++;
    current = media.CheckMediaResponse(
      haveTrash: false,
      report: 'Restored files',
    );
  }

  @override
  Future<String> addFile({required String desiredName, required Uint8List bytes}) async =>
      desiredName;

  @override
  Future<String> addFromUrl(String url) async => url;

  @override
  Future<String> absolutePath(String filename) async => filename;
}
