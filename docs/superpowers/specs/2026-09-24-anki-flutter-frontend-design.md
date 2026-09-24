# AnkiFlutter Frontend Architecture Design

Date: 2026-09-24
Status: Pending written-spec review; implementation not started

## 1. Purpose

AnkiFlutter is an open-source Flutter replacement frontend for Anki Desktop. It is not a new flashcard engine and should not reimplement Anki behavior that already exists in the official Anki backend.

The project should provide a modern cross-platform desktop UI while preserving real Anki compatibility by reusing as much of the official Anki Rust backend (`rslib`) and protobuf service surface as practical.

Initial target platforms are Windows, macOS, and Linux. The architecture should avoid choices that unnecessarily block Android or iOS later, but mobile parity is not part of the initial implementation scope.

## 2. Success criteria

The project is successful when a user can use AnkiFlutter as a practical alternative frontend for a real Anki collection without maintaining a separate scheduling/database implementation.

Core success criteria:

- Open and use a real Anki collection.
- Use the official Anki scheduling and FSRS logic.
- Preserve Anki deck, note, card, media, search, import/export, and sync semantics wherever those capabilities are available from upstream.
- Present a modern Flutter desktop UI instead of cloning the existing PyQt UI.
- Keep upstream Anki-specific details behind a narrow compatibility layer.
- Use strict test-driven development for every handwritten behavior.
- Keep feature modules independently testable.

## 3. Upstream architecture assumptions

Official Anki is already separated into GUI and backend layers. Most backend logic lives in Rust under `rslib`, with Python proxying calls into Rust. Anki uses Protocol Buffers for backend methods and data interchange.

Relevant upstream references:

- Architecture: https://github.com/ankitects/anki/blob/main/docs/architecture.md
- Protobuf definitions: https://github.com/ankitects/anki/tree/main/proto/anki
- License: https://github.com/ankitects/anki/blob/main/LICENSE

Anki explicitly documents that its protobuf surface is not currently a stable public API. AnkiFlutter must therefore isolate upstream churn behind its own bridge/repository APIs and pin an exact supported Anki revision instead of silently building against arbitrary upstream `main`.

## 4. License

The official Anki codebase is licensed under AGPL-3.0-or-later, with some separately licensed components. Because AnkiFlutter intends to incorporate and link against official Anki backend code, the repository and distribution process must comply with applicable AGPL obligations.

The project must include license and attribution files before the first distributable release.

## 5. High-level architecture

```text
Flutter UI
   |
   | stable Dart domain/repository APIs
   v
AnkiFlutter backend client
   |
   | FFI + serialized protobuf payloads
   v
native/anki_bridge
   |
   | pinned integration with upstream APIs
   v
Official Anki rslib
   |
   +-- collection / SQLite
   +-- scheduler / FSRS
   +-- decks
   +-- notes / cards
   +-- search
   +-- rendering
   +-- sync
   +-- import / export
   +-- statistics and other backend services
```

The Flutter layer must not directly depend on upstream protobuf objects in widgets or feature state. Generated protobuf code is an integration detail.

## 6. Upstream pinning strategy

AnkiFlutter will include the official `ankitects/anki` repository as a git submodule at `third_party/anki`, pinned to an exact commit.

The submodule commit recorded by the AnkiFlutter repository is the single source of truth for the supported upstream Anki revision. Local builds and CI must use that checked-out revision and must fail clearly if the submodule is missing or at the wrong revision.

Rules:

- Never build releases against a floating upstream branch.
- Upgrade the Anki submodule deliberately in its own change.
- Run bridge contract tests before accepting an upstream bump.
- Keep adaptation for protobuf/service changes inside `native/anki_bridge`, generated bindings, or backend adapters.
- Do not spread upstream type changes through feature widgets.

## 7. Native bridge

`native/anki_bridge` is intentionally thin. It exists to make the official Rust backend safely callable from Dart and to shield Flutter from Rust ABI details.

The bridge exposes a small handle-based C-compatible FFI surface. The first implementation must support lifecycle operations plus one generic serialized command request/response path rather than defining a separate FFI function for every Anki method.

Conceptually:

```text
backend_create -> backend handle
backend_open_collection(handle, path)
backend_command(handle, command id/name, protobuf bytes) -> result bytes/error
backend_abort(handle)
backend_close_collection(handle)
backend_destroy(handle)
```

The exact ABI data types are established by tests, but the architectural contract is fixed: opaque backend handle, owned byte buffers, explicit release functions, no Rust objects crossing FFI, and no panic unwinding across the boundary.

The preferred command path is serialized protobuf input/output, avoiding a large hand-maintained FFI API for every backend method.

The bridge owns:

- backend lifecycle;
- memory ownership across the FFI boundary;
- conversion between FFI buffers and upstream backend calls;
- stable error envelopes for Dart;
- cancellation/abort plumbing where supported;
- compatibility adaptations required by the pinned Anki revision.

The bridge must not duplicate scheduling or collection business logic.

## 8. Dart backend layer

