class User {
  final String id;
  final dynamic password;
  final String nickname;
  final String? profileImgUrl;

  User({
    required this.id,
    required this.password,
    required this.nickname,
    this.profileImgUrl,
  });

  Map<String, String?> toMap() {
    return {
      'id': id,
      'password': password,
      'nickname': nickname,
      'profileImgUrl': profileImgUrl,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      password: map['password'] ?? '',
      nickname: map['nickname'] ?? '',
      profileImgUrl: map['profileImgUrl'],
    );
  }
}