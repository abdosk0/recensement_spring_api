class ValeurPossible {
  final int? id;
  final String nomValeur;
  final bool? requireSousIndicateur;

  ValeurPossible({
     this.id,
    required this.nomValeur,
     this.requireSousIndicateur,
  });

  factory ValeurPossible.fromJson(Map<String, dynamic> json) {
    return ValeurPossible(
      id: json['id'],
      nomValeur: json['nomValeur'],
      requireSousIndicateur: json['requireSousIndicateur'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomValeur': nomValeur,
      'requireSousIndicateur': requireSousIndicateur,
    };
  }
}