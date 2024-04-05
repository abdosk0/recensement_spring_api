import 'campagne.dart';
import 'chapitre.dart';
import 'cree_par.dart';

class Questionnaire {
  final int id;
  final String nom;
  final String? type;
  final String dateCreation;
  final CreePar creePar;
  final Campagne campagne;
  final List<Chapitre> chapitres;

  Questionnaire({
    required this.id,
    required this.nom,
    required this.type,
    required this.dateCreation,
    required this.creePar,
    required this.campagne,
    required this.chapitres,
  });

  factory Questionnaire.fromJson(Map<String, dynamic> json) {
    return Questionnaire(
      id: json['id'],
      nom: json['nom'],
      type: json['type'],
      dateCreation: json['dateCreation'],
      creePar: CreePar.fromJson(json['creePar']),
      campagne: Campagne.fromJson(json['campagne']),
      chapitres: (json['chapitres'] as List)
          .map((chapitre) => Chapitre.fromJson(chapitre))
          .toList(),
    );
  }
}
