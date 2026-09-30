use anki_flutter_bridge::operations::{
    ADD_DECK, ALL_BROWSER_COLUMNS, ALL_TTS_VOICES, ANSWER_CARD, BURY_OR_SUSPEND_CARDS,
    CLOSE_COLLECTION, DECK_TREE, DESCRIBE_NEXT_STATES, ENCODE_IRI_PATHS, EXTRACT_AV_TAGS,
    GET_DECK_CONFIGS_FOR_UPDATE, GET_QUEUED_CARDS, GET_UNDO_STATUS, NEW_DECK, OPEN_COLLECTION,
    REMOVE_CARDS, RENDER_EXISTING_CARD, SET_CURRENT_DECK, STATE_IS_LEECH, UNDO, WRITE_TTS_STREAM,
};

#[test]
fn required_operations_are_distinct_and_available() {
    let values = [
        OPEN_COLLECTION,
        CLOSE_COLLECTION,
        DECK_TREE,
        SET_CURRENT_DECK,
        GET_QUEUED_CARDS,
        DESCRIBE_NEXT_STATES,
        ANSWER_CARD,
        STATE_IS_LEECH,
        BURY_OR_SUSPEND_CARDS,
        GET_UNDO_STATUS,
        UNDO,
        RENDER_EXISTING_CARD,
        EXTRACT_AV_TAGS,
        ALL_TTS_VOICES,
        WRITE_TTS_STREAM,
        GET_DECK_CONFIGS_FOR_UPDATE,
        ENCODE_IRI_PATHS,
        REMOVE_CARDS,
        ALL_BROWSER_COLUMNS,
        NEW_DECK,
        ADD_DECK,
    ];

    assert_eq!(values.len(), 21);
    for (index, left) in values.iter().enumerate() {
        for right in values.iter().skip(index + 1) {
            assert_ne!(left, right);
        }
    }
}
