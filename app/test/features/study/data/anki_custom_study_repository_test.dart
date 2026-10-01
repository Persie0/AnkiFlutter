import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler;
import 'package:anki_flutter/features/study/data/anki_custom_study_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads custom study defaults for the selected deck', () async {
    final expected = scheduler.CustomStudyDefaultsResponse(
      extendNew: 10,
      extendReview: 20,
      availableNew: 30,
      availableReview: 40,
    );
    final backend = _BackendQueue([expected.writeToBuffer()]);
    final repository = AnkiCustomStudyRepository(backend: backend);

    final result = await repository.defaults(123);

    expect(result, expected);
    expect(backend.calls.single.operation, BackendOperation.customStudyDefaults);
    expect(
      scheduler.CustomStudyDefaultsRequest.fromBuffer(backend.calls.single.request).deckId,
      Int64(123),
    );
  });

  test('sends extend-new custom study request', () async {
    final backend = _BackendQueue([Uint8List(0)]);
    final repository = AnkiCustomStudyRepository(backend: backend);

    await repository.extendNew(123, 7);

    final request = scheduler.CustomStudyRequest.fromBuffer(backend.calls.single.request);
    expect(backend.calls.single.operation, BackendOperation.customStudy);
    expect(request.deckId, Int64(123));
    expect(request.newLimitDelta, 7);
    expect(request.whichValue(), scheduler.CustomStudyRequest_Value.newLimitDelta);
  });

  test('sends cram filters and card limit through Anki', () async {
    final backend = _BackendQueue([Uint8List(0)]);
    final repository = AnkiCustomStudyRepository(backend: backend);

    await repository.cram(
      9,
      kind: scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_REVIEW,
      cardLimit: 50,
      tagsToInclude: const ['exam'],
      tagsToExclude: const ['done'],
    );

    final request = scheduler.CustomStudyRequest.fromBuffer(backend.calls.single.request);
    expect(request.cram.cardLimit, 50);
    expect(request.cram.tagsToInclude, ['exam']);
    expect(request.cram.tagsToExclude, ['done']);
  });

  test('unburies all cards in the deck', () async {
    final backend = _BackendQueue([Uint8List(0)]);
    final repository = AnkiCustomStudyRepository(backend: backend);

    await repository.unburyAll(77);

    expect(backend.calls.single.operation, BackendOperation.unburyDeck);
    final request = scheduler.UnburyDeckRequest.fromBuffer(backend.calls.single.request);
    expect(request.deckId, Int64(77));
    expect(request.mode, scheduler.UnburyDeckRequest_Mode.ALL);
  });
}

class _Call {
  const _Call(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _BackendQueue implements BackendInvoker {
  _BackendQueue(this.responses);

  final List<Uint8List> responses;
  final calls = <_Call>[];
  var _index = 0;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    return responses[_index++];
  }
}
