import 'indicateur.dart';

class Chapitre {
  final int id;
  final String codeChapitre;
  final String nomChapitre;
  final int ordreChapitre;
  final List<Indicateur> indicateurs;

  Chapitre({
    required this.id,
    required this.codeChapitre,
    required this.nomChapitre,
    required this.ordreChapitre,
    required this.indicateurs,
  });

  factory Chapitre.fromJson(Map<String, dynamic> json) {
    return Chapitre(
      id: json['id'],
      codeChapitre: json['codeChapitre'],
      nomChapitre: json['nomChapitre'],
      ordreChapitre: json['ordreChapitre'],
      indicateurs: (json['indicateurs'] as List)
          .map((indicateur) => Indicateur.fromJson(indicateur))
          .toList(),
    );
  }
}
