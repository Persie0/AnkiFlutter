import 'dart:async';

import 'package:anki_flutter/features/collection/data/anki_database_check_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Anki's collection check may repair inconsistent data, so never run it
/// implicitly when opening a collection or visiting this page.
class CheckDatabasePage extends StatefulWidget {
  const CheckDatabasePage({
    required this.repository,
    this.onCollectionChanged,
    super.key,
  });

  final DatabaseCheckRepository repository;
  final Future<void> Function()? onCollectionChanged;

  @override
  State<CheckDatabasePage> createState() => _CheckDatabasePageState();
}

class _CheckDatabasePageState extends State<CheckDatabasePage> {
  static const _pageSize = 50;
  bool _checking = false;
  List<String>? _messages;
  Object? _error;
  int _visible = _pageSize;

  Future<void> _check() async {
    if (_checking) return;
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Check Anki database?'),
        content: const Text(
          'Anki will inspect this collection and may repair inconsistent '
          'data. Back up your collection before proceeding. The operation '
          'may take time on large collections.',
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
    if (!mounted || approved != true || _checking) return;

    setState(() {
      _checking = true;
      _error = null;
      _messages = null;
    });
    try {
      final messages = await widget.repository.checkDatabase();
      if (!mounted) return;
      setState(() {
        _messages = List.unmodifiable(messages);
        _visible = _pageSize;
      });
      await widget.onCollectionChanged?.call();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error;
        _messages = null;
      });
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _copyMessages() async {
    final messages = _messages;
    if (messages == null || messages.isEmpty) return;
    try {
      await Clipboard.setData(ClipboardData(text: messages.join('\n')));
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
    final messages = _messages;
    return Scaffold(
      appBar: AppBar(title: const Text('Check database')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Collection database integrity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Use Anki’s built-in database checker to inspect and, when '
              'necessary, repair the currently open collection. '
              'Make a backup before running it.',
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                key: const ValueKey('database-check-run'),
                onPressed: _checking ? null : () => unawaited(_check()),
                icon: _checking
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.build_circle_outlined),
                label: Text(_checking ? 'Checking database…' : 'Check database'),
              ),
            ),
            if (_error case final error?) ...[
              const SizedBox(height: 12),
              Text(
                'Database check failed: $error',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            if (messages != null) ...[
              const SizedBox(height: 16),
              if (messages.isEmpty)
                const Text('Anki reported no database problems.')
              else ...[
                Text(
                  'Anki reported ${messages.length} '
                  '${messages.length == 1 ? 'message' : 'messages'}.',
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    key: const ValueKey('database-check-copy'),
                    onPressed: () => unawaited(_copyMessages()),
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy report'),
                  ),
                ),
                for (final message in messages.take(_visible))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: SelectableText(message),
                  ),
                if (_visible < messages.length)
                  TextButton(
                    key: const ValueKey('database-check-more'),
                    onPressed: () => setState(() => _visible += _pageSize),
                    child: Text(
                      'Show more (${messages.length - _visible} remaining)',
                    ),
                  ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
