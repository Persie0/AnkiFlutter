# Reviewer Card Info Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add official-style Reviewer Card Info and Previous Card Info, backed by pinned Anki `CardStats`, without mutating reviewer state.

**Architecture:** Append stable bridge operation 75 for `BackendStatsService.card_stats`, map the generated protobuf response into immutable Dart presentation models, and render one reusable Flutter `CardInfoPage`. Reviewer navigation captures an immutable current/previous card target, pauses auto-advance through a generation/card-bound secondary-surface token, and resumes only when the original reviewer context is still current.

**Tech Stack:** Flutter/Dart, generated protobuf Dart types, existing `BackendInvoker`, Rust FFI bridge, pinned Anki `rslib`, `flutter_test`.

**Spec:** `docs/superpowers/specs/2026-10-05-reviewer-card-info-design.md`

## Global Constraints

- Pinned upstream Anki revision remains `a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`.
- Bridge operation IDs are append-only: IDs 1–74 remain unchanged; Card Stats is ID 75.
- No `.proto` schema changes or regeneration are required for this feature.
- Card Info is read-only: no answering, rescheduling, burying, suspending, deleting, queue advancement, or direct DB access.
- Card Info UI is native Flutter and responsive from phone-sized layouts through desktop windows.
- Generated protobuf objects do not become long-lived widget state.
- Previous Card Info means the card displayed immediately before the current card; it does not mean “last successfully answered card.”
- No private AnkiFlutter Actions validation; use the established public `Persie0/Playground` validation path.
- Implementation is sequential/native in this session; do not dispatch subagents.

## Review Focus

1. **Deleted previous card:** a captured `previousCardId` may no longer exist; Card Info must show an unavailable/error state and never fall back to the current card. Test in Task 4 and Task 5.
2. **Stale secondary-surface return:** a Reviewer generation/card may change while Card Info is open; returning must not re-enable auto-advance on the newer card/session. Test in Task 3 and Task 5.
3. **Absent protobuf optionals:** due date/position, original deck, review timestamps, memory state, retrievability, and desired retention must remain absent rather than render fake zero values. Test in Task 2 and Task 4.
4. **Large/empty review history:** zero history rows and 200 history rows must both render safely without changing backend order. Test in Task 4.
5. **Unknown future review kind:** rendering must use a safe readable fallback instead of crashing on an unmapped enum value. Test formatter behavior in Task 2.

---

### Task 1: Add stable Card Stats bridge operation 75

**Files:**
- Modify: `app/lib/core/backend/backend_operation.dart`
- Modify: `native/anki_bridge/build.rs`
- Modify: `native/anki_bridge/src/ffi.rs`
- Test: `native/anki_bridge/src/ffi.rs` (`#[cfg(test)]` operation-ID test)
- Test: create `app/test/core/backend/card_stats_operation_test.dart`

**Interfaces:**
- Consumes: existing `BackendInvoker.invoke(BackendOperation, Uint8List)` and pinned descriptor service/method names.
- Produces: `BackendOperation.cardStats` with `nativeId == 75`, mapped to `BackendStatsService.card_stats`.

- [ ] **Step 1: Write failing bridge-ID tests**

Add assertions that:

```text
BackendOperation.cardStats.nativeId == 75
operation_from_id(75) == CARD_STATS
operation_from_id(76) is error
```

and keep the existing assertions for IDs 1–74 unchanged.

- [ ] **Step 2: Run RED tests**

Run:

```bash
cd native/anki_bridge && cargo test extended_operation_ids_map_to_the_pinned_backend_descriptors
cd ../../app && flutter test test/core/backend/card_stats_operation_test.dart
```

Expected: FAIL because `CARD_STATS` / `BackendOperation.cardStats` do not exist.

- [ ] **Step 3: Append operation 75**

Implement exactly:

```text
Dart enum: cardStats(75)
Rust generated descriptor constant: CARD_STATS -> BackendStatsService.card_stats
Rust FFI table: append CARD_STATS after SET_DUE_DATE
```

Do not renumber existing entries.

- [ ] **Step 4: Run GREEN tests**

