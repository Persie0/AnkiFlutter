import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards;
import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart' as stats;
import 'package:anki_flutter/features/card_info/data/anki_card_info_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads and maps CardStats through operation 75', () async {
    final response = stats.CardStatsResponse(
      cardId: Int64(123),
      noteId: Int64(456),
      deck: 'French::Verbs',
      originalDeck: 'French',
      cardType: 'Card 1',
      notetype: 'Basic',
      preset: 'Default',
      added: Int64(1_700_000_000),
      firstReview: Int64(1_700_000_100),
      latestReview: Int64(1_700_001_000),
      dueDate: Int64(1_700_100_000),
      duePosition: 42,
      interval: 30,
      ease: 2500,
      reviews: 12,
      lapses: 2,
      averageSecs: 4.5,
      totalSecs: 54,
      customData: '{"x":1}',
      memoryState: cards.FsrsMemoryState(stability: 12.5, difficulty: 4.25),
      fsrsRetrievability: 0.91,
      desiredRetention: 0.9,
      fsrsParams: const [0.4, 1.2, 3.5],
      revlog: [
        stats.CardStatsResponse_StatsRevlogEntry(
          time: Int64(1_700_001_000),
          reviewKind: stats.RevlogEntry_ReviewKind.REVIEW,
          buttonChosen: 3,
          interval: 86_400,
          lastInterval: 43_200,
          ease: 2500,
          takenSecs: 3.25,
          memoryState: cards.FsrsMemoryState(
            stability: 11,
            difficulty: 4,
          ),
        ),
        stats.CardStatsResponse_StatsRevlogEntry(
          time: Int64(1_700_000_100),
          reviewKind: stats.RevlogEntry_ReviewKind.LEARNING,
          buttonChosen: 1,
          interval: 600,
          lastInterval: 60,
          ease: 0,
          takenSecs: 5.75,
        ),
      ],
    );
    final backend = _BackendQueue([response.writeToBuffer()]);
    final repository = AnkiCardInfoRepository(backend: backend);

    final result = await repository.load(123);

    expect(backend.calls.single.operation, BackendOperation.cardStats);
    final request = cards.CardId.fromBuffer(backend.calls.single.request);
    expect(request.cid.toInt(), 123);
    expect(result.cardId, 123);
    expect(result.noteId, 456);
    expect(result.deck, 'French::Verbs');
    expect(result.originalDeck, 'French');
    expect(result.cardType, 'Card 1');
    expect(result.noteType, 'Basic');
    expect(result.preset, 'Default');
    expect(result.addedUnixSeconds, 1_700_000_000);
    expect(result.firstReviewUnixSeconds, 1_700_000_100);
    expect(result.latestReviewUnixSeconds, 1_700_001_000);
    expect(result.dueUnixSeconds, 1_700_100_000);
    expect(result.duePosition, 42);
    expect(result.intervalDays, 30);
    expect(result.easePermille, 2500);
    expect(result.reviews, 12);
    expect(result.lapses, 2);
    expect(result.averageSeconds, closeTo(4.5, 0.001));
    expect(result.totalSeconds, closeTo(54, 0.001));
    expect(result.customData, '{"x":1}');
    expect(result.memoryState?.stability, closeTo(12.5, 0.001));
    expect(result.memoryState?.difficulty, closeTo(4.25, 0.001));
    expect(result.retrievability, closeTo(0.91, 0.001));
    expect(result.desiredRetention, closeTo(0.9, 0.001));
    expect(result.fsrsParameters, [0.4, 1.2, 3.5]);

    expect(result.reviewHistory, hasLength(2));
    expect(result.reviewHistory[0].unixSeconds, 1_700_001_000);
    expect(
      result.reviewHistory[0].reviewKindValue,
      stats.RevlogEntry_ReviewKind.REVIEW.value,
    );
    expect(result.reviewHistory[0].buttonChosen, 3);
    expect(result.reviewHistory[0].intervalSeconds, 86_400);
    expect(result.reviewHistory[0].lastIntervalSeconds, 43_200);
    expect(result.reviewHistory[0].easePermille, 2500);
    expect(result.reviewHistory[0].takenSeconds, closeTo(3.25, 0.001));
    expect(result.reviewHistory[0].memoryState?.stability, closeTo(11, 0.001));
    expect(result.reviewHistory[1].unixSeconds, 1_700_000_100);
    expect(result.reviewHistory[1].memoryState, isNull);
  });

  test('preserves absent optional CardStats fields as null', () async {
    final response = stats.CardStatsResponse(
      cardId: Int64(1),
      noteId: Int64(2),
      deck: 'Default',
      cardType: 'Card 1',
      notetype: 'Basic',
      preset: 'Default',
      added: Int64(1_700_000_000),
      interval: 0,
      ease: 0,
      reviews: 0,
      lapses: 0,
      averageSecs: 0,
      totalSecs: 0,
      customData: '',
    );
    final repository = AnkiCardInfoRepository(
      backend: _BackendQueue([response.writeToBuffer()]),
    );

    final result = await repository.load(1);

    expect(result.firstReviewUnixSeconds, isNull);
    expect(result.latestReviewUnixSeconds, isNull);
    expect(result.dueUnixSeconds, isNull);
    expect(result.duePosition, isNull);
    expect(result.originalDeck, isNull);
    expect(result.memoryState, isNull);
    expect(result.retrievability, isNull);
    expect(result.desiredRetention, isNull);
    expect(result.fsrsParameters, isEmpty);
    expect(result.reviewHistory, isEmpty);
  });

  test('propagates backend failures', () async {
    final expected = StateError('card was deleted');
    final repository = AnkiCardInfoRepository(
      backend: _ThrowingBackend(expected),
    );

    await expectLater(repository.load(999), throwsA(same(expected)));
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

class _ThrowingBackend implements BackendInvoker {
  const _ThrowingBackend(this.error);

  final Object error;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    throw error;
  }
}
