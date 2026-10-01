import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).resolve().parents[1] / "prepare_bridge_lock.py"


class PrepareBridgeLockTest(unittest.TestCase):
    def test_generates_separate_online_lockfiles_for_each_crate(self):
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = Path(temporary_directory)
            (root / "tool").mkdir()
            shutil.copyfile(SCRIPT, root / "tool" / "prepare_bridge_lock.py")
            upstream_lock = root / "third_party" / "anki" / "Cargo.lock"
            upstream_lock.parent.mkdir(parents=True)
            upstream_lock.write_text("pinned anki lock")

            for crate in ("anki_bridge", "anki_bridge_ios"):
                crate_dir = root / "native" / crate
                crate_dir.mkdir(parents=True)
                (crate_dir / "Cargo.toml").write_text("[package]\n")

            fake_bin = root / "bin"
            fake_bin.mkdir()
            fake_cargo = fake_bin / "cargo"
            fake_cargo.write_text(
                "#!/usr/bin/env python3\n"
                "import pathlib, sys\n"
                "args = sys.argv[1:]\n"
                "with open('cargo-commands.txt', 'a') as commands:\n"
                "    commands.write(' '.join(args) + '\\n')\n"
                "manifest = pathlib.Path(args[args.index('--manifest-path') + 1])\n"
                "(manifest.parent / 'Cargo.lock').write_text('lock for ' + manifest.parent.name)\n"
            )
            fake_cargo.chmod(0o755)

            environment = os.environ.copy()
            environment["PATH"] = f"{fake_bin}{os.pathsep}{environment['PATH']}"
            command = ["python3", str(root / "tool" / "prepare_bridge_lock.py")]
            subprocess.run(
                command,
                cwd=root,
                env=environment,
                check=True,
                capture_output=True,
                text=True,
            )
            subprocess.run(
                command,
                cwd=root,
                env=environment,
                check=True,
                capture_output=True,
                text=True,
            )

            bridge_lock = (root / "native" / "anki_bridge" / "Cargo.lock").read_text()
            ios_lock = (root / "native" / "anki_bridge_ios" / "Cargo.lock").read_text()
            commands = (root / "cargo-commands.txt").read_text()

            self.assertEqual(bridge_lock, "lock for anki_bridge")
            self.assertEqual(ios_lock, "lock for anki_bridge_ios")
            self.assertNotIn("--offline", commands)
            self.assertEqual(len(commands.splitlines()), 2)


if __name__ == "__main__":
    unittest.main()
