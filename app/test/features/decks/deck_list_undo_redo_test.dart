import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/decks/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('undo and redo follow native collection history and reload decks',
      (tester) async {
    final backend = _HistoryBackend()
      ..state = collection.UndoStatus(undo: 'Add note');
    final decks = _DeckRepository();
    await tester.pumpWidget(_app(backend, decks));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    final undo = find.byKey(const ValueKey('collection-undo'));
    final redo = find.byKey(const ValueKey('collection-redo'));
    expect(tester.widget<IconButton>(undo).onPressed, isNotNull);
    expect(tester.widget<IconButton>(redo).onPressed, isNull);
    expect(tester.widget<IconButton>(undo).tooltip, 'Undo Add note');
    final initialDeckLoads = decks.loads;

    await tester.tap(undo);
    await tester.pumpAndSettle();

    expect(backend.undos, 1);
    expect(backend.redos, 0);
    expect(decks.loads, initialDeckLoads + 1);
    expect(tester.widget<IconButton>(undo).onPressed, isNull);
    expect(tester.widget<IconButton>(redo).tooltip, 'Redo Add note');

    await tester.tap(redo);
    await tester.pumpAndSettle();
    expect(backend.redos, 1);
    expect(decks.loads, initialDeckLoads + 2);
    expect(tester.widget<IconButton>(undo).onPressed, isNotNull);
    expect(tester.widget<IconButton>(redo).onPressed, isNull);
  });

  testWidgets('no native undo history keeps controls disabled', (tester) async {
    final backend = _HistoryBackend();
    await tester.pumpWidget(_app(backend, _DeckRepository()));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<IconButton>(find.byKey(const ValueKey('collection-undo')))
          .onPressed,
      isNull,
    );
    expect(
      tester.widget<IconButton>(find.byKey(const ValueKey('collection-redo')))
          .onPressed,
      isNull,
    );
    expect(backend.undos, 0);
    expect(backend.redos, 0);
  });

  testWidgets('native undo failure keeps the collection open and retryable',
      (tester) async {
    final backend = _HistoryBackend()
      ..state = collection.UndoStatus(undo: 'Add note')
      ..fail = true;
    final decks = _DeckRepository();
    await tester.pumpWidget(_app(backend, decks));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    final loads = decks.loads;

    await tester.tap(find.byKey(const ValueKey('collection-undo')));
    await tester.pumpAndSettle();

    expect(find.textContaining('native history failed'), findsOneWidget);
    expect(decks.loads, loads);
    expect(find.text('Decks'), findsOneWidget);
    expect(
      tester.widget<IconButton>(find.byKey(const ValueKey('collection-undo')))
          .onPressed,
      isNotNull,
    );
    backend.fail = false;
    await tester.tap(find.byKey(const ValueKey('collection-undo')));
    await tester.pumpAndSettle();
    expect(backend.undos, 2);
    expect(decks.loads, loads + 1);
  });

  testWidgets('pending undo disables both controls and prevents duplicate undo',
      (tester) async {
    final backend = _HistoryBackend()
      ..state = collection.UndoStatus(undo: 'Add note');
    final pending = Completer<void>();
    backend.pendingUndo = pending;
    await tester.pumpWidget(_app(backend, _DeckRepository()));
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('collection-undo')));
    await tester.pump();

    expect(backend.undos, 1);
    expect(
      tester.widget<IconButton>(find.byKey(const ValueKey('collection-undo')))
          .onPressed,
      isNull,
    );
    expect(
      tester.widget<IconButton>(find.byKey(const ValueKey('collection-redo')))
          .onPressed,
      isNull,
    );
    pending.complete();
    await tester.pumpAndSettle();
    expect(backend.undos, 1);
  });
}

Widget _app(_HistoryBackend backend, _DeckRepository decks) => MaterialApp(
      home: DeckListPage(
        controller: DeckListController(repository: decks),
        pickCollection: () async => '/tmp/a.anki2',
        openCollection: (_) async {},
        backend: backend,
      ),
    );

class _DeckRepository implements DeckRepository {
  int loads = 0;
  @override
  Future<List<DeckNode>> loadDeckTree() async {
    loads++;
    return const [];
  }
}

class _HistoryBackend implements BackendInvoker {
  collection.UndoStatus state = collection.UndoStatus();
  int undos = 0;
  int redos = 0;
  bool fail = false;
  Completer<void>? pendingUndo;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    if (operation == BackendOperation.getUndoStatus) {
      return Uint8List.fromList(state.writeToBuffer());
    }
    if (operation == BackendOperation.undo || operation == BackendOperation.redo) {
      if (operation == BackendOperation.undo) {
        undos++;
        if (pendingUndo case final pending?) await pending.future;
      } else {
        redos++;
      }
      if (fail) throw StateError('native history failed');
      state = operation == BackendOperation.undo
          ? collection.UndoStatus(redo: 'Add note')
          : collection.UndoStatus(undo: 'Add note');
      return Uint8List.fromList(
        collection.OpChangesAfterUndo(newStatus: state).writeToBuffer(),
      );
    }
    throw StateError('Unexpected operation: $operation');
  }
}
