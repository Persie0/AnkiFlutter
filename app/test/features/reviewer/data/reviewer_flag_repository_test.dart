import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic_pb;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler_pb;
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('queued Anki card maps its user flag bits', () async {
    final states = scheduler_pb.SchedulingStates(
      current: scheduler_pb.SchedulingState(),
      again: scheduler_pb.SchedulingState(),
      hard: scheduler_pb.SchedulingState(),
      good: scheduler_pb.SchedulingState(),
      easy: scheduler_pb.SchedulingState(),
    );
    final queued = scheduler_pb.QueuedCards(
      cards: [
        scheduler_pb.QueuedCards_QueuedCard(
          card: cards_pb.Card(id: Int64(101), flags: 11),
          states: states,
        ),
      ],
    );
    final backend = _Backend({
      BackendOperation.getQueuedCards: Uint8List.fromList(queued.writeToBuffer()),
      BackendOperation.describeNextStates: Uint8List.fromList(
        generic_pb.StringList(vals: ['1m', '2m', '3m', '4m']).writeToBuffer(),
      ),
    });
    final repository = AnkiReviewRepository(backend: backend);

    final card = await repository.nextCard();

    expect(card?.flag, 3);
  });

  test('sets current card flag through the stable Anki operation', () async {
    final backend = _Backend({BackendOperation.setFlag: Uint8List(0)});
    final repository = AnkiReviewRepository(backend: backend);
    final flagRepository = repository as ReviewFlagRepository;
    final card = ReviewCard(
      cardId: 101,
      noteId: 202,
      deckId: 303,
      counts: const ReviewCounts(newCount: 0, learningCount: 0, reviewCount: 1),
      currentStateBytes: Uint8List(0),
      choices: const [],
      deckName: 'Deck',
    );

    await flagRepository.setFlag(card, 4);

    expect(backend.calls.single.operation, BackendOperation.setFlag);
    final request = cards_pb.SetFlagRequest.fromBuffer(backend.calls.single.request);
    expect(request.cardIds.map((id) => id.toInt()), [101]);
    expect(request.flag, 4);
  });
}

class _Call {
  const _Call(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  _Backend(this.responses);

  final Map<BackendOperation, Uint8List> responses;
  final calls = <_Call>[];

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    return responses[operation] ?? Uint8List(0);
  }
}
