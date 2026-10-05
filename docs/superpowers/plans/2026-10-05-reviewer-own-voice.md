# Reviewer Own Voice Parity Implementation Plan

> **For implementation:** REQUIRED SUB-SKILL: use `superpowers:executing-plans` and `superpowers:test-driven-development`. Implement sequentially in this session; do not dispatch subagents.

**Goal:** Add Anki Reviewer parity for **Record Own Voice** and **Replay Own Voice** on Android, iOS, Linux, macOS, and Windows, using temporary WAV recordings, the existing Reviewer audio player, upstream shortcuts, and generation-safe Reviewer lifecycle behavior.

**Architecture:** Add a `ReviewVoiceRecorder` boundary with a `record` 7.1.1 production adapter, extend `ReviewAudioService` with one-shot playback that preserves the card-audio replay queue, keep all own-voice state/lifecycle in `ReviewController`, and implement a native Flutter modal flow in `ReviewPage`. Production composition happens in `AnkiAppRoot`. Platform permission/config changes are limited to Android/iOS/macOS, and Linux runtime dependencies are documented and added to the public Playground validation environment.

**Tech Stack:** Flutter 3.47.5 / Dart 3.13+, `record` 7.1.1, `media_kit`, `flutter_test`, existing public `Persie0/Playground` cross-platform validation.

**Spec:** `docs/superpowers/specs/2026-10-05-reviewer-own-voice-design.md`

## Global Constraints

- Match pinned upstream Reviewer shortcuts exactly: `Shift+V` = Record Own Voice, `V` = Replay Own Voice.
- Own-voice recordings are temporary Reviewer-session files only. Never write them through the Anki backend or into collection media.
- A successful new recording replaces the prior successful recording only after finalization succeeds.
- Cancel/permission denial/start failure/stop failure must preserve the prior successful recording.
- Successful recording immediately replays through the existing Reviewer audio service.
- One-shot own-voice playback must not replace the logical card-audio replay queue.
- Recording persists across card transitions and same-card repeats within one Reviewer controller lifetime.
- Dispose cancels active recording, cleans the final successful file, and disposes the recorder best-effort.
- Auto Advance must be paused for the recording modal and restored only for the same generation/card through the existing `ReviewSecondarySurfaceToken` lifecycle.
- Existing `waitForAudio` behavior must observe own-voice playback through the same `ReviewAudioService.playingChanges` signal.
- Typed-answer focus continues to suppress Reviewer shortcuts.
- No backend operation IDs, protobuf schemas, generated protobufs, scheduler behavior, or Rust bridge behavior change in this feature.
- No private AnkiFlutter Actions validation. Use public `Persie0/Playground` only.
- Every handwritten behavior starts RED before implementation.

## Review Focus

1. **Replay queue integrity:** after own-voice playback, `Replay audio` / `R` must still replay the current card-audio queue.
2. **Replacement safety:** never delete the old successful recording until a new file has finalized and been adopted.
3. **Stale/disposed async work:** late permission/start/stop completions must not mutate Reviewer state; any produced stale file is cleaned best-effort.
4. **Dialog cancellation:** explicit Cancel, system back, page disposal, and any failed start/stop path must invoke cancellation cleanup at most once.
5. **Auto Advance:** modal open pauses it; only same generation/card return may restore it.
6. **Cross-platform plugin integration:** package/config must build on Android, iOS, Linux, macOS, and Windows even though CI does not capture a real microphone.
7. **Interface fallout:** every existing fake implementation of `ReviewAudioService` / `ReviewAudioPlayerAdapter` must compile after adding `playOneShot`.

---

### Task 1: Add one-shot Reviewer playback without changing the card replay queue

**Files:**
- Modify: `app/lib/features/reviewer/audio/review_audio_service.dart`
- Modify: `app/lib/features/reviewer/audio/media_kit_review_audio_player_adapter.dart`
- Modify if needed: `app/lib/features/reviewer/audio/native_media_kit_player_port.dart`
- Modify: `app/test/features/reviewer/audio/review_audio_service_test.dart`
- Modify: `app/test/features/reviewer/audio/media_kit_review_audio_player_adapter_test.dart`
- Modify compile-only fakes implementing `ReviewAudioService` in existing Reviewer tests.

