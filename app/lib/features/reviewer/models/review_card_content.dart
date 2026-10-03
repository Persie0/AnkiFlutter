sealed class ReviewAudioTag {
  const ReviewAudioTag();
}

final class ReviewMediaTag extends ReviewAudioTag {
  const ReviewMediaTag(this.filename);

  final String filename;
}

final class ReviewTtsTag extends ReviewAudioTag {
  ReviewTtsTag({
    required this.text,
    required this.language,
    required List<String> voices,
    required this.speed,
    required List<String> otherArgs,
  })  : voices = List.unmodifiable(voices),
        otherArgs = List.unmodifiable(otherArgs);

  final String text;
  final String language;
  final List<String> voices;
  final double speed;
  final List<String> otherArgs;
}

class ReviewCardContent {
  ReviewCardContent({
    required this.questionHtml,
    required String answerHtml,
    required this.css,
    required List<ReviewAudioTag> questionAudio,
    required List<ReviewAudioTag> answerAudio,
  })  : answerHtml = _normalizeTypedAnswerSeparator(answerHtml),
        questionAudio = List.unmodifiable(questionAudio),
        answerAudio = List.unmodifiable(answerAudio);

  final String questionHtml;
  final String answerHtml;
  final String css;
  final List<ReviewAudioTag> questionAudio;
  final List<ReviewAudioTag> answerAudio;
}

String _normalizeTypedAnswerSeparator(String html) {
  const separator = '<hr id=answer>';
  const comparisonWrapper = '<div style="font-family: \' ';
  const typedAnswerCode = '<code id=typeans>';

  final separatorIndex = html.indexOf(separator);
  final typedAnswerIndex = html.indexOf(typedAnswerCode);
  if (separatorIndex < 0 ||
      typedAnswerIndex < 0 ||
      separatorIndex < typedAnswerIndex) {
    return html;
  }

  var comparisonIndex = html.lastIndexOf(comparisonWrapper, typedAnswerIndex);
  if (comparisonIndex < 0) {
    comparisonIndex = typedAnswerIndex;
  }

  final withoutSeparator = html.replaceRange(
    separatorIndex,
    separatorIndex + separator.length,
    '',
  );
  return withoutSeparator.replaceRange(
    comparisonIndex,
    comparisonIndex,
    separator,
  );
}
