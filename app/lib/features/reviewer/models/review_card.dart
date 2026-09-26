import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';

class ReviewCard {
  ReviewCard({
    required this.cardId,
    required this.noteId,
    required this.deckId,
    required this.counts,
    required Uint8List currentStateBytes,
    required List<ReviewAnswerChoice> choices,
    required this.deckName,
  })  : _currentStateBytes = Uint8List.fromList(currentStateBytes),
        choices = List.unmodifiable(choices);

  final int cardId;
  final int noteId;
  final int deckId;
  final ReviewCounts counts;
  final Uint8List _currentStateBytes;
  final List<ReviewAnswerChoice> choices;
  final String deckName;

  Uint8List get currentStateBytes => Uint8List.fromList(_currentStateBytes);
}
