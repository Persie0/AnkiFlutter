use std::any::Any;
use std::mem::ManuallyDrop;
use std::panic::{catch_unwind, AssertUnwindSafe};
use std::ptr;
use std::slice;

use crate::backend::BridgeBackend;
use crate::operations::{
    OperationIndex, ABORT_MEDIA_SYNC, ABORT_SYNC, ADD_DECK, ADD_MEDIA_FILE, ADD_MEDIA_FROM_URL,
    ADD_NOTE, ADD_NOTETYPE, ADD_NOTE_TAGS, ALL_BROWSER_COLUMNS, ALL_TAGS, ALL_TTS_VOICES,
    ANSWER_CARD, BROWSER_ROW_FOR_ID, BURY_OR_SUSPEND_CARDS, CARD_STATS, CHECK_DATABASE,
    CHECK_MEDIA, CLOSE_COLLECTION, COMPARE_ANSWER, CREATE_BACKUP, CUSTOM_STUDY,
    CUSTOM_STUDY_DEFAULTS, DECK_TREE, DEFAULTS_FOR_ADDING, DESCRIBE_NEXT_STATES, ENCODE_IRI_PATHS,
    EXPORT_ANKI_PACKAGE, EXTRACT_AV_TAGS, EXTRACT_CLOZE_FOR_TYPING, FIND_AND_REPLACE,
    FULL_UPLOAD_OR_DOWNLOAD, GET_ABSOLUTE_MEDIA_PATH, GET_CARD, GET_CONFIG_JSON, GET_CONFIG_STRING,
    GET_DECK_CONFIGS_FOR_UPDATE, GET_IMPORT_ANKI_PACKAGE_PRESETS, GET_NOTE, GET_NOTETYPE,
    GET_NOTETYPE_NAMES_AND_COUNTS, GET_PREFERENCES, GET_QUEUED_CARDS, GET_UNDO_STATUS, GRAPHS,
    IMPORT_ANKI_PACKAGE, MEDIA_SYNC_STATUS, NEW_DECK, NEW_NOTE, NOTE_FIELDS_CHECK, OPEN_COLLECTION,
    REDO, REMOVE_CARDS, REMOVE_DECKS, REMOVE_NOTES, REMOVE_NOTETYPE, REMOVE_NOTE_TAGS, RENAME_DECK,
    RENDER_EXISTING_CARD, REPOSITION_DEFAULTS, RESTORE_BURIED_AND_SUSPENDED_CARDS, RESTORE_TRASH,
    SCHEDULE_CARDS_AS_NEW, SCHEDULE_CARDS_AS_NEW_DEFAULTS, SEARCH_CARDS,
    SET_ACTIVE_BROWSER_COLUMNS, SET_CURRENT_DECK, SET_CUSTOM_CERTIFICATE, SET_DECK, SET_DUE_DATE,
    SET_FLAG, SET_PREFERENCES, SORT_CARDS, STATE_IS_LEECH, SYNC_COLLECTION, SYNC_LOGIN, SYNC_MEDIA,
    SYNC_STATUS, TRASH_MEDIA_FILES, UNBURY_DECK, UNDO, UPDATE_DECK_CONFIGS, UPDATE_NOTES,
    UPDATE_NOTETYPE, WRITE_TTS_STREAM,
};

pub const STATUS_SUCCESS: u32 = 0;
pub const STATUS_BACKEND_ERROR: u32 = 1;
pub const STATUS_BRIDGE_ERROR: u32 = 2;

