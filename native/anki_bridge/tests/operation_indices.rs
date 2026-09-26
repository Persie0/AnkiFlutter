use anki_flutter_bridge::operations::{CLOSE_COLLECTION, DECK_TREE, OPEN_COLLECTION};

#[test]
fn required_operations_are_distinct_and_available() {
    let values = [OPEN_COLLECTION, CLOSE_COLLECTION, DECK_TREE];
    assert_eq!(values.len(), 3);
    assert_ne!(OPEN_COLLECTION, CLOSE_COLLECTION);
    assert_ne!(OPEN_COLLECTION, DECK_TREE);
    assert_ne!(CLOSE_COLLECTION, DECK_TREE);
}
