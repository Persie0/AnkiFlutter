# AnkiFlutter Reviewer Parity Design

Date: 2026-09-26
Status: Approved in chat; pending written-spec review

## 1. Purpose

Build the next AnkiFlutter milestone as a near-behavioral port of the official Anki Desktop Reviewer, while keeping Flutter as the application shell and the official Anki Rust backend (`rslib`) as the source of truth for scheduling and card data.

The goal is not to redesign studying. The goal is to make AnkiFlutter capable of real day-to-day reviewing with behavior that closely matches the pinned official Anki Desktop implementation.

The Reviewer must use one shared Flutter/Dart implementation across Windows, macOS, and Linux. Small platform runner/bootstrap code is acceptable where required by an embedded browser engine, but there must not be three separate reviewer implementations.

## 2. Reference implementation

The behavioral and UX reference is the official Anki Desktop code at the pinned upstream revision already used by AnkiFlutter:

- upstream commit: `a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`
- reviewer behavior: `qt/aqt/reviewer.py`
- reviewer browser content and scripts: official reviewer HTML/CSS/JS assets at the same revision
- scheduler service: `proto/anki/scheduler.proto`
- card rendering service: `proto/anki/card_rendering.proto`
- collection undo service: `proto/anki/collection.proto`
- deck selection service: `proto/anki/decks.proto`

Where the PyQt implementation contains UI-framework-specific code, AnkiFlutter should reproduce the user-visible behavior rather than copy PyQt mechanics.

Where official Anki already exposes the behavior through `rslib`, AnkiFlutter must call that backend instead of reimplementing it in Dart.

## 3. Success criteria

This milestone is complete when a user can:

1. open a real collection and choose a deck;
2. start studying that deck;
3. receive the real queued card from Anki's scheduler;
4. see the card rendered with its real Anki template HTML/CSS/JavaScript;
5. have embedded images and media resolve from the collection media folder;
6. hear autoplayed card audio and TTS according to Anki behavior;
7. replay, pause, and seek audio using Anki-compatible controls;
8. reveal the answer with Space/Enter or the UI;
9. see Again / Hard / Good / Easy with real next-state interval text from Anki;
10. rate the card with the UI or standard answer keys;
11. have the official backend persist the scheduling result;
12. immediately receive the next real card;
13. undo the previous review;
14. bury or suspend the current card/note;
15. use the primary official Reviewer keyboard shortcuts;
16. complete a queue and return to the deck overview/congratulations state;
17. get equivalent reviewer behavior on Windows, macOS, and Linux from the same Flutter codebase.

## 4. Non-goals

This milestone does not attempt to support:

- arbitrary Python/PyQt add-ons;
- arbitrary reviewer hook compatibility;
- Python custom field filters supplied by add-ons;
- full note editor parity;
- full browser parity;
- card-template editing;
- custom-study UI beyond what is necessary for normal reviewing;
- every obscure Reviewer context-menu action if it depends on a later feature module;
- mobile reviewer support.

The milestone should preserve extension points so later work can add missing actions without changing the core reviewer architecture.

## 5. High-level architecture

```text
Deck overview
   |
   | Study
   v
ReviewController
   |
   +--> StudyRepository
   |      +--> SetCurrentDeck
   |      +--> GetQueuedCards
   |      +--> DescribeNextStates
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
   |
   +--> ReviewMediaServer
   |
   v
CardSurface
   |
   v
embedded Chromium/CEF widget
   |
   +-- official-style reviewer HTML/CSS/JS
   +-- rendered Anki question/answer HTML
   +-- media URLs served from collection.media

All backend requests continue through:
Flutter repositories -> existing BackendInvoker -> FFI -> anki_bridge -> official rslib
```

Generated protobuf types remain behind repositories/adapters and do not leak into feature widgets.

## 6. One-codebase requirement

The Reviewer implementation is shared Dart code.

The same classes, controller, state model, repositories, card surface abstraction, keyboard command handling, audio orchestration, and tests are used on Windows, macOS, and Linux.

A browser/runtime package may require minimal platform-specific build/bootstrap configuration, but platform conditionals must not contain Reviewer business rules.

The preferred embedded browser strategy is one Chromium/CEF-based renderer on all three desktop platforms so card HTML/JS behavior stays as consistent as practical.

The browser implementation must sit behind a small `CardSurface` interface so it can be replaced without changing `ReviewController` or scheduler logic.

## 7. Official Anki behavior to port

The Flutter controller should mirror the meaningful state transitions in official `Reviewer` rather than inventing a new state model.

Core states:

```text
loading
  -> question
  -> answer
  -> transition
  -> question

or

  -> finished
  -> error
```

The official behavior to preserve includes:

- fetch next queued card;
- start the card timer when the card becomes current;
- show question;
- autoplay question audio when enabled;
- reveal answer;
- autoplay answer audio when enabled;
- expose four scheduler answer choices;
- ignore rating input while not on the answer side;
- transition while the answer operation is running;
- fetch/show the next card after a successful answer;
- update queue counts;
- return to overview when no card remains;
- replay the correct side's audio;
- support configured auto-advance behavior;
- wait for audio where Anki's setting requires it;
- preserve undo semantics through the official backend.

## 8. Scheduler integration

The Reviewer must not calculate scheduling or FSRS results in Dart.

For each queued card, use the official scheduler response from `GetQueuedCards`:

- current card;
- queue type;
- current scheduling state;
- Again state;
- Hard state;
- Good state;
- Easy state;
- scheduling context;
- queue counts.

Before answering, preserve Anki's required `custom_data` behavior by carrying the card custom data into the current scheduling state exactly as the official Reviewer does.

Answer interval labels must come from official backend scheduling-state description APIs, not frontend math.

When the user selects a rating:

1. map 1/2/3/4 to Again/Hard/Good/Easy;
2. select the corresponding scheduler-provided new state;
3. provide card id, current state, new state, rating, answer timestamp, and elapsed answer time;
4. call `AnswerCard`;
5. only advance after success.

If Anki reports that the resulting state is a leech/suspended state, surface the corresponding user feedback without reproducing leech rules in Dart.

## 9. Card rendering

Card templates must be rendered through official Anki rendering APIs.

For an existing review card, use `RenderExistingCard` with `browser=false` and full rendering enabled (`partial_render=false`) wherever possible.

The returned CSS and rendered card content become the document content shown in the embedded browser.

Anki's Rust renderer already owns built-in template logic, cloze handling, special fields, and standard filters. Flutter must not implement those template rules itself.

Unknown Python add-on field filters are not supported in this milestone. Their absence must not crash the reviewer.

The answer rendering must preserve `FrontSide` behavior and other official built-in rendering semantics supplied by the backend.

## 10. Reviewer web content

Reuse/port the official Anki Reviewer web content where practical and license-compatible:

- reviewer DOM structure;
- question/answer presentation behavior;
- reviewer CSS;
- reviewer JavaScript behavior;
- answer-button behavior where it belongs in the web layer;
- card-side switching behavior;
- body/card classes expected by common Anki templates.

Do not embed PyQt assumptions in the web content. Replace the Qt bridge with a small Flutter/CEF JavaScript bridge whose messages are explicit and typed on the Dart side.

Flutter remains responsible for application chrome, navigation, focus management, command routing, dialogs, and non-card controls.

## 11. Media serving

Anki card HTML frequently refers to media with relative paths. To keep one implementation across desktop platforms, expose collection media through a local loopback HTTP server owned by the current collection session.

Requirements:

- bind only to `127.0.0.1`;
- choose an ephemeral port;
- generate an unguessable per-session token in the URL path;
- expose only the active collection's media directory;
- reject `..`, encoded traversal, absolute paths, symlink escapes, and paths outside the media root;
- return correct MIME types where practical;
- support GET/HEAD only;
- shut down when the collection closes;
- never expose arbitrary local files.

The card document uses the media server URL as its base so `<img>`, CSS `url(...)`, `<audio>`, `<video>`, and other relative resources resolve consistently on all three desktop operating systems.

## 12. Audio and TTS

Audio/TTS is included in this milestone.

### 12.1 AV extraction

Use official Anki `ExtractAvTags` behavior to separate card display text from sound/TTS directives. Do not parse `[sound:...]` or TTS syntax independently in Dart if upstream can provide the parsed representation.

### 12.2 Media audio

Sound/video AV tags referencing collection media are resolved through the collection media root and played by `ReviewAudioService`.

Playback behavior should mirror official Anki:

- question audio on question side;
- answer audio on answer side;
- replay question audio on answer side when the card/deck setting requests it;
- autoplay only when configured;
- queue multiple AV tags in order;
- replay current side with `r` or F5;
- pause/resume with `5`;
- seek backward 5 seconds with `6`;
- seek forward 5 seconds with `7` where the active media backend supports seeking.

### 12.3 TTS

Use official backend TTS APIs where available:

- query voices through `AllTtsVoices`;
- ask upstream to generate audio through `WriteTtsStream`;
- store generated streams only in an application-owned temporary/cache directory;
- play the resulting file through the same `ReviewAudioService` queue;
- clean up temporary TTS files safely.

If a requested voice is unavailable, skip/fail that tag with user-visible diagnostic behavior comparable to Anki rather than crashing the review session.

## 13. Keyboard behavior

Primary official Reviewer shortcuts should be preserved unless the target OS reserves the key combination.

Required for this milestone:

- Space / Return / Enter: show answer; when configured, rate with selected/default answer on answer side;
- answer keys 1, 2, 3, 4: Again, Hard, Good, Easy on answer side;
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

Additional official shortcuts such as editor, options, flags, mark, card info, delete note, forget card, set due date, recording, and copy-card should only be enabled when the corresponding AnkiFlutter feature/action exists. Missing feature-module actions should not be implemented as Reviewer-specific hacks.

Keyboard commands must be routed centrally so both Flutter controls and shortcuts invoke the same controller methods.

## 14. Answer controls

Question side:

- large central card surface;
- official-style Show Answer control;
- visible queue counts consistent with Anki concepts;
- optional remaining-time/auto-advance indicators where enabled.

Answer side:

- Again / Hard / Good / Easy controls;
- interval text sourced from upstream scheduling states;
- rating controls disabled during transition/submission;
- visual focus/selection compatible with keyboard use.

The exact outer Flutter styling may use Material 3, but the card/reviewer interaction should remain recognizably Anki and should not change the established reviewing workflow.

## 15. Auto-advance and timers

Mirror official Reviewer auto-advance behavior using deck configuration exposed by the backend where practical:

- seconds to show question;
- seconds to show answer;
- wait-for-audio setting;
- question timeout action;
- answer timeout action;
- current auto-advance enabled state.

Do not trigger an auto action while the application/reviewer is not focused if official Anki would disable/pause the behavior in that situation.

Card answer timing sent to the backend must use a monotonic elapsed timer for duration and wall-clock milliseconds for `answered_at_millis`.

## 16. Undo

Undo must use official collection undo APIs.

The Reviewer should:

- expose undo only when upstream undo status allows it;
- call official `Undo`;
- refresh queue/current-card state after undo;
- not attempt to reverse scheduling locally;
- restore UI to a coherent state even when the undone operation came from another feature.

## 17. Bury and suspend

Use `BuryOrSuspendCards` for reviewer actions.

Required actions:

- bury current card;
- bury current note;
- suspend current card;
- suspend current note.

After success, advance/refresh the queue exactly as the official Reviewer does for an operation that removes the current card from active study.

No direct card queue mutation happens in Dart.

## 18. End-of-queue behavior

When `GetQueuedCards` returns no card:

- leave the Reviewer cleanly;
- stop reviewer audio/timers;
- show/return to the selected deck's overview/congratulations state;
- refresh deck counts from the backend.

Do not keep a stale rendered card visible after the backend queue is empty.

## 19. Error handling

Reviewer failures should be recoverable whenever possible.

Distinguish at least:

- queue fetch failure;
- card render failure;
- media-not-found error;
- TTS unavailable/error;
- answer submission failure;
- undo failure;
- bury/suspend failure;
- embedded renderer initialization failure;
- backend/collection session failure.

A failed answer submission must not optimistically advance to the next card.

A missing image/audio file should not terminate the review session.

Unexpected backend errors should preserve diagnostic details for logs while showing concise user-facing feedback.

## 20. Lifecycle and cancellation

Entering Reviewer starts a review session associated with the currently open collection and selected deck.

Leaving Reviewer must:

- cancel pending UI timers;
- stop/clear audio playback;
- invalidate pending async responses from the old card/session;
- detach browser bridge callbacks;
- dispose the embedded card surface when appropriate;
- leave the collection itself open so navigation back to deck overview remains fast.

Closing the collection must additionally stop the media server and invalidate any reviewer session.

Late async completions from an old card must never overwrite a newer card's state.

## 21. State ownership

`ReviewController` owns reviewer state and commands.

Widgets are presentation-only and receive immutable state plus callbacks.

Suggested stable domain objects:

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

Generated protobuf objects remain in repository/mapper code.

The controller must be constructor-injected with repositories/services so unit/widget tests can run without loading native code or Chromium.

## 22. Strict TDD requirements

The repository's existing TDD rule remains mandatory: no handwritten production behavior without first observing the focused test fail for the intended reason.

The implementation plan must decompose the Reviewer into small Red -> Green -> Refactor slices.

At minimum, test-drive:

- queue mapping;
- current-state `custom_data` handling;
- question-state entry;
- answer reveal;
- answer-choice mapping;
- elapsed answer timing;
- answer submission does not advance before success;
- successful answer advances;
- failed answer stays recoverable;
- end-of-queue behavior;
- queue counts;
- interval labels;
- keyboard routing;
- replay/pause/seek command routing;
- AV-tag mapping;
- autoplay sequencing;
- answer-side question-audio replay behavior;
- TTS generation/playback orchestration;
- auto-advance timing and wait-for-audio behavior;
- undo refresh behavior;
- bury/suspend behavior;
- stale async response rejection;
- media-server traversal protection;
- collection-close cleanup;
- card-surface bridge messages;
- renderer failure/error state.

