import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<bool> login({
    required String id,
    required String password,
  }) async {
    //1. 파이어스토어 인스턴스 가지고오기
    final firestore = FirebaseFirestore.instance;
    //2. 컬렉션 참조 만들기
    final collectionRef = firestore.collection('users');
    //3. 값 불러오기
    final result = await collectionRef.where('id', isEqualTo: id).get();

    final docs = result.docs;
    if (docs.isNotEmpty) {
      final userDoc = docs.first.data();
      // 4. 비밀번호 확인 (여기서는 단순 비교를 사용)
      if (userDoc['password'] == password) {
        return true; // 로그인 성공
      }
    }
    return false;
  }

Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

Future<String?> loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

}
