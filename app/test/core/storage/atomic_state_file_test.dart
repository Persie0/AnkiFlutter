import 'dart:io';

import 'package:anki_flutter/core/storage/atomic_state_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory root;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('ankiflutter-atomic-state-');
  });

  tearDown(() async {
    if (await root.exists()) {
      await root.delete(recursive: true);
    }
  });

  test('creates parent folders and replaces only completed state files', () async {
    final file = File('${root.path}/support/nested/state.json');

    await writeAtomicState(file, '{"value":1}');
    expect(await file.readAsString(), '{"value":1}');
    await writeAtomicState(file, '{"value":2}');
    expect(await file.readAsString(), '{"value":2}');
    expect(
      file.parent.listSync().where(
        (item) => item.path.contains('.ankiflutter-state-'),
      ),
      isEmpty,
    );
  });

  test('failed promotion removes staging without deleting the destination', () async {
    final target = Directory('${root.path}/state.json');
    await target.create();
    await expectLater(
      writeAtomicState(File(target.path), '{"value":3}'),
      throwsA(isA<FileSystemException>()),
    );
    expect(await target.exists(), isTrue);
    expect(
      root.listSync().where(
        (item) => item.path.contains('.ankiflutter-state-'),
      ),
      isEmpty,
    );
  });
}
