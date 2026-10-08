/// Navigation history for submitted browser queries only.
///
/// This is intentionally session-scoped. Saved searches are stored separately
/// in the browser's preferences file, and sort or data refreshes must not add
/// additional history entries.
class BrowserSearchHistory {
  BrowserSearchHistory({this.capacity = 30})
    : assert(capacity > 0, 'History capacity must be positive');

  final int capacity;
  final List<String> _queries = [];
  int _index = -1;

  bool get canGoBack => _index > 0;
  bool get canGoForward => _index >= 0 && _index < _queries.length - 1;
  String? get current => _index < 0 ? null : _queries[_index];

  /// Snapshot for debugging and pure unit tests.
  List<String> get queries => List.unmodifiable(_queries);

  void record(String query) {
    if (current == query) return;
    if (canGoForward) {
      _queries.removeRange(_index + 1, _queries.length);
    }
    _queries.add(query);
    if (_queries.length > capacity) {
      _queries.removeAt(0);
    }
    _index = _queries.length - 1;
  }

  String? back() {
    if (!canGoBack) return null;
    return _queries[--_index];
  }

  String? forward() {
    if (!canGoForward) return null;
    return _queries[++_index];
  }
}
