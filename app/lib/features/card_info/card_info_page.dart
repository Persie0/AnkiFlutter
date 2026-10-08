import 'dart:async';

import 'package:anki_flutter/features/card_info/card_info_formatters.dart';
import 'package:anki_flutter/features/card_info/data/card_info_repository.dart';
import 'package:anki_flutter/features/card_info/models/card_info_data.dart';
import 'package:flutter/material.dart';

enum CardInfoKind { current, previous, browser }

class CardInfoPage extends StatefulWidget {
  const CardInfoPage({
    required this.repository,
    required this.cardId,
    required this.kind,
    super.key,
  });

  final CardInfoRepository repository;
  final int? cardId;
  final CardInfoKind kind;

  @override
  State<CardInfoPage> createState() => _CardInfoPageState();
}

class _CardInfoPageState extends State<CardInfoPage> {
  CardInfoData? _data;
  Object? _error;
  late bool _loading;
  int _requestGeneration = 0;

  @override
  void initState() {
    super.initState();
    _loading = widget.cardId != null;
    if (widget.cardId != null) {
      unawaited(_load());
    }
  }

  @override
  void didUpdateWidget(CardInfoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cardId == widget.cardId && oldWidget.kind == widget.kind) {
      return;
    }
    _requestGeneration++;
    _data = null;
    _error = null;
    _loading = widget.cardId != null;
    if (widget.cardId != null) {
      unawaited(_load());
    }
  }

  @override
  void dispose() {
    _requestGeneration++;
    super.dispose();
  }

  Future<void> _load() async {
    final cardId = widget.cardId;
    if (cardId == null) return;
    final generation = ++_requestGeneration;
    if (mounted) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }
    try {
      final data = await widget.repository.load(cardId);
      if (!mounted || generation != _requestGeneration) return;
      setState(() {
        _data = data;
        _loading = false;
      });
    } catch (error) {
      if (!mounted || generation != _requestGeneration) return;
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: SafeArea(child: _buildBody()),
    );
  }

  String get _title => switch (widget.kind) {
    CardInfoKind.current => 'Current Card Info',
    CardInfoKind.previous => 'Previous Card Info',
    CardInfoKind.browser => 'Card Info',
  };

  Widget _buildBody() {
    if (widget.cardId == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            widget.kind == CardInfoKind.previous
                ? 'No previous card available'
                : 'Card information unavailable',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final data = _data;
    if (data == null && _loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final error = _error;
    if (data == null && error != null) {
      return _CardInfoError(error: error, onRetry: _load);
    }
    if (data == null) return const SizedBox.shrink();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_loading) const LinearProgressIndicator(),
        if (error != null)
          MaterialBanner(
            content: Text('Could not refresh card information: $error'),
            actions: [
              TextButton(onPressed: _load, child: const Text('Retry')),
            ],
          ),
        _IdentitySection(data: data),
        const SizedBox(height: 16),
        _SchedulingSection(data: data),
        const SizedBox(height: 16),
        _TimingSection(data: data),
        if (_hasFsrs(data)) ...[
          const SizedBox(height: 16),
          _FsrsSection(data: data),
        ],
        const SizedBox(height: 16),
        _ReviewHistorySection(entries: data.reviewHistory),
      ],
    );
  }
}

class _IdentitySection extends StatelessWidget {
  const _IdentitySection({required this.data});

  final CardInfoData data;

  @override
  Widget build(BuildContext context) => _InfoSection(
    title: 'Identity',
    children: [
      _InfoRow(label: 'Card ID', value: '${data.cardId}'),
      _InfoRow(label: 'Note ID', value: '${data.noteId}'),
      _InfoRow(label: 'Deck', value: data.deck),
      if (data.originalDeck case final originalDeck?)
        _InfoRow(label: 'Original deck', value: originalDeck),
      _InfoRow(label: 'Card type', value: data.cardType),
      _InfoRow(label: 'Note type', value: data.noteType),
      _InfoRow(label: 'Preset', value: data.preset),
    ],
  );
}

class _SchedulingSection extends StatelessWidget {
  const _SchedulingSection({required this.data});

  final CardInfoData data;

  @override
  Widget build(BuildContext context) => _InfoSection(
    title: 'Scheduling',
    children: [
      if (data.dueUnixSeconds case final due?)
        _InfoRow(label: 'Due date', value: formatCardInfoTimestamp(due))
      else if (data.duePosition case final position?)
        _InfoRow(label: 'Due position', value: '$position'),
      _InfoRow(
        label: 'Interval',
        value: formatCardInfoIntervalDays(data.intervalDays),
      ),
      _InfoRow(label: 'Ease', value: formatCardInfoEase(data.easePermille)),
      _InfoRow(label: 'Reviews', value: '${data.reviews}'),
      _InfoRow(label: 'Lapses', value: '${data.lapses}'),
      if (data.customData.isNotEmpty)
        _InfoRow(label: 'Custom data', value: data.customData),
    ],
  );
}

