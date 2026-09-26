import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Anki repository satisfies stable ReviewRepository interface', () {
    final ReviewRepository repository = AnkiReviewRepository(
      backend: _FakeBackend(),
    );

    expect(repository, isA<AnkiReviewRepository>());
  });

  test('stateIsLeech forwards opaque state and returns Anki boolean', () async {
    final state = scheduler_pb.SchedulingState(customData: 'opaque-state');
    final backend = _FakeBackend(
      response: Uint8List.fromList(generic_pb.Bool(val: true).writeToBuffer()),
    );
    final ReviewRepository repository = AnkiReviewRepository(backend: backend);
    final choice = ReviewAnswerChoice(
      rating: ReviewRating.good,
      intervalLabel: '3d',
      schedulingStateBytes: Uint8List.fromList(state.writeToBuffer()),
    );

    final isLeech = await repository.stateIsLeech(choice);

    expect(isLeech, isTrue);
    expect(backend.operation, BackendOperation.stateIsLeech);
    expect(backend.request, orderedEquals(state.writeToBuffer()));
  });
}

class _FakeBackend implements BackendInvoker {
  _FakeBackend({Uint8List? response}) : response = response ?? Uint8List(0);

  final Uint8List response;
  BackendOperation? operation;
  Uint8List? request;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    this.operation = operation;
    this.request = request;
    return response;
  }
}
