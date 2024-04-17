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
    this.validator,
    this.isRequired,
    this.onSubmit,
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
          onChanged: (value) {
            if (onSubmit != null) {
              onSubmit!(value);
            }
          },
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
            errorText: isRequired ?? false
                ? 'Please enter some text'
                : null,
          ),
          style: const TextStyle(color: Color(0xFFFFFFFF)),
          validator: (value) {
            return validator != null ? validator!(value) : null;
          },
        )
      ],
    );
  }
}
