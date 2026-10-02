import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_client.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pb.dart';
import 'package:anki_flutter/core/backend/native/ffi_native_anki_bindings.dart';
import 'package:anki_flutter/core/backend/native/native_anki_bindings.dart';
import 'package:anki_flutter/core/backend/native/native_library_loader.dart';
import 'package:anki_flutter/features/collection/collection_location.dart';
import 'package:anki_flutter/features/collection/collection_session.dart';
import 'package:anki_flutter/features/collection/mobile_collection_storage.dart';
import 'package:anki_flutter/features/collection/recent_collection_store.dart';
import 'package:anki_flutter/features/decks/anki_deck_repository.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:anki_flutter/features/profiles/data/file_profile_repository.dart';
import 'package:anki_flutter/features/profiles/profile_picker_dialog.dart';
import 'package:anki_flutter/features/reviewer/audio/media_kit_review_audio_player_adapter.dart';
import 'package:anki_flutter/features/reviewer/audio/native_media_kit_player_port.dart';
import 'package:anki_flutter/features/reviewer/audio/review_audio_service.dart';
import 'package:anki_flutter/features/reviewer/audio/review_tts_service.dart';
import 'package:anki_flutter/features/reviewer/data/anki_card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/data/anki_review_repository.dart';
import 'package:anki_flutter/features/reviewer/media/review_media_server.dart';
import 'package:anki_flutter/features/reviewer/review_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef NativeBindingsLoader = NativeAnkiBindings Function();
typedef AnkiDesktopRoot = AnkiAppRoot;

class AnkiAppRoot extends StatefulWidget {
  const AnkiAppRoot({this.bindingsLoader, this.pickCollection, super.key});

  final NativeBindingsLoader? bindingsLoader;
  final CollectionPicker? pickCollection;

  @override
  State<AnkiAppRoot> createState() => _AnkiAppRootState();
}

class _AnkiAppRootState extends State<AnkiAppRoot> {
  AnkiBackendClient? _client;
  CollectionSession? _session;
  DeckListController? _controller;
  Object? _startupError;

  @override
  void initState() {
    super.initState();
    _initializeBackend();
  }

  void _initializeBackend() {
    try {
      final bindings = (widget.bindingsLoader ?? _loadNativeBindings)();
      final init = BackendInit(
        preferredLangs: [PlatformDispatcher.instance.locale.toLanguageTag()],
        server: false,
      );
      final client = AnkiBackendClient.create(
        bindings: bindings,
        init: Uint8List.fromList(init.writeToBuffer()),
      );
      final session = CollectionSession(
        backend: client,
        mediaServer: ReviewMediaServer(),
      );
      final repository = AnkiDeckRepository(
        backend: client,
        unixSeconds: () =>
            DateTime.now().millisecondsSinceEpoch ~/
            Duration.millisecondsPerSecond,
      );

      _client = client;
      _session = session;
      _controller = DeckListController(repository: repository);
    } catch (error) {
      _startupError = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final error = _startupError;
    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('AnkiFlutter')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 40),
                const SizedBox(height: 12),
                Text(
                  'Anki backend unavailable',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(error.toString(), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    }

    final controller = _controller;
    final session = _session;
    if (controller == null || session == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DeckListPage(
      controller: controller,
      backend: _client!,
      mediaBaseUri: () => session.mediaBaseUri,
      reviewControllerBuilder: () => ReviewController(
        repository: AnkiReviewRepository(backend: _client!),
        renderer: AnkiCardRenderRepository(backend: _client!),
        wallClockMillis: () => DateTime.now().millisecondsSinceEpoch,
        stopwatchFactory: Stopwatch.new,
        audio: PlayerBackedReviewAudioService(
          player: MediaKitReviewAudioPlayerAdapter(
            player: NativeMediaKitPlayerPort(),
          ),
        ),
        tts: AnkiReviewTtsService(
          backend: _client!,
          tempDirectoryProvider: () async => Directory.systemTemp,
        ),
        mediaUriFor: (filename) {
          final baseUri = session.mediaBaseUri;
          if (baseUri == null) {
            throw StateError('The collection media server is not running.');
          }
          final encodedFilename = filename
              .split('/')
              .map(Uri.encodeComponent)
              .join('/');
          return baseUri.resolve(encodedFilename);
        },
      ),
      pickCollection:
          widget.pickCollection ?? () => _pickAnkiCollection(context),
      recentCollectionsStore: FileRecentCollectionStore(),
      openCollection: (path) =>
          session.open(CollectionLocation.fromCollectionPath(path)),
      closeCollection: session.close,
      collectionIsOpen: () => session.isOpen,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    final client = _client;
    final session = _session;
    if (client != null && session != null) {
      unawaited(_closeSessionAndDisposeClient(session, client));
    } else {
      client?.dispose();
    }
    super.dispose();
  }
}

NativeAnkiBindings _loadNativeBindings() {
  const overridePath = String.fromEnvironment('ANKIFLUTTER_NATIVE_LIB');
  final library = openPlatformNativeLibrary(
    platform: defaultTargetPlatform,
    executablePath: Platform.resolvedExecutable,
    environmentOverride: overridePath,
  );
  return FfiNativeAnkiBindings.fromLibrary(library);
}

Future<String?> _pickAnkiCollection(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (_) => ProfilePickerDialog(
      repository: FileProfileRepository(
        profilesDirectory: ApplicationDataPaths.profilesDirectory,
        registryFile: ApplicationDataPaths.profileRegistryFile,
        pathSeparator: Platform.pathSeparator,
      ),
      pickExistingCollection: _browseAnkiCollection,
    ),
  );
}

Future<String?> _browseAnkiCollection() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final selection = await FilePicker.pickFile(
      dialogTitle: 'Choose an Anki collection',
      type: FileType.custom,
      allowedExtensions: const ['anki2'],
    );
    if (selection == null) {
      return null;
    }
    final selectedFile = await _materializePickedFile(selection);
    return MobileCollectionStorage(
      collectionsDirectory: ApplicationDataPaths.collectionsDirectory,
    ).copySelectedCollection(selectedFile);
  }

  final directory = await FilePicker.getDirectoryPath(
    dialogTitle: 'Choose an Anki profile folder',
  );
  if (directory == null) {
    return null;
  }
  return CollectionLocation.collectionPathInProfile(
    directory,
    pathSeparator: Platform.pathSeparator,
  );
}

Future<File> _materializePickedFile(PlatformFile selection) async {
  final path = selection.path;
  if (path != null && path.isNotEmpty) {
    return File(path);
  }

  final directory = await Directory.systemTemp.createTemp('ankiflutter-pick-');
  final fallback = File(
    '${directory.path}${Platform.pathSeparator}${selection.name}',
  );
  await fallback.writeAsBytes(await selection.readAsBytes(), flush: true);
  return fallback;
}

Future<void> _closeSessionAndDisposeClient(
  CollectionSession session,
  AnkiBackendClient client,
) async {
  try {
    await session.close();
  } catch (_) {
    // Shutdown must still release the native handle if closing the collection
    // fails because the process or filesystem is already going away.
  } finally {
    client.dispose();
  }
}
