import 'package:flutter/material.dart';

import '../models/valeur_possible.dart';

class MultiSelectionFormField extends StatefulWidget {
  final String label;
  final List<ValeurPossible> valeursPossibles;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onChanged;
  final bool isRequired;

  const MultiSelectionFormField({
    Key? key,
    required this.label,
    required this.valeursPossibles,
    required this.selectedOptions,
    required this.onChanged, required this.isRequired,
  }) : super(key: key);

  @override
  _MultiSelectionFormFieldState createState() =>
      _MultiSelectionFormFieldState();
}

class _MultiSelectionFormFieldState extends State<MultiSelectionFormField> {
  List<String> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions.addAll(widget.selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: widget.valeursPossibles.map((value) {
            return FilterChip(
              label: Text(value.nomValeur),
              selected: _selectedOptions.contains(value.nomValeur),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedOptions.add(value.nomValeur);
                  } else {
                    _selectedOptions.remove(value.nomValeur);
                  }
                  widget.onChanged(_selectedOptions);
                });
              },
              selectedColor: Color(0xFFA1F0F2),
              backgroundColor: Color(0xFF008A90),
              labelStyle: TextStyle(color: Colors.black),
              checkmarkColor: Colors.black,
              
            );
          }).toList(),
        ),
        if (widget.isRequired && _selectedOptions.isEmpty)
          const Text(
            'Ce champ est obligatoire',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
