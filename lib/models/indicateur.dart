import 'valeur_possible.dart';

class Indicateur {
  final int id;
  final String codeIndicateur;
  final String nomIndicateur;
  final int ordreIndicateur;
  final String description;
  final String type;
  final bool obligatoire;
  final String objectIndicateur;
  final List<ValeurPossible> valeursPossibles; // Added field

  Indicateur({
    required this.id,
    required this.codeIndicateur,
    required this.nomIndicateur,
    required this.ordreIndicateur,
    required this.description,
    required this.type,
    required this.obligatoire,
    required this.objectIndicateur,
    required this.valeursPossibles,
  });

  factory Indicateur.fromJson(Map<String, dynamic> json) {
    // Parse the "valeursPossibles" list
    List<ValeurPossible> valeursPossibles = [];
    if (json['valeursPossibles'] != null) {
      valeursPossibles = List<ValeurPossible>.from(
        json['valeursPossibles'].map(
          (value) => ValeurPossible.fromJson(value),
        ),
      );
    }

    return Indicateur(
      id: json['id'],
      codeIndicateur: json['codeIndicateur'],
      nomIndicateur: json['nomIndicateur'],
      ordreIndicateur: json['ordreIndicateur'],
      description: json['description'],
      type: json['type'],
      obligatoire: json['obligatoire'],
      objectIndicateur: json['objectIndicateur'],
      valeursPossibles: valeursPossibles,
    );
  }
Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codeIndicateur': codeIndicateur,
      'nomIndicateur': nomIndicateur,
      'ordreIndicateur': ordreIndicateur,
      'description': description,
      'type': type,
      'obligatoire': obligatoire,
      'objectIndicateur': objectIndicateur,
      'valeursPossibles': valeursPossibles.map((vp) => vp.toJson()).toList(),
    };
  }
  
}