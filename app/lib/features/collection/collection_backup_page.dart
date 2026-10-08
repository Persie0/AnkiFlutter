import 'dart:async';

import 'package:anki_flutter/features/collection/data/anki_collection_backup_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

typedef BackupDirectoryPicker = Future<String?> Function();

/// Manual no-media backup. The native Anki backend writes the backup file;
/// Dart neither serializes the collection nor claims success on a skipped run.
class CollectionBackupPage extends StatefulWidget {
  const CollectionBackupPage({
    required this.repository,
    this.pickDirectory,
    super.key,
  });

  final CollectionBackupRepository repository;
  final BackupDirectoryPicker? pickDirectory;

  @override
  State<CollectionBackupPage> createState() => _CollectionBackupPageState();
}

class _CollectionBackupPageState extends State<CollectionBackupPage> {
  bool _busy = false;
  String? _result;
  String? _error;
  String? _destination;

  Future<void> _create() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
      _result = null;
    });
    try {
      final destination = await (widget.pickDirectory ??
          () => FilePicker.platform.getDirectoryPath(
                dialogTitle: 'Choose Anki backup folder',
              ))();
      if (!mounted || destination == null) return;
      final path = destination.trim();
      if (path.isEmpty) {
        throw ArgumentError('Select a folder accessible as a native path.');
      }
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Create Anki collection backup?'),
          content: Text(
            'Anki will create a database-only backup in:\n$path\n\n'
            'Media files are not included. Use Export as .apkg for a '
            'portable package with media. A backup may take time on '
            'large collections.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              key: const ValueKey('collection-backup-confirm'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Create backup'),
            ),
          ],
        ),
      );
      if (!mounted || confirmed != true) return;
      final created = await widget.repository.createBackup(path);
      if (!mounted) return;
      setState(() {
        _destination = path;
        _result = created
            ? 'Backup completed in $path'
            : 'Anki did not create a backup in $path.';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = 'Could not create collection backup: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: !_busy,
        child: Scaffold(
          appBar: AppBar(title: const Text('Collection backup')),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Back up collection', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const Text(
                  'Create a local database-only backup using Anki’s native '
                  'backup engine. This preserves notes, decks and scheduling, '
                  'but not media files. For sharing or transferring your '
                  'collection with media, use Import & export instead.',
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.icon(
                    key: const ValueKey('collection-backup-run'),
                    onPressed: _busy ? null : () => unawaited(_create()),
                    icon: _busy
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.backup_outlined),
                    label: Text(_busy ? 'Creating backup…' : 'Choose folder and back up'),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _error!,
                    key: const ValueKey('collection-backup-error'),
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
                if (_result != null) ...[
                  const SizedBox(height: 16),
                  Text(_result!, key: const ValueKey('collection-backup-result')),
                  if (_destination != null)
                    SelectableText('Destination: $_destination'),
                ],
              ],
            ),
          ),
        ),
      );
}
