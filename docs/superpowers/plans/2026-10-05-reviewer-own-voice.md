# Reviewer Own Voice Parity Implementation Plan

> **For implementation:** use `superpowers:executing-plans` and `superpowers:test-driven-development`. Execute sequentially in this session; do not dispatch subagents.

**Goal:** Add Anki Reviewer parity for **Record Own Voice** and **Replay Own Voice** on Android, iOS, Linux, macOS, and Windows.

**Architecture:** Add a `ReviewVoiceRecorder` boundary backed by `record` 7.1.1, extend the existing Reviewer audio service with one-shot playback that preserves the card-audio replay queue, keep own-voice state/lifecycle in `ReviewController`, and implement the recording modal in native Flutter. `AnkiAppRoot` provides the production recorder. Android/iOS/macOS receive microphone declarations; Linux runtime packages are documented and installed in public validation.

**Spec:** `docs/superpowers/specs/2026-10-05-reviewer-own-voice-design.md`

## Global constraints

- Match pinned upstream shortcuts exactly: `Shift+V` = Record Own Voice, `V` = Replay Own Voice.
- Recordings are temporary Reviewer-session files only. Never add them to collection media or write them through the Anki backend.
- A new recording replaces the previous successful recording only after finalization succeeds.
- Cancel, permission denial, start failure, failed/null finalization, and stale work preserve the previous successful recording.
- A successful recording immediately replays through the existing Reviewer audio service.
- Own-voice playback must not replace the logical card-audio replay queue.
- The successful recording persists across card transitions and same-card repeats for the lifetime of the Reviewer controller.
- Controller disposal cancels active recording and best-effort cleans the final successful file. Recorder-level `dispose()` is idempotent; do not require repeated `ChangeNotifier.dispose()` calls on `ReviewController` itself.
- Recording is a secondary surface: Auto Advance pauses while the modal is open and is restored only for the same generation/card through `ReviewSecondarySurfaceToken`.
- Existing `waitForAudio` must observe own-voice playback through the same `ReviewAudioService.playingChanges` signal.
- Typed-answer focus continues to suppress Reviewer shortcuts.
- No backend operation IDs, protobuf schemas/generated files, scheduler behavior, or Rust bridge mapping changes.
- No private AnkiFlutter Actions validation. Use public `Persie0/Playground`.
- Every handwritten behavior begins with a failing test.

## Review focus

1. **Replay queue integrity:** `Replay audio` / `R` must still replay card audio after own-voice playback.
2. **Replacement safety:** old successful audio is not deleted until the new file has finalized and been adopted.
3. **Null finalization:** recorder `stop()` returning `null` is a failed finalization. `stopOwnVoiceRecording()` must preserve the old recording and throw; it must not silently succeed.
4. **Stale/disposed async work:** late permission/start/stop completions cannot mutate Reviewer state; late output files are cleaned best-effort.
5. **Dialog cancellation:** explicit Cancel, system back, page disposal, and failure paths perform cleanup at most once.
6. **Cross-platform integration:** plugin/config builds on Android, iOS, Linux, macOS, and Windows; CI does not require physical microphone capture.
7. **Interface fallout:** all existing `ReviewAudioService`/`ReviewAudioPlayerAdapter` fakes compile after `playOneShot` is added.

---

## Task 1 — Add one-shot Reviewer playback without changing the card replay queue

**Files**
- Modify `app/lib/features/reviewer/audio/review_audio_service.dart`
- Modify `app/lib/features/reviewer/audio/media_kit_review_audio_player_adapter.dart`
- Modify `app/lib/features/reviewer/audio/native_media_kit_player_port.dart` only if needed
- Modify `app/test/features/reviewer/audio/review_audio_service_test.dart`
- Modify `app/test/features/reviewer/audio/media_kit_review_audio_player_adapter_test.dart`
- Update compile-only Reviewer test fakes that implement the changed interfaces

**API**

```dart
abstract interface class ReviewAudioPlayerAdapter {
  // existing members...
  Future<void> openOneShot(Uri item);
}

abstract interface class ReviewAudioService {
  // existing members...
  Future<void> playOneShot(Uri item);
}
```

