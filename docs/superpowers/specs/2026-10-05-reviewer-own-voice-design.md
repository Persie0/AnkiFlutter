# Reviewer Own Voice Parity Design

Date: 2026-10-05
Status: Proposed for implementation planning after user review
Base: `feat/reviewer-delete-note` at merge commit `e44bce42737f99ce0b92445be423aa47080031af`
Feature branch: `feat/reviewer-own-voice`

## Intent

Implement Anki Reviewer parity for **Record Own Voice** and **Replay Own Voice** across Android, iOS, Linux, macOS, and Windows while preserving AnkiFlutter's shared Flutter architecture.

Success means a reviewer can temporarily record their microphone, immediately hear the result, replay that recording later in the same Reviewer session, cancel a new recording without losing the previous successful recording, and use the upstream desktop shortcuts and menu actions without mutating the scheduler or collection.

The feature is Reviewer-session tooling, not note media editing. Recorded audio must remain temporary and must never be inserted into collection media or written through the Anki backend.

## Upstream behavior to match

Pinned upstream Anki Reviewer behavior:

- `Shift+V` invokes **Record Own Voice**.
- `V` invokes **Replay Own Voice**.
- A successful recording replaces the prior Reviewer-session recording and immediately replays the new recording.
- Replaying before any successful recording shows the user that no voice recording exists yet.
- Canceling a recording deletes the new temporary file and leaves the previous successful recording available.
- The stored recording belongs to the Reviewer session, not to an individual card, so advancing to another card does not clear it.

AnkiFlutter should match these semantics while using native Flutter UI rather than cloning the Qt dialog.

## Scope

### In scope

- Reviewer menu actions:
  - `Record Own Voice`
  - `Replay Own Voice`
- Desktop keyboard shortcuts:
  - `Shift+V` to record
  - `V` to replay
- A small Flutter recording dialog/surface with:
  - elapsed recording time
  - Stop action
  - Cancel action
- Microphone permission handling.
- Temporary WAV recording.
- Immediate replay after a successful stop.
- Replay of the latest successful recording later in the same Reviewer session.
- Cleanup of replaced recordings and final Reviewer disposal.
- Auto-advance suspension/restoration while the recording surface is open.
- Interaction with existing card-audio playback and auto-advance `waitForAudio` behavior.
- Android/iOS/macOS permission/configuration changes.
- Linux runtime dependency documentation and public validation environment support.
- Automated tests for lifecycle, cancellation, playback, shortcuts, error handling, and cleanup.

### Out of scope

- Saving the recording to collection media.
- Adding sound tags to notes/cards.
- Browser or Editor recording.
- Background recording.
- Waveform editing or trimming.
- Microphone/input-device selection UI.
- Audio normalization, denoising, or gain controls.
- A custom native recorder implementation per platform.
- New backend operation IDs or protobuf changes.
- Changes to scheduling semantics.

## Architectural approach

Use three small boundaries:

1. `ReviewVoiceRecorder`: Reviewer-facing recording abstraction.
2. `RecordReviewVoiceRecorder`: production adapter over `package:record`.
3. Existing `ReviewAudioService`: extended with one-shot playback for temporary voice recordings.

Reviewer state and orchestration remain in the existing Reviewer layer. Platform recording details remain behind the recorder interface. This keeps tests deterministic and prevents the third-party package from leaking into controller or page code.

### Why this approach

`record` 7.1.1 supports Android, iOS, Linux, macOS, and Windows and can write WAV on all five platforms. Its `cancel()` contract removes the in-progress output. Android/iOS/macOS use native platform recording APIs; Windows uses MediaFoundation; Linux uses `parecord`, `pactl`, and `ffmpeg`.

Using the existing Review audio player for replay is important because the Reviewer already has one audio-playing signal that drives `waitForAudio` auto-advance behavior. A second independent player would make that signal incomplete and create competing playback ownership.

## Components

### `ReviewVoiceRecorder`

Add a small interface under `features/reviewer/audio/` with production-neutral semantics:

```dart
abstract interface class ReviewVoiceRecorder {
  bool get isRecording;
  Stream<Duration> get elapsedChanges;

  Future<bool> ensurePermission();
  Future<void> start();
  Future<Uri?> stop();
  Future<void> cancel();
  Future<void> dispose();
}
```

The exact method names may be adjusted during implementation if tests expose a cleaner API, but the semantic contract is fixed:

- `ensurePermission()` requests/checks permission where supported and reports whether recording may proceed.
- `start()` starts a new temporary recording.
- `stop()` finalizes the current recording and returns its URI/path.
- `cancel()` abandons the in-progress recording and removes its temporary output.
- `dispose()` safely stops/cancels any active recording and releases recorder resources.
- elapsed time is observable without tying Reviewer UI directly to `package:record`.

The interface must be easily faked in widget/controller tests.

### `RecordReviewVoiceRecorder`

Production adapter using `record: 7.1.1`.

Configuration:

- encoder: WAV
- temporary output directory only
- one recording at a time
- no background recording
- no input-device picker

The adapter owns only the currently active recording operation. The Reviewer controller/session owns the URI of the most recent successful recording.

For platforms where `hasPermission()` is implemented, the adapter uses it before starting. On platforms where the package does not expose a permission check, failure from `start()` is surfaced through the normal error path.

### `ReviewAudioService.playOneShot()`

Extend the existing audio abstraction with one-shot playback:

```dart
Future<void> playOneShot(Uri item);
```

Required semantics:

- use the same underlying media_kit player as card audio;
- interrupt currently playing card audio, matching upstream voice-replay behavior;
- do **not** replace the remembered card-audio replay queue (`_currentQueue`);
- report playing state through the existing `playingChanges` stream;
- after voice playback, `Replay audio` / `R` must still replay the current card's audio queue.

`MediaKitReviewAudioPlayerAdapter` can implement this by opening the temporary URI directly while `PlayerBackedReviewAudioService` deliberately leaves `_currentQueue` unchanged.

## Reviewer state ownership

The latest successful own-voice recording belongs to the `ReviewController`/Reviewer session, not to a card.

Add controller state similar to:

```dart
Uri? _recordedOwnVoice;
```

This URI remains valid across normal card transitions, including answer, rate, bury, suspend, undo, and repeated-card transitions, until one of these events occurs:

- a newer recording successfully replaces it;
- the Reviewer controller is disposed.

Starting a new recording must **not** delete the previous successful recording. Replacement happens only after the new recording has successfully stopped and produced a usable file.

When replacement succeeds:

1. retain the new URI;
2. delete the old temporary file;
3. immediately play the new recording.

If stopping fails, the previous successful recording remains the active replay target.

## Temporary-file lifecycle

All own-voice files are temporary application files and never collection media.

Rules:

- recording starts at a unique file path in a temporary directory;
- cancel removes the new in-progress file;
- successful replacement removes the previous successful file only after the new one is finalized;
- controller disposal removes the last successful file;
- cleanup failures must not crash Reviewer shutdown;
- deleting a temporary file must tolerate it already being absent;
- no file path is persisted across app/reviewer sessions.

The production implementation should centralize deletion in one helper so tests can verify replacement/disposal semantics without duplicating filesystem logic.

## Recording UI and interaction

Add two `_ReviewAction` values:

- `recordOwnVoice`
- `replayOwnVoice`

Add menu entries in the Reviewer audio section regardless of whether the card itself contains media. Own-voice recording capability is independent of `hasReplayableAudio`.

Desktop shortcuts:

- `Shift+V` -> `recordOwnVoice`
- `V` -> `replayOwnVoice`

As with existing Reviewer shortcuts, shortcuts are disabled while the typed-answer input owns focus.

### Recording dialog

Use a modal Flutter dialog/surface, not a separate navigation page.

Minimum UI:

- title: `Record Own Voice`
- microphone/recording indicator
- elapsed time, updated while recording
- `Cancel`
- `Stop`

Recording starts after permission succeeds and after the dialog is mounted. The dialog must not silently begin recording before permission is resolved.

`Stop`:

1. finalize recording;
2. close the dialog;
3. replace the previous successful recording;
4. automatically replay the new recording.

`Cancel`, back navigation, dialog dismissal, or Reviewer disposal while recording:

1. cancel recorder operation;
2. remove the new temporary output;
3. preserve the previous successful recording;
4. do not auto-replay.

The page-level `_manualActionInProgress` guard prevents duplicate record actions while the dialog/action is active.

## Permission and platform configuration

### Android

Add microphone permission to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

The runtime request/check is handled through the recorder adapter/package.

No storage permission is required because recording goes to app-controlled temporary storage.

### iOS

