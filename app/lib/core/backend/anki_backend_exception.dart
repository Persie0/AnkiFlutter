class AnkiBackendException implements Exception {
  const AnkiBackendException({
    required this.kind,
    required this.message,
    required this.context,
  });

  final int kind;
  final String message;
  final String context;

  @override
  String toString() => context.isEmpty ? message : '$message ($context)';
}

class AnkiBridgeException implements Exception {
  const AnkiBridgeException(this.message);

  final String message;

  @override
  String toString() => message;
}
