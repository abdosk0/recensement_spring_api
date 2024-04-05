import 'package:flutter/material.dart';

class CustomMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomMainAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isRootPage = ModalRoute.of(context)?.isFirst ?? true;

    return AppBar(
      elevation: 0.0,
      backgroundColor: const Color(0xFF008A90),
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFFFFFFFF)),
      ),
      leading: showBackButton && !isRootPage
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app_sharp),
          onPressed: () {
            _logout(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void _logout(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
}
