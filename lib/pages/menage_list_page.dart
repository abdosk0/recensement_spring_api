import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/menage.dart';
import '../widgets/customAppbar.dart';
import 'menage_details_page.dart';
import 'menage_update_form.dart';

class MenageListPage extends StatefulWidget {
  @override
  _MenageListPageState createState() => _MenageListPageState();
}

class _MenageListPageState extends State<MenageListPage> {
  late List<Map<String, dynamic>> _menages = [];

  @override
  void initState() {
    super.initState();
    _loadMenages();
  }

  Future<void> _loadMenages() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'recensement_database.db'),
    );
    final List<Map<String, dynamic>> menages = await database.query('Menage');
    setState(() {
      _menages = menages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'List des Menages',
        showBackButton: true,
      ),
      body: ListView.builder(
        itemCount: _menages.length,
        itemBuilder: (context, index) {
          final menage = _menages[index];
          return GestureDetector(
            onTap: () {
              _showOptionsDialog(context, menage);
            },
            child: Card(
              color: const Color(0xFFA1F0F2),
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(menage['nom']),
                subtitle: Row(
                  children: [
                    Text('${menage['nombre_familles']} families'),
                    const SizedBox(width: 8.0),
                    const Icon(Icons.family_restroom),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOptionsDialog(
      BuildContext context, Map<String, dynamic> menageData) {
    Menage menage = Menage(
      menageId: menageData['id_menage'],
      nomMenage: menageData['nom'],
      adresseMenage: menageData['adresse'],
      quartier: menageData['quartier'],
      ville: menageData['ville'],
    );

    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.bottomSlide,
      title: 'Options',
      desc: 'Choose an option',
      btnCancelText: 'Modifier le Menage',
      btnOkColor: const Color(0xFF008A90),
      btnCancelColor: const Color(0xFF008A90),
      btnCancelOnPress: () async {
        // Navigate to update form
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenageUpdateForm(menage: menage)),
        );

        // Check if the result is true 
        if (result == true) {
          // Refresh the list here 
          _loadMenages(); 
        }
      },
      btnOkText: 'Voir les familles',
      btnOkOnPress: () {
        // Navigate to details page
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenageDetailsPage(
                    menage: menageData,
                  )),
        );
      },
    ).show();
  }
}
