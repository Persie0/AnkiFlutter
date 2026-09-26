enum ReviewQuestionAction {
  showAnswer,
  showReminder,
}

enum ReviewAnswerAction {
  buryCard,
  answerAgain,
  answerGood,
  answerHard,
  showReminder,
}

class ReviewDeckSettings {
  const ReviewDeckSettings({
    required this.autoplay,
    required this.showTimer,
    required this.stopTimerOnAnswer,
    required this.answerTimeLimitSeconds,
    required this.secondsToShowQuestion,
    required this.secondsToShowAnswer,
    required this.waitForAudio,
    required this.skipQuestionWhenReplayingAnswer,
    required this.questionAction,
    required this.answerAction,
  });

  final bool autoplay;
  final bool showTimer;
  final bool stopTimerOnAnswer;
  final int answerTimeLimitSeconds;
  final double secondsToShowQuestion;
  final double secondsToShowAnswer;
  final bool waitForAudio;
  final bool skipQuestionWhenReplayingAnswer;
  final ReviewQuestionAction questionAction;
  final ReviewAnswerAction answerAction;
}
