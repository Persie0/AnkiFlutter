import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deleteNote removes the current note through Anki removeNotes', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);
    final card = ReviewCard(
      cardId: 101,
      noteId: 202,
      deckId: 303,
      deckName: 'Default',
      counts: const ReviewCounts(
        newCount: 1,
        learningCount: 0,
        reviewCount: 0,
      ),
      currentStateBytes: Uint8List(0),
      choices: const [],
    );

    await repository.deleteNote(card);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.removeNotes);
    final request = notes_pb.RemoveNotesRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.noteIds, [Int64(202)]);
    expect(request.cardIds, isEmpty);
  });
}

class _BackendCall {
  _BackendCall(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _FakeBackend implements BackendInvoker {
  final List<_BackendCall> calls = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_BackendCall(operation, request));
    return Uint8List(0);
  }
}
