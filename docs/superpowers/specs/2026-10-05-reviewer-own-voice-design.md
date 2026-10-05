# Reviewer Own Voice Parity Design

Date: 2026-10-05
Status: Ready for user review
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
- Replaying before any successful recording shows that no voice recording exists yet.
- Canceling a recording deletes the new temporary file and leaves the previous successful recording available.
- The stored recording belongs to the Reviewer session, not to an individual card, so advancing to another card does not clear it.

AnkiFlutter will match these semantics with native Flutter UI rather than cloning the Qt dialog.

## Scope

### In scope

- Reviewer actions `Record Own Voice` and `Replay Own Voice`.
- Desktop shortcuts `Shift+V` and `V`.
- A modal Flutter recording dialog with preparation, recording, elapsed-time, Stop, and Cancel states.
- Microphone permission handling.
- Temporary WAV recording.
- Immediate replay after a successful recording.
- Replay of the latest successful recording across cards in the same Reviewer session.
- Cleanup of canceled, replaced, stale, and final temporary files.
- Auto-advance suspension/restoration while the recording dialog is active.
- Correct interaction with existing card-audio playback and `waitForAudio`.
- Android/iOS/macOS permission/configuration changes.
- Linux runtime dependency documentation and public validation environment support.
- Automated lifecycle, cancellation, playback, shortcut, error, and cleanup tests.

### Out of scope

- Saving recordings to collection media or adding sound tags to notes.
- Browser or Editor recording.
- Background recording.
- Waveform editing, trimming, normalization, denoising, or gain controls.
- Microphone/input-device selection UI.
- A custom native recorder implementation per platform.
- Backend operation IDs, protobuf changes, or scheduling changes.

## Architectural approach

Use three boundaries:

1. `ReviewVoiceRecorder`: Reviewer-facing recording abstraction.
2. `RecordReviewVoiceRecorder`: production adapter over `package:record`.
3. Existing `ReviewAudioService`: extended with one-shot playback for temporary voice recordings.

Reviewer state and orchestration stay in `ReviewController`. Platform recording details stay behind the recorder interface. `ReviewPage` owns only presentation and the modal dialog flow.

`record` 7.1.1 is used because it supports Android, iOS, Linux, macOS, and Windows and can write WAV on all five platforms. Its `cancel()` contract removes the in-progress output. Linux uses `parecord`, `pactl`, and `ffmpeg`.

The existing Review audio player is reused for own-voice playback because Reviewer already has one audio-playing signal that drives `waitForAudio`. A second player would make that signal incomplete and create competing playback ownership.

## Recording abstraction

Add under `features/reviewer/audio/`:

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

Contract:

- `ensurePermission()` requests/checks permission where supported and returns `false` only when recording cannot proceed because permission is denied/unavailable.
- `start()` creates a unique temporary WAV and starts recording.
- `stop()` finalizes the active recording and returns its URI; `null` means no usable output was produced.
- `cancel()` abandons the active recording and removes its new output.
- `dispose()` cancels any active recording and releases resources; it is idempotent.
- `elapsedChanges` starts from zero for each recording and emits elapsed recording time while active.

The interface is injected into `ReviewController` and is directly fakeable in controller/widget tests.

## Production recorder adapter

`RecordReviewVoiceRecorder` uses exactly `record: 7.1.1` with:

- `AudioEncoder.wav`;
- one recording at a time;
- a unique file under `Directory.systemTemp` or an injected temporary-directory provider;
- no background recording;
- no device picker.

The adapter owns only the active recording operation and its active output path. The controller owns the URI of the latest successful recording.

Where `record` exposes permission checking, the adapter uses it. On platforms where permission checking is unavailable, `start()` failures use the normal recorder-error path.

## One-shot playback

Extend `ReviewAudioService` with:

```dart
Future<void> playOneShot(Uri item);
```

Required semantics:

- use the same underlying media_kit player as card audio;
- interrupt current card audio;
- do **not** replace `PlayerBackedReviewAudioService._currentQueue`;
- report playback through the same `isPlaying` / `playingChanges` signal;
- after own-voice playback, `Replay audio` / `R` still replays the current card-audio queue.

