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
            maxLines: 5,
            decoration: InputDecoration(
              labelText: index < fieldNames.length
                  ? fieldNames[index]
                  : 'Field ${index + 1}',
              alignLabelWithHint: true,
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

List<String> parseNoteTags(String input) => input
    .split(RegExp(r'\s+'))
    .where((tag) => tag.isNotEmpty)
    .toList(growable: false);
