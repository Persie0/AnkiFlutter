import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/notetypes/data/anki_notetype_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

class NotetypeEditorPage extends StatefulWidget {
  const NotetypeEditorPage({
    required this.notetypeId,
    required this.useCount,
    required this.repository,
    super.key,
  });

  final int notetypeId;
  final int useCount;
  final NotetypeRepository repository;

  @override
  State<NotetypeEditorPage> createState() => _NotetypeEditorPageState();
}

class _NotetypeEditorPageState extends State<NotetypeEditorPage> {
  notetypes.Notetype? _draft;
  bool _loading = true;
  bool _saving = false;
  String? _error;
  int _identityCounter = 0;

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
      final notetype = await widget.repository.getNotetype(widget.notetypeId);
      if (!mounted) return;
      setState(() {
        _draft = notetype.deepCopy();
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not load note type: $error';
      });
    }
  }

  Future<void> _save() async {
    final draft = _draft;
    if (draft == null || _saving) return;
    final validationError = _validate(draft);
    if (validationError != null) {
      setState(() => _error = validationError);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.repository.updateNotetype(draft);
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = 'Could not save note type: $error';
      });
    }
  }

  String? _validate(notetypes.Notetype draft) {
    if (draft.name.trim().isEmpty) return 'Enter a note type name.';
    if (draft.fields.isEmpty) return 'A note type needs at least one field.';

    final fieldNames = <String>{};
    for (final field in draft.fields) {
      final name = field.name.trim();
      if (name.isEmpty) return 'Field names cannot be empty.';
      if (!fieldNames.add(name.toLowerCase())) {
        return 'Field names must be unique.';
      }
    }

    final isCloze =
        draft.config.kind == notetypes.Notetype_Config_Kind.KIND_CLOZE;
    if (!isCloze && draft.templates.isEmpty) {
      return 'A normal note type needs at least one card template.';
    }

    final templateNames = <String>{};
    for (final template in draft.templates) {
      final name = template.name.trim();
      if (name.isEmpty) return 'Template names cannot be empty.';
      if (!templateNames.add(name.toLowerCase())) {
        return 'Template names must be unique.';
      }
      if (template.config.qFormat.trim().isEmpty) {
        return 'Each card template needs a front template.';
      }
      if (template.config.aFormat.trim().isEmpty) {
        return 'Each card template needs a back template.';
      }
    }
    return null;
  }

  Future<String?> _promptName({
    required String title,
    required String label,
  }) async {
    final controller = TextEditingController();
    try {
      return await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: TextField(
            key: ValueKey('notetype-name-prompt-$label'),
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(labelText: label),
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
              child: const Text('Add'),
            ),
          ],
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  Future<void> _addField() async {
    final draft = _draft;
    if (draft == null) return;
    final name = await _promptName(title: 'Add field', label: 'Field name');
    if (!mounted || name == null) return;
    if (draft.fields.any(
      (field) => field.name.trim().toLowerCase() == name.toLowerCase(),
    )) {
      setState(() => _error = 'Field names must be unique.');
      return;
    }
    setState(() {
      draft.fields.add(
        notetypes.Notetype_Field(
          name: name,
          config: notetypes.Notetype_Field_Config(
            id: _newIdentity(),
            fontName: 'Arial',
            fontSize: 20,
          ),
        ),
      );
      _error = null;
    });
  }

  Future<void> _addTemplate() async {
    final draft = _draft;
    if (draft == null ||
        draft.config.kind == notetypes.Notetype_Config_Kind.KIND_CLOZE) {
      return;
    }
    final name = await _promptName(
      title: 'Add card template',
      label: 'Template name',
    );
    if (!mounted || name == null) return;
    if (draft.templates.any(
      (template) => template.name.trim().toLowerCase() == name.toLowerCase(),
    )) {
      setState(() => _error = 'Template names must be unique.');
      return;
    }

    final frontField = draft.fields.first.name;
    final backField = draft.fields.length > 1 ? draft.fields[1].name : frontField;
    setState(() {
      draft.templates.add(
        notetypes.Notetype_Template(
          name: name,
          config: notetypes.Notetype_Template_Config(
            id: _newIdentity(),
            qFormat: '{{$frontField}}',
            aFormat: '{{FrontSide}}\n\n<hr id=answer>\n\n{{$backField}}',
          ),
        ),
      );
      _error = null;
    });
  }

  Int64 _newIdentity() {
    _identityCounter += 1;
    return Int64(DateTime.now().microsecondsSinceEpoch + _identityCounter);
  }

  Future<bool> _confirmDestructive(String title, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Remove'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _removeField(int index) async {
    final draft = _draft;
    if (draft == null || draft.fields.length <= 1) return;
    final field = draft.fields[index];
    if (field.hasConfig() && field.config.preventDeletion) return;
    final confirmed = await _confirmDestructive(
      'Remove field?',
      'Removing “${field.name}” will discard that field from ${widget.useCount} '
          '${widget.useCount == 1 ? 'note' : 'notes'} when you save.',
    );
    if (confirmed && mounted) {
      setState(() => draft.fields.removeAt(index));
    }
  }

  Future<void> _removeTemplate(int index) async {
    final draft = _draft;
    if (draft == null || draft.templates.length <= 1) return;
    if (draft.config.kind == notetypes.Notetype_Config_Kind.KIND_CLOZE) return;
    final template = draft.templates[index];
    final confirmed = await _confirmDestructive(
      'Remove card template?',
      'Removing “${template.name}” can remove cards generated from this '
          'template for ${widget.useCount} ${widget.useCount == 1 ? 'note' : 'notes'} '
          'when you save.',
    );
    if (confirmed && mounted) {
      setState(() => draft.templates.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = _draft;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit note type'),
        actions: [
          IconButton(
            key: const ValueKey('save-notetype'),
            tooltip: 'Save note type',
            onPressed: draft == null || _saving ? null : _save,
            icon: _saving
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    final draft = _draft;
    if (draft == null) {
      return _ErrorPane(message: _error ?? 'Could not load note type.', onRetry: _load);
    }

    final isCloze =
        draft.config.kind == notetypes.Notetype_Config_Kind.KIND_CLOZE;
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error case final error?) ...[
                  MaterialBanner(
                    key: const ValueKey('notetype-editor-error'),
                    content: Text(error),
                    actions: [
                      TextButton(
                        onPressed: () => setState(() => _error = null),
                        child: const Text('Dismiss'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  key: const ValueKey('notetype-name'),
                  controller: TextEditingController(text: draft.name)
                    ..selection = TextSelection.collapsed(offset: draft.name.length),
                  decoration: const InputDecoration(
                    labelText: 'Note type name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => draft.name = value,
                ),
                const SizedBox(height: 24),
                _SectionHeader(
                  title: 'Fields',
                  actionLabel: 'Add field',
                  onPressed: _addField,
                ),
                const SizedBox(height: 8),
                for (var index = 0; index < draft.fields.length; index++)
                  _FieldEditor(
                    key: ValueKey('field-editor-$index'),
                    field: draft.fields[index],
                    canRemove: draft.fields.length > 1 &&
                        !(draft.fields[index].hasConfig() &&
                            draft.fields[index].config.preventDeletion),
                    onRemove: () => _removeField(index),
                  ),
                const SizedBox(height: 24),
                _SectionHeader(
                  title: 'Card templates',
                  actionLabel: isCloze ? null : 'Add template',
                  onPressed: isCloze ? null : _addTemplate,
                ),
                if (isCloze)
                  const Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 8),
                    child: Text('Cloze note types use a single card template.'),
                  ),
                const SizedBox(height: 8),
                for (var index = 0; index < draft.templates.length; index++)
                  _TemplateEditor(
                    key: ValueKey('template-editor-$index'),
                    template: draft.templates[index],
                    canRemove: !isCloze && draft.templates.length > 1,
                    onRemove: () => _removeTemplate(index),
                  ),
                const SizedBox(height: 24),
                Text('Styling', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                TextField(
                  key: const ValueKey('notetype-css'),
                  controller: TextEditingController(text: draft.config.css),
                  minLines: 8,
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(fontFamily: 'monospace'),
                  decoration: const InputDecoration(
                    labelText: 'CSS',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => draft.ensureConfig().css = value,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onPressed,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
        if (actionLabel case final label?)
          TextButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.add),
            label: Text(label),
          ),
      ],
    );
  }
}

class _FieldEditor extends StatelessWidget {
  const _FieldEditor({
    required this.field,
    required this.canRemove,
    required this.onRemove,
    super.key,
  });

  final notetypes.Notetype_Field field;
  final bool canRemove;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: field.name,
                decoration: const InputDecoration(labelText: 'Field name'),
                onChanged: (value) => field.name = value,
              ),
            ),
            IconButton(
              tooltip: canRemove ? 'Remove field' : 'This field cannot be removed',
              onPressed: canRemove ? onRemove : null,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemplateEditor extends StatelessWidget {
  const _TemplateEditor({
    required this.template,
    required this.canRemove,
    required this.onRemove,
    super.key,
  });

  final notetypes.Notetype_Template template;
  final bool canRemove;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: TextFormField(
          initialValue: template.name,
          decoration: const InputDecoration(labelText: 'Template name'),
          onChanged: (value) => template.name = value,
        ),
        trailing: IconButton(
          tooltip: canRemove ? 'Remove card template' : 'Template cannot be removed',
          onPressed: canRemove ? onRemove : null,
          icon: const Icon(Icons.delete_outline),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          TextFormField(
            key: const ValueKey('template-front'),
            initialValue: template.config.qFormat,
            minLines: 4,
            maxLines: 12,
            style: const TextStyle(fontFamily: 'monospace'),
            decoration: const InputDecoration(
              labelText: 'Front template',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => template.ensureConfig().qFormat = value,
          ),
          const SizedBox(height: 12),
          TextFormField(
            key: const ValueKey('template-back'),
            initialValue: template.config.aFormat,
            minLines: 4,
            maxLines: 12,
            style: const TextStyle(fontFamily: 'monospace'),
            decoration: const InputDecoration(
              labelText: 'Back template',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => template.ensureConfig().aFormat = value,
          ),
        ],
      ),
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
