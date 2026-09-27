# Add Note Design

## Goal

Let a user create an Anki note in the deck they opened, using that collection's real note types and fields. The same Flutter flow must work on Linux, macOS, Windows, Android, and iOS through the existing native Anki backend.

## Scope

- Add an **Add note** action to a deck overview.
- Load Anki's available note types and initialize the selected type through `NewNote`.
- Build the entry form from the returned note fields and labels.
- Save with `AddNote` using the selected deck ID.
- Report backend validation failures in the form and keep entered values available for correction.
- After success, clear the form for another note and confirm the save.

Note browsing, editing, deletion, media attachment, and note type creation are separate follow-up work.

## Architecture

The deck overview navigates to a shared Flutter note-entry page. A note repository owns the protobuf request/response encoding and invokes Anki through the existing `BackendInvoker`. The bridge maps only the required `BackendNotetypesService.GetNotetypeNamesAndCounts`, `BackendNotetypesService.GetNotetype`, `BackendNotesService.DefaultsForAdding`, `BackendNotesService.NewNote`, and `BackendNotesService.AddNote` operations, with operation indices derived from the pinned Anki descriptors at build time.

The page loads notetype names and counts and asks `DefaultsForAdding` for Anki's default notetype for the selected deck. It then asks Anki for both the selected type's field labels and a fresh note whenever the notetype changes or a save succeeds. Fields are displayed in the order returned by Anki. Saving sends the entered values without trimming or rewriting their content; Anki remains responsible for duplicate, empty, and notetype validation.

## User-visible behavior

- Opening **Add note** shows a loading state while Anki returns note types and a new note.
- Each notetype selection displays its own ordered set of fields.
- The user can return to the deck overview without saving.
- A successful save displays confirmation and prepares a clean note of the same type in the same deck.
- A failed save shows an actionable error and preserves the user's field values.

## Tests

- Repository tests decode captured protobuf requests and assert exact backend operation IDs and payload values.
- Controller/page tests cover loading, notetype changes, dynamic field counts and order, save success/reset, save failure/value preservation, and cancellation.
- Existing Flutter analysis and unit suite remain green.
- Rust bridge formatting, lint, and tests verify the new descriptor mappings.
- GitHub Actions remains responsible for Linux, Android, and iOS builds; the shared Flutter page requires no platform-specific UI implementation.

## Constraints

- Use the pinned Anki protobuf descriptors; do not duplicate Anki business logic in Dart.
- Keep the bridge as the single native backend on all platforms.
- Do not add dependencies for the form or RPC layer.
- Use the repository's existing test-first workflow.