const OPERATIONS_BY_ID: &[OperationIndex] = &[
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
    RENAME_DECK,
    REMOVE_DECKS,
    GET_NOTETYPE_NAMES_AND_COUNTS,
    NEW_NOTE,
    ADD_NOTE,
    GET_NOTETYPE,
    DEFAULTS_FOR_ADDING,
    SEARCH_CARDS,
    BROWSER_ROW_FOR_ID,
    SET_ACTIVE_BROWSER_COLUMNS,
    GET_CONFIG_JSON,
    GET_NOTE,
    UPDATE_NOTES,
    GET_CARD,
    REMOVE_CARDS,
    ALL_BROWSER_COLUMNS,
    NEW_DECK,
    ADD_DECK,
    UPDATE_NOTETYPE,
    ADD_NOTETYPE,
    REMOVE_NOTETYPE,
    GET_IMPORT_ANKI_PACKAGE_PRESETS,
    IMPORT_ANKI_PACKAGE,
    EXPORT_ANKI_PACKAGE,
    CUSTOM_STUDY_DEFAULTS,
    CUSTOM_STUDY,
    UNBURY_DECK,
    UPDATE_DECK_CONFIGS,
    SYNC_LOGIN,
    SYNC_STATUS,
    SYNC_COLLECTION,
    FULL_UPLOAD_OR_DOWNLOAD,
    SYNC_MEDIA,
    MEDIA_SYNC_STATUS,
    ABORT_SYNC,
    ABORT_MEDIA_SYNC,
    SET_CUSTOM_CERTIFICATE,
    ADD_MEDIA_FILE,
    ADD_MEDIA_FROM_URL,
    CHECK_MEDIA,
    GET_ABSOLUTE_MEDIA_PATH,
    ADD_NOTE_TAGS,
    REMOVE_NOTE_TAGS,
    SET_DECK,
    SET_FLAG,
    ALL_TAGS,
    GRAPHS,
    GET_PREFERENCES,
    SET_PREFERENCES,
    NOTE_FIELDS_CHECK,
    COMPARE_ANSWER,
    EXTRACT_CLOZE_FOR_TYPING,
    REMOVE_NOTES,
    SCHEDULE_CARDS_AS_NEW,
    SCHEDULE_CARDS_AS_NEW_DEFAULTS,
    GET_CONFIG_STRING,
    SET_DUE_DATE,
    CARD_STATS,
    TRASH_MEDIA_FILES,
    RESTORE_TRASH,
    RESTORE_BURIED_AND_SUSPENDED_CARDS,
    REDO,
    CHECK_DATABASE,
    CREATE_BACKUP,
    FIND_AND_REPLACE,
    SORT_CARDS,
    REPOSITION_DEFAULTS,
];

#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct ByteBuffer {
    pub ptr: *mut u8,
    pub len: usize,
    pub cap: usize,
}

impl ByteBuffer {
    fn empty() -> Self {
        Self {
            ptr: ptr::null_mut(),
            len: 0,
            cap: 0,
        }
    }

    fn from_vec(bytes: Vec<u8>) -> Self {
        if bytes.is_empty() {
            return Self::empty();
        }
        let mut bytes = ManuallyDrop::new(bytes);
        Self {
            ptr: bytes.as_mut_ptr(),
            len: bytes.len(),
            cap: bytes.capacity(),
        }
    }

    fn from_string(message: String) -> Self {
        Self::from_vec(message.into_bytes())
    }
}

#[repr(C)]
pub struct BridgeCreateResult {
    pub status: u32,
    pub handle: *mut BridgeBackend,
    pub data: ByteBuffer,
}

#[repr(C)]
pub struct BridgeCallResult {
    pub status: u32,
    pub data: ByteBuffer,
}

fn bridge_create_error(message: String) -> BridgeCreateResult {
    BridgeCreateResult {
        status: STATUS_BRIDGE_ERROR,
        handle: ptr::null_mut(),
        data: ByteBuffer::from_string(message),
    }
}

fn bridge_call_error(message: String) -> BridgeCallResult {
    BridgeCallResult {
        status: STATUS_BRIDGE_ERROR,
        data: ByteBuffer::from_string(message),
    }
}

fn panic_text(payload: Box<dyn Any + Send>) -> String {
    if let Some(message) = payload.downcast_ref::<&str>() {
        format!("Anki bridge panic: {message}")
    } else if let Some(message) = payload.downcast_ref::<String>() {
        format!("Anki bridge panic: {message}")
    } else {
        "Anki bridge panic".to_string()
    }
}

