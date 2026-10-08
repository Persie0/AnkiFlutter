import 'dart:convert';
import 'dart:io';

import 'package:anki_flutter/core/storage/atomic_state_file.dart';

class AnkiProfile {
  const AnkiProfile({
    required this.id,
    required this.name,
    required this.collectionPath,
    required this.profileDirectory,
    required this.isManaged,
  });

  final String id;
  final String name;
  final String collectionPath;
  final String profileDirectory;
  final bool isManaged;

  @override
  bool operator ==(Object other) =>
      other is AnkiProfile &&
      other.id == id &&
      other.name == name &&
      other.collectionPath == collectionPath &&
      other.profileDirectory == profileDirectory &&
      other.isManaged == isManaged;

  @override
  int get hashCode => Object.hash(
        id,
        name,
        collectionPath,
        profileDirectory,
        isManaged,
      );
}

abstract interface class ProfileRepository {
  Future<List<AnkiProfile>> list();
  Future<AnkiProfile> create(String name);
  Future<AnkiProfile> registerExternal({
    required String name,
    required String collectionPath,
  });
  Future<AnkiProfile> rename(String id, String name);
  Future<void> remove(String id);
}

class FileProfileRepository implements ProfileRepository {
  FileProfileRepository({
    required this.profilesDirectory,
    required this.registryFile,
    required this.pathSeparator,
    int Function()? timestampMicros,
  }) : _timestampMicros =
           timestampMicros ?? (() => DateTime.now().microsecondsSinceEpoch);

  final Directory profilesDirectory;
  final File registryFile;
  final String pathSeparator;
  final int Function() _timestampMicros;

  @override
  Future<List<AnkiProfile>> list() async {
    try {
      final decoded = jsonDecode(await registryFile.readAsString());
      if (decoded is! Map<String, dynamic>) {
        return const [];
      }
      final profiles = decoded['profiles'];
      if (profiles is! List) {
        return const [];
      }
      return profiles
          .whereType<Map>()
          .map((entry) => _decodeProfile(Map<String, dynamic>.from(entry)))
          .whereType<AnkiProfile>()
          .toList(growable: false);
    } on FileSystemException {
      return const [];
    } on FormatException {
      return const [];
    }
  }

  @override
  Future<AnkiProfile> create(String name) async {
    final normalizedName = _validateName(name);
    final profiles = await list();
    _ensureUniqueName(profiles, normalizedName);

    final id = await _availableManagedId(
      '${_slug(normalizedName)}-${_timestampMicros()}',
      profiles,
    );
    final profileDirectory = Directory(
      '${profilesDirectory.path}$pathSeparator$id',
    );
    await profileDirectory.create(recursive: true);
    try {
      final profile = AnkiProfile(
        id: id,
        name: normalizedName,
        collectionPath:
            '${profileDirectory.path}${pathSeparator}collection.anki2',
        profileDirectory: profileDirectory.path,
        isManaged: true,
      );
      await _write([...profiles, profile]);
      return profile;
    } catch (_) {
      // The newly created managed folder must not become an orphan if the
      // registry cannot be committed. Never delete any pre-existing folder.
      if (await profileDirectory.exists()) {
        await profileDirectory.delete(recursive: true);
      }
      rethrow;
    }
  }

  @override
  Future<AnkiProfile> registerExternal({
    required String name,
    required String collectionPath,
  }) async {
    final normalizedName = _validateName(name);
    final path = collectionPath.trim();
    if (path.isEmpty || !RegExp(r'\.anki2$', caseSensitive: false).hasMatch(path)) {
      throw ArgumentError.value(
        collectionPath,
        'collectionPath',
        'Select an Anki .anki2 collection.',
      );
    }
    final profiles = await list();
    _ensureUniqueName(profiles, normalizedName);
    final existingPath = profiles.any((profile) => profile.collectionPath == path);
    if (existingPath) {
      throw ArgumentError.value(
        collectionPath,
        'collectionPath',
        'This collection is already registered.',
      );
    }
    final separatorIndex = path.lastIndexOf(pathSeparator);
    final profile = AnkiProfile(
      id: _availableExternalId('external-${_timestampMicros()}', profiles),
      name: normalizedName,
      collectionPath: path,
      profileDirectory:
          separatorIndex <= 0 ? '' : path.substring(0, separatorIndex),
      isManaged: false,
    );
    await _write([...profiles, profile]);
    return profile;
  }

