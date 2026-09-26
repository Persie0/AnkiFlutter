# AnkiFlutter Reviewer Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a real Anki-compatible desktop Reviewer that closely mirrors official Anki Desktop behavior, including queueing, card rendering, grading, audio/TTS, keyboard shortcuts, undo, bury/suspend, timers, and end-of-queue flow on Windows, macOS, and Linux from one shared Flutter codebase.

**Architecture:** Extend the existing descriptor-driven Rust bridge and `BackendInvoker` transport with the exact upstream Reviewer operations, then map protobuf data into small Dart domain models and a constructor-injected `ReviewController`. Card HTML runs in one shared Chromium/CEF `CardSurface`, while scheduling, FSRS, rendering semantics, deck configuration, undo, and collection mutations remain authoritative in pinned Anki `rslib`.

**Tech Stack:** Flutter 3.47.5 / Dart 3.13.4; `webview_cef` 0.6.2; `media_kit` 1.2.6 plus the platform media libs required for desktop audio; `ffi` 2.2.0; `protobuf` 6.1.0; Rust 1.88; official `ankitects/anki` commit `a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`; CEF 149 through `webview_cef`.

**Spec:** `docs/superpowers/specs/2026-09-26-reviewer-parity-design.md`

## Global Constraints

- Preserve strict Red -> Green -> Refactor TDD for every handwritten behavior.
- The behavioral/UX reference is official Anki Desktop Reviewer at upstream commit `a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`.
- Keep one shared Flutter/Dart Reviewer implementation across Windows, macOS, and Linux.
- Do not calculate scheduling, FSRS, leech state, intervals, collection mutations, or deck-review settings in Dart when upstream Anki exposes them.
- Generated protobuf types remain behind repositories/adapters and must not leak into widgets.
- Continue using the existing generic FFI transport; do not add one FFI function per Reviewer operation.
- Native Anki service/method indexes are generated from the pinned descriptor set; never hard-code upstream service or method indices.
- Use `webview_cef` 0.6.2 as the one embedded Chromium surface on Windows/macOS/Linux.
- Include audio/TTS in this milestone.
- Arbitrary Python/PyQt add-ons and custom Python field filters remain out of scope.
- Keep the collection open when navigating between overview and Reviewer.
- Never expose arbitrary local files through the card media server.

## Review Focus

- **Stale async completions:** if card A finishes rendering/answering after card B became current, card A must never overwrite card B state. Task 6 adds generation-token tests.
- **Unsafe media paths:** traversal (`..`), percent-encoded traversal, absolute paths, and symlink escapes must be rejected. Task 4 pins all four cases.
- **Duplicate grading input:** rapid double-click/key presses while a grade is in flight must produce one backend answer only. Task 6 tests transition-state command suppression.
- **Renderer failure:** CEF initialization/load failure must show a recoverable Reviewer error instead of hanging or losing the collection session. Task 8 covers this.
- **Audio/auto-advance race:** wait-for-audio must defer timeout actions until playback is actually idle, without firing twice. Task 7 tests the race explicitly.

---

## File structure for this milestone

New feature files should stay under `app/lib/features/reviewer/` and remain small by responsibility:

```text
app/lib/features/reviewer/
  models/
    review_answer_choice.dart
    review_card.dart
    review_card_content.dart
    review_counts.dart
    review_deck_settings.dart
    review_rating.dart
    review_session_state.dart
  data/
    anki_review_repository.dart
    anki_card_render_repository.dart
    review_repository.dart
    card_render_repository.dart
  audio/
    review_audio_service.dart
    media_kit_review_audio_service.dart
    review_tts_service.dart
  media/
    review_media_server.dart
  surface/
    card_surface.dart
    cef_card_surface.dart
    reviewer_bridge_message.dart
  review_controller.dart
  review_shortcuts.dart
  review_page.dart
```

Tests mirror those responsibilities under `app/test/features/reviewer/`. Native bridge tests remain in `native/anki_bridge/tests/`. One real-backend Reviewer flow is added under `app/integration_test/`.

---

### Task 1: Extend the descriptor-driven native Reviewer operation surface

**Files:**
- Modify: `native/anki_bridge/build.rs`
- Modify: `native/anki_bridge/src/ffi.rs`
- Modify: `native/anki_bridge/tests/operation_indices.rs`
- Modify: `native/anki_bridge/tests/ffi_contract.rs`
- Modify: `app/lib/core/backend/backend_operation.dart`
- Test: `app/test/core/backend/backend_operation_test.dart`

