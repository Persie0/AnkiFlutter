import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes_pb;
import 'package:anki_flutter/core/backend/generated/anki/tags.pb.dart' as tags_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('isMarked reads the exact Anki marked tag from the current note', () async {
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getNote: Uint8List.fromList(
          notes_pb.Note(
            id: Int64(202),
            tags: ['language', 'marked', 'priority'],
          ).writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    expect(await repository.isMarked(_card()), isTrue);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.getNote);
    final request = notes_pb.NoteId.fromBuffer(backend.calls.single.request);
    expect(request.nid.toInt(), 202);
  });

  test('isMarked does not treat similarly named tags as marked', () async {
    final backend = _FakeBackend(
      responses: {
        BackendOperation.getNote: Uint8List.fromList(
          notes_pb.Note(
            id: Int64(202),
            tags: ['Marked', 'marked::child', 'unmarked'],
          ).writeToBuffer(),
        ),
      },
    );
    final repository = AnkiReviewRepository(backend: backend);

    expect(await repository.isMarked(_card()), isFalse);
  });

  test('setMarked true adds the exact marked tag to the current note', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);

    await repository.setMarked(_card(), true);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.addNoteTags);
    final request = tags_pb.NoteIdsAndTagsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.noteIds.map((id) => id.toInt()), [202]);
    expect(request.tags, 'marked');
  });

  test('setMarked false removes the exact marked tag from the current note', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);

    await repository.setMarked(_card(), false);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.removeNoteTags);
    final request = tags_pb.NoteIdsAndTagsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.noteIds.map((id) => id.toInt()), [202]);
    expect(request.tags, 'marked');
  });
}

ReviewCard _card() => ReviewCard(
  cardId: 101,
  noteId: 202,
  deckId: 303,
  counts: const ReviewCounts(newCount: 0, learningCount: 0, reviewCount: 0),
  currentStateBytes: Uint8List(0),
  choices: const [],
  deckName: 'Default',
);

class _BackendCall {
  _BackendCall(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _FakeBackend implements BackendInvoker {
  _FakeBackend({Map<BackendOperation, Uint8List>? responses})
      : responses = responses ?? <BackendOperation, Uint8List>{};

  final Map<BackendOperation, Uint8List> responses;
  final List<_BackendCall> calls = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_BackendCall(operation, request));
    return responses[operation] ?? Uint8List(0);
  }
}
