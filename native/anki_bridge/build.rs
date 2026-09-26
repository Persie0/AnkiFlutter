use std::error::Error;
use std::fs;
use std::path::PathBuf;

use anki_proto_gen::{descriptors_path, get_services, BackendService, Method};
use prost_reflect::DescriptorPool;

fn main() -> Result<(), Box<dyn Error>> {
    let descriptors = descriptors_path();
    println!("cargo:rerun-if-changed={}", descriptors.display());
    let pool = DescriptorPool::decode(fs::read(descriptors)?.as_ref())?;
    let (_, services) = get_services(&pool);

    let open_collection = operation(&services, "BackendCollectionService", "open_collection")?;
    let close_collection = operation(&services, "BackendCollectionService", "close_collection")?;
    let deck_tree = operation(&services, "BackendDecksService", "deck_tree")?;

    let generated = format!(
        "pub const OPEN_COLLECTION: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const CLOSE_COLLECTION: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const DECK_TREE: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n",
        open_collection.0,
        open_collection.1,
        close_collection.0,
        close_collection.1,
        deck_tree.0,
        deck_tree.1,
    );

    fs::write(
        PathBuf::from(std::env::var("OUT_DIR")?).join("operations_generated.rs"),
        generated,
    )?;
    Ok(())
}

fn operation(
    services: &[BackendService],
    service_name: &str,
    method_name: &str,
) -> Result<(u32, u32), Box<dyn Error>> {
    let service = services
        .iter()
        .find(|service| service.name == service_name)
        .ok_or_else(|| format!("missing Anki service {service_name}"))?;
    let method: &Method = service
        .all_methods()
        .find(|method| method.name == method_name)
        .ok_or_else(|| format!("missing Anki method {service_name}.{method_name}"))?;
    Ok((service.index as u32, method.index as u32))
}
