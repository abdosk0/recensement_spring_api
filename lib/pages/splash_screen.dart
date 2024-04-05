import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("home");
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(), // Cover the entire screen
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF7F9FF),
            Color(0xFFE7F6FF),
            Color(0xFFD3F4FF),
            Color(0xFFBDF2FF),
            Color(0xFFA9E9F3),
            Color(0xFF95DFE7),
            Color(0xFF81D6D9),
            Color(0xFF69C3C6),
            Color(0xFF4FAFB4),
            Color(0xFF339CA2),
            Color(0xFF008A90),
          ],
        ),
      ),
      child: Image.asset(
        "assets/images/LogoCensus.png",
        fit: BoxFit.contain, // Adjust the image size to fit the container
      ),
    );
  }
}
