import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notetypes/data/anki_notetype_repository.dart';
import 'package:anki_flutter/features/notetypes/notetype_list_page.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows note type names and affected note counts', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(MaterialApp(home: NotetypeListPage(repository: repository)));
    await tester.pumpAndSettle();

    expect(find.text('Basic'), findsOneWidget);
    expect(find.text('4 notes'), findsOneWidget);
  });

  testWidgets('confirms affected note count before deleting', (tester) async {
    final repository = _Repository();
    await tester.pumpWidget(MaterialApp(home: NotetypeListPage(repository: repository)));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Note type actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.textContaining('affects 4 notes'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('confirm-delete-notetype')));
    await tester.pumpAndSettle();

    expect(repository.removedId, 12);
  });
}

class _Repository implements NotetypeRepository {
  int? removedId;

  @override
  Future<notetypes.NotetypeUseCounts> listNotetypes() async =>
      notetypes.NotetypeUseCounts(
        entries: [
          notetypes.NotetypeNameIdUseCount(
            id: Int64(12),
            name: 'Basic',
            useCount: 4,
          ),
        ],
      );

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async =>
      notetypes.Notetype(id: Int64(notetypeId), name: 'Basic');

  @override
  Future<void> updateNotetype(notetypes.Notetype notetype) async {}

  @override
  Future<void> duplicateNotetype(int sourceNotetypeId, String name) async {}

  @override
  Future<void> removeNotetype(int notetypeId) async {
    removedId = notetypeId;
  }
}