Run the same two commands. Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/core/backend/backend_operation.dart app/test/core/backend/card_stats_operation_test.dart native/anki_bridge/build.rs native/anki_bridge/src/ffi.rs
git commit -m "feat: add card stats bridge operation [skip ci]"
```

---

### Task 2: Add Card Info repository, immutable models, mapper, and formatters

**Files:**
- Create: `app/lib/features/card_info/models/card_info_data.dart`
- Create: `app/lib/features/card_info/data/card_info_repository.dart`
- Create: `app/lib/features/card_info/data/anki_card_info_repository.dart`
- Create: `app/lib/features/card_info/card_info_formatters.dart`
- Create: `app/test/features/card_info/data/anki_card_info_repository_test.dart`
- Create: `app/test/features/card_info/card_info_formatters_test.dart`

**Interfaces:**
- Consumes: `BackendOperation.cardStats`, generated `anki.cards.CardId(cid: Int64(...))`, generated `anki.stats.CardStatsResponse`.
- Produces:
  - `abstract interface class CardInfoRepository { Future<CardInfoData> load(int cardId); }`
  - `class AnkiCardInfoRepository implements CardInfoRepository`
  - immutable `CardInfoData`, `CardReviewHistoryEntry`, `CardInfoMemoryState`
  - pure formatting helpers for timestamp, duration, interval, ease, and review-kind labels.

Define `CardInfoData` with these fields:

```dart
int cardId
int noteId
String deck
String? originalDeck
String cardType
String noteType
String preset
int addedUnixSeconds
int? firstReviewUnixSeconds
int? latestReviewUnixSeconds
int? dueUnixSeconds
int? duePosition
int intervalSeconds
int easePermille
int reviews
int lapses
double averageSeconds
double totalSeconds
String customData
CardInfoMemoryState? memoryState
double? retrievability
double? desiredRetention
List<double> fsrsParameters
List<CardReviewHistoryEntry> reviewHistory
```

Define `CardInfoMemoryState(stability, difficulty)` and `CardReviewHistoryEntry` with:

```dart
int unixSeconds
int reviewKindValue
int buttonChosen
int intervalSeconds
int lastIntervalSeconds
int easePermille
double takenSeconds
CardInfoMemoryState? memoryState
```

- [ ] **Step 1: Write failing repository tests**

Tests must assert:

- request decodes as `cards.CardId` with `cid == requestedCardId`;
- operation is exactly `BackendOperation.cardStats`;
- every required response field maps correctly;
- `hasX()` optional fields map to nullable Dart fields, not zero defaults;
- memory-state stability/difficulty and FSRS parameters map correctly;
- review history preserves backend order exactly;
- backend errors propagate without conversion to fake data.

- [ ] **Step 2: Write failing formatter tests**

Tests must assert:

- Unix seconds are converted to `DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true).toLocal()` before display;
- duration/interval formatting does not recompute scheduling meaning;
- ease per-mill formats predictably;
- known pinned review kinds get readable labels;
- an unknown numeric review kind returns `Unknown (<value>)` instead of throwing.

- [ ] **Step 3: Run RED tests**

```bash
cd app && flutter test test/features/card_info/data/anki_card_info_repository_test.dart test/features/card_info/card_info_formatters_test.dart
```

Expected: FAIL because the Card Info data layer does not exist.

- [ ] **Step 4: Implement repository and mapper**

`AnkiCardInfoRepository.load(int cardId)` must:

1. build `cards.CardId(cid: Int64(cardId))`;
2. invoke `BackendOperation.cardStats`;
3. decode `stats.CardStatsResponse.fromBuffer(response)`;
4. map to `CardInfoData` immediately.

Use protobuf presence methods (`hasFirstReview()`, `hasLatestReview()`, `hasDueDate()`, `hasDuePosition()`, `hasMemoryState()`, `hasFsrsRetrievability()`, `hasOriginalDeck()`, `hasDesiredRetention()`) before reading optional fields.

- [ ] **Step 5: Implement pure formatters**

Keep formatting in `card_info_formatters.dart`; widgets receive already-decided display strings from these helpers. Review-history timestamps are also Unix seconds at the pinned backend revision.

- [ ] **Step 6: Run GREEN tests**

Run the Task 2 test command. Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/features/card_info app/test/features/card_info
git commit -m "feat: add card info data model [skip ci]"
```

---

### Task 3: Track previous card and add generation-safe secondary-surface suspension

**Files:**
- Modify: `app/lib/features/reviewer/review_controller.dart`
- Create: `app/test/features/reviewer/review_controller_card_info_test.dart`

