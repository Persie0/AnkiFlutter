# AnkiFlutter First Desktop Vertical Slice Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the first usable AnkiFlutter desktop slice: launch a Flutter Material 3 app, load the official Anki Rust backend, open a real `.anki2` collection, show the real deck hierarchy with New/Learn/Review counts, and open a minimal deck overview.

**Architecture:** Flutter owns presentation and small testable controllers. A thin C ABI Rust `cdylib` owns an official `anki::backend::Backend` from a pinned upstream Anki checkout. Dart uses upstream-generated protobuf message classes, while Rust isolates unstable upstream service/method indices and dispatches serialized protobuf through Anki's existing `Backend::run_service_method()` API.

**Tech Stack:** Flutter 3.47.5 / Dart 3.13.4, Dart FFI (`ffi` 2.2.0), Dart protobuf (`protobuf` 6.1.0), `file_picker` 13.1.0, Rust 1.80+, official `ankitects/anki` pinned at `a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`, Anki `rslib`, Protocol Buffers.

**Spec:** `docs/superpowers/specs/2026-09-24-anki-flutter-frontend-design.md`

## Global Constraints

- Flutter is the frontend.
- Initial target platforms are Windows, macOS, and Linux; this plan fully verifies Linux and keeps all handwritten Dart/Rust code platform-neutral.
- Official Anki backend code is reused as extensively as practical.
- No separate scheduler, FSRS implementation, or collection/database engine is created.
- Upstream Anki is pinned to an explicit revision and never built from floating `main`.
- Upstream instability is isolated behind the native bridge and Dart repository layer.
- Generated protobuf types never appear in widgets or feature presentation state.
- Strict TDD is mandatory for every handwritten behavior: RED -> verify expected failure -> GREEN -> full relevant suite -> refactor -> suite again.
- Generated code and unavoidable platform/build configuration are the only TDD exceptions.
- Real-user collections are never used by automated tests; tests create temporary collections.
- Dart never writes Anki SQLite tables directly.
- Python/PyQt add-on compatibility is not part of this plan.
- The repository remains AGPL-compatible with the incorporated upstream Anki code; license and attribution are included before a distributable build.

## Review Focus

1. **Malformed or missing native backend** — app must surface an actionable startup error instead of crashing; pinned by Task 6 FFI client tests and Task 10 widget tests.
2. **Invalid/corrupt/non-Anki collection path** — opening must fail without replacing the current screen with partial deck data; pinned by Task 7 session tests and Task 11 native contract test.
3. **Nested deck names and recursive hierarchy** — children must remain children and counts must not be flattened or recomputed in Flutter; pinned by Task 8 repository tests and Task 10 widget tests.
4. **Upstream service/method reordering** — bridge operation mapping must regenerate from Anki's descriptor set instead of relying on handwritten numeric indices; pinned by Task 3 build-generator test and Task 11 contract test.
5. **FFI buffer ownership/error paths** — every success and error buffer must be copied exactly once and freed exactly once; pinned by Task 5 Rust ABI tests and Task 6 Dart binding tests.

---

## File Structure Locked by This Plan

```text
AnkiFlutter/
├── .github/workflows/ci.yml
├── .gitmodules
├── LICENSE
├── README.md
├── app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app/anki_flutter_app.dart
│   │   ├── core/backend/
│   │   │   ├── anki_backend_client.dart
│   │   │   ├── anki_backend_exception.dart
│   │   │   ├── backend_operation.dart
│   │   │   ├── generated/anki/*.pb.dart
│   │   │   └── native/
│   │   │       ├── native_anki_bindings.dart
│   │   │       └── native_library_loader.dart
│   │   └── features/
│   │       ├── collection/
│   │       │   ├── collection_location.dart
│   │       │   └── collection_session.dart
│   │       └── decks/
│   │           ├── deck_node.dart
│   │           ├── deck_repository.dart
│   │           ├── anki_deck_repository.dart
│   │           ├── deck_list_controller.dart
│   │           ├── deck_list_state.dart
│   │           ├── deck_list_page.dart
│   │           └── deck_overview_page.dart
│   ├── test/
│   │   ├── app/
│   │   ├── core/backend/
│   │   └── features/
│   └── integration_test/real_backend_deck_list_test.dart
├── native/anki_bridge/
│   ├── Cargo.toml
│   ├── build.rs
│   ├── src/lib.rs
│   ├── src/ffi.rs
│   ├── src/operations.rs
│   └── tests/backend_contract.rs
├── third_party/anki/                 # git submodule
└── tool/
    ├── generate_dart_protos.py
    ├── verify_generated_protos.py
    └── run_desktop_dev.py
```

The feature files stay small: collection lifecycle is separate from deck mapping, deck state is separate from widgets, and native memory handling is separate from the high-level backend client.

---

### Task 1: Bootstrap the Flutter desktop shell with a tested app boundary

**Files:**
- Create via Flutter generator: `app/` for Linux, macOS, and Windows
- Create: `app/lib/app/anki_flutter_app.dart`
- Modify: `app/lib/main.dart`
- Create: `app/test/app/anki_flutter_app_test.dart`
- Create: `LICENSE`
- Create: `README.md`

