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
use anki_proto::cards::{CardIds, RemoveCardsRequest};
use anki_proto::collection::{
    CheckDatabaseResponse, CloseCollectionRequest, CreateBackupRequest, OpChangesAfterUndo,
    OpChangesWithCount,
    OpChangesWithId, OpenCollectionRequest, UndoStatus,
};
use anki_proto::decks::{DeckTreeNode, DeckTreeRequest};
use anki_proto::generic::Empty;
use anki_proto::media::{CheckMediaResponse, TrashMediaFilesRequest};
use anki_proto::scheduler::BuryOrSuspendCardsRequest;
use anki_proto::search::BrowserColumns;
use prost::Message;
use tempfile::TempDir;

// Stable AnkiFlutter bridge ABI operation IDs, not upstream Anki service indices.
const OPEN_COLLECTION: u32 = 1;
const CLOSE_COLLECTION: u32 = 2;
const DECK_TREE: u32 = 3;
const RENDER_EXISTING_CARD: u32 = 12;
const REMOVE_CARDS: u32 = 32;
const ALL_BROWSER_COLUMNS: u32 = 33;
const NEW_DECK: u32 = 34;
const ADD_DECK: u32 = 35;

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
fn native_backup_creates_database_only_archive_in_selected_directory() {
    let temp = TempDir::new().unwrap();
    let backend = TestBackend::new();
    let open = collection_request(&temp);
    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(status, STATUS_SUCCESS, "open: {}", String::from_utf8_lossy(&bytes));

    let folder = temp.path().join("manual-backups");
    fs::create_dir_all(&folder).unwrap();
    let (status, bytes) = backend.invoke(
        81,
        &CreateBackupRequest {
            backup_folder: folder.to_string_lossy().into_owned(),
            force: true,
            wait_for_completion: true,
        },
    );
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "backup failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    let created = anki_proto::generic::Bool::decode(bytes.as_slice()).unwrap();
    assert!(created.val, "forced native backup must actually be created");
    assert!(
        fs::read_dir(&folder).unwrap().next().is_some(),
        "native backup must write into the selected folder"
    );
}

#[test]
fn real_backend_creates_a_deck_from_anki_defaults_through_ffi() {
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

    let (status, bytes) = backend.invoke(NEW_DECK, &Empty::default());
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "Anki default deck creation failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    let mut deck = anki_proto::decks::Deck::decode(bytes.as_slice()).unwrap();
    deck.name = "Created by AnkiFlutter".to_string();

    let (status, bytes) = backend.invoke(ADD_DECK, &deck);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "deck add failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    let result = OpChangesWithId::decode(bytes.as_slice()).unwrap();
    assert!(result.id > 1, "new deck should receive a non-default id");

    let tree = fetch_tree(&backend);
    assert!(tree
        .children
        .iter()
        .any(|node| { node.deck_id == result.id && node.name == "Created by AnkiFlutter" }));
}

#[test]
fn native_database_check_uses_upstream_anki_on_real_collection() {
    let temp = TempDir::new().unwrap();
    let open = collection_request(&temp);
    let backend = TestBackend::new();
    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "open: {}",
        String::from_utf8_lossy(&bytes)
    );

    let (status, bytes) = backend.invoke(80, &Empty::default());
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "check database: {}",
        String::from_utf8_lossy(&bytes)
    );
    let _report = CheckDatabaseResponse::decode(bytes.as_slice()).unwrap();
    // A completed database check must leave the collection readable.
    assert!(fetch_tree(&backend)
        .children
        .iter()
        .any(|node| node.deck_id == 1));
}

