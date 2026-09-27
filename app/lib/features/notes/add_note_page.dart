import 'dart:async';

import 'package:anki_flutter/features/decks/deck_node.dart';
import 'package:anki_flutter/features/notes/data/anki_note_repository.dart';
import 'package:anki_flutter/core/backend/generated/anki/notes.pb.dart' as notes;
import 'package:anki_flutter/core/backend/generated/anki/notetypes.pb.dart'
    as notetypes;
import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({
    required this.deck,
    required this.repository,
    super.key,
  });

  final DeckNode deck;
  final NoteEntryRepository repository;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  List<notetypes.NotetypeNameIdUseCount> _notetypes = [];
  notetypes.Notetype? _selectedNotetype;
  notes.Note? _note;
  List<TextEditingController> _fields = [];
  int? _selectedNotetypeId;
  int _generation = 0;
  bool _loading = true;
  bool _saving = false;
  bool _noNotetypes = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_loadInitial());
  }

  Future<void> _loadInitial() async {
    final generation = ++_generation;
    setState(() {
      _loading = true;
      _error = null;
      _noNotetypes = false;
    });

    try {
      final notetypes = await widget.repository.getNotetypeNamesAndCounts();
      if (!_isCurrent(generation)) return;
      if (notetypes.entries.isEmpty) {
        setState(() {
          _notetypes = [];
          _selectedNotetypeId = null;
          _noNotetypes = true;
          _loading = false;
        });
        return;
      }

      _notetypes = notetypes.entries.toList(growable: false);
      final defaults = await widget.repository.defaultsForAdding(widget.deck.id);
      if (!_isCurrent(generation)) return;
      final defaultId = defaults.notetypeId.toInt();
      final selected = _notetypes.any((entry) => entry.id.toInt() == defaultId)
          ? defaultId
          : _notetypes.first.id.toInt();
      await _loadNotetype(selected);
    } catch (error) {
      if (_isCurrent(generation)) {
        setState(() {
          _loading = false;
          _error = error;
        });
      }
    }
  }

  Future<void> _loadNotetype(int notetypeId) async {
    final generation = ++_generation;
    setState(() {
      _selectedNotetypeId = notetypeId;
      _selectedNotetype = null;
      _note = null;
      _loading = true;
      _error = null;
    });
    _disposeFields();

    try {
      final type = await widget.repository.getNotetype(notetypeId);
      if (!_isCurrent(generation)) return;
      final note = await widget.repository.newNote(notetypeId);
      if (!_isCurrent(generation)) return;

      _fields = [
        for (final value in note.fields)
          TextEditingController(text: value),
      ];
      setState(() {
        _selectedNotetype = type;
        _note = note;
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
    final notetypeId = _selectedNotetypeId;
    if (note == null || notetypeId == null || _saving || _loading) return;

    setState(() {
      _saving = true;
      _error = null;
    });
    final submittedNote = notes.Note.fromBuffer(note.writeToBuffer());
    submittedNote.fields
      ..clear()
      ..addAll(_fields.map((field) => field.text));

    try {
      await widget.repository.addNote(
        deckId: widget.deck.id,
        note: submittedNote,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note added')),
      );
      await _loadNotetype(notetypeId);
    } catch (error) {
      if (mounted) {
        setState(() => _error = error);
      }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add note to ${widget.deck.name}')),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading && _selectedNotetype == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_noNotetypes) {
      return const Center(child: Text('This collection has no note types.'));
    }
    if (_selectedNotetype == null || _note == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Could not load note types: $_error'),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: _loading ? null : _loadInitial,
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
        DropdownButtonFormField<int>(
          initialValue: _selectedNotetypeId,
          decoration: const InputDecoration(labelText: 'Note type'),
          items: [
            for (final notetype in _notetypes)
              DropdownMenuItem(
                value: notetype.id.toInt(),
                child: Text(notetype.name),
              ),
          ],
          onChanged: _loading || _saving
              ? null
              : (id) {
                  if (id != null && id != _selectedNotetypeId) {
                    unawaited(_loadNotetype(id));
                  }
                },
        ),
        const SizedBox(height: 16),
        for (var index = 0; index < _fields.length; index++) ...[
          TextField(
            key: ValueKey('note-field-$index'),
            controller: _fields[index],
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: index < _selectedNotetype!.fields.length
                  ? _selectedNotetype!.fields[index].name
                  : 'Field ${index + 1}',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (_error case final error?) ...[
          Text(
            'Could not add note: $error',
            key: const ValueKey('add-note-error'),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 12),
        ],
        FilledButton.icon(
          onPressed: _saving || _loading ? null : _save,
          icon: _saving
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add),
          label: const Text('Add note'),
        ),
      ],
    );
  }
}
