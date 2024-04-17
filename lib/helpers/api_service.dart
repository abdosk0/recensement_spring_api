import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/campagne.dart';
import '../models/chapitre.dart';
import '../models/famille.dart';
import '../models/indicateur.dart';
import '../models/menage.dart';
import '../models/personne.dart';

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

  static Future<List<Famille>> fetchFamilies() async {
    final response = await http
        .get(Uri.parse('http://173.249.11.251:8080/recensement-1/famille/all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Famille> families =
          data.map((json) => Famille.fromJson(json)).toList();
      return families;
    } else {
      throw Exception('Error fetching families');
    }
  }

  static Future<List<Menage>> fetchMenages() async {
    final response = await http
        .get(Uri.parse('http://173.249.11.251:8080/recensement-1/menage/all'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Menage> menages =
          jsonList.map((json) => Menage.fromJson(json)).toList();
      return menages;
    } else {
      throw Exception('Failed to fetch menages');
    }
  }

  static Future<List<Personne>> fetchPersonnes() async {
    try {
      final response = await http.get(
          Uri.parse('http://173.249.11.251:8080/recensement-1/personne/all'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Personne> personnes = jsonList
            .map((json) => Personne.fromJson(json))
            .whereType<Personne>() // Filter out any null values
            .toList();
        return personnes;
      } else {
        print('Failed to load personnes - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to load personnes');
      }
    } catch (e) {
      print('Error fetching personnes: $e');
      throw Exception('Error fetching personnes: $e');
    }
  }
}
