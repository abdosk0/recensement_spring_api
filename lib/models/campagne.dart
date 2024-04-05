class Campagne {
  final int id;
  final String anneeCampagne;
  final String description;
  final String nomCampagne;
  final String pays;

  Campagne({
    required this.id,
    required this.anneeCampagne,
    required this.description,
    required this.nomCampagne,
    required this.pays,
  });

  factory Campagne.fromJson(Map<String, dynamic> json) {
    return Campagne(
      id: json['id'],
      anneeCampagne: json['anneeCampagne'],
      description: json['description'],
      nomCampagne: json['nomCampagne'],
      pays: json['pays'],
    );
  }
}
