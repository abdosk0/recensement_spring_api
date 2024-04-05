import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../helpers/api_service.dart';
import '../helpers/authentification_service.dart';
import '../models/indicateur.dart';
import '../models/menage.dart';
import '../models/user.dart';
import '../widgets/customAppbar.dart';
import '../widgets/dynamic_indicator.dart';
import 'famille_form.dart';
import 'package:http/http.dart' as http;

class MenageIndicatorPage extends StatefulWidget {
  final Map<String, dynamic> responseData;
  final int numberOfFamilies;
  final Menage menage;

  const MenageIndicatorPage({
    super.key,
    required this.responseData,
    required this.numberOfFamilies,
    required this.menage,
  });

  @override
  _MenageIndicatorPageState createState() => _MenageIndicatorPageState();
}

class _MenageIndicatorPageState extends State<MenageIndicatorPage> {
  final ApiService _apiService = ApiService();
  late List<Indicateur> _menageIndicators = [];
  final AuthenticationService _authService = AuthenticationService();
  final Map<String, TextEditingController> controllersMap = {};

  @override
  void initState() {
    super.initState();
    _fetchMenageIndicators();
  }

  @override
  void dispose() {
    // Dispose all controllers in the map to prevent memory leaks
    for (var controller in controllersMap.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchMenageIndicators() async {
    try {
      // Simulating a delay for demonstration purposes
      await Future.delayed(const Duration(seconds: 2));

      final List<Indicateur> indicators = await _apiService.fetchIndicateurs(1);
      setState(() {
        _menageIndicators = indicators
            .where((indicateur) => indicateur.objectIndicateur == 'Ménage')
            .toList();

        // Initialize controllers after fetching indicators
        for (var indicateur in _menageIndicators) {
          controllersMap[indicateur.id.toString()] = TextEditingController();
        }
      });
    } catch (e) {
      print('Error fetching Menage indicators: $e');
    }
  }

  void _submitIndicateurPersonne() async {
    try {
      final String authToken = await _authService.fetchAuthToken();
      if (authToken.isNotEmpty) {
        // Fetch user data 
        final User? currentUser = await _authService.fetchCurrentUser();

        // Loop through each indicator and prepare the data
        final List<Map<String, dynamic>> postDataList = [];
        for (final indicateur in _menageIndicators) {
          final controller = controllersMap[indicateur.id.toString()];
          dynamic valeurToSubmit;
          switch (indicateur.type) {
            case 'Text':
            case 'Nombre':
            case 'Date':
            case 'TextArea':
              valeurToSubmit = controller?.text.trim();
              break;
            case 'Dropdown':
            case 'Radio':
              valeurToSubmit = indicateur.codeIndicateur; // Use codeIndicateur
              break;
            default:
              valeurToSubmit = null;
          }
          if (controller != null) {
            final indicateurPersonneData = {
              'valeurIndicateur': valeurToSubmit,
              'date': DateTime.now().toIso8601String(),
              'remarques': null,
              'enregistrePar': currentUser?.toJson(),
              'personne': null,
              'indicateur': indicateur.toJson(),
              'sousIndicateur': false,
              'resultatValeur': null,
              'menage': widget.menage.toMap(),
            };
            postDataList.add(indicateurPersonneData);
          }
        }

        // Post the IndicateurPersonne data for each indicator
        for (final postData in postDataList) {
          final response = await http.post(
            Uri.parse(
                'http://173.249.11.251:8080/recensement-1/indicateurPersonne/add'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(postData),
          );

          if (response.statusCode == 200) {
            print('IndicateurPersonne submitted successfully');
          } else {
            print(postDataList);
            print(
                'Error submitting IndicateurPersonne: ${response.statusCode}');
            throw Exception('Failed to submit IndicateurPersonne');
          }
        }

        // Show success message
        showSuccessMessage(context, 'Success', 'Data submitted successfully');
        Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FamilleForm(
                  responseData: widget.responseData,
                  numberOfFamilies: widget.numberOfFamilies,
                ),
              ),
            );
      } else {
        print('Failed to get authentication token.');
      }
    } catch (e) {
      print('Error submitting IndicateurPersonne: $e');
      // Show error message
      showErrorMessage(context, 'Error', 'Failed to submit data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Indicateurs Menage',
      ),
      body: _menageIndicators.isEmpty
          ? Center(
              child: Lottie.asset(
                'assets/animations/loading_indicator.json', // Path to the animation
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
          : ListView.builder(
              itemCount: _menageIndicators.length,
              itemBuilder: (context, index) {
                final indicateur = _menageIndicators[index];
                // Get the appropriate controller from the map
                final controller = controllersMap[indicateur.id.toString()];
                if (controller != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DynamicIndicatorItem(
                      indicateur: indicateur,
                      controller: controller,
                    ),
                  );
                } else {
                  return Container(); // Handle the case when controller is null
                }
              },
            ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            _submitIndicateurPersonne();
          },
          child: const Text('Submit'),
        ),
      ],
    );
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
