import 'package:flutter/material.dart';

import '../models/valeur_possible.dart';

class DropdownFormField extends StatelessWidget {
  final String label;
  final List<ValeurPossible> valeursPossibles;
  final String? selectedOption;
  final ValueChanged<String?> onChanged;
  final bool isRequired;

  const DropdownFormField({
    Key? key,
    required this.label,
    required this.valeursPossibles,
    required this.selectedOption,
    required this.onChanged, required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedOption,
          onChanged: onChanged,
          items: valeursPossibles.map((value) {
            return DropdownMenuItem<String>(
              value: value.nomValeur,
              child: Text(value.nomValeur),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFA1F0F2),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFFA1F0F2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFF008A90)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          style: TextStyle(color: Colors.black),
          validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter some text';
        }
        return null;
      },
        ),
      ],
    );
  }
}
