import 'dart:io';

import 'package:anki_flutter/core/backend/generated/anki/sync.pb.dart' as sync;
import 'package:anki_flutter/features/sync/data/sync_auth_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('round-trips host key and endpoint only', () async {
    final directory = await Directory.systemTemp.createTemp('ankiflutter-sync-auth-test-');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}${Platform.pathSeparator}auth.json');
    final store = FileSyncAuthStore(file: file);

    await store.save(
      sync.SyncAuth(
        hkey: 'host-key',
        endpoint: 'https://sync.example',
        ioTimeoutSecs: 45,
      ),
    );

    final raw = await file.readAsString();
    expect(raw, contains('host-key'));
    expect(raw, contains('https://sync.example'));
    expect(raw, isNot(contains('password')));

    final loaded = await store.load();
    expect(loaded?.hkey, 'host-key');
    expect(loaded?.endpoint, 'https://sync.example');
    expect(loaded?.ioTimeoutSecs, 45);
  });

  test('clear removes persisted sync authorization', () async {
    final directory = await Directory.systemTemp.createTemp('ankiflutter-sync-auth-test-');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}${Platform.pathSeparator}auth.json');
    final store = FileSyncAuthStore(file: file);
    await store.save(sync.SyncAuth(hkey: 'host-key'));

    await store.clear();

    expect(await file.exists(), isFalse);
    expect(await store.load(), isNull);
  });
  test('concurrent logout and save finish in requested order', () async {
    final directory = await Directory.systemTemp.createTemp('ankiflutter-auth-queue-');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/auth.json');
    final first = FileSyncAuthStore(file: file);
    final second = FileSyncAuthStore(file: file);
    await Future.wait([
      first.save(sync.SyncAuth(hkey: 'old-host-key')),
      second.clear(),
    ]);
    expect(await first.load(), isNull);
    expect(await file.exists(), isFalse);

    await Future.wait([
      first.clear(),
      second.save(sync.SyncAuth(hkey: 'fresh-key')),
    ]);
    expect((await first.load())?.hkey, 'fresh-key');
  });

}