**Interfaces:**

Add:

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

`PlayerBackedReviewAudioService.playOneShot()` must call the player one-shot operation without mutating `_currentQueue`.

- [ ] **Step 1: Write RED service tests**

Add tests proving:

- `playOneShot(uri)` opens exactly that URI;
- existing `_currentQueue` remains intact;
- calling `replay()` after one-shot playback reopens the prior card queue, not the own-voice URI;
- `playOneShot()` after disposal throws the same unusable-service error behavior as other active controls;
- `playingChanges` remains the same underlying player stream.

- [ ] **Step 2: Write RED adapter tests**

Assert `openOneShot(file:///tmp/voice.wav)` delegates to the same media-kit player with exactly one source and immediate play.

- [ ] **Step 3: Run RED**

```bash
cd app
flutter test \
  test/features/reviewer/audio/review_audio_service_test.dart \
  test/features/reviewer/audio/media_kit_review_audio_player_adapter_test.dart
```

Expected: FAIL because `playOneShot` / `openOneShot` do not exist.

- [ ] **Step 4: Implement the minimum playback API**

Implementation shape:

```dart
Future<void> playOneShot(Uri item) async {
  _ensureUsable();
  await _player.openOneShot(item);
}
```

`MediaKitReviewAudioPlayerAdapter.openOneShot()` should reuse `openSources([item.toString()], play: true)`; do not create a second player.

- [ ] **Step 5: Update existing test fakes**

Search for every `implements ReviewAudioService` and `implements ReviewAudioPlayerAdapter`; add the minimum `playOneShot` / `openOneShot` implementation so the full suite compiles. Do not change unrelated test semantics.

- [ ] **Step 6: Run GREEN + audio regression suite**

```bash
cd app
flutter test test/features/reviewer/audio test/features/reviewer/review_controller_audio_controls_test.dart test/features/reviewer/review_page_audio_controls_test.dart test/features/reviewer/review_page_shortcut_parity_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/features/reviewer/audio app/test/features/reviewer app/test/features/reviewer/audio
git commit -m "feat: add reviewer one-shot audio playback [skip ci]"
```

---

### Task 2: Add `ReviewVoiceRecorder` and the `record` production adapter

**Files:**
- Modify: `app/pubspec.yaml`
- Modify: `app/pubspec.lock`
- Create: `app/lib/features/reviewer/audio/review_voice_recorder.dart`
- Create: `app/lib/features/reviewer/audio/record_review_voice_recorder.dart`
- Create: `app/test/features/reviewer/audio/record_review_voice_recorder_test.dart`

**Interfaces:**

Create exactly:

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

Production adapter: `RecordReviewVoiceRecorder` over `package:record` 7.1.1.

For unit-testability, keep the plugin call surface behind a small injected/private port or constructor seam rather than invoking platform channels directly in tests.

- [ ] **Step 1: Add the dependency and lock exact version**

Add:

```yaml
record: 7.1.1
```

Run:

```bash
cd app
flutter pub get
```

Verify `pubspec.lock` resolves `record` exactly to `7.1.1` and preserves the existing Flutter/Dart constraints.

- [ ] **Step 2: Write RED adapter tests**

Tests must prove:

- `ensurePermission()` delegates to the plugin permission check and returns its boolean result;
- `start()` generates a unique `.wav` path below the injected temp directory;
- start uses `AudioEncoder.wav`;
- second concurrent `start()` is rejected or otherwise prevented deterministically;
- elapsed stream resets to zero for each recording and advances only while active;
- `stop()` returns the finalized file URI and clears active state;
- `stop()` with no active recording is safely handled according to the adapter contract;
- `cancel()` abandons the active recording, stops elapsed updates, and clears active state;
- `dispose()` cancels active work and is idempotent;
- plugin start/stop/cancel failures do not leave `isRecording` stuck true.