**Interfaces:**
- Consumes: existing `BackendInvoker.invoke(BackendOperation operation, Uint8List request)`.
- Produces these stable operation ids:
  - `setCurrentDeck(4)` -> `BackendDecksService.set_current_deck`
  - `getQueuedCards(5)` -> `BackendSchedulerService.get_queued_cards`
  - `describeNextStates(6)` -> `BackendSchedulerService.describe_next_states`
  - `answerCard(7)` -> `BackendSchedulerService.answer_card`
  - `stateIsLeech(8)` -> `BackendSchedulerService.state_is_leech`
  - `buryOrSuspendCards(9)` -> `BackendSchedulerService.bury_or_suspend_cards`
  - `getUndoStatus(10)` -> `BackendCollectionService.get_undo_status`
  - `undo(11)` -> `BackendCollectionService.undo`
  - `renderExistingCard(12)` -> `BackendCardRenderingService.render_existing_card`
  - `extractAvTags(13)` -> `BackendCardRenderingService.extract_av_tags`
  - `allTtsVoices(14)` -> `BackendCardRenderingService.all_tts_voices`
  - `writeTtsStream(15)` -> `BackendCardRenderingService.write_tts_stream`
  - `getDeckConfigsForUpdate(16)` -> `BackendDeckConfigService.get_deck_configs_for_update`
  - `encodeIriPaths(17)` -> `BackendCardRenderingService.encode_iri_paths`

- [ ] **Step 1: Write the failing Rust operation-index test**

Extend `required_operations_are_distinct_and_available` so the array contains all 17 bridge operations and asserts all generated `OperationIndex` values are pairwise distinct.

- [ ] **Step 2: Run the focused Rust test and confirm RED**

Run: `cargo test --manifest-path native/anki_bridge/Cargo.toml --test operation_indices`

Expected: compile failure for missing Reviewer operation constants.

- [ ] **Step 3: Add descriptor lookups in `build.rs`**

Generate the named constants above by service/method name using the existing `operation()` helper; do not add numeric service/method indexes.

- [ ] **Step 4: Extend the stable FFI id mapping**

Update `operation_from_id()` in `ffi.rs` with ids 4-17 and keep 1-3 unchanged for compatibility.

- [ ] **Step 5: Run Rust operation/FFI tests and confirm GREEN**

Run: `cargo test --manifest-path native/anki_bridge/Cargo.toml --test operation_indices --test ffi_contract`

Expected: PASS.

- [ ] **Step 6: Write the failing Dart stable-id test**

Create `backend_operation_test.dart` asserting ids 1-17 exactly match the contract above and are unique.

- [ ] **Step 7: Run the focused Dart test and confirm RED**

Run: `cd app && flutter test test/core/backend/backend_operation_test.dart`

Expected: compile/assertion failure because Reviewer enum values do not exist.

- [ ] **Step 8: Extend `BackendOperation` and rerun GREEN**

Add the values with the exact ids above, then rerun the focused test.

- [ ] **Step 9: Run relevant suites and commit**

Run:
- `cargo test --manifest-path native/anki_bridge/Cargo.toml`
- `cd app && flutter test test/core/backend`

Commit: `feat: expose reviewer backend operations`

---

### Task 2: Map scheduler queue data into stable Reviewer domain models

**Files:**
- Create: `app/lib/features/reviewer/models/review_rating.dart`
- Create: `app/lib/features/reviewer/models/review_counts.dart`
- Create: `app/lib/features/reviewer/models/review_answer_choice.dart`
- Create: `app/lib/features/reviewer/models/review_card.dart`
- Create: `app/lib/features/reviewer/models/review_deck_settings.dart`
- Create: `app/lib/features/reviewer/data/review_repository.dart`
- Create: `app/lib/features/reviewer/data/anki_review_repository.dart`
- Test: `app/test/features/reviewer/data/anki_review_repository_test.dart`

**Interfaces:**
- `enum ReviewRating { again, hard, good, easy }`
- `ReviewCounts(newCount, learningCount, reviewCount)`
- `ReviewAnswerChoice(rating, intervalLabel, schedulingStateBytes)` where `schedulingStateBytes` is an opaque immutable `Uint8List` owned by the repository/controller boundary, not a generated protobuf object.
- `ReviewCard` contains: `int cardId`, `int noteId`, `int deckId`, `ReviewCounts counts`, `Uint8List currentStateBytes`, `List<ReviewAnswerChoice> choices`, `String deckName`, plus scheduler context fields only if later tasks need them.
- `ReviewDeckSettings` contains exactly: `autoplay`, `showTimer`, `stopTimerOnAnswer`, `answerTimeLimitSeconds`, `secondsToShowQuestion`, `secondsToShowAnswer`, `waitForAudio`, `skipQuestionWhenReplayingAnswer`, `questionAction`, `answerAction`.
- `ReviewRepository` exposes:
  - `Future<void> selectDeck(int deckId)`
  - `Future<ReviewCard?> nextCard()`
  - `Future<void> answer(ReviewCard card, ReviewRating rating, {required int answeredAtMillis, required int millisecondsTaken})`
  - `Future<bool> stateIsLeech(ReviewAnswerChoice choice)`
  - `Future<ReviewDeckSettings> settingsForDeck(int deckId)`
  - mutation/undo methods added in Task 7.

- [ ] **Step 1: Write RED repository mapping tests**

Test that `getQueuedCards` maps the first queued card, queue counts, card/note/deck ids, current state, all four rating states, and copies `card.customData` into the current scheduling state's `customData` before preserving it as opaque bytes.

