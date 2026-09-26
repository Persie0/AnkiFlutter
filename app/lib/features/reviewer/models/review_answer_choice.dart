import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/models/review_rating.dart';

class ReviewAnswerChoice {
  ReviewAnswerChoice({
    required this.rating,
    required this.intervalLabel,
    required Uint8List schedulingStateBytes,
  }) : _schedulingStateBytes = Uint8List.fromList(schedulingStateBytes);

  final ReviewRating rating;
  final String intervalLabel;
  final Uint8List _schedulingStateBytes;

  Uint8List get schedulingStateBytes => Uint8List.fromList(_schedulingStateBytes);
}
