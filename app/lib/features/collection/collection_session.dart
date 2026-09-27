import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/features/collection/collection_location.dart';
import 'package:anki_flutter/features/reviewer/media/review_media_server.dart';

class CollectionSession {
  CollectionSession({
    required this.backend,
    required this.mediaServer,
  });

  final BackendInvoker backend;
  final ReviewMediaServer mediaServer;

  bool _isOpen = false;
  CollectionLocation? _location;

  bool get isOpen => _isOpen;
  CollectionLocation? get location => _location;

  Future<void> open(CollectionLocation location) async {
    final request = OpenCollectionRequest(
      collectionPath: location.collectionPath,
      mediaFolderPath: location.mediaFolderPath,
      mediaDbPath: location.mediaDbPath,
    );
    await backend.invoke(
      BackendOperation.openCollection,
      Uint8List.fromList(request.writeToBuffer()),
    );
    await mediaServer.start(location.mediaFolderPath);
    _location = location;
    _isOpen = true;
  }

  Future<void> close() async {
    if (!_isOpen) {
      return;
    }
    final request = CloseCollectionRequest(downgradeToSchema11: false);
    await backend.invoke(
      BackendOperation.closeCollection,
      Uint8List.fromList(request.writeToBuffer()),
    );
    await mediaServer.close();
    _location = null;
    _isOpen = false;
  }
}
