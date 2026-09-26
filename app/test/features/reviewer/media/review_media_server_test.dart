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
}