- [ ] **Step 2: Run focused test and confirm RED**

Run: `cd app && flutter test test/features/reviewer/data/anki_review_repository_test.dart`

Expected: compile failure for missing repository/models.

- [ ] **Step 3: Implement `selectDeck()` and `nextCard()` minimally**

Use `DeckId`, `GetQueuedCardsRequest(fetchLimit: 1, intradayLearningOnly: false)`, and `QueuedCards.fromBuffer`. Return `null` when upstream returns no cards.

- [ ] **Step 4: Add RED interval-description test**

Given scheduler states and a `StringList` response from `describeNextStates`, assert labels map in Again/Hard/Good/Easy order and no interval arithmetic exists in Dart.

- [ ] **Step 5: Implement interval mapping and run GREEN**

Invoke `describeNextStates` with the exact `SchedulingStates` from the queue response and attach returned strings to the four choices.

- [ ] **Step 6: Add RED answer serialization test**

Assert `answer()` sends `CardAnswer` containing the queued current state, the selected upstream new state, rating enum, exact `answeredAtMillis`, and exact `millisecondsTaken`.

- [ ] **Step 7: Implement answer serialization and run GREEN**

Do not rebuild scheduling states from domain fields; deserialize only the opaque state bytes supplied by the repository itself.

- [ ] **Step 8: Add RED deck-settings test**

Mock `GetDeckConfigsForUpdate(deckId)` with a current deck config id and matching config entry; assert every `ReviewDeckSettings` field maps from upstream config. Also test missing matching config falls back to returned defaults rather than hard-coded Flutter values.

- [ ] **Step 9: Implement `settingsForDeck()` and run GREEN**

Use `GetDeckConfigsForUpdate` only; do not persist or mutate deck config in this milestone.

- [ ] **Step 10: Run suite and commit**

Run: `cd app && flutter test test/features/reviewer/data/anki_review_repository_test.dart`

Commit: `feat: map anki reviewer queue data`

---

### Task 3: Render official Anki card content and AV tags

**Files:**
- Create: `app/lib/features/reviewer/models/review_card_content.dart`
- Create: `app/lib/features/reviewer/data/card_render_repository.dart`
- Create: `app/lib/features/reviewer/data/anki_card_render_repository.dart`
- Test: `app/test/features/reviewer/data/anki_card_render_repository_test.dart`
- Modify: `native/anki_bridge/tests/backend_contract.rs`

**Interfaces:**
- `sealed class ReviewAudioTag`
  - `ReviewMediaTag(String filename)`
  - `ReviewTtsTag(String text, String language, List<String> voices, double speed, List<String> otherArgs)`
- `ReviewCardContent(questionHtml, answerHtml, css, questionAudio, answerAudio)`
- `CardRenderRepository.render(int cardId) -> Future<ReviewCardContent>`

- [ ] **Step 1: Add a real-backend RED contract test for full review rendering**

Create a temporary Basic note/card and assert `RenderExistingCard(browser=false, partial_render=false)` returns question text containing the front, answer text containing both FrontSide and back, and the note-type CSS.

- [ ] **Step 2: Run the focused Rust contract test**

Run: `cargo test --manifest-path native/anki_bridge/Cargo.toml --test backend_contract reviewer_render`

Expected: RED until the test is wired through the new operation; if upstream full rendering itself fails the FrontSide assertion, stop and adjust the spec/plan before implementing a frontend workaround.

- [ ] **Step 3: Write Dart RED rendering/AV tests**

Mock `renderExistingCard`, `extractAvTags`, and `encodeIriPaths`. Assert the repository:
1. renders once;
2. extracts AV tags separately for question (`questionSide=true`) and answer (`questionSide=false`);
3. uses cleaned text returned by `ExtractAvTags`;
4. runs cleaned HTML through `EncodeIriPaths`;
5. maps sound/video and TTS tags without exposing protobuf objects.

- [ ] **Step 4: Implement `AnkiCardRenderRepository.render()` and run GREEN**

Use full rendering, then AV extraction, then IRI encoding in the same order official Anki prepares card text for display.

- [ ] **Step 5: Add missing-media neutrality test**

Assert rendering succeeds even when the HTML references a media filename that does not exist; media failure belongs to playback/resource loading, not template rendering.

- [ ] **Step 6: Run relevant suites and commit**

Run:
- `cargo test --manifest-path native/anki_bridge/Cargo.toml --test backend_contract`
- `cd app && flutter test test/features/reviewer/data/anki_card_render_repository_test.dart`

Commit: `feat: render anki reviewer card content`

---

### Task 4: Add the collection-scoped secure media server

**Files:**
- Create: `app/lib/features/reviewer/media/review_media_server.dart`
- Modify: `app/lib/features/collection/collection_session.dart`
- Test: `app/test/features/reviewer/media/review_media_server_test.dart`
- Modify: `app/test/features/collection/collection_session_test.dart`

