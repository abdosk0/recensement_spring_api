import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

class AuthenticationService {
  String apiUrl =
      'http://173.249.11.251:8080/recensement-1/api/auth/authenticate';

  Future<void> signIn(
      String username, String password, BuildContext context) async {
    final Map<String, dynamic> postData = {
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('token') &&
            responseData['token'] != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("menu", (route) => false);
          showSuccessMessage(context, 'Bienvenue', 'Bonjour, Mr $username');
        } else {
          showErrorMessage(context, 'Authentication failed',
              'Please check your credentials');
        }
      }
    } catch (error) {
      showErrorMessage(
          context, 'Error', 'Error during authentication. Please try again.');
    }
  }

  Future<String> fetchAuthToken() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': 'test', 'password': 'test123'}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String authToken = responseData['token'];
        return authToken;
      } else {
        throw Exception(
            'Failed to fetch authentication token. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching authentication token: $e');
      throw Exception('Failed to fetch authentication token. Error: $e');
    }
  }

  Future<User?> fetchCurrentUser() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'username': 'test', 'password': 'test123'}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return User.fromJson(responseData);
      } else {
        print('Failed to fetch current user: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching current user: $e');
      return null;
    }
  }

  void showErrorMessage(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.failure,
        ),
      ),
    );
  }

  void showSuccessMessage(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.success,
        ),
      ),
    );
  }
}