**Interfaces:**
- Consumes: none
- Produces: `AnkiFlutterApp extends StatelessWidget`; a runnable/testable Flutter desktop shell.

- [ ] **Step 1: Generate only framework/platform scaffolding**

Run from repository root:

```bash
flutter --version
# Must report Flutter 3.47.5 / Dart 3.13.4 for this plan.
flutter create --platforms=linux,macos,windows --org dev.persie0 --project-name anki_flutter app
cd app
flutter pub add ffi:^2.2.0 protobuf:^6.1.0 file_picker:^13.1.0
```

Generated Flutter/platform files and dependency configuration are allowed by the project's generated/configuration TDD exception. Delete the generated counter implementation and generated counter test before writing handwritten app behavior.

- [ ] **Step 2: Write the failing app-shell widget test**

Create `app/test/app/anki_flutter_app_test.dart`:

```dart
import 'package:anki_flutter/app/anki_flutter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('boots a Material 3 AnkiFlutter shell', (tester) async {
    await tester.pumpWidget(const AnkiFlutterApp(home: Text('Home')));

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'AnkiFlutter');
    expect(materialApp.debugShowCheckedModeBanner, isFalse);
    expect(materialApp.theme?.useMaterial3, isTrue);
    expect(find.text('Home'), findsOneWidget);
  });
}
```

- [ ] **Step 3: Run the test and verify RED**

Run:

```bash
cd app
flutter test test/app/anki_flutter_app_test.dart
```

Expected: FAIL because `package:anki_flutter/app/anki_flutter_app.dart` / `AnkiFlutterApp` does not exist.

- [ ] **Step 4: Implement the smallest shell**

Create `app/lib/app/anki_flutter_app.dart`:

```dart
import 'package:flutter/material.dart';

class AnkiFlutterApp extends StatelessWidget {
  const AnkiFlutterApp({required this.home, super.key});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnkiFlutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: home,
    );
  }
}
```

Set `main.dart` to call `runApp(const AnkiFlutterApp(home: Placeholder()))`; the placeholder is replaced by Task 10.

- [ ] **Step 5: Verify GREEN and full Flutter suite**

Run:

```bash
cd app
flutter test test/app/anki_flutter_app_test.dart
flutter test
flutter analyze
```

Expected: all PASS; analyzer has no issues.

- [ ] **Step 6: Add AGPL repository license/readme framing**

Use `AGPL-3.0-or-later` for repository code and state in `README.md` that AnkiFlutter is an independent frontend using upstream Anki code and is not affiliated with Ankitects Pty Ltd. Link the pinned upstream source and preserve upstream copyright notices in generated/copied artifacts.

- [ ] **Step 7: Commit**

```bash
git add app LICENSE README.md
git commit -m "feat: bootstrap tested Flutter desktop shell"
```

---

### Task 2: Pin upstream Anki and generate Dart protobuf messages reproducibly

**Files:**
- Create: `.gitmodules`
- Create: `third_party/anki` gitlink
- Create: `tool/generate_dart_protos.py`
- Create: `tool/verify_generated_protos.py`
- Create generated: `app/lib/core/backend/generated/anki/*.pb.dart`
- Create: `app/test/core/backend/generated_proto_smoke_test.dart`

**Interfaces:**
- Consumes: upstream Anki proto files at pinned commit.
- Produces: generated Dart message classes including `BackendInit`, `BackendError`, `OpenCollectionRequest`, `CloseCollectionRequest`, `DeckTreeRequest`, and `DeckTreeNode`.

- [ ] **Step 1: Pin upstream Anki exactly**

Run:

```bash
git submodule add https://github.com/ankitects/anki.git third_party/anki
git -C third_party/anki checkout a5a0e444677a6b58cf784a9c2b7c2d5167f20df0
git add .gitmodules third_party/anki
```

Verify:

```bash
test "$(git -C third_party/anki rev-parse HEAD)" = "a5a0e444677a6b58cf784a9c2b7c2d5167f20df0"
```

- [ ] **Step 2: Add deterministic proto generation tooling**

`tool/generate_dart_protos.py` must:

```python
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
PROTO_ROOT = ROOT / "third_party" / "anki" / "proto"
OUT = ROOT / "app" / "lib" / "core" / "backend" / "generated"

if OUT.exists():
    shutil.rmtree(OUT)
OUT.mkdir(parents=True)
files = sorted((PROTO_ROOT / "anki").glob("*.proto"))
subprocess.run([
    "protoc",
    f"--proto_path={PROTO_ROOT}",
    f"--dart_out={OUT}",
    *map(str, files),
], check=True)
```

Pin the Dart generator command in documentation/CI to:

```bash
dart pub global activate protoc_plugin 25.1.0
python3 tool/generate_dart_protos.py
```

`tool/verify_generated_protos.py` runs the generator and exits non-zero when `git diff --exit-code -- app/lib/core/backend/generated` reports changes.