**Interfaces:**
- `ReviewMediaServer.start(String mediaRoot) -> Future<Uri>` returns a base URI shaped like `http://127.0.0.1:<ephemeral>/<session-token>/`.
- `ReviewMediaServer.close() -> Future<void>`.
- `CollectionSession` exposes the active `CollectionLocation? get location` and starts/stops the server through injected callbacks/service ownership rather than global state.

- [ ] **Step 1: Write RED happy-path HTTP tests**

Create a temporary media directory/file, start the server, GET and HEAD the tokenized URL, and assert body/status/content-length/MIME behavior.

- [ ] **Step 2: Run focused test and confirm RED**

Run: `cd app && flutter test test/features/reviewer/media/review_media_server_test.dart`

- [ ] **Step 3: Implement loopback-only ephemeral server minimally**

Use `HttpServer.bind(InternetAddress.loopbackIPv4, 0)` and a cryptographically random session token.

- [ ] **Step 4: Add RED traversal/security tests**

Pin all Review Focus cases:
- literal `../` traversal;
- percent-encoded traversal;
- absolute path attempts;
- symlink inside media root pointing outside root.

All must return 403/404 and never read outside the canonical media root. Also assert unsupported methods return 405.

- [ ] **Step 5: Implement canonical path containment and run GREEN**

Resolve/canonicalize the candidate and root before file access; reject symlink escape after canonical resolution.

- [ ] **Step 6: Add collection lifecycle RED tests**

Assert opening records `CollectionLocation`, closing clears it and closes the media server, and repeated close is idempotent.

- [ ] **Step 7: Implement session ownership and run GREEN**

Do not make the server a process-global singleton.

- [ ] **Step 8: Run suite and commit**

Run: `cd app && flutter test test/features/reviewer/media test/features/collection`

Commit: `feat: serve reviewer collection media safely`

---

### Task 5: Add shared desktop audio and TTS orchestration

**Files:**
- Modify: `app/pubspec.yaml`
- Modify/generated: `app/pubspec.lock`
- Create: `app/lib/features/reviewer/audio/review_audio_service.dart`
- Create: `app/lib/features/reviewer/audio/media_kit_review_audio_service.dart`
- Create: `app/lib/features/reviewer/audio/review_tts_service.dart`
- Test: `app/test/features/reviewer/audio/review_audio_service_test.dart`
- Test: `app/test/features/reviewer/audio/review_tts_service_test.dart`
- Modify: `app/lib/main.dart`

**Interfaces:**
- `ReviewAudioService`:
  - `Future<void> playQueue(List<Uri> items)`
  - `Future<void> replay()`
  - `Future<void> togglePause()`
  - `Future<void> seekRelative(Duration delta)`
  - `Future<void> stop()`
  - `bool get isPlaying`
  - `Stream<bool> get playingChanges`
  - `Future<void> dispose()`
- `ReviewTtsService.materialize(ReviewTtsTag tag) -> Future<Uri?>` uses upstream `AllTtsVoices` and `WriteTtsStream` and an injected temp-directory provider.

- [ ] **Step 1: Write RED queue/replay/pause/seek service tests against a fake player adapter**

Assert media items preserve order, replay restarts the current logical queue, pause toggles, and seek forwards `-5s/+5s` exactly.

- [ ] **Step 2: Implement the abstract orchestration and `media_kit` adapter**

Pin `media_kit: 1.2.6` and the desktop platform media libs required by its current installation instructions. Initialize media-kit once from app startup.

- [ ] **Step 3: Write RED TTS tests**

Test voice selection order follows the tag's requested voices, unavailable voices return `null` without crashing, and successful `WriteTtsStream` writes only under the injected application temp/cache directory.

- [ ] **Step 4: Implement TTS materialization and cleanup ownership**

Never write generated TTS into the collection media directory.

- [ ] **Step 5: Run audio/TTS tests and commit**

Run: `cd app && flutter test test/features/reviewer/audio`

Commit: `feat: add reviewer audio and tts services`

---

### Task 6: Implement the core Reviewer state machine

**Files:**
- Create: `app/lib/features/reviewer/models/review_session_state.dart`
- Create: `app/lib/features/reviewer/review_controller.dart`
- Test: `app/test/features/reviewer/review_controller_test.dart`

**Interfaces:**
- State variants: `ReviewInitial`, `ReviewLoading`, `ReviewQuestion`, `ReviewAnswer`, `ReviewTransition`, `ReviewFinished`, `ReviewFailure`.
- `ReviewQuestion` and `ReviewAnswer` carry immutable `ReviewCard`, `ReviewCardContent`, `ReviewDeckSettings`, and a per-card generation id.
- `ReviewController` methods:
  - `Future<void> start(int deckId)`
  - `Future<void> showAnswer()`
  - `Future<void> rate(ReviewRating rating)`
  - `Future<void> retry()`
  - lifecycle hooks added by later tasks.
- Inject clocks:
  - `int Function() wallClockMillis`
  - `Stopwatch Function() stopwatchFactory`

- [ ] **Step 1: Write RED start/question test**