#[test]
fn native_undo_and_redo_restore_a_deck_and_their_status() {
    let temp = TempDir::new().unwrap();
    let backend = TestBackend::new();
    let open = collection_request(&temp);
    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "open: {}",
        String::from_utf8_lossy(&bytes)
    );

    let (status, bytes) = backend.invoke(NEW_DECK, &Empty::default());
    assert_eq!(status, STATUS_SUCCESS);
    let mut deck = anki_proto::decks::Deck::decode(bytes.as_slice()).unwrap();
    deck.name = "History roundtrip".to_string();
    let (status, bytes) = backend.invoke(ADD_DECK, &deck);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "add: {}",
        String::from_utf8_lossy(&bytes)
    );
    let id = OpChangesWithId::decode(bytes.as_slice()).unwrap().id;
    assert!(fetch_tree(&backend)
        .children
        .iter()
        .any(|node| node.deck_id == id));

    let (status, bytes) = backend.invoke(10, &Empty::default());
    assert_eq!(status, STATUS_SUCCESS);
    let state = UndoStatus::decode(bytes.as_slice()).unwrap();
    assert!(
        !state.undo.is_empty(),
        "Anki must offer undo for newly created deck"
    );

    let (status, bytes) = backend.invoke(11, &Empty::default());
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "undo: {}",
        String::from_utf8_lossy(&bytes)
    );
    let _undone = OpChangesAfterUndo::decode(bytes.as_slice()).unwrap();
    // UndoOutput captures the interim status inside the transaction. Read
    // the committed status after the opposite redo step is recorded.
    let (status, bytes) = backend.invoke(10, &Empty::default());
    assert_eq!(status, STATUS_SUCCESS);
    let after_undo = UndoStatus::decode(bytes.as_slice()).unwrap();
    assert!(
        !after_undo.redo.is_empty(),
        "redo must be available after undo"
    );
    assert!(!fetch_tree(&backend)
        .children
        .iter()
        .any(|node| node.deck_id == id));

    let (status, bytes) = backend.invoke(79, &Empty::default());
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "redo: {}",
        String::from_utf8_lossy(&bytes)
    );
    let _redone = OpChangesAfterUndo::decode(bytes.as_slice()).unwrap();
    let (status, bytes) = backend.invoke(10, &Empty::default());
    assert_eq!(status, STATUS_SUCCESS);
    let after_redo = UndoStatus::decode(bytes.as_slice()).unwrap();
    assert!(
        !after_redo.undo.is_empty(),
        "undo must be available after redo"
    );
    assert!(fetch_tree(&backend)
        .children
        .iter()
        .any(|node| node.deck_id == id));
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
fn selected_card_removal_uses_anki_cards_service_through_ffi() {
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
    note.set_field(0, "remove-selected-card").unwrap();
    note.set_field(1, "back").unwrap();
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
        REMOVE_CARDS,
        &RemoveCardsRequest {
            card_ids: vec![card_id],
        },
    );
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "removal failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    let changes = OpChangesWithCount::decode(bytes.as_slice()).unwrap();
    assert_eq!(changes.count, 1);
}

#[test]
fn suspended_card_can_be_restored_through_native_anki_scheduler() {
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
    note.set_field(0, "restore-suspended").unwrap();
    note.set_field(1, "back").unwrap();
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
        9,
        &BuryOrSuspendCardsRequest {
            card_ids: vec![card_id],
            note_ids: vec![],
            mode: 0, // Anki's SUSPEND enum
        },
    );
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "suspend card failed: {}",
        String::from_utf8_lossy(&bytes)
    );

    let (status, bytes) = backend.invoke(
        78,
        &CardIds {
            cids: vec![card_id],
        },
    );
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "restore card failed: {}",
        String::from_utf8_lossy(&bytes)
    );
}

#[test]
fn browser_sort_metadata_is_available_through_ffi() {
    let temp = TempDir::new().unwrap();
    let open = collection_request(&temp);
    let backend = TestBackend::new();

    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "open failed: {}",
        String::from_utf8_lossy(&bytes)
    );

    let (status, bytes) = backend.invoke(ALL_BROWSER_COLUMNS, &anki_proto::generic::Empty {});
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "browser columns failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    let columns = BrowserColumns::decode(bytes.as_slice()).unwrap();
    assert!(columns.columns.iter().any(|column| column.key == "noteFld"));
    assert!(columns.columns.iter().any(|column| column.key == "cardDue"));
}

#[test]
fn media_audit_trash_and_restore_use_upstream_anki_storage() {
    let temp = TempDir::new().unwrap();
    let open = collection_request(&temp);
    let media_path = temp
        .path()
        .join("collection.media")
        .join("unused-by-note.png");
    fs::write(&media_path, b"unreferenced-media").unwrap();

    let backend = TestBackend::new();
    let (status, bytes) = backend.invoke(OPEN_COLLECTION, &open);
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "open failed: {}",
        String::from_utf8_lossy(&bytes)
    );

    let (status, bytes) = backend.invoke(57, &Empty::default());
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "check media failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    let audit = CheckMediaResponse::decode(bytes.as_slice()).unwrap();
    assert!(audit.unused.contains(&"unused-by-note.png".to_string()));

    let (status, bytes) = backend.invoke(
        76,
        &TrashMediaFilesRequest {
            fnames: vec!["unused-by-note.png".to_string()],
        },
    );
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "trash media failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    assert!(
        !media_path.exists(),
        "trash must remove original media path"
    );

    let (status, bytes) = backend.invoke(77, &Empty::default());
    assert_eq!(
        status,
        STATUS_SUCCESS,
        "restore media failed: {}",
        String::from_utf8_lossy(&bytes)
    );
    assert!(
        media_path.exists(),
        "restoring trash must recover original media"
    );
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
