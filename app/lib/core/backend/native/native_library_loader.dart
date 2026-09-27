import 'dart:ffi';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:flutter/foundation.dart';

typedef DynamicLibraryOpener = DynamicLibrary Function(String path);

String nativeLibraryFileName(TargetPlatform platform) {
  return switch (platform) {
    TargetPlatform.linux => 'libanki_flutter_bridge.so',
    TargetPlatform.macOS => 'libanki_flutter_bridge.dylib',
    TargetPlatform.windows => 'anki_flutter_bridge.dll',
    _ => throw const AnkiBridgeException(
        'Anki backend is currently supported on Linux, macOS, and Windows only.',
      ),
  };
}

String resolveNativeLibraryPath({
  required TargetPlatform platform,
  required String executablePath,
  required String environmentOverride,
}) {
  if (environmentOverride.isNotEmpty) {
    return environmentOverride;
  }

  final slash = executablePath.lastIndexOf('/');
  final backslash = executablePath.lastIndexOf('\\');
  final separatorIndex = slash > backslash ? slash : backslash;
  final directory = separatorIndex >= 0
      ? executablePath.substring(0, separatorIndex)
      : '.';
  final separator = platform == TargetPlatform.windows ? '\\' : '/';
  return '$directory$separator${nativeLibraryFileName(platform)}';
}

DynamicLibrary openNativeLibrary(
  String path, {
  DynamicLibraryOpener opener = DynamicLibrary.open,
}) {
  try {
    return opener(path);
  } catch (error) {
    throw AnkiBridgeException(
      'Unable to load the Anki backend native library at $path: $error',
    );
  }
}
