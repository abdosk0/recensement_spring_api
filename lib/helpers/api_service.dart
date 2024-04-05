import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/campagne.dart';
import '../models/chapitre.dart';
import '../models/famille.dart';
import '../models/indicateur.dart';
class ApiService {
  final String baseUrl = "http://173.249.11.251:8080/recensement-1";


  Future<Campagne> fetchCampagne(int idQuestionnaire) async {
    final response =
        await http.get(Uri.parse('$baseUrl/questionnaire/$idQuestionnaire'));

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodedBody);
      return Campagne.fromJson(responseData['campagne']);
    } else {
      throw Exception('Failed to load campagne');
    }
  }

  Future<List<Chapitre>> fetchChapitres(int idQuestionnaire) async {
    final response =
        await http.get(Uri.parse('$baseUrl/questionnaire/$idQuestionnaire'));

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodedBody);
      final List<dynamic> chapitresData = responseData['chapitres'];
      return chapitresData
          .map((chapitre) => Chapitre.fromJson(chapitre))
          .toList();
    } else {
      throw Exception('Failed to load chapitres');
    }
  }

  Future<List<Indicateur>> fetchIndicateurs(int idQuestionnaire) async {
    final response =
        await http.get(Uri.parse('$baseUrl/questionnaire/$idQuestionnaire'));

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodedBody);
      if (responseData.containsKey('chapitres')) {
        final chapitresData = responseData['chapitres'];

        // Check if chapitresData is a List
        if (chapitresData is List) {
          final List<Indicateur> indicateurs = [];

          // Process each chapitre
          for (final chapitreData in chapitresData) {
            // Check if chapitreData contains the 'indicateurs' key
            if (chapitreData.containsKey('indicateurs')) {
              final indicateursData = chapitreData['indicateurs'];

              // Check if indicateursData is a List
              if (indicateursData is List) {
                // Process each element of the list
                for (final indicateurData in indicateursData) {
                  // Create an Indicateur object and add it to the list
                  indicateurs.add(Indicateur.fromJson(indicateurData));
                }
              } else {
                throw Exception('Indicateurs data is not a List');
              }
            } else {
              throw Exception('Indicateurs key not found in chapitreData');
            }
          }

          // Return the list of Indicateurs
          return indicateurs;
        } else {
          throw Exception('Chapitres data is not a List');
        }
      } else {
        throw Exception('Chapitres key not found in responseData');
      }
    } else {
      throw Exception('Failed to load indicateurs');
    }
  }

  Future<List<Famille>> fetchFamilies() async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/famille/all'));

      if (response.statusCode == 200) {
        final List<dynamic> familiesJson = jsonDecode(response.body);
        final List<Famille> fetchedFamilies =
            familiesJson.map((json) => Famille.fromJson(json)).toList();
        return fetchedFamilies;
      } else {
        throw Exception('Failed to load families');
      }
    } catch (e) {
      throw Exception('Error fetching families: $e');
    }
  }

}
