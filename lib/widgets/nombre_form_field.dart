import 'package:flutter/material.dart';

class NombreFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final void Function(dynamic value)? onSubmit;
  final bool isRequired;

  const NombreFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.onSubmit,
    required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onSubmit,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF008A90),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFFA1F0F2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFF008A90)),
            ),
            labelStyle: const TextStyle(color: Color(0xFFFFFFFF)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          style: const TextStyle(color: Color(0xFFFFFFFF)),
        ),
        if (isRequired && controller.text.isEmpty)
          const Text(
            'Ce champ est obligatoire',
            style: const TextStyle(color: Colors.red),
          ),
        if (!isRequired ||
            !controller
                .text.isEmpty) // Added condition to hide the error message
          const SizedBox(
              height:
                  0), // Placeholder to occupy space but not display anything
      ],
    );
  }
}