Assert `start(deckId)` selects the deck, fetches one card, loads deck settings and rendered content, starts answer timing, and enters `ReviewQuestion`.

- [ ] **Step 2: Implement minimal start flow and run GREEN**

Use a monotonically increasing generation token for every current-card load.

- [ ] **Step 3: Write RED end-of-queue test**

If `nextCard()` returns `null`, assert state becomes `ReviewFinished` and no render/settings calls occur.

- [ ] **Step 4: Implement finished flow and run GREEN**

- [ ] **Step 5: Write RED reveal-answer test**

Assert `showAnswer()` only transitions from question to answer, preserves the same card/content, and records the answer-side timing state without refetching scheduler data.

- [ ] **Step 6: Implement reveal and run GREEN**

- [ ] **Step 7: Write RED grading tests**

Pin these behaviors:
- rating on question side is ignored;
- valid rating enters `ReviewTransition` immediately;
- `answer()` gets exact wall-clock and monotonic elapsed milliseconds;
- controller does not fetch the next card until `answer()` succeeds;
- backend failure returns to recoverable `ReviewAnswer` with error information and same current card;
- double click/key while transition is in flight issues exactly one backend answer.

- [ ] **Step 8: Implement grading and run GREEN**

- [ ] **Step 9: Add RED stale-completion tests**

Use completers so card A rendering and answer requests complete after a later generation. Assert old completions do not alter current state.

- [ ] **Step 10: Implement generation checks and run GREEN**

- [ ] **Step 11: Run controller suite and commit**

Run: `cd app && flutter test test/features/reviewer/review_controller_test.dart`

Commit: `feat: add reviewer state machine`

---

### Task 7: Match official audio, timer, auto-advance, undo, bury, and suspend behavior

**Files:**
- Modify: `app/lib/features/reviewer/data/review_repository.dart`
- Modify: `app/lib/features/reviewer/data/anki_review_repository.dart`
- Modify: `app/lib/features/reviewer/review_controller.dart`
- Test: `app/test/features/reviewer/review_controller_actions_test.dart`
- Modify: `app/test/features/reviewer/data/anki_review_repository_test.dart`

**Interfaces:**
- Add repository methods:
  - `Future<bool> canUndo()`
  - `Future<void> undo()`
  - `Future<void> buryCard(ReviewCard card)`
  - `Future<void> buryNote(ReviewCard card)`
  - `Future<void> suspendCard(ReviewCard card)`
  - `Future<void> suspendNote(ReviewCard card)`
- Add controller methods:
  - `replayAudio`, `togglePause`, `seekBackward`, `seekForward`
  - `toggleAutoAdvance`
  - `undo`, `buryCard`, `buryNote`, `suspendCard`, `suspendNote`
  - `disposeReviewSession`

- [ ] **Step 1: Write RED repository mutation tests**

Assert exact `BuryOrSuspendCardsRequest` mode/card_ids/note_ids for the four actions and that undo uses `GetUndoStatus` + `Undo` rather than local reversal.

- [ ] **Step 2: Implement repository actions and run GREEN**

- [ ] **Step 3: Write RED autoplay tests**

Assert question entry plays question tags only when `autoplay=true`; answer entry plays answer tags, and prepends question tags when `skipQuestionWhenReplayingAnswer=false` as official Anki's replay-answer behavior requires.

- [ ] **Step 4: Implement side-aware playback orchestration and run GREEN**

TTS tags are materialized before being handed to the shared audio queue; missing TTS/audio files are surfaced as non-fatal diagnostics.

- [ ] **Step 5: Write RED auto-advance tests**

Use fake timers/clock to assert:
- question timeout uses `secondsToShowQuestion` and configured `questionAction`;
- answer timeout uses `secondsToShowAnswer` and configured `answerAction`;
- `waitForAudio=true` defers the timeout action while playback is active;
- playback becoming idle triggers the deferred action once, not twice;
- disabling auto-advance cancels pending actions.

- [ ] **Step 6: Implement timer orchestration and run GREEN**

Keep timers in `ReviewController`, not widgets.

- [ ] **Step 7: Write RED undo/bury/suspend controller tests**

After each successful mutation, assert queue refresh occurs and stale current card is not retained. Undo should refresh from upstream and can return to question/finished depending on the new queue.

- [ ] **Step 8: Implement action refresh behavior and run GREEN**

- [ ] **Step 9: Write RED disposal test**

Assert leaving Reviewer cancels timers, stops audio, invalidates pending generations, and makes late async completions no-ops.

- [ ] **Step 10: Implement disposal and commit**

Run: `cd app && flutter test test/features/reviewer/review_controller_actions_test.dart test/features/reviewer/review_controller_test.dart`

Commit: `feat: match anki reviewer actions and timers`

---

### Task 8: Port official Reviewer web assets behind one CEF `CardSurface`

