import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart'
    as stats;
import 'package:flutter/material.dart';

/// Additional Anki-native statistics. All counts come directly from the
/// pinned Anki backend; Flutter only formats and displays the distributions.
class StatisticsExtraGraphs extends StatelessWidget {
  const StatisticsExtraGraphs({
    required this.graphs,
    required this.days,
    super.key,
  });

  final stats.GraphsResponse graphs;
  final int days;

  @override
  Widget build(BuildContext context) {
    final sections = <Widget>[];

    if (graphs.hasAdded() && graphs.added.added.isNotEmpty) {
      sections.add(_CountsGraph(
        key: const ValueKey('stats-added'),
        title: 'Cards added',
        description: 'Cards added by relative day',
        counts: graphs.added.added,
        labelForKey: _relativeDay,
        recentFirst: true,
      ));
    }

    if (graphs.hasReviews() && graphs.reviews.count.isNotEmpty) {
      sections.add(_CountsGraph(
        key: const ValueKey('stats-review-history'),
        title: 'Review history',
        description: 'Answers by relative day (all review types)',
        counts: graphs.reviews.count.map(
          (day, kinds) => MapEntry(
            day,
            kinds.learn + kinds.relearn + kinds.young +
                kinds.mature + kinds.filtered,
          ),
        ),
        labelForKey: _relativeDay,
        recentFirst: true,
      ));
    }

    if (graphs.hasHours()) {
      final byHour = _hoursForDays(graphs.hours, days);
      if (byHour.any((hour) => hour.total > 0)) {
        sections.add(_CountsGraph(
          key: const ValueKey('stats-study-hours'),
          title: 'Study hours',
          description: 'Answers recorded by hour of day',
          counts: {
            for (var hour = 0; hour < byHour.length && hour < 24; hour++)
              hour: byHour[hour].total,
          },
          labelForKey: (hour) =>
              '${hour.toString().padLeft(2, '0')}:00',
          maxVisible: 24,
          showAll: true,
        ));
      }
    }

    if (graphs.hasButtons()) {
      final buttons = _buttonsForDays(graphs.buttons, days);
      if (buttons != null) {
        // The native response separates learning, young and mature cards;
        // combine the four answer buttons without reimplementing scheduling.
        final counts = <int, int>{};
        for (final group in [buttons.learning, buttons.young, buttons.mature]) {
          for (var i = 0; i < group.length && i < 4; i++) {
            counts.update(i + 1, (value) => value + group[i],
                ifAbsent: () => group[i]);
          }
        }
        if (counts.values.any((count) => count > 0)) {
          sections.add(_CountsGraph(
            key: const ValueKey('stats-answer-buttons'),
            title: 'Answer buttons',
            description: 'Times each rating was chosen',
            counts: counts,
            labelForKey: (rating) => switch (rating) {
              1 => 'Again',
              2 => 'Hard',
              3 => 'Good',
              4 => 'Easy',
              _ => '$rating',
            },
            showAll: true,
          ));
        }
      }
    }

    if (graphs.hasIntervals() && graphs.intervals.intervals.isNotEmpty) {
      sections.add(_CountsGraph(
        key: const ValueKey('stats-intervals'),
        title: 'Card intervals',
        description: 'Native interval buckets (days)',
        counts: graphs.intervals.intervals,
        labelForKey: (bucket) => '${bucket}d',
      ));
    }

    if (graphs.hasFsrs() && graphs.fsrs) {
      if (graphs.hasDifficulty() && graphs.difficulty.eases.isNotEmpty) {
        sections.add(_CountsGraph(
          key: const ValueKey('stats-fsrs-difficulty'),
          title: 'FSRS difficulty',
          description: 'Native difficulty buckets',
          counts: graphs.difficulty.eases,
          labelForKey: (bucket) => '$bucket',
        ));
      }
      if (graphs.hasStability() && graphs.stability.intervals.isNotEmpty) {
        sections.add(_CountsGraph(
          key: const ValueKey('stats-fsrs-stability'),
          title: 'FSRS stability',
          description: 'Native stability buckets (days)',
          counts: graphs.stability.intervals,
          labelForKey: (bucket) => '${bucket}d',
        ));
      }
      if (graphs.hasRetrievability() &&
          graphs.retrievability.retrievability.isNotEmpty) {
        sections.add(_CountsGraph(
          key: const ValueKey('stats-fsrs-retrievability'),
          title: 'FSRS retrievability',
          description: 'Native retrievability buckets',
          counts: graphs.retrievability.retrievability,
          labelForKey: (bucket) => '$bucket',
        ));
      }
    }

    if (sections.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final section in sections) ...[
          const SizedBox(height: 24),
          section,
        ],
      ],
    );
  }

  static String _relativeDay(int day) => switch (day) {
    0 => 'Today',
    -1 => 'Yesterday',
    < 0 => '${-day}d ago',
    _ => '+${day}d',
  };

  static List<stats.GraphsResponse_Hours_Hour> _hoursForDays(
    stats.GraphsResponse_Hours hours,
    int days,
  ) => switch (days) {
    30 => hours.oneMonth,
    90 => hours.threeMonths,
    365 => hours.oneYear,
    _ => hours.allTime,
  };

  static stats.GraphsResponse_Buttons_ButtonCounts? _buttonsForDays(
    stats.GraphsResponse_Buttons buttons,
    int days,
  ) => switch (days) {
    30 => buttons.hasOneMonth() ? buttons.oneMonth : null,
    90 => buttons.hasThreeMonths() ? buttons.threeMonths : null,
    365 => buttons.hasOneYear() ? buttons.oneYear : null,
    _ => buttons.hasAllTime() ? buttons.allTime : null,
  };
}

