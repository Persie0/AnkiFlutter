import 'dart:io';

import 'package:anki_flutter/features/import_export/staged_package_import_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory root;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('ankiflutter-stage-test-');
  });
  tearDown(() async {
    if (await root.exists()) await root.delete(recursive: true);
  });

  test('stages import bytes in an owned temporary directory and removes them', () async {
    final store = StagedPackageImportStore(temporaryRoot: root);
    final path = await store.stage([1, 2, 3, 4]);
    final file = File(path);

    expect(await file.exists(), isTrue);
    expect(await file.readAsBytes(), [1, 2, 3, 4]);
    expect(file.uri.pathSegments.last, 'import.apkg');

    await store.release(path);

    expect(await file.exists(), isFalse);
    expect(await file.parent.exists(), isFalse);
  });

  test('cleanup never deletes packages not created by this store', () async {
    final store = StagedPackageImportStore(temporaryRoot: root);
    final external = File('${root.path}${Platform.pathSeparator}user.apkg');
    await external.writeAsBytes([7, 8]);

    await store.release(external.path);

    expect(await external.readAsBytes(), [7, 8]);
  });

  test('cleanup is idempotent and isolated across multiple staged imports', () async {
    final store = StagedPackageImportStore(temporaryRoot: root);
    final first = await store.stage([11]);
    final second = await store.stage([22]);

    await store.release(first);
    await store.release(first);

    expect(await File(first).exists(), isFalse);
    expect(await File(second).readAsBytes(), [22]);

    await store.release(second);
    expect(await File(second).exists(), isFalse);
  });
}
