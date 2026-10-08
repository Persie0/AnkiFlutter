import 'dart:async';

import 'package:anki_flutter/features/card_info/card_info_page.dart';
import 'package:anki_flutter/features/card_info/data/card_info_repository.dart';

import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/surface/card_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Read-only card preview using Anki's browser rendering context.
/// No reviewer queue is entered and no scheduling operation is performed.
class BrowserCardPreviewPage extends StatefulWidget {
  const BrowserCardPreviewPage({
    required this.cardId,
    required this.repository,
    this.orderedCardIds = const [],
    this.cardInfoRepository,
    this.mediaBaseUri,
    this.surfaceBuilder,
    super.key,
  });

  final int cardId;
  final CardRenderRepository repository;

  /// Optional complete browser-search order. Without it preview stays a
  /// single-card view, as before. The active card must be in this list.
  final List<int> orderedCardIds;

  /// Optional card information for any matching card, including unloaded rows.
  final CardInfoRepository? cardInfoRepository;
  final Uri? mediaBaseUri;
  final Widget Function(BuildContext context, String html)? surfaceBuilder;

  @override
  State<BrowserCardPreviewPage> createState() => _BrowserCardPreviewPageState();
}

class _BrowserCardPreviewPageState extends State<BrowserCardPreviewPage> {
  ReviewCardContent? _content;
  Object? _error;
  bool _loading = true;
  bool _showAnswer = false;
  int _generation = 0;
  late List<int> _orderedCardIds;
  late int _position;

  int get _currentCardId => _orderedCardIds[_position];

  void _resetCardOrder() {
    final ids = widget.orderedCardIds;
    // A browser may supply only currently rendered rows, or a stale selection.
    // Never navigate to an unrelated card if the active ID isn't in the list.
    final ordered = ids.contains(widget.cardId)
        ? ids.toSet().toList(growable: false)
        : <int>[widget.cardId];
    _orderedCardIds = List<int>.unmodifiable(ordered);
    _position = _orderedCardIds.indexOf(widget.cardId);
  }

  void _flip() {
    if (_loading || _content == null) return;
    setState(() => _showAnswer = !_showAnswer);
  }

  Future<void> _openCardInfo() async {
    final info = widget.cardInfoRepository;
    if (info == null || _loading) return;
    final cardId = _currentCardId;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => CardInfoPage(
          repository: info,
          cardId: cardId,
          kind: CardInfoKind.browser,
        ),
      ),
    );
  }

  void _navigate(int delta) {
    final next = _position + delta;
    if (next < 0 || next >= _orderedCardIds.length) return;
    setState(() {
      _position = next;
      _content = null;
      _error = null;
      _showAnswer = false;
      _loading = true;
    });
    // The generation guard in _load() makes old render completions harmless.
    unawaited(_load());
  }

  @override
  void initState() {
    super.initState();
    _resetCardOrder();
    unawaited(_load());
  }

  @override
  void didUpdateWidget(covariant BrowserCardPreviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cardId == widget.cardId &&
        oldWidget.repository == widget.repository &&
        oldWidget.orderedCardIds == widget.orderedCardIds) {
      return;
    }
    _generation++;
    _resetCardOrder();
    _content = null;
    _error = null;
    _showAnswer = false;
    unawaited(_load());
  }

  @override
  void dispose() {
    _generation++;
    super.dispose();
  }

  Future<void> _load() async {
    final generation = ++_generation;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final content = await widget.repository.render(_currentCardId);
      if (!mounted || generation != _generation) return;
      setState(() {
        _content = content;
        _loading = false;
      });
    } catch (error) {
      if (!mounted || generation != _generation) return;
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _content;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            _navigate(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            _navigate(1),
        const SingleActivator(LogicalKeyboardKey.space): _flip,
        const SingleActivator(LogicalKeyboardKey.enter): _flip,
        if (widget.cardInfoRepository != null)
          const SingleActivator(LogicalKeyboardKey.keyI): () =>
              unawaited(_openCardInfo()),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
      appBar: AppBar(
        title: Text('Preview card $_currentCardId'),
        actions: [
          if (widget.cardInfoRepository != null)
            IconButton(
              key: const ValueKey('browser-preview-card-info'),
              tooltip: 'Card info',
              onPressed: _loading ? null : () => unawaited(_openCardInfo()),
              icon: const Icon(Icons.info_outline),
            ),
          if (_orderedCardIds.length > 1) ...[
            Center(
              child: Text(
                '${_position + 1} / ${_orderedCardIds.length}',
                key: const ValueKey('browser-preview-position'),
              ),
            ),
            IconButton(
              key: const ValueKey('browser-preview-previous'),
              tooltip: 'Previous card',
              onPressed: _position > 0 ? () => _navigate(-1) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            IconButton(
              key: const ValueKey('browser-preview-next'),
              tooltip: 'Next card',
              onPressed: _position + 1 < _orderedCardIds.length
                  ? () => _navigate(1)
                  : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_loading && content != null) const LinearProgressIndicator(),
            Expanded(
              child: content != null
                  ? CardSurface(
                      content: content,
                      showAnswer: _showAnswer,
                      mediaBaseUri: widget.mediaBaseUri,
                      builder: widget.surfaceBuilder,
                    )
                  : _loading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Could not preview this card'),
                            const SizedBox(height: 8),
                            Text('${_error ?? 'No card returned'}'),
                            const SizedBox(height: 16),
                            OutlinedButton(
                              key: const ValueKey('browser-preview-retry'),
                              onPressed: _load,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  key: const ValueKey('browser-preview-flip'),
                  onPressed: _loading ? null : _flip,
                  child: Text(_showAnswer ? 'Show question' : 'Show answer'),
                ),
              ),
          ],
        ),
      ),
        ),
      ),
    );
  }
}
