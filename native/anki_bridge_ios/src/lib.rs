//! Static archive adapter that keeps the shared Flutter C ABI in the iOS link.

use std::ffi::c_void;

#[used]
static BRIDGE_EXPORTS: [*const c_void; 4] = [
    anki_flutter_bridge::ffi::anki_bridge_create as *const c_void,
    anki_flutter_bridge::ffi::anki_bridge_invoke as *const c_void,
    anki_flutter_bridge::ffi::anki_bridge_free_buffer as *const c_void,
    anki_flutter_bridge::ffi::anki_bridge_destroy as *const c_void,
];

#[no_mangle]
pub extern "C" fn anki_flutter_ios_bridge_link_anchor() -> usize {
    BRIDGE_EXPORTS.len()
}
