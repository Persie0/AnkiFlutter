import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/sync.pb.dart' as sync;

abstract interface class SyncRepository {
  Future<sync.SyncAuth> login({
    required String username,
    required String password,
    String? endpoint,
  });

  Future<sync.SyncStatusResponse> status(sync.SyncAuth auth);
  Future<sync.SyncCollectionResponse> syncCollection(
    sync.SyncAuth auth, {
    required bool syncMedia,
  });
  Future<void> fullSync(
    sync.SyncAuth auth, {
    required bool upload,
    int? serverUsn,
  });
  Future<void> syncMedia(sync.SyncAuth auth);
  Future<sync.MediaSyncStatusResponse> mediaStatus();
  Future<void> abortCollectionSync();
  Future<void> abortMediaSync();
  Future<bool> setCustomCertificate(String certificatePem);
}

class AnkiSyncRepository implements SyncRepository {
  const AnkiSyncRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<sync.SyncAuth> login({
    required String username,
    required String password,
    String? endpoint,
  }) async {
    final trimmedUsername = username.trim();
    if (trimmedUsername.isEmpty) {
      throw ArgumentError.value(username, 'username', 'Username is empty');
    }
    if (password.isEmpty) {
      throw ArgumentError.value(password, 'password', 'Password is empty');
    }
    final request = sync.SyncLoginRequest(
      username: trimmedUsername,
      password: password,
    );
    final trimmedEndpoint = endpoint?.trim() ?? '';
    if (trimmedEndpoint.isNotEmpty) request.endpoint = trimmedEndpoint;
    final response = await backend.invoke(
      BackendOperation.syncLogin,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return sync.SyncAuth.fromBuffer(response);
  }

  @override
  Future<sync.SyncStatusResponse> status(sync.SyncAuth auth) async {
    final response = await backend.invoke(
      BackendOperation.syncStatus,
      Uint8List.fromList(auth.writeToBuffer()),
    );
    return sync.SyncStatusResponse.fromBuffer(response);
  }

  @override
  Future<sync.SyncCollectionResponse> syncCollection(
    sync.SyncAuth auth, {
    required bool syncMedia,
  }) async {
    final response = await backend.invoke(
      BackendOperation.syncCollection,
      Uint8List.fromList(
        sync.SyncCollectionRequest(
          auth: auth,
          syncMedia: syncMedia,
        ).writeToBuffer(),
      ),
    );
    return sync.SyncCollectionResponse.fromBuffer(response);
  }

  @override
  Future<void> fullSync(
    sync.SyncAuth auth, {
    required bool upload,
    int? serverUsn,
  }) async {
    final request = sync.FullUploadOrDownloadRequest(
      auth: auth,
      upload: upload,
    );
    if (serverUsn != null) request.serverUsn = serverUsn;
    await backend.invoke(
      BackendOperation.fullUploadOrDownload,
      Uint8List.fromList(request.writeToBuffer()),
    );
  }

  @override
  Future<void> syncMedia(sync.SyncAuth auth) async {
    await backend.invoke(
      BackendOperation.syncMedia,
      Uint8List.fromList(auth.writeToBuffer()),
    );
  }

  @override
  Future<sync.MediaSyncStatusResponse> mediaStatus() async {
    final response = await backend.invoke(
      BackendOperation.mediaSyncStatus,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return sync.MediaSyncStatusResponse.fromBuffer(response);
  }

  @override
  Future<void> abortCollectionSync() async {
    await backend.invoke(
      BackendOperation.abortSync,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
  }

  @override
  Future<void> abortMediaSync() async {
    await backend.invoke(
      BackendOperation.abortMediaSync,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
  }

  @override
  Future<bool> setCustomCertificate(String certificatePem) async {
    final response = await backend.invoke(
      BackendOperation.setCustomCertificate,
      Uint8List.fromList(generic.String(val: certificatePem).writeToBuffer()),
    );
    return generic.Bool.fromBuffer(response).val;
  }
}