- [ ] **Step 3: Generate messages**

Run:

```bash
dart pub global activate protoc_plugin 25.1.0
export PATH="$PATH:$HOME/.pub-cache/bin"
python3 tool/generate_dart_protos.py
```

This generated code is explicitly exempt from test-first production-code rules.

- [ ] **Step 4: Write a message round-trip smoke test**

Create `app/test/core/backend/generated_proto_smoke_test.dart`:

```dart
import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pinned Anki DeckTreeNode protobuf round-trips counts and children', () {
    final node = DeckTreeNode(
      deckId: 42,
      name: 'Languages',
      newCount: 3,
      learnCount: 2,
      reviewCount: 7,
      children: [DeckTreeNode(deckId: 43, name: 'Norwegian')],
    );

    final decoded = DeckTreeNode.fromBuffer(node.writeToBuffer());
    expect(decoded.deckId.toInt(), 42);
    expect(decoded.name, 'Languages');
    expect(decoded.newCount, 3);
    expect(decoded.learnCount, 2);
    expect(decoded.reviewCount, 7);
    expect(decoded.children.single.name, 'Norwegian');
  });
}
```

- [ ] **Step 5: Verify generation and tests**

Run:

```bash
cd app
flutter test test/core/backend/generated_proto_smoke_test.dart
cd ..
python3 tool/verify_generated_protos.py
```

Expected: PASS and no generated diff.

- [ ] **Step 6: Commit**

```bash
git add .gitmodules third_party/anki tool app/lib/core/backend/generated app/test/core/backend/generated_proto_smoke_test.dart
git commit -m "build: pin Anki and generate Dart protobufs"
```

---

### Task 3: Generate upstream service/method indices inside the Rust bridge

**Files:**
- Create: `native/anki_bridge/Cargo.toml`
- Create: `native/anki_bridge/build.rs`
- Create: `native/anki_bridge/src/operations.rs`
- Create: `native/anki_bridge/src/lib.rs`
- Create: `native/anki_bridge/tests/operation_indices.rs`

**Interfaces:**
- Consumes: pinned Anki descriptor set via `anki_proto_gen::descriptors_path()` and `get_services()`.
- Produces: `OPEN_COLLECTION`, `CLOSE_COLLECTION`, `DECK_TREE` constants of type `OperationIndex { service: u32, method: u32 }` generated from descriptor names, never handwritten numbers.

- [ ] **Step 1: Create crate configuration**

Use:

```toml
[package]
name = "anki_flutter_bridge"
version = "0.1.0"
edition = "2021"
rust-version = "1.80"
build = "build.rs"

[lib]
crate-type = ["cdylib", "rlib"]

[dependencies]
anki = { path = "../../third_party/anki/rslib", features = ["rustls"] }
anki_proto = { path = "../../third_party/anki/rslib/proto" }
prost = "0.13"

[build-dependencies]
anki_proto = { path = "../../third_party/anki/rslib/proto" }
anki_proto_gen = { path = "../../third_party/anki/rslib/proto_gen" }
prost-reflect = "0.14.7"
```

This is build configuration and falls under the configuration exception.

- [ ] **Step 2: Write the failing operation-index test**

Create `native/anki_bridge/tests/operation_indices.rs`:

```rust
use anki_flutter_bridge::operations::{CLOSE_COLLECTION, DECK_TREE, OPEN_COLLECTION};

#[test]
fn required_operations_are_distinct_and_generated() {
    let values = [OPEN_COLLECTION, CLOSE_COLLECTION, DECK_TREE];
    assert!(values.iter().all(|op| op.service > 0 || op.method > 0));
    assert_ne!(OPEN_COLLECTION, CLOSE_COLLECTION);
    assert_ne!(OPEN_COLLECTION, DECK_TREE);
}
```

- [ ] **Step 3: Run and verify RED**

```bash
cd native/anki_bridge
cargo test --test operation_indices
```

Expected: FAIL because crate/modules/constants do not exist.

- [ ] **Step 4: Implement descriptor-driven generation**

`build.rs` reads `anki_proto_gen::descriptors_path()`, decodes it with `DescriptorPool`, calls `get_services()`, locates:

```text
BackendCollectionService.open_collection
BackendCollectionService.close_collection
BackendDecksService.deck_tree
```

and writes Rust constants into `$OUT_DIR/operations.rs`.

The lookup helper must fail the build with a message containing the missing service/method name if an upstream bump removes or renames one. It must use `BackendService::all_methods()` so delegated collection methods such as `deck_tree` are found.

`src/operations.rs`:

```rust
#[derive(Clone, Copy, Debug, Eq, PartialEq)]
pub struct OperationIndex {
    pub service: u32,
    pub method: u32,
}

include!(concat!(env!("OUT_DIR"), "/operations.rs"));
```

`src/lib.rs` initially contains only:

```rust
pub mod operations;
```

- [ ] **Step 5: Verify GREEN and full Rust suite**

```bash
cargo test --test operation_indices
cargo test
cargo fmt --check
cargo clippy --all-targets -- -D warnings
```

