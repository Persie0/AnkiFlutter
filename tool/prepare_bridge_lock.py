#!/usr/bin/env python3
from pathlib import Path
import shutil

ROOT = Path(__file__).resolve().parents[1]
UPSTREAM_LOCK = ROOT / "third_party" / "anki" / "Cargo.lock"
BRIDGE_LOCK = ROOT / "native" / "anki_bridge" / "Cargo.lock"

if not UPSTREAM_LOCK.is_file():
    raise SystemExit("pinned Anki Cargo.lock not found; initialize third_party/anki")

BRIDGE_LOCK.parent.mkdir(parents=True, exist_ok=True)
shutil.copyfile(UPSTREAM_LOCK, BRIDGE_LOCK)
print(f"Seeded {BRIDGE_LOCK.relative_to(ROOT)} from pinned Anki Cargo.lock")
