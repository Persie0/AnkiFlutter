import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;

bool noteValidationIsDuplicate(notes.NoteFieldsCheckResponse_State state) =>
    state == notes.NoteFieldsCheckResponse_State.DUPLICATE;

String? noteValidationError(notes.NoteFieldsCheckResponse_State state) =>
    switch (state) {
      notes.NoteFieldsCheckResponse_State.NORMAL => null,
      notes.NoteFieldsCheckResponse_State.DUPLICATE => null,
      notes.NoteFieldsCheckResponse_State.EMPTY =>
        'The first field is empty. Add content before saving the note.',
      notes.NoteFieldsCheckResponse_State.MISSING_CLOZE =>
        'This cloze note does not contain any cloze deletions.',
      notes.NoteFieldsCheckResponse_State.NOTETYPE_NOT_CLOZE =>
        'This note uses cloze content with a note type that is not configured for cloze deletion.',
      notes.NoteFieldsCheckResponse_State.FIELD_NOT_CLOZE =>
        'The cloze deletion is in a field that is not configured as the cloze field.',
      _ => 'Anki rejected the note fields.',
    };
