# AnkiFlutter Reviewer Card Info Design

Date: 2026-10-05
Status: Approved in chat; pending written-spec review

## 1. Goal

Add official-style Reviewer Card Info parity to AnkiFlutter for both the current card and the previous card, while keeping one shared Flutter implementation across supported platforms.

The feature must expose the same authoritative scheduling/statistics data that official Anki uses. Flutter owns presentation and navigation; the pinned Anki backend remains authoritative for card statistics and review history.

This slice includes both Reviewer actions:

- **Card Info** — shortcut `I`
- **Previous Card Info** — shortcut `Ctrl+Alt+I`

They share one reusable Card Info data path and UI.

## 2. Upstream reference

Use the already-pinned Anki revision:

- commit `a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`;
- `qt/aqt/reviewer.py` for Reviewer action and shortcut semantics;
- `qt/aqt/browser/card_info.py` for current/previous-card ownership and dialog behavior;
- `proto/anki/stats.proto` for `StatsService.CardStats` and `CardStatsResponse`;
- generated Dart types already present under `app/lib/core/backend/generated/anki/stats.pb.dart`.

Official Anki's PyQt/Svelte implementation is a behavior reference, not a UI technology requirement. AnkiFlutter will render the information natively in Flutter rather than embed Anki Desktop's `card-info/{card_id}` SvelteKit page.

## 3. Scope and success criteria

A user reviewing cards can:

1. open **Card Info** from the Reviewer menu or by pressing `I`;
2. see statistics for the currently displayed card;
3. open **Previous Card Info** from the Reviewer menu or by pressing `Ctrl+Alt+I`;
4. see statistics for the card that was displayed immediately before the current card;
5. see the backend-provided card/deck identity, scheduling information, review counts/timing, FSRS information when available, and review history;
6. close Card Info and return to the exact Reviewer state they left;
7. keep auto-advance behavior logically unchanged after returning;
8. encounter a useful empty/error state without mutating the review queue if the target card is unavailable.

The feature must not answer, skip, delete, reschedule, bury, suspend, or otherwise mutate a card.

## 4. Explicit non-goals

This slice does not add:

- browser-wide Card Info integration;
- Anki Desktop's exact SvelteKit Card Info frontend;
- raw database debug output or the desktop `Ctrl+C` JSON/debug-copy behavior;
- editable statistics;
- graphs/statistics dashboards beyond the selected card;
- voice recording/replay parity;
- filtered-deck editing;
- arbitrary PyQt window-position persistence.

The reusable repository/page should make Browser Card Info possible later, but this slice is Reviewer-only.

## 5. Backend contract

Append one stable bridge operation without renumbering existing operations:

- `75` — `cardStats`

Map it to the pinned backend descriptor:

```text
BackendStatsService.card_stats
```

Request and response are the existing pinned protobuf types:

```text
anki.cards.CardId
    -> BackendStatsService.card_stats
    -> anki.stats.CardStatsResponse
```

No `.proto` files need to change. The Dart `CardStatsResponse` and nested review-log entry types are already generated in the repository.

Required bridge changes are limited to the existing stable-operation plumbing:

- append `cardStats(75)` in Dart `BackendOperation`;
- append `CARD_STATS` descriptor generation in `native/anki_bridge/build.rs`;
- append the operation to the Rust FFI operation-id table;
- extend bridge operation-id tests to verify ID 75 resolves to the pinned backend descriptor and that 76 remains invalid until another operation is intentionally appended.

Operation IDs are append-only. Existing IDs 1–74 must remain unchanged.

## 6. Data architecture

Introduce a small Reviewer Card Info repository boundary:

```text
CardInfoPage
    |
    v
CardInfoRepository
    |
    | CardId
    v
BackendInvoker
    |
    v
BackendOperation.cardStats (75)
    |
    v
anki_bridge
    |
    v
Pinned Anki BackendStatsService.card_stats
```

Generated protobuf objects must not become long-lived widget state. The repository maps `CardStatsResponse` into immutable app-level models that are straightforward to render and unit-test.

The app-level model split is:

```text
CardInfoData
  identity / deck
  lifecycle timestamps
  scheduling summary
  timing summary
  optional FSRS details
  reviewHistory: List<CardReviewHistoryEntry>
```

The mapper must preserve optional-vs-absent backend semantics instead of turning absent values into misleading zeroes.