Expected: all PASS.

- [ ] **Step 6: Commit**

```bash
git add native/anki_bridge
git commit -m "build: derive Anki service indices from descriptors"
```

---

### Task 4: Initialize the official Anki backend behind a Rust-owned object

**Files:**
- Modify: `native/anki_bridge/src/lib.rs`
- Create: `native/anki_bridge/src/backend.rs`
- Create: `native/anki_bridge/tests/backend_lifecycle.rs`

**Interfaces:**
- Consumes: serialized upstream `anki.backend.BackendInit` bytes.
- Produces: `BridgeBackend::from_init_bytes(&[u8]) -> Result<BridgeBackend, BridgeError>` and `BridgeBackend::invoke(OperationIndex, &[u8]) -> Result<Vec<u8>, BackendCallError>`.

- [ ] **Step 1: Write the failing lifecycle test**

```rust
use anki_flutter_bridge::backend::BridgeBackend;
use anki_proto::backend::BackendInit;
use prost::Message;

#[test]
fn initializes_official_anki_backend_from_protobuf() {
    let init = BackendInit {
        preferred_langs: vec!["en-US".into()],
        locale_folder_path: String::new(),
        server: false,
    };
    let backend = BridgeBackend::from_init_bytes(&init.encode_to_vec());
    assert!(backend.is_ok());
}

#[test]
fn rejects_malformed_backend_init() {
    let err = BridgeBackend::from_init_bytes(&[0xff, 0xff]).unwrap_err();
    assert!(err.to_string().contains("decode"));
}
```

- [ ] **Step 2: Run and verify RED**

```bash
cargo test --test backend_lifecycle
```

Expected: FAIL because `backend` module does not exist.

- [ ] **Step 3: Implement the minimal backend wrapper**

`BridgeBackend` owns `anki::backend::Backend`. `from_init_bytes()` calls `anki::backend::init_backend()`. `invoke()` calls only the upstream public `Backend::run_service_method(service, method, input)` and returns backend error bytes unchanged.

Do not duplicate collection, deck, scheduling, or database logic.

- [ ] **Step 4: Verify GREEN and refactor while green**

```bash
cargo test --test backend_lifecycle
cargo test
cargo clippy --all-targets -- -D warnings
```

- [ ] **Step 5: Commit**

```bash
git add native/anki_bridge/src native/anki_bridge/tests/backend_lifecycle.rs
git commit -m "feat: wrap official Anki backend lifecycle"
```

---

### Task 5: Add a memory-safe C ABI with explicit success/backend/bridge errors

**Files:**
- Create: `native/anki_bridge/src/ffi.rs`
- Modify: `native/anki_bridge/src/lib.rs`
- Create: `native/anki_bridge/tests/ffi_contract.rs`

**Interfaces:**
- Consumes: raw protobuf byte buffers and operation IDs `1=open_collection`, `2=close_collection`, `3=deck_tree`.
- Produces C ABI:
  - `anki_bridge_create(init_ptr, init_len) -> BridgeCreateResult`
  - `anki_bridge_invoke(handle, operation, input_ptr, input_len) -> BridgeCallResult`
  - `anki_bridge_free_buffer(ByteBuffer)`
  - `anki_bridge_destroy(handle)`
- Status codes: `0=success`, `1=Anki backend error protobuf`, `2=bridge/FFI error UTF-8`.

- [ ] **Step 1: Write failing ABI tests around real exported Rust functions**

Tests must cover:

```rust
#[test]
fn malformed_init_returns_bridge_error_without_handle() { /* status == 2 */ }

#[test]
fn null_handle_returns_bridge_error() { /* invoke(null, ...) => status == 2 */ }

#[test]
fn unknown_operation_returns_bridge_error() { /* operation 999 => status == 2 */ }

#[test]
fn returned_buffer_round_trips_and_is_freed_by_bridge() { /* success/error bytes preserved */ }
```

Use real `BackendInit` protobuf for valid creation and call `anki_bridge_free_buffer()` on every non-empty result in the test.

- [ ] **Step 2: Run and verify RED**

```bash
cargo test --test ffi_contract
```

Expected: FAIL because ABI symbols/types do not exist.

- [ ] **Step 3: Implement exact ABI structs**

```rust
#[repr(C)]
pub struct ByteBuffer {
    pub ptr: *mut u8,
    pub len: usize,
    pub cap: usize,
}

#[repr(C)]
pub struct BridgeCreateResult {
    pub status: u32,
    pub handle: *mut BridgeBackend,
    pub data: ByteBuffer,
}

#[repr(C)]
pub struct BridgeCallResult {
    pub status: u32,
    pub data: ByteBuffer,
}
```

`ByteBuffer::from_vec()` transfers ownership with `Vec::into_raw_parts`-equivalent stable logic (`ManuallyDrop<Vec<u8>>`); `anki_bridge_free_buffer()` reconstructs the vector with `Vec::from_raw_parts()` exactly once. Null input with non-zero length is a bridge error. Null handle is a bridge error. No panic may cross the C ABI; wrap exported bodies in `std::panic::catch_unwind()` and return status `2` on panic.

