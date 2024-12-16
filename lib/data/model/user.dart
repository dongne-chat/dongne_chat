class User {
  final String id;
  final dynamic password;
  final String nickname;

  User({
    required this.id,
    required this.password,
    required this.nickname,
  });

  Map<String, String> toMap() {
    return {
      'id': id,
      'password': password,
      'nickname': nickname,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      password: map['password'] ?? '',
      nickname: map['nickname'] ?? '',
    );
  }
}