## 7. Card identity and previous-card semantics

Current Card Info always targets the `cardId` of the card currently displayed by the Reviewer.

Previous Card Info follows pinned Anki Reviewer semantics: it refers to the card that was displayed immediately before the current card, not merely the last successfully answered card.

When `ReviewController` replaces the current card with a newly fetched card:

1. retain the outgoing current card ID as `previousCardId`;
2. install the newly fetched card as current;
3. expose both IDs through Reviewer state without changing scheduling behavior.

This must apply regardless of why the Reviewer advanced to another card, including normal answering and existing mutation actions that advance the queue.

If the previous card no longer exists because it was deleted or otherwise became unavailable, Previous Card Info shows an unavailable/error state. It must not silently fall back to the current card.

On a brand-new Reviewer session before any card transition, `previousCardId` is absent and Previous Card Info shows a dedicated **No previous card available** state without issuing a backend request.

Starting a new Reviewer session clears any previous-card ID from the old session.

## 8. Reviewer integration

Add two Reviewer actions using the existing menu/shortcut architecture:

- `Card Info` — `I`
- `Previous Card Info` — `Ctrl+Alt+I`

The Reviewer page delegates navigation through a typed callback rather than directly constructing repository/backend dependencies, matching the existing navigation pattern used for other Reviewer-owned secondary screens.

The navigation target captures:

- source: current or previous;
- target `cardId`, nullable only for the previous-card empty state;
- the Reviewer generation/current-card identity needed for safe auto-advance restoration.

The Card Info page must not reach back into `ReviewController` to discover a different card after navigation has started.

Both menu and keyboard paths resolve through the same action handler.

## 9. Card Info UI

Use one native Flutter `CardInfoPage` for current and previous cards.

The page is responsive and scrollable, suitable for phone-size through desktop-size windows. Do not reproduce a desktop-only fixed dialog layout.

Presentation sections are:

### Identity

- Card ID
- Note ID
- Deck
- Original deck, when present
- Card type
- Note type
- Preset

### Scheduling

- Due Date when `due_date` is present;
- otherwise Due Position when `due_position` is present;
- omit the due row if neither is present;
- Current interval
- Ease
- Review count
- Lapse count
- Custom data when non-empty, in a clearly labeled advanced/details row

### Timing

- Added
- First review, when present
- Latest review, when present
- Average answer time
- Total answer time

### FSRS

Show only fields the backend actually supplies:

- stability/difficulty from memory state;
- retrievability;
- desired retention;
- FSRS parameters in a collapsed advanced/details section whenever the backend list is non-empty.

Do not fabricate FSRS values for cards where they are absent.

### Review history

Render all backend-provided `revlog` entries in the order supplied by `CardStatsResponse`; do not sort or recalculate them in Flutter. Each row exposes, where available:

- review time;
- review kind;
- answer/button chosen;
- resulting interval;
- previous interval;
- ease;
- time taken;
- memory state when supplied.

On narrow screens, history rows may use stacked cards/list tiles. On wider screens, a compact table is acceptable. The information content must be equivalent.

Dates/times use the app's normal local-time formatting rather than raw Unix timestamps.

## 10. Loading, empty, and error states

Card Info owns its own asynchronous load state:

```text
loading -> data
        -> error

previous absent -> empty (no backend call)
```

Requirements:

- show progress while `cardStats` is loading;
- backend failure stays within Card Info and does not modify Reviewer state;
- provide a Retry action for recoverable load failures;
- if the previous target is absent, show `No previous card available`;
- if a previously known card was removed, report that its information is unavailable rather than switching targets;
- closing the page during an in-flight request must not update disposed UI.

## 11. Reviewer lifecycle and auto-advance

Opening either Card Info action is a secondary Reviewer surface, not a queue transition.

Before opening it:

1. capture the current Reviewer generation and current card ID;
2. suspend Reviewer auto-advance timers using the same lifecycle pattern as other Reviewer secondary screens;
3. remember whether auto-advance was enabled;
4. open Card Info for the captured target card ID.

When Card Info closes:

- do not fetch another card;
- do not reveal/answer the card;
- do not alter question/answer side;
- restore auto-advance only if it was enabled before opening, the Reviewer generation is unchanged, and the current card ID still equals the captured current card ID;
- otherwise leave auto-advance in the newer/current Reviewer state untouched.

