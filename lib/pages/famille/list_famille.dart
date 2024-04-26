import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../models/famille.dart';
import '../../widgets/customAppbar.dart';
import '../personne/personne_form.dart';

class ListFamille extends StatelessWidget {
  final List<Famille> families;

  const ListFamille({Key? key, required this.families}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool allCompleted = families.every((family) => family.completed);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Liste des Familles',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: families.length,
              itemBuilder: (context, index) {
                final family = families[index];
                final cardColor = family.completed ? Colors.green : Colors.red;
                final icon =
                    family.completed ? Icons.check : Icons.close_rounded;
                return GestureDetector(
                  onTap: family.completed
                      ? null
                      : () {
                          int? numberOfPersons; // Default value
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.scale,
                            title: 'Nombre de Personnes',
                            desc:
                                'Entrer le nombre de personne dans la famille',
                            body: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                numberOfPersons = int.tryParse(value);
                              },
                            ),
                            btnOkOnPress: () {
                              if (numberOfPersons != null &&
                                  numberOfPersons! > 0) {
                                Navigator.of(context).pop();
                                // Navigate to PersonneForm for each person
                                for (int i = 1; i <= numberOfPersons!; i++) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PersonneForm(
                                        famille: family,
                                        families: families,
                                        personneNumber: i,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  title: 'Erreur',
                                  desc: 'Veuillez entrer un nombre valide.',
                                  btnOkOnPress: () {},
                                ).show();
                              }
                            },
                          ).show();
                        },
                  child: Card(
                    color: cardColor,
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              family.nomFamille,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Icon(
                            icon,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Conditionally show the button if all families are completed
          if (allCompleted)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to the Menu
                  Navigator.pushReplacementNamed(context, 'menu');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA1F0F2),
                  fixedSize: const Size(200, 50),
                ),
                child: const Text(
                  'Retourner au Menu',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