**Interfaces:**
- Consumes: existing `ReviewQuestion`, `ReviewAnswer`, `_loadNextCard()`, generation counter, auto-advance scheduling.
- Produces:
  - `int? get currentCardId`
  - `int? get previousCardId`
  - `ReviewSecondarySurfaceToken? pauseForSecondarySurface()`
  - `void resumeAfterSecondarySurface(ReviewSecondarySurfaceToken token)`
  - immutable `ReviewSecondarySurfaceToken` carrying `generationId`, `cardId`, and `restoreAutoAdvance`.

- [ ] **Step 1: Write failing previous-card tests**

Assert:

- after `start()`, current ID is first card and `previousCardId == null`;
- after a successful answer advances to card B, `previousCardId == cardA.cardId`;
- after another advance to card C, previous becomes B, not A;
- an advancing delete/mutation retains the outgoing card ID as previous even though later Card Stats may report that card unavailable;
- existing advancing actions use the same `_loadNextCard()` behavior and capture the outgoing card;
- a fresh `start()` clears previous state from the old session;
- a failed/stale next-card load does not install a misleading previous ID.

- [ ] **Step 2: Write failing secondary-surface lifecycle tests**

Assert:

- pausing while auto-advance is enabled cancels the active timer and returns a token with `restoreAutoAdvance == true`;
- resuming the same token on the same generation/card re-enables auto-advance and reschedules for the unchanged question/answer side;
- pausing while auto-advance is disabled returns `restoreAutoAdvance == false` and resume leaves it disabled;
- changing generation or current card before resume makes resume a no-op;
- calling pause outside `ReviewQuestion`/`ReviewAnswer` returns `null`.

- [ ] **Step 3: Run RED tests**

```bash
cd app && flutter test test/features/reviewer/review_controller_card_info_test.dart
```

Expected: FAIL because these getters/token methods do not exist.

- [ ] **Step 4: Implement previous-card tracking**

At the start of `start(int deckId)`, clear `_previousCardId`. In `_loadNextCard(generationId)`, snapshot the outgoing current card ID before fetching, but assign it to `_previousCardId` only when a non-null next card is successfully installed for the same generation. Do not rewrite previous state on stale completion.

- [ ] **Step 5: Implement secondary-surface token lifecycle**

`pauseForSecondarySurface()` captures the current generation/card and current auto-advance flag, disables auto-advance by clearing timer/deferred state, and notifies listeners only if the flag changes. `resumeAfterSecondarySurface(token)` validates both generation and current card ID; only then restore/schedule auto-advance when `token.restoreAutoAdvance` is true.

- [ ] **Step 6: Run GREEN tests plus existing auto-advance/stale suites**

```bash
cd app && flutter test test/features/reviewer/review_controller_card_info_test.dart test/features/reviewer/review_controller_auto_advance_parity_test.dart test/features/reviewer/review_controller_stale_completion_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/features/reviewer/review_controller.dart app/test/features/reviewer/review_controller_card_info_test.dart
git commit -m "feat: track reviewer card info targets [skip ci]"
```

---

### Task 4: Build reusable responsive Card Info page

**Files:**
- Create: `app/lib/features/card_info/card_info_page.dart`
- Create: `app/test/features/card_info/card_info_page_test.dart`

**Interfaces:**
- Consumes: `CardInfoRepository.load(int)`, `CardInfoData`, Card Info formatters.
- Produces:
  - `enum CardInfoKind { current, previous }`
  - `CardInfoPage({required CardInfoRepository repository, required int? cardId, required CardInfoKind kind})`

- [ ] **Step 1: Write failing page-state tests**

Assert:

- non-null `cardId` starts loading exactly once;
- current kind uses title `Card Info` and previous kind uses title `Previous Card Info`;
- `cardId == null && kind == CardInfoKind.previous` shows `No previous card available` and never calls the repository;
- a backend/not-found failure for a non-null previous ID shows that captured card's information as unavailable and never switches to a different ID/current card;
- load error renders an unavailable/error message plus `Retry`;
- tapping Retry invokes the same captured card ID again;
- completing a request after widget disposal produces no exception/state update.

- [ ] **Step 2: Write failing data-rendering tests**

With a representative `CardInfoData`, assert visible sections/values for:

- identity/deck/original deck/card type/note type/preset;
- due date vs due position based on nullable fields;
- interval/ease/reviews/lapses/custom data;
- added/first/latest review/average/total time;
- FSRS stability/difficulty/retrievability/desired retention only when present;
- FSRS parameters in an expandable advanced area;
- absent optional fields do not display fabricated zero values;
- empty review history state;
- 200 history entries render in backend order, including an unknown review-kind fallback.

- [ ] **Step 3: Write responsive-layout test**

Pump at a narrow surface (phone width) and a wide desktop surface. Assert both render without overflow; narrow history uses stacked rows/cards, while wide layout may use the compact tabular presentation.

- [ ] **Step 4: Run RED tests**

```bash
cd app && flutter test test/features/card_info/card_info_page_test.dart
```

Expected: FAIL because `CardInfoPage` does not exist.

- [ ] **Step 5: Implement `CardInfoPage`**

Use one `StatefulWidget` with a captured `cardId`, request generation/disposed guard, `ListView`/scrollable body, small private section widgets, and `LayoutBuilder` only for narrow/wide history presentation. Do not query Reviewer controller state from this page.

- [ ] **Step 6: Run GREEN tests**

Run the Task 4 command. Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/features/card_info/card_info_page.dart app/test/features/card_info/card_info_page_test.dart
git commit -m "feat: add card info page [skip ci]"
```

---

### Task 5: Wire Reviewer actions, shortcuts, navigation, and lifecycle

**Files:**
- Modify: `app/lib/features/reviewer/review_page.dart`
- Modify: `app/lib/features/decks/deck_overview_page.dart`
- Create: `app/test/features/reviewer/review_card_info_test.dart`
- Modify: `app/test/features/reviewer/review_page_shortcut_parity_test.dart`

**Interfaces:**
- Consumes: Task 3 controller getters/token lifecycle, Task 4 `CardInfoPage`, `AnkiCardInfoRepository`.
- Produces:
  - `typedef ReviewCardInfoOpener = Future<void> Function(ReviewCardInfoTarget target)`
  - `ReviewCardInfoTarget({required CardInfoKind kind, required int? cardId})`
  - `ReviewPage.onOpenCardInfo`
  - menu actions `Card Info` and `Previous Card Info`
  - shortcuts `I` and `Ctrl+Alt+I`.

- [ ] **Step 1: Write failing shortcut/menu routing tests**

Assert:

- Reviewer menu contains `Card Info` and `Previous Card Info` when `onOpenCardInfo` is supplied;
- `I` calls opener with current card ID and `CardInfoKind.current`;
- `Ctrl+Alt+I` calls opener with captured `previousCardId` and `CardInfoKind.previous`;
- previous action still opens with `cardId == null` on the first card so the dedicated empty page can render;
- after an advancing delete/mutation, Previous Card Info passes the deleted outgoing ID unchanged rather than falling back to current;
- both menu and shortcut routes use the same typed target semantics.

- [ ] **Step 2: Write failing lifecycle/navigation tests**

Assert:

- opening Card Info pauses enabled auto-advance before awaiting the opener;
- returning on the same generation/card restores prior auto-advance state;
- returning after generation/card change does not restore stale auto-advance;
- opener error is reported through the existing Reviewer action error path and leaves current card/side unchanged;
- no Card Info action invokes `nextCard`, `showAnswer`, or rating/mutation methods.

- [ ] **Step 3: Run RED tests**

```bash
cd app && flutter test test/features/reviewer/review_card_info_test.dart test/features/reviewer/review_page_shortcut_parity_test.dart
```

Expected: FAIL because Card Info actions/wiring do not exist.

- [ ] **Step 4: Add Reviewer typed target and actions**

In `review_page.dart`:

- append `_ReviewAction.cardInfo` and `_ReviewAction.previousCardInfo`;
- add `I` and `Ctrl+Alt+I` activators;
- add corresponding popup menu rows;
- build `ReviewCardInfoTarget` only from `controller.currentCardId` / `controller.previousCardId` captured at action time;
- acquire a `ReviewSecondarySurfaceToken` before opening and always pass it back to `resumeAfterSecondarySurface()` in `finally`.

- [ ] **Step 5: Wire actual page navigation in Deck Overview**

Add `_openReviewCardInfo(ReviewCardInfoTarget target)` that pushes:

```text
CardInfoPage(
  repository: AnkiCardInfoRepository(backend: backend),
  cardId: target.cardId,
  kind: target.kind,
)
```

Pass this callback to `ReviewPage` whenever `backend != null`.

- [ ] **Step 6: Run GREEN focused tests**

Run the Task 5 command. Expected: PASS.

- [ ] **Step 7: Run neighboring Reviewer regression tests**

```bash
cd app && flutter test test/features/reviewer/review_options_test.dart test/features/reviewer/review_page_edit_note_test.dart test/features/reviewer/review_page_manual_actions_test.dart test/features/reviewer/review_controller_actions_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/features/reviewer/review_page.dart app/lib/features/decks/deck_overview_page.dart app/test/features/reviewer/review_card_info_test.dart app/test/features/reviewer/review_page_shortcut_parity_test.dart
git commit -m "feat: add reviewer card info actions [skip ci]"
```

---

### Task 6: Add real-backend Card Stats smoke coverage, validate exact tree, and finalize stacked PR

**Files:**
- Modify: `app/integration_test/real_backend_deck_list_test.dart`
- No other production changes unless validation exposes a real defect.

**Interfaces:**
- Consumes: completed Tasks 1–5 and existing real-backend collection/note/card setup.
- Produces: direct real-backend proof that operation 75 returns Card Stats, one exact implementation SHA proven green in public validation, then a tree-identical `[skip ci]` head if needed, and a stacked PR against `feat/reviewer-delete-note`.

- [ ] **Step 1: Add real-backend Card Stats assertion**

In the existing real-backend integration flow that creates a note and resolves its card ID, instantiate `AnkiCardInfoRepository(backend: client)`, call `load(resolvedCardId)`, and assert at minimum:

```text
info.cardId == resolvedCardId
info.noteId == noteId
info.deck == "Default"
```

This test must use the native bridge/client, not a fake `BackendInvoker`.

- [ ] **Step 2: Run focused real-backend test when native library is available**

Run the existing integration-test command used by the public real-backend workflow with `ANKIFLUTTER_NATIVE_LIB` configured. Expected: PASS and operation 75 exercised end-to-end.

- [ ] **Step 3: Commit integration coverage**

```bash
git add app/integration_test/real_backend_deck_list_test.dart
git commit -m "test: cover card stats on real backend [skip ci]"
```

- [ ] **Step 4: Run local/focused verification commands available in the execution environment**

At minimum:

```bash
cd app && flutter analyze
cd app && flutter test test/features/card_info test/features/reviewer/review_controller_card_info_test.dart test/features/reviewer/review_card_info_test.dart test/features/reviewer/review_page_shortcut_parity_test.dart
cd native/anki_bridge && cargo fmt --check && cargo clippy --all-targets -- -D warnings && cargo test
```

Expected: all PASS.

- [ ] **Step 5: Public focused RED/GREEN provenance**

Preserve the already-created RED commit when practical, then validate the implementation SHA in `Persie0/Playground` with the established focused Reviewer/Card Info workflow. Expected: analyzer + focused tests PASS.

- [ ] **Step 6: Public full Flutter validation**

Run the existing full Flutter public workflow against the same implementation SHA. Expected: analyzer and complete Flutter test suite PASS.

- [ ] **Step 7: Public cross-platform validation**

Run the established cross-platform public workflow against the same implementation SHA and require PASS for:

```text
generated protobuf verification
Rust fmt / strict Clippy / Rust tests
Flutter analyze / full tests
Linux bridge + app
Android APK
real-backend integration including operation 75 Card Stats
iOS bridge + simulator app
macOS bridge + app
Windows bridge + app
```

- [ ] **Step 8: Self-review base-to-head diff**

Compare against `feat/reviewer-delete-note` and confirm only the Card Info bridge/data/UI/controller/navigation/tests plus approved docs changed. Specifically verify no operation renumbering, no protobuf schema changes, and no unrelated Reviewer behavior changes.

- [ ] **Step 9: Finalize without private CI**

If the validated implementation head itself is not already `[skip ci]`, create a tree-identical final `[skip ci]` commit. Verify the final tree SHA is identical to the publicly validated implementation tree and verify no private AnkiFlutter workflow ran on the final head.

- [ ] **Step 10: Open stacked PR**

Open `feat/reviewer-card-info` against `feat/reviewer-delete-note`, include the exact public run IDs and validated SHA/tree in the PR body, verify mergeability/review threads, and merge only when clean under the user's standing merge-if-OK instruction.
