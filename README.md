# AnkiFlutter

AnkiFlutter is an independent, open-source Flutter frontend for Anki. The project reuses the official Anki Rust backend (`rslib`) instead of reimplementing Anki scheduling, FSRS, collection storage, search, sync, or import/export behavior.

This project is not affiliated with or endorsed by Ankitects Pty Ltd.

## Current milestone

The first desktop vertical slice supports opening a local `.anki2` collection through the official Anki backend, loading the real hierarchical deck tree with Anki's New/Learn/Review counts, opening a deck overview, and returning to the still-loaded deck list.

The reviewer is the next vertical slice. Card queueing, question/answer rendering, grading, undo, bury, and suspend are intentionally not part of this milestone yet.

## Toolchain

The repository and CI pin the development toolchain used for this slice:

- Flutter 3.47.5 / Dart 3.13.4
- Rust 1.88.0
- `protoc_plugin` 25.1.0
- the Anki git submodule revision recorded in `third_party/anki`

Linux desktop development also requires the normal Flutter Linux toolchain (`clang`, CMake, Ninja, pkg-config, GTK 3 development headers) plus `protobuf-compiler`.

## Development setup

Clone with the pinned Anki submodules:

```bash
git clone --recurse-submodules https://github.com/Persie0/AnkiFlutter.git
cd AnkiFlutter
```

Install the pinned Dart protobuf generator and generate bindings from the pinned Anki sources:

```bash
dart pub global activate protoc_plugin 25.1.0
export PATH="$PATH:$HOME/.pub-cache/bin"
python3 tool/generate_dart_protos.py
```

Run the native bridge tests:

```bash
python3 tool/prepare_bridge_lock.py
cargo test --manifest-path native/anki_bridge/Cargo.toml
```

Launch the desktop app with the native bridge built and injected automatically:

```bash
python3 tool/run_desktop_dev.py
```

Run the real Flutter/native integration test against a disposable Anki collection:

```bash
python3 tool/run_desktop_dev.py --test
```

The runner builds `anki_flutter_bridge`, resolves the platform-specific dynamic library to an absolute path, and passes it to Flutter with `ANKIFLUTTER_NATIVE_LIB`.

## Quality gates

CI runs the same milestone checks from a clean checkout. The core commands are:

```bash
python3 tool/verify_generated_protos.py
cargo fmt --manifest-path native/anki_bridge/Cargo.toml --check
cargo clippy --manifest-path native/anki_bridge/Cargo.toml --all-targets -- -D warnings
cargo test --manifest-path native/anki_bridge/Cargo.toml
cd app
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter build linux
cd ..
python3 tool/run_desktop_dev.py --test
```

The Linux CI build also creates the release Rust bridge and copies `libanki_flutter_bridge.so` beside the Flutter executable, matching the app's default native-library lookup path.

## Native backend troubleshooting

If the app shows **Anki backend unavailable**, first run it through `python3 tool/run_desktop_dev.py`; that is the supported development path and supplies the exact built library automatically.

For a manually built desktop bundle, the bridge must be beside the executable using the platform filename expected by the loader:

- Linux: `libanki_flutter_bridge.so`
- macOS: `libanki_flutter_bridge.dylib`
- Windows: `anki_flutter_bridge.dll`

For test or development overrides, pass an absolute path with:

```bash
--dart-define=ANKIFLUTTER_NATIVE_LIB=/absolute/path/to/native/library
```

If protobuf verification fails, regenerate with `python3 tool/generate_dart_protos.py` using `protoc_plugin` 25.1.0 and commit the resulting generated files only when the pinned upstream proto inputs intentionally changed.

## Development process

The project follows strict test-driven development: handwritten behavior starts with a failing test, receives the smallest implementation needed to make that test pass, and is then refactored while green.

See `docs/superpowers/specs/2026-09-24-anki-flutter-frontend-design.md` and `docs/superpowers/plans/2026-09-24-first-desktop-vertical-slice.md` for the approved architecture and implementation plan.

## License

AGPL-3.0-or-later. Upstream Anki code retains its original copyright and license notices.
