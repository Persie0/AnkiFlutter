import 'package:anki_flutter/core/backend/generated/anki/import_export.pb.dart'
    as import_export;
import 'package:anki_flutter/features/import_export/data/anki_package_repository.dart';
import 'package:anki_flutter/features/import_export/native_package_file_transfer.dart';
import 'package:flutter/material.dart';

class PackageTransferPage extends StatefulWidget {
  const PackageTransferPage({
    required this.repository,
    required this.fileTransfer,
    this.onCollectionChanged,
    super.key,
  });

  final PackageRepository repository;
  final PackageFileTransfer fileTransfer;
  final Future<void> Function()? onCollectionChanged;

  @override
  State<PackageTransferPage> createState() => _PackageTransferPageState();
}

class _PackageTransferPageState extends State<PackageTransferPage> {
  import_export.ImportAnkiPackageOptions? _importOptions;
  List<PackageExportDeck> _exportDecks = const [];
  String? _deckListError;
  int _exportDeckId = 0; // 0 = whole collection; real Anki deck IDs are >0.
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
      List<PackageExportDeck> decks = const [];
      String? deckListError;
      if (widget.repository is DeckScopedPackageRepository &&
          widget.fileTransfer is DeckScopedPackageFileTransfer) {
        try {
          decks = await (widget.repository as DeckScopedPackageRepository)
              .exportDeckTargets();
        } catch (error) {
          // Exporting the complete collection must remain usable if deck
          // metadata cannot be retrieved.
          deckListError = 'Could not list decks for export: $error';
        }
      }
      if (!mounted) return;
      setState(() {
        _importOptions = presets.deepCopy();
        _exportDecks = decks;
        _deckListError = deckListError;
        if (!decks.any((deck) => deck.id == _exportDeckId)) {
          _exportDeckId = 0;
        }
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

    // Lock before opening the native picker to prevent multiple concurrent
    // dialogs or imports against the same Anki collection.
    String? path;
    setState(() {
      _busy = true;
      _error = null;
      _status = 'Choosing package…';
    });
    try {
      path = await widget.fileTransfer.pickImportPackage();
      if (!mounted) return;
      if (path == null) {
        setState(() {
          _busy = false;
          _status = null;
        });
        return;
      }
      setState(() => _status = 'Importing package…');
      final response = await widget.repository.importPackage(
        path,
        options.deepCopy(),
      );
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
    } finally {
      // Only the file-transfer adapter knows whether it created a temporary
      // byte-backed copy. Never remove a user-selected local package.
      if (path != null &&
          widget.fileTransfer is TemporaryPackageImportCleanup) {
        try {
          await (widget.fileTransfer as TemporaryPackageImportCleanup)
              .releasePickedPackage(path);
        } catch (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not clean temporary package: $error')),
            );
          }
        }
      }
    }
  }

  Future<void> _exportPackage() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
      _status = 'Exporting package…';
    });
    try {
      final selectedDeckId = _exportDeckId;
      final result = selectedDeckId != 0 &&
              widget.repository is DeckScopedPackageRepository &&
              widget.fileTransfer is DeckScopedPackageFileTransfer
          ? await (widget.fileTransfer as DeckScopedPackageFileTransfer)
                .exportDeckPackage(
                  widget.repository as DeckScopedPackageRepository,
                  deckId: selectedDeckId,
                  withScheduling: _exportWithScheduling,
                  withDeckConfigs: _exportWithDeckConfigs,
                  withMedia: _exportWithMedia,
                  legacy: _exportLegacy,
                )
          : await widget.fileTransfer.exportPackage(
              widget.repository,
              withScheduling: _exportWithScheduling,
              withDeckConfigs: _exportWithDeckConfigs,
              withMedia: _exportWithMedia,
              legacy: _exportLegacy,
            );
      if (!mounted) return;
      if (result == null) {
        setState(() {
          _busy = false;
          _status = null;
        });
        return;
      }
      final selectedDeckName = selectedDeckId == 0
          ? null
          : _exportDecks
              .where((deck) => deck.id == selectedDeckId)
              .map((deck) => deck.name)
              .firstOrNull;
      setState(() {
        _busy = false;
        final prefix = selectedDeckName == null
            ? 'Export complete'
            : 'Export complete ($selectedDeckName)';
        _status = _exportWithMedia
            ? '$prefix: ${result.mediaFiles} media '
                '${result.mediaFiles == 1 ? 'file' : 'files'} included.'
            : '$prefix.';
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

  void _updateImport(
    void Function(import_export.ImportAnkiPackageOptions) update,
  ) {
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
              FilledButton.tonal(
                onPressed: _loadPresets,
                child: const Text('Retry'),
              ),
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
        const Text(
          'Import decks, notes, scheduling data, deck options, and media '
          'using Anki’s native importer.',
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Merge compatible note types'),
          value: options.mergeNotetypes,
          onChanged: _busy
              ? null
              : (value) => _updateImport(
                    (valueOptions) => valueOptions.mergeNotetypes = value,
                  ),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Import scheduling'),
          value: options.withScheduling,
          onChanged: _busy
              ? null
              : (value) => _updateImport(
                    (valueOptions) => valueOptions.withScheduling = value,
                  ),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Import deck options'),
          value: options.withDeckConfigs,
          onChanged: _busy
              ? null
              : (value) => _updateImport(
                    (valueOptions) => valueOptions.withDeckConfigs = value,
                  ),
        ),
        _UpdateConditionTile(
          title: 'Existing notes',
          value: options.updateNotes,
          enabled: !_busy,
          onChanged: (value) => _updateImport(
            (valueOptions) => valueOptions.updateNotes = value,
          ),
        ),
        _UpdateConditionTile(
          title: 'Existing note types',
          value: options.updateNotetypes,
          enabled: !_busy,
          onChanged: (value) => _updateImport(
            (valueOptions) => valueOptions.updateNotetypes = value,
          ),
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
        const Text(
          'Export the whole open collection or a selected deck as a '
          'standard Anki package.',
        ),
        const SizedBox(height: 12),
        if (_deckListError case final error?) ...[
          Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          const Text('Whole-collection export is still available.'),
          const SizedBox(height: 12),
        ],
        if (_exportDecks.isNotEmpty) ...[
          InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Export scope',
              border: OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                key: const ValueKey('export-scope-dropdown'),
                isExpanded: true,
                value: _exportDeckId,
                items: [
                  const DropdownMenuItem<int>(
                    value: 0,
                    child: Text('Whole collection'),
                  ),
                  ..._exportDecks.map(
                    (deck) => DropdownMenuItem<int>(
                      value: deck.id,
                      child: Text(deck.name, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
                onChanged: _busy
                    ? null
                    : (deckId) => setState(() => _exportDeckId = deckId ?? 0),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Include scheduling'),
          value: _exportWithScheduling,
          onChanged: _busy
              ? null
              : (value) => setState(() => _exportWithScheduling = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Include deck options'),
          value: _exportWithDeckConfigs,
          onChanged: _busy
              ? null
              : (value) => setState(() => _exportWithDeckConfigs = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Include media'),
          value: _exportWithMedia,
          onChanged: _busy
              ? null
              : (value) => setState(() => _exportWithMedia = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Legacy package format'),
          subtitle: const Text('Use only when importing into older Anki versions.'),
          value: _exportLegacy,
          onChanged: _busy
              ? null
              : (value) => setState(() => _exportLegacy = value),
        ),
        const SizedBox(height: 8),
        FilledButton.tonalIcon(
          key: const ValueKey('export-apkg'),
          onPressed: _busy ? null : _exportPackage,
          icon: const Icon(Icons.file_upload_outlined),
          label: const Text('Export package'),
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
        onChanged: enabled
            ? (next) {
                if (next != null) onChanged(next);
              }
            : null,
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

String _conditionLabel(
  import_export.ImportAnkiPackageUpdateCondition condition,
) {
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
