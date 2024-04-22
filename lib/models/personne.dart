import 'famille.dart';
import 'menage.dart';

class Personne {
  final int? id;
  final String prenom;
  final String nom;
  final String sexe;
  final DateTime dateNaissance;
  final String chefFamille; 
  final String lienParente;
  final Famille famille;

  Personne({
    this.id,
    required this.prenom,
    required this.nom,
    required this.sexe,
    required this.dateNaissance,
    required this.chefFamille,
    required this.lienParente,
    required this.famille,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'dateNaissance': dateNaissance.toIso8601String(),
      'chefFamille': chefFamille,
      'lienParente': lienParente,
      'famille': famille.toMap(), // Convert Famille object to map
    };
  }

  factory Personne.fromMap(Map<String, dynamic> map) {
    return Personne(
      id: map['id'],
      prenom: map['prenom'],
      nom: map['nom'],
      sexe: map['sexe'],
      dateNaissance: DateTime.parse(map['dateNaissance']),
      chefFamille: map['chefFamille'] == 1 ? 'true' : 'false',
      lienParente: map['lienParente'],
      famille: Famille.fromMap(map['famille']), // Convert map to Famille object
    );
  }

  factory Personne.fromJson(Map<String, dynamic> json) {
    return Personne(
      id: json['id'],
      prenom: json['prenom'] ?? '',
      nom: json['nom'] ?? '',
      sexe: json['sexe'] ?? '',
      dateNaissance: json['dateNaissance'] != null
          ? DateTime.parse(json['dateNaissance'])
          : DateTime.now(),
      chefFamille: json['chefFamille'] ?? 'false',
      lienParente: json['lienParente'] ?? '',
      famille: json['famille'] != null
          ? Famille.fromJson(json['famille'] as Map<String, dynamic>)
          : Famille(
              id: null,
              nomFamille: '',
              menage: Menage(
                id: null,
                nomMenage: '',
                adresseMenage: '',
                quartier: '',
                ville: '',
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'dateNaissance': dateNaissance.toIso8601String(),
      'chefFamille': chefFamille,
      'lienParente': lienParente,
      'famille': famille.toJson(),
    };
  }
}