Dart receives data through a dedicated backend package/module and maps integration objects into stable domain objects.

Example boundary:

```dart
abstract interface class DeckRepository {
  Future<List<Deck>> getDecks();
  Future<DeckId> createDeck(String name);
  Future<void> renameDeck(DeckId id, String name);
}
```

Widgets depend on repositories/use-cases, not FFI calls and not generated protobuf classes.

This gives the project:

- testable Flutter features without loading native code in every widget test;
- isolation from upstream protobuf churn;
- clear error handling;
- room for integration tests against the real Rust backend.

## 9. Project structure

Target structure:

```text
AnkiFlutter/
├── app/
│   ├── lib/
│   │   ├── app/
│   │   ├── core/
│   │   │   ├── backend/
│   │   │   ├── models/
│   │   │   ├── routing/
│   │   │   └── theme/
│   │   └── features/
│   │       ├── decks/
│   │       ├── study/
│   │       ├── browser/
│   │       ├── editor/
│   │       ├── add_note/
│   │       ├── deck_options/
│   │       ├── statistics/
│   │       ├── sync/
│   │       ├── import_export/
│   │       └── preferences/
│   └── test/
├── native/
│   └── anki_bridge/
│       ├── src/
│       └── tests/
├── proto/
│   ├── anki/
│   └── generated/
├── third_party/
│   └── anki/        # git submodule pinned to an exact commit
├── integration_test/
└── docs/
```

The exact generated directories may change during implementation if tool requirements demand it, but the architectural boundaries must stay the same.

## 10. Strict TDD rule

Test-driven development is a hard project rule for handwritten production behavior.

For every feature or bug fix:

1. Write one focused behavior test.
2. Run it and confirm it fails for the expected reason.
3. Write the minimum production code needed to satisfy that behavior.
4. Run the focused test and confirm it passes.
5. Run the complete relevant test suite.
6. Refactor only while green.
7. Run the complete suite again.
8. Repeat with the next behavior.

No handwritten production feature code should be committed unless its behavior was introduced by a failing test first.

Exceptions are limited to generated code and unavoidable platform/build configuration. Generated code is instead covered by generator/contract/integration tests.

## 11. Test layers

### Rust unit tests

Used for bridge-owned behavior such as:

- lifecycle state;
- FFI memory ownership;
- invalid input handling;
- error serialization;
- command dispatch adaptation;
- cancellation behavior implemented by the bridge.

### Rust integration/contract tests

Use a temporary real Anki collection and the pinned upstream backend. These prove that AnkiFlutter's bridge contract still matches upstream behavior.

Examples:

- open an empty collection;
- fetch the default deck;
- create/rename/delete a deck;
- close and reopen a collection and verify persistence;
- request queued cards;
- answer a card and observe scheduling state changes.

### Dart unit tests

Cover:

- protobuf/integration-object to domain-model mapping;
- repositories;
- error conversion;
- state reducers/controllers/use-cases;
- input validation owned by the frontend.

### Flutter widget tests

Cover actual user-facing behavior:

- loading states;
- empty states;
- deck rows and counts;
- navigation;
- keyboard actions;
- error states;
- editor interactions.

### End-to-end integration tests

Run Flutter against the real native bridge and temporary Anki collections for critical workflows.

Initial critical path:

`launch -> open collection -> display decks -> select deck -> display real counts`.

Later critical path:

`queue card -> render question -> reveal answer -> answer -> next card`.

## 12. UI direction

AnkiFlutter should preserve Anki concepts and workflows, but should not visually reproduce old Anki Desktop.

UI principles:

- Flutter Material 3 baseline;
- light, dark, and system themes;
- responsive desktop layouts;
- keyboard-first operation for common study/browser actions;
- familiar Anki terminology;
- accessible focus and semantics;
- card content remains the visual priority during review;
- restrained animation;
- platform-appropriate menus, window behavior, file pickers, and shortcuts where practical.

The UI should be modular so appearance can evolve without coupling presentation to upstream backend types.

## 13. Feature sequence

### Phase 1: Foundation and first vertical slice

- Flutter desktop project foundation.
- Rust bridge crate.
- reproducible pinned Anki backend integration.
- generated protobuf/binding pipeline.
- backend lifecycle.
- collection open/close.
- domain/repository boundary.
- deck hierarchy and counts.
- deck selection/overview.

Milestone outcome:

```text
Launch AnkiFlutter
       -> Rust backend loads
       -> choose/create collection
       -> official Anki backend opens collection
       -> Flutter displays real deck hierarchy
       -> select deck
       -> display real New / Learn / Review counts
```

### Phase 2: Reviewer

- queued cards;
- question rendering;
- reveal answer;
- Again / Hard / Good / Easy;
- answer intervals;
- keyboard shortcuts;
- timer;
- undo;
- bury/suspend;
- next-card flow.

Scheduling decisions remain in upstream Anki.

### Phase 3: Note editing and adding

- note fields;
- note types;
- tags;
- HTML/rich text editing;
- cloze;
- media insertion;
- note/card validation.

