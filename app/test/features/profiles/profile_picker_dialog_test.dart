import 'package:anki_flutter/features/profiles/data/file_profile_repository.dart';
import 'package:anki_flutter/features/profiles/profile_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('returns the selected saved profile collection', (tester) async {
    final repository = _ProfileRepository([
      const AnkiProfile(
        id: 'p1',
        name: 'Personal',
        collectionPath: '/profiles/p1/collection.anki2',
        profileDirectory: '/profiles/p1',
        isManaged: true,
      ),
    ]);
    String? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => FilledButton(
            onPressed: () async {
              selected = await showDialog<String>(
                context: context,
                builder: (_) => ProfilePickerDialog(
                  repository: repository,
                  pickExistingCollection: () async => null,
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Personal'));
    await tester.pumpAndSettle();

    expect(selected, '/profiles/p1/collection.anki2');
  });

  testWidgets('creates a profile and immediately selects it', (tester) async {
    final repository = _ProfileRepository(const []);
    String? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => FilledButton(
            onPressed: () async {
              selected = await showDialog<String>(
                context: context,
                builder: (_) => ProfilePickerDialog(
                  repository: repository,
                  pickExistingCollection: () async => null,
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('new-profile')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('profile-name')), 'Study');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(repository.createdName, 'Study');
    expect(selected, '/managed/Study/collection.anki2');
  });

  testWidgets('browsed collection is registered before selection', (tester) async {
    final repository = _ProfileRepository(const []);
    String? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => FilledButton(
            onPressed: () async {
              selected = await showDialog<String>(
                context: context,
                builder: (_) => ProfilePickerDialog(
                  repository: repository,
                  pickExistingCollection: () async => '/outside/French.anki2',
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('browse-profile')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('profile-name')), findsOneWidget);
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(repository.externalPath, '/outside/French.anki2');
    expect(repository.externalName, 'French');
    expect(selected, '/outside/French.anki2');
  });
}

class _ProfileRepository implements ProfileRepository {
  _ProfileRepository(List<AnkiProfile> profiles) : _profiles = [...profiles];

  final List<AnkiProfile> _profiles;
  String? createdName;
  String? externalName;
  String? externalPath;

  @override
  Future<List<AnkiProfile>> list() async => [..._profiles];

  @override
  Future<AnkiProfile> create(String name) async {
    createdName = name;
    final profile = AnkiProfile(
      id: 'created',
      name: name,
      collectionPath: '/managed/$name/collection.anki2',
      profileDirectory: '/managed/$name',
      isManaged: true,
    );
    _profiles.add(profile);
    return profile;
  }

  @override
  Future<AnkiProfile> registerExternal({
    required String name,
    required String collectionPath,
  }) async {
    externalName = name;
    externalPath = collectionPath;
    final profile = AnkiProfile(
      id: 'external',
      name: name,
      collectionPath: collectionPath,
      profileDirectory: '/outside',
      isManaged: false,
    );
    _profiles.add(profile);
    return profile;
  }

  @override
  Future<AnkiProfile> rename(String id, String name) async {
    final index = _profiles.indexWhere((profile) => profile.id == id);
    final current = _profiles[index];
    final renamed = AnkiProfile(
      id: current.id,
      name: name,
      collectionPath: current.collectionPath,
      profileDirectory: current.profileDirectory,
      isManaged: current.isManaged,
    );
    _profiles[index] = renamed;
    return renamed;
  }

  @override
  Future<void> remove(String id) async {
    _profiles.removeWhere((profile) => profile.id == id);
  }
}