`ReviewAudioPlayerAdapter` gets a corresponding one-item open/play operation. `PlayerBackedReviewAudioService.playOneShot()` delegates to it without mutating `_currentQueue`.

## Reviewer state ownership

Inject `ReviewVoiceRecorder? voiceRecorder` into `ReviewController` beside the existing audio/TTS dependencies.

The controller owns:

```dart
Uri? _recordedOwnVoice;
```

The recording remains available across question/answer transitions, rating, bury/suspend, undo, normal card changes, and immediate same-card repeats. It is cleared only after successful replacement or Reviewer disposal.

Starting a new recording never deletes the previous successful recording. Replacement occurs only after the new recording has successfully finalized.

Successful replacement order:

1. finalize and receive the new URI;
2. set `_recordedOwnVoice` to the new URI;
3. best-effort delete the previous successful temporary file;
4. play the new URI with `ReviewAudioService.playOneShot()`.

If finalization fails or returns no usable URI, the previous successful recording remains active.

## Fixed controller API

Expose this controller API:

```dart
bool get canRecordOwnVoice;
bool get hasRecordedOwnVoice;
Stream<Duration> get ownVoiceRecordingElapsed;

Future<ReviewOwnVoiceStartResult> beginOwnVoiceRecording();
Future<void> stopOwnVoiceRecording();
Future<void> cancelOwnVoiceRecording();
Future<bool> replayOwnVoice();
```

with:

```dart
enum ReviewOwnVoiceStartResult {
  started,
  permissionDenied,
}
```

Semantics:

- `canRecordOwnVoice` is true only when both a recorder and audio service are available.
- `hasRecordedOwnVoice` reflects `_recordedOwnVoice != null`.
- `ownVoiceRecordingElapsed` forwards the recorder's elapsed stream; when unsupported it is an empty stream.
- `beginOwnVoiceRecording()` stops current Reviewer audio first, checks/requests permission, then starts recording. Permission denial returns `permissionDenied`; other failures throw.
- `stopOwnVoiceRecording()` finalizes, replaces the successful URI, cleans the old file, and immediately replays the new recording. Failure throws and preserves the previous successful URI.
- `cancelOwnVoiceRecording()` cancels only the active attempt; it never clears the previous successful URI.
- `replayOwnVoice()` returns `false` if no successful recording exists. Otherwise it calls `playOneShot()` and returns `true`; playback failures throw.

Async completions must be ignored if the controller has been disposed. Files created by stale/disposed work must still be cleaned up.

## Temporary-file lifecycle

All own-voice files are temporary application files and never collection media.

Rules:

- every start uses a unique temporary WAV path;
- cancel removes the new in-progress output;
- successful replacement deletes the prior successful file only after the new file is finalized and adopted;
- controller disposal cancels active recording, deletes the last successful file, and disposes the recorder;
- cleanup failures do not crash Reviewer shutdown;
- deletion tolerates an already-absent file;
- no recording path is persisted across Reviewer/app sessions.

Use one injected/bounded temp-file cleanup helper so replacement and disposal behavior are independently testable.

## Recording dialog and page flow

Add `_ReviewAction.recordOwnVoice` and `_ReviewAction.replayOwnVoice`.

The menu entries appear in the Reviewer audio section whenever `canRecordOwnVoice` is true, regardless of whether the card itself has replayable media.

Desktop shortcuts:

- `Shift+V` -> `recordOwnVoice`
- `V` -> `replayOwnVoice`

Shortcuts remain disabled while the typed-answer field owns focus.

### Deterministic modal flow

`ReviewPage` handles Record Own Voice as follows:

1. Reject duplicate invocation through `_manualActionInProgress`.
2. Acquire `ReviewSecondarySurfaceToken` with `pauseForSecondarySurface()` before showing the dialog.
3. Open the modal dialog in a `Preparing microphone…` state.
4. After the dialog's first frame, call `beginOwnVoiceRecording()` exactly once.
5. If the result is `permissionDenied`, close the dialog, show a microphone-permission message, and do not alter any previous recording.
6. If start succeeds, switch the dialog to recording state and subscribe/render `ownVoiceRecordingElapsed`.
7. `Stop` disables Stop/Cancel, calls `stopOwnVoiceRecording()`, and closes the dialog after success. The controller immediately replays the new recording.
8. `Cancel`, system back, barrier dismissal, or page disposal calls `cancelOwnVoiceRecording()` exactly once before closing/finishing.
9. In a `finally` path, call `resumeAfterSecondarySurface(token)`; its existing generation/card checks decide whether Auto Advance can be restored.

The dialog is `barrierDismissible: false`; explicit Cancel and system back are handled so cancellation cleanup always runs.

The dialog never directly calls `package:record`, never owns file paths, and never manipulates Review audio state.

## Replay Own Voice flow

`ReviewPage` calls `controller.replayOwnVoice()`.

- `true`: playback started normally.
- `false`: show `You haven't recorded your voice yet.`
- thrown error: use existing review-action error feedback.

Replay Own Voice does not pause Auto Advance itself; playback is visible through the existing audio service, so `waitForAudio` behaves consistently with other audio.

## Auto-advance and audio lifecycle

Recording is a secondary Reviewer interaction and must not allow the card to advance underneath the dialog.

Reuse `ReviewSecondarySurfaceToken`:

- Auto Advance is suspended before the dialog opens.
- `beginOwnVoiceRecording()` stops current card audio before microphone recording begins.
- Auto Advance is restored only when it had been enabled and the same generation/card remains visible.
- If the card/generation changes while permission or recorder work is pending, obsolete restoration does not occur.

Successful recording replay happens after finalization and during dialog completion. Because it uses the same audio service, `waitForAudio` sees it through the same playing state.

## Platform configuration

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

No storage permission is required because the app writes to its temporary directory.

### iOS

Add `NSMicrophoneUsageDescription` to `ios/Runner/Info.plist` explaining that microphone access is used only when the user chooses Record Own Voice in Reviewer.

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

No manifest/configuration change is required by the selected plugin. Recording startup errors use the common error path.

### Linux

Document runtime requirements:

- `parecord`
- `pactl`
- `ffmpeg`

On Ubuntu, install `pulseaudio-utils ffmpeg`.

Update the public `Persie0/Playground` Linux validation setup to install those packages. CI does not attempt physical microphone capture; fake-driven tests verify recording behavior while platform builds verify plugin integration.

## Error handling

### Permission denied

Do not enter recording state. Preserve the previous successful recording. Close the modal and show a concise message that microphone permission is required.

No automatic jump to OS settings is included.

### Start failure

Cancel/clean any partial active attempt, preserve the previous recording, close the modal, restore secondary-surface lifecycle, and surface the existing review-action error.

### Stop/finalization failure

Cancel/clean the failed attempt, preserve the previous recording, close the modal, restore lifecycle, and surface an error. Never replay a partial file.

### Playback failure

Keep the successful recording URI so replay can be retried later. Surface the error without deleting the recording.

### No prior recording

Show exactly:

`You haven't recorded your voice yet.`

This is an expected empty state, not an exception.

### Disposal/stale completion

Late permission/start/stop callbacks after controller disposal must not mutate Reviewer state. Any file produced by such work is deleted best-effort. Secondary-surface restoration remains guarded by the existing generation/card token.

## Dependency changes

Add and lock exactly:

```yaml
record: 7.1.1
```

The app already requires Dart >=3.13, satisfying `record` 7.1.1's Dart requirement.

No Anki backend, protobuf, generated-proto, Rust bridge, or stable operation-ID changes are required.

## Testing strategy

### `ReviewAudioService`

Verify:

- `playOneShot()` uses the supplied URI;
- it does not overwrite `_currentQueue`;
- `replay()` after one-shot playback still reopens the prior card-audio queue;
- playing-change reporting still comes from the same player.

### `ReviewController`

