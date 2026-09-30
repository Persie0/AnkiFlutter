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

  test('failed media startup closes the backend collection again', () async {
    mediaServer.startError = StateError('media server failed');

    await expectLater(session.open(location), throwsStateError);

    expect(session.isOpen, isFalse);
    expect(session.location, isNull);
    expect(
      backend.calls.map((call) => call.operation),
      [BackendOperation.openCollection, BackendOperation.closeCollection],
    );
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

  test('opening another collection closes the old one before opening it', () async {
    const nextLocation = CollectionLocation(
      collectionPath: '/tmp/next.anki2',
      mediaFolderPath: '/tmp/next.media',
      mediaDbPath: '/tmp/next.media.db2',
    );
    await session.open(location);
    backend.calls.clear();

    await session.open(nextLocation);

    expect(
      backend.calls.map((call) => call.operation),
      [BackendOperation.closeCollection, BackendOperation.openCollection],
    );
    expect(session.isOpen, isTrue);
    expect(session.location, same(nextLocation));
    expect(mediaServer.closeCalls, 1);
    expect(mediaServer.startCalls, ['/tmp/collection.media', '/tmp/next.media']);
  });

  test('failed collection switch restores the previously open collection', () async {
    const nextLocation = CollectionLocation(
      collectionPath: '/tmp/next.anki2',
      mediaFolderPath: '/tmp/next.media',
      mediaDbPath: '/tmp/next.media.db2',
    );
    await session.open(location);
    backend.calls.clear();
    backend.openFailures[nextLocation.collectionPath] = 1;

    await expectLater(session.open(nextLocation), throwsStateError);

    expect(
      backend.calls.map((call) => call.operation),
      [
        BackendOperation.closeCollection,
        BackendOperation.openCollection,
        BackendOperation.openCollection,
      ],
    );
    expect(session.isOpen, isTrue);
    expect(session.location, same(location));
    expect(session.mediaBaseUri, isNotNull);
    expect(mediaServer.closeCalls, 1);
    expect(
      mediaServer.startCalls,
      ['/tmp/collection.media', '/tmp/collection.media'],
    );
  });

  test('opening the already open location is a no-op', () async {
    await session.open(location);
    backend.calls.clear();

    await session.open(location);

    expect(backend.calls, isEmpty);
    expect(mediaServer.startCalls, ['/tmp/collection.media']);
    expect(mediaServer.closeCalls, 0);
  });

  test('reports when a failed switch cannot restore the previous collection', () async {
    const nextLocation = CollectionLocation(
      collectionPath: '/tmp/next.anki2',
      mediaFolderPath: '/tmp/next.media',
      mediaDbPath: '/tmp/next.media.db2',
    );
    await session.open(location);
    backend.openFailures[nextLocation.collectionPath] = 1;
    backend.openFailures[location.collectionPath] = 1;

    await expectLater(
      session.open(nextLocation),
      throwsA(isA<CollectionSwitchException>()),
    );

    expect(session.isOpen, isFalse);
    expect(session.location, isNull);
    expect(session.mediaBaseUri, isNull);
  });

  test('close failure keeps the active collection state intact', () async {
    await session.open(location);
    backend.error = StateError('close failed');

    await expectLater(session.close(), throwsStateError);

    expect(session.isOpen, isTrue);
    expect(session.location, same(location));
    expect(session.mediaBaseUri, isNotNull);
    expect(mediaServer.closeCalls, 0);
  });

  test('media shutdown failure restores the collection before rejecting a switch', () async {
    const nextLocation = CollectionLocation(
      collectionPath: '/tmp/next.anki2',
      mediaFolderPath: '/tmp/next.media',
      mediaDbPath: '/tmp/next.media.db2',
    );
    await session.open(location);
    backend.calls.clear();
    mediaServer.closeError = StateError('media shutdown failed');

    await expectLater(session.open(nextLocation), throwsStateError);

    expect(
      backend.calls.map((call) => call.operation),
      [BackendOperation.closeCollection, BackendOperation.openCollection],
    );
    expect(session.isOpen, isTrue);
    expect(session.location, same(location));
    expect(mediaServer.startCalls, ['/tmp/collection.media', '/tmp/collection.media']);
  });
}

int _eventOrder = 0;

class _FakeBackend implements BackendInvoker {
  final calls = <_Invocation>[];
  final events = <_OrderedEvent>[];
  final openFailures = <String, int>{};
  Object? error;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Invocation(operation, request));
    if (error case final error?) {
      throw error;
    }
    if (operation == BackendOperation.openCollection) {
      final path = OpenCollectionRequest.fromBuffer(request).collectionPath;
      final failuresRemaining = openFailures[path] ?? 0;
      if (failuresRemaining > 0) {
        openFailures[path] = failuresRemaining - 1;
        throw StateError('open failed: $path');
      }
      events.add(_OrderedEvent('backend:open', _eventOrder++));
    }
    return Uint8List(0);
  }
}

class _FakeReviewMediaServer extends ReviewMediaServer {
  final startCalls = <String>[];
  final events = <_OrderedEvent>[];
  int closeCalls = 0;
  Object? startError;
  Object? closeError;

  @override
  Future<Uri> start(String mediaRoot) async {
    startCalls.add(mediaRoot);
    events.add(_OrderedEvent('media:start', _eventOrder++));
    if (startError case final error?) {
      throw error;
    }
    return Uri.parse('http://127.0.0.1:43210/token/');
  }

  @override
  Future<void> close() async {
    closeCalls += 1;
    if (closeError case final error?) {
      throw error;
    }
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
