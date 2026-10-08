import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart'
    as media;
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Media integrity audit delegated to Anki's native backend.
/// Destructive cleanup is opt-in, confirmed, and moves files to reversible trash.
class CheckMediaPage extends StatefulWidget {
  const CheckMediaPage({
    required this.repository,
    this.onOpenNote,
    this.onBrowseAffectedNotes,
    super.key,
  });

  final MediaRepository repository;

  /// Optional navigation to the native Anki note editor. True means saved.
  final Future<bool?> Function(int noteId)? onOpenNote;

  /// Optional navigation to Browse, with the exact note IDs from Anki.
  final void Function(List<int> noteIds)? onBrowseAffectedNotes;

  @override
  State<CheckMediaPage> createState() => _CheckMediaPageState();
}

class _CheckMediaPageState extends State<CheckMediaPage> {
  static const int _pageSize = 50;

  bool _checking = false;
  bool _changingTrash = false;
  Object? _error;
  media.CheckMediaResponse? _result;
  int _missingVisible = _pageSize;
  int _unusedVisible = _pageSize;
  int _notesVisible = _pageSize;

  Future<void> _check() async {
    if (_checking || _changingTrash) return;
    setState(() {
      _checking = true;
      _error = null;
    });
    try {
      final result = await widget.repository.checkMedia();
      if (!mounted) return;
      setState(() {
        _result = result;
        _missingVisible = _pageSize;
        _unusedVisible = _pageSize;
        _notesVisible = _pageSize;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _changeTrash({required bool restore}) async {
    final repository = widget.repository is MediaTrashRepository
        ? widget.repository as MediaTrashRepository
        : null;
    final result = _result;
    if (repository == null ||
        result == null ||
        _error != null ||
        _checking ||
        _changingTrash ||
        (restore ? !result.haveTrash : result.unused.isEmpty)) {
      return;
    }
    // Snapshot only names Anki itself identifies as unused. Never take
    // arbitrary user filenames or permanently empty the media trash.
    final unused = List<String>.unmodifiable(result.unused);
    setState(() => _changingTrash = true);
    try {
      final approved = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(
            restore
                ? 'Restore media trash?'
                : 'Move ${unused.length} unused files to trash?',
          ),
          content: Text(
            restore
                ? 'Restore files from Anki media trash into this collection.'
                : 'Move the ${unused.length} media files identified by the '
                      'last native Anki scan into media trash. '
                      'You can restore them later. Nothing is permanently deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              key: ValueKey(
                restore ? 'media-confirm-restore' : 'media-confirm-trash',
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(restore ? 'Restore files' : 'Move to trash'),
            ),
          ],
        ),
      );
      if (!mounted || approved != true) return;
      if (restore) {
        await repository.restoreMediaTrash();
      } else {
        await repository.trashMediaFiles(unused);
      }
      if (!mounted) return;
      setState(() => _changingTrash = false);
      await _check();
      if (!mounted || _error != null) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            restore
                ? 'Media trash restored.'
                : 'Moved ${unused.length} unused files to media trash.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            restore
                ? 'Could not restore media trash: $error'
                : 'Could not move unused media to trash: $error',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _changingTrash = false);
    }
  }

  Future<void> _openAffectedNote(int noteId) async {
    final openNote = widget.onOpenNote;
    if (openNote == null || _checking || _changingTrash) return;
    try {
      final saved = await openNote(noteId);
      if (saved == true && mounted) {
        await _check();
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open note $noteId: $error')),
      );
    }
  }