Add `NSMicrophoneUsageDescription` to `ios/Runner/Info.plist` with user-facing text explaining that microphone access is used only when the user chooses Record Own Voice in Reviewer.

### macOS

Add the same `NSMicrophoneUsageDescription` to `macos/Runner/Info.plist`.

Add:

```xml
<key>com.apple.security.device.audio-input</key>
<true/>
```

to both:

- `macos/Runner/DebugProfile.entitlements`
- `macos/Runner/Release.entitlements`

### Windows

No manifest/configuration change is expected for the plugin. Recording startup errors still use the common error path.

### Linux

`record` 7.1.1 requires:

- `parecord`
- `pactl`
- `ffmpeg`

Document `pulseaudio-utils` and `ffmpeg` as Linux runtime dependencies.

Update the public Playground Linux validation setup to install `pulseaudio-utils ffmpeg` so the production plugin can resolve/build in the exact environment used for cross-platform validation. Automated recording behavior itself remains fake-driven in headless CI; the validation gate proves integration/build compatibility, not physical microphone access.

## Auto-advance and audio lifecycle

Recording is a modal secondary Reviewer interaction and must not allow the card to advance underneath it.

Reuse the existing `ReviewSecondarySurfaceToken` lifecycle:

1. capture current generation/card and whether Auto Advance was enabled;
2. suspend Auto Advance before opening/starting recording;
3. stop current card audio before beginning microphone recording;
4. on dialog completion/cancel/error, restore Auto Advance only when:
   - it was previously enabled;
   - the same Reviewer generation is still visible;
   - the same card is still visible;
   - Auto Advance has not independently been re-enabled.

This matches Card Info's generation-safe restoration rather than adding another timer system.

Immediate replay of the newly recorded voice occurs after the modal recording surface has closed. Because one-shot playback uses the existing audio service, normal `waitForAudio` behavior observes it through the same `isPlaying`/`playingChanges` signal.

## Controller API

Add explicit Reviewer operations rather than letting `ReviewPage` manipulate recorder/audio internals directly. Expected shape:

```dart
bool get canRecordOwnVoice;
bool get hasRecordedOwnVoice;

Future<void> beginOwnVoiceRecording();
Future<Uri?> stopOwnVoiceRecording();
Future<void> cancelOwnVoiceRecording();
Future<bool> replayOwnVoice();
```

The exact final method split may be adjusted to keep dialog ownership clean, but these responsibilities must remain controller/service-level:

- permission/start/stop/cancel orchestration;
- successful-recording ownership;
- temporary-file replacement/cleanup;
- one-shot replay;
- generation-safe handling of stale async completions.

`replayOwnVoice()` should distinguish "nothing recorded" from a playback failure so the page can show the upstream-equivalent empty-state message separately from an error.

## Error handling

### Permission denied

Do not enter recording state. Keep any previous successful recording. Show a concise Reviewer message that microphone permission is required to record voice.

No automatic jump to OS settings is included in this slice.

### Recorder start failure

Close/avoid the recording state, preserve the previous recording, restore Auto Advance through the secondary-surface token, and show the existing review-action error UI.

### Stop/finalization failure

Attempt to cancel/clean the failed new recording, preserve the previous recording, restore Reviewer lifecycle, and show an error. Do not replay a partial file.

### Playback failure

Keep the successful recording URI so replay can be attempted again later. Surface the error through Reviewer action feedback.

### No prior recording

`Replay Own Voice` performs no playback and shows:

`You haven't recorded your voice yet.`

This is an expected empty state, not an exception.

### Stale async completion

If the Reviewer generation/session changes while permission, start, stop, or replay work is pending, late completions must not mutate the visible card or restore obsolete Auto Advance state. Temporary output created by stale work must still be cleaned up.

## Dependency changes

Add to `app/pubspec.yaml` and lockfile:

```yaml
record: 7.1.1
```

Pin the exact version for deterministic cross-platform validation in this parity slice rather than using a caret range.

No Anki backend, protobuf, Rust bridge, or stable operation-ID changes are required.

## Testing strategy

### Recorder adapter/unit tests

Use a fake recorder platform/port where practical. Verify:

- permission accepted -> recording may start;
- permission denied -> no recording start;
- stop returns successful URI;
- cancel does not produce a successful recording;
- dispose is idempotent;
- failures propagate without leaving the adapter logically recording.

Avoid tests that require a real microphone in CI.

