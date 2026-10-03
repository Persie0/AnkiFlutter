class ReviewTypedAnswerPrompt {
  const ReviewTypedAnswerPrompt({
    required this.pattern,
    required this.fieldName,
    required this.expected,
    required this.combining,
    required this.fontName,
    required this.fontSize,
  });

  final String pattern;
  final String fieldName;
  final String expected;
  final bool combining;
  final String fontName;
  final int fontSize;
}
