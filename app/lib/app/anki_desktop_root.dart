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
import 'package:anki_flutter/features/decks/anki_deck_repository.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef NativeBindingsLoader = NativeAnkiBindings Function();

class AnkiDesktopRoot extends StatefulWidget {
  const AnkiDesktopRoot({
    this.bindingsLoader,
    this.pickCollection,
    super.key,
  });

  final NativeBindingsLoader? bindingsLoader;
  final CollectionPicker? pickCollection;

  @override
  State<AnkiDesktopRoot> createState() => _AnkiDesktopRootState();
}

class _AnkiDesktopRootState extends State<AnkiDesktopRoot> {
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
        preferredLangs: [
          PlatformDispatcher.instance.locale.toLanguageTag(),
        ],
        server: false,
      );
      final client = AnkiBackendClient.create(
        bindings: bindings,
        init: Uint8List.fromList(init.writeToBuffer()),
      );
      final session = CollectionSession(backend: client);
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
      pickCollection: widget.pickCollection ?? _pickAnkiCollection,
      openCollection: (path) => session.open(
        CollectionLocation.fromCollectionPath(path),
      ),
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
  final libraryPath = resolveNativeLibraryPath(
    platform: defaultTargetPlatform,
    executablePath: Platform.resolvedExecutable,
    environmentOverride: overridePath,
  );
  final library = openNativeLibrary(libraryPath);
  return FfiNativeAnkiBindings.fromLibrary(library);
}

Future<String?> _pickAnkiCollection() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: const ['anki2'],
    allowMultiple: false,
  );
  if (result == null || result.files.isEmpty) {
    return null;
  }
  return result.files.single.path;
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