Operation routing maps `1/2/3` to the descriptor-generated constants from Task 3 and sends input bytes unchanged to `Backend::run_service_method()`.

- [ ] **Step 4: Verify GREEN, Miri-friendly ownership, and suite**

```bash
cargo test --test ffi_contract
cargo test
cargo clippy --all-targets -- -D warnings
```

If the installed toolchain has Miri, additionally run:

```bash
cargo +nightly miri test --test ffi_contract
```

Miri is an additional check, not a completion gate when unavailable.

- [ ] **Step 5: Commit**

```bash
git add native/anki_bridge/src native/anki_bridge/tests/ffi_contract.rs
git commit -m "feat: expose safe Anki bridge C ABI"
```

---

### Task 6: Build the Dart FFI transport and error model test-first

**Files:**
- Create: `app/lib/core/backend/backend_operation.dart`
- Create: `app/lib/core/backend/anki_backend_exception.dart`
- Create: `app/lib/core/backend/native/native_anki_bindings.dart`
- Create: `app/lib/core/backend/native/native_library_loader.dart`
- Create: `app/lib/core/backend/anki_backend_client.dart`
- Create: `app/test/core/backend/anki_backend_client_test.dart`
- Create: `app/test/core/backend/native_anki_bindings_test.dart`

**Interfaces:**
- Consumes: C ABI from Task 5 and generated `BackendInit`/`BackendError` protobufs.
- Produces:
  - `enum BackendOperation { openCollection, closeCollection, deckTree }`
  - `abstract interface class NativeAnkiBindings`
  - `AnkiBackendClient.create(NativeAnkiBindings, BackendInit)`
  - `Future<Uint8List> invoke(BackendOperation operation, Uint8List request)`
  - `void dispose()`.

- [ ] **Step 1: Write failing client behavior tests with a fake binding**

Cover four behaviors:

```dart
test('success returns an exact copy of native response bytes', () async {});
test('backend error decodes BackendError and throws AnkiBackendException', () async {});
test('bridge error decodes UTF-8 and throws AnkiBridgeException', () async {});
test('disposed client rejects further calls', () async {});
```

The fake binding records `freeBuffer` calls; assert each returned native buffer is freed exactly once on success, backend error, and bridge error.

- [ ] **Step 2: Run and verify RED**

```bash
cd app
flutter test test/core/backend/anki_backend_client_test.dart
```

Expected: FAIL because backend client/types do not exist.

- [ ] **Step 3: Implement the minimal client and exception mapping**

`AnkiBackendException` stores upstream `BackendError.kind`, `message`, and `context`; presentation code never receives raw generated proto objects.

`AnkiBridgeException` stores only the bridge error message.

The client must copy native memory into a Dart-owned `Uint8List` before asking the binding to free the native buffer.

- [ ] **Step 4: Write failing dynamic-library selection tests**

Test a pure function `nativeLibraryFileName(TargetPlatform)`:

```dart
expect(nativeLibraryFileName(TargetPlatform.linux), 'libanki_flutter_bridge.so');
expect(nativeLibraryFileName(TargetPlatform.macOS), 'libanki_flutter_bridge.dylib');
expect(nativeLibraryFileName(TargetPlatform.windows), 'anki_flutter_bridge.dll');
```

Also test that an explicit `ANKIFLUTTER_NATIVE_LIB` dart-define path takes precedence over default executable-directory lookup.

- [ ] **Step 5: Implement `DynamicLibrary.open()` binding and verify GREEN**

Bind the exact Task 5 structs/functions with `dart:ffi`. Keep the low-level signatures in `native_anki_bindings.dart`; no feature code imports `dart:ffi`.

Run:

```bash
flutter test test/core/backend/anki_backend_client_test.dart
flutter test test/core/backend/native_anki_bindings_test.dart
flutter test
flutter analyze
```