unsafe fn input_bytes<'a>(input_ptr: *const u8, input_len: usize) -> Result<&'a [u8], String> {
    if input_len == 0 {
        return Ok(&[]);
    }
    if input_ptr.is_null() {
        return Err("Anki bridge input pointer is null for non-zero input length".to_string());
    }
    Ok(unsafe { slice::from_raw_parts(input_ptr, input_len) })
}

fn operation_from_id(operation: u32) -> Result<OperationIndex, String> {
    let index = operation
        .checked_sub(1)
        .ok_or_else(|| format!("Unknown Anki bridge operation {operation}"))?
        as usize;
    OPERATIONS_BY_ID
        .get(index)
        .copied()
        .ok_or_else(|| format!("Unknown Anki bridge operation {operation}"))
}

/// Creates a bridge backend from the protobuf bytes at `init_ptr`.
///
/// # Safety
///
/// When `init_len` is non-zero, `init_ptr` must point to at least `init_len`
/// readable bytes for the duration of this call. The returned handle, when
/// non-null, must later be released exactly once with `anki_bridge_destroy`.
#[no_mangle]
pub unsafe extern "C" fn anki_bridge_create(
    init_ptr: *const u8,
    init_len: usize,
) -> BridgeCreateResult {
    match catch_unwind(AssertUnwindSafe(|| {
        let input = unsafe { input_bytes(init_ptr, init_len) }?;
        let backend = BridgeBackend::from_init_bytes(input)?;
        Ok::<_, String>(BridgeCreateResult {
            status: STATUS_SUCCESS,
            handle: Box::into_raw(Box::new(backend)),
            data: ByteBuffer::empty(),
        })
    })) {
        Ok(Ok(result)) => result,
        Ok(Err(message)) => bridge_create_error(message),
        Err(payload) => bridge_create_error(panic_text(payload)),
    }
}

/// Invokes a stable bridge operation on an existing backend handle.
///
/// # Safety
///
/// `handle`, when non-null, must be a live handle returned by
/// `anki_bridge_create` that has not been destroyed. When `input_len` is
/// non-zero, `input_ptr` must point to at least `input_len`
/// readable bytes for the duration of this call. Any non-empty returned buffer
/// must be released exactly once with `anki_bridge_free_buffer`.
#[no_mangle]
pub unsafe extern "C" fn anki_bridge_invoke(
    handle: *mut BridgeBackend,
    operation: u32,
    input_ptr: *const u8,
    input_len: usize,
) -> BridgeCallResult {
    match catch_unwind(AssertUnwindSafe(|| {
        let backend =
            unsafe { handle.as_ref() }.ok_or_else(|| "Anki bridge handle is null".to_string())?;
        let input = unsafe { input_bytes(input_ptr, input_len) }?;
        let operation = operation_from_id(operation)?;
        Ok::<_, String>(match backend.invoke(operation, input) {
            Ok(bytes) => BridgeCallResult {
                status: STATUS_SUCCESS,
                data: ByteBuffer::from_vec(bytes),
            },
            Err(bytes) => BridgeCallResult {
                status: STATUS_BACKEND_ERROR,
                data: ByteBuffer::from_vec(bytes),
            },
        })
    })) {
        Ok(Ok(result)) => result,
        Ok(Err(message)) => bridge_call_error(message),
        Err(payload) => bridge_call_error(panic_text(payload)),
    }
}

/// Releases a buffer returned by this bridge.
///
/// # Safety
///
/// `buffer` must either be the empty/null buffer or a buffer returned by this
/// bridge that has not already been freed. Passing forged pointer/length/capacity
/// values or freeing the same non-empty buffer twice is undefined behavior.
#[no_mangle]
pub unsafe extern "C" fn anki_bridge_free_buffer(buffer: ByteBuffer) {
    let _ = catch_unwind(AssertUnwindSafe(|| {
        if buffer.ptr.is_null() {
            return;
        }
        if buffer.cap < buffer.len || buffer.cap == 0 {
            return;
        }
        unsafe {
            drop(Vec::from_raw_parts(buffer.ptr, buffer.len, buffer.cap));
        }
    }));
}

