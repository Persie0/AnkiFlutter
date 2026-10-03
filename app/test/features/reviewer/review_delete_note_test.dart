import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/review_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_answer_choice.dart';
import 'package:anki_flutter/features/reviewer/models/review_card.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:anki_flutter/features/reviewer/models/review_counts.dart';
import 'package:anki_flutter/features/reviewer/models/review_deck_settings.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deleting current note advances to the next scheduler card', () async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);

    await controller.deleteCurrentNote();

    expect(repository.deletedNoteIds, [101]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('failed delete preserves current card and can be retried', () async {
    final repository = _Repository()..deleteError = StateError('delete failed');
    final controller = _controller(repository);
    await controller.start(7);

    await expectLater(controller.deleteCurrentNote(), throwsStateError);
    expect((controller.state as ReviewQuestion).card.cardId, 1);

    repository.deleteError = null;
    await controller.deleteCurrentNote();
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  test('stale delete completion cannot advance a newer review session', () async {
    final completer = Completer<void>();
    final repository = _Repository()..deleteCompleter = completer;
    final controller = _controller(repository);
    await controller.start(7);

    final deleting = controller.deleteCurrentNote();
    await Future<void>.delayed(Duration.zero);
    await controller.start(8);
    expect((controller.state as ReviewQuestion).card.cardId, 2);

    completer.complete();
    await deleting;

    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  testWidgets('review action menu exposes Delete note and delegates it', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller));

    expect(controller.supportsDeleteNote, isTrue);
    await tester.tap(find.byTooltip('Review actions'));
    await tester.pumpAndSettle();
    expect(find.text('Delete note'), findsOneWidget);

    await tester.tap(find.text('Delete note'));
    await tester.pumpAndSettle();

    expect(repository.deletedNoteIds, [101]);
    expect((controller.state as ReviewQuestion).card.cardId, 2);
  });

  testWidgets('Ctrl+Delete deletes current note on Windows/Linux', (
    tester,
  ) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller, platform: TargetPlatform.linux));
    await tester.pumpAndSettle();

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.delete);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();

    expect(repository.deletedNoteIds, [101]);
  });

  testWidgets('Ctrl+Backspace deletes current note on macOS', (tester) async {
    final repository = _Repository();
    final controller = _controller(repository);
    await controller.start(7);
    await tester.pumpWidget(_app(controller, platform: TargetPlatform.macOS));
    await tester.pumpAndSettle();

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpAndSettle();

    expect(repository.deletedNoteIds, [101]);
  });
}

Widget _app(
  ReviewController controller, {
  TargetPlatform platform = TargetPlatform.linux,
}) => MaterialApp(
  theme: ThemeData(platform: platform),
  home: ReviewPage(
    controller: controller,
    onFinished: () {},
    cardSurfaceBuilder: (_, _) => const Text('Card'),
  ),
);

ReviewController _controller(_Repository repository) => ReviewController(
  repository: repository,
  renderer: _Renderer(),
  wallClockMillis: () => 100,
  stopwatchFactory: Stopwatch.new,
);

ReviewCard _card(int id) => ReviewCard(
  cardId: id,
  noteId: id + 100,
  deckId: 7,
  deckName: 'Deck',
  counts: const ReviewCounts(newCount: 1, learningCount: 0, reviewCount: 0),
  currentStateBytes: Uint8List(0),
  choices: [
    for (final rating in ReviewRating.values)
      ReviewAnswerChoice(
        rating: rating,
        intervalLabel: '1d',
        schedulingStateBytes: Uint8List(0),
      ),
  ],
);

class _Renderer implements CardRenderRepository {
  @override
  Future<ReviewCardContent> render(int cardId) async => ReviewCardContent(
    questionHtml: 'Question',
    answerHtml: 'Answer',
    css: '',
    questionAudio: const [],
    answerAudio: const [],
  );
}

class _Repository implements ReviewRepository, ReviewDeleteNoteRepository {
  final cards = <ReviewCard>[_card(1), _card(2), _card(3)];
  int nextIndex = 0;
  final deletedNoteIds = <int>[];
  Object? deleteError;
  Completer<void>? deleteCompleter;

  @override
  Future<void> selectDeck(int deckId) async {}

  @override
  Future<ReviewCard?> nextCard() async {
    if (nextIndex >= cards.length) return null;
    return cards[nextIndex++];
  }

  @override
  Future<void> deleteNote(ReviewCard card) async {
    deletedNoteIds.add(card.noteId);
    final pending = deleteCompleter;
    if (pending != null) await pending.future;
    final error = deleteError;
    if (error != null) throw error;
  }

  @override
  Future<ReviewDeckSettings> settingsForDeck(int deckId) async =>
      const ReviewDeckSettings(
        autoplay: false,
        showTimer: false,
        stopTimerOnAnswer: false,
        answerTimeLimitSeconds: 0,
        secondsToShowQuestion: 0,
        secondsToShowAnswer: 0,
        waitForAudio: false,
        skipQuestionWhenReplayingAnswer: false,
        questionAction: ReviewQuestionAction.showAnswer,
        answerAction: ReviewAnswerAction.answerGood,
      );

  @override
  Future<void> answer(
    ReviewCard card,
    ReviewRating rating, {
    required int answeredAtMillis,
    required int millisecondsTaken,
  }) async {}

  @override
  Future<bool> stateIsLeech(ReviewAnswerChoice choice) async => false;

  @override
  Future<bool> canUndo() async => false;

  @override
  Future<void> undo() async {}

  @override
  Future<void> buryCard(ReviewCard card) async {}

  @override
  Future<void> buryNote(ReviewCard card) async {}

  @override
  Future<void> suspendCard(ReviewCard card) async {}

  @override
  Future<void> suspendNote(ReviewCard card) async {}
}
