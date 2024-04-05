import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

import '../models/famille.dart';
import '../models/valeur_possible.dart';
import '../widgets/customAppbar.dart';
import '../widgets/date_form_field.dart';
import '../widgets/radio_form_field.dart';
import '../widgets/text_field_widget.dart';
import 'list_famille.dart';

class PersonneForm extends StatefulWidget {
  final Famille famille;
  final int personneNumber;
  final List<Famille> families;

  const PersonneForm({
    Key? key,
    required this.famille,
    required this.personneNumber,
    required this.families,
  }) : super(key: key);

  @override
  _PersonneFormState createState() => _PersonneFormState();
}

class _PersonneFormState extends State<PersonneForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _dateNaissanceController =
      TextEditingController();
  String _selectedLienParente = 'Père';
  String? _sexe;
  bool _isPersonneChef = false;

  String? _validateTextField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir le $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            'Ajouter Personne ${widget.personneNumber} pour ${widget.famille.nomFamille}',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: const Color(0xFFA1F0F2),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lien Parente',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: const Color(
                            0xFF008A90), // Dropdown background color
                        textTheme: Theme.of(context)
                            .textTheme
                            .apply(bodyColor: Colors.white), // Text color
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedLienParente,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLienParente = newValue!;
                          });
                        },
                        items: [
                          'Père',
                          'Mère',
                          'Beau-père',
                          'Belle-mère',
                          'Enfant',
                          'Frère',
                          'Soeur',
                          'Beau-frère',
                          'Belle-soeur',
                          'Grand-père',
                          'Grand-mère',
                          'Petits-enfants',
                          'Oncle',
                          'Tante',
                          'Neveu',
                          'Nièce',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              const Color(0xFF008A90), // Background color
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Border radius
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      controller: _prenomController,
                      labelText: 'Prénom',
                      validator: (value) => _validateTextField(value, 'prénom'),
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      controller: _nomController,
                      labelText: 'Nom',
                      validator: (value) => _validateTextField(value, 'nom'),
                    ),
                    const SizedBox(height: 16),
                    RadioFormField(
                      label: 'Sexe',
                      valeursPossibles: [
                        ValeurPossible(nomValeur: 'Homme'),
                        ValeurPossible(nomValeur: 'Femme'),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _sexe = value;
                        });
                      },
                      selectedOption: _sexe,
                      isRequired: true,
                    ),
                    const SizedBox(height: 20),
                    DateFormField(
                      label: 'Date de naissance',
                      controller: _dateNaissanceController,
                      isRequired: true,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isPersonneChef,
                          onChanged: (value) {
                            setState(() {
                              _isPersonneChef = value!;
                            });
                          },
                        ),
                        const Text('Chef de famille'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _savePersonne(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF008A90),
                        fixedSize: const Size(200, 50),
                      ),
                      child: const Text(
                        'Valider',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _savePersonne(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        Famille family = widget.famille;
        final personneData = {
          'prenom': _prenomController.text,
          'nom': _nomController.text,
          'sexe': _sexe!,
          'dateNaissance': _dateNaissanceController.text,
          'chefFamille': _isPersonneChef,
          'lienParente': _selectedLienParente,
          'famille': {
            'id': family.familleId,
            'nomFamille': family.nomFamille,
            'menage': {
              'id': family.menage.menageId,
              'nomMenage': family.menage.nomMenage,
              'adresseMenage': family.menage.adresseMenage,
              'quartier': family.menage.quartier,
              'ville': family.menage.ville,
            }
          },
        };

        final response = await http.post(
          Uri.parse('http://173.249.11.251:8080/recensement-1/personne/add'),
          body: jsonEncode(personneData),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          _showSuccessDialog(context);
        } else {
          print('Failed to add personne: ${response.statusCode}');
          print('Response body: ${response.body}');
          _showErrorDialog(context, 'Failed to add personne');
        }
      } catch (e) {
        print('Error saving personne: $e');
        _showErrorDialog(context, 'Error saving personne');
      }
    }
  }

  void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Succès',
      desc: 'Les personnes ont été ajoutées avec succès.',
      btnOkText: 'OK',
      btnOkOnPress: () {
        // Pop until reaching the PersonneForm route
        Navigator.popUntil(context, (route) {
          return route.isFirst || route.settings.name == 'PersonneForm';
        });

        if (widget.personneNumber > 1) {
          // Navigate to the next PersonneForm if more persons remaining
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PersonneForm(
                famille: widget.famille,
                personneNumber: widget.personneNumber - 1,
                families: widget.families,
              ),
            ),
          );
        } else {
          widget.famille.completed = true;
          // Navigate to ListFamille if all persons added
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ListFamille(
                families: widget.families,
              ),
            ),
          );
        }
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
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
    ).show();
  }
}