### TDD steps

- [ ] Add RED service tests proving one-shot opens exactly one URI, leaves `_currentQueue` unchanged, and `replay()` afterwards reopens the previous card queue.
- [ ] Add RED adapter test proving one-shot delegates to the same media-kit player with a one-item source list and `play: true`.
- [ ] Run:

```bash
cd app
flutter test test/features/reviewer/audio/review_audio_service_test.dart test/features/reviewer/audio/media_kit_review_audio_player_adapter_test.dart
```

Expected RED: missing `playOneShot` / `openOneShot`.

- [ ] Implement `PlayerBackedReviewAudioService.playOneShot()` without assigning `_currentQueue`.
- [ ] Implement `MediaKitReviewAudioPlayerAdapter.openOneShot()` by reusing the existing source-opening path; do not create a second player.
- [ ] Search every implementation/fake of both changed interfaces and add the minimum method required for compilation.
- [ ] Run GREEN/regressions:

```bash
cd app
flutter test test/features/reviewer/audio test/features/reviewer/review_controller_audio_controls_test.dart test/features/reviewer/review_page_audio_controls_test.dart test/features/reviewer/review_page_shortcut_parity_test.dart
```

- [ ] Commit: `feat: add reviewer one-shot audio playback [skip ci]`

---

## Task 2 — Add `ReviewVoiceRecorder` and the `record` production adapter

**Files**
- Modify `app/pubspec.yaml`
- Modify `app/pubspec.lock`
- Create `app/lib/features/reviewer/audio/review_voice_recorder.dart`
- Create `app/lib/features/reviewer/audio/record_review_voice_recorder.dart`
- Create `app/test/features/reviewer/audio/record_review_voice_recorder_test.dart`

**Interface**

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

### TDD steps

- [ ] Add exact dependency `record: 7.1.1` and run `flutter pub get`; verify lockfile resolves exactly 7.1.1.
- [ ] Keep `AudioRecorder` behind a small injected/private port or constructor seam so tests never invoke platform channels.
- [ ] Add RED tests for permission delegation, unique temp `.wav` path, `AudioEncoder.wav`, one active recording, elapsed reset/update, stop result, cancel, errors, and idempotent recorder disposal.
- [ ] Run RED:

```bash
cd app
flutter test test/features/reviewer/audio/record_review_voice_recorder_test.dart
```

- [ ] Implement `RecordReviewVoiceRecorder`:
  - production `AudioRecorder`;
  - `hasPermission()`;
  - `RecordConfig(encoder: AudioEncoder.wav)`;
  - unique `review-own-voice-*.wav` under injected temp directory (`Directory.systemTemp` in production);
  - elapsed time generated in Dart, independent of plugin amplitude APIs;
  - `stop()` converts a non-null finalized path to `Uri.file(...)` and returns `null` unchanged when plugin produces no usable output;
  - `cancel()` clears active state in `finally`;
  - `dispose()` is idempotent, best-effort cancels active work, closes elapsed resources, and disposes the plugin recorder.
- [ ] Run GREEN + analyze:

```bash
cd app
flutter test test/features/reviewer/audio/record_review_voice_recorder_test.dart
flutter analyze lib/features/reviewer/audio test/features/reviewer/audio
```

- [ ] Commit: `feat: add reviewer voice recorder [skip ci]`

---

## Task 3 — Add own-voice state, replacement, cleanup, and stale guards to `ReviewController`

**Files**
- Modify `app/lib/features/reviewer/review_controller.dart`
- Create `app/test/features/reviewer/review_controller_own_voice_test.dart`
- Modify `app/test/features/reviewer/review_controller_stale_completion_test.dart` if useful

**Injection/API**

```dart
ReviewVoiceRecorder? voiceRecorder,
Future<void> Function(Uri uri)? ownVoiceFileDeleter,
```

```dart
bool get canRecordOwnVoice;
bool get hasRecordedOwnVoice;
Stream<Duration> get ownVoiceRecordingElapsed;

Future<ReviewOwnVoiceStartResult> beginOwnVoiceRecording();
Future<void> stopOwnVoiceRecording();
Future<void> cancelOwnVoiceRecording();
Future<bool> replayOwnVoice();

enum ReviewOwnVoiceStartResult {
  started,
  permissionDenied,
}
```

