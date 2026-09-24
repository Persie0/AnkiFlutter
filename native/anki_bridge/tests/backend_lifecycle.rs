use anki_flutter_bridge::backend::BridgeBackend;
use anki_proto::backend::BackendInit;
use prost::Message;

fn backend_init_bytes() -> Vec<u8> {
    BackendInit {
        preferred_langs: vec!["en-US".to_string()],
        locale_folder_path: String::new(),
        server: false,
    }
    .encode_to_vec()
}

#[test]
fn valid_backend_init_creates_backend() {
    assert!(BridgeBackend::from_init_bytes(&backend_init_bytes()).is_ok());
}

#[test]
fn malformed_backend_init_is_rejected() {
    let result = BridgeBackend::from_init_bytes(&[0xff, 0xff]);
    assert!(result.is_err());
}
