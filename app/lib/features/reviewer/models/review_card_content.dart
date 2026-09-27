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
    required this.answerHtml,
    required this.css,
    required List<ReviewAudioTag> questionAudio,
    required List<ReviewAudioTag> answerAudio,
  })  : questionAudio = List.unmodifiable(questionAudio),
        answerAudio = List.unmodifiable(answerAudio);

  final String questionHtml;
  final String answerHtml;
  final String css;
  final List<ReviewAudioTag> questionAudio;
  final List<ReviewAudioTag> answerAudio;
}
