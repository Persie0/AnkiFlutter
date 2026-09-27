import 'dart:ffi';
import 'dart:io';

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
import 'package:anki_flutter/features/reviewer/media/review_media_server.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('real backend loads Default deck and opens its overview', (
    tester,
  ) async {
    const overridePath = String.fromEnvironment('ANKIFLUTTER_NATIVE_LIB');
    final DynamicLibrary library = openPlatformNativeLibrary(
      platform: defaultTargetPlatform,
      executablePath: Platform.resolvedExecutable,
      environmentOverride: overridePath,
    );
    final bindings = FfiNativeAnkiBindings.fromLibrary(library);
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
      unixSeconds: () => DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
    final controller = DeckListController(repository: repository);
    final sandboxHome =
        Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        Directory.current.path;
    final sandboxTemp = Directory('$sandboxHome${Platform.pathSeparator}tmp');
    await sandboxTemp.create(recursive: true);
    final temp = await sandboxTemp.createTemp('anki_flutter_real_backend_');
    final collectionPath =
        '${temp.path}${Platform.pathSeparator}collection.anki2';
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
          backend: client,
          pickCollection: () async => collectionPath,
          openCollection: (path) =>
              session.open(CollectionLocation.fromCollectionPath(path)),
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

  testWidgets('real backend starts a review session from the deck overview', (
    tester,
  ) async {
    const overridePath = String.fromEnvironment('ANKIFLUTTER_NATIVE_LIB');
    final bindings = FfiNativeAnkiBindings.fromLibrary(
      openPlatformNativeLibrary(
        platform: defaultTargetPlatform,
        executablePath: Platform.resolvedExecutable,
        environmentOverride: overridePath,
      ),
    );
    final client = AnkiBackendClient.create(
      bindings: bindings,
      init: Uint8List.fromList(BackendInit(server: false).writeToBuffer()),
    );
    final session = CollectionSession(
      backend: client,
      mediaServer: ReviewMediaServer(),
    );
    final controller = DeckListController(
      repository: AnkiDeckRepository(
        backend: client,
        unixSeconds: () => DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
    final sandboxHome = Platform.environment['HOME'] ?? Directory.current.path;
    final temp = await Directory('$sandboxHome${Platform.pathSeparator}tmp')
        .createTemp('anki_flutter_reviewer_');
    final location = CollectionLocation.fromCollectionPath(
      '${temp.path}${Platform.pathSeparator}collection.anki2',
    );
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
          backend: client,
          pickCollection: () async => location.collectionPath,
          openCollection: (_) => session.open(location),
        ),
      ),
    );
    await tester.tap(find.text('Open Anki Collection'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Default'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();
    expect(find.text('You have finished this deck for now.'), findsOneWidget);
  });
}
