import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recensement_app_spring/widgets/customAppbar.dart';
import '../helpers/api_service.dart';
import '../models/menage.dart';
import 'famille_list_page.dart';

class MenageListPage extends StatefulWidget {
  @override
  _MenageListPageState createState() => _MenageListPageState();
}

class _MenageListPageState extends State<MenageListPage> {
  List<Menage> menages = [];

  @override
  void initState() {
    super.initState();
    _fetchMenages();
  }

  Future<void> _fetchMenages() async {
    try {
      List<Menage> fetchedMenages = await ApiService.fetchMenages();
      setState(() {
        menages = fetchedMenages;
      });
    } catch (e) {
      // Handle error
      print('Error fetching menages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'List des Menages',
        showBackButton: true,
      ),
      body: ListView.builder(
        itemCount: menages.length,
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.orange,
                  onPressed: (BuildContext context) {},
                  icon: Icons.border_color,
                  label: 'Update',
                )
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
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
                leading: const Icon(Icons.home),
                title: Text(menages[index].nomMenage),
                subtitle: Text(
                  '${menages[index].adresseMenage}, ${menages[index].ville}',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FamilleListPage(
                        menageId: menages[index].id!,
                      ),
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
