import 'dart:ffi';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:flutter/foundation.dart';

typedef DynamicLibraryOpener = DynamicLibrary Function(String path);

String nativeLibraryFileName(TargetPlatform platform) {
  return switch (platform) {
    TargetPlatform.android => 'libanki_flutter_bridge.so',
    TargetPlatform.linux => 'libanki_flutter_bridge.so',
    TargetPlatform.macOS => 'libanki_flutter_bridge.dylib',
    TargetPlatform.windows => 'anki_flutter_bridge.dll',
    _ => throw const AnkiBridgeException(
      'Anki backend has no dynamic library file for this platform.',
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

  if (platform == TargetPlatform.android) {
    // Android resolves packaged JNI libraries by their soname.
    return nativeLibraryFileName(platform);
  }

  final slash = executablePath.lastIndexOf('/');
  final backslash = executablePath.lastIndexOf('\\');
  final separatorIndex = slash > backslash ? slash : backslash;
  final directory = separatorIndex >= 0
      ? executablePath.substring(0, separatorIndex)
      : '.';
  final separator = platform == TargetPlatform.windows ? '\\' : '/';
  if (platform == TargetPlatform.macOS) {
    return '$directory$separator..${separator}Frameworks$separator'
        '${nativeLibraryFileName(platform)}';
  }
  return '$directory$separator${nativeLibraryFileName(platform)}';
}

DynamicLibrary openPlatformNativeLibrary({
  required TargetPlatform platform,
  required String executablePath,
  required String environmentOverride,
  DynamicLibraryOpener opener = DynamicLibrary.open,
  DynamicLibrary Function() processOpener = DynamicLibrary.process,
}) {
  if (environmentOverride.isEmpty && platform == TargetPlatform.iOS) {
    // The Rust bridge is linked into the iOS app binary because App Store apps
    // cannot load an unsigned dylib from outside their signed bundle.
    return processOpener();
  }
  final path = resolveNativeLibraryPath(
    platform: platform,
    executablePath: executablePath,
    environmentOverride: environmentOverride,
  );
  return openNativeLibrary(path, opener: opener);
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
