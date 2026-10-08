import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/config.pb.dart'
    as config;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart'
    as scheduler;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reads Anki browser-specific Set Due Date preference', () async {
    final backend = _Backend()
      ..responses[BackendOperation.getConfigString] =
          Uint8List.fromList(generic.String(val: '3-7').writeToBuffer());

    final result =
        await AnkiCardBrowserRepository(backend: backend).setDueDateDefault();

    expect(result, '3-7');
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.getConfigString);
    final request = config.GetConfigStringRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.key, config.ConfigKey_String.SET_DUE_BROWSER);
  });

  test('passes only selected cards and browser config to Anki', () async {
    final backend = _Backend();
    final repository = AnkiCardBrowserRepository(backend: backend);

    await repository.setCardsDueDate([21, 34, 55], '1!');

    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.setDueDate);
    final request =
        scheduler.SetDueDateRequest.fromBuffer(backend.calls.single.request);
    expect(request.cardIds, [Int64(21), Int64(34), Int64(55)]);
    expect(request.days, '1!');
    expect(request.hasConfigKey(), isTrue);
    expect(request.configKey.key, config.ConfigKey_String.SET_DUE_BROWSER);
  });

  test('does not mutate scheduling on empty selection', () async {
    final backend = _Backend();
    await AnkiCardBrowserRepository(backend: backend)
        .setCardsDueDate([], '5');
    expect(backend.calls, isEmpty);
  });
}

class _Call {
  const _Call(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}

class _Backend implements BackendInvoker {
  final calls = <_Call>[];
  final responses = <BackendOperation, Uint8List>{};

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    return responses[operation] ?? Uint8List(0);
  }
}
