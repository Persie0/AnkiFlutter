import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fetches native RepositionDefaults, not locally assumed values',
      () async {
    final backend = _Backend()
      ..responses[BackendOperation.repositionDefaults] = Uint8List.fromList(
        scheduler.RepositionDefaultsResponse(
          random: true,
          shift: false,
        ).writeToBuffer(),
      );
    final defaults =
        await AnkiCardBrowserRepository(backend: backend).repositionDefaults();
    expect(defaults.randomize, isTrue);
    expect(defaults.shiftExisting, isFalse);
    expect(backend.calls.single.operation, BackendOperation.repositionDefaults);
    expect(backend.calls.single.request, isEmpty);
  });

  test('delegates reposition options and ordered IDs to native Anki', () async {
    final backend = _Backend()
      ..responses[BackendOperation.sortCards] = Uint8List.fromList(
        collection.OpChangesWithCount(count: 2).writeToBuffer(),
      );
    final repo = AnkiCardBrowserRepository(backend: backend);
    final count = await repo.repositionNewCards(
      [45, 21, 45, 9],
      const CardBrowserRepositionOptions(
        startingFrom: 13,
        stepSize: 3,
        randomize: false,
        shiftExisting: true,
      ),
    );
    expect(count, 2);
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.sortCards);
    final request =
        scheduler.SortCardsRequest.fromBuffer(backend.calls.single.request);
    expect(request.cardIds, [Int64(45), Int64(21), Int64(9)]);
    expect(request.startingFrom, 13);
    expect(request.stepSize, 3);
    expect(request.randomize, isFalse);
    expect(request.shiftExisting, isTrue);
  });

  test('invalid position, step and card ID never reach Anki', () async {
    final backend = _Backend();
    final repo = AnkiCardBrowserRepository(backend: backend);
    const options = CardBrowserRepositionOptions(
      startingFrom: 1,
      stepSize: 1,
      randomize: false,
      shiftExisting: false,
    );

    expect(await repo.repositionNewCards([], options), 0);
    await expectLater(
      repo.repositionNewCards([-2], options),
      throwsArgumentError,
    );
    await expectLater(
      repo.repositionNewCards(
        [9],
        const CardBrowserRepositionOptions(
          startingFrom: 0,
          stepSize: 1,
          randomize: false,
          shiftExisting: false,
        ),
      ),
      throwsArgumentError,
    );
    await expectLater(
      repo.repositionNewCards(
        [9],
        const CardBrowserRepositionOptions(
          startingFrom: 1,
          stepSize: 0,
          randomize: false,
          shiftExisting: false,
        ),
      ),
      throwsArgumentError,
    );
    await expectLater(
      repo.repositionNewCards(
        [9],
        const CardBrowserRepositionOptions(
          startingFrom: 0x100000000,
          stepSize: 1,
          randomize: false,
          shiftExisting: false,
        ),
      ),
      throwsArgumentError,
    );
    expect(backend.calls, isEmpty);
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  final calls = <_Call>[];
  final responses = <BackendOperation, Uint8List>{};

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    return responses[operation] ?? Uint8List(0);
  }
}
