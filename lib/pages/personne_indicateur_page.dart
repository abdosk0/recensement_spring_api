import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import '../helpers/api_service.dart';
import '../models/famille.dart';
import '../models/indicateur.dart';
import '../widgets/customAppbar.dart';
import '../widgets/dynamic_indicator.dart';
import 'list_famille.dart';

class PersonneIndicatorPage extends StatefulWidget {
  final List<Famille> families;

  const PersonneIndicatorPage({Key? key, required this.families})
      : super(key: key);

  @override
  _PersonneIndicatorPageState createState() => _PersonneIndicatorPageState();
}

class _PersonneIndicatorPageState extends State<PersonneIndicatorPage> {
  final ApiService _apiService = ApiService();
  late List<Indicateur> _personneIndicators = [];

  @override
  void initState() {
    super.initState();
    _fetchPersonneIndicators();
  }

  Future<void> _fetchPersonneIndicators() async {
    try {
      // Simulating a delay for demonstration purposes
      await Future.delayed(Duration(seconds: 2));

      final List<Indicateur> indicators = await _apiService.fetchIndicateurs(1);
      setState(() {
        _personneIndicators = indicators
            .where((indicateur) => indicateur.objectIndicateur == 'Personne')
            .toList();
      });
    } catch (e) {
      print('Error fetching Personne indicators: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Indicateurs Personne',
      ),
      body: _personneIndicators.isEmpty
          ? Center(
              child: Lottie.asset(
                'assets/animations/loading_indicator.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
          : ListView.builder(
              itemCount: _personneIndicators.length,
              itemBuilder: (context, index) {
                final indicateur = _personneIndicators[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DynamicIndicatorItem(
                    indicateur: indicateur, controller: TextEditingController(),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final families = widget.families;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ListFamille(families: families),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
