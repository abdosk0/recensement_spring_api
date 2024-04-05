import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/databaseHelper.dart';
import '../models/menage.dart';
import '../widgets/customAppBar.dart';
import '../widgets/text_field_widget.dart';
import '../widgets/ville_dropdown.dart';

class MenageUpdateForm extends StatefulWidget {
  final Menage menage;

  const MenageUpdateForm({required this.menage});

  @override
  _MenageUpdateFormState createState() => _MenageUpdateFormState();
}

class _MenageUpdateFormState extends State<MenageUpdateForm> {
  late TextEditingController _nomMenageController;
  late TextEditingController _adresseMenageController;
  late TextEditingController _quartierMenageController;
  late TextEditingController _nombreFamillesController;

  List<Map<String, dynamic>> _citiesData = [];
  late String _selectedCity;

  @override
  void initState() {
    super.initState();
    _loadCities();
    _nomMenageController = TextEditingController(text: widget.menage.nomMenage);
    _adresseMenageController =
        TextEditingController(text: widget.menage.adresseMenage);
    _quartierMenageController =
        TextEditingController(text: widget.menage.quartier);
    _selectedCity = widget.menage.ville;
  }

  Future<void> _loadCities() async {
    try {
      String citiesJson =
          await rootBundle.loadString('assets/json/ma_cities.json');
      setState(() {
        _citiesData = jsonDecode(citiesJson).cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error loading cities: $e');
    }
  }

  void _updateMenage(BuildContext context) async {
    if (_nomMenageController.text.isEmpty ||
        _adresseMenageController.text.isEmpty ||
        _quartierMenageController.text.isEmpty ||
        _selectedCity.isEmpty ||
        _nombreFamillesController.text.isEmpty) {
      _showErrorDialog(context, 'All fields are required.');
      return;
    }

    Menage updatedMenage = Menage(
      menageId: widget.menage.menageId,
      nomMenage: _nomMenageController.text,
      adresseMenage: _adresseMenageController.text,
      quartier: _quartierMenageController.text,
      ville: _selectedCity,
    );

    await DatabaseHelper.updateMenage(updatedMenage);

    _showSuccessDialog(context);
  }

  void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Success',
      desc: 'Menage updated successfully!',
      btnOkText: 'OK',
      btnOkOnPress: () {
        Navigator.pop(context, true); // Pop the current screen
      },
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
      appBar: CustomAppBar(title: "Update Menage"),
      body: SingleChildScrollView(
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
              enabled: false,
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
                _updateMenage(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA1F0F2),
                fixedSize: const Size(200, 50),
              ),
              child: const Text(
                'Mettre à jour Menage',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
