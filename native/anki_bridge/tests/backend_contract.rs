use std::fs;
use std::ptr;
use std::slice;
use std::time::{SystemTime, UNIX_EPOCH};

use anki::collection::CollectionBuilder;
use anki::decks::DeckId;
use anki::search::SortMode;
use anki_flutter_bridge::backend::BridgeBackend;
use anki_flutter_bridge::ffi::{
    anki_bridge_create, anki_bridge_destroy, anki_bridge_free_buffer, anki_bridge_invoke,
    ByteBuffer, STATUS_BACKEND_ERROR, STATUS_SUCCESS,
};
use anki_proto::backend::{BackendError, BackendInit};
use anki_proto::card_rendering::{
    rendered_template_node::Value, RenderCardResponse, RenderExistingCardRequest,
    RenderedTemplateNode,
};
use anki_proto::collection::{CloseCollectionRequest, OpenCollectionRequest};
use anki_proto::decks::{DeckTreeNode, DeckTreeRequest};
use prost::Message;
use tempfile::TempDir;

// Stable AnkiFlutter bridge ABI operation IDs, not upstream Anki service indices.
const OPEN_COLLECTION: u32 = 1;
const CLOSE_COLLECTION: u32 = 2;
const DECK_TREE: u32 = 3;
const RENDER_EXISTING_CARD: u32 = 12;

struct TestBackend {
    handle: *mut BridgeBackend,
}

impl TestBackend {
    fn new() -> Self {
        let init = BackendInit {
            preferred_langs: vec!["en-US".to_string()],
            locale_folder_path: String::new(),
            server: false,
        };
        let bytes = init.encode_to_vec();
        let result = unsafe { anki_bridge_create(bytes.as_ptr(), bytes.len()) };
        let error = take_buffer(result.data);
        assert_eq!(
            result.status,
            STATUS_SUCCESS,
            "backend init failed: {}",
            String::from_utf8_lossy(&error)
        );
        assert!(!result.handle.is_null());
        Self {
            handle: result.handle,
        }
    }

    fn invoke<M: Message>(&self, operation: u32, message: &M) -> (u32, Vec<u8>) {
        let input = message.encode_to_vec();
        let result =
            unsafe { anki_bridge_invoke(self.handle, operation, input.as_ptr(), input.len()) };
        (result.status, take_buffer(result.data))
    }
}

impl Drop for TestBackend {
    fn drop(&mut self) {
        unsafe { anki_bridge_destroy(self.handle) };
        self.handle = ptr::null_mut();
    }
}

fn take_buffer(buffer: ByteBuffer) -> Vec<u8> {
    let bytes = if buffer.ptr.is_null() || buffer.len == 0 {
        Vec::new()
    } else {
        unsafe { slice::from_raw_parts(buffer.ptr, buffer.len).to_vec() }
    };
    unsafe { anki_bridge_free_buffer(buffer) };
    bytes
}

fn collection_request(temp: &TempDir) -> OpenCollectionRequest {
    let collection_path = temp.path().join("collection.anki2");
    let media_folder_path = temp.path().join("collection.media");
    fs::create_dir_all(&media_folder_path).unwrap();
    let media_db_path = temp.path().join("collection.media.db2");

    OpenCollectionRequest {
        collection_path: collection_path.to_string_lossy().into_owned(),
        media_folder_path: media_folder_path.to_string_lossy().into_owned(),
        media_db_path: media_db_path.to_string_lossy().into_owned(),
    }
}

fn fetch_tree(backend: &TestBackend) -> DeckTreeNode {
    let now = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_secs() as i64;
    let (status, bytes) = backend.invoke(DECK_TREE, &DeckTreeRequest { now });
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "deck tree failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    DeckTreeNode::decode(bytes.as_slice()).unwrap()
}

fn assert_empty_default_deck(tree: &DeckTreeNode) {
    let default = tree
        .children
        .iter()
        .find(|node| node.deck_id == 1)
        .expect("default deck should exist");
    assert_eq!(default.new_count, 0);
    assert_eq!(default.learn_count, 0);
    assert_eq!(default.review_count, 0);
}

fn rendered_text(nodes: &[RenderedTemplateNode]) -> String {
    nodes
        .iter()
        .map(|node| match node.value.as_ref() {
            Some(Value::Text(text)) => text.as_str(),
            Some(Value::Replacement(_)) => panic!("full rendering returned replacement node"),
            None => panic!("rendered node missing value"),
        })
        .collect()
}

#[test]
fn real_collection_opens_exposes_default_deck_and_reopens_through_ffi() {
    let temp = TempDir::new().unwrap();
    let backend = TestBackend::new();
    let open = collection_request(&temp);

    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "open failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    assert_empty_default_deck(&fetch_tree(&backend));

    let (status, bytes) = backend.invoke(
        CLOSE_COLLECTION,
        &CloseCollectionRequest {
            downgrade_to_schema11: false,
        },
    );
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "close failed: {}",
        String::from_utf8_lossy(&bytes)
    );

    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "reopen failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    assert_empty_default_deck(&fetch_tree(&backend));
}

#[test]
fn reviewer_render_uses_real_anki_frontside_back_and_css() {
    let temp = TempDir::new().unwrap();
    let open = collection_request(&temp);

    let mut builder = CollectionBuilder::new(&open.collection_path);
    builder.set_media_paths(open.media_folder_path.clone(), open.media_db_path.clone());
    let mut collection = builder.build().unwrap();
    let notetype = collection
        .get_notetype_by_name("Basic")
        .unwrap()
        .expect("Basic notetype should exist");
    let mut note = notetype.new_note();
    note.set_field(0, "reviewer-front").unwrap();
    note.set_field(1, "reviewer-back").unwrap();
    collection.add_note(&mut note, DeckId(1)).unwrap();
    let card_ids = collection.search_cards(note.id, SortMode::NoOrder).unwrap();
    assert_eq!(card_ids.len(), 1);
    let card_id = card_ids[0].0;
    collection.close(None).unwrap();

    let backend = TestBackend::new();
    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "open failed: {}",
        String::from_utf8_lossy(&bytes)
    );

    let (status, bytes) = backend.invoke(
        RENDER_EXISTING_CARD,
        &RenderExistingCardRequest {
            card_id,
            browser: false,
            partial_render: false,
        },
    );
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "render failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    let rendered = RenderCardResponse::decode(bytes.as_slice()).unwrap();
    let question = rendered_text(&rendered.question_nodes);
    let answer = rendered_text(&rendered.answer_nodes);

    assert!(question.contains("reviewer-front"));
    assert!(answer.contains("reviewer-front"));
    assert!(answer.contains("reviewer-back"));
    assert!(!rendered.css.trim().is_empty());
}

#[test]
fn invalid_collection_parent_returns_status_one_with_decodable_anki_error() {
    let temp = TempDir::new().unwrap();
    let backend = TestBackend::new();
    let not_a_directory = temp.path().join("not_a_directory");
    fs::write(&not_a_directory, b"regular file").unwrap();

    let request = OpenCollectionRequest {
        collection_path: not_a_directory
            .join("collection.anki2")
            .to_string_lossy()
            .into_owned(),
        media_folder_path: temp
            .path()
            .join("collection.media")
            .to_string_lossy()
            .into_owned(),
        media_db_path: temp
            .path()
            .join("collection.media.db2")
            .to_string_lossy()
            .into_owned(),
    };

    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &request);
    assert_eq!(status, STATUS_BACKEND_ERROR);
    let error = BackendError::decode(bytes.as_slice()).expect("upstream error protobuf");
    assert!(!error.message.is_empty());
}
