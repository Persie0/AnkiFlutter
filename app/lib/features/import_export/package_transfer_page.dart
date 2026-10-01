import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:flutter/material.dart';

typedef PackagePathPicker = Future<String?> Function();

class PackageTransferPage extends StatefulWidget {
  const PackageTransferPage({
    required this.repository,
    required this.pickImportPath,
    required this.pickExportPath,
    this.onCollectionChanged,
    super.key,
  });

  final PackageRepository repository;
  final PackagePathPicker pickImportPath;
  final PackagePathPicker pickExportPath;
  final Future<void> Function()? onCollectionChanged;

  @override
  State<PackageTransferPage> createState() => _PackageTransferPageState();
}

class _PackageTransferPageState extends State<PackageTransferPage> {
  import_export.ImportAnkiPackageOptions? _importOptions;
  bool _loading = true;
  bool _busy = false;
  bool _exportWithScheduling = true;
  bool _exportWithDeckConfigs = true;
  bool _exportWithMedia = true;
  bool _exportLegacy = false;
  String? _status;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPresets();
  }

  Future<void> _loadPresets() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final presets = await widget.repository.getImportPresets();
      if (!mounted) return;
      setState(() {
        _importOptions = presets.deepCopy();
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not load Anki import settings: $error';
      });
    }
  }

  Future<void> _importPackage() async {
    final options = _importOptions;
    if (_busy || options == null) return;
    final path = await widget.pickImportPath();
    if (!mounted || path == null) return;

    setState(() {
      _busy = true;
      _error = null;
      _status = 'Importing package…';
    });
    try {
      final response = await widget.repository.importPackage(path, options.deepCopy());
      await widget.onCollectionChanged?.call();
      if (!mounted) return;
      final log = response.log;
      setState(() {
        _busy = false;
        _status = 'Import complete: ${log.foundNotes} found, '
            '${log.new_1.length} new, ${log.updated.length} updated, '
            '${log.duplicate.length} duplicate, ${log.conflicting.length} conflicting.';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = null;
        _error = 'Could not import package: $error';
      });
    }
  }

  Future<void> _exportPackage() async {
    if (_busy) return;
    final path = await widget.pickExportPath();
    if (!mounted || path == null) return;

    setState(() {
      _busy = true;
      _error = null;
      _status = 'Exporting package…';
    });
    try {
      final mediaFiles = await widget.repository.exportPackage(
        path,
        withScheduling: _exportWithScheduling,
        withDeckConfigs: _exportWithDeckConfigs,
        withMedia: _exportWithMedia,
        legacy: _exportLegacy,
      );
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = _exportWithMedia
            ? 'Export complete: $mediaFiles media ${mediaFiles == 1 ? 'file' : 'files'} written.'
            : 'Export complete.';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _status = null;
        _error = 'Could not export package: $error';
      });
    }
  }

  void _updateImport(void Function(import_export.ImportAnkiPackageOptions) update) {
    final options = _importOptions;
    if (options == null) return;
    setState(() => update(options));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import & export')),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final options = _importOptions;
    if (options == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_error ?? 'Anki import settings are unavailable.'),
              const SizedBox(height: 12),
              FilledButton.tonal(onPressed: _loadPresets, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_error case final error?)
          MaterialBanner(
            key: const ValueKey('package-transfer-error'),
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => setState(() => _error = null),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        if (_status case final status?) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_busy)
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.check_circle_outline),
                    ),
                  Expanded(child: Text(status)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Text('Import .apkg', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        const Text('Import decks, notes, scheduling data, deck options, and media using Anki’s native importer.'),
        const SizedBox(height: 12),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Merge compatible note types'),
          value: options.mergeNotetypes,
          onChanged: _busy
              ? null
              : (value) => _updateImport((valueOptions) => valueOptions.mergeNotetypes = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Import scheduling'),
          value: options.withScheduling,
          onChanged: _busy
              ? null
              : (value) => _updateImport((valueOptions) => valueOptions.withScheduling = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Import deck options'),
          value: options.withDeckConfigs,
          onChanged: _busy
              ? null
              : (value) => _updateImport((valueOptions) => valueOptions.withDeckConfigs = value),
        ),
        _UpdateConditionTile(
          title: 'Existing notes',
          value: options.updateNotes,
          enabled: !_busy,
          onChanged: (value) => _updateImport((valueOptions) => valueOptions.updateNotes = value),
        ),
        _UpdateConditionTile(
          title: 'Existing note types',
          value: options.updateNotetypes,
          enabled: !_busy,
          onChanged: (value) => _updateImport((valueOptions) => valueOptions.updateNotetypes = value),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          key: const ValueKey('import-apkg'),
          onPressed: _busy ? null : _importPackage,
          icon: const Icon(Icons.file_download_outlined),
          label: const Text('Choose .apkg to import'),
        ),
        const SizedBox(height: 32),
        const Divider(),
        const SizedBox(height: 20),
        Text('Export .apkg', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        const Text('Export the whole open collection as a standard Anki package.'),
        const SizedBox(height: 12),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Include scheduling'),
          value: _exportWithScheduling,
          onChanged: _busy ? null : (value) => setState(() => _exportWithScheduling = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Include deck options'),
          value: _exportWithDeckConfigs,
          onChanged: _busy ? null : (value) => setState(() => _exportWithDeckConfigs = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Include media'),
          value: _exportWithMedia,
          onChanged: _busy ? null : (value) => setState(() => _exportWithMedia = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Legacy package format'),
          subtitle: const Text('Use only when importing into older Anki versions.'),
          value: _exportLegacy,
          onChanged: _busy ? null : (value) => setState(() => _exportLegacy = value),
        ),
        const SizedBox(height: 8),
        FilledButton.tonalIcon(
          key: const ValueKey('export-apkg'),
          onPressed: _busy ? null : _exportPackage,
          icon: const Icon(Icons.file_upload_outlined),
          label: const Text('Choose export location'),
        ),
      ],
    );
  }
}

class _UpdateConditionTile extends StatelessWidget {
  const _UpdateConditionTile({
    required this.title,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final String title;
  final import_export.ImportAnkiPackageUpdateCondition value;
  final bool enabled;
  final ValueChanged<import_export.ImportAnkiPackageUpdateCondition> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: DropdownButton<import_export.ImportAnkiPackageUpdateCondition>(
        value: value,
        onChanged: enabled ? (next) { if (next != null) onChanged(next); } : null,
        items: import_export.ImportAnkiPackageUpdateCondition.values
            .map(
              (condition) => DropdownMenuItem(
                value: condition,
                child: Text(_conditionLabel(condition)),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

String _conditionLabel(import_export.ImportAnkiPackageUpdateCondition condition) {
  if (condition ==
      import_export.ImportAnkiPackageUpdateCondition
          .IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_ALWAYS) {
    return 'Always';
  }
  if (condition ==
      import_export.ImportAnkiPackageUpdateCondition
          .IMPORT_ANKI_PACKAGE_UPDATE_CONDITION_NEVER) {
    return 'Never';
  }
  return 'If newer';
}
