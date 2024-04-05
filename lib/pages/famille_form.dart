import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import '../models/famille.dart'; // Import your Famille model here
import '../widgets/customAppbar.dart';
import '../widgets/text_field_widget.dart';
import 'list_famille.dart';

class FamilleForm extends StatefulWidget {
  final Map<String, dynamic> responseData;
  final int numberOfFamilies;

  const FamilleForm({
    super.key,
    required this.responseData,
    required this.numberOfFamilies,
  });

  @override
  _FamilleFormState createState() => _FamilleFormState();
}

class _FamilleFormState extends State<FamilleForm> {
  List<String> _familyNames = [];
  List<Famille> _families = [];
  late List<TextEditingController> _familyControllers;

  @override
  void initState() {
    super.initState();
    _families = [];
    _familyControllers = List.generate(
      widget.numberOfFamilies,
      (_) => TextEditingController(),
    );
    _familyNames = List.filled(widget.numberOfFamilies, '');
  }

  @override
  void dispose() {
    _familyControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _addFamilyName(int index) {
    setState(() {
      _familyNames[index] = _familyControllers[index].text;
    });
  }

  void _saveFamilies(BuildContext context) async {
    List<String> familyNames = _familyControllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    if (familyNames.length < widget.numberOfFamilies) {
      _showErrorDialog(context, 'Veuillez saisir tous les noms de famille.');
      return;
    }
    int menageId = widget.responseData['id'];
    String nomMenage = widget.responseData['nomMenage'];
    String adresseMenage = widget.responseData['adresseMenage'];
    String quartier = widget.responseData['quartier'];
    String ville = widget.responseData['ville'];
    try {
      List<Famille> addedFamilies = [];
      for (String familyName in familyNames) {
        final Map<String, dynamic> familyData = {
          'nomFamille': familyName,
          'menage': {
            'id': menageId,
            'nomMenage': nomMenage,
            'adresseMenage': adresseMenage,
            'quartier': quartier,
            'ville': ville,
          }
        };

        final response = await http.post(
          Uri.parse('http://173.249.11.251:8080/recensement-1/famille/add'),
          body: jsonEncode(familyData),
          headers: {'Content-Type': 'application/json'},
        );
        print(jsonDecode(response.body));
        if (response.statusCode == 201) {
          // Parse the response body to get the added family data
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          Famille addedFamily = Famille.fromJson(responseData);
          addedFamily.updateFamilleId(responseData['id']); // Update familleId
          addedFamilies.add(addedFamily);
          print('Family added successfully: $familyName');
        } else {
          // Print error message without stopping the loop
          print('Failed to add family $familyName: ${response.statusCode}');
          print('Response body: ${response.body}');
          _showErrorDialog(context, 'Failed to add family $familyName');
        }
      }

      // Update _families list with added families
      setState(() {
        _families.addAll(addedFamilies);
      });

      // Show success dialog if families were added
      if (addedFamilies.isNotEmpty) {
        _showSuccessDialog(context);
      }
    } catch (e) {
      print('Error saving families: $e');
      _showErrorDialog(context, 'Error saving families');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Succès',
      desc: 'Les familles ont été ajoutées avec succès.',
      btnOkText: 'OK',
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ListFamille(
              families: _families,
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
      appBar: const CustomAppBar(title: "Nom de famille"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.numberOfFamilies,
                itemBuilder: (context, index) {
                  return TextFieldWidget(
                    controller: _familyControllers[index],
                    labelText: 'Nom de famille ${index + 1}',
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _saveFamilies(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA1F0F2),
                fixedSize: const Size(200, 50),
              ),
              child: const Text(
                'Sauvegarder les familles',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
