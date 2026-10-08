import 'dart:convert';
import 'dart:io';

import 'package:anki_flutter/features/reviewer/media/review_media_server.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('serves collection media over tokenized loopback GET and HEAD', () async {
    final temp = await Directory.systemTemp.createTemp('anki-review-media-');
    addTearDown(() => temp.delete(recursive: true));
    final mediaRoot = Directory('${temp.path}${Platform.pathSeparator}collection.media');
    await mediaRoot.create();
    final mediaFile = File('${mediaRoot.path}${Platform.pathSeparator}hello.txt');
    const body = 'reviewer media';
    await mediaFile.writeAsString(body);

    final server = ReviewMediaServer();
    addTearDown(server.close);
    final baseUri = await server.start(mediaRoot.path);

    expect(baseUri.scheme, 'http');
    expect(baseUri.host, InternetAddress.loopbackIPv4.address);
    expect(baseUri.port, greaterThan(0));
    expect(baseUri.path, startsWith('/'));
    expect(baseUri.path, endsWith('/'));
    expect(baseUri.pathSegments.where((segment) => segment.isNotEmpty), hasLength(1));

    final client = HttpClient();
    addTearDown(() => client.close(force: true));

    final getRequest = await client.getUrl(baseUri.resolve('hello.txt'));
    final getResponse = await getRequest.close();
    expect(getResponse.statusCode, HttpStatus.ok);
    expect(getResponse.contentLength, utf8.encode(body).length);
    expect(getResponse.headers.contentType?.mimeType, 'text/plain');
    expect(await utf8.decoder.bind(getResponse).join(), body);

    final headRequest = await client.openUrl('HEAD', baseUri.resolve('hello.txt'));
    final headResponse = await headRequest.close();
    expect(headResponse.statusCode, HttpStatus.ok);
    expect(headResponse.contentLength, utf8.encode(body).length);
    expect(headResponse.headers.contentType?.mimeType, 'text/plain');
    expect(await headResponse.fold<int>(0, (length, bytes) => length + bytes.length), 0);
  });

  test('supports audio/video byte range seeking and HEAD metadata', () async {
    final fixture = await _SecurityFixture.create();
    addTearDown(fixture.dispose);
    final file = File(
      '${fixture.mediaRoot.path}${Platform.pathSeparator}video.mp4',
    );
    await file.writeAsBytes([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    final uri = fixture.baseUri.resolve('video.mp4');

    Future<HttpClientResponse> rangeResponse(String method, String range) async {
      final request = await fixture.client.openUrl(method, uri);
      request.headers.set('range', range);
      return request.close();
    }

    final first = await rangeResponse('GET', 'bytes=2-5');
    expect(first.statusCode, HttpStatus.partialContent);
    expect(first.headers.value('content-range'), 'bytes 2-5/10');
    expect(first.headers.value('accept-ranges'), 'bytes');
    expect(first.contentLength, 4);
    expect(await first.fold<List<int>>([], (list, data) => list..addAll(data)),
        [2, 3, 4, 5]);

    final suffix = await rangeResponse('GET', 'bytes=-3');
    expect(suffix.statusCode, HttpStatus.partialContent);
    expect(suffix.headers.value('content-range'), 'bytes 7-9/10');
    expect(await suffix.fold<List<int>>([], (list, data) => list..addAll(data)),
        [7, 8, 9]);

    final remaining = await rangeResponse('GET', 'bytes=8-');
    expect(remaining.statusCode, HttpStatus.partialContent);
    expect(await remaining.fold<List<int>>([], (list, data) => list..addAll(data)),
        [8, 9]);

    final head = await rangeResponse('HEAD', 'bytes=4-6');
    expect(head.statusCode, HttpStatus.partialContent);
    expect(head.contentLength, 3);
    expect(head.headers.value('content-range'), 'bytes 4-6/10');
    expect(await head.fold<int>(0, (count, data) => count + data.length), 0);
  });

  test('returns 416 for malformed, multiple or unsatisfiable ranges',
      () async {
    final fixture = await _SecurityFixture.create();
    addTearDown(fixture.dispose);
    await File('${fixture.mediaRoot.path}/audio.mp3').writeAsBytes([1, 2, 3]);
    for (final range in [
      'bytes=3-',
      'bytes=2-1',
      'bytes=-0',
      'bytes=0-1,2-2',
      'bytes=hello',
    ]) {
      final request = await fixture.client.getUrl(
        fixture.baseUri.resolve('audio.mp3'),
      );
      request.headers.set('range', range);
      final response = await request.close();
      expect(response.statusCode, HttpStatus.requestedRangeNotSatisfiable,
          reason: 'invalid range: $range');
      expect(response.headers.value('content-range'), 'bytes */3');
      expect(await response.drain<void>(), isNull);
    }
  });

  test('disables sniffing, referrers and browser storage of private media',
      () async {
    final fixture = await _SecurityFixture.create();
    addTearDown(fixture.dispose);
    await File('${fixture.mediaRoot.path}/note.html')
        .writeAsString('<p>private card</p>');
    final response = await fixture.client
        .getUrl(fixture.baseUri.resolve('note.html'))
        .then((request) => request.close());
    expect(response.statusCode, HttpStatus.ok);
    expect(response.headers.value('x-content-type-options'), 'nosniff');
    expect(response.headers.value('referrer-policy'), 'no-referrer');
    expect(response.headers.value('cache-control'), 'private, no-store');
    await response.drain<void>();
  });

  test('rejects literal and percent-encoded parent traversal', () async {
    final fixture = await _SecurityFixture.create();
    addTearDown(fixture.dispose);

    for (final path in [
      '${fixture.baseUri.path}../outside.txt',
      '${fixture.baseUri.path}%2e%2e/outside.txt',
    ]) {
      final uri = fixture.baseUri.replace(path: path);
      final response = await _get(fixture.client, uri);
      expect(
        response.statusCode,
        anyOf(HttpStatus.forbidden, HttpStatus.notFound),
        reason: 'Traversal path should not be served: $path',
      );
      expect(response.body, isNot(contains(_SecurityFixture.secret)));
    }
  });

  test('rejects requests outside the tokenized media path', () async {
    final fixture = await _SecurityFixture.create();
    addTearDown(fixture.dispose);

    final absoluteUri = fixture.baseUri.replace(path: '/outside.txt');
    final response = await _get(fixture.client, absoluteUri);

    expect(response.statusCode, anyOf(HttpStatus.forbidden, HttpStatus.notFound));
    expect(response.body, isNot(contains(_SecurityFixture.secret)));
  });

  test(
    'rejects symlink inside media root that resolves outside root',
    () async {
      final fixture = await _SecurityFixture.create();
      addTearDown(fixture.dispose);
      final link = Link(
        '${fixture.mediaRoot.path}${Platform.pathSeparator}escape.txt',
      );
      await link.create(fixture.outsideFile.path);

      final response = await _get(
        fixture.client,
        fixture.baseUri.resolve('escape.txt'),
      );

      expect(response.statusCode, anyOf(HttpStatus.forbidden, HttpStatus.notFound));
      expect(response.body, isNot(contains(_SecurityFixture.secret)));
    },
    skip: Platform.isWindows
        ? 'Creating symlinks requires privileges on some Windows runners.'
        : false,
  );

  test('rejects unsupported HTTP methods with 405', () async {
    final fixture = await _SecurityFixture.create();
    addTearDown(fixture.dispose);
    final file = File(
      '${fixture.mediaRoot.path}${Platform.pathSeparator}hello.txt',
    );
    await file.writeAsString('hello');

    final request = await fixture.client.postUrl(
      fixture.baseUri.resolve('hello.txt'),
    );
    final response = await request.close();
    await response.drain<void>();

    expect(response.statusCode, HttpStatus.methodNotAllowed);
    final allow = response.headers.value('allow') ?? '';
    expect(allow, contains('GET'));
    expect(allow, contains('HEAD'));
  });
}

Future<_HttpResult> _get(HttpClient client, Uri uri) async {
  final request = await client.getUrl(uri);
  final response = await request.close();
  final body = await utf8.decoder.bind(response).join();
  return _HttpResult(response.statusCode, body);
}

class _HttpResult {
  const _HttpResult(this.statusCode, this.body);

  final int statusCode;
  final String body;
}

class _SecurityFixture {
  _SecurityFixture({
    required this.temp,
    required this.mediaRoot,
    required this.outsideFile,
    required this.server,
    required this.baseUri,
    required this.client,
  });

  static const secret = 'outside reviewer secret';

  final Directory temp;
  final Directory mediaRoot;
  final File outsideFile;
  final ReviewMediaServer server;
  final Uri baseUri;
  final HttpClient client;

  static Future<_SecurityFixture> create() async {
    final temp = await Directory.systemTemp.createTemp('anki-review-media-security-');
    final mediaRoot = Directory(
      '${temp.path}${Platform.pathSeparator}collection.media',
    );
    await mediaRoot.create();
    final outsideFile = File('${temp.path}${Platform.pathSeparator}outside.txt');
    await outsideFile.writeAsString(secret);
    final server = ReviewMediaServer();
    final baseUri = await server.start(mediaRoot.path);
    final client = HttpClient();
    return _SecurityFixture(
      temp: temp,
      mediaRoot: mediaRoot,
      outsideFile: outsideFile,
      server: server,
      baseUri: baseUri,
      client: client,
    );
  }

  Future<void> dispose() async {
    client.close(force: true);
    await server.close();
    await temp.delete(recursive: true);
  }
}