Do not require a physical microphone in unit tests.

- [ ] **Step 3: Run RED**

```bash
cd app
flutter test test/features/reviewer/audio/record_review_voice_recorder_test.dart
```

Expected: FAIL because the recorder abstraction/adapter does not exist.

- [ ] **Step 4: Implement the abstraction and adapter**

Production behavior:

- construct/use `AudioRecorder`;
- permission via `hasPermission()`;
- start with `RecordConfig(encoder: AudioEncoder.wav)`;
- unique path such as `review-own-voice-<unique>.wav` under an injected temp-directory provider (production: `Directory.systemTemp`);
- elapsed duration generated in Dart from the recording start time/timer so UI is not coupled to plugin-specific amplitude APIs;
- `stop()` converts the finalized returned path to `Uri.file(...)`;
- `cancel()` delegates to plugin cancel and clears local active state in `finally`;
- `dispose()` is idempotent, cancels an active attempt best-effort, closes elapsed resources, and disposes the plugin recorder.

- [ ] **Step 5: Run GREEN**

```bash
cd app
flutter test test/features/reviewer/audio/record_review_voice_recorder_test.dart
flutter analyze lib/features/reviewer/audio test/features/reviewer/audio
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/pubspec.yaml app/pubspec.lock app/lib/features/reviewer/audio app/test/features/reviewer/audio
git commit -m "feat: add reviewer voice recorder [skip ci]"
```

---

### Task 3: Add own-voice state, replacement, cleanup, and stale-completion guards to `ReviewController`

**Files:**
- Modify: `app/lib/features/reviewer/review_controller.dart`
- Create: `app/test/features/reviewer/review_controller_own_voice_test.dart`
- Modify as needed: `app/test/features/reviewer/review_controller_stale_completion_test.dart`

**Interfaces:**

Inject:

```dart
ReviewVoiceRecorder? voiceRecorder,
Future<void> Function(Uri uri)? ownVoiceFileDeleter,
```

Expose:

```dart
bool get canRecordOwnVoice;
bool get hasRecordedOwnVoice;
Stream<Duration> get ownVoiceRecordingElapsed;

Future<ReviewOwnVoiceStartResult> beginOwnVoiceRecording();
Future<void> stopOwnVoiceRecording();
Future<void> cancelOwnVoiceRecording();
Future<bool> replayOwnVoice();
```

and:

```dart
enum ReviewOwnVoiceStartResult {
  started,
  permissionDenied,
}
```

The default deleter should best-effort delete only `file:` URIs owned by this feature; test injection records exactly what is cleaned.

- [ ] **Step 1: Write RED capability/start tests**

Assert:

- `canRecordOwnVoice == true` only when both recorder and audio service are injected;
- no recorder/audio -> `false` and empty elapsed stream;
- begin stops current Reviewer audio before permission/start;
- permission denied returns `permissionDenied` and never calls recorder start;
- permission accepted starts exactly once and returns `started`;
- start failure cancels/cleans the active attempt best-effort and rethrows;
- elapsed stream is forwarded from the recorder.

- [ ] **Step 2: Write RED stop/replay/replacement tests**

Assert:

- first successful stop stores the new URI and immediately calls `audio.playOneShot(newUri)`;
- `hasRecordedOwnVoice` becomes true only after successful finalization;
- `replayOwnVoice()` returns false and performs no playback before any success;
- after success, replay returns true and one-shots the stored URI;
- successful second recording adopts new URI, then deletes the old URI, then plays the new URI;
- stop returning `null` preserves the old successful URI and does not delete/replay partial output;
- stop failure preserves the old URI and rethrows;
- playback failure after successful finalization keeps the new URI for retry.

- [ ] **Step 3: Write RED cancel/persistence/disposal tests**

Assert:

- cancel invokes recorder cancel and leaves prior successful recording untouched;
- successful recording persists across `showAnswer()`, ratings/card transitions, undo, bury/suspend, and same-card repeats;
- controller disposal cancels active recording, deletes the last successful URI best-effort, disposes recorder, and remains safe when cleanup fails;
- duplicate dispose does not double-delete/double-dispose.

- [ ] **Step 4: Write RED stale/disposed completion tests**

Use completers in a fake recorder to prove:

- controller disposed while permission is pending cannot start/adopt later;
- disposed while start is pending cannot mutate state;
- disposed while stop is pending cannot adopt/replay late output;
- any URI produced after disposal is passed to the cleanup helper;
- a late old attempt cannot replace a newer successful recording.

Use an own-voice operation generation/token separate from the Reviewer card generation if necessary so recording staleness is explicit and testable.

- [ ] **Step 5: Run RED**

```bash
cd app
flutter test test/features/reviewer/review_controller_own_voice_test.dart test/features/reviewer/review_controller_stale_completion_test.dart
```

Expected: FAIL because the own-voice controller API does not exist.

- [ ] **Step 6: Implement minimum controller orchestration**

Required ordering:

**Begin**
1. verify supported/not disposed/current operation;
2. `await _audio!.stop()`;
3. `await _voiceRecorder!.ensurePermission()`;
4. if denied, return `permissionDenied`;
5. start recording;
6. return `started` only for the still-current operation.

**Stop success**
1. finalize to `newUri`;
2. if stale/disposed, delete `newUri` and exit without state mutation;
3. adopt `newUri`;
4. best-effort delete old successful URI;
5. `await _audio!.playOneShot(newUri)`.

**Cancel**
- cancel only the active attempt; never clear the previous successful recording.

**Dispose**
- invalidate own-voice operations before async cleanup;
- cancel active recorder, delete final successful URI, dispose recorder best-effort;
- preserve existing audio/TTS disposal behavior.

- [ ] **Step 7: Run GREEN + Reviewer lifecycle regressions**

```bash
cd app
flutter test \
  test/features/reviewer/review_controller_own_voice_test.dart \
  test/features/reviewer/review_controller_stale_completion_test.dart \
  test/features/reviewer/review_controller_card_info_test.dart \
  test/features/reviewer/review_controller_auto_advance_parity_test.dart \
  test/features/reviewer/review_controller_audio_controls_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/features/reviewer/review_controller.dart app/test/features/reviewer
git commit -m "feat: add reviewer own voice lifecycle [skip ci]"
```

---

### Task 4: Add Reviewer menu actions, `Shift+V`/`V`, and deterministic recording dialog

**Files:**
- Modify: `app/lib/features/reviewer/review_page.dart`
- Create: `app/test/features/reviewer/review_page_own_voice_test.dart`
- Modify: `app/test/features/reviewer/review_page_shortcut_parity_test.dart`
- Modify: `app/test/features/reviewer/review_page_typed_answer_test.dart` if needed for focused shortcut suppression coverage.

**Interfaces:**

Add `_ReviewAction.recordOwnVoice` and `_ReviewAction.replayOwnVoice`.

Reuse existing:

```dart
ReviewSecondarySurfaceToken? pauseForSecondarySurface();
void resumeAfterSecondarySurface(ReviewSecondarySurfaceToken token);
```

Do not put plugin/file logic into `ReviewPage`.

- [ ] **Step 1: Write RED menu/shortcut tests**

Assert:

- when `controller.canRecordOwnVoice` is true, menu shows `Record Own Voice` and `Replay Own Voice` even if the card has no media;
- unsupported controller hides/disables those menu actions consistently with existing capability-driven UI;
- `Shift+V` invokes Record Own Voice;
- `V` invokes Replay Own Voice;
- typed-answer focus suppresses both `V` shortcuts;
- `_manualActionInProgress` prevents duplicate record/replay action dispatch.

- [ ] **Step 2: Write RED replay feedback tests**

Assert:

- controller `replayOwnVoice() == false` shows exactly `You haven't recorded your voice yet.`;
- `true` produces no empty-state warning;
- thrown playback error uses the existing `Could not apply review action: ...` feedback path.

- [ ] **Step 3: Write RED modal state tests**

Use a fake recorder/controller seam and assert:

- invoking Record pauses Auto Advance through `pauseForSecondarySurface()` before microphone work;
- dialog initially renders `Preparing microphone…`;
- recording begins only after the dialog is mounted/first frame and exactly once;
- permission denial closes the dialog, restores lifecycle, and shows a concise microphone-permission message;
- recording state renders elapsed time plus `Stop` and `Cancel`;
- Stop disables actions while pending, finalizes once, closes on success, and leaves controller immediate replay to Task 3 logic;
- Cancel calls controller cancellation once and closes;
- system back routes through the same cancellation path exactly once;
- `barrierDismissible` is false;
- page/widget disposal while dialog is active triggers cancellation cleanup once;
- start/stop failure closes/finishes safely, resumes the secondary-surface lifecycle, and uses existing error feedback.

- [ ] **Step 4: Write RED Auto Advance stale-return tests**

Assert:

- same generation/card restores previously enabled Auto Advance after Stop/Cancel/denial/error;
- changed generation/card while permission/start/stop is pending does not restore Auto Advance on the newer card.

Reuse the existing generation-safe `ReviewSecondarySurfaceToken` behavior rather than duplicating card checks in the dialog.

- [ ] **Step 5: Run RED**

```bash
cd app
flutter test \
  test/features/reviewer/review_page_own_voice_test.dart \
  test/features/reviewer/review_page_shortcut_parity_test.dart \
  test/features/reviewer/review_page_typed_answer_test.dart
```

Expected: FAIL because the actions/dialog do not exist.

- [ ] **Step 6: Implement actions and shortcuts**

Add:

```dart
const SingleActivator(LogicalKeyboardKey.keyV, shift: true)
const SingleActivator(LogicalKeyboardKey.keyV)
```

with Shift mapping to Record and plain V to Replay. Keep the existing top-level typed-answer-focus suppression unchanged.

Place menu items in the Reviewer audio section, capability-driven by `canRecordOwnVoice` and independent of `hasReplayableAudio`.

- [ ] **Step 7: Implement the modal as a small private stateful widget/helper**

Keep deterministic states:

```text
preparing -> recording -> finishing
                |-> cancelling
```

The modal owns only presentation and one-shot UI invocation guards. It subscribes to `controller.ownVoiceRecordingElapsed`; it never sees file paths or `package:record`.

Use `PopScope`/the current Flutter equivalent so system back performs controller cancellation before allowing closure. Do not allow barrier dismissal.

- [ ] **Step 8: Run GREEN + existing Reviewer page tests**

```bash
cd app
flutter test test/features/reviewer/review_page_own_voice_test.dart test/features/reviewer/review_page_shortcut_parity_test.dart test/features/reviewer/review_page_typed_answer_test.dart test/features/reviewer/review_card_info_test.dart test/features/reviewer/review_page_audio_controls_test.dart
```

Expected: PASS.

- [ ] **Step 9: Commit**

```bash
git add app/lib/features/reviewer/review_page.dart app/test/features/reviewer
git commit -m "feat: add reviewer own voice controls [skip ci]"
```

---

### Task 5: Wire production recorder and platform permissions/configuration

**Files:**
- Modify: `app/lib/app/anki_app_root.dart`
- Modify: `app/android/app/src/main/AndroidManifest.xml`
- Modify: `app/ios/Runner/Info.plist`
- Modify: `app/macos/Runner/Info.plist`
- Modify: `app/macos/Runner/DebugProfile.entitlements`
- Modify: `app/macos/Runner/Release.entitlements`
- Modify: `app/test/app/macos_entitlements_test.dart`
- Modify: `app/test/app/mobile_native_bridge_config_test.dart` or create a focused platform-permissions test file
- Modify: `README.md`
- Modify in public validation repo: `Persie0/Playground/.github/workflows/ankiflutter-validation.yml`

