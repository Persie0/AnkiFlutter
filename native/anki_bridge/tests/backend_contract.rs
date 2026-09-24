use std::fs;
use std::path::{Path, PathBuf};
use std::time::{SystemTime, UNIX_EPOCH};

use anki_flutter_bridge::backend::BridgeBackend;
use anki_flutter_bridge::operations::{CLOSE_COLLECTION, DECK_TREE, OPEN_COLLECTION};
use anki_proto::backend::{BackendError, BackendInit};
use anki_proto::collection::{CloseCollectionRequest, OpenCollectionRequest};
use anki_proto::decks::{DeckTreeNode, DeckTreeRequest};
use prost::Message;

#[test]
fn real_collection_opens_exposes_default_deck_and_reopens() {
    let temp = unique_temp_dir("real_collection");
    fs::create_dir_all(&temp).unwrap();

    let collection = temp.join("collection.anki2");
    let media = temp.join("collection.media");
    let media_db = temp.join("collection.media.db2");
    fs::create_dir_all(&media).unwrap();

    let backend = new_backend();
    open_collection(&backend, &collection, &media, &media_db).unwrap();

    let first_tree = deck_tree(&backend).unwrap();
    let default = first_tree
        .children
        .iter()
        .find(|deck| deck.name == "Default")
        .expect("new Anki collection should contain Default deck");
    assert_eq!(default.new_count, 0);
    assert_eq!(default.learn_count, 0);
    assert_eq!(default.review_count, 0);

    close_collection(&backend).unwrap();
    open_collection(&backend, &collection, &media, &media_db).unwrap();

    let reopened_tree = deck_tree(&backend).unwrap();
    assert!(reopened_tree.children.iter().any(|deck| deck.name == "Default"));

    close_collection(&backend).unwrap();
    fs::remove_dir_all(temp).unwrap();
}

#[test]
fn invalid_collection_parent_returns_decodable_anki_error() {
    let temp = unique_temp_dir("invalid_parent");
    fs::create_dir_all(&temp).unwrap();
    let not_a_directory = temp.join("not_a_directory");
    fs::write(&not_a_directory, b"regular file").unwrap();

    let collection = not_a_directory.join("collection.anki2");
    let media = not_a_directory.join("collection.media");
    let media_db = not_a_directory.join("collection.media.db2");
    let backend = new_backend();

    let error = open_collection(&backend, &collection, &media, &media_db)
        .expect_err("regular-file parent must fail deterministically");
    let decoded = BackendError::decode(error.as_slice()).expect("upstream error protobuf");
    assert!(!decoded.message.is_empty());

    fs::remove_dir_all(temp).unwrap();
}

fn new_backend() -> BridgeBackend {
    let init = BackendInit {
        preferred_langs: vec!["en-US".to_string()],
        locale_folder_path: String::new(),
        server: false,
    };
    BridgeBackend::from_init_bytes(&init.encode_to_vec()).unwrap()
}

fn open_collection(
    backend: &BridgeBackend,
    collection: &Path,
    media: &Path,
    media_db: &Path,
) -> Result<Vec<u8>, Vec<u8>> {
    let request = OpenCollectionRequest {
        collection_path: collection.to_string_lossy().into_owned(),
        media_folder_path: media.to_string_lossy().into_owned(),
        media_db_path: media_db.to_string_lossy().into_owned(),
    };
    backend.invoke(OPEN_COLLECTION, &request.encode_to_vec())
}

fn close_collection(backend: &BridgeBackend) -> Result<Vec<u8>, Vec<u8>> {
    let request = CloseCollectionRequest {
        downgrade_to_schema11: false,
    };
    backend.invoke(CLOSE_COLLECTION, &request.encode_to_vec())
}

fn deck_tree(backend: &BridgeBackend) -> Result<DeckTreeNode, Vec<u8>> {
    let now = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_secs() as i64;
    let request = DeckTreeRequest { now };
    backend
        .invoke(DECK_TREE, &request.encode_to_vec())
        .and_then(|bytes| DeckTreeNode::decode(bytes.as_slice()).map_err(|_| Vec::new()))
}

fn unique_temp_dir(label: &str) -> PathBuf {
    let nanos = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_nanos();
    std::env::temp_dir().join(format!(
        "anki_flutter_{label}_{}_{}",
        std::process::id(),
        nanos
    ))
}
