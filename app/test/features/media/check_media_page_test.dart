import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/features/media/check_media_page.dart';
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('does not scan until explicitly requested; shows native findings',
      (tester) async {
    final repository = _MediaRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(repository.checks, 0);
    expect(find.text('Check collection media'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    expect(repository.checks, 1);
    expect(find.text('Missing files: 2'), findsOneWidget);
    expect(find.text('Unused files: 1'), findsOneWidget);
    expect(find.text('Affected notes: 2'), findsOneWidget);
    expect(find.text('missing.mp3'), findsOneWidget);
    expect(find.text('missing-image.png'), findsOneWidget);
    expect(find.text('Anki media report'), findsOneWidget);
    expect(find.text('Media trash exists.'), findsOneWidget);

    // SelectableText creates its own internal Scrollable. Only the outer
    // page scroll view should drive the viewport.
    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('old.wav'),
      220,
      scrollable: scrollable,
    );
    expect(find.text('old.wav'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Note ID 91'),
      220,
      scrollable: scrollable,
    );
    expect(find.text('Note ID 42'), findsOneWidget);
    expect(find.text('Note ID 91'), findsOneWidget);
  });

  testWidgets('long native lists are initially limited, with Show more',
      (tester) async {
    final repository = _MediaRepository()
      ..result = media.CheckMediaResponse(
        missing: List.generate(55, (i) => 'file-$i.mp3'),
        report: '55 missing',
      );
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    expect(find.text('file-0.mp3'), findsOneWidget);
    expect(find.text('file-49.mp3'), findsOneWidget);
    expect(find.text('file-54.mp3'), findsNothing);
    expect(find.byKey(const ValueKey('media-check-more-missing')), findsOneWidget);

    final showMore = find.byKey(const ValueKey('media-check-more-missing'));
    await tester.ensureVisible(showMore);
    await tester.pumpAndSettle();
    await tester.tap(showMore);
    await tester.pumpAndSettle();

    expect(find.text('file-54.mp3'), findsOneWidget);
    expect(find.byKey(const ValueKey('media-check-more-missing')), findsNothing);
  });

  testWidgets('scan failure offers retry, never fabricates success', (tester) async {
    final repository = _MediaRepository()..fail = true;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    expect(find.textContaining('native scan failed'), findsOneWidget);
    expect(find.text('Missing files: 2'), findsNothing);
    repository.fail = false;
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();
    expect(repository.checks, 2);
    expect(find.text('Missing files: 2'), findsOneWidget);
  });

  testWidgets('busy state prevents concurrent scans', (tester) async {
    final repository = _MediaRepository();
    final pending = Completer<media.CheckMediaResponse>();
    repository.pending = pending;
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pump();

    expect(repository.checks, 1);
    expect(
      tester.widget<FilledButton>(
        find.byKey(const ValueKey('media-check-run')),
      ).onPressed,
      isNull,
    );
    pending.complete(repository.result);
    await tester.pumpAndSettle();
    expect(find.text('Missing files: 2'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(
        find.byKey(const ValueKey('media-check-run')),
      ).onPressed,
      isNotNull,
    );
  });

  testWidgets('subsequent scan replaces results without stale file lists',
      (tester) async {
    final repository = _MediaRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    repository.result = media.CheckMediaResponse(report: 'Everything is present.');
    await tester.tap(find.byKey(const ValueKey('media-check-run')));
    await tester.pumpAndSettle();

    expect(repository.checks, 2);
    expect(find.text('Missing files: 0'), findsOneWidget);
    expect(find.text('Unused files: 0'), findsOneWidget);
    expect(find.text('old.wav'), findsNothing);
    expect(find.text('Everything is present.'), findsOneWidget);
  });
}

Widget _app(_MediaRepository repository) => MaterialApp(
  home: CheckMediaPage(repository: repository),
);

class _MediaRepository implements MediaRepository {
  var checks = 0;
  bool fail = false;
  Completer<media.CheckMediaResponse>? pending;
  media.CheckMediaResponse result = media.CheckMediaResponse(
    missing: ['missing.mp3', 'missing-image.png'],
    unused: ['old.wav'],
    missingMediaNotes: [Int64(42), Int64(91)],
    report: 'Anki media report',
    haveTrash: true,
  );

  @override
  Future<media.CheckMediaResponse> checkMedia() async {
    checks++;
    if (fail) throw StateError('native scan failed');
    if (pending case final p?) return p.future;
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
