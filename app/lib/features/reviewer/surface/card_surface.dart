import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardSurface extends StatelessWidget {
  const CardSurface({
    required this.content,
    required this.showAnswer,
    this.builder,
    super.key,
  });

  final ReviewCardContent content;
  final bool showAnswer;
  final Widget Function(BuildContext context, String html)? builder;

  @override
  Widget build(BuildContext context) {
    final html =
        '''<!doctype html><html><head><meta name="viewport" content="width=device-width, initial-scale=1"><style>body{font-family:-apple-system,BlinkMacSystemFont,sans-serif;margin:24px;font-size:20px;}img{max-width:100%;height:auto;} .card{max-width:900px;margin:auto;}</style><style>${content.css}</style></head><body><div class="card">${content.questionHtml}${showAnswer ? '<hr>${content.answerHtml}' : ''}</div></body></html>''';
    final customBuilder = builder;
    if (customBuilder != null) return customBuilder(context, html);
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html);
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: WebViewWidget(controller: controller),
    );
  }
}
