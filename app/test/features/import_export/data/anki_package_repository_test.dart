import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads Anki package import presets', () async {
    final expected = import_export.ImportAnkiPackageOptions(
      mergeNotetypes: true,
      updateNotes: import_export.ImportAnkiPackageUpdateCondition
          .IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER,
      updateNotetypes: import_export.ImportAnkiPackageUpdateCondition
          .IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_IF_NEWER,
      withScheduling: true,
      withDeckConfigs: true,
    );
    final backend = _BackendQueue([expected.writeToBuffer()]);
    final repository = AnkiPackageRepository(backend: backend);

    final actual = await repository.getImportPresets();

    expect(backend.calls.single.operation, BackendOperation.getImportAnkiPackagePresets);
    expect(actual, expected);
  });

  test('imports the selected package using supplied Anki options', () async {
    final options = import_export.ImportAnkiPackageOptions(
      mergeNotetypes: true,
      withScheduling: false,
      withDeckConfigs: true,
    );
    final expected = import_export.ImportResponse(
      log: import_export.ImportResponse_Log(foundNotes: 12),
    );
    final backend = _BackendQueue([expected.writeToBuffer()]);
    final repository = AnkiPackageRepository(backend: backend);

    final actual = await repository.importPackage('/tmp/cards.apkg', options);

    expect(backend.calls.single.operation, BackendOperation.importAnkiPackage);
    expect(
      import_export.ImportAnkiPackageRequest.fromBuffer(backend.calls.single.request),
      import_export.ImportAnkiPackageRequest(
        packagePath: '/tmp/cards.apkg',
        options: options,
      ),
    );
    expect(actual.log.foundNotes, 12);
  });

  test('exports the whole collection with media and scheduling', () async {
    final backend = _BackendQueue([generic.UInt32(val: 17).writeToBuffer()]);
    final repository = AnkiPackageRepository(backend: backend);

    final mediaFiles = await repository.exportPackage(
      '/tmp/export.apkg',
      withScheduling: true,
      withDeckConfigs: true,
      withMedia: true,
      legacy: false,
    );

    expect(backend.calls.single.operation, BackendOperation.exportAnkiPackage);
    final request = import_export.ExportAnkiPackageRequest.fromBuffer(
      backend.calls.single.request,
    );
    expect(request.outPath, '/tmp/export.apkg');
    expect(request.options.withScheduling, isTrue);
    expect(request.options.withDeckConfigs, isTrue);
    expect(request.options.withMedia, isTrue);
    expect(request.options.legacy, isFalse);
    expect(request.limit.hasWholeCollection(), isTrue);
    expect(mediaFiles, 17);
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
