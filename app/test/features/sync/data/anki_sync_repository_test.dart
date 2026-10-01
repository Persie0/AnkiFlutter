import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/sync.pb.dart' as sync;
import 'package:anki_flutter/features/sync/data/anki_sync_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('logs in without persisting the password in the repository', () async {
    final auth = sync.SyncAuth(hkey: 'secret-host-key', endpoint: 'https://sync.example');
    final backend = _BackendQueue([auth.writeToBuffer()]);
    final repository = AnkiSyncRepository(backend: backend);

    final result = await repository.login(
      username: 'user@example.com',
      password: 'password',
      endpoint: 'https://sync.example',
    );

    expect(result.hkey, 'secret-host-key');
    expect(backend.calls.single.operation, BackendOperation.syncLogin);
    final request = sync.SyncLoginRequest.fromBuffer(backend.calls.single.request);
    expect(request.username, 'user@example.com');
    expect(request.password, 'password');
  });

  test('runs normal collection sync with media enabled', () async {
    final response = sync.SyncCollectionResponse(
      required: sync.SyncCollectionResponse_ChangesRequired.NORMAL_SYNC,
      serverMediaUsn: 9,
    );
    final backend = _BackendQueue([response.writeToBuffer()]);
    final repository = AnkiSyncRepository(backend: backend);
    final auth = sync.SyncAuth(hkey: 'hkey');

    final result = await repository.syncCollection(auth, syncMedia: true);

    expect(result.required, sync.SyncCollectionResponse_ChangesRequired.NORMAL_SYNC);
    final request = sync.SyncCollectionRequest.fromBuffer(backend.calls.single.request);
    expect(request.auth.hkey, 'hkey');
    expect(request.syncMedia, isTrue);
  });

  test('full upload/download forwards media server USN', () async {
    final backend = _BackendQueue([Uint8List(0)]);
    final repository = AnkiSyncRepository(backend: backend);
    final auth = sync.SyncAuth(hkey: 'hkey');

    await repository.fullSync(auth, upload: false, serverUsn: 42);

    expect(backend.calls.single.operation, BackendOperation.fullUploadOrDownload);
    final request = sync.FullUploadOrDownloadRequest.fromBuffer(backend.calls.single.request);
    expect(request.upload, isFalse);
    expect(request.serverUsn, 42);
  });

  test('reports media progress and supports both abort paths', () async {
    final backend = _BackendQueue([
      sync.MediaSyncStatusResponse(
        active: true,
        progress: sync.MediaSyncProgress(checked: '10', added: '2', removed: '1'),
      ).writeToBuffer(),
      generic.Empty().writeToBuffer(),
      generic.Empty().writeToBuffer(),
    ]);
    final repository = AnkiSyncRepository(backend: backend);

    final status = await repository.mediaStatus();
    await repository.abortCollectionSync();
    await repository.abortMediaSync();

    expect(status.active, isTrue);
    expect(backend.calls.map((call) => call.operation), [
      BackendOperation.mediaSyncStatus,
      BackendOperation.abortSync,
      BackendOperation.abortMediaSync,
    ]);
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
