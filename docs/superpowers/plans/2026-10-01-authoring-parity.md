# Authoring Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Finish first-release note-type, field, template, and styling management using the pinned Anki backend on Linux, macOS, Windows, Android, and iOS.

**Architecture:** Extend the stable native operation table with Anki's typed notetype mutations. A feature repository owns protobuf requests and preserves complete `Notetype` messages, while Flutter pages edit copies and only persist through `UpdateNotetype`, `AddNotetype`, and `RemoveNotetype`.

**Tech Stack:** Flutter/Dart, protobuf Dart, Rust FFI bridge, pinned Anki Rust backend.

**Spec:** `docs/superpowers/specs/2026-09-28-core-anki-parity-design.md`

## Global Constraints

- The official Anki Rust backend remains authoritative for collection schema and validation.
- One Dart/Rust source tree must behave equivalently on Linux, macOS, Windows, Android, and iOS.
- Destructive note-type deletion requires explicit confirmation and shows affected-note count.
- Repository and widget behavior must be testable without a native backend.
- Native operation IDs are append-only and existing IDs remain stable.

## Review Focus

- Reject blank/duplicate field and template names before invoking the backend.
- Never allow the last field or last normal-card template to be removed in the editor.
- Duplicating a note type must not reuse the source notetype identity or merge IDs.
- A failed save/delete must leave the editor/list usable and show the backend error.
- Closing/reopening the page must reload backend state rather than retaining a mutated unsaved object.

---

### Task 1: Notetype mutation bridge

**Files:**
- Modify: `app/lib/core/backend/backend_operation.dart`
- Modify: `native/anki_bridge/build.rs`
- Modify: `native/anki_bridge/src/ffi.rs`
- Modify: `native/anki_bridge/tests/backend_contract.rs`
- Modify: `native/anki_bridge/tests/operation_indices.rs`

**Interfaces:**
- Produces: `BackendOperation.updateNotetype`, `addNotetype`, `removeNotetype` mapped to pinned Anki descriptors.

- [ ] Write operation-index contract tests for IDs 36-38.
- [ ] Run the native contract tests and confirm the new assertions fail before bridge implementation.
- [ ] Add descriptor lookups/constants and stable FFI mappings.
- [ ] Run native bridge tests and confirm all mappings pass.
- [ ] Commit.

### Task 2: Typed note-type repository

**Files:**
- Create: `app/lib/features/notetypes/data/anki_notetype_repository.dart`
- Test: `app/test/features/notetypes/data/anki_notetype_repository_test.dart`

**Interfaces:**
- Produces: list/get/update/duplicate/remove operations over generated `Notetype` messages.

- [ ] Write fake-backend repository tests for request operation and protobuf payloads.
- [ ] Run the repository tests and confirm they fail before implementation.
- [ ] Implement typed repository calls and identity-safe duplication.
- [ ] Run repository tests and the full Flutter suite.
- [ ] Commit.

### Task 3: Note-type list and editor

**Files:**
- Create: `app/lib/features/notetypes/notetype_list_page.dart`
- Create: `app/lib/features/notetypes/notetype_editor_page.dart`
- Modify: `app/lib/features/decks/deck_list_page.dart`
- Test: `app/test/features/notetypes/notetype_list_page_test.dart`
- Test: `app/test/features/notetypes/notetype_editor_page_test.dart`

**Interfaces:**
- Consumes: `NotetypeRepository` from Task 2.
- Produces: navigation from the deck toolbar to a responsive list/editor with field, template, and CSS editing.

- [ ] Write widget tests for load/error, save, duplicate/delete confirmation, field/template validation, and template front/back editing.
- [ ] Run widget tests and confirm they fail before UI implementation.
- [ ] Implement list/editor and wire navigation.
- [ ] Run Flutter analysis/tests.
- [ ] Commit.

### Task 4: Cross-platform validation

**Files:**
- Modify only validation metadata/workflow inputs in the public `Persie0/Playground` repository.

**Interfaces:**
- Consumes: exact AnkiFlutter head SHA.

- [ ] Trigger public Playground validation for Rust contract tests, Flutter analysis/tests, and native build smoke tests without consuming private-repository Actions credits.
- [ ] Do not block implementation waiting on the workflow; inspect its result only in a later pass.
