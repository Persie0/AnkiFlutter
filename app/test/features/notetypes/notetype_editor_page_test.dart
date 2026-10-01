import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notetypes/data/anki_notetype_repository.dart';
import 'package:anki_flutter/features/notetypes/notetype_editor_page.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('edits and saves the complete note type', (tester) async {
    final repository = _Repository(_basicNotetype());
    await tester.pumpWidget(
      MaterialApp(
        home: NotetypeEditorPage(
          notetypeId: 12,
          useCount: 4,
          repository: repository,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const ValueKey('notetype-name')), 'Basic edited');
    await tester.tap(find.byKey(const ValueKey('save-notetype')));
    await tester.pumpAndSettle();

    expect(repository.updated, isNotNull);
    expect(repository.updated!.name, 'Basic edited');
  });

  testWidgets('rejects duplicate field names before saving', (tester) async {
    final notetype = _basicNotetype()..fields[1].name = 'Front';
    final repository = _Repository(notetype);
    await tester.pumpWidget(
      MaterialApp(
        home: NotetypeEditorPage(
          notetypeId: 12,
          useCount: 4,
          repository: repository,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('save-notetype')));
    await tester.pump();

    expect(find.text('Field names must be unique.'), findsOneWidget);
    expect(repository.updated, isNull);
  });
}

notetypes.Notetype _basicNotetype() => notetypes.Notetype(
      id: Int64(12),
      name: 'Basic',
      config: notetypes.Notetype_Config(
        kind: notetypes.Notetype_Config_Kind.KIND_NORMAL,
        css: '.card { font-family: arial; }',
      ),
      fields: [
        notetypes.Notetype_Field(name: 'Front'),
        notetypes.Notetype_Field(name: 'Back'),
      ],
      templates: [
        notetypes.Notetype_Template(
          name: 'Card 1',
          config: notetypes.Notetype_Template_Config(
            qFormat: '{{Front}}',
            aFormat: '{{FrontSide}}<hr id=answer>{{Back}}',
          ),
        ),
      ],
    );

class _Repository implements NotetypeRepository {
  _Repository(this.value);

  final notetypes.Notetype value;
  notetypes.Notetype? updated;

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async => value.deepCopy();

  @override
  Future<notetypes.NotetypeUseCounts> listNotetypes() async =>
      notetypes.NotetypeUseCounts();

  @override
  Future<void> updateNotetype(notetypes.Notetype notetype) async {
    updated = notetype.deepCopy();
  }

  @override
  Future<void> duplicateNotetype(int sourceNotetypeId, String name) async {}

  @override
  Future<void> removeNotetype(int notetypeId) async {}
}
