import 'dart:async';

import 'package:anki_flutter/core/backend/generated/anki/decks.pb.dart'
    as decks;
import 'package:anki_flutter/features/decks/data/anki_filtered_deck_options_repository.dart';
import 'package:flutter/material.dart';

/// Edits a filtered deck using the official Anki config protobuf. Fields
/// not shown in the form remain untouched in the snapshot that is saved.
class FilteredDeckOptionsPage extends StatefulWidget {
  const FilteredDeckOptionsPage({
    required this.deckId,
    required this.repository,
    this.onChanged,
    super.key,
  });

  final int deckId;
  final FilteredDeckOptionsRepository repository;
  final Future<void> Function()? onChanged;

  @override
  State<FilteredDeckOptionsPage> createState() =>
      _FilteredDeckOptionsPageState();
}

class _SearchFields {
  _SearchFields(decks.Deck_Filtered_SearchTerm term)
    : query = TextEditingController(text: term.search),
      limit = TextEditingController(text: '${term.limit}'),
      order = term.order;

  final TextEditingController query;
  final TextEditingController limit;
  decks.Deck_Filtered_SearchTerm_Order order;

  void dispose() {
    query.dispose();
    limit.dispose();
  }
}

class _FilteredDeckOptionsPageState extends State<FilteredDeckOptionsPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _terms = <_SearchFields>[];
  decks.FilteredDeckForUpdate? _snapshot;
  bool _loading = true;
  bool _saving = false;
  bool _reschedule = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    if (mounted) setState(() { _loading = true; _error = null; });
    try {
      final loaded = await widget.repository.load(widget.deckId);
      if (!mounted) return;
      for (final term in _terms) {
        term.dispose();
      }
      _terms.clear();
      _terms.addAll(loaded.config.searchTerms.map(_SearchFields.new));
      // The backend should provide at least one search. A default empty term
      // allows editing a malformed or migrated config without data loss.
      if (_terms.isEmpty) {
        _terms.add(_SearchFields(decks.Deck_Filtered_SearchTerm(
          search: '',
          limit: 100,
          order: decks.Deck_Filtered_SearchTerm_Order.DUE,
        )));
      }
      _name.text = loaded.name;
      setState(() {
        _snapshot = loaded.deepCopy();
        _reschedule = loaded.config.reschedule;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load filtered deck settings: $error';
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _name.dispose();
    for (final term in _terms) {
      term.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final snapshot = _snapshot;
    if (snapshot == null || _saving || !_formKey.currentState!.validate()) {
      return;
    }
    final draft = snapshot.deepCopy()
      ..name = _name.text.trim()
      ..allowEmpty = snapshot.allowEmpty;
    draft.config.reschedule = _reschedule;
    draft.config.searchTerms.clear();
    for (final term in _terms) {
      draft.config.searchTerms.add(decks.Deck_Filtered_SearchTerm(
        search: term.query.text.trim(),
        limit: int.parse(term.limit.text.trim()),
        order: term.order,
      ));
    }

    setState(() { _saving = true; _error = null; });
    try {
      await widget.repository.save(draft);
      await widget.onChanged?.call();
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = 'Could not save filtered deck settings: $error';
      });
    }
  }

  void _addSearch() {
    if (_saving || _terms.length >= 2) return;
    setState(() {
      _terms.add(_SearchFields(decks.Deck_Filtered_SearchTerm(
        search: '',
        limit: 100,
        order: decks.Deck_Filtered_SearchTerm_Order.DUE,
      )));
    });
  }

  void _removeSecondSearch() {
    if (_saving || _terms.length != 2) return;
    final removed = _terms.removeLast();
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) => removed.dispose());
  }

  String _orderName(decks.Deck_Filtered_SearchTerm_Order value) {
    switch (value) {
      case decks.Deck_Filtered_SearchTerm_Order.OLDEST_REVIEWED_FIRST:
        return 'Oldest reviewed first';
      case decks.Deck_Filtered_SearchTerm_Order.RANDOM:
        return 'Random';
      case decks.Deck_Filtered_SearchTerm_Order.INTERVALS_ASCENDING:
        return 'Shortest interval first';
      case decks.Deck_Filtered_SearchTerm_Order.INTERVALS_DESCENDING:
        return 'Longest interval first';
      case decks.Deck_Filtered_SearchTerm_Order.LAPSES:
        return 'Most lapses';
      case decks.Deck_Filtered_SearchTerm_Order.ADDED:
        return 'Order added';
      case decks.Deck_Filtered_SearchTerm_Order.DUE:
        return 'Due date';
      case decks.Deck_Filtered_SearchTerm_Order.REVERSE_ADDED:
        return 'Reverse added';
      case decks.Deck_Filtered_SearchTerm_Order.RETRIEVABILITY_ASCENDING:
        return 'Lowest retrievability';
      case decks.Deck_Filtered_SearchTerm_Order.RETRIEVABILITY_DESCENDING:
        return 'Highest retrievability';
      case decks.Deck_Filtered_SearchTerm_Order.RELATIVE_OVERDUENESS:
        return 'Relative overdueness';
    }
    return value.name;
  }

  Widget _searchEditor(int index) {
    final term = _terms[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('Search ${index + 1}',
              style: Theme.of(context).textTheme.titleMedium)),
            if (index == 1)
              TextButton.icon(
                key: const ValueKey('filtered-options-remove-second'),
                onPressed: _saving ? null : _removeSecondSearch,
                icon: const Icon(Icons.remove_circle_outline),
                label: const Text('Remove'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          key: ValueKey('filtered-options-query-$index'),
          controller: term.query,
          enabled: !_saving,
          decoration: const InputDecoration(
            labelText: 'Search cards',
            hintText: 'deck:French is:due',
            border: OutlineInputBorder(),
          ),
          validator: (text) => text == null || text.trim().isEmpty
              ? 'Enter an Anki search query.'
              : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          key: ValueKey('filtered-options-limit-$index'),
          controller: term.limit,
          enabled: !_saving,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Maximum cards',
            border: OutlineInputBorder(),
          ),
          validator: (text) {
            final parsed = int.tryParse(text?.trim() ?? '');
            if (parsed == null || parsed < 1 || parsed > 1000000) {
              return 'Enter a number from 1 to 1,000,000.';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<decks.Deck_Filtered_SearchTerm_Order>(
          key: ValueKey('filtered-options-order-$index'),
          initialValue: term.order,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Sort matching cards',
            border: OutlineInputBorder(),
          ),
          items: [
            for (final order in decks.Deck_Filtered_SearchTerm_Order.values)
              DropdownMenuItem(value: order, child: Text(_orderName(order))),
          ],
          onChanged: _saving ? null : (order) {
            if (order != null) setState(() => term.order = order);
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckId == 0
            ? 'Create filtered deck'
            : 'Filtered deck options'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _snapshot == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_error ?? 'Filtered deck settings unavailable.'),
                      TextButton(onPressed: _load, child: const Text('Retry')),
                    ],
                  ),
                )
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      TextFormField(
                        key: const ValueKey('filtered-options-name'),
                        controller: _name,
                        enabled: !_saving,
                        decoration: const InputDecoration(
                          labelText: 'Deck name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (text) => text == null || text.trim().isEmpty
                            ? 'Enter a deck name.'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      for (var index = 0; index < _terms.length; index++)
                        _searchEditor(index),
                      if (_terms.length < 2)
                        OutlinedButton.icon(
                          key: const ValueKey('filtered-options-add-search'),
                          onPressed: _saving ? null : _addSearch,
                          icon: const Icon(Icons.add),
                          label: const Text('Add second search'),
                        ),
                      SwitchListTile(
                        key: const ValueKey('filtered-options-reschedule'),
                        title: const Text('Reschedule cards based on my answers'),
                        subtitle: const Text(
                          'If disabled, reviewing here does not affect original scheduling.',
                        ),
                        value: _reschedule,
                        onChanged: _saving ? null : (value) =>
                            setState(() => _reschedule = value),
                      ),
                      const SizedBox(height: 10),
                      if (_error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(_error!, style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          )),
                        ),
                      FilledButton.icon(
                        key: const ValueKey('filtered-options-save'),
                        onPressed: _saving ? null : _save,
                        icon: _saving
                            ? const SizedBox(width: 16, height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.save),
                        label: Text(widget.deckId == 0
                            ? 'Create filtered deck'
                            : 'Save filtered deck'),
                      ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
