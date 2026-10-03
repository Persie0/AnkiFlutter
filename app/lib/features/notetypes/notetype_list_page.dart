import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notetypes/data/anki_notetype_repository.dart';
import 'package:anki_flutter/features/notetypes/notetype_editor_page.dart';
import 'package:flutter/material.dart';

class NotetypeListPage extends StatefulWidget {
  const NotetypeListPage({required this.repository, super.key});

  final NotetypeRepository repository;

  @override
  State<NotetypeListPage> createState() => _NotetypeListPageState();
}

enum _NotetypeAction { duplicate, delete }

class _NotetypeListPageState extends State<NotetypeListPage> {
  List<notetypes.NotetypeNameIdUseCount>? _entries;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await widget.repository.listNotetypes();
      final entries = [...response.entries]
        ..sort((left, right) => left.name.toLowerCase().compareTo(right.name.toLowerCase()));
      if (!mounted) return;
      setState(() {
        _entries = entries;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not load note types: $error';
      });
    }
  }

  Future<void> _open(notetypes.NotetypeNameIdUseCount entry) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NotetypeEditorPage(
          notetypeId: entry.id.toInt(),
          useCount: entry.useCount,
          repository: widget.repository,
        ),
      ),
    );
    if (changed == true && mounted) await _load();
  }

  Future<void> _duplicate(notetypes.NotetypeNameIdUseCount entry) async {
    final controller = TextEditingController(text: '${entry.name} copy');
    try {
      final name = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Duplicate note type'),
          content: TextField(
            key: const ValueKey('duplicate-notetype-name'),
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'New note type name'),
            onSubmitted: (_) {
              final value = controller.text.trim();
              if (value.isNotEmpty) Navigator.of(context).pop(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isNotEmpty) Navigator.of(context).pop(value);
              },
              child: const Text('Duplicate'),
            ),
          ],
        ),
      );
      if (!mounted || name == null) return;
      await widget.repository.duplicateNotetype(entry.id.toInt(), name);
      if (mounted) await _load();
    } catch (error) {
      if (mounted) {
        setState(() => _error = 'Could not duplicate note type: $error');
      }
    } finally {
      controller.dispose();
    }
  }

  Future<void> _delete(notetypes.NotetypeNameIdUseCount entry) async {
    final count = entry.useCount;
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete “${entry.name}”?'),
            content: Text(
              count == 0
                  ? 'This note type is not currently used by any notes.'
                  : 'This permanently deletes the note type and affects $count '
                      '${count == 1 ? 'note' : 'notes'}.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                key: const ValueKey('confirm-delete-notetype'),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed || !mounted) return;

    try {
      await widget.repository.removeNotetype(entry.id.toInt());
      if (mounted) await _load();
    } catch (error) {
      if (mounted) setState(() => _error = 'Could not delete note type: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note types'),
        actions: [
          IconButton(
            tooltip: 'Reload note types',
            onPressed: _loading ? null : _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading && _entries == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final entries = _entries;
    if (entries == null) {
      return _ErrorPane(message: _error ?? 'Could not load note types.', onRetry: _load);
    }

    return Column(
      children: [
        if (_error case final error?)
          MaterialBanner(
            key: const ValueKey('notetype-list-error'),
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => setState(() => _error = null),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        Expanded(
          child: entries.isEmpty
              ? const Center(child: Text('No note types'))
              : ListView.separated(
                  itemCount: entries.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return ListTile(
                      key: ValueKey('notetype-${entry.id}'),
                      leading: const Icon(Icons.view_agenda_outlined),
                      title: Text(entry.name),
                      subtitle: Text(
                        '${entry.useCount} ${entry.useCount == 1 ? 'note' : 'notes'}',
                      ),
                      onTap: () => _open(entry),
                      trailing: PopupMenuButton<_NotetypeAction>(
                        tooltip: 'Note type actions',
                        onSelected: (action) => switch (action) {
                          _NotetypeAction.duplicate => _duplicate(entry),
                          _NotetypeAction.delete => _delete(entry),
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: _NotetypeAction.duplicate,
                            child: ListTile(
                              leading: Icon(Icons.copy_outlined),
                              title: Text('Duplicate'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          PopupMenuItem(
                            value: _NotetypeAction.delete,
                            child: ListTile(
                              leading: Icon(Icons.delete_outline),
                              title: Text('Delete'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _ErrorPane extends StatelessWidget {
  const _ErrorPane({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
