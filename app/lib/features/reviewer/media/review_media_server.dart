import 'dart:convert';
import 'dart:io';
import 'dart:math';

class ReviewMediaServer {
  HttpServer? _server;
  String? _mediaRoot;
  String? _sessionToken;

  Future<Uri> start(String mediaRoot) async {
    if (_server != null) {
      throw StateError('Review media server is already running.');
    }

    final root = Directory(mediaRoot).absolute;
    if (!await root.exists()) {
      throw FileSystemException('Review media root does not exist.', root.path);
    }
    final canonicalRoot = await root.resolveSymbolicLinks();

    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final token = _newSessionToken();
    _server = server;
    _mediaRoot = canonicalRoot;
    _sessionToken = token;
    server.listen(_handleRequest);

    return Uri(
      scheme: 'http',
      host: server.address.address,
      port: server.port,
      path: '/$token/',
    );
  }

  Future<void> close() async {
    final server = _server;
    _server = null;
    _mediaRoot = null;
    _sessionToken = null;
    if (server != null) {
      await server.close(force: true);
    }
  }

  Future<void> _handleRequest(HttpRequest request) async {
    try {
      // Collection media can contain private note content. Do not persist it
      // in browser disk caches or allow content-type sniffing.
      request.response.headers.set('cache-control', 'private, no-store');
      request.response.headers.set('x-content-type-options', 'nosniff');
      request.response.headers.set('referrer-policy', 'no-referrer');
      if (request.method != 'GET' && request.method != 'HEAD') {
        request.response.statusCode = HttpStatus.methodNotAllowed;
        request.response.headers.set('allow', 'GET, HEAD');
        await request.response.close();
        return;
      }

      final token = _sessionToken;
      final mediaRoot = _mediaRoot;
      final segments = request.uri.pathSegments;
      if (token == null ||
          mediaRoot == null ||
          segments.length < 2 ||
          segments.first != token) {
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
        return;
      }

      final mediaSegments = segments.skip(1).toList(growable: false);
      if (mediaSegments.any(_isUnsafePathSegment)) {
        request.response.statusCode = HttpStatus.forbidden;
        await request.response.close();
        return;
      }

      final relativePath = mediaSegments.join(Platform.pathSeparator);
      final file = File('$mediaRoot${Platform.pathSeparator}$relativePath');
      if (!await file.exists()) {
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
        return;
      }

      final canonicalFile = await file.resolveSymbolicLinks();
      if (!_isInsideRoot(canonicalFile, mediaRoot)) {
        request.response.statusCode = HttpStatus.forbidden;
        await request.response.close();
        return;
      }

      final resolvedFile = File(canonicalFile);
      final length = await resolvedFile.length();
      request.response.headers.contentType = _contentTypeFor(resolvedFile.path);
      request.response.headers.set('accept-ranges', 'bytes');

      // Browsers request byte ranges when seeking within audio or video.
      // Serving 200 and the full file for each seek breaks media playback.
      final rangeHeader = request.headers.value('range');
      final range = rangeHeader == null
          ? null
          : _parseRange(rangeHeader, length);
      if (rangeHeader != null && range == null) {
        request.response.statusCode = HttpStatus.requestedRangeNotSatisfiable;
        request.response.headers.set('content-range', 'bytes */$length');
        request.response.contentLength = 0;
        await request.response.close();
        return;
      }

      final start = range?.start ?? 0;
      final endExclusive = range == null ? length : range.end + 1;
      request.response.statusCode =
          range == null ? HttpStatus.ok : HttpStatus.partialContent;
      request.response.contentLength = endExclusive - start;
      if (range != null) {
        request.response.headers.set(
          'content-range',
          'bytes $start-${range.end}/$length',
        );
      }

      if (request.method == 'GET') {
        await request.response.addStream(
          resolvedFile.openRead(start, endExclusive),
        );
      }
      await request.response.close();
    } catch (_) {
      try {
        request.response.statusCode = HttpStatus.internalServerError;
        await request.response.close();
      } catch (_) {
        // The response may already have started; there is nothing left to send.
      }
    }
  }

  _ByteRange? _parseRange(String header, int size) {
    if (size == 0) return null;
    final match = RegExp(r'^bytes=(\d*)-(\d*)$').firstMatch(header.trim());
    if (match == null) return null;
    final first = match.group(1)!;
    final last = match.group(2)!;
    if (first.isEmpty && last.isEmpty) return null;

    try {
      if (first.isEmpty) {
        final suffix = int.parse(last);
        if (suffix <= 0) return null;
        return _ByteRange(
          suffix >= size ? 0 : size - suffix,
          size - 1,
        );
      }
      final start = int.parse(first);
      final end = last.isEmpty ? size - 1 : int.parse(last);
      if (start < 0 || start >= size || end < start) return null;
      return _ByteRange(start, end >= size ? size - 1 : end);
    } on FormatException {
      return null;
    }
  }

