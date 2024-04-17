import 'menage.dart';

class Famille {
  int? id;
  final String nomFamille;
  final Menage menage;
  bool completed;

  Famille({
    this.id,
    required this.nomFamille,
    required this.menage,
    this.completed = false,
  });

  Famille.withId({
    required this.id,
    required this.nomFamille,
    required this.menage,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomFamille': nomFamille,
      'menage': menage.toMap(), // Convert Menage to a map
      'completed': completed ? 1 : 0,
    };
  }

  factory Famille.fromMap(Map<String, dynamic> map) {
    return Famille(
      id: map['id'],
      nomFamille: map['nomFamille'],
      menage: Menage.fromMap(map['menage']),
      completed: map['completed'] ??
          false, // Assign a default value if completed is null
    );
  }

  factory Famille.fromJson(Map<String, dynamic> json) {
    return Famille(
      id: json['id'],
      nomFamille: json['nomFamille'] ?? '',
      menage: json['menage'] != null
          ? Menage.fromJson(json['menage'])
          : Menage(
              id: null,
              nomMenage: '',
              adresseMenage: '',
              quartier: '',
              ville: ''),
      completed: json['completed'] ?? false,
    );
  }

  void updateFamilleId(int familleId) {
    id = familleId;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomFamille': nomFamille,
      'menage': menage.toMap(), // Convert Menage to a map
      'completed': completed ? 1 : 0,
    };
  }
}
