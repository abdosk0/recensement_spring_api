import 'package:flutter/material.dart';

import '../models/valeur_possible.dart';

class RadioFormField extends StatelessWidget {
  final String label;
  final List<ValeurPossible> valeursPossibles;
  final ValueChanged<String?> onChanged;
  final String? selectedOption;
  final bool isRequired;

  const RadioFormField({
    Key? key,
    required this.label,
    required this.valeursPossibles,
    required this.onChanged,
    required this.selectedOption, required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 8),
        Column(
          children: valeursPossibles.map((value) {
            return RadioListTile<String>(
              title: Text(
                value.nomValeur,
                style: TextStyle(color: Colors.black),
              ),
              value: value.nomValeur,
              groupValue: selectedOption,
              onChanged: (newValue) {
                onChanged(newValue);
              },
              activeColor: Color(0xFF008A90),
            );
          }).toList(),
        ),
        if (isRequired && selectedOption == null)
          Text(
            'Ce champ est obligatoire',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
