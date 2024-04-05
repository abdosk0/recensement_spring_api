import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CardMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        color: const Color(0xFF008A90),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFFFFFFF),
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}