#!/usr/bin/env python3
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
if not files:
    raise SystemExit("no Anki proto files found; initialize third_party/anki")
subprocess.run([
    "protoc",
    f"--proto_path={PROTO_ROOT}",
    f"--dart_out={OUT}",
    *map(str, files),
], check=True)
