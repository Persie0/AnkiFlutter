import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;

/// Check Database delegates all validation/repairs to Anki's upstream backend.
/// It may change collection data, so callers must request user confirmation.
abstract interface class CollectionIntegrityRepository {
  Future<List<String>> checkDatabase();
}

class AnkiCollectionIntegrityRepository implements CollectionIntegrityRepository {
  const AnkiCollectionIntegrityRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<List<String>> checkDatabase() async {
    final bytes = await backend.invoke(
      BackendOperation.checkDatabase,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    final result = collection.CheckDatabaseResponse.fromBuffer(bytes);
    return List<String>.unmodifiable(result.problems);
  }
}
