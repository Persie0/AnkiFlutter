# Browser Bulk Actions Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let users select cards in the shared browser and suspend or bury the selected cards through Anki on Linux, macOS, Windows, Android, and iOS.

**Architecture:** `AnkiCardBrowserRepository` serializes Anki's generated `BuryOrSuspendCardsRequest` through the already-exposed backend operation. The shared browser page owns visible selection and confirmation; after a successful mutation it clears selection and refreshes the same search, while failures preserve selection for retry.

**Tech Stack:** Flutter Material 3, Dart protobuf bindings, Dart FFI, official pinned Anki Rust backend.

**Spec:** `docs/superpowers/specs/2026-09-28-core-anki-parity-design.md`

## Global Constraints

- Anki remains authoritative for bury and suspend behavior.
- The feature stays in the shared Flutter UI and backend repository, with no platform-specific workflow.
- Every destructive bulk action confirms the selected card count before calling Anki.
- Search changes clear selection; successful mutations retain the active query and refresh it.
- Backend errors preserve the visible selection so the user can retry.
- Tests use generated Anki protobufs and repository interfaces; widgets do not access protobufs.

## Review Focus

- Submitting a different search must not apply actions to cards from an earlier result set.
- A canceled confirmation must make no backend call and retain the selection.
- A failed backend action must keep selection and search text intact.
- Empty selection must not issue a request.
- A successful action must send only selected IDs, clear selection, and refresh the retained query.

---

### Task 1: Add Anki-backed suspend and bury actions to the browser repository

**Files:**
- Modify: `app/lib/features/browser/data/anki_card_browser_repository.dart`
- Modify: `app/test/features/browser/data/anki_card_browser_repository_test.dart`

**Interfaces:**
- Produces: `CardBulkAction { suspend, bury }` and
  `CardBrowserRepository.applyBulkAction(List<int> cardIds, CardBulkAction action)`.
- `AnkiCardBrowserRepository` maps `suspend` to
  `BuryOrSuspendCardsRequest_Mode.SUSPEND` and `bury` to
  `BuryOrSuspendCardsRequest_Mode.BURY_USER`, using
  `BackendOperation.buryOrSuspendCards`.

- [x] **Step 1: Add failing repository contract tests**

Add tests named `encodes suspend and bury modes with only the requested card
IDs` and `does not call Anki when there are no selected cards`. Assert the
captured operation is `BackendOperation.buryOrSuspendCards`, decoded
`cardIds` equal `[Int64(21), Int64(34)]`, each decoded mode equals the requested
action, and an empty ID list makes no backend call.

- [x] **Step 2: Run the repository tests to verify they fail**

Run: `flutter test test/features/browser/data/anki_card_browser_repository_test.dart`
from `app/` in the Playground validation workflow.
Expected: the action type and repository method are missing.

- [x] **Step 3: Implement the action type and repository mapping**

Add `CardBulkAction`, extend `CardBrowserRepository`, and serialize a
`BuryOrSuspendCardsRequest` with `Int64` IDs and the selected mode. Return
without calling Anki when the ID list is empty.

- [x] **Step 4: Re-run the repository tests**

Expected: both repository tests pass and prior repository tests remain green.

- [x] **Step 5: Commit the repository change**

Commit as `feat: expose Anki browser bulk actions`.

### Task 2: Add selection, confirmation, and recoverable bulk actions to the shared browser

**Files:**
- Modify: `app/lib/features/browser/card_browser_page.dart`
- Modify: `app/test/features/browser/card_browser_page_test.dart`
- Modify: `app/test/features/browser/card_browser_note_edit_navigation_test.dart`

**Interfaces:**
- Consumes: Task 1's `CardBrowserRepository.applyBulkAction`.
- Produces: row selection and confirmed “Suspend selected” and “Bury selected”
  actions; successful actions refresh the active query, while canceled/failed
  actions keep selection.

- [x] **Step 1: Add failing widget tests**

Add tests named `confirms selected cards before suspending and refreshes the
current query`, `canceling a bulk action keeps the selection`, `retains the
selection after a backend action fails`, and `clears selection when a new
search is submitted`. Assert confirmation precedes the repository call, only
selected IDs are sent, the active query is searched again after success,
selection remains after cancel/failure, and a new query clears prior IDs.

- [x] **Step 2: Run browser widget tests to verify they fail**

Run: `flutter test test/features/browser` from `app/` in the Playground
validation workflow.
Expected: the page has no row selection or bulk-action controls.

- [x] **Step 3: Implement the shared browser interactions**

Add per-row checkboxes, selected-count controls, suspend/bury confirmations,
and an in-progress state. Clear selection when a new search is submitted or
an action succeeds. Preserve the selected IDs and active query when canceled
or when Anki returns an error. Update repository fakes for the new interface.

- [x] **Step 4: Run browser widget tests**

Expected: all browser tests pass, including existing note-edit navigation.

- [x] **Step 5: Commit the shared browser change**

Commit as `feat: add confirmed card browser bulk actions`.

### Task 3: Run final checks and publish the tested commits to the parity PR

**Files:**
- No new source files.

**Interfaces:**
- Consumes: Tasks 1 and 2.
- Produces: verified commit range on the existing `feat/mobile-and-core-parity`
  branch.

- [x] **Step 1: Run the full Flutter verification in Playground**

Run `flutter pub get --enforce-lockfile`, `flutter analyze`, and `flutter test`
against the completed AnkiFlutter branch. Expected: all commands pass.

- [x] **Step 2: Update the existing parity PR branch**

Move `feat/mobile-and-core-parity` to the tested feature commit, then inspect
its all-platform CI run. Expected: protobuf/Rust checks, Flutter tests, and
Linux, macOS, Windows, Android, and iOS builds pass.
