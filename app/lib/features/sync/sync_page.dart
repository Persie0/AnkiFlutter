import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/sync.pb.dart' as sync;
import 'package:anki_flutter/features/sync/data/anki_sync_repository.dart';
import 'package:anki_flutter/features/collection/data/anki_collection_backup_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:anki_flutter/features/sync/data/sync_auth_store.dart';
import 'package:flutter/material.dart';

enum _BackupChoice { cancel, skip, backup }

class SyncPage extends StatefulWidget {
  const SyncPage({
    required this.repository,
    required this.authStore,
    this.onCollectionChanged,
    this.backupRepository,
    this.chooseBackupDirectory,
    super.key,
  });

  final SyncRepository repository;
  final SyncAuthStore authStore;
  final Future<void> Function()? onCollectionChanged;
  /// Optional native database backup before a destructive full download.
  final CollectionBackupRepository? backupRepository;
  final Future<String?> Function()? chooseBackupDirectory;

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _endpointController = TextEditingController();
  sync.SyncAuth? _auth;
  sync.MediaSyncStatusResponse? _mediaStatus;
  Timer? _mediaTimer;
  Object? _mediaStatusRequest;
  int _mediaStatusGeneration = 0;
  bool _loading = true;
  bool _busy = false;
  bool _syncMedia = true;
  String? _status;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAuth();
  }

  Future<void> _loadAuth() async {
    try {
      final auth = await widget.authStore.load();
      if (!mounted) return;
      if (auth != null && auth.hasEndpoint()) {
        _endpointController.text = auth.endpoint;
      }
      setState(() {
        _auth = auth;
        _loading = false;
      });
      if (auth != null) {
        unawaited(_refreshMediaStatus());
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not load sync authorization: $error';
      });
    }
  }

  Future<void> _login() async {
    if (_busy) return;
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      setState(() => _error = 'Enter your AnkiWeb email and password.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _status = 'Signing in…';
    });
    try {
      final auth = await widget.repository.login(
        username: username,
        password: password,
        endpoint: _endpointController.text.trim().isEmpty
            ? null
            : _endpointController.text.trim(),
      );
      await widget.authStore.save(auth);
      _passwordController.clear();
      if (!mounted) return;
      _stopMediaPolling(); // Discard status responses belonging to an older account.
      setState(() {
        _auth = auth;
        _busy = false;
        _status = 'Signed in to AnkiWeb.';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = null;
        _error = 'Could not sign in: $error';
      });
    }
  }

  Future<void> _logout() async {
    _stopMediaPolling();
    await widget.authStore.clear();
    if (!mounted) return;
    setState(() {
      _auth = null;
      _mediaStatus = null;
      _status = 'Signed out.';
      _error = null;
    });
  }

  Future<void> _sync() async {
    final auth = _auth;
    if (auth == null || _busy) return;
    setState(() {
      _busy = true;
      _error = null;
      _status = 'Syncing collection…';
    });
    try {
      final response = await widget.repository.syncCollection(
        auth,
        syncMedia: _syncMedia,
      );
      if (!mounted) return;
      if (response.hasNewEndpoint() && response.newEndpoint.isNotEmpty) {
        auth.endpoint = response.newEndpoint;
        await widget.authStore.save(auth);
      }
      final completed = await _handleSyncResponse(auth, response);
      if (!mounted) return;
      if (completed) {
        await widget.onCollectionChanged?.call();
      }
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = completed
            ? (response.serverMessage.isEmpty
                  ? 'Collection sync complete.'
                  : response.serverMessage)
            : null;
      });
      if (completed && _syncMedia) {
        _startMediaPolling();
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = null;
        _error = 'Sync failed: $error';
      });
    }
  }

  Future<bool> _handleSyncResponse(
    sync.SyncAuth auth,
    sync.SyncCollectionResponse response,
  ) async {
    switch (response.required) {
      case sync.SyncCollectionResponse_ChangesRequired.NO_CHANGES:
      case sync.SyncCollectionResponse_ChangesRequired.NORMAL_SYNC:
        return true;
      case sync.SyncCollectionResponse_ChangesRequired.FULL_UPLOAD:
        return _runFullSync(auth, response, upload: true, allowChoice: false);
      case sync.SyncCollectionResponse_ChangesRequired.FULL_DOWNLOAD:
        return _runFullSync(auth, response, upload: false, allowChoice: false);
      case sync.SyncCollectionResponse_ChangesRequired.FULL_SYNC:
        final upload = await _chooseFullSyncDirection();
        if (upload == null || !mounted) return false;
        return _runFullSync(auth, response, upload: upload, allowChoice: true);
      default:
        return true;
    }
  }

  Future<bool?> _chooseFullSyncDirection() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Full sync required'),
        content: const Text(
          'Anki cannot merge the local and AnkiWeb collections automatically. '
          'Choose which copy should replace the other. This overwrites the '
          'collection on the destination side.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            key: const ValueKey('full-sync-download'),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Download from AnkiWeb'),
          ),
          FilledButton(
            key: const ValueKey('full-sync-upload'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Upload this collection'),
          ),
        ],
      ),
    );
  }

  Future<bool> _runFullSync(
    sync.SyncAuth auth,
    sync.SyncCollectionResponse response, {
    required bool upload,
    required bool allowChoice,
  }) async {
    if (!allowChoice) {
      final confirmed = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text(upload ? 'Full upload required' : 'Full download required'),
              content: Text(
                upload
                    ? 'AnkiWeb has no mergeable collection. Uploading will replace the remote collection.'
                    : 'The local collection cannot be merged. Downloading will replace the local collection.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(upload ? 'Upload' : 'Download'),
                ),
              ],
            ),
          ) ??
          false;
      if (!confirmed) return false;
    }
    if (!upload && widget.backupRepository != null) {
      if (!await _confirmDownloadProtection() || !mounted) return false;
    }
    setState(() {
      _status = upload ? 'Uploading full collection…' : 'Downloading full collection…';
    });
    await widget.repository.fullSync(
      auth,
      upload: upload,
      serverUsn: _syncMedia ? response.serverMediaUsn : null,
    );
    return true;
  }

  Future<bool> _confirmDownloadProtection() async {
    final choice = await showDialog<_BackupChoice>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Protect the local collection'),
        content: const Text(
          'Downloading from AnkiWeb will replace the local collection. '
          'You can create a database-only backup first. '
          'Media files are not included in this backup.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, _BackupChoice.cancel),
            child: const Text('Cancel download'),
          ),
          TextButton(
            key: const ValueKey('full-sync-skip-backup'),
            onPressed: () => Navigator.pop(dialogContext, _BackupChoice.skip),
            child: const Text('Download without backup'),
          ),
          FilledButton(
            key: const ValueKey('full-sync-create-backup'),
            onPressed: () => Navigator.pop(dialogContext, _BackupChoice.backup),
            child: const Text('Back up first'),
          ),
        ],
      ),
    );
    if (!mounted || choice == null || choice == _BackupChoice.cancel) {
      return false;
    }
    if (choice == _BackupChoice.skip) return true;

    final directory = await (widget.chooseBackupDirectory ??
        () => FilePicker.getDirectoryPath(
              dialogTitle: 'Choose pre-sync backup folder',
            ))();
    if (!mounted || directory == null) return false;
    final trimmed = directory.trim();
    if (trimmed.isEmpty) return false;
    setState(() => _status = 'Backing up local collection…');
    final created = await widget.backupRepository!.createBackup(trimmed);
    if (!created) {
      throw StateError(
        'Anki did not create the backup. Download was not started.',
      );
    }
    return mounted;
  }

  Future<void> _refreshStatus() async {
    final auth = _auth;
    if (auth == null || _busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final response = await widget.repository.status(auth);
      if (!mounted) return;
      if (response.hasNewEndpoint() && response.newEndpoint.isNotEmpty) {
        auth.endpoint = response.newEndpoint;
        await widget.authStore.save(auth);
      }
      setState(() {
        _busy = false;
        _status = switch (response.required) {
          sync.SyncStatusResponse_Required.NO_CHANGES => 'No collection changes waiting to sync.',
          sync.SyncStatusResponse_Required.NORMAL_SYNC => 'A normal sync is required.',
          sync.SyncStatusResponse_Required.FULL_SYNC => 'A full upload or download is required.',
          _ => 'Sync status updated.',
        };
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Could not check sync status: $error';
      });
    }
  }

  Future<void> _syncMediaOnly() async {
    final auth = _auth;
    if (auth == null || _busy) return;
    setState(() {
      _busy = true;
      _error = null;
      _status = 'Starting media sync…';
    });
    try {
      await widget.repository.syncMedia(auth);
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = 'Media sync started.';
      });
      _startMediaPolling();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Could not start media sync: $error';
      });
    }
  }

  void _startMediaPolling() {
    _stopMediaPolling();
    unawaited(_refreshMediaStatus());
    _mediaTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => unawaited(_refreshMediaStatus()),
    );
  }

  void _stopMediaPolling() {
    _mediaTimer?.cancel();
    _mediaTimer = null;
    // Invalidate already dispatched callbacks (logout, cancellation, or
    // switching accounts). Their completion must not update the new session.
    _mediaStatusGeneration++;
    _mediaStatusRequest = null;
  }

  Future<void> _refreshMediaStatus() async {
    final auth = _auth;
    if (auth == null || _mediaStatusRequest != null) return;
    final request = Object();
    final generation = _mediaStatusGeneration;
    _mediaStatusRequest = request;
    try {
      final status = await widget.repository.mediaStatus();
      if (!mounted ||
          generation != _mediaStatusGeneration ||
          !identical(auth, _auth)) {
        return;
      }
      setState(() => _mediaStatus = status);
      if (!status.active) _stopMediaPolling();
    } catch (error) {
      if (!mounted ||
          generation != _mediaStatusGeneration ||
          !identical(auth, _auth)) {
        return;
      }
      _stopMediaPolling();
      setState(() => _error = 'Media sync failed: $error');
    } finally {
      if (identical(_mediaStatusRequest, request)) {
        _mediaStatusRequest = null;
      }
    }
  }

  Future<void> _abortSync() async {
    try {
      await widget.repository.abortCollectionSync();
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = 'Collection sync cancelled.';
      });
    } catch (error) {
      if (mounted) setState(() => _error = 'Could not cancel sync: $error');
    }
  }

  Future<void> _abortMedia() async {
    try {
      await widget.repository.abortMediaSync();
      _stopMediaPolling();
      await _refreshMediaStatus();
      if (mounted) setState(() => _status = 'Media sync cancelled.');
    } catch (error) {
      if (mounted) setState(() => _error = 'Could not cancel media sync: $error');
    }
  }

  Future<void> _setCertificate() async {
    final controller = TextEditingController();
    try {
      final pem = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Custom sync certificate'),
          content: SizedBox(
            width: 560,
            child: TextField(
              controller: controller,
              minLines: 8,
              maxLines: 18,
              style: const TextStyle(fontFamily: 'monospace'),
              decoration: const InputDecoration(
                labelText: 'PEM certificate',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Apply'),
            ),
          ],
        ),
      );
      if (pem == null || pem.isEmpty) return;
      final accepted = await widget.repository.setCustomCertificate(pem);
      if (!mounted) return;
      setState(() {
        _status = accepted
            ? 'Custom sync certificate installed.'
            : 'The custom certificate was not accepted.';
      });
    } catch (error) {
      if (mounted) setState(() => _error = 'Could not set certificate: $error');
    } finally {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _stopMediaPolling();
    _usernameController.dispose();
    _passwordController.dispose();
    _endpointController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync'),
        actions: [
          if (_auth != null)
            IconButton(
              tooltip: 'Sign out',
              onPressed: _busy ? null : _logout,
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _auth == null
            ? _buildLogin()
            : _buildSync(),
      ),
    );
  }

  Widget _buildLogin() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('AnkiWeb', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text(
          'Your password is sent only to Anki’s sync login operation. '
          'AnkiFlutter stores the returned host key, not the password.',
        ),
        const SizedBox(height: 20),
        TextField(
          key: const ValueKey('sync-username'),
          controller: _usernameController,
          enabled: !_busy,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.username],
          decoration: const InputDecoration(
            labelText: 'AnkiWeb email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const ValueKey('sync-password'),
          controller: _passwordController,
          enabled: !_busy,
          obscureText: true,
          autofillHints: const [AutofillHints.password],
          onSubmitted: (_) => _login(),
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _endpointController,
          enabled: !_busy,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'Custom sync endpoint (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          key: const ValueKey('sync-login'),
          onPressed: _busy ? null : _login,
          icon: const Icon(Icons.login),
          label: const Text('Sign in'),
        ),
        _messageArea(),
      ],
    );
  }

  Widget _buildSync() {
    final media = _mediaStatus;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('AnkiWeb sync', style: Theme.of(context).textTheme.headlineSmall),
        if (_auth case final auth?)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              auth.hasEndpoint() && auth.endpoint.isNotEmpty
                  ? auth.endpoint
                  : 'Official AnkiWeb endpoint',
            ),
          ),
        _messageArea(),
        const SizedBox(height: 16),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Sync media'),
          subtitle: const Text('Upload/download images, audio, and other collection media.'),
          value: _syncMedia,
          onChanged: _busy ? null : (value) => setState(() => _syncMedia = value),
        ),
        FilledButton.icon(
          key: const ValueKey('sync-now'),
          onPressed: _busy ? null : _sync,
          icon: const Icon(Icons.sync),
          label: const Text('Sync now'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _busy ? null : _refreshStatus,
          icon: const Icon(Icons.info_outline),
          label: const Text('Check sync status'),
        ),
        if (_busy) ...[
          const SizedBox(height: 12),
          const LinearProgressIndicator(),
          TextButton.icon(
            onPressed: _abortSync,
            icon: const Icon(Icons.stop_circle_outlined),
            label: const Text('Cancel collection sync'),
          ),
        ],
        const Divider(height: 36),
        Text('Media', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        if (media != null)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(media.active ? 'Media sync active' : 'Media sync idle'),
                  if (media.hasProgress()) ...[
                    const SizedBox(height: 6),
                    Text('Checked: ${media.progress.checked}'),
                    Text('Added: ${media.progress.added}'),
                    Text('Removed: ${media.progress.removed}'),
                  ],
                ],
              ),
            ),
          ),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: _busy ? null : _syncMediaOnly,
              icon: const Icon(Icons.perm_media_outlined),
              label: const Text('Sync media only'),
            ),
            if (media?.active == true)
              TextButton.icon(
                onPressed: _abortMedia,
                icon: const Icon(Icons.stop_circle_outlined),
                label: const Text('Cancel media sync'),
              ),
          ],
        ),
        const Divider(height: 36),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: const Text('Advanced sync settings'),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.security_outlined),
              title: const Text('Custom TLS certificate'),
              subtitle: const Text('For self-hosted sync servers using a custom CA/certificate.'),
              onTap: _busy ? null : _setCertificate,
            ),
          ],
        ),
      ],
    );
  }

  Widget _messageArea() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_status case final status?) ...[
            const SizedBox(height: 16),
            Text(status),
          ],
          if (_error case final error?) ...[
            const SizedBox(height: 16),
            Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      );
}
