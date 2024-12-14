import 'package:dongne_chat/ui/pages/create_chat/create_chat_page.dart';
import 'package:flutter/material.dart';

class CreateChatRoomButton extends StatelessWidget {
  /// 채팅방 생성 플로팅 버튼
  const CreateChatRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 기능 구현 필요
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateChatPage()));
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
