import 'dart:async';

import 'package:anki_flutter/features/collection/data/anki_collection_integrity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deliberately user-initiated. Upstream Check Database can repair a
/// collection; this screen must never run it automatically during startup.
class CheckDatabasePage extends StatefulWidget {
  const CheckDatabasePage({
    required this.repository,
    this.onCollectionChanged,
    super.key,
  });

  final CollectionIntegrityRepository repository;
  final Future<void> Function()? onCollectionChanged;

  @override
  State<CheckDatabasePage> createState() => _CheckDatabasePageState();
}

class _CheckDatabasePageState extends State<CheckDatabasePage> {
  static const _pageSize = 50;

  bool _running = false;
  List<String>? _problems;
  int _visible = _pageSize;
  Object? _error;
  Object? _refreshError;

  Future<void> _runCheck() async {
    if (_running) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Check database?'),
        content: const Text(
          'Anki’s database checker may repair collection inconsistencies '
          'and modify notes or scheduling data. Make a collection backup '
          'before continuing. This operation can take some time.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('database-check-confirm'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Check database'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true || _running) return;

    setState(() {
      _running = true;
      _error = null;
      _refreshError = null;
      _problems = null;
      _visible = _pageSize;
    });
    try {
      final problems = await widget.repository.checkDatabase();
      if (!mounted) return;
      setState(() => _problems = problems);
      try {
        await widget.onCollectionChanged?.call();
      } catch (error) {
        if (mounted) setState(() => _refreshError = error);
      }
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }

  Future<void> _copyReport() async {
    final problems = _problems;
    if (problems == null) return;
    final report = problems.isEmpty
        ? 'Anki Check Database: no problems reported.'
        : 'Anki Check Database: ${problems.length} reported problems\n'
              '${problems.map((problem) => '- $problem').join('\n')}';
    try {
      await Clipboard.setData(ClipboardData(text: report));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Database report copied.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not copy report: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final problems = _problems;
    final shown = problems == null
        ? 0
        : (_visible < problems.length ? _visible : problems.length);

    return Scaffold(
      appBar: AppBar(title: const Text('Check database')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Collection integrity', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
              'Verify the open collection using Anki’s own database checker. '
              'It can repair problems, so create a backup first.',
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                key: const ValueKey('database-check-run'),
                onPressed: _running ? null : () => unawaited(_runCheck()),
                icon: _running
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.fact_check_outlined),
                label: Text(_running ? 'Checking database…' : 'Check database'),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                'Database check failed: $_error',
                key: const ValueKey('database-check-error'),
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ],
            if (problems != null) ...[
              const SizedBox(height: 20),
              Text(
                problems.isEmpty
                    ? 'Check completed: no problems reported.'
                    : 'Check completed: ${problems.length} problems reported.',
                key: const ValueKey('database-check-summary'),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'The report comes from Anki’s backend. If problems were '
                'found, review them before continuing to study or sync.',
              ),
              if (_refreshError != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Check completed, but could not refresh decks: $_refreshError',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ],
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  key: const ValueKey('database-check-copy'),
                  onPressed: () => unawaited(_copyReport()),
                  icon: const Icon(Icons.copy_outlined),
                  label: const Text('Copy report'),
                ),
              ),
              for (final problem in problems.take(shown))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SelectableText(problem),
                ),
              if (shown < problems.length)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    key: const ValueKey('database-check-more'),
                    onPressed: () => setState(() => _visible += _pageSize),
                    child: Text(
                      'Show more (${problems.length - shown} remaining)',
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
