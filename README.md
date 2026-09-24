# AnkiFlutter

AnkiFlutter is an independent, open-source Flutter frontend for Anki. The project aims to reuse the official Anki Rust backend (`rslib`) instead of reimplementing Anki scheduling, FSRS, collection storage, search, sync, or import/export behavior.

This project is not affiliated with or endorsed by Ankitects Pty Ltd.

## Development

The project follows strict test-driven development: handwritten behavior starts with a failing test, then receives the smallest implementation needed to make the test pass, followed by refactoring while green.

See `docs/superpowers/specs/2026-09-24-anki-flutter-frontend-design.md` and `docs/superpowers/plans/2026-09-24-first-desktop-vertical-slice.md`.

## License

AGPL-3.0-or-later. Upstream Anki code retains its original copyright and license notices.
