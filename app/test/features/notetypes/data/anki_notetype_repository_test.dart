import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notetypes/data/anki_notetype_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lists note types with their use counts', () async {
    final response = notetypes.NotetypeUseCounts(
      entries: [
        notetypes.NotetypeNameIdUseCount(
          id: Int64(12),
          name: 'Basic',
          useCount: 7,
        ),
      ],
    );
    final backend = _BackendQueue([response.writeToBuffer()]);
    final repository = AnkiNotetypeRepository(backend: backend);

    final result = await repository.listNotetypes();

    expect(backend.calls.single.operation, BackendOperation.getNotetypeNamesAndCounts);
    expect(result.entries.single.name, 'Basic');
    expect(result.entries.single.useCount, 7);
  });

  test('loads and updates a complete note type through Anki', () async {
    final expected = notetypes.Notetype(id: Int64(12), name: 'Basic');
    final backend = _BackendQueue([
      expected.writeToBuffer(),
      Uint8List(0),
    ]);
    final repository = AnkiNotetypeRepository(backend: backend);

    final loaded = await repository.getNotetype(12);
    loaded.name = 'Basic edited';
    await repository.updateNotetype(loaded);

    expect(backend.calls[0].operation, BackendOperation.getNotetype);
    expect(
      notetypes.NotetypeId.fromBuffer(backend.calls[0].request),
      notetypes.NotetypeId(ntid: Int64(12)),
    );
    expect(backend.calls[1].operation, BackendOperation.updateNotetype);
    expect(
      notetypes.Notetype.fromBuffer(backend.calls[1].request).name,
      'Basic edited',
    );
  });

  test('duplicates without reusing note type, field, or template identity', () async {
    final source = notetypes.Notetype(
      id: Int64(12),
      name: 'Basic',
      mtimeSecs: Int64(99),
      usn: 3,
      fields: [
        notetypes.Notetype_Field(
          ord: generic.UInt32(val: 0),
          name: 'Front',
          config: notetypes.Notetype_Field_Config(id: Int64(101)),
        ),
      ],
      templates: [
        notetypes.Notetype_Template(
          ord: generic.UInt32(val: 0),
          name: 'Card 1',
          mtimeSecs: Int64(99),
          usn: 3,
          config: notetypes.Notetype_Template_Config(
            qFormat: '{{Front}}',
            aFormat: '{{FrontSide}}',
            id: Int64(201),
          ),
        ),
      ],
    );
    final ids = <Int64>[Int64(501), Int64(502)].iterator;
    final backend = _BackendQueue([
      source.writeToBuffer(),
      Uint8List(0),
    ]);
    final repository = AnkiNotetypeRepository(
      backend: backend,
      configIdGenerator: () {
        ids.moveNext();
        return ids.current;
      },
    );

    await repository.duplicateNotetype(12, 'Basic copy');

    expect(backend.calls.map((call) => call.operation), [
      BackendOperation.getNotetype,
      BackendOperation.addNotetype,
    ]);
    final duplicate = notetypes.Notetype.fromBuffer(backend.calls[1].request);
    expect(duplicate.id, Int64(0));
    expect(duplicate.name, 'Basic copy');
    expect(duplicate.mtimeSecs, Int64(0));
    expect(duplicate.usn, 0);
    expect(duplicate.fields.single.hasOrd(), isFalse);
    expect(duplicate.fields.single.config.id, Int64(501));
    expect(duplicate.templates.single.hasOrd(), isFalse);
    expect(duplicate.templates.single.mtimeSecs, Int64(0));
    expect(duplicate.templates.single.usn, 0);
    expect(duplicate.templates.single.config.id, Int64(502));
    expect(source.id, Int64(12), reason: 'source must not be mutated');
  });

  test('removes a note type using its Anki id', () async {
    final backend = _BackendQueue([Uint8List(0)]);
    final repository = AnkiNotetypeRepository(backend: backend);

    await repository.removeNotetype(42);

    expect(backend.calls.single.operation, BackendOperation.removeNotetype);
    expect(
      notetypes.NotetypeId.fromBuffer(backend.calls.single.request),
      notetypes.NotetypeId(ntid: Int64(42)),
    );
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
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    calls.add(_Call(operation, request));
    return responses[_index++];
  }
}
