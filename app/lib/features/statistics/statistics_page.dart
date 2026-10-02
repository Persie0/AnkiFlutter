import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/stats.pb.dart' as stats;
import 'package:anki_flutter/features/statistics/data/anki_statistics_repository.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({
    required this.repository,
    this.search = '',
    super.key,
  });

  final StatisticsRepository repository;
  final String search;

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  static const _ranges = <({int days, String label})>[
    (days: 30, label: '1 month'),
    (days: 90, label: '3 months'),
    (days: 365, label: '1 year'),
    (days: 0, label: 'All'),
  ];

  int _days = 30;
  bool _loading = true;
  stats.GraphsResponse? _graphs;
  Object? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final graphs = await widget.repository.graphs(
        search: widget.search,
        days: _days,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _graphs = graphs;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  Future<void> _selectRange(int days) async {
    if (days == _days || _loading) {
      return;
    }
    setState(() => _days = days);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          IconButton(
            tooltip: 'Refresh statistics',
            onPressed: _loading ? null : _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _RangeSelector(
              selectedDays: _days,
              enabled: !_loading,
              ranges: _ranges,
              onSelected: _selectRange,
            ),
            const Divider(height: 1),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    final graphs = _graphs;
    final error = _error;
    if (graphs == null && _loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (graphs == null && error != null) {
      return _StatisticsError(error: error, onRetry: _load);
    }
    if (graphs == null) {
      return const SizedBox.shrink();
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (error != null)
            MaterialBanner(
              content: Text('Could not refresh statistics: $error'),
              actions: [
                TextButton(onPressed: _load, child: const Text('Retry')),
              ],
            ),
          if (_loading) const LinearProgressIndicator(),
          _TodaySection(graphs: graphs),
          const SizedBox(height: 24),
          _CardCountsSection(graphs: graphs),
          const SizedBox(height: 24),
          _RetentionSection(graphs: graphs),
          if (graphs.hasFutureDue()) ...[
            const SizedBox(height: 24),
            _FutureDueSection(futureDue: graphs.futureDue),
          ],
        ],
      ),
    );
  }
}

class _RangeSelector extends StatelessWidget {
  const _RangeSelector({
    required this.selectedDays,
    required this.enabled,
    required this.ranges,
    required this.onSelected,
  });

  final int selectedDays;
  final bool enabled;
  final List<({int days, String label})> ranges;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          for (final range in ranges) ...[
            ChoiceChip(
              key: ValueKey('stats-range-${range.days}'),
              label: Text(range.label),
              selected: selectedDays == range.days,
              onSelected: enabled ? (_) => onSelected(range.days) : null,
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _TodaySection extends StatelessWidget {
  const _TodaySection({required this.graphs});

  final stats.GraphsResponse graphs;

  @override
  Widget build(BuildContext context) {
    final today = graphs.today;
    final accuracy = today.answerCount == 0
        ? null
        : today.correctCount / today.answerCount;
    final averageMillis = today.answerCount == 0
        ? null
        : today.answerMillis / today.answerCount;

    return _Section(
      title: 'Today',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _MetricCard(label: 'Answers', value: '${today.answerCount}'),
          _MetricCard(
            label: 'Study time',
            value: _formatDuration(Duration(milliseconds: today.answerMillis)),
          ),
          _MetricCard(
            label: 'Accuracy',
            value: accuracy == null ? '—' : '${(accuracy * 100).round()}%',
          ),
          _MetricCard(
            label: 'Average answer',
            value: averageMillis == null
                ? '—'
                : '${(averageMillis / 1000).toStringAsFixed(1)}s',
          ),
          _MetricCard(label: 'Learning', value: '${today.learnCount}'),
          _MetricCard(label: 'Review', value: '${today.reviewCount}'),
          _MetricCard(label: 'Relearning', value: '${today.relearnCount}'),
        ],
      ),
    );
  }
}

class _CardCountsSection extends StatelessWidget {
  const _CardCountsSection({required this.graphs});

