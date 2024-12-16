import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/ui/pages/dongne_list/chat_room_creat_test.dart';
import 'package:flutter/material.dart';

class CreateChatRoomButton extends StatelessWidget {
  /// 채팅방 생성 플로팅 버튼
  CreateChatRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatRoomCreateTest()));
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
