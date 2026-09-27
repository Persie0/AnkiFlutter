# AnkiFlutter Reviewer Parity Design

Date: 2026-09-26
Status: Approved in chat; pending written-spec review

## 1. Goal

Build the next AnkiFlutter milestone as a near-behavioral port of the official Anki Desktop Reviewer. Flutter remains the application shell; official Anki `rslib` remains authoritative for queueing, rendering, scheduling/FSRS, answering, undo, bury/suspend, and TTS support.

This is not a redesign of studying. The target is: **official Anki Reviewer behavior inside the Flutter desktop shell**, using one shared Flutter/Dart implementation on Windows, macOS, and Linux.

## 2. Upstream reference

Use the already-pinned official Anki revision:

- commit `a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`;
- `qt/aqt/reviewer.py` as the behavioral reference;
- official reviewer HTML/CSS/JS assets at that revision as the web-layer reference;
- `proto/anki/scheduler.proto` for queueing/answering;
- `proto/anki/card_rendering.proto` for rendering, AV extraction, and TTS;
- `proto/anki/collection.proto` for undo;
- `proto/anki/decks.proto` for selected/current deck behavior.

When official Anki behavior is PyQt-specific, reproduce the visible behavior rather than the PyQt mechanism. When `rslib` already owns a rule, call it rather than reimplementing it in Dart.

## 3. Milestone success criteria

A user can:

1. select a real deck and start review;
2. receive the real next card from Anki's scheduler;
3. view the real card template HTML/CSS/JS;
4. load collection media referenced by the template;
5. use question/answer audio and TTS, including autoplay and replay;
6. reveal the answer with the same core controls as Anki;
7. see Again / Hard / Good / Easy and their real next-state interval text;
8. submit a rating to the official scheduler and immediately receive the next card;
9. undo a review;
10. bury or suspend the current card or note;
11. use the main official Reviewer keyboard shortcuts;
12. use official-style auto-advance/wait-for-audio behavior;
13. finish a queue and return cleanly to deck overview/congratulations;
14. get equivalent Reviewer behavior on Windows, macOS, and Linux from one Dart codebase.

## 4. Explicit non-goals

This milestone does not add arbitrary Python/PyQt add-ons, Python reviewer hooks, custom add-on field filters, note-editor parity, browser parity, template editing, mobile support, or unrelated Reviewer actions whose owning feature does not yet exist.

Examples intentionally deferred until their feature modules exist: edit current note, full card-info dialogs, record-your-own-voice workflow, delete note, forget card, set due date, copy card, and full deck-options UI.

## 5. Architecture

```text
DeckOverview
    |
    | Study
    v
ReviewController
    |
    +--> StudyRepository
    |      +--> SetCurrentDeck
    |      +--> GetQueuedCards
    |      +--> DescribeNextStates
    |      +--> StateIsLeech
    |      +--> AnswerCard
    |      +--> BuryOrSuspendCards
    |      +--> GetUndoStatus / Undo
    |
    +--> CardRenderRepository
    |      +--> RenderExistingCard
    |      +--> ExtractAvTags
    |      +--> AllTtsVoices / WriteTtsStream
    |
    +--> ReviewAudioService
    +--> ReviewMediaServer
    v
CardSurface
    v
webview_cef / Chromium
    +-- ported official reviewer HTML/CSS/JS
    +-- rendered Anki question/answer HTML
    +-- media served from collection.media

Flutter repositories
    -> existing BackendInvoker
    -> FFI
    -> anki_bridge
    -> official rslib
```

Generated protobuf types remain behind repositories/mappers and never become widget state.

## 6. One-codebase renderer decision

Use `webview_cef` **0.6.2** as the desktop card surface implementation for this milestone. It provides one Flutter API backed by the same CEF/Chromium engine on Windows, macOS, and Linux and supports JS<->Dart bridging and injected scripts.

The project must pin the dependency version in `pubspec.lock`; do not float to arbitrary plugin releases.

Known platform consequences accepted by this design:

- Windows minimum: Windows 10;
- macOS minimum: macOS 12;
- Linux uses the plugin's software rendering path while Windows/macOS can use GPU texture paths;
- native runner/bootstrap changes required by CEF are allowed;
- C++20-capable native toolchains are required.

Those platform hooks must contain no Reviewer business logic.

Wrap the plugin behind a small project-owned `CardSurface` interface. `ReviewController`, scheduler logic, audio orchestration, and tests must not depend directly on `webview_cef`, so the renderer can be replaced later without redesigning Review state.

## 7. Reviewer state machine

Mirror the meaningful official Reviewer states:

```text
loading
  -> question
  -> answer
  -> transition
  -> question

or

  -> finished
  -> recoverable error
```

Behavior:

- fetching a card enters `question` only after the card and render data are ready;
- revealing enters `answer`;
- answering enters `transition` before the backend call;
- rating input is ignored unless on `answer`;
- the UI does not optimistically advance before `AnswerCard` succeeds;
- successful answer fetches the next card;
- an empty queue ends the Reviewer and returns to overview;
- stale async work from an older card/session is ignored.

