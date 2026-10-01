import 'package:anki_flutter/core/backend/generated/anki/deck_config.pb.dart'
    as deck_config;
import 'package:anki_flutter/features/deck_options/data/anki_deck_options_repository.dart';
import 'package:flutter/material.dart';

class DeckOptionsPage extends StatefulWidget {
  const DeckOptionsPage({
    required this.deckId,
    required this.repository,
    this.onChanged,
    super.key,
  });

  final int deckId;
  final DeckOptionsRepository repository;
  final Future<void> Function()? onChanged;

  @override
  State<DeckOptionsPage> createState() => _DeckOptionsPageState();
}

class _DeckOptionsPageState extends State<DeckOptionsPage> {
  final _formKey = GlobalKey<FormState>();
  deck_config.DeckConfigsForUpdate? _snapshot;
  deck_config.DeckConfig? _draft;
  bool _loading = true;
  bool _saving = false;
  bool _fsrsReschedule = false;
  String? _error;
  String _learningSteps = '';
  String _relearningSteps = '';
  String _newPerDay = '';
  String _reviewsPerDay = '';
  String _maximumInterval = '';
  String _desiredRetention = '';
  String _leechThreshold = '';

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
      final snapshot = await widget.repository.load(widget.deckId);
      final selected = _selectedConfig(snapshot);
      if (!mounted) return;
      setState(() {
        _snapshot = snapshot;
        _loading = false;
      });
      _loadDraft(selected);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not load deck options: $error';
      });
    }
  }

  deck_config.DeckConfig _selectedConfig(
    deck_config.DeckConfigsForUpdate snapshot,
  ) {
    final id = snapshot.currentDeck.configId;
    for (final entry in snapshot.allConfig) {
      if (entry.config.id == id) return entry.config.deepCopy();
    }
    if (snapshot.allConfig.isNotEmpty) {
      return snapshot.allConfig.first.config.deepCopy();
    }
    return snapshot.defaults.deepCopy();
  }

  void _loadDraft(deck_config.DeckConfig config) {
    final options = config.ensureConfig();
    setState(() {
      _draft = config.deepCopy();
      _learningSteps = options.learnSteps.join(', ');
      _relearningSteps = options.relearnSteps.join(', ');
      _newPerDay = '${options.newPerDay}';
      _reviewsPerDay = '${options.reviewsPerDay}';
      _maximumInterval = '${options.maximumReviewInterval}';
      _desiredRetention = options.desiredRetention == 0
          ? '0.90'
          : options.desiredRetention.toStringAsFixed(2);
      _leechThreshold = '${options.leechThreshold}';
      _error = null;
    });
  }

  Future<void> _save() async {
    final snapshot = _snapshot;
    final draft = _draft;
    if (snapshot == null || draft == null || _saving) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final config = draft.ensureConfig();
    config
      ..learnSteps.clear()
      ..learnSteps.addAll(_parseSteps(_learningSteps))
      ..relearnSteps.clear()
      ..relearnSteps.addAll(_parseSteps(_relearningSteps))
      ..newPerDay = int.parse(_newPerDay)
      ..reviewsPerDay = int.parse(_reviewsPerDay)
      ..maximumReviewInterval = int.parse(_maximumInterval)
      ..desiredRetention = double.parse(_desiredRetention)
      ..leechThreshold = int.parse(_leechThreshold);

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.repository.save(
        widget.deckId,
        snapshot: snapshot,
        selectedConfig: draft,
        fsrsReschedule: _fsrsReschedule,
      );
      await widget.onChanged?.call();
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = 'Could not save deck options: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck options'),
        actions: [
          IconButton(
            key: const ValueKey('save-deck-options'),
            tooltip: 'Save deck options',
            onPressed: _draft == null || _saving ? null : _save,
            icon: _saving
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final snapshot = _snapshot;
    final draft = _draft;
    if (snapshot == null || draft == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error ?? 'Deck options are unavailable.'),
            const SizedBox(height: 12),
            FilledButton.tonal(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }

    final config = draft.ensureConfig();
    final selectedUseCount = snapshot.allConfig
        .where((entry) => entry.config.id == draft.id)
        .map((entry) => entry.useCount)
        .firstOrNull;

    return Form(
      key: _formKey,
      child: ListView(
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
          DropdownButtonFormField<String>(
            initialValue: draft.id.toString(),
            decoration: const InputDecoration(
              labelText: 'Options preset',
              border: OutlineInputBorder(),
            ),
            items: snapshot.allConfig
                .map(
                  (entry) => DropdownMenuItem(
                    value: entry.config.id.toString(),
                    child: Text('${entry.config.name} · ${entry.useCount} decks'),
                  ),
                )
                .toList(growable: false),
            onChanged: _saving
                ? null
                : (id) {
                    if (id == null) return;
                    final selected = snapshot.allConfig
                        .where((entry) => entry.config.id.toString() == id)
                        .firstOrNull;
                    if (selected != null) _loadDraft(selected.config);
                  },
          ),
          if ((selectedUseCount ?? 0) > 1)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'This preset is shared by $selectedUseCount decks; edits apply to all of them.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          const SizedBox(height: 24),
          _Section(title: 'Daily limits'),
          Row(
            children: [
              Expanded(
                child: _NumberField(
                  label: 'New cards / day',
                  value: _newPerDay,
                  onChanged: (value) => _newPerDay = value,
                  integer: true,
                  min: 0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumberField(
                  label: 'Reviews / day',
                  value: _reviewsPerDay,
                  onChanged: (value) => _reviewsPerDay = value,
                  integer: true,
                  min: 0,
                ),
              ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('New cards ignore review limit'),
            value: snapshot.newCardsIgnoreReviewLimit,
            onChanged: _saving
                ? null
                : (value) => setState(
                      () => snapshot.newCardsIgnoreReviewLimit = value,
                    ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Limits start from top-level deck'),
            value: snapshot.applyAllParentLimits,
            onChanged: _saving
                ? null
                : (value) => setState(() => snapshot.applyAllParentLimits = value),
          ),
          const SizedBox(height: 20),
          _Section(title: 'Learning'),
          TextFormField(
            initialValue: _learningSteps,
            decoration: const InputDecoration(
              labelText: 'Learning steps (minutes, comma separated)',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => _learningSteps = value,
            validator: _stepsValidator,
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: _relearningSteps,
            decoration: const InputDecoration(
              labelText: 'Relearning steps (minutes, comma separated)',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => _relearningSteps = value,
            validator: _stepsValidator,
          ),
          const SizedBox(height: 12),
          _NumberField(
            label: 'Maximum review interval (days)',
            value: _maximumInterval,
            onChanged: (value) => _maximumInterval = value,
            integer: true,
            min: 1,
          ),
          const SizedBox(height: 20),
          _Section(title: 'FSRS'),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Enable FSRS'),
            value: snapshot.fsrs,
            onChanged: _saving
                ? null
                : (value) => setState(() => snapshot.fsrs = value),
          ),
          if (snapshot.fsrs) ...[
            _NumberField(
              label: 'Desired retention',
              value: _desiredRetention,
              onChanged: (value) => _desiredRetention = value,
              min: 0.70,
              max: 0.99,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Reschedule cards when saving'),
              subtitle: const Text(
                'Recomputes existing due dates using the current FSRS settings.',
              ),
              value: _fsrsReschedule,
              onChanged: _saving
                  ? null
                  : (value) => setState(() => _fsrsReschedule = value),
            ),
          ],
          const SizedBox(height: 20),
          _Section(title: 'Ordering'),
          DropdownButtonFormField<deck_config.DeckConfig_Config_NewCardGatherPriority>(
            initialValue: config.newCardGatherPriority,
            decoration: const InputDecoration(labelText: 'New-card gather order'),
            items: deck_config.DeckConfig_Config_NewCardGatherPriority.values
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(_enumLabel(value.name, 'NEW_CARD_GATHER_PRIORITY_')),
                  ),
                )
                .toList(growable: false),
            onChanged: _saving
                ? null
                : (value) {
                    if (value != null) setState(() => config.newCardGatherPriority = value);
                  },
          ),
          DropdownButtonFormField<deck_config.DeckConfig_Config_NewCardSortOrder>(
            initialValue: config.newCardSortOrder,
            decoration: const InputDecoration(labelText: 'New-card sort order'),
            items: deck_config.DeckConfig_Config_NewCardSortOrder.values
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(_enumLabel(value.name, 'NEW_CARD_SORT_ORDER_')),
                  ),
                )
                .toList(growable: false),
            onChanged: _saving
                ? null
                : (value) {
                    if (value != null) setState(() => config.newCardSortOrder = value);
                  },
          ),
          DropdownButtonFormField<deck_config.DeckConfig_Config_ReviewCardOrder>(
            initialValue: config.reviewOrder,
            decoration: const InputDecoration(labelText: 'Review order'),
            items: deck_config.DeckConfig_Config_ReviewCardOrder.values
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(_enumLabel(value.name, 'REVIEW_CARD_ORDER_')),
                  ),
                )
                .toList(growable: false),
            onChanged: _saving
                ? null
                : (value) {
                    if (value != null) setState(() => config.reviewOrder = value);
                  },
          ),
          const SizedBox(height: 20),
          _Section(title: 'Burying & leeches'),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Bury new siblings'),
            value: config.buryNew,
            onChanged: _saving ? null : (value) => setState(() => config.buryNew = value),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Bury review siblings'),
            value: config.buryReviews,
            onChanged: _saving
                ? null
                : (value) => setState(() => config.buryReviews = value),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Bury interday learning siblings'),
            value: config.buryInterdayLearning,
            onChanged: _saving
                ? null
                : (value) => setState(() => config.buryInterdayLearning = value),
          ),
          _NumberField(
            label: 'Leech threshold',
            value: _leechThreshold,
            onChanged: (value) => _leechThreshold = value,
            integer: true,
            min: 1,
          ),
          DropdownButtonFormField<deck_config.DeckConfig_Config_LeechAction>(
            initialValue: config.leechAction,
            decoration: const InputDecoration(labelText: 'Leech action'),
            items: deck_config.DeckConfig_Config_LeechAction.values
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(_enumLabel(value.name, 'LEECH_ACTION_')),
                  ),
                )
                .toList(growable: false),
            onChanged: _saving
                ? null
                : (value) {
                    if (value != null) setState(() => config.leechAction = value);
                  },
          ),
          const SizedBox(height: 20),
          _Section(title: 'Audio & timer'),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Automatically play audio'),
            value: !config.disableAutoplay,
            onChanged: _saving
                ? null
                : (value) => setState(() => config.disableAutoplay = !value),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Show answer timer'),
            value: config.showTimer,
            onChanged: _saving ? null : (value) => setState(() => config.showTimer = value),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Stop timer when answer is shown'),
            value: config.stopTimerOnAnswer,
            onChanged: _saving
                ? null
                : (value) => setState(() => config.stopTimerOnAnswer = value),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save options'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      );
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.integer = false,
    this.min,
    this.max,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool integer;
  final num? min;
  final num? max;

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: value,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: onChanged,
        validator: (raw) {
          final parsed = integer ? int.tryParse(raw ?? '') : double.tryParse(raw ?? '');
          if (parsed == null) return 'Enter a valid number';
          if (min != null && parsed < min!) return 'Minimum: $min';
          if (max != null && parsed > max!) return 'Maximum: $max';
          return null;
        },
      );
}

String? _stepsValidator(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  try {
    _parseSteps(raw);
    return null;
  } catch (_) {
    return 'Use positive numbers separated by commas';
  }
}

List<double> _parseSteps(String raw) {
  if (raw.trim().isEmpty) return const [];
  return raw.split(',').map((part) {
    final value = double.parse(part.trim());
    if (value <= 0) throw const FormatException('Step must be positive');
    return value;
  }).toList(growable: false);
}

String _enumLabel(String name, String prefix) => name
    .replaceFirst(prefix, '')
    .toLowerCase()
    .split('_')
    .map((word) => word.isEmpty ? word : '${word[0].toUpperCase()}${word.substring(1)}')
    .join(' ');
