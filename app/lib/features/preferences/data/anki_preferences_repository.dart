import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/config.pb.dart' as config;

abstract interface class PreferencesRepository {
  Future<config.Preferences> load();
  Future<void> save(config.Preferences preferences);
}

class AnkiPreferencesRepository implements PreferencesRepository {
  const AnkiPreferencesRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<config.Preferences> load() async {
    final response = await backend.invoke(
      BackendOperation.getPreferences,
      Uint8List(0),
    );
    return config.Preferences.fromBuffer(response);
  }

  @override
  Future<void> save(config.Preferences preferences) async {
    await backend.invoke(
      BackendOperation.setPreferences,
      Uint8List.fromList(preferences.writeToBuffer()),
    );
  }
}
