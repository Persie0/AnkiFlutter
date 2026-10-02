# Release builds

AnkiFlutter keeps signing credentials out of the repository. The app version is sourced from `app/pubspec.yaml`; update it before producing a release.

## Common preparation

From the repository root:

```bash
git submodule update --init --recursive
python3 tool/prepare_bridge_lock.py
cd app
flutter pub get --enforce-lockfile
```

Run the quality gates before packaging:

```bash
flutter analyze
flutter test
```

## Android

Android release builds require a private upload/release keystore. `android/key.properties`, `*.jks`, and `*.keystore` are ignored by git.

Either create `app/android/key.properties`:

```properties
storeFile=/absolute/path/to/ankiflutter-upload.jks
storePassword=...
keyAlias=...
keyPassword=...
```

or provide the equivalent environment variables:

```bash
export ANKIFLUTTER_KEYSTORE_PATH=/absolute/path/to/ankiflutter-upload.jks
export ANKIFLUTTER_KEYSTORE_PASSWORD=...
export ANKIFLUTTER_KEY_ALIAS=...
export ANKIFLUTTER_KEY_PASSWORD=...
```

Then build the Play Store bundle:

```bash
flutter build appbundle --release
```

The build fails instead of silently signing a release with the debug key when signing credentials are missing.

## iOS

The bundle identifier is `dev.persie0.ankiFlutter`. Configure the matching App ID, distribution certificate, and provisioning profile in Xcode/App Store Connect, then build/archive from macOS:

```bash
flutter build ipa --release
```

For CI or manual signing, pass the normal Xcode signing settings for the registered App ID. No Apple signing credentials are stored in this repository.

## macOS

Build the release app:

```bash
flutter build macos --release
```

The native Anki bridge must be present in `AnkiFlutter.app/Contents/Frameworks/libanki_flutter_bridge.dylib`. Sign/notarize the completed bundle with the intended Developer ID before distribution outside local development.

## Windows

Build the release bundle:

```powershell
flutter build windows --release
```

Ensure `anki_flutter_bridge.dll` is copied beside `AnkiFlutter.exe` in the release bundle before packaging/signing the directory or installer.

## Linux

Build the release bundle:

```bash
flutter build linux --release
```

Ensure `libanki_flutter_bridge.so` is copied into the generated release bundle beside the executable. Package the complete Flutter bundle rather than the intermediate executable.

## Release verification

Before publishing a platform artifact, verify:

- the app displays `AnkiFlutter` as its product/window name;
- the expected application/bundle identifier is used;
- the native Anki bridge is bundled for the target architecture;
- a real disposable collection can be opened and studied;
- import/export and file pickers work on the target OS;
- the artifact is signed with release credentials where the platform requires signing.
