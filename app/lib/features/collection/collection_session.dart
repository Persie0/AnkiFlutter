import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/features/collection/collection_location.dart';

class CollectionSession {
  CollectionSession({required BackendInvoker backend}) : _backend = backend;

  final BackendInvoker _backend;
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  Future<void> open(CollectionLocation location) async {
    final request = OpenCollectionRequest(
      collectionPath: location.collectionPath,
      mediaFolderPath: location.mediaFolderPath,
      mediaDbPath: location.mediaDbPath,
    );
    await _backend.invoke(
      BackendOperation.openCollection,
      Uint8List.fromList(request.writeToBuffer()),
    );
    _isOpen = true;
  }

  Future<void> close() async {
    if (!_isOpen) {
      return;
    }
    final request = CloseCollectionRequest(downgradeToSchema11: false);
    await _backend.invoke(
      BackendOperation.closeCollection,
      Uint8List.fromList(request.writeToBuffer()),
    );
    _isOpen = false;
  }
}
