import 'package:anki_flutter/features/reviewer/models/review_typed_answer_prompt.dart';

sealed class ReviewTypedAnswerPreparation {
  const ReviewTypedAnswerPreparation();
}

final class ReviewTypedAnswerReady extends ReviewTypedAnswerPreparation {
  const ReviewTypedAnswerReady(this.prompt);

  final ReviewTypedAnswerPrompt prompt;
}

final class ReviewTypedAnswerEmpty extends ReviewTypedAnswerPreparation {
  const ReviewTypedAnswerEmpty();
}

final class ReviewTypedAnswerWarning extends ReviewTypedAnswerPreparation {
  const ReviewTypedAnswerWarning(this.message);

  final String message;
}