**Files:**
- Modify: `app/pubspec.yaml`
- Modify/generated: `app/pubspec.lock`
- Create: `app/lib/features/reviewer/surface/card_surface.dart`
- Create: `app/lib/features/reviewer/surface/reviewer_bridge_message.dart`
- Create: `app/lib/features/reviewer/surface/cef_card_surface.dart`
- Add assets under: `app/assets/anki_reviewer/`
- Create: `tool/sync_anki_reviewer_assets.py`
- Create: `tool/verify_anki_reviewer_assets.py`
- Test: `app/test/features/reviewer/surface/card_surface_contract_test.dart`
- Test: `app/test/features/reviewer/surface/reviewer_bridge_message_test.dart`
- Test: `tool/test_verify_anki_reviewer_assets.py`

**Interfaces:**
- `CardSurface` widget/controller boundary supports:
  - initialize/load reviewer shell with a `baseUri`;
  - `showQuestion(questionHtml, answerHtml, bodyClass)`;
  - `showAnswer(answerHtml)`;
  - optional JS evaluation only through named methods, not ad-hoc calls from widgets;
  - report `ready`, `loadError`, and typed bridge messages.
- Copy/reference upstream assets only from pinned Anki commit, with a manifest storing source path + SHA256.

- [ ] **Step 1: Write RED asset-verification test**

The verifier must fail when a copied Reviewer asset differs from its manifest or when the manifest references a source path outside the approved pinned Anki reviewer/web asset set.

- [ ] **Step 2: Implement deterministic sync/verify tooling**

Copy only the upstream assets actually required by the Reviewer shell (reviewer JS/CSS and transitive runtime assets required for card display such as MathJax helpers), preserving license headers where present and recording provenance.

- [ ] **Step 3: Add `webview_cef: 0.6.2` and RED bridge-message tests**

Define a minimal JSON message envelope with exact allowed commands used by the ported Reviewer web layer; reject unknown/malformed messages.

- [ ] **Step 4: Implement typed bridge parsing and run GREEN**

Do not expose a generic arbitrary command dispatcher to feature code.

- [ ] **Step 5: Write RED `CardSurface` contract tests with a fake surface**

Assert question/answer calls preserve ordering and renderer initialization errors map to a surface error event.

- [ ] **Step 6: Implement `CefCardSurface` using one shared Dart implementation**

Use `WebViewController`/`WebviewManager` from `webview_cef`; inject the copied official Reviewer shell and replace Anki's Qt `pycmd` bridge with the typed Flutter bridge.

- [ ] **Step 7: Add RED renderer-failure widget/controller test**

Assert CEF initialization/load failure yields recoverable `ReviewFailure` while the collection session remains open.

- [ ] **Step 8: Implement error propagation and run GREEN**

- [ ] **Step 9: Run asset/surface tests and commit**

Run:
- `python3 -m unittest tool/test_verify_anki_reviewer_assets.py`
- `python3 tool/verify_anki_reviewer_assets.py`
- `cd app && flutter test test/features/reviewer/surface`

Commit: `feat: port official anki reviewer web surface`

---

### Task 9: Add official Reviewer keyboard command routing

**Files:**
- Create: `app/lib/features/reviewer/review_shortcuts.dart`
- Test: `app/test/features/reviewer/review_shortcuts_test.dart`

**Interfaces:**
- `ReviewCommand` enum/value objects route to controller methods.
- A single `Shortcuts`/`Actions` map handles both key presses and button callbacks through the same controller commands.

- [ ] **Step 1: Write RED shortcut mapping tests**

Pin required official shortcuts:
- Space / Return / Enter -> show answer (or configured default rating on answer side when supported by current state);
- 1/2/3/4 -> Again/Hard/Good/Easy only on answer side;
- `r` and F5 -> replay;
- `u` -> undo;
- `-` -> bury card;
- `=` -> bury note;
- `@` -> suspend card;
- `!` -> suspend note;
- `5` -> pause/resume;
- `6` -> seek -5s;
- `7` -> seek +5s;
- Shift+A -> toggle auto-advance.

- [ ] **Step 2: Implement state-aware command router and run GREEN**

Do not enable editor/options/card-info shortcuts until those feature modules exist.

- [ ] **Step 3: Add focus regression test**

When the card web surface owns focus, the Flutter shortcut layer must still receive the required Reviewer shortcuts or the CEF bridge must forward them into the same command router; assert no duplicate command is emitted.

- [ ] **Step 4: Implement focus forwarding and commit**

Run: `cd app && flutter test test/features/reviewer/review_shortcuts_test.dart`

Commit: `feat: add anki reviewer shortcuts`

---

### Task 10: Build the Reviewer page and answer controls

**Files:**
- Create: `app/lib/features/reviewer/review_page.dart`
- Test: `app/test/features/reviewer/review_page_test.dart`

**Interfaces:**
- `ReviewPage(controller, cardSurfaceBuilder, onFinished)`.
- Widgets consume immutable controller state only.

- [ ] **Step 1: Write RED question-side widget test**

Assert question state renders the card surface, queue counts, and Show Answer control, while Again/Hard/Good/Easy are absent.

- [ ] **Step 2: Implement minimal question UI and run GREEN**

Keep card content visually dominant; use Material 3 only for surrounding controls/chrome.

