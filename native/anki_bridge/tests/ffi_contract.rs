use std::ptr;
use std::time::{SystemTime, UNIX_EPOCH};

use anki_flutter_bridge::backend::BridgeBackend;
use anki_flutter_bridge::ffi::{
    anki_bridge_create, anki_bridge_destroy, anki_bridge_free_buffer, anki_bridge_invoke,
    ByteBuffer, STATUS_BACKEND_ERROR, STATUS_BRIDGE_ERROR, STATUS_SUCCESS,
};
use anki_flutter_bridge::operations::DECK_TREE;
use anki_proto::backend::BackendInit;
use anki_proto::collection::{CloseCollectionRequest, OpenCollectionRequest};
use anki_proto::decks::{DeckTreeNode, DeckTreeRequest};
use prost::Message;

fn backend_init_bytes() -> Vec<u8> {
    BackendInit {
        preferred_langs: vec!["en-US".to_string()],
        locale_folder_path: String::new(),
        server: false,
    }
    .encode_to_vec()
}

unsafe fn copy_and_free(buffer: ByteBuffer) -> Vec<u8> {
    if buffer.len == 0 {
        assert!(buffer.ptr.is_null());
        return Vec::new();
    }
    assert!(!buffer.ptr.is_null());
    let copied = unsafe { std::slice::from_raw_parts(buffer.ptr, buffer.len) }.to_vec();
    unsafe { anki_bridge_free_buffer(buffer) };
    copied
}

#[test]
fn malformed_init_returns_bridge_error_and_null_handle() {
    let bytes = [0xff, 0xff];
    let result = unsafe { anki_bridge_create(bytes.as_ptr(), bytes.len()) };
    assert_eq!(result.status, STATUS_BRIDGE_ERROR);
    assert!(result.handle.is_null());
    let message = String::from_utf8(unsafe { copy_and_free(result.data) }).unwrap();
    assert!(message.contains("decode"));
}

#[test]
fn null_handle_is_rejected() {
    let result = unsafe { anki_bridge_invoke(ptr::null_mut(), 3, ptr::null(), 0) };
    assert_eq!(result.status, STATUS_BRIDGE_ERROR);
    let message = String::from_utf8(unsafe { copy_and_free(result.data) }).unwrap();
    assert!(message.contains("handle"));
}

#[test]
fn null_input_with_nonzero_length_is_rejected() {
    let init = backend_init_bytes();
    let created = unsafe { anki_bridge_create(init.as_ptr(), init.len()) };
    assert_eq!(created.status, STATUS_SUCCESS);
    assert!(!created.handle.is_null());

    let result = unsafe { anki_bridge_invoke(created.handle, 3, ptr::null(), 1) };
    assert_eq!(result.status, STATUS_BRIDGE_ERROR);
    let message = String::from_utf8(unsafe { copy_and_free(result.data) }).unwrap();
    assert!(message.contains("input"));

    unsafe { anki_bridge_destroy(created.handle) };
}

#[test]
fn unknown_operation_is_rejected() {
    let init = backend_init_bytes();
    let created = unsafe { anki_bridge_create(init.as_ptr(), init.len()) };
    assert_eq!(created.status, STATUS_SUCCESS);

    let result = unsafe { anki_bridge_invoke(created.handle, 999, ptr::null(), 0) };
    assert_eq!(result.status, STATUS_BRIDGE_ERROR);
    let message = String::from_utf8(unsafe { copy_and_free(result.data) }).unwrap();
    assert!(message.contains("operation 999"));

    unsafe { anki_bridge_destroy(created.handle) };
}

#[test]
fn backend_error_bytes_are_preserved() {
    let init = backend_init_bytes();
    let request = DeckTreeRequest { now: 1_800_000_000 }.encode_to_vec();
    let direct = BridgeBackend::from_init_bytes(&init).unwrap();
    let expected = direct.invoke(DECK_TREE, &request).unwrap_err();

    let created = unsafe { anki_bridge_create(init.as_ptr(), init.len()) };
    let result = unsafe { anki_bridge_invoke(created.handle, 3, request.as_ptr(), request.len()) };
    assert_eq!(result.status, STATUS_BACKEND_ERROR);
    let actual = unsafe { copy_and_free(result.data) };
    assert_eq!(actual, expected);

    unsafe { anki_bridge_destroy(created.handle) };
}

#[test]
fn successful_nonempty_buffer_is_decodable_and_freeable() {
    let stamp = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_nanos();
    let root = std::env::temp_dir().join(format!("anki_flutter_{}_{}", std::process::id(), stamp));
    let collection = root.with_extension("anki2");
    let media = root.with_extension("media");
    let media_db = std::path::PathBuf::from(format!("{}.db2", media.display()));

    let init = backend_init_bytes();
    let created = unsafe { anki_bridge_create(init.as_ptr(), init.len()) };
    assert_eq!(created.status, STATUS_SUCCESS);
    assert!(created.data.ptr.is_null());
    assert_eq!(created.data.len, 0);

    let open = OpenCollectionRequest {
        collection_path: collection.to_string_lossy().into_owned(),
        media_folder_path: media.to_string_lossy().into_owned(),
        media_db_path: media_db.to_string_lossy().into_owned(),
    }
    .encode_to_vec();
    let opened = unsafe { anki_bridge_invoke(created.handle, 1, open.as_ptr(), open.len()) };
    assert_eq!(opened.status, STATUS_SUCCESS);
    assert!(opened.data.ptr.is_null());

    let tree_request = DeckTreeRequest { now: 1_800_000_000 }.encode_to_vec();
    let tree_result =
        unsafe { anki_bridge_invoke(created.handle, 3, tree_request.as_ptr(), tree_request.len()) };
    assert_eq!(tree_result.status, STATUS_SUCCESS);
    let tree_bytes = unsafe { copy_and_free(tree_result.data) };
    assert!(!tree_bytes.is_empty());
    let _ = DeckTreeNode::decode(tree_bytes.as_slice()).unwrap();

    let close = CloseCollectionRequest {
        downgrade_to_schema11: false,
    }
    .encode_to_vec();
    let closed = unsafe { anki_bridge_invoke(created.handle, 2, close.as_ptr(), close.len()) };
    assert_eq!(closed.status, STATUS_SUCCESS);
    unsafe { anki_bridge_destroy(created.handle) };

    let _ = std::fs::remove_file(collection);
    let _ = std::fs::remove_file(media_db);
    let _ = std::fs::remove_dir_all(media);
}