The page itself is read-only and therefore does not need a post-return deck/settings refresh.

## 12. Formatting rules

Display values are presentation conversions only. Scheduling meaning always comes from the backend.

Rules:

- timestamps: backend Unix time -> local date/time;
- durations: seconds -> concise human-readable time;
- ease: per-mill backend value -> percentage-like display where appropriate;
- intervals: use backend-provided interval values and a shared formatter; do not recompute intervals from dates;
- enum review kinds: map known pinned enum values to readable labels and retain a safe fallback for future/unknown values.

Formatting functions are independently unit-testable and contain no backend calls.

## 13. Files/components expected to change

Exact filenames may be adjusted during planning to fit existing conventions, but implementation must stay within these responsibilities:

### Backend bridge

- `app/lib/core/backend/backend_operation.dart`
- `native/anki_bridge/build.rs`
- `native/anki_bridge/src/ffi.rs`
- bridge operation mapping tests

### Reviewer data/model

- Card Info repository
- Card Info immutable presentation models/mappers
- `ReviewController` / Reviewer state for `previousCardId`

### Reviewer UI/navigation

- `ReviewPage` action/menu/shortcut wiring
- app-shell/navigation callback wiring
- reusable `CardInfoPage`
- focused Card Info widgets/formatters as needed

Avoid unrelated refactors.

## 14. Test strategy

Use TDD for implementation.

### Bridge tests

Verify:

- stable operation ID 75 maps to `BackendStatsService.card_stats`;
- IDs 1–74 remain unchanged;
- ID 76 is rejected until explicitly added;
- request bytes are an `anki.cards.CardId`;
- response bytes decode as `anki.stats.CardStatsResponse`.

### Repository/model tests

Verify mapping of:

- required identity fields;
- optional timestamps/due fields;
- interval/ease/review/lapse/time fields;
- FSRS fields present and absent;
- original deck present and absent;
- review history entries and review kinds;
- backend error propagation.

### Controller tests

Verify:

- first card has no previous card;
- card transition captures outgoing current ID as previous;
- another transition replaces previous with the immediately outgoing card;
- a new Reviewer session clears previous-card state;
- existing answer/mutation behavior is unchanged.

### Reviewer UI tests

Verify:

- menu contains both actions;
- `I` opens current Card Info;
- `Ctrl+Alt+I` opens previous Card Info;
- current action uses current card ID;
- previous action uses captured previous card ID;
- no-previous state performs no backend call;
- load/error/retry/data rendering;
- representative standard and FSRS fields;
- review history rendering;
- closing Card Info leaves current Reviewer card/side untouched;
- auto-advance pause/restore behavior;
- stale Reviewer generation cannot re-enable old timers.

## 15. Validation strategy

Do not consume private AnkiFlutter Actions minutes for validation.

Use the established public `Persie0/Playground` validation path:

1. RED focused tests proving the new API/UI is absent;
2. focused GREEN analyzer + Reviewer/Card Info tests;
3. complete Flutter analyzer/test suite;
4. complete public cross-platform validation on the exact implementation SHA:
   - generated protobuf verification;
   - Rust formatting;
   - strict Clippy;
   - Rust tests;
   - Flutter analyze/tests;
   - Linux bridge/app;
   - Android APK;
   - real-backend integration;
   - iOS bridge + simulator app;
   - macOS bridge/app;
   - Windows bridge/app;
5. self-review the base-to-head diff for accidental scope changes;
6. use the established tree-identical `[skip ci]` finalization pattern when necessary to avoid private PR-triggered CI.

## 16. Implementation boundaries

Keep this feature read-only and isolated:

- no scheduler calculations in Dart;
- no direct database queries;
- no copied desktop Card Info business logic when backend data already provides the result;
- no queue mutations from Card Info;
- no dependency from the Card Info page back into mutable Reviewer controller state;
- no microphone/voice-recording work in this slice;
- no new protobuf schema definitions;
- no operation renumbering.

## 17. Completion definition

Reviewer Card Info parity is complete when both current and previous Reviewer actions work on all supported app targets, use the pinned backend `CardStats` response as their source of truth, preserve Reviewer lifecycle state, pass focused/full/cross-platform public validation, and introduce no regressions in existing Reviewer actions.