Expected: all PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/core/backend app/test/core/backend
git commit -m "feat: add tested Dart transport for Anki bridge"
```

---

### Task 7: Open and close real collection locations without frontend DB logic

**Files:**
- Create: `app/lib/features/collection/collection_location.dart`
- Create: `app/lib/features/collection/collection_session.dart`
- Create: `app/test/features/collection/collection_location_test.dart`
- Create: `app/test/features/collection/collection_session_test.dart`

**Interfaces:**
- Consumes: `AnkiBackendClient`, upstream `OpenCollectionRequest` and `CloseCollectionRequest` protobufs.
- Produces:
  - `CollectionLocation.fromCollectionPath(String)`
  - `CollectionSession.open(CollectionLocation)`
  - `CollectionSession.close()`
  - `bool get isOpen`.

- [ ] **Step 1: Write failing media-path derivation tests**

Pin Anki's current desktop convention exactly:

```dart
expect(
  CollectionLocation.fromCollectionPath('/tmp/collection.anki2'),
  const CollectionLocation(
    collectionPath: '/tmp/collection.anki2',
    mediaFolderPath: '/tmp/collection.media',
    mediaDbPath: '/tmp/collection.media.db2',
  ),
);
```

Also test uppercase `.ANKI2`; extension matching is case-insensitive, matching upstream `media_paths_from_col_path()`.

- [ ] **Step 2: Verify RED**

```bash
flutter test test/features/collection/collection_location_test.dart
```

- [ ] **Step 3: Implement only path derivation and verify GREEN**

Do not inspect or write SQLite. Only derive the two media paths from the selected collection file path.

- [ ] **Step 4: Write failing session tests**

Using a fake backend client, assert:

```text
open() serializes OpenCollectionRequest with all three paths
successful open sets isOpen=true
failed open leaves isOpen=false
close() sends CloseCollectionRequest(downgradeToSchema11=false)
second close is a no-op
```

- [ ] **Step 5: Implement session behavior and verify full suite**

Run:

```bash
flutter test test/features/collection
flutter test
flutter analyze
```

- [ ] **Step 6: Commit**

```bash
git add app/lib/features/collection app/test/features/collection
git commit -m "feat: manage Anki collection sessions"
```

---

### Task 8: Map Anki's recursive DeckTree protobuf into stable frontend domain models

**Files:**
- Create: `app/lib/features/decks/deck_node.dart`
- Create: `app/lib/features/decks/deck_repository.dart`
- Create: `app/lib/features/decks/anki_deck_repository.dart`
- Create: `app/test/features/decks/anki_deck_repository_test.dart`

**Interfaces:**
- Consumes: open `CollectionSession`, `AnkiBackendClient`, upstream `DeckTreeRequest`/`DeckTreeNode`.
- Produces:

```dart
class DeckNode {
  const DeckNode({
    required this.id,
    required this.name,
    required this.newCount,
    required this.learnCount,
    required this.reviewCount,
    required this.filtered,
    required this.children,
  });
  final int id;
  final String name;
  final int newCount;
  final int learnCount;
  final int reviewCount;
  final bool filtered;
  final List<DeckNode> children;
}

