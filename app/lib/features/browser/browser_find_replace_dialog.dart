import 'package:anki_flutter/features/browser/data/anki_card_browser_repository.dart';
import 'package:flutter/material.dart';

/// Native Find & Replace is scoped by the caller to explicitly selected notes.
class BrowserFindReplaceDialog extends StatefulWidget {
  const BrowserFindReplaceDialog({required this.cardCount, super.key});

  final int cardCount;

  @override
  State<BrowserFindReplaceDialog> createState() =>
      _BrowserFindReplaceDialogState();
}

class _BrowserFindReplaceDialogState extends State<BrowserFindReplaceDialog> {
  final _findController = TextEditingController();
  final _replaceController = TextEditingController();
  final _fieldController = TextEditingController();
  bool _regex = false;
  bool _matchCase = false;

  @override
  void dispose() {
    _findController.dispose();
    _replaceController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Find and replace'),
    content: SizedBox(
      width: 440,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Replace text in notes belonging to ${widget.cardCount} '
              'selected ${widget.cardCount == 1 ? 'card' : 'cards'}. '
              'Sibling cards sharing a note will also change.',
            ),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('browser-find-text'),
              controller: _findController,
              autofocus: true,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Find',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              key: const ValueKey('browser-replacement-text'),
              controller: _replaceController,
              decoration: const InputDecoration(
                labelText: 'Replace with (can be empty)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              key: const ValueKey('browser-replacement-field'),
              controller: _fieldController,
              decoration: const InputDecoration(
                labelText: 'Field name (optional)',
                hintText: 'Blank: search all note fields',
                border: OutlineInputBorder(),
              ),
            ),
            SwitchListTile(
              key: const ValueKey('browser-replacement-regex'),
              contentPadding: EdgeInsets.zero,
              title: const Text('Regular expression'),
              value: _regex,
              onChanged: (next) => setState(() => _regex = next),
            ),
            SwitchListTile(
              key: const ValueKey('browser-replacement-case'),
              contentPadding: EdgeInsets.zero,
              title: const Text('Match case'),
              value: _matchCase,
              onChanged: (next) => setState(() => _matchCase = next),
            ),
            const Text(
              'Anki will apply this directly to the selected notes. '
              'Make a backup before bulk replacements.',
            ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
      FilledButton(
        key: const ValueKey('browser-confirm-find-replace'),
        onPressed: _findController.text.trim().isEmpty
            ? null
            : () => Navigator.of(context).pop(
                CardBrowserFindReplaceOptions(
                  search: _findController.text,
                  replacement: _replaceController.text,
                  fieldName: _fieldController.text,
                  regex: _regex,
                  matchCase: _matchCase,
                ),
              ),
        child: const Text('Replace in selected notes'),
      ),
    ],
  );
}
