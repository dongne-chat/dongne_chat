import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../pages/mypage/mypage.dart';
import '/data/model/user.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _signup() async {
    final id = _idController.text;
    final password = _passwordController.text;

    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 입력하세요.')),
      );
      return;
    }

    try {
      final userDoc = await _firestore.collection('users').doc(id).get();

      if (userDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미 존재하는 아이디입니다.')),
        );
      } else {
        final newUser = User(id: id, password: password);
        await _firestore.collection('users').doc(id).set(newUser.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입이 완료되었습니다.')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyPage(userId: id, userData: newUser.toMap()),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 중 오류가 발생했습니다: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 화면을 탭하면 키보드 숨기기
      },
      child: Scaffold(
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
                  backgroundColor: const Color(0xFF466995), // 버튼 배경색
                ),
                onPressed: _signup,
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white), // 글자 색상 하얀색
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