**Production composition:**

`AnkiAppRoot` must inject one `RecordReviewVoiceRecorder` per `ReviewController`, using `Directory.systemTemp`, beside the existing audio/TTS dependencies.

- [ ] **Step 1: Write RED platform-config tests**

Assert source files contain:

- Android `android.permission.RECORD_AUDIO`;
- iOS `NSMicrophoneUsageDescription` with non-empty Reviewer-specific text;
- macOS `NSMicrophoneUsageDescription`;
- both macOS entitlement files contain `com.apple.security.device.audio-input` set true.

Keep existing native-bridge/network/file-access assertions intact.

- [ ] **Step 2: Run RED platform tests**

```bash
cd app
flutter test test/app/macos_entitlements_test.dart test/app/mobile_native_bridge_config_test.dart
```

Expected: FAIL on missing microphone configuration.

- [ ] **Step 3: Add production wiring**

In `AnkiAppRoot`, inject:

```dart
voiceRecorder: RecordReviewVoiceRecorder(
  tempDirectoryProvider: () async => Directory.systemTemp,
),
```

Use the adapter's real constructor shape from Task 2. No global recorder singleton: Reviewer controller owns its recorder lifetime.

- [ ] **Step 4: Add platform permission/config files**

Android:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

before `<application>`.

iOS/macOS usage text should state that microphone access is used only when the user chooses Record Own Voice in Reviewer.

macOS both entitlements:

```xml
<key>com.apple.security.device.audio-input</key>
<true/>
```

- [ ] **Step 5: Document Linux runtime requirements**

Update README Linux setup with:

```text
parecord
pactl
ffmpeg
```

and Ubuntu package install guidance:

```bash
sudo apt-get install pulseaudio-utils ffmpeg
```

Clarify that microphone capture is user-invoked Reviewer functionality and recordings are temporary.

- [ ] **Step 6: Update public Playground validation environment**

In `Persie0/Playground/.github/workflows/ankiflutter-validation.yml`, add `pulseaudio-utils ffmpeg` to the Ubuntu dependency install step. Do not add hardware microphone tests.

This Playground change is validation infrastructure, not product behavior. Commit it separately in Playground and keep its workflow otherwise unchanged.

- [ ] **Step 7: Run GREEN source/config tests**

```bash
cd app
flutter test test/app/macos_entitlements_test.dart test/app/mobile_native_bridge_config_test.dart
flutter analyze
```

Expected: PASS.

- [ ] **Step 8: Commit product configuration**

```bash
git add app/lib/app/anki_app_root.dart app/android/app/src/main/AndroidManifest.xml app/ios/Runner/Info.plist app/macos/Runner/Info.plist app/macos/Runner/DebugProfile.entitlements app/macos/Runner/Release.entitlements app/test/app README.md
git commit -m "feat: configure reviewer microphone access [skip ci]"
```

Commit the Playground workflow update separately in `Persie0/Playground`.

---

### Task 6: Focused RED/GREEN evidence, full verification, public cross-platform validation, and stacked PR

**Files:**
- Product: all Task 1–5 files only, plus test-fake compile updates required by the new audio interface.
- Validation repo: only the Playground dependency line and validation target file when dispatching.

- [ ] **Step 1: Preserve RED evidence before implementation**

For the first own-voice behavior test added in Task 1/2/3/4, record a public Playground focused RED run against the exact RED commit or otherwise retain the exact failing test output in the implementation notes. The failure must be due to missing own-voice behavior, not syntax/setup errors.

- [ ] **Step 2: Run focused Reviewer GREEN locally/publicly**

At minimum:

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

- [ ] **Step 3: Run full Flutter suite**

```bash
cd app
flutter test
```

Expected: PASS.

- [ ] **Step 4: Verify dependency/config cleanliness**

Run:

```bash
cd app
flutter pub get --enforce-lockfile
flutter analyze
cd ..
python3 tool/verify_generated_protos.py
```

