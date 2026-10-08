import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/cards.pb.dart' as cards;
import 'package:anki_flutter/core/backend/generated/anki/collection.pb.dart'
    as collection;
import 'package:anki_flutter/core/backend/generated/anki/search.pb.dart' as search;
import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const options = CardBrowserFindReplaceOptions(
    search: 'colour',
    replacement: 'color',
    regex: true,
    matchCase: false,
    fieldName: 'Front',
  );

  test('deduplicates selected sibling-card note IDs before native replace',
      () async {
    final backend = _Backend();
    final count = await AnkiCardBrowserRepository(backend: backend)
        .findAndReplaceSelected([11, 12, 11, 13], options);

    expect(count, 2);
    expect(backend.calls.map((call) => call.operation), [
      BackendOperation.getCard,
      BackendOperation.getCard,
      BackendOperation.getCard,
      BackendOperation.findAndReplace,
    ]);
    final request = search.FindAndReplaceRequest.fromBuffer(
      backend.calls.last.payload,
    );
    expect(request.nids, [Int64(42), Int64(43)]);
    expect(request.search, 'colour');
    expect(request.replacement, 'color');
    expect(request.regex, isTrue);
    expect(request.matchCase, isFalse);
    expect(request.fieldName, 'Front');
  });

  test('empty replacement and blank field name remain valid', () async {
    final backend = _Backend();
    await AnkiCardBrowserRepository(backend: backend).findAndReplaceSelected(
      [11],
      const CardBrowserFindReplaceOptions(
        search: 'remove',
        replacement: '',
        regex: false,
        matchCase: true,
        fieldName: ' ',
      ),
    );
    final request = search.FindAndReplaceRequest.fromBuffer(
      backend.calls.last.payload,
    );
    expect(request.replacement, isEmpty);
    expect(request.fieldName, isEmpty);
    expect(request.matchCase, isTrue);
  });

  test('rejects empty search and invalid card IDs before making changes',
      () async {
    final backend = _Backend();
    final repo = AnkiCardBrowserRepository(backend: backend);
    await expectLater(repo.findAndReplaceSelected([], options), throwsArgumentError);
    await expectLater(repo.findAndReplaceSelected([0], options), throwsArgumentError);
    await expectLater(
      repo.findAndReplaceSelected(
        [11],
        const CardBrowserFindReplaceOptions(
          search: '   ',
          replacement: '',
          regex: false,
          matchCase: false,
          fieldName: '',
        ),
      ),
      throwsArgumentError,
    );
    expect(backend.calls, isEmpty);
  });

  test('failed note resolution does not perform any partial replacement',
      () async {
    final backend = _Backend()..failLookupFor = 13;
    await expectLater(
      AnkiCardBrowserRepository(backend: backend)
          .findAndReplaceSelected([11, 13], options),
      throwsStateError,
    );
    expect(backend.calls.any((call) =>
        call.operation == BackendOperation.findAndReplace), isFalse);
  });

  test('upstream regex errors propagate so the selection can be retried',
      () async {
    final backend = _Backend()..failReplace = true;
    await expectLater(
      AnkiCardBrowserRepository(backend: backend)
          .findAndReplaceSelected([11], options),
      throwsStateError,
    );
    expect(backend.calls.last.operation, BackendOperation.findAndReplace);
  });
}

class _Call {
  const _Call(this.operation, this.payload);
  final BackendOperation operation;
  final Uint8List payload;
}

class _Backend implements BackendInvoker {
  final calls = <_Call>[];
  int? failLookupFor;
  bool failReplace = false;

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_Call(operation, request));
    if (operation == BackendOperation.getCard) {
      final id = cards.CardId.fromBuffer(request).cid.toInt();
      if (failLookupFor == id) throw StateError('card unavailable');
      return Uint8List.fromList(
        cards.Card(noteId: Int64(id == 13 ? 43 : 42)).writeToBuffer(),
      );
    }
    if (operation == BackendOperation.findAndReplace) {
      if (failReplace) throw StateError('invalid Anki replacement regex');
      return Uint8List.fromList(
        collection.OpChangesWithCount(count: 2).writeToBuffer(),
      );
    }
    throw StateError('Unexpected backend operation $operation');
  }
}
