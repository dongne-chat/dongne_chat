import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  final String userId;
  final Map<String, String> userData;

  const MyPage({super.key, required this.userId, required this.userData});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final TextEditingController _newIdController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _updateId() {
    final newId = _newIdController.text;

    if (newId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('새로운 아이디를 입력하세요.')),
      );
      return;
    }

    if (widget.userData.containsKey(newId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미 존재하는 아이디입니다.')),
      );
    } else {
      setState(() {
        widget.userData.remove(widget.userId);
        widget.userData[newId] = widget.userData[widget.userId]!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디가 변경되었습니다.')),
      );
    }
  }

  void _updatePassword() {
    final newPassword = _newPasswordController.text;

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('새로운 비밀번호를 입력하세요.')),
      );
      return;
    }

    setState(() {
      widget.userData[widget.userId] = newPassword;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('비밀번호가 변경되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('아이디: ${widget.userId}'),
            const SizedBox(height: 20),
            TextField(
              controller: _newIdController,
              decoration: const InputDecoration(labelText: '새로운 아이디 입력'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF466995), // 버튼 색상 변경
              ),
              onPressed: _updateId,
              child: const Text('아이디 변경'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(labelText: '새로운 비밀번호 입력'),
              obscureText: true,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF466995), // 버튼 색상 변경
              ),
              onPressed: _updatePassword,
              child: const Text('비밀번호 변경'),
            ),
          ],
        ),
      ),
    );
  }
}
