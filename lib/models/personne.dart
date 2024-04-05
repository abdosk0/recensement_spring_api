
import 'famille.dart';

class Personne {
  final int? personneId;
  final String prenom;
  final String nom;
  final String sexe;
  final DateTime dateNaissance;
  final bool chefFamille;
  final String lienParente;
  final Famille famille;

  Personne({
    this.personneId,
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
      'personneId': personneId,
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'dateNaissance': dateNaissance.toIso8601String(),
      'chefFamille': chefFamille ? 1 : 0,
      'lienParente': lienParente,
      'famille': famille.toMap(), // Convert Famille object to map
    };
  }

  factory Personne.fromMap(Map<String, dynamic> map) {
    return Personne(
      personneId: map['personneId'],
      prenom: map['prenom'],
      nom: map['nom'],
      sexe: map['sexe'],
      dateNaissance: DateTime.parse(map['dateNaissance']),
      chefFamille: map['chefFamille'] == 1 ? true : false,
      lienParente: map['lienParente'],
      famille: Famille.fromMap(map['famille']), // Convert map to Famille object
    );
  }

  factory Personne.fromJson(Map<String, dynamic> json) {
    return Personne(
      personneId: json['personneId'],
      prenom: json['prenom'],
      nom: json['nom'],
      sexe: json['sexe'],
      dateNaissance: DateTime.parse(json['dateNaissance']),
      chefFamille: json['chefFamille'],
      lienParente: json['lienParente'],
      famille: Famille.fromJson(json['famille']), // Convert JSON to Famille object
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personneId': personneId,
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
