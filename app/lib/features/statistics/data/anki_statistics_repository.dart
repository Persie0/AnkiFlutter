import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart' as stats;

abstract interface class StatisticsRepository {
  Future<stats.GraphsResponse> graphs({String search = '', int days = 0});
}

class AnkiStatisticsRepository implements StatisticsRepository {
  const AnkiStatisticsRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<stats.GraphsResponse> graphs({String search = '', int days = 0}) async {
    if (days < 0) {
      throw ArgumentError.value(days, 'days', 'Must be non-negative');
    }
    final response = await backend.invoke(
      BackendOperation.graphs,
      Uint8List.fromList(
        stats.GraphsRequest(search: search, days: days).writeToBuffer(),
      ),
    );
    return stats.GraphsResponse.fromBuffer(response);
  }
}
