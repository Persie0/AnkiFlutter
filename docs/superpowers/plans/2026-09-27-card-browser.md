# Implementation Plan: Shared Anki Card Browser

1. Extend descriptor-derived Rust operation mapping for SearchCards, BrowserRowForId, SetActiveBrowserColumns, and GetConfigJson; add operation ID regression checks.
2. Add Dart operation IDs and repository/model with contract tests for native protobuf requests and row mapping.
3. Add the shared search screen with widget tests for loading, success, empty, error/retry, and result-limit states.
4. Expose the browser from the open-collection deck screen; test navigation.
5. Run Dart format/analyze/tests, Rust format/tests, verify generated protobufs, push the changes, and inspect every CI platform lane.