class _TimingSection extends StatelessWidget {
  const _TimingSection({required this.data});

  final CardInfoData data;

  @override
  Widget build(BuildContext context) => _InfoSection(
    title: 'Timing',
    children: [
      _InfoRow(
        label: 'Added',
        value: formatCardInfoTimestamp(data.addedUnixSeconds),
      ),
      if (data.firstReviewUnixSeconds case final first?)
        _InfoRow(
          label: 'First review',
          value: formatCardInfoTimestamp(first),
        ),
      if (data.latestReviewUnixSeconds case final latest?)
        _InfoRow(
          label: 'Latest review',
          value: formatCardInfoTimestamp(latest),
        ),
      _InfoRow(
        label: 'Average answer',
        value: formatCardInfoDuration(data.averageSeconds),
      ),
      _InfoRow(
        label: 'Total answer time',
        value: formatCardInfoDuration(data.totalSeconds),
      ),
    ],
  );
}

class _FsrsSection extends StatelessWidget {
  const _FsrsSection({required this.data});

  final CardInfoData data;

  @override
  Widget build(BuildContext context) => _InfoSection(
    title: 'FSRS',
    children: [
      if (data.memoryState case final state?) ...[
        _InfoRow(
          label: 'Stability',
          value: state.stability.toStringAsFixed(2),
        ),
        _InfoRow(
          label: 'Difficulty',
          value: state.difficulty.toStringAsFixed(2),
        ),
      ],
      if (data.retrievability case final value?)
        _InfoRow(
          label: 'Retrievability',
          value: '${(value * 100).toStringAsFixed(1)}%',
        ),
      if (data.desiredRetention case final value?)
        _InfoRow(
          label: 'Desired retention',
          value: '${(value * 100).toStringAsFixed(1)}%',
        ),
      if (data.fsrsParameters.isNotEmpty)
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: 8),
          title: const Text('FSRS parameters'),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SelectableText(
                [
                  for (var index = 0; index < data.fsrsParameters.length; index++)
                    'p${index + 1}=${data.fsrsParameters[index].toStringAsFixed(4)}',
                ].join(', '),
              ),
            ),
          ],
        ),
    ],
  );
}

class _ReviewHistorySection extends StatelessWidget {
  const _ReviewHistorySection({required this.entries});

  final List<CardReviewHistoryEntry> entries;

  @override
  Widget build(BuildContext context) => _InfoSection(
    title: 'Review history',
    children: entries.isEmpty
        ? const [Text('No review history yet.')]
        : [
            for (var index = 0; index < entries.length; index++)
              _ReviewHistoryCard(
                key: ValueKey('card-info-review-$index'),
                entry: entries[index],
              ),
          ],
  );
}

class _ReviewHistoryCard extends StatelessWidget {
  const _ReviewHistoryCard({required this.entry, super.key});

  final CardReviewHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final memoryState = entry.memoryState;
    return Card.outlined(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatCardInfoTimestamp(entry.unixSeconds),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                Text(formatCardInfoReviewKind(entry.reviewKindValue)),
                Text('Button ${entry.buttonChosen}'),
                Text(formatCardInfoHistoryIntervalSeconds(entry.intervalSeconds)),
                Text(
                  'Previous: ${formatCardInfoHistoryIntervalSeconds(entry.lastIntervalSeconds)}',
                ),
                Text('Ease: ${formatCardInfoEase(entry.easePermille)}'),
                Text('Time: ${formatCardInfoDuration(entry.takenSeconds)}'),
              ],
            ),
            if (memoryState != null) ...[
              const SizedBox(height: 6),
              Text(
                'FSRS: stability ${memoryState.stability.toStringAsFixed(2)}, '
                'difficulty ${memoryState.difficulty.toStringAsFixed(2)}',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    ),
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 128,
          child: Text(label, style: Theme.of(context).textTheme.labelLarge),
        ),
        const SizedBox(width: 12),
        Expanded(child: SelectableText(value)),
      ],
    ),
  );
}

class _CardInfoError extends StatelessWidget {
  const _CardInfoError({required this.error, required this.onRetry});

  final Object error;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 40),
          const SizedBox(height: 12),
          Text(
            'Could not load card information',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(error.toString(), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    ),
  );
}

bool _hasFsrs(CardInfoData data) =>
    data.memoryState != null ||
    data.retrievability != null ||
    data.desiredRetention != null ||
    data.fsrsParameters.isNotEmpty;