### Phase 4: Browser

- Anki search;
- result table/list;
- sorting where backend semantics support it;
- card/note editing;
- multi-selection operations;
- suspend/bury/delete/change deck operations.

### Phase 5: Full desktop essentials

- deck options and FSRS settings;
- custom study/filtered decks;
- statistics;
- import/export;
- AnkiWeb sync;
- preferences;
- media management/checking;
- desktop packaging and updates strategy.

## 14. Error handling

The native boundary must return structured errors instead of panicking across FFI.

Dart should convert integration errors into stable application error types. Feature UI should distinguish at least:

- invalid/corrupt collection;
- collection locked/in use where detectable;
- backend incompatibility;
- sync/network error;
- invalid user input;
- unsupported upstream operation;
- unexpected internal failure.

Unexpected errors should include diagnostic details suitable for logs without exposing secrets such as sync credentials.

## 15. Collection safety

A real Anki collection is user data. Data integrity takes priority over convenience.

Rules:

- avoid direct SQLite writes from Dart;
- use upstream collection operations whenever available;
- integration tests use temporary copies/fixtures, never the user's real collection;
- destructive operations need clear UI confirmation where appropriate;
- the app must close/flush backend resources correctly;
- crash recovery and backup behavior should reuse upstream mechanisms when the pinned backend exposes them; otherwise those features stay disabled until a compatible implementation is designed.

## 16. Protobuf and generated code

Dart protobuf types should be generated from the protobuf definitions associated with the pinned Anki submodule revision when those definitions are used by the bridge contract.

Generated Dart protobuf/binding output is checked into the repository so contributors and release builds do not depend on implicit regeneration. A deterministic generation command and CI consistency check must verify that committed generated files match their source definitions.

Generated code:

- is not manually edited;
- is reproducible from the pinned upstream definitions and repository tooling;
- is treated as an integration representation rather than the app's domain model.

If a specific upstream service cannot be represented safely through direct generated Dart protobufs, the Rust bridge may expose a smaller AnkiFlutter-owned protobuf message for that service. Such messages are compatibility shims only; they must not reimplement Anki business rules.

## 17. State management

No state-management package is mandated by the architecture. The implementation plan should choose the smallest maintainable solution once the initial Flutter skeleton exists.

Requirements are more important than library choice:

- business logic outside widgets;
- injectable repositories;
- deterministic tests;
- no native backend singleton hidden inside presentation widgets;
- clear application-level ownership of backend/collection lifecycle.

## 18. Non-goals for initial parity

The following are intentionally outside the initial implementation target:

- binary compatibility with Anki Desktop plugins;
- running arbitrary Python/PyQt Anki add-ons;
- recreating Anki's existing UI pixel-for-pixel;
- independently reimplementing FSRS or scheduler algorithms;
- independently defining a new collection/database format;
- a second cloud-sync protocol;
- mobile-first UI parity.

Python/PyQt add-ons depend heavily on the existing desktop frontend/runtime. Add-on compatibility can be investigated later as a separate architecture project.

## 19. CI and quality gates

CI should enforce for the first vertical slice:

- Dart formatting and static analysis;
- Flutter unit/widget tests;
- Rust formatting/lints/tests;
- bridge contract tests;
- generated-code consistency checks;
- at least one Linux desktop build/smoke path.

Windows and macOS build jobs must be added before those platforms are advertised as supported distributable targets. License/attribution checks must be present before the first distributable release.

A change that alters feature behavior must include the TDD test that drove it.

## 20. First implementation target

The first implementation plan must stop at a useful vertical slice rather than trying to build complete Anki parity at once.

The first target is:

1. bootstrap Flutter desktop shell;
2. bootstrap native Rust bridge;
3. add the official Anki repository as a submodule at `third_party/anki` pinned to an exact commit;
4. compile the bridge against that pinned Anki source;
5. prove one request can cross Dart -> FFI -> Rust/Anki -> FFI -> Dart;
6. open/create a temporary or user-selected collection;
7. expose deck data through a Dart repository;
8. render the real deck hierarchy and New/Learn/Review counts;
9. select a deck and show a minimal deck overview;
10. cover each handwritten behavior with strict Red-Green-Refactor TDD;
11. add one end-to-end smoke test for the entire path.

The reviewer and other features begin only after this slice is green and structurally sound.

## 21. Design constraints summary

The implementation must preserve these decisions:

- Flutter is the frontend.
- Official Anki backend code is reused as extensively as practical.
- No separate scheduler or collection engine is created.
- Official Anki source is a git submodule at `third_party/anki`, pinned to an explicit commit.
- Upstream instability is isolated behind the native bridge and Dart repository layer.
- Generated protobuf types do not leak into widgets.
- Generated Dart integration bindings are reproducible and checked in.
- Strict TDD precedes handwritten production behavior.
- The first deliverable is the real-collection deck-list vertical slice.
- Existing Python/PyQt add-ons are not an initial compatibility goal.
