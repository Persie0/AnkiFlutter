import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:anki_flutter/app/anki_flutter_app.dart';
import 'package:anki_flutter/core/backend/anki_backend_client.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pb.dart';
import 'package:anki_flutter/core/backend/native/ffi_native_anki_bindings.dart';
import 'package:anki_flutter/core/backend/native/native_library_loader.dart';
import 'package:anki_flutter/features/collection/collection_location.dart';
import 'package:anki_flutter/features/collection/collection_session.dart';
import 'package:anki_flutter/features/decks/anki_deck_repository.dart';
import 'package:anki_flutter/features/decks/deck_list_controller.dart';
import 'package:anki_flutter/features/decks/deck_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('real backend loads Default deck and opens its overview', (
    tester,
  ) async {
    const overridePath = String.fromEnvironment('ANKIFLUTTER_NATIVE_LIB');
    final libraryPath = resolveNativeLibraryPath(
      platform: defaultTargetPlatform,
      executablePath: Platform.resolvedExecutable,
      environmentOverride: overridePath,
    );
    final DynamicLibrary library = openNativeLibrary(libraryPath);
    final bindings = FfiNativeAnkiBindings.fromLibrary(library);
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
      unixSeconds: () => DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
    final controller = DeckListController(repository: repository);
    final temp = await Directory.systemTemp.createTemp(
      'anki_flutter_real_backend_',
    );
    final collectionPath = '${temp.path}${Platform.pathSeparator}collection.anki2';
    final location = CollectionLocation.fromCollectionPath(collectionPath);
    await Directory(location.mediaFolderPath).create(recursive: true);

    addTearDown(() async {
      await session.close();
      controller.dispose();
      client.dispose();
      await temp.delete(recursive: true);
    });

    await tester.pumpWidget(
      AnkiFlutterApp(
        home: DeckListPage(
          controller: controller,
          pickCollection: () async => collectionPath,
          openCollection: (path) => session.open(
            CollectionLocation.fromCollectionPath(path),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();

    expect(find.text('Default'), findsOneWidget);
    await tester.tap(find.text('Default'));
    await tester.pumpAndSettle();

    expect(find.text('Default'), findsOneWidget);
    expect(find.text('New 0'), findsOneWidget);
    expect(find.text('Learn 0'), findsOneWidget);
    expect(find.text('Review 0'), findsOneWidget);
    expect(find.text('Study'), findsOneWidget);
  });
}
