class Menage {
  final int? id;
  final String nomMenage;
  final String adresseMenage;
  final String quartier;
  final String ville;

  Menage({
    this.id,
    required this.nomMenage,
    required this.adresseMenage,
    required this.quartier,
    required this.ville,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomMenage': nomMenage,
      'adresseMenage': adresseMenage,
      'quartier': quartier,
      'ville': ville,
    };
  }

  factory Menage.fromMap(Map<String, dynamic> map) {
    return Menage(
      id: map['id'],
      nomMenage: map['nomMenage'],
      adresseMenage: map['adresseMenage'],
      quartier: map['quartier'],
      ville: map['ville'],
    );
  }

  factory Menage.fromJson(Map<String, dynamic> json) {
    return Menage(
      id: json['id'],
      nomMenage: json['nomMenage'] ?? '',
      adresseMenage: json['adresseMenage'] ?? '',
      quartier: json['quartier'] ?? '',
      ville: json['ville'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomMenage': nomMenage,
      'adresseMenage': adresseMenage,
      'quartier': quartier,
      'ville': ville,
    };
  }
}
