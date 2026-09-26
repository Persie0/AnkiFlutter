#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct OperationIndex {
    pub service: u32,
    pub method: u32,
}

include!(concat!(env!("OUT_DIR"), "/operations_generated.rs"));
