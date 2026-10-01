import 'dart:typed_data';

import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:anki_flutter/features/notes/note_fields_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('inserts Anki image markup from downloaded URL media', (tester) async {
    final field = TextEditingController(text: 'Before ');
    final tags = TextEditingController();
    addTearDown(field.dispose);
    addTearDown(tags.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoteFieldsForm(
            fields: [field],
            fieldNames: const ['Front'],
            tagsController: tags,
            busy: false,
            error: null,
            errorKey: 'error',
            errorPrefix: 'Error',
            saveLabel: 'Save',
            saveIcon: Icons.save,
            onSave: () {},
            mediaRepository: _MediaRepository(),
          ),
        ),
      ),
    );

    field.selection = TextSelection.collapsed(offset: field.text.length);
    await tester.tap(find.byKey(const ValueKey('attach-media-url-0')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('media-url')),
      'https://example.com/picture.png',
    );
    await tester.tap(find.text('Attach').last);
    await tester.pumpAndSettle();

    expect(field.text, 'Before <img src="picture.png">');
  });
}

class _MediaRepository implements MediaRepository {
  @override
  Future<String> addFromUrl(String url) async => 'picture.png';

  @override
  Future<String> addFile({required String desiredName, required Uint8List bytes}) async =>
      desiredName;

  @override
  Future<String> absolutePath(String filename) async => filename;

  @override
  Future<media.CheckMediaResponse> checkMedia() async => media.CheckMediaResponse();
}
