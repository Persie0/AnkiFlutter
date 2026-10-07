import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart' as generic;
import 'package:anki_flutter/core/backend/generated/anki/media.pb.dart' as media;

abstract interface class MediaRepository {
  Future<String> addFile({
    required String desiredName,
    required Uint8List bytes,
  });
  Future<String> addFromUrl(String url);
  Future<media.CheckMediaResponse> checkMedia();
  Future<String> absolutePath(String filename);
}

/// Optional safe media-trash operations backed by Anki's own media service.
abstract interface class MediaTrashRepository {
  Future<void> trashMediaFiles(List<String> filenames);
  Future<void> restoreMediaTrash();
}

class AnkiMediaRepository implements MediaRepository, MediaTrashRepository {
  const AnkiMediaRepository({required this.backend});

  final BackendInvoker backend;

  @override
  Future<String> addFile({
    required String desiredName,
    required Uint8List bytes,
  }) async {
    final name = desiredName.trim();
    if (name.isEmpty) {
      throw ArgumentError.value(desiredName, 'desiredName', 'Filename is empty');
    }
    if (bytes.isEmpty) {
      throw ArgumentError.value(bytes, 'bytes', 'Media file is empty');
    }
    final response = await backend.invoke(
      BackendOperation.addMediaFile,
      Uint8List.fromList(
        media.AddMediaFileRequest(desiredName: name, data: bytes).writeToBuffer(),
      ),
    );
    final filename = generic.String.fromBuffer(response).val;
    if (filename.isEmpty) throw StateError('Anki did not return a media filename.');
    return filename;
  }

  @override
  Future<String> addFromUrl(String url) async {
    final value = url.trim();
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !(uri.scheme == 'http' || uri.scheme == 'https')) {
      throw ArgumentError.value(url, 'url', 'Enter an HTTP or HTTPS URL');
    }
    final response = await backend.invoke(
      BackendOperation.addMediaFromUrl,
      Uint8List.fromList(media.AddMediaFromUrlRequest(url: value).writeToBuffer()),
    );
    final result = media.AddMediaFromUrlResponse.fromBuffer(response);
    if (result.hasError() && result.error.isNotEmpty) {
      throw StateError(result.error);
    }
    if (!result.hasFilename() || result.filename.isEmpty) {
      throw StateError('Anki did not return a media filename.');
    }
    return result.filename;
  }

  @override
  Future<media.CheckMediaResponse> checkMedia() async {
    final response = await backend.invoke(
      BackendOperation.checkMedia,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
    return media.CheckMediaResponse.fromBuffer(response);
  }

  @override
  Future<void> trashMediaFiles(List<String> filenames) async {
    final unique = filenames.toSet().toList(growable: false);
    if (unique.isEmpty) return;
    if (unique.any((filename) => filename.trim().isEmpty)) {
      throw ArgumentError.value(filenames, 'filenames', 'Empty media filename.');
    }
    await backend.invoke(
      BackendOperation.trashMediaFiles,
      Uint8List.fromList(
        media.TrashMediaFilesRequest(fnames: unique).writeToBuffer(),
      ),
    );
  }

  @override
  Future<void> restoreMediaTrash() async {
    await backend.invoke(
      BackendOperation.restoreMediaTrash,
      Uint8List.fromList(generic.Empty().writeToBuffer()),
    );
  }

  @override
  Future<String> absolutePath(String filename) async {
    final response = await backend.invoke(
      BackendOperation.getAbsoluteMediaPath,
      Uint8List.fromList(generic.String(val: filename).writeToBuffer()),
    );
    return generic.String.fromBuffer(response).val;
  }
}