### `ReviewAudioService` tests

Verify:

- `playOneShot()` opens the supplied URI on the existing player;
- one-shot playback does not overwrite `_currentQueue`;
- after one-shot playback, `replay()` still opens the prior card-audio queue;
- playing-change behavior still comes from the same player.

### `ReviewController` tests

Verify:

- successful stop stores the recording;
- successful stop immediately invokes one-shot playback;
- new successful recording replaces and cleans the old one;
- canceled recording preserves old successful recording;
- denied permission preserves old recording;
- failed start/stop preserves old recording;
- replay with no recording returns expected empty state;
- replay with recording invokes one-shot playback;
- recording persists across card transitions;
- controller disposal cleans the final temp file;
- stale completion cannot replace the current recording incorrectly.

### `ReviewPage` widget tests

Verify:

- menu contains `Record Own Voice` and `Replay Own Voice` even on cards without media;
- `Shift+V` opens recording flow;
- `V` replays own voice;
- shortcuts do not fire while typed-answer input is focused;
- recording dialog shows elapsed time plus Stop/Cancel;
- Cancel preserves previous recording;
- no-recording replay displays the expected message;
- permission/error paths show actionable feedback;
- `_manualActionInProgress` prevents duplicate actions.

### Lifecycle tests

Verify:

- Auto Advance is suspended while recording dialog is active;
- Auto Advance restores when the same generation/card remains active;
- Auto Advance does not restore after generation/card changes;
- current card audio is stopped before recording begins;
- successful post-dialog replay is visible to `waitForAudio` through existing player state.

### Platform/build validation

Public `Persie0/Playground` validation remains the authoritative final gate:

1. focused RED test proving missing behavior before implementation;
2. focused Reviewer analyzer/tests GREEN;
3. full Flutter test suite GREEN;
4. cross-platform validation GREEN:
   - generated protobuf verification
   - Rust format/Clippy/tests
   - Flutter analyze/tests
   - Linux app build
   - Android APK
   - real-backend integration
   - iOS simulator build
   - macOS build
   - Windows build

Do not use private AnkiFlutter Actions for feature validation.

## Expected files touched

Production code is expected to stay primarily within:

- `app/pubspec.yaml`
- `app/pubspec.lock`
- `app/lib/app/anki_app_root.dart`
- `app/lib/features/reviewer/audio/review_audio_service.dart`
- `app/lib/features/reviewer/audio/media_kit_review_audio_player_adapter.dart` or its player port if needed
- new `app/lib/features/reviewer/audio/review_voice_recorder.dart`
- new production `record` adapter file
- `app/lib/features/reviewer/review_controller.dart`
- `app/lib/features/reviewer/review_page.dart`
- Android/iOS/macOS platform permission/configuration files
- focused Reviewer/audio tests
- Linux dependency documentation

Public validation infrastructure may additionally update `Persie0/Playground` to install Linux recorder dependencies. That validation-only repository change is not product behavior.

## Acceptance criteria

The slice is complete only when all of the following are true:

1. Reviewer exposes Record Own Voice and Replay Own Voice.
2. `Shift+V` and `V` match upstream behavior on desktop platforms.
3. A successful recording immediately replays.
4. Replay continues to work across subsequent cards in the same Reviewer session.
5. Canceling a new recording leaves the previous successful recording intact.
6. Replay before any successful recording produces the expected user-facing message.
7. Own-voice playback interrupts current card audio without destroying the remembered card-audio replay queue.
8. Recording cannot cause Auto Advance to advance underneath the modal surface.
9. Auto Advance restoration is generation/card safe.
10. Temporary recordings are cleaned on replacement and Reviewer disposal.
11. No recording is added to collection media or sent to the backend.
12. Android, iOS, macOS microphone permissions/configuration are present.
13. Linux runtime dependencies are documented and present in public validation setup.
14. No protobuf/generated backend files or stable operation IDs change.
15. Focused, full Flutter, and cross-platform public validation are green on the exact feature head.

## Deliberate non-decisions deferred to later work

The following are intentionally not generalized in this slice:

- shared recording infrastructure for Editor/Browser;
- microphone selection;
- persistent recording history;
- encoding/quality settings;
- accessibility-driven recording controls beyond standard Flutter semantics;
- waveform visualization;
- background recording.

If later features need those capabilities, they should extend the small recorder abstraction rather than expanding this Reviewer parity slice preemptively.
