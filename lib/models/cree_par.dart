class CreePar {
  final int id;
  final String nom;
  final String? prenom;
  final String? email;
  final String tel;
  final String role;
  final bool enabled;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;

  CreePar({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.tel,
    required this.role,
    required this.enabled,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory CreePar.fromJson(Map<String, dynamic> json) {
    return CreePar(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      tel: json['tel'],
      role: json['role'],
      enabled: json['enabled'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
    );
  }
}