## 8. Scheduler integration

Do not calculate scheduling or FSRS results in Dart.

`GetQueuedCards` provides the current card, queue type, counts, scheduling context, current state, and candidate Again/Hard/Good/Easy states. Preserve the card's `custom_data` on the current state exactly as official Anki does.

Displayed answer intervals come from upstream scheduling-state descriptions, not frontend interval math.

When answering:

1. map key/button 1/2/3/4 to Again/Hard/Good/Easy;
2. select the corresponding scheduler-provided new state;
3. send card id, current state, new state, rating, wall-clock `answered_at_millis`, and monotonic elapsed `milliseconds_taken`;
4. call `AnswerCard`;
5. advance only after success;
6. use upstream leech/state checks for post-answer feedback rather than duplicating leech rules.

## 9. Card rendering and official web content

Use official Anki card rendering APIs. For existing review cards call `RenderExistingCard` with `browser=false` and full rendering (`partial_render=false`) because arbitrary Python add-on filters are not supported in this milestone.

The backend owns built-in template parsing, cloze behavior, special fields, built-in filters, `FrontSide`, and CSS extraction. Flutter must not duplicate those rules.

Port/reuse the official Reviewer DOM/CSS/JS where practical and license-compatible, including question/answer switching and card-side classes. Replace Qt bridge calls with explicit typed messages over the Flutter/CEF JS bridge.

Flutter owns application chrome, navigation, focus/shortcut routing, dialogs, and controls outside the card document.

Unknown Python add-on filters may be skipped according to upstream full-render behavior; they must never crash the review session.

## 10. Collection media serving

Serve relative card media through a project-owned loopback server so the same URL behavior works on all three operating systems.

Requirements:

- bind only to `127.0.0.1`;
- choose an ephemeral port;
- use an unguessable per-session path token;
- expose only the current collection's media root;
- support only GET/HEAD;
- reject `..`, encoded traversal, absolute paths, symlink escapes, and any resolved path outside the media root;
- return sensible MIME types;
- stop when the collection closes.

The Reviewer document receives this URL as its media/base URL so relative images, CSS resources, audio, and video resolve consistently.

## 11. Audio and TTS

Audio/TTS is part of this milestone.

Use upstream `ExtractAvTags`; do not independently parse Anki sound/TTS syntax in Dart when the backend can provide the structured tags.

`ReviewAudioService` must preserve official-style behavior:

- question-side audio on question;
- answer-side audio on answer;
- replay question audio on answer when the card/deck setting requires it;
- autoplay only when configured;
- queue multiple tags in order;
- `r`/F5 replay;
- `5` pause/resume;
- `6` seek back 5 seconds;
- `7` seek forward 5 seconds when the playback backend supports seeking.

For TTS:

- obtain voices through `AllTtsVoices`;
- generate streams with `WriteTtsStream`;
- write only to app-owned temporary/cache locations;
- play generated streams through the same audio queue;
- safely delete temporary files;
- report unavailable voices without crashing the Reviewer.

The implementation plan must choose one cross-platform Dart audio backend that supports the required desktop targets; audio playback remains behind `ReviewAudioService` so package choice does not leak into Reviewer state.

## 12. Keyboard and controls

Required official-style shortcuts:

- Space / Return / Enter: show answer; on answer side rate according to configured/default selection behavior;
- `1` `2` `3` `4`: Again / Hard / Good / Easy on answer side;
- `r` and F5: replay audio;
- `u`: undo;
- `-`: bury card;
- `=`: bury note;
- `@`: suspend card;
- `!`: suspend note;
- `5`: pause/resume audio;
- `6`: seek backward;
- `7`: seek forward;
- Shift+A: toggle auto-advance.

All keyboard commands and visible controls call the same controller commands. Platform-reserved shortcuts may receive a documented platform alternative, but the core answer/reveal shortcuts must remain identical wherever possible.

Question side shows the card and official-style Show Answer affordance. Answer side shows Again / Hard / Good / Easy with upstream interval descriptions. Rating controls are disabled while transitioning.

The outer Flutter chrome may use Material 3, but the reviewing workflow must remain recognizably Anki rather than introducing a different study interaction.

## 13. Auto-advance and focus behavior

Mirror official Reviewer auto-advance semantics where the pinned backend/deck configuration exposes the needed values:

- seconds to show question;
- seconds to show answer;
- wait-for-audio;
- question timeout action;
- answer timeout action.

Do not auto-act while the Reviewer window is unfocused if official Anki would stop/disable auto-advance in that condition.

Leaving Reviewer cancels timers.

## 14. Undo, bury, and suspend

Undo uses official collection undo APIs only. The UI exposes undo when upstream undo status permits it, invokes `Undo`, then refreshes current card/queue state. It never reconstructs prior scheduling state locally.

Use `BuryOrSuspendCards` for:

- bury current card;
- bury current note;
- suspend current card;
- suspend current note.

On success, refresh/advance exactly as appropriate for a card removed from the active study queue. Do not mutate the frontend queue as a substitute for the backend result.

## 15. End-of-queue behavior

When no queued card remains:

