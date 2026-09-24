use anki::backend::{self, Backend};

use crate::operations::OperationIndex;

pub struct BridgeBackend {
    backend: Backend,
}

impl BridgeBackend {
    pub fn from_init_bytes(input: &[u8]) -> Result<Self, String> {
        backend::init_backend(input).map(|backend| Self { backend })
    }

    pub fn invoke(
        &self,
        operation: OperationIndex,
        input: &[u8],
    ) -> Result<Vec<u8>, Vec<u8>> {
        self.backend
            .run_service_method(operation.service, operation.method, input)
    }
}
