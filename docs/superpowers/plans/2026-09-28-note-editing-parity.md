# Note Editing Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let a user open a browser result, edit its real Anki note fields and
tags, save through the official backend, and immediately see updated browser
rows on every supported platform.

**Architecture:** Extend the existing descriptor-indexed bridge with only the
`get_note` and `update_notes` service calls. A typed repository owns protobuf
mapping, while a reusable Flutter note editor owns form state and validation.
The browser pushes that editor and refreshes its current query after a save.

**Tech Stack:** Flutter Material 3, Dart protobuf bindings, Dart FFI, Rust,
official pinned Anki backend, Flutter tests, Rust tests.

**Spec:** `docs/superpowers/specs/2026-09-28-core-anki-parity-design.md`

## Global Constraints

- The pinned official Anki Rust backend remains the authority for collection
  mutation, duplicate checks, card generation, and undo.
- One Flutter UI and one Rust bridge source tree must work on Linux, macOS,
  Windows, Android, and iOS.
- Every new behavior follows RED → GREEN → refactor with a real automated
  test, then the affected full suite.
- Backend errors retain their operation context and leave the collection open.
- Commits are task-sized; meaningful PR updates run public-repository CI.

## Review Focus

- Saving a note whose notetype has changed fields must let the backend produce
  its authoritative validation error instead of corrupting the form.
- A failed update must keep the user-entered fields and tags editable for retry.
- Tag whitespace and duplicates must be normalized by the backend, then shown
  exactly as returned after reopening.
- Browser refresh must preserve the active search query after editing a note.
- A browser result for a missing/deleted note must show an actionable error,
  not crash the page.

### Task 1: Expose real note retrieval and update operations

**Files:**
- Modify: `app/lib/core/backend/backend_operation.dart`
- Modify: `native/anki_bridge/build.rs`
- Modify: `native/anki_bridge/src/ffi.rs`
- Modify: `app/test/core/backend/backend_operation_test.dart`
- Modify: `native/anki_bridge/src/ffi.rs` Rust test module

**Interfaces:**
- Consumes: generated `anki_proto::notes::{NoteId, UpdateNotesRequest}`
- Produces: `BackendOperation.getNote` and `BackendOperation.updateNotes`,
  mapped to the generated Anki operation indexes; `invoke_backend()` accepts
  their serialized protobuf requests.

- [ ] **Step 1: Write failing Dart and Rust operation mapping tests**

Assert that both enum operations map to their generated Anki service indexes
and that their names are present in the bridge's supported-operation table.

- [ ] **Step 2: Run the focused mapping tests to verify they fail**

Run: `cargo test -p anki_flutter_bridge operation --locked` and
`flutter test test/core/backend/backend_operation_test.dart`

Expected: failures because the operations are absent.

- [ ] **Step 3: Add `getNote` and `updateNotes` operation mappings**

Map only descriptor-derived indexes. Do not hand-code protobuf field layouts or
collection SQL.

- [ ] **Step 4: Run focused Rust and Dart mapping tests**

Expected: both focused suites pass.

- [ ] **Step 5: Commit**

`git commit -m "feat: expose Anki note update operations"`

### Task 2: Add a typed editable-note repository

**Files:**
- Modify: `app/lib/features/notes/data/anki_note_repository.dart`
- Create: `app/test/features/notes/data/anki_note_repository_test.dart`

**Interfaces:**
- Consumes: `BackendInvoker`, `BackendOperation.getNote`,
  `BackendOperation.updateNotes`, generated `notes.Note`.
- Produces: `Future<notes.Note> getNote(int noteId)` and
  `Future<void> updateNote(notes.Note note)` on `NoteEntryRepository`.

- [ ] **Step 1: Write failing repository tests**

Test that `getNote(42)` serializes `notes.NoteId(nid: Int64(42))`, decodes the
returned note, and that `updateNote()` serializes an
`UpdateNotesRequest(notes: [note], skipUndoEntry: false)`.

- [ ] **Step 2: Run repository tests to verify they fail**

Run: `flutter test test/features/notes/data/anki_note_repository_test.dart`

Expected: compilation failure because the interface methods do not exist.

- [ ] **Step 3: Implement the two repository methods**

Keep protobuf conversion inside `AnkiNoteRepository`; callers receive the
generated note so unknown backend fields survive an edit.

- [ ] **Step 4: Run repository tests to verify they pass**

Expected: all repository tests pass.

- [ ] **Step 5: Commit**

`git commit -m "feat: add typed Anki note editing repository"`

### Task 3: Build a reusable note editor with recoverable saves

**Files:**
- Create: `app/lib/features/notes/note_editor_page.dart`
- Create: `app/test/features/notes/note_editor_page_test.dart`
- Modify: `app/lib/features/notes/add_note_page.dart`