Expected:

- lockfile is reproducible;
- no generated protobuf diff;
- no backend/Rust operation change caused by this feature.

- [ ] **Step 5: Validate exact feature SHA in public Playground**

Set `Persie0/Playground/ankiflutter-validation-target.txt` to the exact AnkiFlutter feature SHA and run the established cross-platform workflow.

Required GREEN jobs:

- `quality-linux-android`
  - generated Dart protos verification
  - Rust format
  - strict Clippy
  - Rust tests
  - Flutter dependency resolution
  - Flutter analyze
  - full Flutter tests
  - Linux bridge/app build
  - Android APK build
  - real-backend integration
- `ios`
  - iOS bridge
  - simulator app
- `macos`
  - bridge + release app
- `windows`
  - bridge + release app

Do not consider a superseded/cancelled run sufficient. Validate one exact feature SHA with all required jobs successful.

- [ ] **Step 6: Inspect feature diff against current Reviewer parity base**

Compare `feat/reviewer-delete-note...feat/reviewer-own-voice` and confirm only intended own-voice files/config/tests/docs are present plus existing stacked Card Info history inherited from the base.

Explicitly verify:

- no backend op IDs/protos/Rust mapping changed;
- no collection media writes were added;
- no microphone capture can begin without user action;
- card replay queue remains separate from own-voice one-shot playback;
- temporary file cleanup paths are bounded to adopted/active own-voice file URIs;
- package lock pins `record` 7.1.1.

- [ ] **Step 7: If needed, create a tree-identical final `[skip ci]` commit**

Only if private Actions would otherwise run or metadata needs cleanup. If doing this, verify the final commit tree SHA is identical to the publicly validated feature tree SHA.

- [ ] **Step 8: Open stacked draft PR**

Create PR:

```text
base: feat/reviewer-delete-note
head: feat/reviewer-own-voice
title: feat: add reviewer own voice parity
```

PR body should summarize:

- Record/Replay Own Voice parity;
- `Shift+V` / `V` shortcuts;
- temporary WAV lifecycle and cancellation semantics;
- shared one-shot Reviewer playback preserving card replay queue;
- Auto Advance + `waitForAudio` integration;
- Android/iOS/macOS permissions and Linux runtime requirements;
- exact public validation run URLs/IDs.

- [ ] **Step 9: Final review and merge**

Before marking ready/merging:

- check PR mergeability;
- check reviews and unresolved review threads;
- verify no unintended private workflow usage;
- verify the PR head/tree is the publicly validated implementation;
- re-check the approved design scope.

If clean and green, mark ready and merge into `feat/reviewer-delete-note` under the standing instruction to merge completed reviewer-parity child PRs.

---

## Final Acceptance Checklist

- [ ] `Shift+V` records; `V` replays.
- [ ] Recording UI is native Flutter and user-triggered only.
- [ ] Permission denial is non-destructive.
- [ ] Cancel/back/page-disposal cleanup is deterministic and single-shot.
- [ ] Successful recording immediately replays.
- [ ] Re-recording replaces only after successful finalization.
- [ ] Previous successful recording survives failed/cancelled replacement attempts.
- [ ] Recording remains available across Reviewer card changes during the same session.
- [ ] Card-audio `Replay audio` still replays card audio after own-voice playback.
- [ ] Existing `waitForAudio` observes own-voice playback.
- [ ] Auto Advance pauses for modal recording and restores only on the same card/generation.
- [ ] Temporary recordings are deleted on replacement/disposal and never enter collection media.
- [ ] Android/iOS/macOS microphone declarations are present.
- [ ] Linux dependencies are documented and installed in public validation.
- [ ] Windows requires no extra manifest/config.
- [ ] `record` is pinned to exactly 7.1.1.
- [ ] No backend/protobuf/Rust operation changes.
- [ ] Focused tests, full Flutter suite, and all public cross-platform validation jobs are green on the exact implementation tree.
