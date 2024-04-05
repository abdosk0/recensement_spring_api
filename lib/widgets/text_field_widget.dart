import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? isRequired;
  final void Function(dynamic value)? onSubmit;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.labelText,
    this.enabled = true,
    this.keyboardType,
    this.validator, this.isRequired, this.onSubmit, // Added validator parameter
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
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          onChanged: onSubmit,
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
          validator: (value) {
        if (isRequired! && (value == null || value.isEmpty)) {
          return 'Please enter some text';
        }
        return null;
      },
        )
      ],
    );
  }
}
