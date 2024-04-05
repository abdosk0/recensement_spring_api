import 'package:flutter/material.dart';

class UsernameFormField extends StatefulWidget {
  const UsernameFormField({
    super.key,
    required this.onUsernameChanged,
    required this.initialUsername,
  });

  final ValueChanged<String> onUsernameChanged;
  final String initialUsername;

  @override
  State<UsernameFormField> createState() => _UsernameFormFieldState();
}

class _UsernameFormFieldState extends State<UsernameFormField> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.initialUsername;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        initialValue: widget.initialUsername,
        onChanged: (value) {
          setState(() {
            username = value;
            widget.onUsernameChanged(
                username); // Notify parent widget about the username change
          });
        },
        decoration: InputDecoration(
          prefixIcon:
              const Icon(Icons.person_outline, color: Color(0xFFEEEEEE)),
          labelText: 'Username',
          filled: true,
          fillColor: const Color(0xFF008A90),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF393E46)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF00ADB5)),
          ),
          labelStyle: const TextStyle(color: Color(0xFFEEEEEE)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        style: const TextStyle(color: Color(0xFFEEEEEE)),
      ),
    );
  }
}
