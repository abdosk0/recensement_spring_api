

import 'menage.dart';

class Famille {
  int? familleId;
  final String nomFamille;
  final Menage menage;
  bool completed;

  Famille({
    this.familleId,
    required this.nomFamille,
    required this.menage,
    this.completed = false,
  });

  Famille.withId({
    required this.familleId,
    required this.nomFamille,
    required this.menage,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'familleId': familleId,
      'nomFamille': nomFamille,
      'menage': menage.toMap(), // Convert Menage to a map
      'completed': completed ? 1 : 0,
    };
  }

  factory Famille.fromMap(Map<String, dynamic> map) {
    return Famille(
      familleId: map['familleId'],
      nomFamille: map['nomFamille'],
      menage: Menage.fromMap(map['menage']),
      completed: map['completed'] ??
          false, // Assign a default value if completed is null
    );
  }

  factory Famille.fromJson(Map<String, dynamic> json) {
    return Famille(
      familleId: json['familleId'],
      nomFamille: json['nomFamille'],
      menage: Menage.fromJson(json['menage']),
      completed: json['completed'] ??
          false, // Assign a default value if completed is null
    );
  }
  void updateFamilleId(int id) {
    familleId = id;
  }
  Map<String, dynamic> toJson() {
    return {
      'familleId': familleId,
      'nomFamille': nomFamille,
      'menage': menage.toMap(), // Convert Menage to a map
      'completed': completed ? 1 : 0,
    };
  }
}
