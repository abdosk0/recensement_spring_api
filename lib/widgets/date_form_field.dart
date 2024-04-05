import 'package:flutter/material.dart';

class DateFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final void Function(dynamic value)? onSubmit; // Added onSubmit function

  const DateFormField({
    Key? key,
    required this.label,
    required this.controller,
    required this.isRequired,
    this.onSubmit, // Added onSubmit parameter
  }) : super(key: key);

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        widget.controller.text = pickedDate.toString(); // Update controller text
      });

      if (widget.onSubmit != null) {
        widget.onSubmit!(pickedDate); // Call onSubmit function with pickedDate
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFA1F0F2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFFA1F0F2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFF008A90)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (widget.isRequired && (value == null || value.isEmpty)) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
