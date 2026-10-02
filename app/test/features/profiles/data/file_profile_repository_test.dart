import 'dart:io';

import 'package:anki_flutter/features/profiles/data/file_profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory tempDirectory;
  late FileProfileRepository repository;

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp('ankiflutter_profiles_');
    repository = FileProfileRepository(
      profilesDirectory: Directory('${tempDirectory.path}/profiles'),
      registryFile: File('${tempDirectory.path}/profiles.json'),
      pathSeparator: Platform.pathSeparator,
    );
  });

  tearDown(() async {
    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  test('creates a named app-owned profile with an Anki collection path', () async {
    final profile = await repository.create('Personal');

    expect(profile.name, 'Personal');
    expect(profile.collectionPath, endsWith('collection.anki2'));
    expect(Directory(profile.profileDirectory).existsSync(), isTrue);
    expect(await repository.list(), [profile]);
  });

  test('rejects duplicate profile names case-insensitively', () async {
    await repository.create('Personal');

    expect(
      () => repository.create('personal'),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('registers external collection without moving user data', () async {
    final external = File('${tempDirectory.path}/outside.anki2');
    await external.writeAsBytes([1, 2, 3]);

    final profile = await repository.registerExternal(
      name: 'Imported',
      collectionPath: external.path,
    );

    expect(profile.isManaged, isFalse);
    expect(profile.collectionPath, external.path);
    expect(await external.readAsBytes(), [1, 2, 3]);
  });

  test('rename changes display name without moving collection data', () async {
    final profile = await repository.create('Personal');

    final renamed = await repository.rename(profile.id, 'University');

    expect(renamed.name, 'University');
    expect(renamed.collectionPath, profile.collectionPath);
    expect(Directory(profile.profileDirectory).existsSync(), isTrue);
  });

  test('remove forgets profile but never deletes its collection', () async {
    final profile = await repository.create('Disposable');
    final collection = File(profile.collectionPath);
    await collection.writeAsBytes([7, 8, 9]);

    await repository.remove(profile.id);

    expect(await repository.list(), isEmpty);
    expect(await collection.readAsBytes(), [7, 8, 9]);
  });

  test('recovers from malformed registry as an empty profile list', () async {
    await repository.registryFile.parent.create(recursive: true);
    await repository.registryFile.writeAsString('{broken json');

    expect(await repository.list(), isEmpty);
  });
}
