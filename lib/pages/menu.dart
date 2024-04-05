import 'package:flutter/material.dart';

import '../widgets/card_menu.dart';
import '../widgets/custom_main_appbar.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomMainAppBar(title: "Menu"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardMenu(
              text: 'Nouvel Enregistrement',
              icon: Icons.add_home,
              onPressed: () {
                Navigator.of(context).pushNamed("menage");
              },
            ),
            const SizedBox(height: 20),
            CardMenu(
              text: 'Prêt à Envoyé',
              icon: Icons.send,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            CardMenu(
              text: 'Envoyés',
              icon: Icons.send,
              onPressed: () {
                Navigator.pushNamed(context, 'menageList');
              },
            ),
            const SizedBox(height: 20),
            CardMenu(
              text: 'Infos Générales',
              icon: Icons.info,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
