# Browser Selected Card Deletion Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let users delete selected cards from the shared browser on Linux, macOS, Windows, Android, and iOS.

**Architecture:** The shared browser uses its current selection and a count-confirmation dialog. The repository serializes Anki's generated `RemoveCardsRequest`; the Rust bridge exposes descriptor-derived `CardsService.remove_cards` under stable operation ID 32. Successful deletion clears selection and refreshes the current search. Cancellation and backend errors preserve selection.

**Spec:** `docs/superpowers/specs/2026-09-28-core-anki-parity-design.md` and `docs/superpowers/specs/2026-09-27-card-browser-design.md`.

## Global Constraints

- Anki remains authoritative for deleting cards and their related data.
- The feature uses shared Flutter code and the same bridge on every supported platform.
- Confirmation names the number of cards before the backend is called.
- Only selected card IDs are sent; an empty list does not call Anki.
- Success refreshes the current query; cancellation or failure retains the selected IDs.

## Review Focus

- Stable operation ID 32 maps to the descriptor-derived `CardsService.remove_cards` method.
- The protobuf request contains exactly the selected card IDs.
- The UI does not call the backend before explicit confirmation.
- A failed deletion keeps the query and selection available for retry.

---

### Task 1: Specify the Anki removal bridge and repository contract

**Files:**
- Modify: `native/anki_bridge/tests/operation_indices.rs`
- Modify: `native/anki_bridge/tests/backend_contract.rs`
- Modify: `app/test/features/browser/data/anki_card_browser_repository_test.dart`

**Steps:**

- [ ] Add a Rust operation-index assertion and a real-backend contract test for removing a selected card.
- [ ] Add repository tests that decode `RemoveCardsRequest`, assert operation 32 and exact IDs, and verify empty input makes no backend call.
- [ ] Run the hosted repository test to observe the missing delete API.

### Task 2: Expose Anki card deletion through the shared backend

**Files:**
- Modify: `native/anki_bridge/build.rs`
- Modify: `native/anki_bridge/src/ffi.rs`
- Modify: `native/anki_bridge/tests/operation_indices.rs`
- Modify: `native/anki_bridge/tests/backend_contract.rs`
- Modify: `app/lib/core/backend/backend_operation.dart`
- Modify: `app/lib/features/browser/data/anki_card_browser_repository.dart`

**Steps:**

- [ ] Add stable bridge operation ID 32 for `BackendCardsService.remove_cards`.
- [ ] Add `CardBulkAction.delete` and serialize Anki's generated `RemoveCardsRequest`.
- [ ] Run Playground repository tests and PR bridge tests.

### Task 3: Add confirmed deletion to the shared browser

**Files:**
- Modify: `app/lib/features/browser/card_browser_page.dart`
- Modify: `app/test/features/browser/card_browser_page_test.dart`
- Modify: `app/test/features/browser/card_browser_note_edit_navigation_test.dart`

**Steps:**

- [ ] Add widget tests for confirmation-before-delete, exact selected IDs, current-query refresh, cancel, and backend failure.
- [ ] Add the “Delete selected” control and count-aware confirmation; preserve selection on cancel/failure.
- [ ] Run browser widget tests, analysis, and the full Flutter suite on Playground.

### Task 4: Update the draft parity PR and verify all platforms

**Steps:**

- [ ] Push the tested source to the existing `feat/mobile-and-core-parity` branch.
- [ ] Inspect Rust, Flutter, Linux, Android, iOS, macOS, and Windows CI before completion.
