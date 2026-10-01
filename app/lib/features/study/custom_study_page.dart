import 'package:anki_flutter/core/backend/generated/anki/scheduler.pb.dart' as scheduler;
import 'package:anki_flutter/features/study/data/anki_custom_study_repository.dart';
import 'package:flutter/material.dart';

class CustomStudyPage extends StatefulWidget {
  const CustomStudyPage({
    required this.deckId,
    required this.deckName,
    required this.repository,
    this.onChanged,
    super.key,
  });

  final int deckId;
  final String deckName;
  final CustomStudyRepository repository;
  final Future<void> Function()? onChanged;

  @override
  State<CustomStudyPage> createState() => _CustomStudyPageState();
}

class _CustomStudyPageState extends State<CustomStudyPage> {
  scheduler.CustomStudyDefaultsResponse? _defaults;
  bool _loading = true;
  bool _busy = false;
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
      final defaults = await widget.repository.defaults(widget.deckId);
      if (!mounted) return;
      setState(() {
        _defaults = defaults;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not load custom study options: $error';
      });
    }
  }

  Future<void> _run(
    Future<void> Function() action, {
    required String success,
    bool refreshDefaults = true,
  }) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      await widget.onChanged?.call();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success)));
      if (refreshDefaults) {
        final defaults = await widget.repository.defaults(widget.deckId);
        if (!mounted) return;
        setState(() {
          _defaults = defaults;
          _busy = false;
        });
      } else {
        setState(() => _busy = false);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Custom study failed: $error';
      });
    }
  }

  Future<int?> _numberDialog({
    required String title,
    required String label,
    required int initialValue,
    int min = 0,
  }) async {
    final controller = TextEditingController(text: '$initialValue');
    try {
      return await showDialog<int>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: label),
            onSubmitted: (_) => _submitNumber(context, controller, min),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => _submitNumber(context, controller, min),
              child: const Text('Apply'),
            ),
          ],
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  void _submitNumber(
    BuildContext context,
    TextEditingController controller,
    int min,
  ) {
    final value = int.tryParse(controller.text.trim());
    if (value != null && value >= min) {
      Navigator.of(context).pop(value);
    }
  }

  Future<void> _extendNew() async {
    final defaults = _defaults;
    if (defaults == null) return;
    final count = await _numberDialog(
      title: 'Increase today’s new-card limit',
      label: 'Extra new cards',
      initialValue: defaults.extendNew,
    );
    if (count == null) return;
    await _run(
      () => widget.repository.extendNew(widget.deckId, count),
      success: 'New-card limit increased by $count.',
    );
  }

  Future<void> _extendReview() async {
    final defaults = _defaults;
    if (defaults == null) return;
    final count = await _numberDialog(
      title: 'Increase today’s review limit',
      label: 'Extra review cards',
      initialValue: defaults.extendReview,
    );
    if (count == null) return;
    await _run(
      () => widget.repository.extendReview(widget.deckId, count),
      success: 'Review limit increased by $count.',
    );
  }

  Future<void> _forgotten() async {
    final days = await _numberDialog(
      title: 'Review forgotten cards',
      label: 'Forgotten within the last N days',
      initialValue: 1,
      min: 1,
    );
    if (days == null) return;
    await _run(
      () => widget.repository.reviewForgotten(widget.deckId, days),
      success: 'Custom Study Session created.',
      refreshDefaults: false,
    );
  }

  Future<void> _ahead() async {
    final days = await _numberDialog(
      title: 'Review ahead',
      label: 'Days ahead',
      initialValue: 1,
      min: 1,
    );
    if (days == null) return;
    await _run(
      () => widget.repository.reviewAhead(widget.deckId, days),
      success: 'Custom Study Session created.',
      refreshDefaults: false,
    );
  }

  Future<void> _preview() async {
    final days = await _numberDialog(
      title: 'Preview recent new cards',
      label: 'Added within the last N days',
      initialValue: 1,
      min: 1,
    );
    if (days == null) return;
    await _run(
      () => widget.repository.previewRecentNew(widget.deckId, days),
      success: 'Custom Study Session created.',
      refreshDefaults: false,
    );
  }

  Future<void> _cram() async {
    final request = await showDialog<_CramSelection>(
      context: context,
      builder: (_) => _CramDialog(defaults: _defaults!),
    );
    if (request == null) return;
    await _run(
      () => widget.repository.cram(
        widget.deckId,
        kind: request.kind,
        cardLimit: request.cardLimit,
        tagsToInclude: request.tagsToInclude,
        tagsToExclude: request.tagsToExclude,
      ),
      success: 'Custom Study Session created.',
      refreshDefaults: false,
    );
  }

  Future<void> _unbury() async {
    await _run(
      () => widget.repository.unburyAll(widget.deckId),
      success: 'Buried cards restored.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom study · ${widget.deckName}')),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final defaults = _defaults;
    if (defaults == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error ?? 'Custom study options are unavailable.'),
            const SizedBox(height: 12),
            FilledButton.tonal(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }

    final availableNew = defaults.availableNew + defaults.availableNewInChildren;
    final availableReview =
        defaults.availableReview + defaults.availableReviewInChildren;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_error case final error?)
          MaterialBanner(
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => setState(() => _error = null),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                Text('$availableNew new available'),
                Text('$availableReview reviews available'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _ActionTile(
          icon: Icons.add_circle_outline,
          title: 'Increase new-card limit',
          subtitle: 'Study more new cards today.',
          onTap: _busy ? null : _extendNew,
        ),
        _ActionTile(
          icon: Icons.add_chart,
          title: 'Increase review limit',
          subtitle: 'Study more due reviews today.',
          onTap: _busy ? null : _extendReview,
        ),
        _ActionTile(
          icon: Icons.history,
          title: 'Review forgotten cards',
          subtitle: 'Create a filtered deck from recent lapses.',
          onTap: _busy ? null : _forgotten,
        ),
        _ActionTile(
          icon: Icons.fast_forward,
          title: 'Review ahead',
          subtitle: 'Review cards due in the next N days.',
          onTap: _busy ? null : _ahead,
        ),
        _ActionTile(
          icon: Icons.preview_outlined,
          title: 'Preview recent new cards',
          subtitle: 'Preview cards added in the last N days without normal scheduling.',
          onTap: _busy ? null : _preview,
        ),
        _ActionTile(
          key: const ValueKey('custom-study-cram'),
          icon: Icons.filter_alt_outlined,
          title: 'Cram / filtered study',
          subtitle: 'Choose card type, limit, and optional include/exclude tags.',
          onTap: _busy ? null : _cram,
        ),
        const Divider(height: 32),
        _ActionTile(
          icon: Icons.unarchive_outlined,
          title: 'Unbury cards',
          subtitle: 'Restore all scheduler- and user-buried cards in this deck.',
          onTap: _busy ? null : _unbury,
        ),
        if (_busy) ...[
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
        ],
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      enabled: onTap != null,
      onTap: onTap,
    );
  }
}

