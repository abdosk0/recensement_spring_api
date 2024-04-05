class User {
  final int id;
  final String nom;
  final String? prenom;
  final String? email;
  final String tel;
  final String? username;
  final String? password;
  final String role;
  final bool enabled;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;
  final List<String>? authorities;

  User({
    required this.id,
    required this.nom,
    this.prenom,
    this.email,
    required this.tel,
    this.username,
    this.password,
    required this.role,
    required this.enabled,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    this.authorities,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      nom: json['user']['nom'],
      prenom: json['user']['prenom'],
      email: json['user']['email'],
      tel: json['user']['tel'],
      username: json['user']['username'],
      password: json['user']['password'],
      role: json['user']['role'],
      enabled: json['user']['enabled'],
      accountNonExpired: json['user']['accountNonExpired'],
      accountNonLocked: json['user']['accountNonLocked'],
      credentialsNonExpired: json['user']['credentialsNonExpired'],
      authorities: json['user']['authorities'] != null
          ? List<String>.from(json['user']['authorities'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'tel': tel,
      'username': username,
      'password': password,
      'role': role,
      'enabled': enabled,
      'accountNonExpired': accountNonExpired,
      'accountNonLocked': accountNonLocked,
      'credentialsNonExpired': credentialsNonExpired,
      'authorities': authorities,
    };
  }
}