**Interfaces:**
- Consumes: `NoteEntryRepository.getNotetype()`, `getNote()`, `updateNote()`,
  `notes.Note`, and `notetypes.Notetype`.
- Produces: `NoteEditorPage.edit({required int noteId, required NoteEntryRepository repository})`
  which pops `true` only after a successful save.

- [ ] **Step 1: Write failing widget tests**

Cover loading a note's named fields and tags, saving edited values, keeping
form values after a repository failure, and showing an error with a Retry
action.

- [ ] **Step 2: Run editor widget tests to verify they fail**

Run: `flutter test test/features/notes/note_editor_page_test.dart`

Expected: test compilation failure because `NoteEditorPage.edit` is absent.

- [ ] **Step 3: Implement `NoteEditorPage.edit`**

Build field inputs in notetype order, store tags in one editable text field,
and replace only `fields` and `tags` on the loaded protobuf note before
calling `updateNote()`. Disable Save while a request is active.

- [ ] **Step 4: Reuse the editor field form from add-note**

Extract only the common field/tag form widget needed by both pages; preserve
the existing add-note behavior and tests.

- [ ] **Step 5: Run note page tests**

Run: `flutter test test/features/notes`

Expected: add and edit page tests pass.

- [ ] **Step 6: Commit**

`git commit -m "feat: add recoverable Anki note editor"`

### Task 4: Navigate from browser results and refresh the current query

**Files:**
- Modify: `app/lib/features/browser/card_browser_page.dart`
- Modify: `app/lib/features/browser/data/anki_card_browser_repository.dart`
- Create: `app/test/features/browser/card_browser_note_edit_navigation_test.dart`

**Interfaces:**
- Consumes: `NoteEditorPage.edit`, browser result `noteId`, and the existing
  card-browser query controller.
- Produces: an edit action per browser row; on `true` result, reloads the
  same query and current browser column state.

- [ ] **Step 1: Write failing navigation tests**

Test tapping a row's Edit action opens the editor for that result's note ID;
after a successful close, the original search text remains and repository
search is called again. Test a missing note displays a snackbar and leaves the
browser usable.

- [ ] **Step 2: Run browser navigation tests to verify they fail**

Run: `flutter test test/features/browser/card_browser_note_edit_navigation_test.dart`

Expected: missing Edit action/navigation behavior.

- [ ] **Step 3: Add the browser Edit action and refresh callback**

Push the editor route using the shared note repository. Refresh only when the
editor returns `true`; do not discard the browser query or selection on a
cancel/failure.

- [ ] **Step 4: Run browser tests**

Run: `flutter test test/features/browser`

Expected: all browser tests pass.

- [ ] **Step 5: Commit**

`git commit -m "feat: edit Anki notes from card browser"`

### Task 5: Verify real FFI edit behavior and platform packaging

**Files:**
- Modify: `app/integration_test/real_backend_deck_list_test.dart`
- Modify: `.github/workflows/ci.yml` only if the existing integration command
  does not already run the new case.

**Interfaces:**
- Consumes: Tasks 1–4 and the disposable real collection test harness.
- Produces: real-backend proof that adding a note, editing it, and searching
  for its changed field succeeds through the FFI bridge.

- [ ] **Step 1: Write a failing real-backend integration test**

Create a disposable collection, add a Basic note, edit its Front field and
tags through `AnkiNoteRepository`, then search for the changed value and
assert exactly the original note ID is returned.

- [ ] **Step 2: Run the integration test to verify it fails**

Run: `python3 tool/run_desktop_dev.py --test integration_test/real_backend_deck_list_test.dart`

Expected: failure before the operation/repository/UI changes are complete.

- [ ] **Step 3: Run the full local verification suite**

Run: `cargo fmt --check && cargo clippy --all-targets -- -D warnings && cargo test --locked && flutter test`

Expected: all available local checks pass. Record unavailable SDK checks for
hosted CI rather than weakening them.

- [ ] **Step 4: Push the task commits and verify public CI**

Confirm protobuf drift, Rust tests, Flutter tests, Linux build, Android APK,
and iOS simulator build succeed on the PR head.

- [ ] **Step 5: Commit and open/update the authoring-parity PR**

`git commit -m "test: cover real Anki note editing flow"`

## Follow-up plans

- `browser-bulk-actions`: selection, suspend/bury/delete, card actions, and
  persisted browser sorting.
- `review-settings-and-custom-study`: deck options, filtered decks, custom
  study, shortcuts, and study statistics.
- `collection-portability`: `.apkg` import/export, media transfer, staging,
  conflict-safe replacement, and recovery.
- `sync-parity`: capability audit and AnkiWeb-compatible sync user flow.
- `release-polish`: profiles/onboarding, accessibility, responsive layouts,
  desktop platform integrations, performance, and release artifacts.
