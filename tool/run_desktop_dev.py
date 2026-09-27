#!/usr/bin/env python3
"""Build the native Anki bridge and run the Flutter desktop app or integration test."""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP_DIR = ROOT / "app"
BRIDGE_MANIFEST = ROOT / "native" / "anki_bridge" / "Cargo.toml"
BRIDGE_TARGET = ROOT / "native" / "anki_bridge" / "target" / "debug"
INTEGRATION_TEST = "integration_test/real_backend_deck_list_test.dart"
DART_DEFINE = "ANKIFLUTTER_NATIVE_LIB"


def _platform_config() -> tuple[str, str]:
    if sys.platform.startswith("linux"):
        return "linux", "libanki_flutter_bridge.so"
    if sys.platform == "darwin":
        return "macos", "libanki_flutter_bridge.dylib"
    if sys.platform == "win32":
        return "windows", "anki_flutter_bridge.dll"
    raise SystemExit(f"Unsupported desktop platform: {sys.platform}")


def _run(command: list[str], *, cwd: Path = ROOT) -> None:
    print("+", " ".join(command), flush=True)
    subprocess.run(command, cwd=cwd, check=True)


def _build_bridge(library_name: str) -> Path:
    _run([sys.executable, str(ROOT / "tool" / "prepare_bridge_lock.py")])
    _run(["cargo", "build", "--manifest-path", str(BRIDGE_MANIFEST)])

    library_path = (BRIDGE_TARGET / library_name).resolve()
    if not library_path.is_file():
        raise SystemExit(
            "Anki bridge build completed but the expected native library was not "
            f"found at {library_path}"
        )
    return library_path


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Build the Anki bridge and run AnkiFlutter desktop.",
    )
    parser.add_argument(
        "--test",
        action="store_true",
        help="Run the real-backend desktop integration test instead of the app.",
    )
    args = parser.parse_args()

    device, library_name = _platform_config()
    library_path = _build_bridge(library_name)
    dart_define = f"--dart-define={DART_DEFINE}={library_path}"

    if args.test:
        command = [
            "flutter",
            "test",
            INTEGRATION_TEST,
            "-d",
            device,
            "-r",
            "github",
            dart_define,
        ]
    else:
        command = ["flutter", "run", "-d", device, dart_define]

    _run(command, cwd=APP_DIR)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
