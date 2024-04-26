import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recensement_app_spring/widgets/customAppbar.dart';

import '../../helpers/api_service.dart';
import '../../models/personne.dart';

class PersonneListPage extends StatefulWidget {
  final int familleId;
  final String nomFamille;

  const PersonneListPage(
      {Key? key, required this.familleId, required this.nomFamille})
      : super(key: key);

  @override
  _PersonneListPageState createState() => _PersonneListPageState();
}

class _PersonneListPageState extends State<PersonneListPage> {
  List<Personne> personnes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Personne> allPersonnes = await ApiService.fetchPersonnes();
      List<Personne> filteredPersonnes = allPersonnes
          .where((personne) => personne.famille.id == widget.familleId)
          .toList();
      setState(() {
        personnes = filteredPersonnes;
      });
    } catch (e) {
      print('Error fetching personnes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'List personne de la famille ${widget.nomFamille}',
        showBackButton: true,
      ),
      body: ListView.builder(
        itemCount: personnes.length,
        itemBuilder: (context, index) {
          final personne = personnes[index];
          print('prenom: ${personne.prenom}');
          print('nom: ${personne.nom}');
          print('lienParente: ${personne.lienParente}');
          return Slidable(
            startActionPane:
                ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.orange,
                onPressed: (BuildContext context) {},
                icon: Icons.border_color,
                label: 'Update',
              )
            ]),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: 'Delete',
                  onPressed: (BuildContext context) {},
                )
              ],
            ),
            child: Card(
              child: ListTile(
                leading: Icon(
                  personne.sexe == 'Homme'
                      ? Icons.person
                      : Icons.person_outline,
                  color: personne.sexe == 'Homme' ? Colors.blue : Colors.pink,
                ),
                title: Text('${personne.prenom} ${personne.nom}'),
                subtitle: Text(personne.lienParente),
              ),
            ),
          );
        },
      ),
    );
  }
}
