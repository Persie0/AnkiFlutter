import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/features/collection/collection_location.dart';
import 'package:anki_flutter/features/collection/collection_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeBackend backend;
  late CollectionSession session;
  final location = CollectionLocation.fromCollectionPath('/tmp/collection.anki2');

  setUp(() {
    backend = _FakeBackend();
    session = CollectionSession(backend: backend);
  });

  test('open serializes all Anki collection paths and marks session open', () async {
    await session.open(location);

    expect(session.isOpen, isTrue);
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.openCollection);
    final request = OpenCollectionRequest.fromBuffer(backend.calls.single.request);
    expect(request.collectionPath, '/tmp/collection.anki2');
    expect(request.mediaFolderPath, '/tmp/collection.media');
    expect(request.mediaDbPath, '/tmp/collection.media.db2');
  });

  test('failed open leaves session closed', () async {
    backend.error = StateError('open failed');

    await expectLater(session.open(location), throwsStateError);
    expect(session.isOpen, isFalse);
  });

  test('close sends non-downgrading request and marks session closed', () async {
    await session.open(location);
    backend.calls.clear();

    await session.close();

    expect(session.isOpen, isFalse);
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.closeCollection);
    final request = CloseCollectionRequest.fromBuffer(backend.calls.single.request);
    expect(request.downgradeToSchema11, isFalse);
  });

  test('second close is a no-op', () async {
    await session.open(location);
    await session.close();
    final callsAfterFirstClose = backend.calls.length;

    await session.close();

    expect(backend.calls.length, callsAfterFirstClose);
  });
}

class _FakeBackend implements BackendInvoker {
  final calls = <_Invocation>[];
  Object? error;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Invocation(operation, request));
    if (error case final error?) {
      throw error;
    }
    return Uint8List(0);
  }
}

class _Invocation {
  const _Invocation(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}