The default deleter only handles feature-owned `file:` URIs. Tests inject a recording deleter to verify exact cleanup.

### TDD steps

- [ ] RED capability/start tests:
  - capability requires both recorder and audio service;
  - unsupported elapsed stream is empty;
  - begin stops Reviewer audio before permission/start;
  - denial returns `permissionDenied` and never starts;
  - accepted permission starts exactly once;
  - start failure cancels the active attempt best-effort and rethrows;
  - elapsed stream forwards from recorder.
- [ ] RED stop/replay/replacement tests:
  - first successful stop adopts URI and immediately `playOneShot(newUri)`;
  - replay before success returns `false` without playback;
  - replay after success returns `true` and one-shots stored URI;
  - successful replacement adopts new URI, then best-effort deletes old URI, then plays new URI;
  - recorder `stop()` returning `null` is treated as failed finalization: preserve old URI, do not replay/delete it, and throw an explicit error such as `StateError`;
  - stop exception preserves old URI and rethrows;
  - playback failure after successful finalization keeps the new URI for retry.
- [ ] RED cancel/persistence/disposal tests:
  - cancel preserves previous successful URI;
  - successful recording survives question/answer transitions, ratings/card changes, undo, bury/suspend, and same-card repeats;
  - one controller disposal cancels active recording, deletes the final successful URI best-effort, and disposes recorder even if cleanup fails.
- [ ] RED stale/disposed tests with completers:
  - disposal during permission/start/stop cannot later mutate state;
  - output produced after disposal is cleaned;
  - an older attempt cannot replace a newer successful recording.
- [ ] Run RED:

```bash
cd app
flutter test test/features/reviewer/review_controller_own_voice_test.dart test/features/reviewer/review_controller_stale_completion_test.dart
```

- [ ] Implement operation generation/token guarding separately from card-generation state if needed.
- [ ] Required begin ordering: stop audio → permission → start → publish `started` only if operation still current.
- [ ] Required stop ordering: finalize → reject/clean stale output → require non-null usable URI → adopt → delete old best-effort → one-shot replay.
- [ ] Cancel only the active attempt; never clear prior successful recording.
- [ ] Disposal invalidates own-voice operations before async cleanup, then preserves existing audio/TTS disposal behavior.
- [ ] Run GREEN/regressions:

```bash
cd app
flutter test test/features/reviewer/review_controller_own_voice_test.dart test/features/reviewer/review_controller_stale_completion_test.dart test/features/reviewer/review_controller_card_info_test.dart test/features/reviewer/review_controller_auto_advance_parity_test.dart test/features/reviewer/review_controller_audio_controls_test.dart
```

- [ ] Commit: `feat: add reviewer own voice lifecycle [skip ci]`

---

## Task 4 — Add Reviewer menu actions, `Shift+V`/`V`, and deterministic recording dialog

**Files**
- Modify `app/lib/features/reviewer/review_page.dart`
- Create `app/test/features/reviewer/review_page_own_voice_test.dart`
- Modify `app/test/features/reviewer/review_page_shortcut_parity_test.dart`
- Modify `app/test/features/reviewer/review_page_typed_answer_test.dart` if focused suppression coverage is needed

Add `_ReviewAction.recordOwnVoice` and `_ReviewAction.replayOwnVoice`. Reuse `pauseForSecondarySurface()` / `resumeAfterSecondarySurface()`; never put recorder/plugin/file logic in the page.

### TDD steps

- [ ] RED menu/shortcut tests:
  - capability exposes `Record Own Voice` and `Replay Own Voice` even when card has no media;
  - unsupported controller does not expose actionable own-voice controls;
  - `Shift+V` records; plain `V` replays;
  - typed-answer focus suppresses both;
  - `_manualActionInProgress` blocks duplicate dispatch.
- [ ] RED replay feedback tests:
  - `false` shows exactly `You haven't recorded your voice yet.`;
  - `true` shows no empty-state warning;
  - playback error uses existing review-action error feedback.
