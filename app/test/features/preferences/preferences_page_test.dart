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
    final showIntervals = find.byKey(const ValueKey('pref-show-intervals'));
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -450),
    );
    await tester.pumpAndSettle();
    await tester.tap(showIntervals);
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