class _CramSelection {
  const _CramSelection({
    required this.kind,
    required this.cardLimit,
    required this.tagsToInclude,
    required this.tagsToExclude,
  });

  final scheduler.CustomStudyRequest_Cram_CramKind kind;
  final int cardLimit;
  final List<String> tagsToInclude;
  final List<String> tagsToExclude;
}

class _CramDialog extends StatefulWidget {
  const _CramDialog({required this.defaults});

  final scheduler.CustomStudyDefaultsResponse defaults;

  @override
  State<_CramDialog> createState() => _CramDialogState();
}

class _CramDialogState extends State<_CramDialog> {
  scheduler.CustomStudyRequest_Cram_CramKind _kind =
      scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_DUE;
  late final TextEditingController _limitController;
  final _includeController = TextEditingController();
  final _excludeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final suggested = widget.defaults.availableReview > 0
        ? widget.defaults.availableReview
        : 100;
    _limitController = TextEditingController(text: '$suggested');
  }

  @override
  void dispose() {
    _limitController.dispose();
    _includeController.dispose();
    _excludeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final knownTags = widget.defaults.tags.map((tag) => tag.name).toList();
    return AlertDialog(
      title: const Text('Cram / filtered study'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<scheduler.CustomStudyRequest_Cram_CramKind>(
                initialValue: _kind,
                decoration: const InputDecoration(labelText: 'Cards'),
                items: [
                  scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_DUE,
                  scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_NEW,
                  scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_REVIEW,
                  scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_ALL,
                ]
                    .map(
                      (kind) => DropdownMenuItem(
                        value: kind,
                        child: Text(_cramKindLabel(kind)),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (kind) {
                  if (kind != null) setState(() => _kind = kind);
                },
              ),
              TextField(
                controller: _limitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Maximum cards'),
              ),
              TextField(
                controller: _includeController,
                decoration: const InputDecoration(
                  labelText: 'Include tags (comma separated)',
                ),
              ),
              TextField(
                controller: _excludeController,
                decoration: const InputDecoration(
                  labelText: 'Exclude tags (comma separated)',
                ),
              ),
              if (knownTags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Available tags: ${knownTags.take(12).join(', ')}'
                  '${knownTags.length > 12 ? '…' : ''}',
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final limit = int.tryParse(_limitController.text.trim());
            if (limit == null || limit <= 0) return;
            Navigator.of(context).pop(
              _CramSelection(
                kind: _kind,
                cardLimit: limit,
                tagsToInclude: _splitTags(_includeController.text),
                tagsToExclude: _splitTags(_excludeController.text),
              ),
            );
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}

List<String> _splitTags(String value) => value
    .split(',')
    .map((tag) => tag.trim())
    .where((tag) => tag.isNotEmpty)
    .toSet()
    .toList(growable: false);

String _cramKindLabel(scheduler.CustomStudyRequest_Cram_CramKind kind) {
  if (kind == scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_NEW) {
    return 'New cards · added order';
  }
  if (kind == scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_REVIEW) {
    return 'Review cards · random order';
  }
  if (kind == scheduler.CustomStudyRequest_Cram_CramKind.CRAM_KIND_ALL) {
    return 'All cards · random, no rescheduling';
  }
  return 'Due cards · due order';
}