- [ ] **Step 3: Write RED answer-side widget test**

Assert all four answer buttons appear with repository-provided interval labels, invoke the corresponding controller rating, and disable while state is `ReviewTransition`.

- [ ] **Step 4: Implement answer controls and run GREEN**

- [ ] **Step 5: Write RED loading/failure/finished tests**

Assert:
- loading shows progress;
- recoverable failure shows Retry and keeps navigation alive;
- finished calls `onFinished` once and does not leave stale card content visible.

- [ ] **Step 6: Implement state views and run GREEN**

- [ ] **Step 7: Add keyboard semantics/focus tests and commit**

Run: `cd app && flutter test test/features/reviewer/review_page_test.dart`

Commit: `feat: add reviewer page`

---

### Task 11: Wire deck overview -> Reviewer -> refreshed overview

**Files:**
- Modify: `app/lib/features/decks/deck_overview_page.dart`
- Modify: `app/lib/features/decks/deck_list_page.dart`
- Modify: `app/lib/app/anki_desktop_root.dart`
- Modify: `app/lib/features/collection/collection_session.dart`
- Modify: `app/test/features/decks/deck_overview_navigation_test.dart`
- Test: `app/test/app/reviewer_composition_test.dart`

**Interfaces:**
- Root composition creates one backend client and repository/service instances per open app session.
- `DeckOverviewPage` receives `Future<void> Function(int deckId) startReview` or an injected Reviewer page factory; do not construct native dependencies inside the page.

- [ ] **Step 1: Change existing navigation test to RED**

Replace the disabled Study assertion with: Study is enabled, tapping it opens Reviewer, backing out does not reopen the collection, and deck overview remains available.

- [ ] **Step 2: Implement navigation injection minimally**

- [ ] **Step 3: Add RED root-composition test**

With fake backend/services, assert the same collection/backend session is shared across deck list, overview, and Reviewer, and closing the app disposes Reviewer services before closing/destroying backend resources.

- [ ] **Step 4: Wire real repositories/media/audio/surface factories in `AnkiDesktopRoot`**

Start the collection-scoped media server after successful collection open and pass its base URI to Reviewer rendering/surface code.

- [ ] **Step 5: Add RED finished-flow test**

When Reviewer finishes, pop/return to overview and refresh deck counts from `DeckListController`/repository before displaying them.

- [ ] **Step 6: Implement refresh-on-finish and run GREEN**

- [ ] **Step 7: Run app/deck tests and commit**

Run: `cd app && flutter test test/app test/features/decks`

Commit: `feat: connect deck overview to reviewer`

---

### Task 12: Add a real Anki backend Reviewer contract test

**Files:**
- Create: `app/integration_test/real_backend_reviewer_test.dart`
- Modify: `tool/run_desktop_dev.py`
- Modify: `native/anki_bridge/tests/backend_contract.rs`

**Interfaces:**
- Runner accepts `--test reviewer` (or equivalent explicit selector) while retaining the existing deck-list integration path.

- [ ] **Step 1: Add RED native contract fixture for a due/new card**

Create a disposable collection through official backend-compatible APIs/fixture setup with a Basic note/card whose front/back and media are deterministic. Do not edit the user's collection and do not direct-write scheduling state from Flutter.

- [ ] **Step 2: Add RED Flutter real-backend Reviewer integration**

Prove this path:

`open disposable collection -> select deck -> queue real card -> render real question -> show answer -> display four upstream interval labels -> rate Good -> backend accepts answer -> queue advances/finishes`

The test may replace actual CEF/audio implementations with test surfaces/audio fakes while keeping real FFI/rslib scheduler and renderer calls; CEF itself is smoke-tested separately in Task 13.

- [ ] **Step 3: Implement only missing fixture/runner glue and run GREEN**

Run: `xvfb-run -a python3 tool/run_desktop_dev.py --test reviewer`

- [ ] **Step 4: Add persistence assertion**

Close/reopen the disposable collection and assert the answered card's scheduling/review state changed through upstream Anki rather than frontend state alone.

- [ ] **Step 5: Commit**

Commit: `test: cover real backend reviewer flow`

---

### Task 13: Configure and smoke-test CEF/audio on Linux, macOS, and Windows

**Files:**
- Modify: `app/windows/runner/main.cpp`
- Modify: `app/macos/Podfile` and/or generated macOS project configuration required by `webview_cef`
- Modify: `app/linux/runner/*` only where the plugin's documented integration requires it
- Modify: `.github/workflows/ci.yml`
- Create: `app/integration_test/reviewer_surface_smoke_test.dart`
- Modify: `app/test/app/macos_entitlements_test.dart` if CEF changes entitlements/sandbox requirements

**Interfaces:**
- Use the exact `webview_cef` 0.6.2 installation hooks for each platform.
- macOS minimum deployment target becomes 12.0 if not already >= 12.0.
- Windows minimum is Windows 10 for this Reviewer-enabled build.

- [ ] **Step 1: Add a RED generated/platform-config regression test where practical**

