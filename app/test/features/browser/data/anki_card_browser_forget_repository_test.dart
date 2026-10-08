import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads browser-context defaults from the native scheduler', () async {
    final backend = _Backend()
      ..responses[BackendOperation.scheduleCardsAsNewDefaults] =
          Uint8List.fromList(
            scheduler.ScheduleCardsAsNewDefaultsResponse(
              restorePosition: true,
              resetCounts: false,
            ).writeToBuffer(),
          );
    final repository = AnkiCardBrowserRepository(backend: backend);

    final options = await repository.forgetCardsDefaults();

    expect(options.restoreOriginalPosition, isTrue);
    expect(options.resetRepetitionAndLapseCounts, isFalse);
    expect(backend.calls, hasLength(1));
    expect(
      backend.calls.single.operation,
      BackendOperation.scheduleCardsAsNewDefaults,
    );
    final request = scheduler.ScheduleCardsAsNewDefaultsRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.context, scheduler.ScheduleCardsAsNewRequest_Context.BROWSER);
  });

  test('forgets exactly the selected IDs with browser history enabled',
      () async {
    final backend = _Backend();
    final repository = AnkiCardBrowserRepository(backend: backend);
    const options = CardBrowserForgetOptions(
      restoreOriginalPosition: false,
      resetRepetitionAndLapseCounts: true,
    );

    await repository.forgetCards([12, 34], options);

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.scheduleCardsAsNew);
    final request = scheduler.ScheduleCardsAsNewRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.cardIds, [Int64(12), Int64(34)]);
    expect(request.log, isTrue);
    expect(request.restorePosition, isFalse);
    expect(request.resetCounts, isTrue);
    expect(request.hasContext(), isTrue);
    expect(request.context, scheduler.ScheduleCardsAsNewRequest_Context.BROWSER);
  });

  test('empty selection does not call native scheduling', () async {
    final backend = _Backend();
    await AnkiCardBrowserRepository(backend: backend).forgetCards(
      [],
      const CardBrowserForgetOptions(
        restoreOriginalPosition: true,
        resetRepetitionAndLapseCounts: false,
      ),
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
