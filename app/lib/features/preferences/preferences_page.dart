import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/config.pb.dart' as config;
import 'package:anki_flutter/features/preferences/data/anki_preferences_repository.dart';
import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({required this.repository, super.key});

  final PreferencesRepository repository;

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final _formKey = GlobalKey<FormState>();
  final _rolloverController = TextEditingController();
  final _learnAheadMinutesController = TextEditingController();
  final _timeLimitSecondsController = TextEditingController();
  final _defaultSearchController = TextEditingController();
  final _dailyBackupsController = TextEditingController();
  final _weeklyBackupsController = TextEditingController();
  final _monthlyBackupsController = TextEditingController();
  final _minimumBackupMinutesController = TextEditingController();

  config.Preferences? _preferences;
  Object? _loadError;
  Object? _saveError;
  bool _loading = true;
  bool _saving = false;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadError = null;
      _saved = false;
    });
    try {
      final preferences = await widget.repository.load();
      preferences.ensureScheduling();
      preferences.ensureReviewing();
      preferences.ensureEditing();
      preferences.ensureBackups();
      _populateControllers(preferences);
      if (!mounted) return;
      setState(() {
        _preferences = preferences;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loadError = error;
        _loading = false;
      });
    }
  }

  void _populateControllers(config.Preferences preferences) {
    _rolloverController.text = '${preferences.scheduling.rollover}';
    _learnAheadMinutesController.text =
        '${preferences.scheduling.learnAheadSecs ~/ 60}';
    _timeLimitSecondsController.text = '${preferences.reviewing.timeLimitSecs}';
    _defaultSearchController.text = preferences.editing.defaultSearchText;
    _dailyBackupsController.text = '${preferences.backups.daily}';
    _weeklyBackupsController.text = '${preferences.backups.weekly}';
    _monthlyBackupsController.text = '${preferences.backups.monthly}';
    _minimumBackupMinutesController.text =
        '${preferences.backups.minimumIntervalMins}';
  }

  Future<void> _save() async {
    final preferences = _preferences;
    if (preferences == null || _saving) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    preferences.scheduling.rollover = int.parse(_rolloverController.text.trim());
    preferences.scheduling.learnAheadSecs =
        int.parse(_learnAheadMinutesController.text.trim()) * 60;
    preferences.reviewing.timeLimitSecs =
        int.parse(_timeLimitSecondsController.text.trim());
    preferences.editing.defaultSearchText = _defaultSearchController.text;
    preferences.backups.daily = int.parse(_dailyBackupsController.text.trim());
    preferences.backups.weekly = int.parse(_weeklyBackupsController.text.trim());
    preferences.backups.monthly = int.parse(_monthlyBackupsController.text.trim());
    preferences.backups.minimumIntervalMins =
        int.parse(_minimumBackupMinutesController.text.trim());

    setState(() {
      _saving = true;
      _saveError = null;
      _saved = false;
    });
    try {
      await widget.repository.save(preferences);
      if (!mounted) return;
      setState(() {
        _saving = false;
        _saved = true;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _saveError = error;
      });
    }
  }

  @override
  void dispose() {
    _rolloverController.dispose();
    _learnAheadMinutesController.dispose();
    _timeLimitSecondsController.dispose();
    _defaultSearchController.dispose();
    _dailyBackupsController.dispose();
    _weeklyBackupsController.dispose();
    _monthlyBackupsController.dispose();
    _minimumBackupMinutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        actions: [
          IconButton(
            key: const ValueKey('preferences-save'),
            tooltip: 'Save preferences',
            onPressed: _preferences == null || _saving ? null : _save,
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading && _preferences == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loadError case final error? when _preferences == null) {
      return _LoadError(error: error, onRetry: _load);
    }
    final preferences = _preferences;
    if (preferences == null) return const SizedBox.shrink();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_saving) const LinearProgressIndicator(),
                if (_saved)
                  const MaterialBanner(
                    content: Text('Preferences saved.'),
                    actions: [SizedBox.shrink()],
                  ),
                if (_saveError case final error?)
                  MaterialBanner(
                    content: Text('Could not save preferences: $error'),
                    actions: [
                      TextButton(
                        onPressed: _save,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                _section(
                  context,
                  title: 'Scheduling',
                  children: [
                    _numberField(
                      keyName: 'pref-rollover',
                      controller: _rolloverController,
                      label: 'Next day starts at hour',
                      helper: '0–23',
                      min: 0,
                      max: 23,
                    ),
                    _numberField(
                      keyName: 'pref-learn-ahead',
                      controller: _learnAheadMinutesController,
                      label: 'Learn ahead limit',
                      helper: 'Minutes',
                      min: 0,
                    ),
                    DropdownButtonFormField<
                      config.Preferences_Scheduling_NewReviewMix
                    >(
                      key: const ValueKey('pref-new-review-mix'),
                      value: preferences.scheduling.newReviewMix,
                      decoration: const InputDecoration(
                        labelText: 'New/review card order',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: config.Preferences_Scheduling_NewReviewMix.DISTRIBUTE,
                          child: Text('Mix with reviews'),
                        ),
                        DropdownMenuItem(
                          value: config.Preferences_Scheduling_NewReviewMix.REVIEWS_FIRST,
                          child: Text('Reviews first'),
                        ),
                        DropdownMenuItem(
                          value: config.Preferences_Scheduling_NewReviewMix.NEW_FIRST,
                          child: Text('New cards first'),
                        ),
                      ],
                      onChanged: _saving
                          ? null
                          : (value) {
                              if (value == null) return;
                              setState(
                                () => preferences.scheduling.newReviewMix = value,
                              );
                            },
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-new-timezone'),
                      title: const Text('Use new timezone handling'),
                      value: preferences.scheduling.newTimezone,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.scheduling.newTimezone = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-day-learn-first'),
                      title: const Text('Show interday learning cards first'),
                      value: preferences.scheduling.dayLearnFirst,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.scheduling.dayLearnFirst = value,
                            ),
                    ),
                  ],
                ),
                _section(
                  context,
                  title: 'Reviewing',
                  children: [
                    SwitchListTile(
                      key: const ValueKey('pref-hide-audio-buttons'),
                      title: const Text('Hide audio replay buttons'),
                      value: preferences.reviewing.hideAudioPlayButtons,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.reviewing.hideAudioPlayButtons = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-interrupt-audio'),
                      title: const Text('Interrupt audio when answering'),
                      value: preferences.reviewing.interruptAudioWhenAnswering,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.reviewing.interruptAudioWhenAnswering = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-show-due-counts'),
                      title: const Text('Show remaining due counts'),
                      value: preferences.reviewing.showRemainingDueCounts,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.reviewing.showRemainingDueCounts = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-show-intervals'),
                      title: const Text('Show next intervals on answer buttons'),
                      value: preferences.reviewing.showIntervalsOnButtons,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.reviewing.showIntervalsOnButtons = value,
                            ),
                    ),
                    _numberField(
                      keyName: 'pref-time-limit',
                      controller: _timeLimitSecondsController,
                      label: 'Answer time limit',
                      helper: 'Seconds; 0 disables the limit',
                      min: 0,
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-load-balancer'),
                      title: const Text('Enable load balancer'),
                      value: preferences.reviewing.loadBalancerEnabled,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.reviewing.loadBalancerEnabled = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-fsrs-short-term'),
                      title: const Text('FSRS short-term scheduling with steps'),
                      value: preferences.reviewing.fsrsShortTermWithStepsEnabled,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.reviewing.fsrsShortTermWithStepsEnabled = value,
                            ),
                    ),
                  ],
                ),
                _section(
                  context,
                  title: 'Editing',
                  children: [
                    SwitchListTile(
                      key: const ValueKey('pref-default-current-deck'),
                      title: const Text('Default new notes to current deck'),
                      value: preferences.editing.addingDefaultsToCurrentDeck,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.editing.addingDefaultsToCurrentDeck = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-paste-png'),
                      title: const Text('Paste images as PNG'),
                      value: preferences.editing.pasteImagesAsPng,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.editing.pasteImagesAsPng = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-strip-formatting'),
                      title: const Text('Strip formatting when pasting'),
                      value: preferences.editing.pasteStripsFormatting,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.editing.pasteStripsFormatting = value,
                            ),
                    ),
                    TextFormField(
                      key: const ValueKey('pref-default-search'),
                      controller: _defaultSearchController,
                      enabled: !_saving,
                      decoration: const InputDecoration(
                        labelText: 'Default browser search',
                      ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-ignore-accents'),
                      title: const Text('Ignore accents in search'),
                      value: preferences.editing.ignoreAccentsInSearch,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.editing.ignoreAccentsInSearch = value,
                            ),
                    ),
                    SwitchListTile(
                      key: const ValueKey('pref-render-latex'),
                      title: const Text('Render LaTeX'),
                      value: preferences.editing.renderLatex,
                      onChanged: _saving
                          ? null
                          : (value) => setState(
                              () => preferences.editing.renderLatex = value,
                            ),
                    ),
                  ],
                ),
                _section(
                  context,
                  title: 'Backups',
                  children: [
                    _numberField(
                      keyName: 'pref-backup-daily',
                      controller: _dailyBackupsController,
                      label: 'Daily backups to keep',
                      min: 0,
                    ),
                    _numberField(
                      keyName: 'pref-backup-weekly',
                      controller: _weeklyBackupsController,
                      label: 'Weekly backups to keep',
                      min: 0,
                    ),
                    _numberField(
                      keyName: 'pref-backup-monthly',
                      controller: _monthlyBackupsController,
                      label: 'Monthly backups to keep',
                      min: 0,
                    ),
                    _numberField(
                      keyName: 'pref-backup-minimum-interval',
                      controller: _minimumBackupMinutesController,
                      label: 'Minimum backup interval',
                      helper: 'Minutes',
                      min: 0,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Save preferences'),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            for (var index = 0; index < children.length; index++) ...[
              children[index],
              if (index != children.length - 1) const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  Widget _numberField({
    required String keyName,
    required TextEditingController controller,
    required String label,
    String? helper,
    required int min,
    int? max,
  }) {
    return TextFormField(
      key: ValueKey(keyName),
      controller: controller,
      enabled: !_saving,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, helperText: helper),
      validator: (value) {
        final parsed = int.tryParse(value?.trim() ?? '');
        if (parsed == null) return 'Enter a whole number';
        if (parsed < min) return 'Must be at least $min';
        if (max != null && parsed > max) return 'Must be at most $max';
        return null;
      },
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.error, required this.onRetry});

  final Object error;
  final Future<void> Function() onRetry;

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
            Text(
              'Could not load preferences',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(error.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonal(
              key: const ValueKey('preferences-retry'),
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
