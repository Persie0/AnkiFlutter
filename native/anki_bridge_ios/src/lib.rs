//! Static archive adapter that keeps the shared Flutter C ABI in the iOS link.

use std::ffi::c_void;
use std::sync::atomic::AtomicPtr;

#[used]
static BRIDGE_EXPORTS: [AtomicPtr<c_void>; 4] = [
    AtomicPtr::new(anki_flutter_bridge::ffi::anki_bridge_create as *mut c_void),
    AtomicPtr::new(anki_flutter_bridge::ffi::anki_bridge_invoke as *mut c_void),
    AtomicPtr::new(anki_flutter_bridge::ffi::anki_bridge_free_buffer as *mut c_void),
    AtomicPtr::new(anki_flutter_bridge::ffi::anki_bridge_destroy as *mut c_void),
];

#[no_mangle]
pub extern "C" fn anki_flutter_ios_bridge_link_anchor() -> usize {
    BRIDGE_EXPORTS.len()
}

#[cfg(test)]
mod tests {
    #[test]
    fn link_anchor_retains_all_four_bridge_exports() {
        assert_eq!(super::anki_flutter_ios_bridge_link_anchor(), 4);
    }
}
