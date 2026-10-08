import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as anki_collection;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;

/// Native Anki's collection validation/repair operation.
/// The check may modify the collection, so the UI must confirm first.
abstract interface class DatabaseCheckRepository {
  Future<List<String>> checkDatabase();
}

class AnkiDatabaseCheckRepository implements DatabaseCheckRepository {
  const AnkiDatabaseCheckRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<List<String>> checkDatabase() async {
    final bytes = await backend.invoke(
      BackendOperation.checkDatabase,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return List.unmodifiable(
      anki_collection.CheckDatabaseResponse.fromBuffer(bytes).problems,
    );
  }
}
