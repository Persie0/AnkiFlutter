import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart' as stats;
import 'package:anki_flutter/features/statistics/data/anki_statistics_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads graph statistics through the pinned Anki backend', () async {
    final expected = stats.GraphsResponse(
      today: stats.GraphsResponse_Today(
        answerCount: 42,
        answerMillis: 120000,
        correctCount: 35,
      ),
    );
    final backend = _BackendQueue([expected.writeToBuffer()]);
    final repository = AnkiStatisticsRepository(backend: backend);

    final result = await repository.graphs(search: 'deck:French', days: 30);

    expect(result.today.answerCount, 42);
    expect(result.today.correctCount, 35);
    expect(backend.calls.single.operation, BackendOperation.graphs);
    final request = stats.GraphsRequest.fromBuffer(backend.calls.single.request);
    expect(request.search, 'deck:French');
    expect(request.days, 30);
  });

  test('rejects negative graph ranges before invoking the backend', () async {
    final backend = _BackendQueue(const []);
    final repository = AnkiStatisticsRepository(backend: backend);

    expect(
      () => repository.graphs(days: -1),
      throwsA(isA<ArgumentError>()),
    );
    expect(backend.calls, isEmpty);
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