- stop audio and Reviewer timers;
- clear stale card content;
- leave Reviewer cleanly;
- return to the selected deck overview/congratulations state;
- refresh real deck counts from the backend.

## 16. Error and lifecycle rules

Distinguish queue, render, media, TTS, answer, undo, bury/suspend, renderer-init, and backend/collection-session failures.

A failed answer must leave the current card recoverable and must not advance. Missing individual media should not terminate reviewing. Unexpected errors retain diagnostic details for logs while user-facing text stays concise.

Entering Reviewer creates a session identity. Leaving Reviewer:

- cancels timers;
- stops/clears audio;
- invalidates pending async completions;
- detaches browser bridge callbacks;
- disposes the card surface as needed;
- leaves the collection open.

Closing the collection additionally stops the media server and invalidates the Reviewer session.

## 17. State ownership

`ReviewController` owns immutable Reviewer state and commands. Widgets are presentation-only.

Stable project-owned domain objects should cover concepts such as:

```text
ReviewSessionState
ReviewCard
ReviewCardContent
ReviewCounts
ReviewAnswerChoice
ReviewRating
ReviewAudioTag
ReviewTtsTag
```

Repositories/services are constructor-injected so controller and widget tests do not require native code, CEF, or real audio.

## 18. Strict TDD

The existing repository rule remains absolute for handwritten behavior: focused failing test first, observe the intended RED, minimal implementation, focused GREEN, relevant/full suite, refactor only while green.

At minimum test-drive:

- queued-card mapping and counts;
- `custom_data` handling;
- question entry and answer reveal;
- answer-choice/rating mapping;
- real interval-description mapping;
- answer timing;
- no advance before answer success;
- success/failure transitions;
- end-of-queue behavior;
- keyboard command routing;
- AV mapping and autoplay order;
- replay/pause/seek routing;
- answer-side question-audio replay;
- TTS orchestration/error handling;
- auto-advance and wait-for-audio;
- undo refresh;
- bury/suspend;
- stale-response rejection;
- loopback media traversal protection;
- collection-close cleanup;
- CardSurface bridge messages and teardown;
- renderer failure state.

Generated protobuf output and unavoidable native CEF bootstrap/configuration are exempt from Red-first behavior, but must be covered by drift/build/smoke checks.

## 19. Real-backend contract and integration tests

Rust/native contract coverage must prove, against disposable real collections:

- select current deck;
- queue a known card;
- get scheduling-state descriptions;
- render the existing card;
- extract AV tags;
- answer the card and observe scheduling change;
- undo and observe restoration;
- bury/suspend and observe queue impact;
- enumerate/generate TTS where the CI host supports the native voice API.

Flutter E2E critical path:

```text
open disposable collection
-> select seeded deck
-> start review
-> render seeded question
-> load seeded media
-> reveal answer
-> show real Again/Hard/Good/Easy intervals
-> submit rating
-> verify changed queue/next card
-> undo
-> verify queue restoration
```

CI must retain the Linux real-backend integration path and add Windows/macOS build/smoke coverage for the CEF Reviewer before those platforms are considered Reviewer-complete.

## 20. Licensing and upstream compatibility

Keep the existing exact Anki submodule pin for this milestone. Do not depend on floating Anki assets/APIs.

Copied/ported Anki Reviewer assets must retain required copyright/license notices and comply with the repository's AGPL obligations. `webview_cef` remains a separately licensed dependency and its notices must be retained as required.

Any future Anki submodule bump must pass Reviewer contract/integration tests before adoption.

## 21. Acceptance checklist

- [ ] real Anki queue is used;
- [ ] real Anki card rendering is used;
- [ ] official Reviewer web behavior/assets are ported where applicable;
- [ ] `webview_cef` 0.6.2 provides one Chromium card surface on Windows/macOS/Linux;
- [ ] relative collection media loads safely;
- [ ] question/answer audio works;
- [ ] TTS works through official backend support where available;
- [ ] Again/Hard/Good/Easy use real scheduler states;
- [ ] interval labels come from upstream;
- [ ] answer timing is sent correctly;
- [ ] core official shortcuts work;
- [ ] undo uses upstream;
- [ ] bury/suspend uses upstream;
- [ ] auto-advance/wait-for-audio is supported;
- [ ] queue completion returns cleanly to overview;
- [ ] no scheduler/FSRS/template reimplementation exists in Dart;
- [ ] one shared Reviewer implementation is used across all three desktop targets;
- [ ] handwritten behavior was introduced strict Red-first;
- [ ] real-backend integration passes;
- [ ] copied upstream license notices are preserved.

## 22. Final design decision

AnkiFlutter's Reviewer will be a Flutter-hosted port of official Anki Desktop Reviewer behavior, not a new study experience.

Flutter owns the app shell and typed project boundaries. `webview_cef` 0.6.2 provides the common Chromium card surface for Windows, macOS, and Linux. Official Anki `rslib` remains authoritative for card queueing, rendering, scheduling/FSRS, answering, undo, bury/suspend, AV extraction, and TTS support. Official Reviewer web assets and interaction patterns are reused/ported where practical and license-compatible.
