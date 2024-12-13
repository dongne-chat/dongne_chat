// pages/signup_page.dart
import 'package:flutter/material.dart';
import '../../pages/mypage/mypage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Map<String, String> userData = {}; // 앱 메모리에 사용자 데이터 저장

  void _signup() {
    final id = _idController.text;
    final password = _passwordController.text;

    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 입력하세요.')),
      );
      return;
    }

    if (userData.containsKey(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미 존재하는 아이디입니다.')),
      );
    } else {
      userData[id] = password;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입이 완료되었습니다.')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyPage(userId: id, userData: userData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: '아이디 입력'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '비밀번호 입력'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF466995), // 버튼 색상 변경
              ),
              onPressed: _signup,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
