use std::any::Any;
use std::mem::ManuallyDrop;
use std::panic::{catch_unwind, AssertUnwindSafe};
use std::ptr;
use std::slice;

use crate::backend::BridgeBackend;
use crate::operations::{
    OperationIndex, ADD_DECK, ADD_NOTE, ADD_NOTETYPE, ALL_BROWSER_COLUMNS, ALL_TTS_VOICES,
    ANSWER_CARD, BROWSER_ROW_FOR_ID, BURY_OR_SUSPEND_CARDS, CLOSE_COLLECTION, DECK_TREE,
    DEFAULTS_FOR_ADDING, DESCRIBE_NEXT_STATES, ENCODE_IRI_PATHS, EXPORT_ANKI_PACKAGE,
    EXTRACT_AV_TAGS, GET_CARD, GET_CONFIG_JSON, GET_DECK_CONFIGS_FOR_UPDATE,
    GET_IMPORT_ANKI_PACKAGE_PRESETS, GET_NOTE, GET_NOTETYPE, GET_NOTETYPE_NAMES_AND_COUNTS,
    GET_QUEUED_CARDS, GET_UNDO_STATUS, IMPORT_ANKI_PACKAGE, NEW_DECK, NEW_NOTE, OPEN_COLLECTION,
    REMOVE_CARDS, REMOVE_DECKS, REMOVE_NOTETYPE, RENAME_DECK, RENDER_EXISTING_CARD,
    SEARCH_CARDS, SET_ACTIVE_BROWSER_COLUMNS, SET_CURRENT_DECK, STATE_IS_LEECH, UNDO,
    UPDATE_NOTES, UPDATE_NOTETYPE, WRITE_TTS_STREAM,
};

pub const STATUS_SUCCESS: u32 = 0;
pub const STATUS_BACKEND_ERROR: u32 = 1;
pub const STATUS_BRIDGE_ERROR: u32 = 2;

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
    match operation {
        1 => Ok(OPEN_COLLECTION),
        2 => Ok(CLOSE_COLLECTION),
        3 => Ok(DECK_TREE),
        4 => Ok(SET_CURRENT_DECK),
        5 => Ok(GET_QUEUED_CARDS),
        6 => Ok(DESCRIBE_NEXT_STATES),
        7 => Ok(ANSWER_CARD),
        8 => Ok(STATE_IS_LEECH),
        9 => Ok(BURY_OR_SUSPEND_CARDS),
        10 => Ok(GET_UNDO_STATUS),
        11 => Ok(UNDO),
        12 => Ok(RENDER_EXISTING_CARD),
        13 => Ok(EXTRACT_AV_TAGS),
        14 => Ok(ALL_TTS_VOICES),
        15 => Ok(WRITE_TTS_STREAM),
        16 => Ok(GET_DECK_CONFIGS_FOR_UPDATE),
        17 => Ok(ENCODE_IRI_PATHS),
        18 => Ok(RENAME_DECK),
        19 => Ok(REMOVE_DECKS),
        20 => Ok(GET_NOTETYPE_NAMES_AND_COUNTS),
        21 => Ok(NEW_NOTE),
        22 => Ok(ADD_NOTE),
        23 => Ok(GET_NOTETYPE),
        24 => Ok(DEFAULTS_FOR_ADDING),
        25 => Ok(SEARCH_CARDS),
        26 => Ok(BROWSER_ROW_FOR_ID),
        27 => Ok(SET_ACTIVE_BROWSER_COLUMNS),
        28 => Ok(GET_CONFIG_JSON),
        29 => Ok(GET_NOTE),
        30 => Ok(UPDATE_NOTES),
        31 => Ok(GET_CARD),
        32 => Ok(REMOVE_CARDS),
        33 => Ok(ALL_BROWSER_COLUMNS),
        34 => Ok(NEW_DECK),
        35 => Ok(ADD_DECK),
        36 => Ok(UPDATE_NOTETYPE),
        37 => Ok(ADD_NOTETYPE),
        38 => Ok(REMOVE_NOTETYPE),
        39 => Ok(GET_IMPORT_ANKI_PACKAGE_PRESETS),
        40 => Ok(IMPORT_ANKI_PACKAGE),
        41 => Ok(EXPORT_ANKI_PACKAGE),
        _ => Err(format!("Unknown Anki bridge operation {operation}")),
    }
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
/// non-zero, `input_ptr` must point to at least `input_len` readable bytes for
/// the duration of this call. Any non-empty returned buffer must be released
/// exactly once with `anki_bridge_free_buffer`.
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
        ADD_DECK, ADD_NOTE, ADD_NOTETYPE, BROWSER_ROW_FOR_ID, DEFAULTS_FOR_ADDING,
        EXPORT_ANKI_PACKAGE, GET_CARD, GET_CONFIG_JSON, GET_IMPORT_ANKI_PACKAGE_PRESETS,
        GET_NOTE, GET_NOTETYPE, GET_NOTETYPE_NAMES_AND_COUNTS, IMPORT_ANKI_PACKAGE, NEW_DECK,
        NEW_NOTE, REMOVE_NOTETYPE, SEARCH_CARDS, SET_ACTIVE_BROWSER_COLUMNS, UPDATE_NOTES,
        UPDATE_NOTETYPE,
    };

    #[test]
    fn note_operation_ids_map_to_the_pinned_backend_descriptors() {
        assert_eq!(
            operation_from_id(20).unwrap(),
            GET_NOTETYPE_NAMES_AND_COUNTS
        );
        assert_eq!(operation_from_id(21).unwrap(), NEW_NOTE);
        assert_eq!(operation_from_id(22).unwrap(), ADD_NOTE);
        assert_eq!(operation_from_id(23).unwrap(), GET_NOTETYPE);
        assert_eq!(operation_from_id(24).unwrap(), DEFAULTS_FOR_ADDING);
        assert_eq!(operation_from_id(25).unwrap(), SEARCH_CARDS);
        assert_eq!(operation_from_id(26).unwrap(), BROWSER_ROW_FOR_ID);
        assert_eq!(operation_from_id(27).unwrap(), SET_ACTIVE_BROWSER_COLUMNS);
        assert_eq!(operation_from_id(28).unwrap(), GET_CONFIG_JSON);
        assert_eq!(operation_from_id(29).unwrap(), GET_NOTE);
        assert_eq!(operation_from_id(30).unwrap(), UPDATE_NOTES);
        assert_eq!(operation_from_id(31).unwrap(), GET_CARD);
        assert_eq!(operation_from_id(34).unwrap(), NEW_DECK);
        assert_eq!(operation_from_id(35).unwrap(), ADD_DECK);
        assert_eq!(operation_from_id(36).unwrap(), UPDATE_NOTETYPE);
        assert_eq!(operation_from_id(37).unwrap(), ADD_NOTETYPE);
        assert_eq!(operation_from_id(38).unwrap(), REMOVE_NOTETYPE);
        assert_eq!(
            operation_from_id(39).unwrap(),
            GET_IMPORT_ANKI_PACKAGE_PRESETS
        );
        assert_eq!(operation_from_id(40).unwrap(), IMPORT_ANKI_PACKAGE);
        assert_eq!(operation_from_id(41).unwrap(), EXPORT_ANKI_PACKAGE);
    }
}
