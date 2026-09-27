import 'dart:async';

import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:anki_flutter/features/reviewer/models/review_rating.dart';
import 'package:anki_flutter/features/reviewer/models/review_session_state.dart';
import 'package:anki_flutter/features/reviewer/surface/card_surface.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    required this.controller,
    required this.onFinished,
    this.cardSurfaceBuilder,
    this.mediaBaseUri,
    super.key,
  });

  final ReviewController controller;
  final VoidCallback onFinished;
  final Widget Function(BuildContext context, String html)? cardSurfaceBuilder;
  final Uri? mediaBaseUri;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool _finishedNotified = false;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (context, _) {
      final state = widget.controller.state;
      if (state is ReviewFinished) {
        if (!_finishedNotified) {
          _finishedNotified = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) widget.onFinished();
          });
        }
        return const Scaffold(
          body: Center(child: Text('You have finished this deck for now.')),
        );
      }
      if (state is ReviewLoading || state is ReviewInitial) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (state case ReviewFailure(:final error)) {
        return Scaffold(
          appBar: AppBar(title: const Text('Reviewer')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Could not load card: $error'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => unawaited(widget.controller.retry()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }
      if (state is ReviewQuestion ||
          state is ReviewAnswer ||
          state is ReviewTransition) {
        final isAnswer = state is ReviewAnswer || state is ReviewTransition;
        final card = switch (state) {
          ReviewQuestion(:final card) => card,
          ReviewAnswer(:final card) => card,
          ReviewTransition(:final card) => card,
          _ => throw StateError('Unexpected reviewer state'),
        };
        final content = switch (state) {
          ReviewQuestion(:final content) => content,
          ReviewAnswer(:final content) => content,
          ReviewTransition(:final content) => content,
          _ => throw StateError('Unexpected reviewer state'),
        };
        final error = state is ReviewAnswer ? state.error : null;
        return Scaffold(
          appBar: AppBar(
            title: Text(card.deckName),
            actions: [
              Center(
                child: Text(
                  'New ${card.counts.newCount}  Learn ${card.counts.learningCount}  Review ${card.counts.reviewCount}',
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CardSurface(
                    content: content,
                    showAnswer: isAnswer,
                    mediaBaseUri: widget.mediaBaseUri,
                    builder: widget.cardSurfaceBuilder,
                  ),
                ),
                if (error != null) Text('Could not answer card: $error'),
                if (!isAnswer)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(
                      onPressed: () =>
                          unawaited(widget.controller.showAnswer()),
                      child: const Text('Show Answer'),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      children: [
                        for (final rating in ReviewRating.values)
                          FilledButton.tonal(
                            onPressed: state is ReviewTransition
                                ? null
                                : () =>
                                      unawaited(widget.controller.rate(rating)),
                            child: Text(
                              _label(
                                rating,
                                card.choices
                                    .firstWhere(
                                      (choice) => choice.rating == rating,
                                    )
                                    .intervalLabel,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      }
      return const Scaffold(body: Center(child: Text('Reviewer unavailable')));
    },
  );

  String _label(ReviewRating rating, String interval) =>
      '${switch (rating) {
        ReviewRating.again => 'Again',
        ReviewRating.hard => 'Hard',
        ReviewRating.good => 'Good',
        ReviewRating.easy => 'Easy',
      }}\n$interval';
}