  final stats.GraphsResponse graphs;

  @override
  Widget build(BuildContext context) {
    if (!graphs.hasCardCounts() || !graphs.cardCounts.hasExcludingInactive()) {
      return const _Section(
        title: 'Cards',
        child: Text('No card statistics are available.'),
      );
    }
    final counts = graphs.cardCounts.excludingInactive;
    return _Section(
      title: 'Cards',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _MetricCard(label: 'New', value: '${counts.newCards}'),
          _MetricCard(label: 'Learning', value: '${counts.learn}'),
          _MetricCard(label: 'Relearning', value: '${counts.relearn}'),
          _MetricCard(label: 'Young', value: '${counts.young}'),
          _MetricCard(label: 'Mature', value: '${counts.mature}'),
          _MetricCard(label: 'Suspended', value: '${counts.suspended}'),
          _MetricCard(label: 'Buried', value: '${counts.buried}'),
        ],
      ),
    );
  }
}

class _RetentionSection extends StatelessWidget {
  const _RetentionSection({required this.graphs});

  final stats.GraphsResponse graphs;

  @override
  Widget build(BuildContext context) {
    if (!graphs.hasTrueRetention()) {
      return const _Section(
        title: 'True retention',
        child: Text('No review history is available yet.'),
      );
    }
    final retention = graphs.trueRetention;
    return _Section(
      title: 'True retention',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          if (retention.hasToday())
            _MetricCard(
              label: 'Today',
              value: _retentionPercent(retention.today),
            ),
          if (retention.hasWeek())
            _MetricCard(
              label: 'Week',
              value: _retentionPercent(retention.week),
            ),
          if (retention.hasMonth())
            _MetricCard(
              label: 'Month',
              value: _retentionPercent(retention.month),
            ),
          if (retention.hasYear())
            _MetricCard(
              label: 'Year',
              value: _retentionPercent(retention.year),
            ),
          if (retention.hasAllTime())
            _MetricCard(
              label: 'All time',
              value: _retentionPercent(retention.allTime),
            ),
        ],
      ),
    );
  }
}

class _FutureDueSection extends StatelessWidget {
  const _FutureDueSection({required this.futureDue});

  final stats.GraphsResponse_FutureDue futureDue;

  @override
  Widget build(BuildContext context) {
    final entries = futureDue.futureDue.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final visible = entries.where((entry) => entry.key >= 0).take(14).toList();
    if (visible.isEmpty) {
      return const _Section(
        title: 'Future due',
        child: Text('No upcoming reviews in this range.'),
      );
    }
    final maxCount = visible.fold<int>(
      1,
      (current, entry) => entry.value > current ? entry.value : current,
    );
    return _Section(
      title: 'Future due',
      child: Column(
        children: [
          for (final entry in visible)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    child: Text(entry.key == 0 ? 'Today' : '+${entry.key}d'),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: entry.value / maxCount,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 48,
                    child: Text('${entry.value}', textAlign: TextAlign.end),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 152,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 6),
              Text(value, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatisticsError extends StatelessWidget {
  const _StatisticsError({required this.error, required this.onRetry});

  final Object error;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 40),
            const SizedBox(height: 12),
            Text(
              'Could not load statistics',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(error.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonal(
              key: const ValueKey('statistics-retry'),
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

String _retentionPercent(
  stats.GraphsResponse_TrueRetentionStats_TrueRetention value,
) {
  final passed = value.youngPassed + value.maturePassed;
  final failed = value.youngFailed + value.matureFailed;
  final total = passed + failed;
  return total == 0 ? '—' : '${(passed * 100 / total).round()}%';
}

String _formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  if (hours > 0) {
    return '${hours}h ${minutes}m';
  }
  if (minutes > 0) {
    return '${minutes}m ${seconds}s';
  }
  return '${seconds}s';
}
