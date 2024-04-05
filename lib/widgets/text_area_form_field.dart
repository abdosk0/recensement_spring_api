import 'package:flutter/material.dart';

class TextAreaFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final void Function(dynamic value)? onSubmit;

  const TextAreaFormField({
    Key? key,
    required this.label,
    required this.controller,
    required this.isRequired,  this.onSubmit,
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
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null, // Allows for unlimited number of lines
          onChanged: onSubmit,
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
