import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/ui/pages/create_chat/create_chat_page.dart';
import 'package:flutter/material.dart';

class CreateChatRoomButton extends StatelessWidget {
  final userId;

  /// 채팅방 생성 플로팅 버튼
  CreateChatRoomButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateChatPage(userId: userId)));
      },
      shape: CircleBorder(),
      backgroundColor: Theme.of(context).highlightColor,
      child: Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
