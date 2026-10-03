import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/card_rendering.pb.dart'
    as card_rendering_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes_pb;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('prepareTypedAnswer resolves field text and editor font metadata', () async {
    final backend = _FakeBackend(
      responsesById: {
        29: _note(fields: const ['Paris']).writeToBuffer(),
        23: _notetype(
          fieldName: 'Front',
          fontName: 'Arial',
          fontSize: 24,
        ).writeToBuffer(),
      },
    );
    final dynamic repository = AnkiReviewRepository(backend: backend);

    final dynamic prompt = await repository.prepareTypedAnswer(
      _card(),
      'Front',
    );

    expect(prompt.pattern, 'Front');
    expect(prompt.fieldName, 'Front');
    expect(prompt.expected, 'Paris');
    expect(prompt.combining, isTrue);
    expect(prompt.fontName, 'Arial');
    expect(prompt.fontSize, 24);
    expect(backend.calls.map((call) => call.operation.nativeId), [29, 23]);
  });

  test('prepareTypedAnswer honors nc filter by disabling combining', () async {
    final backend = _FakeBackend(
      responsesById: {
        29: _note(fields: const ['Paris']).writeToBuffer(),
        23: _notetype(fieldName: 'Front').writeToBuffer(),
      },
    );
    final dynamic repository = AnkiReviewRepository(backend: backend);

    final dynamic prompt = await repository.prepareTypedAnswer(
      _card(),
      'nc:Front',
    );

    expect(prompt.fieldName, 'Front');
    expect(prompt.expected, 'Paris');
    expect(prompt.combining, isFalse);
  });

  test('prepareTypedAnswer asks Anki to extract the active cloze', () async {
    const fieldText = 'hello {{c2::world}}';
    final backend = _FakeBackend(
      responsesById: {
        29: _note(fields: const [fieldText]).writeToBuffer(),
        23: _notetype(fieldName: 'Text').writeToBuffer(),
        69: generic_pb.String(val: 'world').writeToBuffer(),
      },
    );
    final dynamic repository = AnkiReviewRepository(backend: backend);

    final dynamic prompt = await repository.prepareTypedAnswer(
      _card(templateOrdinal: 1),
      'cloze:Text',
    );

    expect(prompt.fieldName, 'Text');
    expect(prompt.expected, 'world');
    expect(prompt.combining, isTrue);
    expect(backend.calls.map((call) => call.operation.nativeId), [29, 23, 69]);
    final request = card_rendering_pb.ExtractClozeForTypingRequest.fromBuffer(
      backend.calls.last.request,
    );
    expect(request.text, fieldText);
    expect(request.ordinal, 2);
  });

  test('compareTypedAnswer delegates comparison to Anki backend', () async {
    final backend = _FakeBackend(
      responsesById: {
        68: generic_pb.String(
          val: '<span class="typeGood">Paris</span>',
        ).writeToBuffer(),
      },
    );
    final dynamic repository = AnkiReviewRepository(backend: backend);

    final result = await repository.compareTypedAnswer(
      expected: 'Paris',
      provided: 'Pari',
      combining: false,
    );

    expect(result, '<span class="typeGood">Paris</span>');
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation.nativeId, 68);
    final request = card_rendering_pb.CompareAnswerRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.expected, 'Paris');
    expect(request.provided, 'Pari');
    expect(request.combining, isFalse);
  });
}

notes_pb.Note _note({required List<String> fields}) => notes_pb.Note(
  id: Int64(202),
  notetypeId: Int64(900),
  fields: fields,
);

notetypes_pb.Notetype _notetype({
  required String fieldName,
  String fontName = 'Sans',
  int fontSize = 20,
}) => notetypes_pb.Notetype(
  id: Int64(900),
  fields: [
    notetypes_pb.Notetype_Field(
      ord: generic_pb.UInt32(val: 0),
      name: fieldName,
      config: notetypes_pb.Notetype_Field_Config(
        fontName: fontName,
        fontSize: fontSize,
      ),
    ),
  ],
);

ReviewCard _card({int templateOrdinal = 0}) => ReviewCard(
  cardId: 101,
  noteId: 202,
  deckId: 303,
  templateOrdinal: templateOrdinal,
  counts: const ReviewCounts(newCount: 0, learningCount: 0, reviewCount: 0),
  currentStateBytes: Uint8List(0),
  choices: const [],
  deckName: 'Default',
);

class _BackendCall {
  const _BackendCall(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _FakeBackend implements BackendInvoker {
  _FakeBackend({Map<int, List<int>>? responsesById})
      : responsesById = responsesById ?? const {};

  final Map<int, List<int>> responsesById;
  final List<_BackendCall> calls = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_BackendCall(operation, request));
    return Uint8List.fromList(responsesById[operation.nativeId] ?? const []);
  }
}
