#!/usr/bin/env python3
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
subprocess.run([sys.executable, str(ROOT / "tool" / "generate_dart_protos.py")], check=True)
result = subprocess.run([
    "git", "diff", "--exit-code", "--",
    "app/lib/core/backend/generated",
], cwd=ROOT)
raise SystemExit(result.returncode)
