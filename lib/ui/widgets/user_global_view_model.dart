import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

Future<String?> loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  print(prefs);
  return prefs.getString('userId'); // 저장된 아이디를 반환
}
