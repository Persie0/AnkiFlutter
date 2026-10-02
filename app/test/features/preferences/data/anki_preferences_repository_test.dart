import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/config.pb.dart' as config;
import 'package:anki_flutter/features/preferences/data/anki_preferences_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads collection preferences from Anki', () async {
    final expected = config.Preferences(
      scheduling: config.Preferences_Scheduling(rollover: 4, learnAheadSecs: 1200),
      reviewing: config.Preferences_Reviewing(showIntervalsOnButtons: true),
    );
    final backend = _BackendQueue([expected.writeToBuffer()]);
    final repository = AnkiPreferencesRepository(backend: backend);

    final result = await repository.load();

    expect(result.scheduling.rollover, 4);
    expect(result.reviewing.showIntervalsOnButtons, isTrue);
    expect(backend.calls.single.operation, BackendOperation.getPreferences);
    expect(backend.calls.single.request, isEmpty);
  });

  test('sends the complete preference protobuf back to Anki', () async {
    final backend = _BackendQueue([Uint8List(0)]);
    final repository = AnkiPreferencesRepository(backend: backend);
    final preferences = config.Preferences(
      scheduling: config.Preferences_Scheduling(rollover: 5),
      editing: config.Preferences_Editing(renderLatex: true),
      backups: config.Preferences_BackupLimits(daily: 8),
    );

    await repository.save(preferences);

    expect(backend.calls.single.operation, BackendOperation.setPreferences);
    final sent = config.Preferences.fromBuffer(backend.calls.single.request);
    expect(sent.scheduling.rollover, 5);
    expect(sent.editing.renderLatex, isTrue);
    expect(sent.backups.daily, 8);
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
