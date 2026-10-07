import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards;
import 'package:anki_flutter/core/backend/generated/anki/tags.pb.dart' as tags;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds tags once per unique note when multiple cards share a note', () async {
    final backend = _Backend([
      cards.Card(noteId: Int64(100)).writeToBuffer(),
      cards.Card(noteId: Int64(200)).writeToBuffer(),
      cards.Card(noteId: Int64(100)).writeToBuffer(),
      Uint8List(0),
    ]);
    final repository = AnkiCardBrowserRepository(backend: backend);

    await repository.applyTagsToCards([1, 2, 3], '  exam important  ', remove: false);

    expect(backend.calls.map((call) => call.operation), [
      BackendOperation.getCard,
      BackendOperation.getCard,
      BackendOperation.getCard,
      BackendOperation.addNoteTags,
    ]);
    expect(
      backend.calls.take(3).map(
        (call) => cards.CardId.fromBuffer(call.request).cid,
      ),
      [Int64(1), Int64(2), Int64(3)],
    );
    final request = tags.NoteIdsAndTagsRequest.fromBuffer(backend.calls.last.request);
    expect(request.noteIds, [Int64(100), Int64(200)]);
    expect(request.tags, 'exam important');
  });

  test('removes tags using Anki native note-tag operation', () async {
    final backend = _Backend([
      cards.Card(noteId: Int64(300)).writeToBuffer(),
      Uint8List(0),
    ]);

    await AnkiCardBrowserRepository(backend: backend)
        .applyTagsToCards([8], 'old', remove: true);

    expect(backend.calls.last.operation, BackendOperation.removeNoteTags);
    final request = tags.NoteIdsAndTagsRequest.fromBuffer(backend.calls.last.request);
    expect(request.noteIds, [Int64(300)]);
    expect(request.tags, 'old');
  });

  test('empty cards or whitespace-only tags do not call the backend', () async {
    final backend = _Backend([]);
    final repository = AnkiCardBrowserRepository(backend: backend);

    await repository.applyTagsToCards([], 'exam', remove: false);
    await repository.applyTagsToCards([1], '   ', remove: true);

    expect(backend.calls, isEmpty);
  });

  test('does not apply tags if any card lookup fails', () async {
    final backend = _Backend([
      cards.Card(noteId: Int64(300)).writeToBuffer(),
    ], failureAt: 1);

    await expectLater(
      AnkiCardBrowserRepository(backend: backend)
          .applyTagsToCards([8, 9], 'exam', remove: false),
      throwsStateError,
    );

    expect(backend.calls.map((call) => call.operation), [
      BackendOperation.getCard,
      BackendOperation.getCard,
    ]);
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.responses, {this.failureAt});
  final List<Uint8List> responses;
  final int? failureAt;
  final List<_Call> calls = [];
  var _index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    final index = _index++;
    if (index == failureAt) throw StateError('card lookup failed');
    return responses[index];
  }
}
