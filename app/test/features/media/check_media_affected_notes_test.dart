import 'dart:typed_data';

import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/features/media/check_media_page.dart';
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('browse receives deduplicated real note IDs from native audit',
      (tester) async {
    final repo = _Repository();
    List<int>? browsed;
    await tester.pumpWidget(MaterialApp(
      home: CheckMediaPage(
        repository: repo,
        onBrowseAffectedNotes: (ids) => browsed = ids,
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    final browse = find.byKey(const ValueKey('media-browse-affected-notes'));
    await tester.ensureVisible(browse);
    await tester.pumpAndSettle();
    expect(find.text('Browse affected notes (2)'), findsOneWidget);
    await tester.tap(browse);
    await tester.pumpAndSettle();
    expect(browsed, [42, 91]);
    expect(() => browsed!.add(100), throwsUnsupportedError);
    expect(repo.checks, 1);
  });

  testWidgets('opens affected note and refreshes audit only after save',
      (tester) async {
    final repo = _Repository();
    final edited = <int>[];
    await tester.pumpWidget(MaterialApp(
      home: CheckMediaPage(
        repository: repo,
        onOpenNote: (id) async {
          edited.add(id);
          repo.result = media.CheckMediaResponse(report: 'Updated notes');
          return true;
        },
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    final open = find.byKey(const ValueKey('media-open-note-42'));
    await tester.ensureVisible(open);
    await tester.pumpAndSettle();
    await tester.tap(open);
    await tester.pumpAndSettle();

    expect(edited, [42]);
    expect(repo.checks, 2);
    expect(find.text('Affected notes: 0'), findsOneWidget);
    expect(find.byKey(const ValueKey('media-open-note-42')), findsNothing);
  });

  testWidgets('canceling note editing preserves the audit and does not rescan',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(MaterialApp(
      home: CheckMediaPage(
        repository: repo,
        onOpenNote: (_) async => false,
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    final open = find.byKey(const ValueKey('media-open-note-91'));
    await tester.ensureVisible(open);
    await tester.pumpAndSettle();
    await tester.tap(open);
    await tester.pumpAndSettle();

    expect(repo.checks, 1);
    expect(find.text('Affected notes: 3'), findsOneWidget);
  });

  testWidgets('failed note navigation keeps audit available and shows error',
      (tester) async {
    final repo = _Repository();
    await tester.pumpWidget(MaterialApp(
      home: CheckMediaPage(
        repository: repo,
        onOpenNote: (_) async => throw StateError('editor unavailable'),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();
    final open = find.byKey(const ValueKey('media-open-note-42'));
    await tester.ensureVisible(open);
    await tester.pumpAndSettle();
    await tester.tap(open);
    await tester.pumpAndSettle();

    expect(find.textContaining('editor unavailable'), findsOneWidget);
    expect(repo.checks, 1);
  });

  testWidgets('read-only media audit without navigation callbacks has no links',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: CheckMediaPage(repository: _Repository())));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('media-browse-affected-notes')), findsNothing);
    expect(find.byKey(const ValueKey('media-open-note-42')), findsNothing);
  });
}

class _Repository implements MediaRepository {
  int checks = 0;
  media.CheckMediaResponse result = media.CheckMediaResponse(
    missingMediaNotes: [Int64(42), Int64(91), Int64(42)],
    missing: ['clip.mp3'],
    report: 'Missing reference',
  );

  @override
  Future<media.CheckMediaResponse> checkMedia() async {
    checks++;
    return result;
  }

  @override
  Future<String> addFile({
    required String desiredName,
    required Uint8List bytes,
  }) async => desiredName;

  @override
  Future<String> addFromUrl(String url) async => url;

  @override
  Future<String> absolutePath(String filename) async => filename;
}
