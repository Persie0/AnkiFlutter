DateTime cardInfoLocalDateTime(int unixSeconds) =>
    DateTime.fromMillisecondsSinceEpoch(
      unixSeconds * Duration.millisecondsPerSecond,
      isUtc: true,
    ).toLocal();

String formatCardInfoTimestamp(int unixSeconds) {
  final value = cardInfoLocalDateTime(unixSeconds);
  return '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')} '
      '${value.hour.toString().padLeft(2, '0')}:'
      '${value.minute.toString().padLeft(2, '0')}';
}

String formatCardInfoDuration(double seconds) {
  if (seconds <= 0) return '0s';
  if (seconds < 60) {
    final rounded = seconds.roundToDouble();
    return rounded == seconds
        ? '${rounded.toInt()}s'
        : '${seconds.toStringAsFixed(1)}s';
  }
  return _formatWholeSeconds(seconds.round(), includeDays: false);
}

String formatCardInfoIntervalDays(int days) => days == 1 ? '1 day' : '$days days';

String formatCardInfoHistoryIntervalSeconds(int seconds) =>
    _formatWholeSeconds(seconds, includeDays: true);

String formatCardInfoEase(int permille) {
  final percent = permille / 10;
  return percent == percent.roundToDouble()
      ? '${percent.toInt()}%'
      : '${percent.toStringAsFixed(1)}%';
}

String formatCardInfoReviewKind(int value) => switch (value) {
  0 => 'Learning',
  1 => 'Review',
  2 => 'Relearning',
  3 => 'Filtered',
  4 => 'Manual',
  5 => 'Rescheduled',
  _ => 'Unknown ($value)',
};

String _formatWholeSeconds(int seconds, {required bool includeDays}) {
  if (seconds <= 0) return '0s';

  var remaining = seconds;
  final parts = <String>[];
  if (includeDays && remaining >= Duration.secondsPerDay) {
    final days = remaining ~/ Duration.secondsPerDay;
    remaining %= Duration.secondsPerDay;
    parts.add('${days}d');
  }
  if (remaining >= Duration.secondsPerHour) {
    final hours = remaining ~/ Duration.secondsPerHour;
    remaining %= Duration.secondsPerHour;
    parts.add('${hours}h');
  }
  if (remaining >= Duration.secondsPerMinute) {
    final minutes = remaining ~/ Duration.secondsPerMinute;
    remaining %= Duration.secondsPerMinute;
    parts.add('${minutes}m');
  }
  if (remaining > 0 || parts.isEmpty) parts.add('${remaining}s');
  return parts.join(' ');
}
