import 'dart:async';

import 'package:anki_flutter/features/tags/data/anki_tag_manager_repository.dart';
import 'package:flutter/material.dart';

/// Manage tags through Anki's undoable native collection operations.
class TagManagerPage extends StatefulWidget {
  const TagManagerPage({
    required this.repository,
    this.onBrowse,
    this.onChanged,
    super.key,
  });

  final TagManagerRepository repository;
  final ValueChanged<String>? onBrowse;
  final Future<void> Function()? onChanged;

  @override
  State<TagManagerPage> createState() => _TagManagerPageState();
}

enum _TagAction { browse, rename, delete }

class _TagManagerPageState extends State<TagManagerPage> {
  final _filter = TextEditingController();
  List<String> _tags = const [];
  bool _loading = true;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (mounted) setState(() { _loading = true; _error = null; });
    try {
      final tags = await widget.repository.allTags();
      if (!mounted) return;
      setState(() {
        _tags = [...tags]..sort((a, b) =>
            a.toLowerCase().compareTo(b.toLowerCase()));
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() { _error = 'Could not load tags: $error'; _loading = false; });
    }
  }

  Future<void> _run(Future<int> Function() action, String message) async {
    if (_busy) return;
    setState(() { _busy = true; _error = null; });
    try {
      await action();
      final tags = await widget.repository.allTags();
      if (!mounted) return;
      setState(() {
        _tags = [...tags]..sort((a, b) =>
            a.toLowerCase().compareTo(b.toLowerCase()));
      });
      await widget.onChanged?.call();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (error) {
      if (mounted) setState(() => _error = 'Could not change tags: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _browse(String tag) {
    final escaped = tag.replaceAll(r'\', r'\\').replaceAll('"', r'\"');
    widget.onBrowse?.call('tag:"$escaped"');
  }

  Future<void> _rename(String tag) async {
    if (_busy) return;
    String candidate = tag;
    final replacement = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Rename tag'),
        content: TextFormField(
          key: const ValueKey('tag-rename-input'),
          initialValue: tag,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'New tag name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => candidate = value,
          onFieldSubmitted: (value) =>
              Navigator.of(dialogContext).pop(value.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('tag-rename-confirm'),
            onPressed: () =>
                Navigator.of(dialogContext).pop(candidate.trim()),
            child: const Text('Rename'),
          ),
        ],
      ),
    );
    if (!mounted || replacement == null) return;
    final newName = replacement.trim();
    if (newName.isEmpty || newName == tag) return;
    await _run(() => widget.repository.rename(tag, newName),
        'Renamed "$tag" to "$newName".');
  }

  Future<void> _delete(String tag) async {
    if (_busy) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove tag?'),
        content: Text(
          'Remove "$tag" from matching notes? '
          'Cards and notes will not be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('tag-delete-confirm'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove tag'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    await _run(() => widget.repository.remove(tag), 'Removed tag "$tag".');
  }

  Future<void> _clearUnused() async {
    if (_busy) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove unused tags?'),
        content: const Text(
          'Remove tags that are not used by any notes? '
          'Cards, notes and assigned tags will be preserved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('tag-cleanup-confirm'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove unused'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    await _run(widget.repository.clearUnused, 'Removed unused tags.');
  }

  @override
  Widget build(BuildContext context) {
    final needle = _filter.text.trim().toLowerCase();
    final visible = _tags.where(
      (tag) => tag.toLowerCase().contains(needle),
    ).toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage tags'),
        actions: [
          IconButton(
            key: const ValueKey('tag-cleanup'),
            tooltip: 'Remove unused tags',
            onPressed: _loading || _busy ? null : _clearUnused,
            icon: const Icon(Icons.cleaning_services_outlined),
          ),
          IconButton(
            tooltip: 'Refresh tags',
            onPressed: _loading || _busy ? null : _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                key: const ValueKey('tag-filter'),
                controller: _filter,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  labelText: 'Filter tags',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            if (_busy) const LinearProgressIndicator(),
            if (_error case final error?)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(error, style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                )),
              ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : visible.isEmpty
                      ? Center(child: Text(
                          needle.isEmpty ? 'No tags yet.' : 'No matching tags.',
                        ))
                      : ListView.builder(
                          itemCount: visible.length,
                          itemBuilder: (context, index) {
                            final tag = visible[index];
                            return ListTile(
                              key: ValueKey('tag-row-$tag'),
                              title: Text(tag, overflow: TextOverflow.ellipsis),
                              leading: const Icon(Icons.label_outline),
                              onTap: _busy || widget.onBrowse == null
                                  ? null
                                  : () => _browse(tag),
                              trailing: PopupMenuButton<_TagAction>(
                                key: ValueKey('tag-actions-$tag'),
                                tooltip: 'Actions for $tag',
                                enabled: !_busy,
                                onSelected: (action) {
                                  switch (action) {
                                    case _TagAction.browse:
                                      _browse(tag);
                                    case _TagAction.rename:
                                      unawaited(_rename(tag));
                                    case _TagAction.delete:
                                      unawaited(_delete(tag));
                                  }
                                },
                                itemBuilder: (_) => [
                                  if (widget.onBrowse != null)
                                    const PopupMenuItem(
                                      value: _TagAction.browse,
                                      child: Text('Browse cards'),
                                    ),
                                  const PopupMenuItem(
                                    value: _TagAction.rename,
                                    child: Text('Rename'),
                                  ),
                                  const PopupMenuItem(
                                    value: _TagAction.delete,
                                    child: Text('Remove'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
