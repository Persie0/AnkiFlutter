import 'dart:typed_data';

import 'package:anki_flutter/core/backend/backend_invoker.dart';
import 'package:anki_flutter/core/backend/backend_operation.dart';
import 'package:anki_flutter/core/backend/generated/anki/card_rendering.pb.dart'
    as card_rendering_pb;
import 'package:anki_flutter/core/backend/generated/anki/generic.pb.dart'
    as generic_pb;
import 'package:anki_flutter/features/reviewer/data/anki_card_render_repository.dart';
import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('render uses Anki render AV extraction and IRI encoding in order', () async {
    final rendered = card_rendering_pb.RenderCardResponse(
      questionNodes: [
        card_rendering_pb.RenderedTemplateNode(
          text: '<div>raw-question [sound:question.mp3]</div>',
        ),
      ],
      answerNodes: [
        card_rendering_pb.RenderedTemplateNode(
          text: '<div>raw-answer {{tts en_US voices=Alex:answer text}}</div>',
        ),
      ],
      css: '.card { font-size: 20px; }',
    );
    final backend = _FakeBackend((operation, request) {
      switch (operation) {
        case BackendOperation.renderExistingCard:
          return Uint8List.fromList(rendered.writeToBuffer());
        case BackendOperation.extractAvTags:
          final input = card_rendering_pb.ExtractAvTagsRequest.fromBuffer(request);
          if (input.questionSide) {
            return Uint8List.fromList(
              card_rendering_pb.ExtractAvTagsResponse(
                text: '<div>clean-question <img src="front image.png"></div>',
                avTags: [
                  card_rendering_pb.AVTag(soundOrVideo: 'question.mp3'),
                ],
              ).writeToBuffer(),
            );
          }
          return Uint8List.fromList(
            card_rendering_pb.ExtractAvTagsResponse(
              text: '<div>clean-answer</div>',
              avTags: [
                card_rendering_pb.AVTag(
                  tts: card_rendering_pb.TTSTag(
                    fieldText: 'answer text',
                    lang: 'en_US',
                    voices: ['Alex', 'Samantha'],
                    speed: 1.25,
                    otherArgs: ['cloze_blank=...'],
                  ),
                ),
              ],
            ).writeToBuffer(),
          );
        case BackendOperation.encodeIriPaths:
          final input = generic_pb.String.fromBuffer(request);
          return Uint8List.fromList(
            generic_pb.String(val: 'encoded:${input.val}').writeToBuffer(),
          );
        default:
          fail('unexpected operation $operation');
      }
    });
    final repository = AnkiCardRenderRepository(backend: backend);

    final content = await repository.render(987654321);

    expect(
      backend.calls.map((call) => call.operation),
      orderedEquals([
        BackendOperation.renderExistingCard,
        BackendOperation.extractAvTags,
        BackendOperation.extractAvTags,
        BackendOperation.encodeIriPaths,
        BackendOperation.encodeIriPaths,
      ]),
    );

    final renderRequest = card_rendering_pb.RenderExistingCardRequest.fromBuffer(
      backend.calls[0].request,
    );
    expect(renderRequest.cardId, Int64(987654321));
    expect(renderRequest.browser, isFalse);
    expect(renderRequest.partialRender, isFalse);

    final questionExtract = card_rendering_pb.ExtractAvTagsRequest.fromBuffer(
      backend.calls[1].request,
    );
    expect(
      questionExtract.text,
      '<div>raw-question [sound:question.mp3]</div>',
    );
    expect(questionExtract.questionSide, isTrue);

    final answerExtract = card_rendering_pb.ExtractAvTagsRequest.fromBuffer(
      backend.calls[2].request,
    );
    expect(
      answerExtract.text,
      '<div>raw-answer {{tts en_US voices=Alex:answer text}}</div>',
    );
    expect(answerExtract.questionSide, isFalse);

    final questionEncode = generic_pb.String.fromBuffer(backend.calls[3].request);
    final answerEncode = generic_pb.String.fromBuffer(backend.calls[4].request);
    expect(
      questionEncode.val,
      '<div>clean-question <img src="front image.png"></div>',
    );
    expect(answerEncode.val, '<div>clean-answer</div>');

    expect(
      content.questionHtml,
      'encoded:<div>clean-question <img src="front image.png"></div>',
    );
    expect(content.answerHtml, 'encoded:<div>clean-answer</div>');
    expect(content.css, '.card { font-size: 20px; }');

    expect(content.questionAudio, hasLength(1));
    expect(content.questionAudio.single, isA<ReviewMediaTag>());
    expect(
      (content.questionAudio.single as ReviewMediaTag).filename,
      'question.mp3',
    );

    expect(content.answerAudio, hasLength(1));
    expect(content.answerAudio.single, isA<ReviewTtsTag>());
    final tts = content.answerAudio.single as ReviewTtsTag;
    expect(tts.text, 'answer text');
    expect(tts.language, 'en_US');
    expect(tts.voices, orderedEquals(['Alex', 'Samantha']));
    expect(tts.speed, closeTo(1.25, 0.0001));
    expect(tts.otherArgs, orderedEquals(['cloze_blank=...']));
  });

  test('render stays neutral when referenced media does not exist', () async {
    const questionHtml = '<img src="definitely-missing-reviewer-image.png">';
    const answerHtml = '<div>answer with missing media</div>';
    final rendered = card_rendering_pb.RenderCardResponse(
      questionNodes: [card_rendering_pb.RenderedTemplateNode(text: questionHtml)],
      answerNodes: [card_rendering_pb.RenderedTemplateNode(text: answerHtml)],
      css: '.card {}',
    );
    final backend = _FakeBackend((operation, request) {
      switch (operation) {
        case BackendOperation.renderExistingCard:
          return Uint8List.fromList(rendered.writeToBuffer());
        case BackendOperation.extractAvTags:
          final input = card_rendering_pb.ExtractAvTagsRequest.fromBuffer(request);
          return Uint8List.fromList(
            card_rendering_pb.ExtractAvTagsResponse(text: input.text).writeToBuffer(),
          );
        case BackendOperation.encodeIriPaths:
          final input = generic_pb.String.fromBuffer(request);
          return Uint8List.fromList(
            generic_pb.String(val: input.val).writeToBuffer(),
          );
        default:
          fail('unexpected operation $operation');
      }
    });
    final repository = AnkiCardRenderRepository(backend: backend);

    final content = await repository.render(42);

    expect(content.questionHtml, questionHtml);
    expect(content.answerHtml, answerHtml);
    expect(content.questionAudio, isEmpty);
    expect(content.answerAudio, isEmpty);
  });
}

class _BackendCall {
  const _BackendCall(this.operation, this.request);

  final BackendOperation operation;
  final Uint8List request;
}

class _FakeBackend implements BackendInvoker {
  _FakeBackend(this.handler);

  final Uint8List Function(BackendOperation operation, Uint8List request) handler;
  final List<_BackendCall> calls = [];

  @override
  Future<Uint8List> invoke(BackendOperation operation, Uint8List request) async {
    calls.add(_BackendCall(operation, request));
    return handler(operation, request);
  }
}
