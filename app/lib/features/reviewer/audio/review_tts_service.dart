import 'dart:io';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/card_rendering.pb.dart'
    as card_rendering_pb;
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';

typedef ReviewTtsTempDirectoryProvider = Future<Directory> Function();

abstract interface class ReviewTtsService {
  Future<Uri?> materialize(ReviewTtsTag tag);

  Future<void> dispose();
}

class AnkiReviewTtsService implements ReviewTtsService {
  AnkiReviewTtsService({
    required this._backend,
    required this._tempDirectoryProvider,
  });

  final BackendInvoker _backend;
  final ReviewTtsTempDirectoryProvider _tempDirectoryProvider;

  // Each synthesis gets a private directory, so overlapping review sessions
  // never overwrite or delete another session's generated audio.
  final Set<Directory> _generatedDirectories = <Directory>{};
  final Set<Future<Uri?>> _inFlight = <Future<Uri?>>{};
  Future<void>? _disposeFuture;
  bool _disposed = false;

  @override
  Future<Uri?> materialize(ReviewTtsTag tag) {
    if (_disposed) return Future<Uri?>.value(null);
    final task = _materialize(tag);
    _inFlight.add(task);
    // Observe errors only for lifecycle tracking; the caller still receives
    // the original task's error.
    task.then<void>(
      (_) { _inFlight.remove(task); },
      onError: (Object error, StackTrace stackTrace) {
        _inFlight.remove(task);
      },
    );
    return task;
  }

  Future<Uri?> _materialize(ReviewTtsTag tag) async {
    final card_rendering_pb.AllTtsVoicesResponse response;
    try {
      final bytes = await _backend.invoke(
        BackendOperation.allTtsVoices,
        Uint8List.fromList(
          card_rendering_pb.AllTtsVoicesRequest(validate: true).writeToBuffer(),
        ),
      );
      response = card_rendering_pb.AllTtsVoicesResponse.fromBuffer(bytes);
    } on AnkiBackendException {
      return null;
    }
    if (_disposed) return null;

    final voice = _selectVoice(response.voices, tag);
    if (voice == null) return null;

    final root = await _tempDirectoryProvider();
    if (_disposed) return null;
    await root.create(recursive: true);
    final directory = await root.createTemp('anki-review-tts-');
    final path = '${directory.path}${Platform.pathSeparator}voice.wav';

    try {
      if (_disposed) return null;
      try {
        await _backend.invoke(
          BackendOperation.writeTtsStream,
          Uint8List.fromList(
            card_rendering_pb.WriteTtsStreamRequest(
              path: path,
              voiceId: voice.id,
              speed: tag.speed,
              text: tag.text,
            ).writeToBuffer(),
          ),
        );
      } on AnkiBackendException {
        return null;
      }
      if (_disposed) return null;
      final file = File(path);
      if (!await file.exists()) return null;
      if (_disposed) return null;
      _generatedDirectories.add(directory);
      return file.uri;
    } finally {
      // A cancelled or failed synthesis does not leave empty temp folders.
      if (!_generatedDirectories.contains(directory) &&
          await directory.exists()) {
        await directory.delete(recursive: true);
      }
    }
  }

  @override
  Future<void> dispose() => _disposeFuture ??= _dispose();

  Future<void> _dispose() async {
    _disposed = true;
    // A native TTS write may already be executing. Deleting its folder
    // before it finishes can otherwise leak a late-created WAV file.
    await Future.wait<void>(
      _inFlight.toList().map(
        (task) => task.then<void>(
          (_) {},
          onError: (Object error, StackTrace stackTrace) {},
        ),
      ),
    );
    final directories = _generatedDirectories.toList(growable: false);
    _generatedDirectories.clear();
    for (final directory in directories) {
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    }
  }

  card_rendering_pb.AllTtsVoicesResponse_TtsVoice? _selectVoice(
    Iterable<card_rendering_pb.AllTtsVoicesResponse_TtsVoice> voices,
    ReviewTtsTag tag,
  ) {
    final language = _normalizeLanguage(tag.language);
    final availableForLanguage = voices
        .where(
          (voice) =>
              (!voice.hasAvailable() || voice.available) &&
              _normalizeLanguage(voice.language) == language,
        )
        .toList(growable: false);

    for (final requested in tag.voices) {
      final normalizedRequested = _normalizeVoiceName(requested);
      for (final voice in availableForLanguage) {
        if (_normalizeVoiceName(voice.name) == normalizedRequested) {
          return voice;
        }
      }
    }

    if (language == 'en_US') {
      for (final voice in availableForLanguage) {
        if (_normalizeVoiceName(voice.name).startsWith('Apple_Samantha')) {
          return voice;
        }
      }
    }

    if (availableForLanguage.isEmpty) {
      return null;
    }
    return availableForLanguage.first;
  }


}

String _normalizeLanguage(String language) => language.replaceAll('-', '_');

String _normalizeVoiceName(String name) => name.replaceAll(' ', '_');
