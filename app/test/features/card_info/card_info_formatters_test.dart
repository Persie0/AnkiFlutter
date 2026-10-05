import 'package:anki_flutter/features/card_info/card_info_formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('converts backend Unix seconds through local time', () {
    const seconds = 1_700_000_000;
    expect(
      cardInfoLocalDateTime(seconds),
      DateTime.fromMillisecondsSinceEpoch(
        seconds * Duration.millisecondsPerSecond,
        isUtc: true,
      ).toLocal(),
    );
  });

  test('formats timestamps from the local DateTime', () {
    const seconds = 1_700_000_000;
    final local = cardInfoLocalDateTime(seconds);
    final expected =
        '${local.year.toString().padLeft(4, '0')}-'
        '${local.month.toString().padLeft(2, '0')}-'
        '${local.day.toString().padLeft(2, '0')} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';

    expect(formatCardInfoTimestamp(seconds), expected);
  });

  test('formats durations without changing their meaning', () {
    expect(formatCardInfoDuration(0), '0s');
    expect(formatCardInfoDuration(4.5), '4.5s');
    expect(formatCardInfoDuration(65), '1m 5s');
    expect(formatCardInfoDuration(3_661), '1h 1m 1s');
  });

  test('keeps card intervals in days and revlog intervals in seconds', () {
    expect(formatCardInfoIntervalDays(1), '1 day');
    expect(formatCardInfoIntervalDays(30), '30 days');
    expect(formatCardInfoHistoryIntervalSeconds(90), '1m 30s');
    expect(formatCardInfoHistoryIntervalSeconds(172_800), '2d');
  });

  test('formats per-mill ease as a percentage', () {
    expect(formatCardInfoEase(2500), '250%');
    expect(formatCardInfoEase(0), '0%');
  });

  test('maps pinned review kinds and safely falls back for unknown values', () {
    expect(formatCardInfoReviewKind(0), 'Learning');
    expect(formatCardInfoReviewKind(1), 'Review');
    expect(formatCardInfoReviewKind(2), 'Relearning');
    expect(formatCardInfoReviewKind(3), 'Filtered');
    expect(formatCardInfoReviewKind(4), 'Manual');
    expect(formatCardInfoReviewKind(5), 'Rescheduled');
    expect(formatCardInfoReviewKind(99), 'Unknown (99)');
  });
}