abstract interface class DeckRepository {
  Future<List<DeckNode>> loadDeckTree();
}
```

- [ ] **Step 1: Write a failing recursive mapping test**

Use a fake backend response containing a root node with two children and one grandchild. Give each level distinct New/Learn/Review values. Assert the Dart domain tree preserves IDs, local names, hierarchy, counts, and `filtered` exactly.

- [ ] **Step 2: Write a failing timestamp test**

Inject `int Function() unixSeconds` into `AnkiDeckRepository`. Assert it serializes `DeckTreeRequest(now: 1_800_000_000)` when the injected clock returns that value. This is required because upstream only includes current counts when `now` is non-zero.

- [ ] **Step 3: Verify RED**

```bash
flutter test test/features/decks/anki_deck_repository_test.dart
```

- [ ] **Step 4: Implement minimal mapping**

The repository invokes `BackendOperation.deckTree`, decodes upstream `DeckTreeNode`, and maps recursively into immutable `DeckNode` objects. It does not recompute totals, merge child counts, split deck names on `::`, or expose protobuf objects.

The upstream response is a synthetic root; return `root.children` as the top-level deck list so the synthetic root is not shown as a deck row.

- [ ] **Step 5: Verify GREEN/full suite**

```bash
flutter test test/features/decks/anki_deck_repository_test.dart
flutter test
flutter analyze
```

- [ ] **Step 6: Commit**

```bash
git add app/lib/features/decks app/test/features/decks/anki_deck_repository_test.dart
git commit -m "feat: expose Anki deck tree as frontend models"
```

---

### Task 9: Add deterministic deck-list state/controller behavior

**Files:**
- Create: `app/lib/features/decks/deck_list_state.dart`
- Create: `app/lib/features/decks/deck_list_controller.dart`
- Create: `app/test/features/decks/deck_list_controller_test.dart`

**Interfaces:**
- Consumes: `DeckRepository`.
- Produces: `DeckListController extends ChangeNotifier` and immutable states `DeckListInitial`, `DeckListLoading`, `DeckListReady(List<DeckNode>)`, `DeckListFailure(Object error)`.

- [ ] **Step 1: Write failing controller tests**

Cover:

```text
load(): Initial -> Loading -> Ready
repository failure: Initial -> Loading -> Failure
retry after Failure calls repository again and can become Ready
dispose prevents UI listeners from receiving further notifications
```

Assert state values, not implementation details or mock call counts except where retry semantics require the second repository request.

- [ ] **Step 2: Verify RED**

```bash
flutter test test/features/decks/deck_list_controller_test.dart
```

- [ ] **Step 3: Implement the smallest controller**

No Riverpod/Bloc dependency is introduced in this first slice. Constructor-inject `DeckRepository`; use `ChangeNotifier` only as the view notification mechanism, with all asynchronous state transitions explicit in the controller.

- [ ] **Step 4: Verify GREEN and suite**

```bash
flutter test test/features/decks/deck_list_controller_test.dart
flutter test
flutter analyze
```

- [ ] **Step 5: Commit**

```bash
git add app/lib/features/decks/deck_list_state.dart app/lib/features/decks/deck_list_controller.dart app/test/features/decks/deck_list_controller_test.dart
git commit -m "feat: add deck list controller"
```

---

### Task 10: Build the Material 3 deck list, collection picker, hierarchy, errors, and overview

**Files:**
- Create: `app/lib/features/decks/deck_list_page.dart`
- Create: `app/lib/features/decks/deck_overview_page.dart`
- Modify: `app/lib/main.dart`
- Create: `app/test/features/decks/deck_list_page_test.dart`
- Create: `app/test/features/decks/deck_overview_page_test.dart`

**Interfaces:**
- Consumes: `CollectionSession`, `DeckListController`, `DeckNode`.
- Produces: user-facing initial collection picker, recursive deck list, count columns, retry/error UI, and minimal deck overview.

- [ ] **Step 1: Write failing deck-list widget tests**

Build the widget with fake session/controller dependencies. Tests must cover:

```text
no collection: shows "Open Anki Collection" action
loading: shows progress indicator and retains app chrome
ready: shows nested deck names with indentation
ready: shows New, Learn, Review column labels and exact counts
ready: a parent with children remains visually hierarchical
failure: shows readable error plus Retry button
native-library startup failure: shows actionable message containing "Anki backend"
```

Use non-zero fake counts such as New=12, Learn=3, Review=45 so swapped columns are detectable.

- [ ] **Step 2: Verify RED**

```bash
flutter test test/features/decks/deck_list_page_test.dart
```

- [ ] **Step 3: Implement the minimal page**

Use Material 3 `Scaffold`, `AppBar`, and `ListView`. A deck row is a small focused widget that receives a `DeckNode` domain object. Render hierarchy by recursion with deterministic left indentation per depth; do not flatten names by parsing `::`.

The open action uses `file_picker` restricted to a single `.anki2` file. On selection:

```text
CollectionLocation.fromCollectionPath(path)
-> CollectionSession.open(location)
-> DeckListController.load()
```

If the picker is cancelled, remain on the initial screen with no error.

- [ ] **Step 4: Write failing deck-overview tests**

Click a deck row and assert navigation shows:

```text
deck name
New count
Learn count
Review count
Study button (disabled in this first slice with tooltip/text "Reviewer coming next")
Back navigation returns to the loaded deck list without reopening the collection
```

- [ ] **Step 5: Implement overview/navigation and wire `main.dart`**

`main.dart` creates the concrete native binding/backend client/session/repository/controller once at application startup and injects them into `AnkiFlutterApp`. Backend/collection disposal is owned by a small root stateful widget; feature widgets do not own the native backend handle.

- [ ] **Step 6: Verify GREEN and full Flutter suite**

```bash
flutter test test/features/decks/deck_list_page_test.dart
flutter test test/features/decks/deck_overview_page_test.dart
flutter test
flutter analyze
```

- [ ] **Step 7: Commit**

```bash
git add app/lib app/test/features/decks
git commit -m "feat: add Material 3 Anki deck browser"
```

---

### Task 11: Prove the bridge against a temporary real Anki collection

**Files:**
- Create: `native/anki_bridge/tests/backend_contract.rs`
- Create: `app/integration_test/real_backend_deck_list_test.dart`
- Create: `tool/run_desktop_dev.py`

**Interfaces:**
- Consumes: actual compiled Rust bridge, pinned Anki backend, temporary filesystem collection.
- Produces: contract proof for `open -> deck_tree -> close` and one Flutter end-to-end smoke path.

- [ ] **Step 1: Write the failing Rust contract test**

The test must:

1. create `tempfile::TempDir` (add `tempfile = "3"` to bridge dev-dependencies);
2. create valid `BackendInit`;
3. call bridge/open operation with `OpenCollectionRequest` pointing at `temp/collection.anki2`, `temp/collection.media`, `temp/collection.media.db2`;
4. call deck-tree with `DeckTreeRequest { now: TimestampSecs::now().0 }` or current UNIX seconds;
5. decode `anki_proto::decks::DeckTreeNode`;
6. assert the generated default collection contains the expected default deck structure and zero initial counts;
7. close with `CloseCollectionRequest { downgrade_to_schema11: false }`;
8. reopen the same path and fetch the tree again to prove persistence/lifecycle correctness.

Also add a negative contract test that passes a path whose parent cannot be created/opened and asserts status `1` with a decodable upstream `BackendError`, never a process panic.

- [ ] **Step 2: Run and verify RED**

```bash
cd native/anki_bridge
cargo test --test backend_contract -- --nocapture
```

Expected: FAIL until all operation routing/lifecycle behavior is correct against real rslib.

- [ ] **Step 3: Make only bridge fixes required by the contract test**

Do not change Dart/UI behavior to make this test pass. Fix descriptor mapping, ABI routing, or backend initialization only where the contract proves the native integration is wrong.

- [ ] **Step 4: Verify Rust GREEN and full native suite**

```bash
cargo test --test backend_contract -- --nocapture
cargo test
cargo clippy --all-targets -- -D warnings
```

- [ ] **Step 5: Write the Flutter end-to-end smoke test before its runner**

`real_backend_deck_list_test.dart` launches the app with a temporary collection path injected by a test-only app constructor, waits for the real native response, and asserts that the default deck appears and can be opened into the overview page. The test must not stub `DeckRepository` or `AnkiBackendClient`.

Run once before adding the runner/native-library placement and verify it fails because the real dynamic library is not discoverable.

- [ ] **Step 6: Add a reproducible native build/test runner**

`tool/run_desktop_dev.py`:

```text
cargo build --manifest-path native/anki_bridge/Cargo.toml
locate target/debug/libanki_flutter_bridge.so|dylib|anki_flutter_bridge.dll
run flutter from app/ with --dart-define=ANKIFLUTTER_NATIVE_LIB=<absolute library path>
```

For integration tests, the same helper exposes a `--test` mode that executes `flutter test integration_test/real_backend_deck_list_test.dart` with the dart define.

- [ ] **Step 7: Verify end-to-end GREEN**

```bash
python3 tool/run_desktop_dev.py --test
```

Expected: Flutter talks through the real C ABI to the pinned Anki backend, opens a temporary real collection, displays the default deck, and navigates to its overview.

- [ ] **Step 8: Commit**

```bash
git add native/anki_bridge app/integration_test tool/run_desktop_dev.py
git commit -m "test: verify real Anki backend deck flow"
```

---

### Task 12: Add CI quality gates and verify the complete vertical slice

**Files:**
- Create: `.github/workflows/ci.yml`
- Modify: `README.md`

**Interfaces:**
- Consumes: every task above.
- Produces: reproducible quality gates for generated code, Dart/Flutter tests, Rust tests/lints, native contract, and Linux desktop build.

- [ ] **Step 1: Create CI configuration**

Use Ubuntu and pin Flutter exactly:

```yaml
- uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.47.5'
    channel: stable
    cache: true
