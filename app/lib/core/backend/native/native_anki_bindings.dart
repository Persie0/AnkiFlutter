import 'dart:typed_data';

abstract interface class NativeAnkiHandle {}

abstract interface class NativeAnkiBuffer {}

abstract interface class NativeAnkiCreateResult {
  int get status;
  NativeAnkiHandle? get handle;
  NativeAnkiBuffer get buffer;
}

abstract interface class NativeAnkiCallResult {
  int get status;
  NativeAnkiBuffer get buffer;
}

abstract interface class NativeAnkiBindings {
  NativeAnkiCreateResult create(Uint8List init);

  NativeAnkiCallResult invoke(
    NativeAnkiHandle handle,
    int operation,
    Uint8List request,
  );

  Uint8List copyBuffer(NativeAnkiBuffer buffer);
  void freeBuffer(NativeAnkiBuffer buffer);
  void destroy(NativeAnkiHandle handle);
}