- [ ] RED modal tests:
  - secondary surface is paused before microphone work;
  - first state is `Preparing microphone…`;
  - recording starts after first frame exactly once;
  - permission denial closes and shows microphone-permission feedback;
  - recording state shows elapsed time, Stop, Cancel;
  - Stop disables controls while pending and finalizes once;
  - Cancel and system back cancel exactly once;
  - barrier dismissal is disabled;
  - page/widget disposal while active triggers cancellation cleanup once;
  - start/stop errors close safely, restore secondary-surface lifecycle, and use normal error feedback.
- [ ] RED Auto Advance stale-return tests:
  - same generation/card restores prior enabled state after Stop/Cancel/denial/error;
  - changed generation/card never restores on the newer Reviewer state.
- [ ] Run RED:

```bash
cd app
flutter test test/features/reviewer/review_page_own_voice_test.dart test/features/reviewer/review_page_shortcut_parity_test.dart test/features/reviewer/review_page_typed_answer_test.dart
```

- [ ] Implement shortcuts with `SingleActivator(LogicalKeyboardKey.keyV, shift: true)` and plain `keyV`.
- [ ] Place menu items in the audio section, capability-driven by `canRecordOwnVoice` and independent of `hasReplayableAudio`.
- [ ] Implement a small private modal state machine: `preparing -> recording -> finishing/cancelling`; subscribe only to controller elapsed stream.
- [ ] Use `PopScope` (or current Flutter equivalent) so system back completes controller cancellation before close.
- [ ] Run GREEN/regressions:

```bash
cd app
flutter test test/features/reviewer/review_page_own_voice_test.dart test/features/reviewer/review_page_shortcut_parity_test.dart test/features/reviewer/review_page_typed_answer_test.dart test/features/reviewer/review_card_info_test.dart test/features/reviewer/review_page_audio_controls_test.dart
```

- [ ] Commit: `feat: add reviewer own voice controls [skip ci]`

---

## Task 5 — Wire production recorder and platform permissions/configuration

**Files**
- Modify `app/lib/app/anki_app_root.dart`
- Modify `app/android/app/src/main/AndroidManifest.xml`
- Modify `app/ios/Runner/Info.plist`
- Modify `app/macos/Runner/Info.plist`
- Modify `app/macos/Runner/DebugProfile.entitlements`
- Modify `app/macos/Runner/Release.entitlements`
- Modify `app/test/app/macos_entitlements_test.dart`
- Modify `app/test/app/mobile_native_bridge_config_test.dart` or create a focused platform-permissions test
- Modify `README.md`
- Modify `Persie0/Playground/.github/workflows/ankiflutter-validation.yml`

### TDD/config steps

- [ ] RED source tests asserting:
  - Android `android.permission.RECORD_AUDIO`;
  - iOS non-empty Reviewer-specific `NSMicrophoneUsageDescription`;
  - macOS same usage description;
  - both macOS entitlement files include `com.apple.security.device.audio-input` = true.
- [ ] Run RED:

```bash
cd app
flutter test test/app/macos_entitlements_test.dart test/app/mobile_native_bridge_config_test.dart
```

- [ ] In `AnkiAppRoot`, inject one new `RecordReviewVoiceRecorder` per `ReviewController`, with production temp-directory provider returning `Directory.systemTemp`.
- [ ] Add Android permission before `<application>`.
- [ ] Add iOS/macOS usage descriptions stating access is used only when the user chooses Record Own Voice in Reviewer.
- [ ] Add macOS audio-input entitlement to DebugProfile and Release.
- [ ] Windows: no extra manifest/config.
- [ ] README Linux runtime requirements: `parecord`, `pactl`, `ffmpeg`; Ubuntu install command `sudo apt-get install pulseaudio-utils ffmpeg`. Clarify recording is user-triggered and temporary.
- [ ] In public Playground workflow, add `pulseaudio-utils ffmpeg` to Ubuntu dependencies. Do not add physical-microphone tests. Commit this infrastructure change separately in Playground.
- [ ] Run GREEN + analyze:

```bash
cd app
flutter test test/app/macos_entitlements_test.dart test/app/mobile_native_bridge_config_test.dart
flutter analyze
```