  Future<void> _copyReport(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Media report copied.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not copy media report: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Check media')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Collection media audit', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
              'Use Anki’s native media checker to find missing files, '
              'unused media, and notes referencing missing media. '
              'Checking does not delete or modify files.',
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                key: const ValueKey('media-check-run'),
                onPressed: _checking || _changingTrash
                    ? null
                    : () => unawaited(_check()),
                icon: _checking
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.fact_check_outlined),
                label: Text(_checking
                    ? 'Checking media…'
                    : result == null
                        ? 'Check collection media'
                        : 'Check again'),
              ),
            ),
            if (_error case final error?) ...[
              const SizedBox(height: 12),
              Text(
                'Could not check media: $error',
                key: const ValueKey('media-check-error'),
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ],
            if (result case final result?) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              Text('Missing files: ${result.missing.length}'),
              const SizedBox(height: 4),
              Text('Unused files: ${result.unused.length}'),
              const SizedBox(height: 4),
              Text(
                'Affected notes: ${result.missingMediaNotes.map((id) => id.toInt()).where((id) => id > 0).toSet().length}',
              ),
              if (result.haveTrash) ...[
                const SizedBox(height: 8),
                const Text('Media trash exists.'),
              ],
              if (widget.repository is MediaTrashRepository &&
                  _error == null) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (result.unused.isNotEmpty)
                      OutlinedButton.icon(
                        key: const ValueKey('media-trash-unused'),
                        onPressed: _checking || _changingTrash
                            ? null
                            : () => unawaited(
                                _changeTrash(restore: false),
                              ),
                        icon: const Icon(Icons.delete_outline),
                        label: Text(
                          'Move ${result.unused.length} unused to trash',
                        ),
                      ),
                    if (result.haveTrash)
                      OutlinedButton.icon(
                        key: const ValueKey('media-restore-trash'),
                        onPressed: _checking || _changingTrash
                            ? null
                            : () => unawaited(
                                _changeTrash(restore: true),
                              ),
                        icon: const Icon(Icons.restore_from_trash_outlined),
                        label: const Text('Restore media trash'),
                      ),
                  ],
                ),
              ],
              if (result.report.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Anki report', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                SelectableText(result.report),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    key: const ValueKey('media-check-copy-report'),
                    onPressed: () => unawaited(_copyReport(result.report)),
                    icon: const Icon(Icons.copy_outlined),
                    label: const Text('Copy report'),
                  ),
                ),
              ],
              _buildGroup(
                title: 'Missing media',
                description: 'Referenced in notes, but absent from the collection.',
                filenames: result.missing,
                visible: _missingVisible,
                keyName: 'missing',
                onShowMore: () => setState(() => _missingVisible += _pageSize),
              ),
              _buildGroup(
                title: 'Unused media',
                description: 'Present in the collection, but not referenced. '
                    'No files are removed by this audit.',
                filenames: result.unused,
                visible: _unusedVisible,
                keyName: 'unused',
                onShowMore: () => setState(() => _unusedVisible += _pageSize),
              ),
              _buildAffectedNotes(
                result.missingMediaNotes
                    .map((id) => id.toInt())
                    .where((id) => id > 0)
                    .toSet()
                    .toList(growable: false),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAffectedNotes(List<int> noteIds) {
    if (noteIds.isEmpty) return const SizedBox.shrink();
    final visibleCount = _notesVisible < noteIds.length
        ? _notesVisible
        : noteIds.length;
    final browse = widget.onBrowseAffectedNotes;
    return Card(
      key: const ValueKey('media-check-group-notes'),
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes with missing media',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            const Text('Anki note IDs referencing missing files.'),
            if (browse != null) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                key: const ValueKey('media-browse-affected-notes'),
                onPressed: _checking || _changingTrash
                    ? null
                    : () => browse(List<int>.unmodifiable(noteIds)),
                icon: const Icon(Icons.search),
                label: Text('Browse affected notes (${noteIds.length})'),
              ),
            ],
            const SizedBox(height: 8),
            for (final noteId in noteIds.take(visibleCount))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(child: SelectableText('Note ID $noteId')),
                    if (widget.onOpenNote != null)
                      TextButton(
                        key: ValueKey('media-open-note-$noteId'),
                        onPressed: _checking || _changingTrash
                            ? null
                            : () => unawaited(_openAffectedNote(noteId)),
                        child: const Text('Edit note'),
                      ),
                  ],
                ),
              ),
            if (visibleCount < noteIds.length) ...[
              const SizedBox(height: 8),
              TextButton(
                key: const ValueKey('media-check-more-notes'),
                onPressed: () => setState(() => _notesVisible += _pageSize),
                child: Text(
                  'Show more (${noteIds.length - visibleCount} remaining)',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGroup({
    required String title,
    required String description,
    required List<String> filenames,
    required int visible,
    required String keyName,
    required VoidCallback onShowMore,
  }) {
    if (filenames.isEmpty) return const SizedBox.shrink();
    final renderedCount = visible < filenames.length ? visible : filenames.length;
    return Card(
      key: ValueKey('media-check-group-$keyName'),
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 8),
            for (final filename in filenames.take(renderedCount))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: SelectableText(filename),
              ),
            if (renderedCount < filenames.length) ...[
              const SizedBox(height: 8),
              TextButton(
                key: ValueKey('media-check-more-$keyName'),
                onPressed: onShowMore,
                child: Text('Show more (${filenames.length - renderedCount} remaining)'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
