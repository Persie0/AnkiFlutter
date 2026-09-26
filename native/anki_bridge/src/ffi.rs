use std::any::Any;
use std::mem::ManuallyDrop;
use std::panic::{catch_unwind, AssertUnwindSafe};
use std::ptr;
use std::slice;

use crate::backend::BridgeBackend;
use crate::operations::{OperationIndex, CLOSE_COLLECTION, DECK_TREE, OPEN_COLLECTION};

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
/// `anki_bridge_create` that has not already been destroyed. A non-null handle
/// must be destroyed exactly once.
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