  @override
  Future<AnkiProfile> rename(String id, String name) async {
    final normalizedName = _validateName(name);
    final profiles = await list();
    final index = profiles.indexWhere((profile) => profile.id == id);
    if (index < 0) {
      throw StateError('Profile not found: $id');
    }
    _ensureUniqueName(profiles, normalizedName, exceptId: id);
    final current = profiles[index];
    final renamed = AnkiProfile(
      id: current.id,
      name: normalizedName,
      collectionPath: current.collectionPath,
      profileDirectory: current.profileDirectory,
      isManaged: current.isManaged,
    );
    final updated = [...profiles];
    updated[index] = renamed;
    await _write(updated);
    return renamed;
  }

  @override
  Future<void> remove(String id) async {
    final profiles = await list();
    await _write(profiles.where((profile) => profile.id != id));
  }

  Future<void> _write(Iterable<AnkiProfile> profiles) async {
    await registryFile.parent.create(recursive: true);
    final payload = <String, Object>{
      'version': 1,
      'profiles': profiles
          .map(
            (profile) => <String, Object>{
              'id': profile.id,
              'name': profile.name,
              'collectionPath': profile.collectionPath,
              'profileDirectory': profile.profileDirectory,
              'isManaged': profile.isManaged,
            },
          )
          .toList(growable: false),
    };
    await writeAtomicState(registryFile, jsonEncode(payload));
  }

  AnkiProfile? _decodeProfile(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final collectionPath = json['collectionPath'];
    final profileDirectory = json['profileDirectory'];
    final isManaged = json['isManaged'];
    if (id is! String ||
        id.isEmpty ||
        name is! String ||
        name.isEmpty ||
        collectionPath is! String ||
        collectionPath.isEmpty ||
        profileDirectory is! String ||
        isManaged is! bool) {
      return null;
    }
    return AnkiProfile(
      id: id,
      name: name,
      collectionPath: collectionPath,
      profileDirectory: profileDirectory,
      isManaged: isManaged,
    );
  }

  String _validateName(String name) {
    final normalized = name.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Profile name must not be blank.');
    }
    if (normalized.length > 80) {
      throw ArgumentError.value(name, 'name', 'Profile name is too long.');
    }
    if (normalized.contains('/') || normalized.contains(r'\')) {
      throw ArgumentError.value(
        name,
        'name',
        'Profile name must not contain path separators.',
      );
    }
    return normalized;
  }

  void _ensureUniqueName(
    List<AnkiProfile> profiles,
    String name, {
    String? exceptId,
  }) {
    final normalized = name.toLowerCase();
    if (profiles.any(
      (profile) =>
          profile.id != exceptId && profile.name.toLowerCase() == normalized,
    )) {
      throw ArgumentError.value(name, 'name', 'Profile name already exists.');
    }
  }

  Future<String> _availableManagedId(
    String base,
    List<AnkiProfile> registered,
  ) async {
    for (var suffix = 0; suffix < 1000; suffix++) {
      final id = suffix == 0 ? base : '$base-$suffix';
      if (registered.any((profile) => profile.id == id)) continue;
      final path = '${profilesDirectory.path}$pathSeparator$id';
      if (!await Directory(path).exists() && !await File(path).exists()) {
        return id;
      }
    }
    throw StateError('Could not allocate an unused profile directory.');
  }

  String _availableExternalId(String base, List<AnkiProfile> registered) {
    for (var suffix = 0; suffix < 1000; suffix++) {
      final id = suffix == 0 ? base : '$base-$suffix';
      if (registered.every((profile) => profile.id != id)) return id;
    }
    throw StateError('Could not allocate an unused external profile ID.');
  }

  String _slug(String value) {
    final slug = value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return slug.isEmpty ? 'profile' : slug;
  }
}
