import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recensement_app_spring/widgets/customAppbar.dart';

import '../../helpers/api_service.dart';
import '../../models/famille.dart';
import '../personne/personne_list_page.dart';

class FamilleListPage extends StatefulWidget {
  final int menageId;

  const FamilleListPage({Key? key, required this.menageId}) : super(key: key);

  @override
  _FamilleListPageState createState() => _FamilleListPageState();
}

class _FamilleListPageState extends State<FamilleListPage> {
  List<Famille> families = [];

  @override
  void initState() {
    super.initState();
    _fetchFamilies();
  }

  Future<void> _fetchFamilies() async {
    try {
      List<Famille> allFamilies = await ApiService.fetchFamilies();
      List<Famille> filteredFamilies = allFamilies
          .where((famille) => famille.menage.id == widget.menageId)
          .toList();

      setState(() {
        families = filteredFamilies;
      });
    } catch (e) {
      print('Error fetching families: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'List des Familles',
        showBackButton: true,
      ),
      body: ListView.builder(
        itemCount: families.length,
        itemBuilder: (context, index) {
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
              color: const Color(0xFFA1F0F2),
              child: ListTile(
                leading: const Icon(Icons.family_restroom),
                title: Text(families[index].nomFamille),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonneListPage(
                          familleId: families[index].id!,
                          nomFamille: families[index].nomFamille),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
