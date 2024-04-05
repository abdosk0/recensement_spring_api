import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../helpers/authentification_service.dart';
import '../widgets/password_form_field.dart';
import '../widgets/username_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _username;
  late String _password;
  bool _isLoading = false;
  final AuthenticationService authService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _username = '';
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/loginLogo.png'),
                    const SizedBox(height: 40),
                    UsernameFormField(
                      initialUsername: _username,
                      onUsernameChanged: (newUsername) {
                        setState(() {
                          _username = newUsername;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    PasswordFormField(
                      initialPassword: _password,
                      onPasswordChanged: (newPassword) {
                        setState(() {
                          _password = newPassword;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          _isLoading || _username.isEmpty || _password.isEmpty
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await authService.signIn(
                                      _username, _password, context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA1F0F2),
                        fixedSize: const Size(200, 50),
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Lottie.asset(
                  'assets/animations/loading_animation.json',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