class _CountsGraph extends StatefulWidget {
  const _CountsGraph({
    super.key,
    required this.title,
    required this.description,
    required this.counts,
    required this.labelForKey,
    this.recentFirst = false,
    this.maxVisible = 14,
    this.showAll = false,
  });

  final String title;
  final String description;
  final Map<int, int> counts;
  final String Function(int) labelForKey;
  final bool recentFirst;
  final int maxVisible;
  final bool showAll;

  @override
  State<_CountsGraph> createState() => _CountsGraphState();
}

class _CountsGraphState extends State<_CountsGraph> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final entries = widget.counts.entries
        .where((entry) => entry.value > 0)
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    if (entries.isEmpty) return const SizedBox.shrink();

    final tooMany = !widget.showAll && entries.length > widget.maxVisible;
    final visible = tooMany && !_expanded
        ? (widget.recentFirst
              ? entries.skip(entries.length - widget.maxVisible).toList()
              : entries.take(widget.maxVisible).toList())
        : entries;
    final maxCount = entries
        .map((entry) => entry.value)
        .reduce((a, b) => a > b ? a : b);
    final total = entries.fold<int>(0, (sum, entry) => sum + entry.value);
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(widget.description,
                style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Text('$total total',
                style: theme.textTheme.labelMedium),
            const SizedBox(height: 12),
            for (final entry in visible)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Semantics(
                  label:
                      '${widget.labelForKey(entry.key)}: ${entry.value} answers or cards',
                  child: Row(
                    children: [
                      SizedBox(
                        width: 88,
                        child: Text(
                          widget.labelForKey(entry.key),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: entry.value / maxCount,
                          minHeight: 12,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 48,
                        child: Text(
                          '${entry.value}',
                          textAlign: TextAlign.end,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (tooMany)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  key: ValueKey('stats-show-more-${widget.title}'),
                  onPressed: () => setState(() => _expanded = !_expanded),
                  child: Text(_expanded
                      ? 'Show fewer'
                      : 'Show all ${entries.length} buckets'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
