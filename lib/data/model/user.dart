class User {
  final String id;
  final dynamic password;

  User({required this.id, required this.password});

  Map<String, String> toMap() {
    return {
      'id': id,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      password: map['password'] ?? '',
    );
  }
}