/// Destroys a bridge backend handle.
///
/// # Safety
///
/// `handle` must either be null or a live handle returned by
/// `anki_bridge_create` that has not been destroyed. A non-null handle must be destroyed exactly once.
#[no_mangle]
pub unsafe extern "C" fn anki_bridge_destroy(handle: *mut BridgeBackend) {
    let _ = catch_unwind(AssertUnwindSafe(|| {
        if !handle.is_null() {
            unsafe {
                drop(Box::from_raw(handle));
            }
        }
    }));
}

#[cfg(test)]
mod tests {
    use super::operation_from_id;
    use crate::operations::{
        ADD_NOTE_TAGS, ALL_TAGS, CARD_STATS, CHECK_DATABASE, COMPARE_ANSWER, CREATE_BACKUP,
        EXTRACT_CLOZE_FOR_TYPING, FIND_AND_REPLACE, GET_CONFIG_STRING, GET_PREFERENCES, GRAPHS,
        NOTE_FIELDS_CHECK, REDO, REMOVE_NOTES, REMOVE_NOTE_TAGS,
        RESTORE_BURIED_AND_SUSPENDED_CARDS, RESTORE_TRASH, SCHEDULE_CARDS_AS_NEW,
        SCHEDULE_CARDS_AS_NEW_DEFAULTS, SET_DECK, SET_DUE_DATE, SET_FLAG, SET_PREFERENCES,
        TRASH_MEDIA_FILES,
    };

    #[test]
    fn extended_operation_ids_map_to_the_pinned_backend_descriptors() {
        assert_eq!(operation_from_id(59).unwrap(), ADD_NOTE_TAGS);
        assert_eq!(operation_from_id(60).unwrap(), REMOVE_NOTE_TAGS);
        assert_eq!(operation_from_id(61).unwrap(), SET_DECK);
        assert_eq!(operation_from_id(62).unwrap(), SET_FLAG);
        assert_eq!(operation_from_id(63).unwrap(), ALL_TAGS);
        assert_eq!(operation_from_id(64).unwrap(), GRAPHS);
        assert_eq!(operation_from_id(65).unwrap(), GET_PREFERENCES);
        assert_eq!(operation_from_id(66).unwrap(), SET_PREFERENCES);
        assert_eq!(operation_from_id(67).unwrap(), NOTE_FIELDS_CHECK);
        assert_eq!(operation_from_id(68).unwrap(), COMPARE_ANSWER);
        assert_eq!(operation_from_id(69).unwrap(), EXTRACT_CLOZE_FOR_TYPING);
        assert_eq!(operation_from_id(70).unwrap(), REMOVE_NOTES);
        assert_eq!(operation_from_id(71).unwrap(), SCHEDULE_CARDS_AS_NEW);
        assert_eq!(
            operation_from_id(72).unwrap(),
            SCHEDULE_CARDS_AS_NEW_DEFAULTS
        );
        assert_eq!(operation_from_id(73).unwrap(), GET_CONFIG_STRING);
        assert_eq!(operation_from_id(74).unwrap(), SET_DUE_DATE);
        assert_eq!(operation_from_id(75).unwrap(), CARD_STATS);
        assert!(operation_from_id(0).is_err());
        assert_eq!(operation_from_id(76).unwrap(), TRASH_MEDIA_FILES);
        assert_eq!(operation_from_id(77).unwrap(), RESTORE_TRASH);
        assert_eq!(
            operation_from_id(78).unwrap(),
            RESTORE_BURIED_AND_SUSPENDED_CARDS
        );
        assert_eq!(operation_from_id(79).unwrap(), REDO);
        assert_eq!(operation_from_id(80).unwrap(), CHECK_DATABASE);
        assert_eq!(operation_from_id(81).unwrap(), CREATE_BACKUP);
        assert_eq!(operation_from_id(82).unwrap(), FIND_AND_REPLACE);
        assert!(operation_from_id(83).is_err());
    }
}
