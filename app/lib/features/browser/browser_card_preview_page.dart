import 'dart:async';

import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/surface/card_surface.dart';
import 'package:flutter/material.dart';

/// Read-only card preview using Anki's browser rendering context.
/// No reviewer queue is entered and no scheduling operation is performed.
class BrowserCardPreviewPage extends StatefulWidget {
  const BrowserCardPreviewPage({
    required this.cardId,
    required this.repository,
    this.mediaBaseUri,
    this.surfaceBuilder,
    super.key,
  });

  final int cardId;
  final CardRenderRepository repository;
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

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void didUpdateWidget(covariant BrowserCardPreviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cardId == widget.cardId &&
        oldWidget.repository == widget.repository) {
      return;
    }
    _generation++;
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
      final content = await widget.repository.render(widget.cardId);
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
    return Scaffold(
      appBar: AppBar(title: Text('Preview card ${widget.cardId}')),
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
                  onPressed: _loading
                      ? null
                      : () => setState(() => _showAnswer = !_showAnswer),
                  child: Text(_showAnswer ? 'Show question' : 'Show answer'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
