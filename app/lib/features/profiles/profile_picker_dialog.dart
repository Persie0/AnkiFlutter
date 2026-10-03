import 'dart:async';

import 'package:anki_flutter/features/profiles/data/file_profile_repository.dart';
import 'package:flutter/material.dart';

typedef ExistingCollectionPicker = Future<String?> Function();

class ProfilePickerDialog extends StatefulWidget {
  const ProfilePickerDialog({
    required this.repository,
    required this.pickExistingCollection,
    super.key,
  });

  final ProfileRepository repository;
  final ExistingCollectionPicker pickExistingCollection;

  @override
  State<ProfilePickerDialog> createState() => _ProfilePickerDialogState();
}

class _ProfilePickerDialogState extends State<ProfilePickerDialog> {
  List<AnkiProfile> _profiles = const [];
  bool _loading = true;
  bool _busy = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final profiles = await widget.repository.list();
      if (!mounted) return;
      setState(() {
        _profiles = profiles;
        _loading = false;
        _error = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

  Future<void> _createProfile() async {
    final name = await _askForName(
      title: 'New profile',
      actionLabel: 'Create',
    );
    if (name == null || !mounted) return;
    await _run(() async {
      final profile = await widget.repository.create(name);
      if (mounted) Navigator.of(context).pop(profile.collectionPath);
    });
  }

  Future<void> _browse() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final path = await widget.pickExistingCollection();
      if (!mounted) return;
      setState(() => _busy = false);
      if (path == null) return;
      final name = await _askForName(
        title: 'Add profile',
        actionLabel: 'Add',
        initialName: _collectionName(path),
      );
      if (name == null || !mounted) return;
      await _run(() async {
        final profile = await widget.repository.registerExternal(
          name: name,
          collectionPath: path,
        );
        if (mounted) Navigator.of(context).pop(profile.collectionPath);
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = error;
      });
    }
  }

  Future<void> _rename(AnkiProfile profile) async {
    final name = await _askForName(
      title: 'Rename profile',
      actionLabel: 'Save',
      initialName: profile.name,
    );
    if (name == null) return;
    await _run(() async {
      await widget.repository.rename(profile.id, name);
      await _load();
    });
  }

  Future<void> _forget(AnkiProfile profile) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Forget ${profile.name}?'),
        content: const Text(
          'This removes the profile from AnkiFlutter only. The collection and media files are not deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Forget'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _run(() async {
      await widget.repository.remove(profile.id);
      await _load();
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      if (mounted) setState(() => _busy = false);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = error;
      });
    }
  }

  Future<String?> _askForName({
    required String title,
    required String actionLabel,
    String initialName = '',
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => _ProfileNameDialog(
        title: title,
        actionLabel: actionLabel,
        initialName: initialName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Profiles'),
      content: SizedBox(
        width: 520,
        height: 420,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_busy) const LinearProgressIndicator(),
            if (_error case final error?) ...[
              MaterialBanner(
                content: Text('Profile operation failed: $error'),
                actions: [
                  TextButton(
                    onPressed: () => setState(() => _error = null),
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
            ],
            Expanded(child: _buildProfiles()),
          ],
        ),
      ),
      actions: [
        TextButton.icon(
          key: const ValueKey('browse-profile'),
          onPressed: _busy ? null : _browse,
          icon: const Icon(Icons.folder_open),
          label: const Text('Browse'),
        ),
        FilledButton.icon(
          key: const ValueKey('new-profile'),
          onPressed: _busy ? null : _createProfile,
          icon: const Icon(Icons.add),
          label: const Text('New profile'),
        ),
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildProfiles() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_profiles.isEmpty) {
      return const Center(
        child: Text(
          'No profiles yet. Create one for a new collection or browse to an existing Anki collection.',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      itemCount: _profiles.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final profile = _profiles[index];
        return ListTile(
          key: ValueKey('profile-${profile.id}'),
          leading: Icon(profile.isManaged ? Icons.person : Icons.link),
          title: Text(profile.name),
          subtitle: Text(profile.collectionPath),
          enabled: !_busy,
          onTap: _busy
              ? null
              : () => Navigator.of(context).pop(profile.collectionPath),
          trailing: PopupMenuButton<_ProfileAction>(
            enabled: !_busy,
            onSelected: (action) {
              switch (action) {
                case _ProfileAction.rename:
                  unawaited(_rename(profile));
                case _ProfileAction.forget:
                  unawaited(_forget(profile));
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: _ProfileAction.rename,
                child: Text('Rename'),
              ),
              PopupMenuItem(
                value: _ProfileAction.forget,
                child: Text('Forget'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileNameDialog extends StatefulWidget {
  const _ProfileNameDialog({
    required this.title,
    required this.actionLabel,
    required this.initialName,
  });

  final String title;
  final String actionLabel;
  final String initialName;

  @override
  State<_ProfileNameDialog> createState() => _ProfileNameDialogState();
}

class _ProfileNameDialogState extends State<_ProfileNameDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          key: const ValueKey('profile-name'),
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Profile name'),
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Enter a profile name'
              : null,
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(widget.actionLabel),
        ),
      ],
    );
  }
}

enum _ProfileAction { rename, forget }

String _collectionName(String path) {
  final filename = path.split(RegExp(r'[/\\]')).last;
  final name = filename.replaceFirst(
    RegExp(r'\.anki2$', caseSensitive: false),
    '',
  );
  return name.isEmpty || name.toLowerCase() == 'collection' ? 'Profile' : name;
}
