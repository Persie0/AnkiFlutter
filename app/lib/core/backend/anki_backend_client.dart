import 'dart:convert';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/backend.pb.dart';
import 'package:anki_flutter/core/backend/native/native_anki_bindings.dart';

class AnkiBackendClient implements BackendInvoker {
  AnkiBackendClient._(this._bindings, this._handle);

  factory AnkiBackendClient.create({
    required NativeAnkiBindings bindings,
    required Uint8List init,
  }) {
    final result = bindings.create(init);
    if (result.status == 0 && result.handle != null) {
      bindings.freeBuffer(result.buffer);
      return AnkiBackendClient._(bindings, result.handle!);
    }

    final bytes = _copyAndFree(bindings, result.buffer);
    if (result.status == 1) {
      throw _backendException(bytes);
    }
    throw AnkiBridgeException(utf8.decode(bytes, allowMalformed: true));
  }

  final NativeAnkiBindings _bindings;
  NativeAnkiHandle? _handle;

  bool get isDisposed => _handle == null;

  @override
  Future<Uint8List> invoke(
    BackendOperation operation,
    Uint8List request,
  ) async {
    final handle = _handle;
    if (handle == null) {
      throw StateError('Anki backend client has been disposed');
    }

    final result = _bindings.invoke(handle, operation.nativeId, request);
    final bytes = _copyAndFree(_bindings, result.buffer);

    switch (result.status) {
      case 0:
        return bytes;
      case 1:
        throw _backendException(bytes);
      case 2:
        throw AnkiBridgeException(utf8.decode(bytes, allowMalformed: true));
      default:
        throw AnkiBridgeException('Unknown native Anki status ${result.status}');
    }
  }

  void dispose() {
    final handle = _handle;
    if (handle == null) {
      return;
    }
    _handle = null;
    _bindings.destroy(handle);
  }
}

Uint8List _copyAndFree(
  NativeAnkiBindings bindings,
  NativeAnkiBuffer buffer,
) {
  try {
    return bindings.copyBuffer(buffer);
  } finally {
    bindings.freeBuffer(buffer);
  }
}

AnkiBackendException _backendException(Uint8List bytes) {
  try {
    final error = BackendError.fromBuffer(bytes);
    return AnkiBackendException(
      kind: error.kind.value,
      message: error.message,
      context: error.context,
    );
  } catch (error) {
    throw AnkiBridgeException('Invalid Anki backend error payload: $error');
  }
}
