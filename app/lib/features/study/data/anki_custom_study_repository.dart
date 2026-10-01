import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler;
import 'package:fixnum/fixnum.dart';

abstract interface class CustomStudyRepository {
  Future<scheduler.CustomStudyDefaultsResponse> defaults(int deckId);

  Future<void> extendNew(int deckId, int count);
  Future<void> extendReview(int deckId, int count);
  Future<void> reviewForgotten(int deckId, int days);
  Future<void> reviewAhead(int deckId, int days);
  Future<void> previewRecentNew(int deckId, int days);

  Future<void> cram(
    int deckId, {
    required scheduler.CustomStudyRequest_Cram_CramKind kind,
    required int cardLimit,
    required List<String> tagsToInclude,
    required List<String> tagsToExclude,
  });

  Future<void> unburyAll(int deckId);
}

class AnkiCustomStudyRepository implements CustomStudyRepository {
  const AnkiCustomStudyRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<scheduler.CustomStudyDefaultsResponse> defaults(int deckId) async {
    final response = await backend.invoke(
      BackendOperation.customStudyDefaults,
      Uint8List.fromList(
        scheduler.CustomStudyDefaultsRequest(
          deckId: Int64(deckId),
        ).writeToBuffer(),
      ),
    );
    return scheduler.CustomStudyDefaultsResponse.fromBuffer(response);
  }

  @override
  Future<void> extendNew(int deckId, int count) => _run(
        scheduler.CustomStudyRequest(
          deckId: Int64(deckId),
          newLimitDelta: _nonNegative(count, 'count'),
        ),
      );

  @override
  Future<void> extendReview(int deckId, int count) => _run(
        scheduler.CustomStudyRequest(
          deckId: Int64(deckId),
          reviewLimitDelta: _nonNegative(count, 'count'),
        ),
      );

  @override
  Future<void> reviewForgotten(int deckId, int days) => _run(
        scheduler.CustomStudyRequest(
          deckId: Int64(deckId),
          forgotDays: _nonNegative(days, 'days'),
        ),
      );

  @override
  Future<void> reviewAhead(int deckId, int days) => _run(
        scheduler.CustomStudyRequest(
          deckId: Int64(deckId),
          reviewAheadDays: _nonNegative(days, 'days'),
        ),
      );

  @override
  Future<void> previewRecentNew(int deckId, int days) => _run(
        scheduler.CustomStudyRequest(
          deckId: Int64(deckId),
          previewDays: _nonNegative(days, 'days'),
        ),
      );

  @override
  Future<void> cram(
    int deckId, {
    required scheduler.CustomStudyRequest_Cram_CramKind kind,
    required int cardLimit,
    required List<String> tagsToInclude,
    required List<String> tagsToExclude,
  }) =>
      _run(
        scheduler.CustomStudyRequest(
          deckId: Int64(deckId),
          cram: scheduler.CustomStudyRequest_Cram(
            kind: kind,
            cardLimit: _nonNegative(cardLimit, 'cardLimit'),
            tagsToInclude: tagsToInclude,
            tagsToExclude: tagsToExclude,
          ),
        ),
      );

  @override
  Future<void> unburyAll(int deckId) async {
    await backend.invoke(
      BackendOperation.unburyDeck,
      Uint8List.fromList(
        scheduler.UnburyDeckRequest(
          deckId: Int64(deckId),
          mode: scheduler.UnburyDeckRequest_Mode.ALL,
        ).writeToBuffer(),
      ),
    );
  }

  Future<void> _run(scheduler.CustomStudyRequest request) async {
    await backend.invoke(
      BackendOperation.customStudy,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }
}

int _nonNegative(int value, String name) {
  if (value < 0) {
    throw ArgumentError.value(value, name, 'Must be non-negative');
  }
  return value;
}
