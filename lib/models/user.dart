class AppUser {
  const AppUser({
    required this.email,
    required this.passwordHash,
    required this.salt,
    required this.createdAt,
  });

  final String email;
  final String passwordHash;
  final String salt;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'passwordHash': passwordHash,
      'salt': salt,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      salt: json['salt'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
