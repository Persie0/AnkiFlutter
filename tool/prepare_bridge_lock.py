#!/usr/bin/env python3
from pathlib import Path
import subprocess
import shutil

ROOT = Path(__file__).resolve().parents[1]
UPSTREAM_LOCK = ROOT / "third_party" / "anki" / "Cargo.lock"
BRIDGE_DIR = ROOT / "native" / "anki_bridge"
BRIDGE_LOCK = BRIDGE_DIR / "Cargo.lock"
IOS_BRIDGE_DIR = ROOT / "native" / "anki_bridge_ios"

if not UPSTREAM_LOCK.is_file():
    raise SystemExit("pinned Anki Cargo.lock not found; initialize third_party/anki")

BRIDGE_DIR.mkdir(parents=True, exist_ok=True)
if not BRIDGE_LOCK.is_file():
    shutil.copyfile(UPSTREAM_LOCK, BRIDGE_LOCK)
    subprocess.run(
        ["cargo", "generate-lockfile", "--manifest-path", str(BRIDGE_DIR / "Cargo.toml")],
        cwd=ROOT,
        check=True,
    )

IOS_BRIDGE_LOCK = IOS_BRIDGE_DIR / "Cargo.lock"
if not IOS_BRIDGE_LOCK.is_file():
    subprocess.run(
        [
            "cargo",
            "generate-lockfile",
            "--manifest-path",
            str(IOS_BRIDGE_DIR / "Cargo.toml"),
        ],
        cwd=ROOT,
        check=True,
    )
print("Generated bridge lockfiles with the pinned Anki sources and bridge dependencies")
