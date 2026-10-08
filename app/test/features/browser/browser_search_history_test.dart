import 'package:anki_flutter/features/browser/browser_search_history.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('history avoids adjacent duplicates and respects both boundaries', () {
    final history = BrowserSearchHistory();
    expect(history.back(), isNull);
    expect(history.forward(), isNull);
    history.record('');
    history.record('');
    history.record('is:due');
    history.record('is:new');
    expect(history.queries, ['', 'is:due', 'is:new']);

    expect(history.forward(), isNull);
    expect(history.back(), 'is:due');
    expect(history.back(), '');
    expect(history.back(), isNull);
    expect(history.forward(), 'is:due');
    expect(history.forward(), 'is:new');
    expect(history.forward(), isNull);
  });

  test('new submitted query after back truncates forward history', () {
    final history = BrowserSearchHistory();
    for (final query in ['A', 'B', 'C']) {
      history.record(query);
    }
    expect(history.back(), 'B');
    history.record('D');

    expect(history.queries, ['A', 'B', 'D']);
    expect(history.current, 'D');
    expect(history.canGoForward, isFalse);
    expect(history.back(), 'B');
    history.record('B');
    expect(history.queries, ['A', 'B', 'D']);
    expect(history.forward(), 'D');
  });

  test('bounded history evicts oldest entry and retains valid index', () {
    final history = BrowserSearchHistory(capacity: 3);
    for (final query in ['1', '2', '3', '4']) {
      history.record(query);
    }
    expect(history.queries, ['2', '3', '4']);
    expect(history.back(), '3');
    expect(history.back(), '2');
    expect(history.back(), isNull);
    expect(history.forward(), '3');
    history.record('5');
    expect(history.queries, ['2', '3', '5']);
  });
}
