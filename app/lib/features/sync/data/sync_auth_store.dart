import 'dart:convert';
import 'dart:io';

import 'package:anki_flutter/core/backend/generated/anki/sync.pb.dart' as sync;
import 'package:anki_flutter/features/collection/mobile_collection_storage.dart';

abstract interface class SyncAuthStore {
  Future<sync.SyncAuth?> load();
  Future<void> save(sync.SyncAuth auth);
  Future<void> clear();
}

class FileSyncAuthStore implements SyncAuthStore {
  FileSyncAuthStore({File? file})
      : file = file ??
            File(
              '${ApplicationDataPaths.applicationSupportDirectory.path}'
              '${Platform.pathSeparator}sync-auth.json',
            );

  final File file;

  @override
  Future<sync.SyncAuth?> load() async {
    if (!await file.exists()) return null;
    try {
      final decoded = jsonDecode(await file.readAsString());
      if (decoded is! Map<String, dynamic>) return null;
      final hkey = decoded['hkey'];
      if (hkey is! String || hkey.isEmpty) return null;
      final auth = sync.SyncAuth(hkey: hkey);
      final endpoint = decoded['endpoint'];
      if (endpoint is String && endpoint.isNotEmpty) auth.endpoint = endpoint;
      final timeout = decoded['ioTimeoutSecs'];
      if (timeout is int && timeout > 0) auth.ioTimeoutSecs = timeout;
      return auth;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(sync.SyncAuth auth) async {
    if (auth.hkey.isEmpty) {
      throw ArgumentError('Sync host key must not be empty');
    }
    await file.parent.create(recursive: true);
    final data = <String, Object>{'hkey': auth.hkey};
    if (auth.hasEndpoint() && auth.endpoint.isNotEmpty) {
      data['endpoint'] = auth.endpoint;
    }
    if (auth.hasIoTimeoutSecs() && auth.ioTimeoutSecs > 0) {
      data['ioTimeoutSecs'] = auth.ioTimeoutSecs;
    }
    await file.writeAsString(jsonEncode(data), flush: true);
  }

  @override
  Future<void> clear() async {
    if (await file.exists()) await file.delete();
  }
}
