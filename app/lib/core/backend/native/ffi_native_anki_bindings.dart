import 'dart:ffi';
import 'dart:typed_data';

import 'package:anki_flutter/core/backend/anki_backend_exception.dart';
import 'package:anki_flutter/core/backend/native/native_anki_bindings.dart';
import 'package:ffi/ffi.dart';

final class _ByteBuffer extends Struct {
  external Pointer<Uint8> ptr;

  @Size()
  external int len;

  @Size()
  external int cap;
}

final class _BridgeCreateResult extends Struct {
  @Uint32()
  external int status;

  external Pointer<Void> handle;
  external _ByteBuffer data;
}

final class _BridgeCallResult extends Struct {
  @Uint32()
  external int status;

  external _ByteBuffer data;
}

typedef _CreateNative = _BridgeCreateResult Function(Pointer<Uint8>, Size);
typedef _CreateDart = _BridgeCreateResult Function(Pointer<Uint8>, int);
typedef _InvokeNative = _BridgeCallResult Function(
  Pointer<Void>,
  Uint32,
  Pointer<Uint8>,
  Size,
);
typedef _InvokeDart = _BridgeCallResult Function(
  Pointer<Void>,
  int,
  Pointer<Uint8>,
  int,
);
typedef _FreeBufferNative = Void Function(_ByteBuffer);
typedef _FreeBufferDart = void Function(_ByteBuffer);
typedef _DestroyNative = Void Function(Pointer<Void>);
typedef _DestroyDart = void Function(Pointer<Void>);

class FfiNativeAnkiBindings implements NativeAnkiBindings {
  FfiNativeAnkiBindings._(
    this._create,
    this._invoke,
    this._freeBuffer,
    this._destroy,
  );

  factory FfiNativeAnkiBindings.fromLibrary(DynamicLibrary library) {
    return FfiNativeAnkiBindings._(
      _lookupCreate(library),
      _lookupInvoke(library),
      _lookupFreeBuffer(library),
      _lookupDestroy(library),
    );
  }

  final _CreateDart _create;
  final _InvokeDart _invoke;
  final _FreeBufferDart _freeBuffer;
  final _DestroyDart _destroy;

  @override
  NativeAnkiCreateResult create(Uint8List init) {
    final input = _copyInput(init);
    try {
      final result = _create(input, init.length);
      return _FfiCreateResult(
        status: result.status,
        handle: result.handle.address == 0 ? null : _FfiHandle(result.handle),
        buffer: _FfiBuffer(result.data),
      );
    } finally {
      if (input.address != 0) {
        calloc.free(input);
      }
    }
  }

  @override
  NativeAnkiCallResult invoke(
    NativeAnkiHandle handle,
    int operation,
    Uint8List request,
  ) {
    final ffiHandle = _requireHandle(handle);
    final input = _copyInput(request);
    try {
      final result = _invoke(
        ffiHandle.pointer,
        operation,
        input,
        request.length,
      );
      return _FfiCallResult(
        status: result.status,
        buffer: _FfiBuffer(result.data),
      );
    } finally {
      if (input.address != 0) {
        calloc.free(input);
      }
    }
  }

  @override
  Uint8List copyBuffer(NativeAnkiBuffer buffer) {
    final value = _requireBuffer(buffer).value;
    if (value.ptr.address == 0 || value.len == 0) {
      return Uint8List(0);
    }
    return Uint8List.fromList(value.ptr.asTypedList(value.len));
  }

  @override
  void freeBuffer(NativeAnkiBuffer buffer) {
    _freeBuffer(_requireBuffer(buffer).value);
  }

  @override
  void destroy(NativeAnkiHandle handle) {
    _destroy(_requireHandle(handle).pointer);
  }
}

_CreateDart _lookupCreate(DynamicLibrary library) {
  try {
    return library.lookupFunction<_CreateNative, _CreateDart>(
      'anki_bridge_create',
    );
  } catch (error) {
    throw AnkiBridgeException(
      'Unable to initialize the Anki backend native binding '
      'anki_bridge_create: $error',
    );
  }
}

_InvokeDart _lookupInvoke(DynamicLibrary library) {
  try {
    return library.lookupFunction<_InvokeNative, _InvokeDart>(
      'anki_bridge_invoke',
    );
  } catch (error) {
    throw AnkiBridgeException(
      'Unable to initialize the Anki backend native binding '
      'anki_bridge_invoke: $error',
    );
  }
}

_FreeBufferDart _lookupFreeBuffer(DynamicLibrary library) {
  try {
    return library.lookupFunction<_FreeBufferNative, _FreeBufferDart>(
      'anki_bridge_free_buffer',
    );
  } catch (error) {
    throw AnkiBridgeException(
      'Unable to initialize the Anki backend native binding '
      'anki_bridge_free_buffer: $error',
    );
  }
}

_DestroyDart _lookupDestroy(DynamicLibrary library) {
  try {
    return library.lookupFunction<_DestroyNative, _DestroyDart>(
      'anki_bridge_destroy',
    );
  } catch (error) {
    throw AnkiBridgeException(
      'Unable to initialize the Anki backend native binding '
      'anki_bridge_destroy: $error',
    );
  }
}

Pointer<Uint8> _copyInput(Uint8List bytes) {
  if (bytes.isEmpty) {
    return nullptr.cast<Uint8>();
  }
  final pointer = calloc<Uint8>(bytes.length);
  pointer.asTypedList(bytes.length).setAll(0, bytes);
  return pointer;
}

_FfiHandle _requireHandle(NativeAnkiHandle handle) {
  if (handle case final _FfiHandle ffiHandle) {
    return ffiHandle;
  }
  throw ArgumentError.value(handle, 'handle', 'Unsupported native Anki handle');
}

_FfiBuffer _requireBuffer(NativeAnkiBuffer buffer) {
  if (buffer case final _FfiBuffer ffiBuffer) {
    return ffiBuffer;
  }
  throw ArgumentError.value(buffer, 'buffer', 'Unsupported native Anki buffer');
}

class _FfiHandle implements NativeAnkiHandle {
  const _FfiHandle(this.pointer);

  final Pointer<Void> pointer;
}

class _FfiBuffer implements NativeAnkiBuffer {
  const _FfiBuffer(this.value);

  final _ByteBuffer value;
}

class _FfiCreateResult implements NativeAnkiCreateResult {
  const _FfiCreateResult({
    required this.status,
    required this.handle,
    required this.buffer,
  });

  @override
  final int status;

  @override
  final NativeAnkiHandle? handle;

  @override
  final NativeAnkiBuffer buffer;
}

class _FfiCallResult implements NativeAnkiCallResult {
  const _FfiCallResult({required this.status, required this.buffer});

  @override
  final int status;

  @override
  final NativeAnkiBuffer buffer;
}
