import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../models/menage.dart';
import '../../widgets/customAppbar.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/ville_dropdown.dart';
import 'menage_indicateur_page.dart';

class MenageForm extends StatefulWidget {
  const MenageForm({super.key});

  @override
  _MenageFormState createState() => _MenageFormState();
}

class _MenageFormState extends State<MenageForm> {
  final TextEditingController _nomMenageController = TextEditingController();
  final TextEditingController _adresseMenageController =
      TextEditingController();
  final TextEditingController _quartierMenageController =
      TextEditingController();
  final TextEditingController _nombreFamillesController =
      TextEditingController();

  List<Map<String, dynamic>> _citiesData = [];
  String _selectedCity = '';

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    try {
      String citiesJson =
          await rootBundle.loadString('assets/json/ma_cities.json');
      _citiesData = jsonDecode(citiesJson).cast<Map<String, dynamic>>();
      setState(() {
        _selectedCity = _citiesData.isNotEmpty ? _citiesData[0]['city'] : '';
      });
    } catch (e) {
      print('Error loading cities: $e');
    }
  }

  void _addMenage(BuildContext context) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'Confirmation',
      desc: 'Êtes-vous sûr de vouloir sauvegarder ce menage ?',
      btnCancelOnPress: () {},
      btnCancelText: 'Anuller',
      btnOkOnPress: () {
        _saveMenage(context);
      },
      btnOkText: 'Sauvegarder',
    ).show();
  }

  void _saveMenage(BuildContext context) async {
    if (_nomMenageController.text.isNotEmpty &&
        _adresseMenageController.text.isNotEmpty &&
        _quartierMenageController.text.isNotEmpty &&
        _selectedCity.isNotEmpty &&
        _nombreFamillesController.text.isNotEmpty) {
      int numberOfFamilies = int.parse(_nombreFamillesController.text);
      if (numberOfFamilies >= 1) {
        Map<String, dynamic> menageData = {
          'nomMenage': _nomMenageController.text,
          'adresseMenage': _adresseMenageController.text,
          'quartier': _quartierMenageController.text,
          'ville': _selectedCity,
          // Exclude 'nombre_familles' from the data sent to the API
        };

        // Make the POST request to the API
        var response = await http.post(
          Uri.parse('http://173.249.11.251:8080/recensement-1/menage/add'),
          body: jsonEncode(menageData),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 201) {
          // Parsing the response to extract the ID
          Map<String, dynamic> responseData = jsonDecode(response.body);
          Menage menage = Menage.fromJson(responseData);
          // Use the menageId as needed, for example, show a success dialog
          _showSuccessDialog(context, responseData, menage);
        } else {
          // Handle the case when the POST request fails
          print('Failed to add Menage: ${response.statusCode}');
          _showErrorDialog(context, 'Failed to add Menage');
        }
      } else {
        _showErrorDialog(
            context, 'Le nombre de familles doit être au moins 1.');
      }
    } else {
      _showErrorDialog(context, 'Aucun champ ne peut être vide.');
    }
  }

  void _showSuccessDialog(
      BuildContext context, Map<String, dynamic> responseData, Menage menage) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Succès',
      desc: 'Le menage a été ajouté avec succès.',
      btnOkText: 'OK',
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MenageIndicatorPage(
              responseData: responseData,
              numberOfFamilies: int.parse(_nombreFamillesController.text),
              menage: menage,
            ),
          ),
        );
      },
      dismissOnTouchOutside: false,
    ).show();
  }

  void _showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Erreur',
      desc: message,
      btnOkText: 'OK',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Menage",
        showBackButton: true,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFieldWidget(
                      controller: _nomMenageController,
                      labelText: 'Nom menage',
                    ),
                    TextFieldWidget(
                      controller: _adresseMenageController,
                      labelText: 'Adresse menage',
                    ),
                    TextFieldWidget(
                      controller: _quartierMenageController,
                      labelText: 'Quartier',
                    ),
                    TextFieldWidget(
                      controller: _nombreFamillesController,
                      keyboardType: TextInputType.number,
                      labelText: 'Nombre de familles',
                    ),
                    VilleDropdown(
                      citiesData: _citiesData,
                      selectedCity: _selectedCity,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCity = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _addMenage(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA1F0F2),
                        fixedSize: const Size(200, 50),
                      ),
                      child: const Text(
                        'Ajoute menage',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
