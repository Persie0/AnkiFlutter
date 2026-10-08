import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/sync.pb.dart' as sync;
import 'package:anki_flutter/features/sync/data/anki_sync_repository.dart';
import 'package:anki_flutter/features/collection/data/anki_collection_backup_repository.dart';
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
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Full sync required'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('full-sync-download')));
    await tester.pumpAndSettle();

    expect(repository.fullUpload, isFalse);
    expect(repository.fullServerUsn, 17);
  });

  testWidgets('full download creates native backup before replacement',
      (tester) async {
    final repository = _Repository(
      collectionResponse: sync.SyncCollectionResponse(
        required: sync.SyncCollectionResponse_ChangesRequired.FULL_SYNC,
      ),
    );
    final backup = _Backup();
    final store = _Store()..value = sync.SyncAuth(hkey: 'host-key');
    await tester.pumpWidget(MaterialApp(home: SyncPage(
      repository: repository,
      authStore: store,
      backupRepository: backup,
      chooseBackupDirectory: () async => '/native/backups',
    )));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('sync-now')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const ValueKey('full-sync-download')));
    await tester.pumpAndSettle();
    expect(find.text('Protect the local collection'), findsOneWidget);
    expect(find.textContaining('Media files are not included'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('full-sync-create-backup')));
    await tester.pumpAndSettle();

    expect(backup.directories, ['/native/backups']);
    expect(repository.fullUpload, isFalse);
  });

  testWidgets('declined backup never starts destructive full download',
      (tester) async {
    final repository = _Repository(
      collectionResponse: sync.SyncCollectionResponse(
        required: sync.SyncCollectionResponse_ChangesRequired.FULL_DOWNLOAD,
      ),
    );
    final backup = _Backup();
    final store = _Store()..value = sync.SyncAuth(hkey: 'host-key');
    await tester.pumpWidget(MaterialApp(home: SyncPage(
      repository: repository,
      authStore: store,
      backupRepository: backup,
      chooseBackupDirectory: () async => null,
    )));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('sync-now')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Download'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('full-sync-create-backup')));
    await tester.pumpAndSettle();

    expect(backup.directories, isEmpty);
    expect(repository.fullUpload, isNull);
  });

  testWidgets('failed native backup blocks replacing local collection',
      (tester) async {
    final repository = _Repository(
      collectionResponse: sync.SyncCollectionResponse(
        required: sync.SyncCollectionResponse_ChangesRequired.FULL_SYNC,
      ),
    );
    final backup = _Backup()..created = false;
    final store = _Store()..value = sync.SyncAuth(hkey: 'host-key');
    await tester.pumpWidget(MaterialApp(home: SyncPage(
      repository: repository,
      authStore: store,
      backupRepository: backup,
      chooseBackupDirectory: () async => '/native/backups',
    )));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('sync-now')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const ValueKey('full-sync-download')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('full-sync-create-backup')));
    await tester.pumpAndSettle();

    expect(repository.fullUpload, isNull);
    expect(backup.directories, ['/native/backups']);
    expect(find.textContaining('Anki did not create the backup'), findsOneWidget);
  });

  testWidgets('explicit skip backup allows full download', (tester) async {
    final repository = _Repository(
      collectionResponse: sync.SyncCollectionResponse(
        required: sync.SyncCollectionResponse_ChangesRequired.FULL_SYNC,
      ),
    );
    final backup = _Backup();
    final store = _Store()..value = sync.SyncAuth(hkey: 'host-key');
    await tester.pumpWidget(MaterialApp(home: SyncPage(
      repository: repository,
      authStore: store,
      backupRepository: backup,
    )));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('sync-now')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const ValueKey('full-sync-download')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('full-sync-skip-backup')));
    await tester.pumpAndSettle();

    expect(backup.directories, isEmpty);
    expect(repository.fullUpload, isFalse);
  });

  testWidgets('sign out ignores a pending response from the previous account',
      (tester) async {
    final repository = _Repository()..manualMediaStatus = true;
    final store = _Store()..value = sync.SyncAuth(hkey: 'host-key');
    await tester.pumpWidget(
      MaterialApp(home: SyncPage(repository: repository, authStore: store)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(repository.mediaStatusCalls, 1);

    await tester.tap(find.byTooltip('Sign out'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(store.value, isNull);
    expect(find.byKey(const ValueKey('sync-login')), findsOneWidget);

    repository.pendingMediaStatuses.single.complete(
      sync.MediaSyncStatusResponse(active: true),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Media sync active'), findsNothing);
    expect(find.text('Media sync failed'), findsNothing);
  });

  testWidgets('media status timer does not overlap an unresolved request',
      (tester) async {
    final repository = _Repository()..manualMediaStatus = true;
    final store = _Store()..value = sync.SyncAuth(hkey: 'host-key');
    await tester.pumpWidget(
      MaterialApp(home: SyncPage(repository: repository, authStore: store)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(repository.mediaStatusCalls, 1);

    await tester.tap(find.text('Sync media only'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(repository.mediaStatusCalls, 2);

    await tester.pump(const Duration(seconds: 4));
    expect(repository.mediaStatusCalls, 2,
        reason: 'Only one request may be in flight per active polling session');

    // A completion from before the polling restart must not override
    // the status returned by the new request.
    repository.pendingMediaStatuses.first.complete(
      sync.MediaSyncStatusResponse(active: true),
    );
    repository.pendingMediaStatuses.last.complete(
      sync.MediaSyncStatusResponse(active: false),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Media sync idle'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(repository.mediaStatusCalls, 2);
  });

}


class _Backup implements CollectionBackupRepository {
  final directories = <String>[];
  bool created = true;

  @override
  Future<bool> createBackup(String backupDirectory) async {
    directories.add(backupDirectory);
    return created;
  }
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
  bool manualMediaStatus = false;
  int mediaStatusCalls = 0;
  final pendingMediaStatuses = <Completer<sync.MediaSyncStatusResponse>>[];

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
  Future<sync.MediaSyncStatusResponse> mediaStatus() async {
    mediaStatusCalls++;
    if (manualMediaStatus) {
      final pending = Completer<sync.MediaSyncStatusResponse>();
      pendingMediaStatuses.add(pending);
      return pending.future;
    }
    return sync.MediaSyncStatusResponse(active: false);
  }

  @override
  Future<void> abortCollectionSync() async {}

  @override
  Future<void> abortMediaSync() async {}

  @override
  Future<bool> setCustomCertificate(String certificatePem) async => true;
}
