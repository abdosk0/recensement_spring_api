import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recensement_app_spring/models/famille.dart';
import 'package:recensement_app_spring/models/personne.dart';
import '../helpers/api_service.dart';
import '../helpers/authentification_service.dart';
import '../models/indicateur.dart';
import '../models/user.dart';
import '../widgets/customAppbar.dart';
import '../widgets/dynamic_indicator.dart';
import 'package:http/http.dart' as http;

class PersonneIndicatorPage extends StatefulWidget {
  final List<Famille> familles;
  final Personne personne;

  const PersonneIndicatorPage({
    Key? key, required this.familles, required this.personne,
  }) : super(key: key);

  @override
  _PersonneIndicatorPageState createState() => _PersonneIndicatorPageState();
}

class _PersonneIndicatorPageState extends State<PersonneIndicatorPage> {
  final ApiService _apiService = ApiService();
  late List<Indicateur> _perosnneIndicators = [];
  bool _showLoading = false;
  final AuthenticationService _authService = AuthenticationService();
  final Map<String, TextEditingController> controllersMap = {};
  Map<int, dynamic> selectedValuesMap = {};

  @override
  void initState() {
    super.initState();
    _fetchPersonneIndicators();
  }

  @override
  void dispose() {
    for (var controller in controllersMap.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchPersonneIndicators() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final List<Indicateur> indicators = await _apiService.fetchIndicateurs(1);
      setState(() {
        _perosnneIndicators = indicators
            .where((indicateur) => indicateur.objectIndicateur == 'Personne')
            .toList();

        // Initialize controllers after fetching indicators
        for (var indicateur in _perosnneIndicators) {
          controllersMap[indicateur.id.toString()] = TextEditingController();
          selectedValuesMap[indicateur.id] = null;
        }
      });
    } catch (e) {
      print('Error fetching Personne indicators: $e');
    }
  }

  void _submitIndicateurPersonne() async {
    setState(() {
      _showLoading = true;
    });
    try {
      final String authToken = await _authService.fetchAuthToken();
      if (authToken.isNotEmpty) {
        final User? currentUser = await _authService.fetchCurrentUser();

        for (final indicateur in _perosnneIndicators) {
          final controller = controllersMap[indicateur.id.toString()];
          bool? requireSousIndicateur;
          int? selectedId = 0;
          for (var i = 0; i < indicateur.valeursPossibles.length; i++) {
            selectedId = indicateur.valeursPossibles[i].id;
            requireSousIndicateur =
                indicateur.valeursPossibles[i].requireSousIndicateur!;
          }

          dynamic valeurToSubmit;
          dynamic resultatValeur;

          switch (indicateur.type) {
            case 'Text':
            case 'Nombre':
            case 'Date':
            case 'TextArea':
              valeurToSubmit = controller?.text.trim();
              resultatValeur = null;
              break;
            case 'Dropdown':
            case 'Radio':
            case 'Multiselection':
              valeurToSubmit = indicateur.codeIndicateur;
              resultatValeur = {
                'id': selectedId,
                'nomValeur': selectedValuesMap[indicateur.id],
                'requireSousIndicateur': requireSousIndicateur,
              };

            default:
              valeurToSubmit = null;
          }

          if (controller != null) {
            final indicatorData = {
              'valeurIndicateur': valeurToSubmit,
              'date': DateTime.now().toIso8601String(),
              'remarques': null,
              'enregistrePar': currentUser?.toJson(),
              'personne': widget.personne.toMap(),
              'indicateur': indicateur.toJson(),
              'sousIndicateur': null,
              'resultatValeur': resultatValeur,
              'menage': null,
            };

            final response = await http.post(
              Uri.parse(
                  'http://173.249.11.251:8080/recensement-1/indicateurPersonne/add'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(indicatorData),
            );

            if (response.statusCode == 201) {
              print(
                  'IndicateurPersonne submitted successfully for ${indicateur.id}');
            } else {
              throw Exception(
                  'Failed to submit IndicateurPersonne for ${indicateur.id}');
            }
          }
        }
        setState(() {
          _showLoading = false;
        });

        // Show success message after all indicators are submitted
        showSuccessMessage(context, 'Success', 'Data submitted successfully');
      } else {
        print('Failed to get authentication token.');
      }
    } catch (e) {
      setState(() {
        _showLoading = false;
      });
      print('Error submitting All IndicateurPersonne: $e');
      // Show error message
      showErrorMessage(context, 'Error', 'Failed to submit data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Indicateurs Personne',
      ),
      body: Stack(
        children: [
          _buildBodyContent(), // Your existing body content
          if (_showLoading)
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
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
            onPressed: _showLoading ? null : _submitIndicateurPersonne,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA1F0F2),
              fixedSize: const Size(200, 50),
            ),
            child: const Text(
              'Ajouter les indicateurs',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyContent() {
    return _perosnneIndicators.isEmpty
        ? Center(
            child: Lottie.asset(
              'assets/animations/loading_indicator.json',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        : ListView.builder(
            itemCount: _perosnneIndicators.length,
            itemBuilder: (context, index) {
              final indicateur = _perosnneIndicators[index];
              final controller = controllersMap[indicateur.id.toString()];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DynamicIndicatorItem(
                  indicateur: indicateur,
                  controller: controller!,
                  selectedValue: selectedValuesMap[indicateur.id],
                  onValueSelected: (value) {
                    setState(() {
                      selectedValuesMap[indicateur.id] = value;
                    });
                  },
                ),
              );
            },
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