- [ ] Commit product config: `feat: configure reviewer microphone access [skip ci]`

---

## Task 6 — Full verification, public cross-platform validation, and stacked PR

### Evidence and verification

- [ ] Preserve a focused RED result showing missing own-voice behavior rather than syntax/setup failure.
- [ ] Focused GREEN:

```bash
cd app
flutter analyze
flutter test test/features/reviewer/audio
flutter test test/features/reviewer/review_controller_own_voice_test.dart
flutter test test/features/reviewer/review_page_own_voice_test.dart
flutter test test/features/reviewer/review_page_shortcut_parity_test.dart
flutter test test/features/reviewer/review_controller_auto_advance_parity_test.dart
flutter test test/features/reviewer/review_controller_stale_completion_test.dart
flutter test test/app
```

- [ ] Full Flutter suite: `cd app && flutter test`.
- [ ] Dependency/generated cleanliness:

```bash
cd app
flutter pub get --enforce-lockfile
flutter analyze
cd ..
python3 tool/verify_generated_protos.py
```

- [ ] Confirm no generated protobuf or Rust/backend-operation changes.

### Public validation

Set `Persie0/Playground/ankiflutter-validation-target.txt` to the exact feature SHA and run the established workflow. One exact SHA must have all required jobs green (not cancelled/superseded):

- `quality-linux-android`: generated-proto check, Rust format/Clippy/tests, Flutter resolve/analyze/tests, Linux app, Android APK, real-backend integration.
- `ios`: bridge + simulator app.
- `macos`: bridge + release app.
- `windows`: bridge + release app.

### Final scope review

- [ ] Compare `feat/reviewer-delete-note...feat/reviewer-own-voice`.
- [ ] Confirm only intended own-voice implementation/config/tests/docs plus inherited Reviewer history.
- [ ] Confirm no backend op IDs/protos/Rust mapping changed.
- [ ] Confirm no collection-media writes and no microphone capture without explicit user action.
- [ ] Confirm cleanup is bounded to active/adopted own-voice temp file URIs.
- [ ] Confirm lockfile pins `record` exactly 7.1.1.
- [ ] If a final `[skip ci]` metadata commit is needed, verify its tree SHA is identical to the publicly validated feature tree.

### PR / merge

- [ ] Open stacked draft PR:

```text
base: feat/reviewer-delete-note
head: feat/reviewer-own-voice
title: feat: add reviewer own voice parity
```

- [ ] PR body includes feature semantics, shortcuts, temp-file lifecycle, replay-queue preservation, Auto Advance / `waitForAudio`, platform permissions/Linux requirements, and exact public validation run IDs/URLs.
- [ ] Check mergeability, reviews, unresolved threads, and absence of unintended private workflow usage.
- [ ] Verify PR head/tree matches the publicly validated implementation.
- [ ] If clean/green, mark ready and merge into `feat/reviewer-delete-note` under the standing reviewer-parity merge instruction.

## Final acceptance checklist

- [ ] `Shift+V` records; `V` replays.
- [ ] Recording UI is native Flutter and user-triggered only.
- [ ] Permission denial is non-destructive.
- [ ] Cancel/back/page-disposal cleanup is deterministic and single-shot.
- [ ] Successful recording immediately replays.
- [ ] Re-recording replaces only after successful finalization.
- [ ] Null/failed/cancelled replacement attempts preserve the previous successful recording.
- [ ] Recording remains available across Reviewer card changes in the same session.
- [ ] Card-audio replay still replays card audio after own-voice playback.
- [ ] Existing `waitForAudio` observes own-voice playback.
- [ ] Auto Advance pauses for the modal and restores only on the same card/generation.
- [ ] Temporary recordings are deleted on replacement/disposal and never enter collection media.
- [ ] Android/iOS/macOS microphone declarations are present.
- [ ] Linux dependencies are documented and installed in public validation.
- [ ] Windows needs no extra configuration.
- [ ] `record` is pinned to exactly 7.1.1.
- [ ] No backend/protobuf/Rust operation changes.
- [ ] Focused tests, full Flutter suite, and public cross-platform validation are green on the exact implementation tree.
