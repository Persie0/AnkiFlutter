import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/config.pb.dart' as config_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dueDateDefault requests the Reviewer set-due-date config string', () async {
    final backend = _FakeBackend()
      ..responses[BackendOperation.getConfigString] = Uint8List.fromList(
        generic_pb.String(val: '3-7').writeToBuffer(),
      );
    final repository = AnkiReviewRepository(backend: backend);

    final value = await repository.dueDateDefault();

    expect(value, '3-7');
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.getConfigString);
    final request = config_pb.GetConfigStringRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.key, config_pb.ConfigKey_String.SET_DUE_REVIEWER);
  });

  test('setDueDate sends the exact Reviewer SetDueDate request', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);

    await repository.setDueDate(_card(), ' 3-7 ');

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.setDueDate);
    final request = scheduler_pb.SetDueDateRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.cardIds, [Int64(101)]);
    expect(request.days, ' 3-7 ');
    expect(request.hasConfigKey(), isTrue);
    expect(
      request.configKey.key,
      config_pb.ConfigKey_String.SET_DUE_REVIEWER,
    );
  });
}

ReviewCard _card() => ReviewCard(
  cardId: 101,
  noteId: 202,
  deckId: 303,
  deckName: 'Default',
  counts: const ReviewCounts(newCount: 1, learningCount: 0, reviewCount: 0),
  currentStateBytes: Uint8List(0),
  choices: const [],
);

class _BackendCall {
  _BackendCall(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _FakeBackend implements BackendInvoker {
  final List<_BackendCall> calls = [];
  final Map<BackendOperation, Uint8List> responses = {};

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_BackendCall(operation, request));
    return responses[operation] ?? Uint8List(0);
  }
}
