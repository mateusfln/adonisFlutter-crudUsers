class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({required this.id, required this.username, required this.email, required this.password, required this.createdAt, required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['created_at']), // Converte a string para DateTime
      updatedAt: DateTime.parse(json['updated_at']), // Converte a string para DateTime
    );
  }
}
