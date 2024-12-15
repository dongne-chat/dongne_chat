import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoomCreateTest extends StatefulWidget {
  const ChatRoomCreateTest({super.key});

  @override
  State<ChatRoomCreateTest> createState() => _ChatRoomCreateTestState();
}

class _ChatRoomCreateTestState extends State<ChatRoomCreateTest> {
  @override
  Widget build(BuildContext context) {
    final loginUserId = 1;

    final titleController = TextEditingController();
    final infoController = TextEditingController();
    final categoryController = TextEditingController();

    @override
    void dispose() {
      titleController.dispose();
      infoController.dispose();
      categoryController.dispose();
      super.dispose();
    }

    final _firestore = FirebaseFirestore.instance;

    void createChatRoom() {
      String title = titleController.text;
      String info = infoController.text;
      String category = categoryController.text;
      // TODO 로그인한 유저의 아이디 넣어주기
      _firestore.collection('chatRooms').add({
        'title': title,
        'info': info,
        'category': category,
        'users': [loginUserId], //.채팅방에 접속한 user_id 배열에 저장
        'address': '광주 봉선동', // 현재 좌표로 주소 찾아서 넣어주기
        // 'createdUser': 12,
        'createdAt': Timestamp.now() //날짜 추가
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: [
          Text('title'),
          TextField(
            controller: titleController,
          ),
          Text('info'),
          TextField(
            controller: infoController,
          ),
          Text('category'),
          TextField(
            controller: categoryController,
          ),
          Text('address'), // 자동
          Text('users'), // 자동
          Text('createdAt'), // 자동
          GestureDetector(
              onTap: () {
                createChatRoom();
                Navigator.pop(context);
              },
              child: Text('확인')), // 자동
        ],
      ),
    );
  }
}
