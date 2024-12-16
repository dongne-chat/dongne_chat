// 1. 상태 클래스 만들기

// 2. 뷰모델 만들기
import 'package:dongne_chat/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel{
  Future<bool> login({
    required String id,
    required String password,
  }) async{
    final userRepository = UserRepository();
    return await userRepository.login(
      id: id,
      password: password,
    );
    
  }
}

// 3. 뷰모델 관리자 만들기

final loginViewModel = Provider.autoDispose((ref) {
  return LoginViewModel();
});
