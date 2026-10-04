import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('forgetCardDefaults requests Reviewer-context defaults', () async {
    final backend = _FakeBackend()
      ..responses[BackendOperation.scheduleCardsAsNewDefaults] = Uint8List.fromList(
        scheduler_pb.ScheduleCardsAsNewDefaultsResponse(
          restorePosition: true,
          resetCounts: false,
        ).writeToBuffer(),
      );
    final repository = AnkiReviewRepository(backend: backend);

    final defaults = await repository.forgetCardDefaults();

    expect(defaults.restoreOriginalPosition, isTrue);
    expect(defaults.resetRepetitionAndLapseCounts, isFalse);
    expect(backend.calls, hasLength(1));
    expect(
      backend.calls.single.operation,
      BackendOperation.scheduleCardsAsNewDefaults,
    );
    final request = scheduler_pb.ScheduleCardsAsNewDefaultsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(
      request.context,
      scheduler_pb.ScheduleCardsAsNewRequest_Context.REVIEWER,
    );
  });

  test('forgetCard sends the exact Reviewer ScheduleCardsAsNew request', () async {
    final backend = _FakeBackend();
    final repository = AnkiReviewRepository(backend: backend);
    final card = _card();
    const options = ReviewForgetCardOptions(
      restoreOriginalPosition: false,
      resetRepetitionAndLapseCounts: true,
    );

    await repository.forgetCard(card, options);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.scheduleCardsAsNew);
    final request = scheduler_pb.ScheduleCardsAsNewRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.cardIds, [Int64(101)]);
    expect(request.log, isTrue);
    expect(request.restorePosition, isFalse);
    expect(request.resetCounts, isTrue);
    expect(request.hasContext(), isTrue);
    expect(
      request.context,
      scheduler_pb.ScheduleCardsAsNewRequest_Context.REVIEWER,
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
