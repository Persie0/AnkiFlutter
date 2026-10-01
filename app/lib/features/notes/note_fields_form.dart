import 'dart:async';
import 'dart:typed_data';

import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NoteFieldsForm extends StatelessWidget {
  const NoteFieldsForm({
    required this.fields,
    required this.fieldNames,
    required this.tagsController,
    required this.busy,
    required this.error,
    required this.errorKey,
    required this.errorPrefix,
    required this.saveLabel,
    required this.saveIcon,
    required this.onSave,
    this.mediaRepository,
    super.key,
  });

  final List<TextEditingController> fields;
  final List<String> fieldNames;
  final TextEditingController tagsController;
  final bool busy;
  final Object? error;
  final String errorKey;
  final String errorPrefix;
  final String saveLabel;
  final IconData saveIcon;
  final VoidCallback onSave;
  final MediaRepository? mediaRepository;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < fields.length; index++) ...[
          TextField(
            key: ValueKey('note-field-$index'),
            controller: fields[index],
            minLines: 1,
            maxLines: 8,
            decoration: InputDecoration(
              labelText: index < fieldNames.length
                  ? fieldNames[index]
                  : 'Field ${index + 1}',
              alignLabelWithHint: true,
            ),
          ),
          if (mediaRepository case final repository?)
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 4,
                children: [
                  TextButton.icon(
                    key: ValueKey('attach-media-$index'),
                    onPressed: busy
                        ? null
                        : () => unawaited(
                              _attachFile(context, repository, fields[index]),
                            ),
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Attach'),
                  ),
                  TextButton.icon(
                    key: ValueKey('attach-media-url-$index'),
                    onPressed: busy
                        ? null
                        : () => unawaited(
                              _attachUrl(context, repository, fields[index]),
                            ),
                    icon: const Icon(Icons.link),
                    label: const Text('From URL'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
        ],
        TextField(
          key: const ValueKey('note-tags'),
          controller: tagsController,
          decoration: const InputDecoration(
            labelText: 'Tags',
            hintText: 'Separate tags with spaces',
          ),
        ),
        if (error case final error?) ...[
          const SizedBox(height: 12),
          Text(
            '$errorPrefix: $error',
            key: ValueKey(errorKey),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: busy ? null : onSave,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: busy ? null : onSave,
          icon: busy
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(saveIcon),
          label: Text(saveLabel),
        ),
      ],
    );
  }
}

Future<void> _attachFile(
  BuildContext context,
  MediaRepository repository,
  TextEditingController controller,
) async {
  try {
    final picked = await FilePicker.pickFile(
      dialogTitle: 'Choose media to attach',
      type: FileType.any,
    );
    if (picked == null || !context.mounted) return;
    final bytes = Uint8List.fromList(await picked.readAsBytes());
    final filename = await repository.addFile(
      desiredName: picked.name,
      bytes: bytes,
    );
    if (!context.mounted) return;
    _insertAtSelection(controller, _markupFor(filename));
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not attach media: $error')),
      );
    }
  }
}

Future<void> _attachUrl(
  BuildContext context,
  MediaRepository repository,
  TextEditingController controller,
) async {
  final urlController = TextEditingController();
  try {
    final url = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Attach media from URL'),
        content: TextField(
          key: const ValueKey('media-url'),
          controller: urlController,
          autofocus: true,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'https://…',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) {
            final value = urlController.text.trim();
            if (value.isNotEmpty) Navigator.of(dialogContext).pop(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = urlController.text.trim();
              if (value.isNotEmpty) Navigator.of(dialogContext).pop(value);
            },
            child: const Text('Attach'),
          ),
        ],
      ),
    );
    if (url == null || !context.mounted) return;
    final filename = await repository.addFromUrl(url);
    if (!context.mounted) return;
    _insertAtSelection(controller, _markupFor(filename));
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not attach media: $error')),
      );
    }
  } finally {
    urlController.dispose();
  }
}

void _insertAtSelection(TextEditingController controller, String markup) {
  final selection = controller.selection;
  final text = controller.text;
  final start = selection.isValid ? selection.start.clamp(0, text.length) : text.length;
  final end = selection.isValid ? selection.end.clamp(start, text.length) : start;
  controller.value = TextEditingValue(
    text: text.replaceRange(start, end, markup),
    selection: TextSelection.collapsed(offset: start + markup.length),
  );
}

String _markupFor(String filename) {
  final escaped = _escapeHtml(filename);
  final extension = filename.contains('.')
      ? filename.split('.').last.toLowerCase()
      : '';
  const images = {'jpg', 'jpeg', 'png', 'gif', 'webp', 'svg', 'avif'};
  const audio = {'mp3', 'ogg', 'wav', 'm4a', 'flac', 'opus', 'aac'};
  const video = {'mp4', 'webm', 'mov', 'mkv', 'm4v'};
  if (images.contains(extension)) return '<img src="$escaped">';
  if (audio.contains(extension)) return '[sound:$filename]';
  if (video.contains(extension)) {
    return '<video controls src="$escaped"></video>';
  }
  return '<a href="$escaped">$escaped</a>';
}

String _escapeHtml(String value) => value
    .replaceAll('&', '&amp;')
    .replaceAll('"', '&quot;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;');

List<String> parseNoteTags(String input) => input
    .split(RegExp(r'\s+'))
    .where((tag) => tag.isNotEmpty)
    .toList(growable: false);
