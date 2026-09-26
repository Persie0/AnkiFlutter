import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_operation.dart';

abstract interface class BackendInvoker {
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request);
}
