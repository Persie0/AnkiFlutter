import 'dart:math';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:fixnum/fixnum.dart';

abstract interface class NotetypeRepository {
  Future<notetypes.NotetypeUseCounts> listNotetypes();

  Future<notetypes.Notetype> getNotetype(int notetypeId);

  Future<void> updateNotetype(notetypes.Notetype notetype);

  Future<void> duplicateNotetype(int sourceNotetypeId, String name);

  Future<void> removeNotetype(int notetypeId);
}

class AnkiNotetypeRepository implements NotetypeRepository {
  AnkiNotetypeRepository({
    required this.backend,
    Int64 Function()? configIdGenerator,
  }) : _configIdGenerator = configIdGenerator ?? _defaultConfigId;

  final BackendInvoker backend;
  final Int64 Function() _configIdGenerator;

  @override
  Future<notetypes.NotetypeUseCounts> listNotetypes() async {
    final response = await backend.invoke(
      BackendOperation.getNotetypeNamesAndCounts,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return notetypes.NotetypeUseCounts.fromBuffer(response);
  }

  @override
  Future<notetypes.Notetype> getNotetype(int notetypeId) async {
    final response = await backend.invoke(
      BackendOperation.getNotetype,
      Uint8List.fromList(
        notetypes.NotetypeId(ntid: Int64(notetypeId)).writeToBuffer(),
      ),
    );
    return notetypes.Notetype.fromBuffer(response);
  }

  @override
  Future<void> updateNotetype(notetypes.Notetype notetype) async {
    await backend.invoke(
      BackendOperation.updateNotetype,
      Uint8List.fromList(notetype.writeToBuffer()),
    );
  }

  @override
  Future<void> duplicateNotetype(int sourceNotetypeId, String name) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Note type name must not be empty');
    }

    final source = await getNotetype(sourceNotetypeId);
    final duplicate = source.deepCopy()
      ..id = Int64.ZERO
      ..name = trimmedName
      ..mtimeSecs = Int64.ZERO
      ..usn = 0;

    for (final field in duplicate.fields) {
      field.clearOrd();
      field.ensureConfig().id = _configIdGenerator();
    }
    for (final template in duplicate.templates) {
      template.clearOrd();
      template.mtimeSecs = Int64.ZERO;
      template.usn = 0;
      template.ensureConfig().id = _configIdGenerator();
    }

    await backend.invoke(
      BackendOperation.addNotetype,
      Uint8List.fromList(duplicate.writeToBuffer()),
    );
  }

  @override
  Future<void> removeNotetype(int notetypeId) async {
    await backend.invoke(
      BackendOperation.removeNotetype,
      Uint8List.fromList(
        notetypes.NotetypeId(ntid: Int64(notetypeId)).writeToBuffer(),
      ),
    );
  }
}

Int64 _defaultConfigId() {
  final randomBits = Random.secure().nextInt(0x7fffffff);
  return Int64(DateTime.now().microsecondsSinceEpoch ^ randomBits);
}
