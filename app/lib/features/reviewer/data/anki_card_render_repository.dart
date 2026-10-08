import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/card_rendering.pb.dart'
    as card_rendering_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic_pb;
import 'package:anki_flutter/features/reviewer/data/card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:fixnum/fixnum.dart';

class AnkiCardRenderRepository implements CardRenderRepository {
  AnkiCardRenderRepository({required this.backend, this.browser = false});

  final BackendInvoker backend;

  /// Native Anki rendering context: reviewer by default, browser for previews.
  final bool browser;

  @override
  Future<ReviewCardContent> render(int cardId) async {
    final renderRequest = card_rendering_pb.RenderExistingCardRequest(
      cardId: Int64(cardId),
      browser: browser,
      partialRender: false,
    );
    final renderBytes = await backend.invoke(
      BackendOperation.renderExistingCard,
      Uint8List.fromList(renderRequest.writeToBuffer()),
    );
    final rendered = card_rendering_pb.RenderCardResponse.fromBuffer(renderBytes);

    final question = await _extractAv(
      _renderedText(rendered.questionNodes),
      questionSide: true,
    );
    final answer = await _extractAv(
      _renderedText(rendered.answerNodes),
      questionSide: false,
    );

    final questionHtml = await _encodeIriPaths(question.html);
    final answerHtml = await _encodeIriPaths(answer.html);

    return ReviewCardContent(
      questionHtml: questionHtml,
      answerHtml: answerHtml,
      css: rendered.css,
      questionAudio: question.audio,
      answerAudio: answer.audio,
    );
  }

  String _renderedText(
    Iterable<card_rendering_pb.RenderedTemplateNode> nodes,
  ) {
    final buffer = StringBuffer();
    for (final node in nodes) {
      if (node.hasText()) {
        buffer.write(node.text);
      } else if (node.hasReplacement()) {
        throw StateError(
          'Anki returned a replacement node during full card rendering.',
        );
      } else {
        throw StateError('Anki returned an empty rendered template node.');
      }
    }
    return buffer.toString();
  }

  Future<_PreparedSide> _extractAv(
    String html, {
    required bool questionSide,
  }) async {
    final request = card_rendering_pb.ExtractAvTagsRequest(
      text: html,
      questionSide: questionSide,
    );
    final bytes = await backend.invoke(
      BackendOperation.extractAvTags,
      Uint8List.fromList(request.writeToBuffer()),
    );
    final response = card_rendering_pb.ExtractAvTagsResponse.fromBuffer(bytes);

    return _PreparedSide(
      html: response.text,
      audio: response.avTags.map(_mapAudioTag).toList(growable: false),
    );
  }

  ReviewAudioTag _mapAudioTag(card_rendering_pb.AVTag tag) {
    if (tag.hasSoundOrVideo()) {
      return ReviewMediaTag(tag.soundOrVideo);
    }
    if (tag.hasTts()) {
      final tts = tag.tts;
      return ReviewTtsTag(
        text: tts.fieldText,
        language: tts.lang,
        voices: tts.voices,
        speed: tts.speed,
        otherArgs: tts.otherArgs,
      );
    }
    throw StateError('Anki returned an AV tag without a value.');
  }

  Future<String> _encodeIriPaths(String html) async {
    final request = generic_pb.String(val: html);
    final bytes = await backend.invoke(
      BackendOperation.encodeIriPaths,
      Uint8List.fromList(request.writeToBuffer()),
    );
    return generic_pb.String.fromBuffer(bytes).val;
  }
}

class _PreparedSide {
  _PreparedSide({required this.html, required List<ReviewAudioTag> audio})
      : audio = List.unmodifiable(audio);

  final String html;
  final List<ReviewAudioTag> audio;
}
