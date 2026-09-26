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

    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final token = _newSessionToken();
    _server = server;
    _mediaRoot = root.path;
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

      final relativePath = segments.skip(1).join(Platform.pathSeparator);
      final file = File('$mediaRoot${Platform.pathSeparator}$relativePath');
      if (!await file.exists()) {
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
        return;
      }

      final length = await file.length();
      request.response.statusCode = HttpStatus.ok;
      request.response.contentLength = length;
      request.response.headers.contentType = _contentTypeFor(file.path);

      if (request.method == 'GET') {
        await request.response.addStream(file.openRead());
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
