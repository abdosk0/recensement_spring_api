import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: const Color(0xFF008A90),
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFFFFFFFF)),
      ),
      automaticallyImplyLeading: showBackButton, // Show back button if showBackButton is true
      leading: showBackButton ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop(); // Navigate back when back button is pressed
        },
      ) : null, // Hide back button if showBackButton is false
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
