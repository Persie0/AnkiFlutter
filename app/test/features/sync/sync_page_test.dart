import 'package:anki_flutter/core/backend/generated/anki/sync.pb.dart' as sync;
import 'package:anki_flutter/features/sync/data/anki_sync_repository.dart';
import 'package:anki_flutter/features/sync/data/sync_auth_store.dart';
import 'package:anki_flutter/features/sync/sync_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login stores returned host key and clears password', (tester) async {
    final repository = _Repository();
    final store = _Store();
    await tester.pumpWidget(
      MaterialApp(home: SyncPage(repository: repository, authStore: store)),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('sync-username')),
      'user@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('sync-password')),
      'secret-password',
    );
    await tester.tap(find.byKey(const ValueKey('sync-login')));
    await tester.pumpAndSettle();

    expect(repository.loginPassword, 'secret-password');
    expect(store.value?.hkey, 'host-key');
    expect(find.text('Signed in to AnkiWeb.'), findsOneWidget);
  });

  testWidgets('full-sync conflict requires explicit upload/download choice', (
    tester,
  ) async {
    final repository = _Repository(
      collectionResponse: sync.SyncCollectionResponse(
        required: sync.SyncCollectionResponse_ChangesRequired.FULL_SYNC,
        serverMediaUsn: 17,
      ),
    );
    final store = _Store()..value = sync.SyncAuth(hkey: 'host-key');
    await tester.pumpWidget(
      MaterialApp(home: SyncPage(repository: repository, authStore: store)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('sync-now')));
    await tester.pumpAndSettle();
    expect(find.text('Full sync required'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('full-sync-download')));
    await tester.pumpAndSettle();

    expect(repository.fullUpload, isFalse);
    expect(repository.fullServerUsn, 17);
  });
}

class _Store implements SyncAuthStore {
  sync.SyncAuth? value;

  @override
  Future<void> clear() async => value = null;

  @override
  Future<sync.SyncAuth?> load() async => value?.deepCopy();

  @override
  Future<void> save(sync.SyncAuth auth) async => value = auth.deepCopy();
}

class _Repository implements SyncRepository {
  _Repository({sync.SyncCollectionResponse? collectionResponse})
      : collectionResponse = collectionResponse ??
            sync.SyncCollectionResponse(
              required: sync.SyncCollectionResponse_ChangesRequired.NO_CHANGES,
            );

  final sync.SyncCollectionResponse collectionResponse;
  String? loginPassword;
  bool? fullUpload;
  int? fullServerUsn;

  @override
  Future<sync.SyncAuth> login({
    required String username,
    required String password,
    String? endpoint,
  }) async {
    loginPassword = password;
    return sync.SyncAuth(hkey: 'host-key');
  }

  @override
  Future<sync.SyncCollectionResponse> syncCollection(
    sync.SyncAuth auth, {
    required bool syncMedia,
  }) async => collectionResponse.deepCopy();

  @override
  Future<void> fullSync(
    sync.SyncAuth auth, {
    required bool upload,
    int? serverUsn,
  }) async {
    fullUpload = upload;
    fullServerUsn = serverUsn;
  }

  @override
  Future<sync.SyncStatusResponse> status(sync.SyncAuth auth) async =>
      sync.SyncStatusResponse(required: sync.SyncStatusResponse_Required.NO_CHANGES);

  @override
  Future<void> syncMedia(sync.SyncAuth auth) async {}

  @override
  Future<sync.MediaSyncStatusResponse> mediaStatus() async =>
      sync.MediaSyncStatusResponse(active: false);

  @override
  Future<void> abortCollectionSync() async {}

  @override
  Future<void> abortMediaSync() async {}

  @override
  Future<bool> setCustomCertificate(String certificatePem) async => true;
}
