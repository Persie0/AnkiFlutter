import 'dart:async';

import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_cef/webview_cef.dart' as cef;
import 'package:webview_flutter/webview_flutter.dart' as mobile;

class CardSurface extends StatefulWidget {
  const CardSurface({
    required this.content,
    required this.showAnswer,
    this.mediaBaseUri,
    this.builder,
    super.key,
  });

  final ReviewCardContent content;
  final bool showAnswer;
  final Uri? mediaBaseUri;
  final Widget Function(BuildContext context, String html)? builder;

  @override
  State<CardSurface> createState() => _CardSurfaceState();
}

class _CardSurfaceState extends State<CardSurface> {
  static Future<void>? _cefInitialization;

  mobile.WebViewController? _mobileController;
  cef.WebViewController? _cefController;
  Object? _error;

  bool get _usesDesktopCef => switch (defaultTargetPlatform) {
    TargetPlatform.windows ||
    TargetPlatform.macOS ||
    TargetPlatform.linux => true,
    _ => false,
  };

  @override
  void initState() {
    super.initState();
    if (widget.builder != null) return;
    if (_usesDesktopCef) {
      unawaited(_initializeCef());
    } else {
      _initializeMobile();
    }
  }

  @override
  void didUpdateWidget(covariant CardSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content ||
        oldWidget.showAnswer != widget.showAnswer ||
        oldWidget.mediaBaseUri != widget.mediaBaseUri) {
      unawaited(_loadCurrentHtml());
    }
  }

  void _initializeMobile() {
    final html = _html();
    _mobileController = mobile.WebViewController()
      ..setJavaScriptMode(mobile.JavaScriptMode.unrestricted)
      ..loadHtmlString(html, baseUrl: widget.mediaBaseUri?.toString());
  }

  Future<void> _initializeCef() async {
    try {
      _cefInitialization ??= cef.WebviewManager().initialize();
      await _cefInitialization;
      if (!mounted) return;
      final controller = cef.WebviewManager().createWebView(
        loading: const Center(child: CircularProgressIndicator()),
      );
      await controller.initialize('about:blank');
      if (!mounted) {
        controller.dispose();
        return;
      }
      _cefController = controller;
      await _loadCurrentHtml();
      if (mounted) setState(() {});
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  Future<void> _loadCurrentHtml() async {
    final html = _html();
    final mobileController = _mobileController;
    if (mobileController != null) {
      await mobileController.loadHtmlString(
        html,
        baseUrl: widget.mediaBaseUri?.toString(),
      );
      return;
    }

    final cefController = _cefController;
    if (cefController != null) {
      final dataUri = Uri.dataFromString(html, mimeType: 'text/html');
      await cefController.loadUrl(dataUri.toString());
    }
  }

  String _html() {
    final base = widget.mediaBaseUri == null
        ? ''
        : '<base href="${_escapeAttribute(widget.mediaBaseUri.toString())}">';
    return '''<!doctype html><html><head><meta name="viewport" content="width=device-width, initial-scale=1">$base<style>body{font-family:-apple-system,BlinkMacSystemFont,sans-serif;margin:24px;font-size:20px;}img{max-width:100%;height:auto;} .card{max-width:900px;margin:auto;}</style><style>${widget.content.css}</style></head><body><div class="card">${widget.content.questionHtml}${widget.showAnswer ? '<hr>${widget.content.answerHtml}' : ''}</div></body></html>''';
  }

  String _escapeAttribute(String value) => value
      .replaceAll('&', '&amp;')
      .replaceAll('"', '&quot;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');

  @override
  void dispose() {
    _mobileController = null;
    _cefController?.dispose();
    _cefController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final html = _html();
    final customBuilder = widget.builder;
    if (customBuilder != null) return customBuilder(context, html);
    if (_error case final error?) {
      return Center(child: Text('Card renderer unavailable: $error'));
    }
    if (_usesDesktopCef) {
      final controller = _cefController;
      if (controller == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return ValueListenableBuilder<bool>(
        valueListenable: controller,
        builder: (context, ready, _) =>
            ready ? controller.webviewWidget : controller.loadingWidget,
      );
    }
    final controller = _mobileController;
    if (controller == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: mobile.WebViewWidget(controller: controller),
    );
  }
}
