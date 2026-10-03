use std::error::Error;
use std::fmt::Write as _;
use std::fs;
use std::path::PathBuf;

use anki_proto_gen::{descriptors_path, get_services, BackendService, Method};
use prost_reflect::DescriptorPool;

const OPERATIONS: &[(&str, &str, &str)] = &[
    (
        "OPEN_COLLECTION",
        "BackendCollectionService",
        "open_collection",
    ),
    (
        "CLOSE_COLLECTION",
        "BackendCollectionService",
        "close_collection",
    ),
    ("DECK_TREE", "BackendDecksService", "deck_tree"),
    (
        "SET_CURRENT_DECK",
        "BackendDecksService",
        "set_current_deck",
    ),
    (
        "GET_QUEUED_CARDS",
        "BackendSchedulerService",
        "get_queued_cards",
    ),
    (
        "DESCRIBE_NEXT_STATES",
        "BackendSchedulerService",
        "describe_next_states",
    ),
    ("ANSWER_CARD", "BackendSchedulerService", "answer_card"),
    (
        "STATE_IS_LEECH",
        "BackendSchedulerService",
        "state_is_leech",
    ),
    (
        "BURY_OR_SUSPEND_CARDS",
        "BackendSchedulerService",
        "bury_or_suspend_cards",
    ),
    (
        "GET_UNDO_STATUS",
        "BackendCollectionService",
        "get_undo_status",
    ),
    ("UNDO", "BackendCollectionService", "undo"),
    (
        "RENDER_EXISTING_CARD",
        "BackendCardRenderingService",
        "render_existing_card",
    ),
    (
        "EXTRACT_AV_TAGS",
        "BackendCardRenderingService",
        "extract_av_tags",
    ),
    (
        "ALL_TTS_VOICES",
        "BackendCardRenderingService",
        "all_tts_voices",
    ),
    (
        "WRITE_TTS_STREAM",
        "BackendCardRenderingService",
        "write_tts_stream",
    ),
    (
        "GET_DECK_CONFIGS_FOR_UPDATE",
        "BackendDeckConfigService",
        "get_deck_configs_for_update",
    ),
    (
        "ENCODE_IRI_PATHS",
        "BackendCardRenderingService",
        "encode_iri_paths",
    ),
    ("RENAME_DECK", "BackendDecksService", "rename_deck"),
    ("REMOVE_DECKS", "BackendDecksService", "remove_decks"),
    (
        "GET_NOTETYPE_NAMES_AND_COUNTS",
        "BackendNotetypesService",
        "get_notetype_names_and_counts",
    ),
    ("NEW_NOTE", "BackendNotesService", "new_note"),
    ("ADD_NOTE", "BackendNotesService", "add_note"),
    ("GET_NOTETYPE", "BackendNotetypesService", "get_notetype"),
    (
        "DEFAULTS_FOR_ADDING",
        "BackendNotesService",
        "defaults_for_adding",
    ),
    ("SEARCH_CARDS", "BackendSearchService", "search_cards"),
    (
        "BROWSER_ROW_FOR_ID",
        "BackendSearchService",
        "browser_row_for_id",
    ),
    (
        "SET_ACTIVE_BROWSER_COLUMNS",
        "BackendSearchService",
        "set_active_browser_columns",
    ),
    ("GET_CONFIG_JSON", "BackendConfigService", "get_config_json"),
    ("GET_NOTE", "BackendNotesService", "get_note"),
    ("UPDATE_NOTES", "BackendNotesService", "update_notes"),
    ("GET_CARD", "BackendCardsService", "get_card"),
    ("REMOVE_CARDS", "BackendCardsService", "remove_cards"),
    (
        "ALL_BROWSER_COLUMNS",
        "BackendSearchService",
        "all_browser_columns",
    ),
    ("NEW_DECK", "BackendDecksService", "new_deck"),
    ("ADD_DECK", "BackendDecksService", "add_deck"),
    (
        "UPDATE_NOTETYPE",
        "BackendNotetypesService",
        "update_notetype",
    ),
    ("ADD_NOTETYPE", "BackendNotetypesService", "add_notetype"),
    (
        "REMOVE_NOTETYPE",
        "BackendNotetypesService",
        "remove_notetype",
    ),
    (
        "GET_IMPORT_ANKI_PACKAGE_PRESETS",
        "BackendImportExportService",
        "get_import_anki_package_presets",
    ),
    (
        "IMPORT_ANKI_PACKAGE",
        "BackendImportExportService",
        "import_anki_package",
    ),
    (
        "EXPORT_ANKI_PACKAGE",
        "BackendImportExportService",
        "export_anki_package",
    ),
    (
        "CUSTOM_STUDY_DEFAULTS",
        "BackendSchedulerService",
        "custom_study_defaults",
    ),
    ("CUSTOM_STUDY", "BackendSchedulerService", "custom_study"),
    ("UNBURY_DECK", "BackendSchedulerService", "unbury_deck"),
    (
        "UPDATE_DECK_CONFIGS",
        "BackendDeckConfigService",
        "update_deck_configs",
    ),
    ("SYNC_LOGIN", "BackendSyncService", "sync_login"),
    ("SYNC_STATUS", "BackendSyncService", "sync_status"),
    ("SYNC_COLLECTION", "BackendSyncService", "sync_collection"),
    (
        "FULL_UPLOAD_OR_DOWNLOAD",
        "BackendSyncService",
        "full_upload_or_download",
    ),
    ("SYNC_MEDIA", "BackendSyncService", "sync_media"),
    (
        "MEDIA_SYNC_STATUS",
        "BackendSyncService",
        "media_sync_status",
    ),
    ("ABORT_SYNC", "BackendSyncService", "abort_sync"),
    ("ABORT_MEDIA_SYNC", "BackendSyncService", "abort_media_sync"),
    (
        "SET_CUSTOM_CERTIFICATE",
        "BackendSyncService",
        "set_custom_certificate",
    ),
    ("ADD_MEDIA_FILE", "BackendMediaService", "add_media_file"),
    (
        "ADD_MEDIA_FROM_URL",
        "BackendMediaService",
        "add_media_from_url",
    ),
    ("CHECK_MEDIA", "BackendMediaService", "check_media"),
    (
        "GET_ABSOLUTE_MEDIA_PATH",
        "BackendMediaService",
        "get_absolute_media_path",
    ),
    ("ADD_NOTE_TAGS", "BackendTagsService", "add_note_tags"),
    ("REMOVE_NOTE_TAGS", "BackendTagsService", "remove_note_tags"),
    ("SET_DECK", "BackendCardsService", "set_deck"),
    ("SET_FLAG", "BackendCardsService", "set_flag"),
    ("ALL_TAGS", "BackendTagsService", "all_tags"),
    ("GRAPHS", "BackendStatsService", "graphs"),
    ("GET_PREFERENCES", "BackendConfigService", "get_preferences"),
    ("SET_PREFERENCES", "BackendConfigService", "set_preferences"),
    (
        "NOTE_FIELDS_CHECK",
        "BackendNotesService",
        "note_fields_check",
    ),
    (
        "COMPARE_ANSWER",
        "BackendCardRenderingService",
        "compare_answer",
    ),
    (
        "EXTRACT_CLOZE_FOR_TYPING",
        "BackendCardRenderingService",
        "extract_cloze_for_typing",
    ),
    ("REMOVE_NOTES", "BackendNotesService", "remove_notes"),
    (
        "SCHEDULE_CARDS_AS_NEW",
        "BackendSchedulerService",
        "schedule_cards_as_new",
    ),
    (
        "SCHEDULE_CARDS_AS_NEW_DEFAULTS",
        "BackendSchedulerService",
        "schedule_cards_as_new_defaults",
    ),
];

fn main() -> Result<(), Box<dyn Error>> {
    let descriptors = descriptors_path();
    println!("cargo:rerun-if-changed={}", descriptors.display());
    let pool = DescriptorPool::decode(fs::read(descriptors)?.as_ref())?;
    let (_, services) = get_services(&pool);

    let mut generated = String::new();
    for &(constant, service, method) in OPERATIONS {
        let (service_index, method_index) = operation(&services, service, method)?;
        writeln!(
            generated,
            "pub const {constant}: OperationIndex = OperationIndex {{ service: {service_index}, method: {method_index} }};"
        )?;
    }

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
