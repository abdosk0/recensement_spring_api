class Menage {
  final int? menageId;
  final String nomMenage;
  final String adresseMenage;
  final String quartier;
  final String ville;

  Menage({
    this.menageId,
    required this.nomMenage,
    required this.adresseMenage,
    required this.quartier,
    required this.ville,
  });

  Map<String, dynamic> toMap() {
    return {
      'menageId': menageId,
      'nomMenage': nomMenage,
      'adresseMenage': adresseMenage,
      'quartier': quartier,
      'ville': ville,
    };
  }

  factory Menage.fromMap(Map<String, dynamic> map) {
    return Menage(
      menageId: map['menageId'],
      nomMenage: map['nomMenage'],
      adresseMenage: map['adresseMenage'],
      quartier: map['quartier'],
      ville: map['ville'],
    );
  }

  factory Menage.fromJson(Map<String, dynamic> json) {
    return Menage(
      menageId: json['menageId'],
      nomMenage: json['nomMenage'],
      adresseMenage: json['adresseMenage'],
      quartier: json['quartier'],
      ville: json['ville'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menageId': menageId,
      'nomMenage': nomMenage,
      'adresseMenage': adresseMenage,
      'quartier': quartier,
      'ville': ville,
    };
  }
}
