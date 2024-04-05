

import 'indicateur.dart';
import 'menage.dart';
import 'personne.dart';
import 'user.dart';

class IndicateurPersonne {
  int? id;
  String? valeurIndicateur;
  DateTime date;
  String? remarques;
  User? enregistrePar;
  Personne? personne;
  Indicateur indicateur;
  bool? sousIndicateur;
  String? resultatValeur;
  Menage? menage;

  IndicateurPersonne({
    this.id,
    this.valeurIndicateur,
    required this.date,
    this.remarques,
    required this.enregistrePar,
    required this.personne,
    required this.indicateur,
    this.sousIndicateur,
    this.resultatValeur,
    this.menage,
  });

  factory IndicateurPersonne.fromJson(Map<String, dynamic> json) {
    return IndicateurPersonne(
      id: json['id'],
      valeurIndicateur: json['valeurIndicateur'],
      date: DateTime.parse(json['date']),
      remarques: json['remarques'],
      enregistrePar: User.fromJson(json['enregistrePar']),
      personne: json['personne'] != null ? Personne.fromJson(json['personne']) : null,
      indicateur: Indicateur.fromJson(json['indicateur']),
      sousIndicateur: json['sousIndicateur'],
      resultatValeur: json['resultatValeur'],
      menage: json['menage'] != null ? Menage.fromJson(json['menage']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'valeurIndicateur': valeurIndicateur,
      'date': date.toIso8601String(),
      'remarques': remarques,
      'enregistrePar': enregistrePar?.toJson(),
      'personne': personne?.toJson(),
      'indicateur': indicateur.toJson(),
      'sousIndicateur': sousIndicateur,
      'resultatValeur': resultatValeur,
      'menage': menage?.toJson(),
    };
  }
}