  bool _isUnsafePathSegment(String segment) {
    return segment.isEmpty ||
        segment == '.' ||
        segment == '..' ||
        segment.contains('/') ||
        segment.contains(r'\');
  }

  bool _isInsideRoot(String candidate, String root) {
    var normalizedCandidate = candidate;
    var normalizedRoot = root;
    if (Platform.isWindows) {
      normalizedCandidate = normalizedCandidate.toLowerCase();
      normalizedRoot = normalizedRoot.toLowerCase();
    }
    return normalizedCandidate == normalizedRoot ||
        normalizedCandidate.startsWith(
          '$normalizedRoot${Platform.pathSeparator}',
        );
  }

  String _newSessionToken() {
    final random = Random.secure();
    final bytes = List<int>.generate(24, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  ContentType _contentTypeFor(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.txt')) {
      return ContentType.text;
    }
    if (lower.endsWith('.html') || lower.endsWith('.htm')) {
      return ContentType.html;
    }
    if (lower.endsWith('.json')) {
      return ContentType.json;
    }
    if (lower.endsWith('.png')) {
      return ContentType('image', 'png');
    }
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) {
      return ContentType('image', 'jpeg');
    }
    if (lower.endsWith('.gif')) {
      return ContentType('image', 'gif');
    }
    if (lower.endsWith('.svg')) {
      return ContentType('image', 'svg+xml');
    }
    if (lower.endsWith('.webp')) {
      return ContentType('image', 'webp');
    }
    if (lower.endsWith('.mp3')) {
      return ContentType('audio', 'mpeg');
    }
    if (lower.endsWith('.ogg')) {
      return ContentType('audio', 'ogg');
    }
    if (lower.endsWith('.wav')) {
      return ContentType('audio', 'wav');
    }
    if (lower.endsWith('.mp4')) {
      return ContentType('video', 'mp4');
    }
    if (lower.endsWith('.webm')) {
      return ContentType('video', 'webm');
    }
    return ContentType.binary;
  }
}
).firstMatch(header.trim());
    if (match == null) return null;
    final first = match.group(1)!;
    final last = match.group(2)!;
    if (first.isEmpty && last.isEmpty) return null;

    try {
      if (first.isEmpty) {
        final suffix = int.parse(last);
        if (suffix <= 0) return null;
        return _ByteRange(
          suffix >= size ? 0 : size - suffix,
          size - 1,
        );
      }
      final start = int.parse(first);
      final end = last.isEmpty ? size - 1 : int.parse(last);
      if (start < 0 || start >= size || end < start) return null;
      return _ByteRange(start, end >= size ? size - 1 : end);
    } on FormatException {
      return null;
    }
  }

  bool _isUnsafePathSegment(String segment) {
    return segment.isEmpty ||
        segment == '.' ||
        segment == '..' ||
        segment.contains('/') ||
        segment.contains(r'\');
  }

  bool _isInsideRoot(String candidate, String root) {
    var normalizedCandidate = candidate;
    var normalizedRoot = root;
    if (Platform.isWindows) {
      normalizedCandidate = normalizedCandidate.toLowerCase();
      normalizedRoot = normalizedRoot.toLowerCase();
    }
    return normalizedCandidate == normalizedRoot ||
        normalizedCandidate.startsWith(
          '$normalizedRoot${Platform.pathSeparator}',
        );
  }

  String _newSessionToken() {
    final random = Random.secure();
    final bytes = List<int>.generate(24, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  ContentType _contentTypeFor(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.txt')) {
      return ContentType.text;
    }
    if (lower.endsWith('.html') || lower.endsWith('.htm')) {
      return ContentType.html;
    }
    if (lower.endsWith('.json')) {
      return ContentType.json;
    }
    if (lower.endsWith('.png')) {
      return ContentType('image', 'png');
    }
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) {
      return ContentType('image', 'jpeg');
    }
    if (lower.endsWith('.gif')) {
      return ContentType('image', 'gif');
    }
    if (lower.endsWith('.svg')) {
      return ContentType('image', 'svg+xml');
    }
    if (lower.endsWith('.webp')) {
      return ContentType('image', 'webp');
    }
    if (lower.endsWith('.mp3')) {
      return ContentType('audio', 'mpeg');
    }
    if (lower.endsWith('.ogg')) {
      return ContentType('audio', 'ogg');
    }
    if (lower.endsWith('.wav')) {
      return ContentType('audio', 'wav');
    }
    if (lower.endsWith('.mp4')) {
      return ContentType('video', 'mp4');
    }
    if (lower.endsWith('.webm')) {
      return ContentType('video', 'webm');
    }
    return ContentType.binary;
  }
}

class _ByteRange {
  const _ByteRange(this.start, this.end);

  final int start;
  final int end;
}
