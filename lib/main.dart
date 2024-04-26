import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/menage/menage_form.dart';
import 'pages/menage/menage_list_page.dart';
import 'pages/menu.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recensement Demo',
      home: const SplashScreen(),
      routes: {
        "home": (context) => const HomePage(),
        "menu": (context) => const Menu(),
        "menage": (context) => const MenageForm(),
        "menageList": (context) =>  MenageListPage(),
      },
    );
  }
}
