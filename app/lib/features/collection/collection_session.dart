import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/features/collection/collection_location.dart';
import 'package:anki_flutter/features/reviewer/media/review_media_server.dart';

class CollectionSession {
  CollectionSession({required this.backend, required this.mediaServer});

  final BackendInvoker backend;
  final ReviewMediaServer mediaServer;

  bool _isOpen = false;
  CollectionLocation? _location;
  Uri? _mediaBaseUri;

  bool get isOpen => _isOpen;
  CollectionLocation? get location => _location;
  Uri? get mediaBaseUri => _mediaBaseUri;

  Future<void> open(CollectionLocation location) async {
    final previousLocation = _location;
    if (_isOpen &&
        previousLocation?.collectionPath == location.collectionPath) {
      return;
    }

    try {
      if (_isOpen) {
        await close();
      }
      await _openLocation(location);
    } catch (error, stackTrace) {
      if (previousLocation == null) {
        Error.throwWithStackTrace(error, stackTrace);
      }

      // A backend close failure leaves the existing session usable. If the
      // backend closed but media shutdown failed, restore the collection so
      // the UI and native state still agree about which collection is active.
      if (_isOpen) {
        Error.throwWithStackTrace(error, stackTrace);
      }

      try {
        await _openLocation(previousLocation);
      } catch (restoreError) {
        throw CollectionSwitchException(
          openError: error,
          restoreError: restoreError,
        );
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> _openLocation(CollectionLocation location) async {
    final request = OpenCollectionRequest(
      collectionPath: location.collectionPath,
      mediaFolderPath: location.mediaFolderPath,
      mediaDbPath: location.mediaDbPath,
    );
    await backend.invoke(
      BackendOperation.openCollection,
      Uint8List.fromList(request.writeToBuffer()),
    );
    Uri mediaBaseUri;
    try {
      mediaBaseUri = await mediaServer.start(location.mediaFolderPath);
    } catch (error, stackTrace) {
      final cleanupErrors = <Object>[];
      try {
        await _closeBackend();
      } catch (cleanupError) {
        cleanupErrors.add(cleanupError);
      }
      try {
        await mediaServer.close();
      } catch (cleanupError) {
        cleanupErrors.add(cleanupError);
      }
      if (cleanupErrors.isNotEmpty) {
        throw CollectionOpenCleanupException(
          openError: error,
          cleanupErrors: cleanupErrors,
        );
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
    _location = location;
    _mediaBaseUri = mediaBaseUri;
    _isOpen = true;
  }

  Future<void> close() async {
    if (!_isOpen) {
      return;
    }
    await _closeBackend();
    _mediaBaseUri = null;
    _location = null;
    _isOpen = false;
    await mediaServer.close();
  }

  Future<void> _closeBackend() async {
    final request = CloseCollectionRequest(downgradeToSchema11: false);
    await backend.invoke(
      BackendOperation.closeCollection,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }
}

class CollectionSwitchException implements Exception {
  const CollectionSwitchException({
    required this.openError,
    required this.restoreError,
  });

  final Object openError;
  final Object restoreError;

  @override
  String toString() =>
      'Could not open the selected collection ($openError), and the previous '
      'collection could not be restored ($restoreError).';
}

class CollectionOpenCleanupException implements Exception {
  const CollectionOpenCleanupException({
    required this.openError,
    required this.cleanupErrors,
  });

  final Object openError;
  final List<Object> cleanupErrors;

  @override
  String toString() =>
      'Opening the collection failed ($openError), and cleanup failed: '
      '${cleanupErrors.join('; ')}';
}
