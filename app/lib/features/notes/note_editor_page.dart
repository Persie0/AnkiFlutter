import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:anki_flutter/features/media/data/anki_media_repository.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/features/notes/note_fields_form.dart';
import 'package:flutter/material.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage.edit({
    required this.noteId,
    required this.repository,
    super.key,
  });

  final int noteId;
  final NoteEntryRepository repository;

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  notes.Note? _note;
  notetypes.Notetype? _notetype;
  List<TextEditingController> _fields = [];
  final TextEditingController _tags = TextEditingController();
  int _generation = 0;
  bool _loading = true;
  bool _saving = false;
  Object? _error;

  MediaRepository? get _mediaRepository {
    final repository = widget.repository;
    return repository is AnkiNoteRepository
        ? AnkiMediaRepository(backend: repository.backend)
        : null;
  }

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final generation = ++_generation;
    setState(() {
      _loading = true;
      _error = null;
    });
    _disposeFields();
    try {
      final note = await widget.repository.getNote(widget.noteId);
      if (!_isCurrent(generation)) return;
      final notetype = await widget.repository.getNotetype(
        note.notetypeId.toInt(),
      );
      if (!_isCurrent(generation)) return;

      _fields = [
        for (final value in note.fields) TextEditingController(text: value),
      ];
      _tags.text = note.tags.join(' ');
      setState(() {
        _note = note;
        _notetype = notetype;
        _loading = false;
      });
    } catch (error) {
      if (_isCurrent(generation)) {
        setState(() {
          _loading = false;
          _error = error;
        });
      }
    }
  }

  Future<void> _save() async {
    final note = _note;
    if (note == null || _saving || _loading) return;

    setState(() {
      _saving = true;
      _error = null;
    });
    final updated = notes.Note.fromBuffer(note.writeToBuffer());
    updated.fields
      ..clear()
      ..addAll(_fields.map((field) => field.text));
    updated.tags
      ..clear()
      ..addAll(parseNoteTags(_tags.text));
    try {
      await widget.repository.updateNote(updated);
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  bool _isCurrent(int generation) => mounted && generation == _generation;

  void _disposeFields() {
    for (final field in _fields) {
      field.dispose();
    }
    _fields = [];
  }

  @override
  void dispose() {
    _generation++;
    _disposeFields();
    _tags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit note')),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_note == null && _loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_note == null || _notetype == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Could not load note: $_error', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: _loading ? null : _load,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        NoteFieldsForm(
          fields: _fields,
          fieldNames: _notetype!.fields.map((field) => field.name).toList(),
          tagsController: _tags,
          busy: _saving,
          error: _error,
          errorKey: 'edit-note-error',
          errorPrefix: 'Could not save note',
          saveLabel: 'Save note',
          saveIcon: Icons.save,
          onSave: _save,
          mediaRepository: _mediaRepository,
        ),
      ],
    );
  }
}
