import 'package:anki_flutter/core/backend/generated/anki/config.pb.dart' as config;
import 'package:anki_flutter/features/preferences/data/anki_preferences_repository.dart';
import 'package:anki_flutter/features/preferences/preferences_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('loads, edits, and saves Anki preferences', (tester) async {
    final repository = _Repository(
      config.Preferences(
        scheduling: config.Preferences_Scheduling(
          rollover: 4,
          learnAheadSecs: 1200,
          newReviewMix: config.Preferences_Scheduling_NewReviewMix.DISTRIBUTE,
          newTimezone: true,
          dayLearnFirst: false,
        ),
        reviewing: config.Preferences_Reviewing(
          showIntervalsOnButtons: false,
          interruptAudioWhenAnswering: true,
        ),
        editing: config.Preferences_Editing(
          defaultSearchText: 'deck:Current',
          renderLatex: true,
        ),
        backups: config.Preferences_BackupLimits(
          daily: 8,
          weekly: 4,
          monthly: 2,
          minimumIntervalMins: 30,
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(home: PreferencesPage(repository: repository)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Scheduling'), findsOneWidget);
    expect(find.text('Reviewing'), findsOneWidget);
    expect(find.text('Editing'), findsOneWidget);
    expect(find.text('Backups'), findsOneWidget);
    expect(
      tester.widget<TextFormField>(find.byKey(const ValueKey('pref-rollover')))
          .controller!
          .text,
      '4',
    );

    await tester.enterText(
      find.byKey(const ValueKey('pref-rollover')),
      '5',
    );
    final showIntervals = tester.widget<SwitchListTile>(
      find.byKey(const ValueKey('pref-show-intervals')),
    );
    showIntervals.onChanged!(true);
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('preferences-save')));
    await tester.pumpAndSettle();

    expect(repository.saved, isNotNull);
    expect(repository.saved!.scheduling.rollover, 5);
    expect(repository.saved!.reviewing.showIntervalsOnButtons, isTrue);
    expect(repository.saved!.editing.defaultSearchText, 'deck:Current');
    expect(repository.saved!.backups.daily, 8);
    expect(find.text('Preferences saved.'), findsOneWidget);
  });

  testWidgets('shows load errors and retries', (tester) async {
    final repository = _Repository(
      config.Preferences(),
      failLoadOnce: true,
    );
    await tester.pumpWidget(
      MaterialApp(home: PreferencesPage(repository: repository)),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Could not load preferences'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('preferences-retry')));
    await tester.pumpAndSettle();

    expect(repository.loadCount, 2);
    expect(find.text('Scheduling'), findsOneWidget);
  });

  testWidgets('back confirms unsaved fields and keeps editing on cancel',
      (tester) async {
    final repository = _Repository(config.Preferences(
      scheduling: config.Preferences_Scheduling(rollover: 4),
    ));
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context) => TextButton(
          key: const ValueKey('open-preferences'),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => PreferencesPage(repository: repository),
          )),
          child: const Text('Open preferences'),
        )),
      ),
    ));
    await tester.tap(find.byKey(const ValueKey('open-preferences')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('pref-rollover')), '6');
    await tester.pump();
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Discard unsaved preferences?'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('preferences-keep-editing')));
    await tester.pumpAndSettle();
    expect(find.byType(PreferencesPage), findsOneWidget);
    expect(repository.saved, isNull);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('preferences-discard')));
    await tester.pumpAndSettle();
    expect(find.byType(PreferencesPage), findsNothing);
    expect(repository.saved, isNull);
  });

  testWidgets('saving changed fields allows leaving without discard dialog',
      (tester) async {
    final repository = _Repository(config.Preferences(
      scheduling: config.Preferences_Scheduling(rollover: 4),
    ));
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context) => TextButton(
          key: const ValueKey('open-preferences'),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => PreferencesPage(repository: repository),
          )),
          child: const Text('Open preferences'),
        )),
      ),
    ));
    await tester.tap(find.byKey(const ValueKey('open-preferences')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('pref-rollover')), '8');
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('preferences-save')));
    await tester.pumpAndSettle();
    expect(repository.saved!.scheduling.rollover, 8);
    expect(find.text('Preferences saved.'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(PreferencesPage), findsNothing);
    expect(find.text('Discard unsaved preferences?'), findsNothing);
  });

  testWidgets('switch-only edits also require confirmation', (tester) async {
    final repository = _Repository(config.Preferences(
      scheduling: config.Preferences_Scheduling(rollover: 4),
      reviewing: config.Preferences_Reviewing(
        showIntervalsOnButtons: false,
      ),
    ));
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context) => TextButton(
          key: const ValueKey('open-preferences'),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => PreferencesPage(repository: repository),
          )),
          child: const Text('Open preferences'),
        )),
      ),
    ));
    await tester.tap(find.byKey(const ValueKey('open-preferences')));
    await tester.pumpAndSettle();
    tester.widget<SwitchListTile>(
      find.byKey(const ValueKey('pref-show-intervals')),
    ).onChanged!(true);
    await tester.pump();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Discard unsaved preferences?'), findsOneWidget);
  });

}

class _Repository implements PreferencesRepository {
  _Repository(this.preferences, {this.failLoadOnce = false});

  final config.Preferences preferences;
  final bool failLoadOnce;
  var loadCount = 0;
  config.Preferences? saved;

  @override
  Future<config.Preferences> load() async {
    loadCount++;
    if (failLoadOnce && loadCount == 1) {
      throw StateError('backend failed');
    }
    return preferences.deepCopy();
  }

  @override
  Future<void> save(config.Preferences preferences) async {
    saved = preferences.deepCopy();
  }
}