Generated code and unavoidable native/browser bootstrap configuration remain exempt from Red-first handwritten behavior, but must be covered by contract/smoke checks.

## 23. Test layers

### Rust bridge contract tests

Use temporary real Anki collections to prove the pinned backend operations work through the bridge:

- set current deck;
- queue a known card;
- describe scheduler states;
- answer a card;
- verify scheduling state changed;
- undo and verify restoration;
- bury/suspend and verify queue impact;
- render existing card;
- extract AV tags;
- enumerate/generate TTS where CI environment supports it.

### Dart unit tests

Cover repository mappers, controller state machine, command routing, timers, media URL construction, audio/TTS orchestration, and stale-response protection.

### Flutter widget tests

Use fake `CardSurface` and fake repositories/services to verify:

- question UI;
- answer UI;
- queue counts;
- answer-button enablement;
- keyboard behavior;
- error/retry states;
- navigation to finished/overview state.

### CardSurface tests

Keep browser-specific behavior behind a contract and test:

- loading complete HTML/CSS;
- question -> answer update;
- JS bridge messages;
- base/media URL behavior;
- renderer teardown.

### End-to-end integration test

Against a disposable real Anki collection:

```text
open collection
-> select seeded deck
-> start review
-> render seeded question
-> verify media can load
-> reveal answer
-> obtain real Again/Hard/Good/Easy choices
-> submit a rating
-> verify next card / changed queue
-> undo
-> verify queue restoration
```

CI should run the real integration path on Linux and add Windows/macOS smoke/build jobs when the selected Chromium/CEF integration can be run reliably in CI.

## 24. Compatibility policy

The project stays pinned to the current upstream Anki commit for this milestone.

Reviewer code must not depend on floating upstream assets or APIs.

Any copied/ported official Anki web assets must retain required copyright/license notices and remain compatible with the repository's AGPL obligations.

Future Anki submodule bumps require reviewer contract tests to pass before adoption.

## 25. Implementation boundaries

The implementation should introduce or extend the following areas without coupling unrelated features:

```text
app/lib/features/study/
  domain/
  data/
  presentation/

app/lib/core/media/
app/lib/core/audio/
app/lib/core/webview/

native/anki_bridge/
  descriptor-derived operations for scheduler/rendering/undo as needed

app/test/features/study/
app/test/core/media/
app/test/core/audio/
app/test/core/webview/

integration_test/
```

Exact filenames are left to the implementation plan, but boundaries must stay narrow and testable.

## 26. Milestone acceptance checklist

The Reviewer milestone is accepted only when all of the following are true:

- [ ] real Anki queue is used;
- [ ] real card HTML/CSS/JS renders;
- [ ] relative collection media loads;
- [ ] question and answer AV tags work;
- [ ] TTS works through official backend support where available;
- [ ] Again/Hard/Good/Easy use real scheduler states;
- [ ] displayed intervals come from upstream;
- [ ] answer timing is sent correctly;
- [ ] official-style primary shortcuts work;
- [ ] undo works through upstream;
- [ ] bury/suspend works through upstream;
- [ ] auto-advance/wait-for-audio behavior is supported;
- [ ] queue completion returns cleanly to overview;
- [ ] Windows/macOS/Linux use one shared reviewer implementation;
- [ ] embedded Chromium/CEF card surface works on all three desktop targets;
- [ ] no frontend scheduling/FSRS reimplementation exists;
- [ ] handwritten behavior was introduced Red-first;
- [ ] real-backend integration test passes;
- [ ] license notices for reused official assets are preserved.

## 27. Deferred official Reviewer behavior

These official actions remain intentionally deferred until their owning feature module exists:

- edit current note;
- card/note information dialogs;
- recording and replay of user-recorded voice;
- flags and mark/tag UI beyond minimal support needed elsewhere;
- delete note;
- forget card;
- set due date;
- create card copy;
- deck options dialog;
- arbitrary add-on hooks and custom scheduling JavaScript.

The Reviewer command layer should reserve clean extension points for these actions rather than implementing temporary duplicates.

## 28. Final design decision

The Reviewer is not a new Anki-like study screen. It is a Flutter-hosted port of official Anki Desktop Reviewer behavior.

Flutter owns the application shell and typed state/repository boundaries. A single Chromium/CEF card surface is used across Windows, macOS, and Linux. Official Anki `rslib` remains authoritative for queueing, rendering, scheduler states, FSRS, answering, undo, bury/suspend, and TTS support. Official Reviewer web assets/interaction patterns are reused or ported where practical and license-compatible.

This keeps AnkiFlutter visually modern at the app-shell level while minimizing behavioral divergence in the most compatibility-sensitive workflow: studying cards.
