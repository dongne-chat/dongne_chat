import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String? userId;
  String? profileImageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId'); // 저장된 사용자 ID를 불러옴
    });
  }

  final TextEditingController _newIdController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newNicknameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickAndUploadImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      File file = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');

      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();

      await _firestore.collection('users').doc(userId).update({'profileImgUrl': downloadUrl});

      setState(() {
        profileImageUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('프로필 이미지가 성공적으로 업데이트되었습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지 업로드 중 오류가 발생했습니다: $e')),
      );
    }
  }

  void _updateId() async {
    final newId = _newIdController.text.trim();

    if (newId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('새로운 아이디를 입력하세요.')),
      );
      return;
    }

    try {
      final newUserDoc = await _firestore.collection('users').doc(newId).get();

      if (newUserDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미 존재하는 아이디입니다.')),
        );
      } else {
        final userDoc = await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          final userData = userDoc.data();
          userData!['id'] = newId; // id 필드 업데이트
          await _firestore.collection('users').doc(newId).set(userData);
          await _firestore.collection('users').doc(userId).delete();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('아이디가 성공적으로 변경되었습니다.')),
          );
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyPage(),
              ),
            );
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디 변경 중 오류가 발생했습니다: $e')),
      );
    }
  }

  void _updatePassword() async {
    final newPassword = _newPasswordController.text.trim();

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('새로운 비밀번호를 입력하세요.')),
      );
      return;
    }

    try {
      await _firestore.collection('users').doc(userId).update({
        'password': newPassword,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 성공적으로 변경되었습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호 변경 중 오류가 발생했습니다: $e')),
      );
    }
  }

  void _updateNickname() async {
    final newNickname = _newNicknameController.text.trim();

    if (newNickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('새로운 닉네임을 입력하세요.')),
      );
      return;
    }

    try {
      await _firestore.collection('users').doc(userId).update({
        'nickname': newNickname,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('닉네임이 성공적으로 변경되었습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('닉네임 변경 중 오류가 발생했습니다: $e')),
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
        appBar: AppBar(title: const Text('마이페이지')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickAndUploadImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
                  child: profileImageUrl == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _newIdController,
                decoration: const InputDecoration(labelText: '새로운 아이디 입력'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF466995),
                ),
                onPressed: _updateId,
                child: const Text(
                  '아이디 변경',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: '새로운 비밀번호 입력'),
                obscureText: true,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF466995),
                ),
                onPressed: _updatePassword,
                child: const Text(
                  '비밀번호 변경',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _newNicknameController,
                decoration: const InputDecoration(labelText: '새로운 닉네임 입력'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF466995),
                ),
                onPressed: _updateNickname,
                child: const Text(
                  '닉네임 변경',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
