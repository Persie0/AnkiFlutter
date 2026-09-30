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
    let set_current_deck = operation(&services, "BackendDecksService", "set_current_deck")?;
    let get_queued_cards = operation(&services, "BackendSchedulerService", "get_queued_cards")?;
    let describe_next_states =
        operation(&services, "BackendSchedulerService", "describe_next_states")?;
    let answer_card = operation(&services, "BackendSchedulerService", "answer_card")?;
    let state_is_leech = operation(&services, "BackendSchedulerService", "state_is_leech")?;
    let bury_or_suspend_cards = operation(
        &services,
        "BackendSchedulerService",
        "bury_or_suspend_cards",
    )?;
    let get_undo_status = operation(&services, "BackendCollectionService", "get_undo_status")?;
    let undo = operation(&services, "BackendCollectionService", "undo")?;
    let render_existing_card = operation(
        &services,
        "BackendCardRenderingService",
        "render_existing_card",
    )?;
    let extract_av_tags = operation(&services, "BackendCardRenderingService", "extract_av_tags")?;
    let all_tts_voices = operation(&services, "BackendCardRenderingService", "all_tts_voices")?;
    let write_tts_stream = operation(&services, "BackendCardRenderingService", "write_tts_stream")?;
    let get_deck_configs_for_update = operation(
        &services,
        "BackendDeckConfigService",
        "get_deck_configs_for_update",
    )?;
    let encode_iri_paths = operation(&services, "BackendCardRenderingService", "encode_iri_paths")?;
    let new_deck = operation(&services, "BackendDecksService", "new_deck")?;
    let add_deck = operation(&services, "BackendDecksService", "add_deck")?;
    let rename_deck = operation(&services, "BackendDecksService", "rename_deck")?;
    let remove_decks = operation(&services, "BackendDecksService", "remove_decks")?;
    let get_notetype_names_and_counts = operation(
        &services,
        "BackendNotetypesService",
        "get_notetype_names_and_counts",
    )?;
    let get_notetype = operation(&services, "BackendNotetypesService", "get_notetype")?;
    let defaults_for_adding = operation(&services, "BackendNotesService", "defaults_for_adding")?;
    let new_note = operation(&services, "BackendNotesService", "new_note")?;
    let add_note = operation(&services, "BackendNotesService", "add_note")?;
    let search_cards = operation(&services, "BackendSearchService", "search_cards")?;
    let browser_row_for_id = operation(&services, "BackendSearchService", "browser_row_for_id")?;
    let set_active_browser_columns = operation(
        &services,
        "BackendSearchService",
        "set_active_browser_columns",
    )?;
    let get_config_json = operation(&services, "BackendConfigService", "get_config_json")?;
    let get_note = operation(&services, "BackendNotesService", "get_note")?;
    let update_notes = operation(&services, "BackendNotesService", "update_notes")?;
    let get_card = operation(&services, "BackendCardsService", "get_card")?;
    let remove_cards = operation(&services, "BackendCardsService", "remove_cards")?;
    let all_browser_columns = operation(&services, "BackendSearchService", "all_browser_columns")?;

    let generated = format!(
        "pub const OPEN_COLLECTION: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const CLOSE_COLLECTION: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const DECK_TREE: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const SET_CURRENT_DECK: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_QUEUED_CARDS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const DESCRIBE_NEXT_STATES: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const ANSWER_CARD: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const STATE_IS_LEECH: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const BURY_OR_SUSPEND_CARDS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_UNDO_STATUS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const UNDO: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const RENDER_EXISTING_CARD: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const EXTRACT_AV_TAGS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const ALL_TTS_VOICES: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const WRITE_TTS_STREAM: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_DECK_CONFIGS_FOR_UPDATE: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const ENCODE_IRI_PATHS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const RENAME_DECK: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const REMOVE_DECKS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_NOTETYPE_NAMES_AND_COUNTS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const NEW_NOTE: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const ADD_NOTE: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_NOTETYPE: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const DEFAULTS_FOR_ADDING: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const SEARCH_CARDS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const BROWSER_ROW_FOR_ID: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const SET_ACTIVE_BROWSER_COLUMNS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_CONFIG_JSON: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_NOTE: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const UPDATE_NOTES: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const GET_CARD: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const REMOVE_CARDS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const ALL_BROWSER_COLUMNS: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const NEW_DECK: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n\
         pub const ADD_DECK: OperationIndex = OperationIndex {{ service: {}, method: {} }};\n",
        open_collection.0,
        open_collection.1,
        close_collection.0,
        close_collection.1,
        deck_tree.0,
        deck_tree.1,
        set_current_deck.0,
        set_current_deck.1,
        get_queued_cards.0,
        get_queued_cards.1,
        describe_next_states.0,
        describe_next_states.1,
        answer_card.0,
        answer_card.1,
        state_is_leech.0,
        state_is_leech.1,
        bury_or_suspend_cards.0,
        bury_or_suspend_cards.1,
        get_undo_status.0,
        get_undo_status.1,
        undo.0,
        undo.1,
        render_existing_card.0,
        render_existing_card.1,
        extract_av_tags.0,
        extract_av_tags.1,
        all_tts_voices.0,
        all_tts_voices.1,
        write_tts_stream.0,
        write_tts_stream.1,
        get_deck_configs_for_update.0,
        get_deck_configs_for_update.1,
        encode_iri_paths.0,
        encode_iri_paths.1,
        rename_deck.0,
        rename_deck.1,
        remove_decks.0,
        remove_decks.1,
        get_notetype_names_and_counts.0,
        get_notetype_names_and_counts.1,
        new_note.0,
        new_note.1,
        add_note.0,
        add_note.1,
        get_notetype.0,
        get_notetype.1,
        defaults_for_adding.0,
        defaults_for_adding.1,
        search_cards.0,
        search_cards.1,
        browser_row_for_id.0,
        browser_row_for_id.1,
        set_active_browser_columns.0,
        set_active_browser_columns.1,
        get_config_json.0,
        get_config_json.1,
        get_note.0,
        get_note.1,
        update_notes.0,
        update_notes.1,
        get_card.0,
        get_card.1,
        remove_cards.0,
        remove_cards.1,
        all_browser_columns.0,
        all_browser_columns.1,
        new_deck.0,
        new_deck.1,
        add_deck.0,
        add_deck.1,
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