```

Install Linux Flutter desktop dependencies, Rust stable (minimum compatible with Anki is 1.80), `protobuf-compiler`, and `protoc_plugin 25.1.0`. Initialize submodules recursively before builds.

The workflow must run, in this order:

```bash
python3 tool/verify_generated_protos.py
cd native/anki_bridge && cargo fmt --check
cd native/anki_bridge && cargo clippy --all-targets -- -D warnings
cd native/anki_bridge && cargo test
cd app && flutter pub get
cd app && flutter analyze
cd app && flutter test
cd app && flutter build linux
python3 tool/run_desktop_dev.py --test
```

- [ ] **Step 2: Add README developer instructions**

Document exact commands for:

```bash
git clone --recurse-submodules <repository>
flutter --version                     # 3.47.5
rustc --version                       # >= 1.80
dart pub global activate protoc_plugin 25.1.0
python3 tool/generate_dart_protos.py
cd native/anki_bridge && cargo test
python3 tool/run_desktop_dev.py
```

Explain that the current milestone is deck browsing only and the Study button intentionally does not start a reviewer yet.

- [ ] **Step 3: Run the complete verification locally**

Run every CI command above from a clean checkout with initialized submodules. Record any failing command by exact name; do not declare the milestone complete while a required gate is red.

- [ ] **Step 4: Manual smoke-check without changing behavior**

Open one disposable/test `.anki2` collection and verify:

```text
app starts
collection chooser accepts the file
real hierarchy appears
New/Learn/Review counts appear
nested decks are indented
clicking a deck opens overview
back returns without reopening collection
closing app releases backend cleanly
```

No user production collection is used for this check.

- [ ] **Step 5: Commit**

```bash
git add .github/workflows/ci.yml README.md
git commit -m "ci: gate first AnkiFlutter desktop slice"
```

---

## Completion Criteria

The plan is complete only when all of the following are true:

```text
[ ] upstream Anki submodule is exactly a5a0e444677a6b58cf784a9c2b7c2d5167f20df0
[ ] no handwritten upstream service/method numeric indices exist
[ ] all handwritten behavior was introduced by an observed failing test
[ ] Rust bridge invokes official Anki backend instead of duplicating business logic
[ ] Dart widgets depend only on domain/repository/controller types
[ ] real temporary collection opens and reopens through the bridge
[ ] real DeckTree protobuf is mapped recursively without frontend count recomputation
[ ] Material 3 deck page displays real New/Learn/Review counts
[ ] deck overview navigation works
[ ] malformed native/backend/collection errors are actionable and do not crash process
[ ] every native buffer is freed exactly once
[ ] flutter test passes
[ ] flutter analyze passes
[ ] cargo test passes
[ ] cargo clippy --all-targets -- -D warnings passes
[ ] generated protobuf verification passes
[ ] flutter build linux passes
[ ] real-backend Flutter integration test passes
[ ] CI is green
```

The next plan begins the reviewer (`GetQueuedCards`, rendered question/answer, Again/Hard/Good/Easy, undo/bury/suspend) only after every item above is green.