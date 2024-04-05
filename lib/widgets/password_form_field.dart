import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.onPasswordChanged,
    required this.initialPassword,
  });

  final ValueChanged<String> onPasswordChanged;
  final String initialPassword;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  late String password;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    password = widget.initialPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        initialValue: widget.initialPassword,
        onChanged: (value) {
          setState(() {
            password = value;
            widget.onPasswordChanged(password);
          });
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFEEEEEE)),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFFEEEEEE)),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          labelText: 'Password',
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