Pin required Windows CEF process initialization and macOS deployment target/config snippets so future `flutter create` drift cannot silently remove them.

- [ ] **Step 2: Apply minimal platform bootstrap configuration**

No Reviewer business logic goes in platform runners.

- [ ] **Step 3: Add Reviewer surface smoke integration**

Start a real `CefCardSurface`, load a deterministic HTML card containing inline JS/CSS and one local media image, execute question -> answer switch, and assert bridge readiness/no load failure.

- [ ] **Step 4: Run Linux smoke locally/in CI and confirm GREEN**

Run under Xvfb if CEF requires a display in CI.

- [ ] **Step 5: Split CI into shared quality plus three desktop build/smoke jobs**

Required jobs:
- Ubuntu: Rust + Flutter tests + Linux build + CEF Reviewer smoke + real backend Reviewer test.
- macOS: `flutter build macos` with CEF bootstrap and a surface smoke where runner support permits; at minimum verify build/package and unit contracts.
- Windows: `flutter build windows` with required CEF process hook and equivalent smoke where runner support permits.

Keep generated-proto verification and lockfile enforcement.

- [ ] **Step 6: Verify desktop packaging contains both native Anki bridge and CEF/media runtime artifacts**

Add explicit file-existence/package checks appropriate to each OS; do not assume Flutter's successful compile means runtime assets were bundled.

- [ ] **Step 7: Commit**

Commit: `ci: verify reviewer on all desktop platforms`

---

### Task 14: Final parity regression, documentation, and branch verification

**Files:**
- Modify: `README.md`
- Modify: `docs/superpowers/specs/2026-09-26-reviewer-parity-design.md` only for factual implementation notes/status, not scope expansion
- Create: `docs/reviewer-upstream-parity.md`
- Modify: `.github/workflows/ci.yml` only if final verification exposes a gap

**Interfaces:**
- `docs/reviewer-upstream-parity.md` records:
  - pinned Anki commit;
  - upstream Reviewer files/assets mirrored;
  - supported shortcuts/actions;
  - deliberately unsupported Python add-on hooks/actions;
  - exact asset sync/verification command;
  - CEF/media-kit desktop prerequisites.

- [ ] **Step 1: Write/update parity checklist from official `qt/aqt/reviewer.py`**

Mark each in-scope spec behavior as implemented and link its test file. Do not claim parity for excluded editor/options/flags/add-on actions.

- [ ] **Step 2: Update README development commands**

Document one command to run the app and one to run the real Reviewer integration path, plus first-build CEF download/toolchain requirements.

- [ ] **Step 3: Run complete final verification**

Run locally where supported:

```bash
python3 tool/generate_dart_protos.py
python3 tool/verify_generated_protos.py
python3 tool/verify_anki_reviewer_assets.py
python3 tool/prepare_bridge_lock.py
cargo fmt --manifest-path native/anki_bridge/Cargo.toml --check
cargo clippy --manifest-path native/anki_bridge/Cargo.toml --all-targets -- -D warnings
cargo test --manifest-path native/anki_bridge/Cargo.toml
cd app
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter build linux
cd ..
xvfb-run -a python3 tool/run_desktop_dev.py --test reviewer
```

Expected: all commands PASS. Then require the macOS and Windows CI jobs from Task 13 to be green on the exact branch head before calling the milestone complete.

- [ ] **Step 4: Verify generated/platform files are clean**

Run the existing generated-config diff check, expanded for any CEF-required platform files and `pubspec.lock`.

- [ ] **Step 5: Commit documentation/verification changes**

Commit: `docs: document reviewer parity workflow`

- [ ] **Step 6: Perform whole-branch review before merge**

Use `superpowers:requesting-code-review` and then `superpowers:verification-before-completion`. Review specifically for scheduler duplication, protobuf leakage into widgets, unsafe media serving, stale async state, duplicated shortcut dispatch, and platform-specific Reviewer logic.

---

## Milestone completion gate

The Reviewer milestone is complete only when all of these are true on the same branch head:

- real Anki queue -> question -> answer -> grade -> next/finish works through FFI/rslib;
- Again/Hard/Good/Easy states and interval labels come from upstream Anki;
- official Anki card rendering path is used, including FrontSide/CSS/HTML/JS behavior covered by contract tests;
- card media resolves through the collection-scoped secure loopback server;
- card audio and TTS work through one shared Dart orchestration layer;
- official primary Reviewer shortcuts work without duplicate dispatch;
- undo, bury card/note, suspend card/note use upstream mutations;
- auto-advance and wait-for-audio behavior are test-covered;
- end-of-queue returns to refreshed overview;
- copied official Reviewer web assets are provenance-pinned and drift-verified;
- no Python/PyQt runtime dependency has been introduced;
- no separate Windows/macOS/Linux Reviewer implementation exists;
- Linux, macOS, and Windows build checks are green;
- Linux real-backend Reviewer integration and CEF smoke are green;
- all Rust, Dart, Flutter, generated-code, and asset-verification quality gates pass.