Using a fake `ReviewVoiceRecorder`, verify:

- permission accepted -> start;
- permission denied -> no start;
- start first stops current audio;
- successful stop stores and immediately replays the new recording;
- successful replacement cleans the old recording;
- cancel preserves the old successful recording;
- denied permission and start/stop failures preserve the old recording;
- replay with no recording returns `false`;
- replay with a recording invokes one-shot playback and returns `true`;
- the recording persists across card transitions, undo, and same-card repeats;
- disposal cancels active recording and cleans the final successful file;
- late/disposed completions cannot replace active state.

### `ReviewPage`

Verify:

- Own Voice menu entries appear even on a card without media when recording is supported;
- `Shift+V` opens the modal;
- `V` invokes replay;
- typed-answer focus suppresses both shortcuts;
- dialog starts in preparation state and starts recording only after mount;
- recording state shows elapsed time, Stop, and Cancel;
- Stop finalizes once and closes;
- Cancel/back finalizes cancellation once and preserves previous recording;
- permission denial closes with correct feedback;
- no-recording replay shows the exact empty-state message;
- `_manualActionInProgress` blocks duplicate invocation.

### Lifecycle

Verify:

- Auto Advance is suspended before dialog activity;
- same-card/generation completion restores prior Auto Advance state;
- changed generation/card does not restore it;
- card audio is stopped before recording begins;
- successful own-voice replay participates in existing `waitForAudio` behavior.

### Platform/build validation

Public `Persie0/Playground` remains the authoritative final gate:

1. focused RED test proving missing behavior before implementation;
2. focused Reviewer analyzer/tests GREEN;
3. full Flutter suite GREEN;
4. cross-platform validation GREEN, including generated-proto verification, Rust format/Clippy/tests, Flutter analyze/tests, Linux build, Android APK, real-backend integration, iOS simulator, macOS, and Windows.

Do not use private AnkiFlutter Actions for feature validation.

## Expected files touched

Product repository:

- `app/pubspec.yaml`
- `app/pubspec.lock`
- `app/lib/app/anki_app_root.dart`
- `app/lib/features/reviewer/audio/review_audio_service.dart`
- `app/lib/features/reviewer/audio/media_kit_review_audio_player_adapter.dart`
- new `app/lib/features/reviewer/audio/review_voice_recorder.dart`
- new `app/lib/features/reviewer/audio/record_review_voice_recorder.dart`
- `app/lib/features/reviewer/review_controller.dart`
- `app/lib/features/reviewer/review_page.dart`
- Android/iOS/macOS permission/configuration files
- focused Reviewer/audio tests
- Linux runtime dependency documentation

Validation repository:

- `Persie0/Playground` AnkiFlutter validation setup for Linux audio utilities.

## Acceptance criteria

The slice is complete only when:

1. Reviewer exposes Record Own Voice and Replay Own Voice.
2. `Shift+V` and `V` match upstream desktop shortcuts.
3. A successful recording immediately replays.
4. The successful recording remains replayable across later cards in the same Reviewer session.
5. Canceling a new recording preserves the previous successful recording.
6. Replay before any successful recording shows the exact expected message.
7. Own-voice playback interrupts current card audio without destroying the remembered card-audio replay queue.
8. Recording cannot let Auto Advance advance underneath the dialog.
9. Auto Advance restoration is generation/card safe.
10. Temporary recordings are cleaned on cancel, replacement, stale completion, and Reviewer disposal.
11. No recording is added to collection media or sent to the backend.
12. Android, iOS, and macOS microphone configuration is present.
13. Linux runtime dependencies are documented and installed in public validation.
14. No protobuf/generated backend files or stable operation IDs change.
15. Focused, full Flutter, and cross-platform public validation are green on the exact feature head.

## Deferred work

Intentionally deferred:

- shared Editor/Browser recording UI;
- microphone selection;
- persistent recording history;
- encoding/quality settings;
- waveform visualization;
- background recording.

Later features should extend the small recorder abstraction instead of expanding this Reviewer parity slice preemptively.
