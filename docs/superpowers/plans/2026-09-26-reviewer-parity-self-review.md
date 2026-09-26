# Reviewer Parity Plan Self-Review Amendments

This file is a **normative addendum** to `docs/superpowers/plans/2026-09-26-reviewer-parity.md` and must be read with it during implementation. Where this addendum is more specific, it overrides the earlier wording.

## Why this addendum exists

The implementation-plan self-review against pinned official Anki Desktop (`a5a0e444677a6b58cf784a9c2b7c2d5167f20df0`) found a few parity details that were underspecified in the first plan draft. They are fixed here before production implementation starts.

## Amendment 1: preserve official current-deck and card-ordinal semantics

In Task 2, `ReviewCard` must contain:

- `int cardId`
- `int noteId`
- `int storageDeckId` from `card.deck_id`
- `int originalDeckId` from `card.original_deck_id`
- `int currentDeckId`, computed exactly like official `Card.current_deck_id()`: `originalDeckId != 0 ? originalDeckId : storageDeckId`
- `int templateOrdinal` from `card.template_idx`
- `ReviewCounts counts`
- opaque current/answer scheduling-state bytes
- `String deckName` from the scheduling context

`ReviewRepository.settingsForDeck()` must be called with `currentDeckId`, not blindly with the queue/storage deck id. This is required for filtered cards, where official Anki uses the original deck's configuration.

Add RED mapping tests for both a normal card (`originalDeckId == 0`) and a filtered card (`originalDeckId != 0`).

## Amendment 2: match official card body classes

In Tasks 8 and 10, the Reviewer card document/body class must preserve the official `theme_manager.body_classes_for_card_ord()` contract relevant to AnkiFlutter:

- always `card`
- always `card${templateOrdinal + 1}`
- exactly one platform class: `isWin`, `isMac`, or `isLin`
- dark Reviewer mode includes both `nightMode` and `night_mode`
- macOS dark mode includes `macos-dark-mode` when applicable
- include `fancy` while AnkiFlutter has no minimalist-mode preference

Do not invent per-platform Reviewer code to produce these classes; expose one tested Dart helper used by the shared card surface.

Add focused tests for template ordinals 0 and 2, all three desktop platform classes, and light/dark output.

## Amendment 3: review timing is uncapped for scheduler submission

Task 6's grading tests must explicitly pin official V3 behavior: `CardAnswer.milliseconds_taken` uses uncapped elapsed card time (`card.time_taken(capped=False)` upstream).

Therefore:

- start the monotonic card timer when the queued card becomes current;
- keep it running through question and answer sides until rating;
- send the full uncapped elapsed milliseconds to `AnswerCard`;
- `answerTimeLimitSeconds` controls the visible Reviewer timer limit only; it must **not** cap `millisecondsTaken`.

Add a test where elapsed time exceeds `answerTimeLimitSeconds` and assert the full elapsed value is submitted.

## Amendment 4: visible timer and stop-on-answer behavior

Task 10 must test and implement the official visible timer semantics:

- when `showTimer == false`, do not show the card answer timer;
- when `showTimer == true`, show elapsed time with the upstream `answerTimeLimitSeconds` as its visual limit;
- when `stopTimerOnAnswer == true`, freeze the **displayed timer** when the answer side is revealed;
- freezing the displayed timer must not stop/cap the scheduler's monotonic elapsed-time measurement from Amendment 3.

Keep timer ownership in `ReviewController`; the widget only renders the controller's timer state.

## Amendment 5: leech feedback after an answer

Task 7 must actually consume the existing `ReviewRepository.stateIsLeech()` interface.

After a successful `AnswerCard` call and before discarding the answered-card context:

1. pass the selected answer choice's upstream new scheduling state to `StateIsLeech`;
2. if upstream returns true, emit a non-fatal Reviewer notice/event that the UI can display;
3. do not independently determine leech thresholds or suspension rules in Dart;
4. still continue to the next queued card after the notice is recorded.

Add tests for both leech and non-leech answers.

## Amendment 6: pin the audio-only media-kit runtime

Task 5 should use:

- `media_kit: 1.2.6`
- `media_kit_libs_audio: 1.0.7`

Do not add `media_kit_video`/video native libs solely for Reviewer audio. Card `<video>` elements remain rendered by Chromium/CEF inside the card surface; `ReviewAudioService` owns extracted Anki AV audio/TTS playback.

## Amendment 7: final parity gate additions

The milestone completion gate also requires:

- normal and filtered cards use the same deck-config semantics as official `Card.current_deck_id()`;
- card body classes include the correct `cardN`, platform, and dark-mode classes;
- scheduler answer time is uncapped even when the visible timer reaches its configured limit;
- `stopTimerOnAnswer` freezes only the visible timer;
- leech status is determined only by upstream `StateIsLeech` and surfaced non-fatally.

No other scope from the main plan is changed.