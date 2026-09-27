import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart';
import 'package:anki_flutter/features/collection/collection_location.dart';
import 'package:anki_flutter/features/collection/collection_session.dart';
import 'package:anki_flutter/features/reviewer/media/review_media_server.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeBackend backend;
  late _FakeReviewMediaServer mediaServer;
  late CollectionSession session;
  final location = CollectionLocation.fromCollectionPath('/tmp/collection.anki2');

  setUp(() {
    backend = _FakeBackend();
    mediaServer = _FakeReviewMediaServer();
    session = CollectionSession(backend: backend, mediaServer: mediaServer);
  });

  test('open serializes paths records location and starts media after backend', () async {
    await session.open(location);

    expect(session.isOpen, isTrue);
    expect(session.location, same(location));
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.openCollection);
    final request = OpenCollectionRequest.fromBuffer(backend.calls.single.request);
    expect(request.collectionPath, '/tmp/collection.anki2');
    expect(request.mediaFolderPath, '/tmp/collection.media');
    expect(request.mediaDbPath, '/tmp/collection.media.db2');
    expect(mediaServer.startCalls, ['/tmp/collection.media']);
    expect(
      [...backend.events, ...mediaServer.events]..sort((a, b) => a.order.compareTo(b.order)),
      hasLength(2),
    );
    expect(backend.events.single.name, 'backend:open');
    expect(mediaServer.events.single.name, 'media:start');
    expect(backend.events.single.order, lessThan(mediaServer.events.single.order));
  });

  test('failed open leaves session closed without starting media', () async {
    backend.error = StateError('open failed');

    await expectLater(session.open(location), throwsStateError);
    expect(session.isOpen, isFalse);
    expect(session.location, isNull);
    expect(mediaServer.startCalls, isEmpty);
  });

  test('close clears location closes media and sends non-downgrading request', () async {
    await session.open(location);
    backend.calls.clear();

    await session.close();

    expect(session.isOpen, isFalse);
    expect(session.location, isNull);
    expect(mediaServer.closeCalls, 1);
    expect(backend.calls, hasLength(1));
    expect(backend.calls.single.operation, BackendOperation.closeCollection);
    final request = CloseCollectionRequest.fromBuffer(backend.calls.single.request);
    expect(request.downgradeToSchema11, isFalse);
  });

  test('second close is a no-op for backend and media server', () async {
    await session.open(location);
    await session.close();
    final callsAfterFirstClose = backend.calls.length;
    final mediaClosesAfterFirstClose = mediaServer.closeCalls;

    await session.close();

    expect(backend.calls.length, callsAfterFirstClose);
    expect(mediaServer.closeCalls, mediaClosesAfterFirstClose);
  });
}

int _eventOrder = 0;

class _FakeBackend implements BackendInvoker {
  final calls = <_Invocation>[];
  final events = <_OrderedEvent>[];
  Object? error;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Invocation(operation, request));
    if (error case final error?) {
      throw error;
    }
    if (operation == BackendOperation.openCollection) {
      events.add(_OrderedEvent('backend:open', _eventOrder++));
    }
    return Uint8List(0);
  }
}

class _FakeReviewMediaServer extends ReviewMediaServer {
  final startCalls = <String>[];
  final events = <_OrderedEvent>[];
  int closeCalls = 0;

  @override
  Future<Uri> start(String mediaRoot) async {
    startCalls.add(mediaRoot);
    events.add(_OrderedEvent('media:start', _eventOrder++));
    return Uri.parse('http://127.0.0.1:43210/token/');
  }

  @override
  Future<void> close() async {
    closeCalls += 1;
  }
}

class _OrderedEvent {
  const _OrderedEvent(this.name, this.order);
  final String name;
  final int order;
}

class _Invocation {
  const _Invocation(this.operation, this.request);
  final BackendOperation operation;
  final Uint8List request;
}
