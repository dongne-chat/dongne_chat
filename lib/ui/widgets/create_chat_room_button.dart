import 'package:flutter/material.dart';

class CreateChatRoomButton extends StatelessWidget {
  /// 채팅방 생성 플로팅 버튼
  const CreateChatRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 기능 구현 필요
    return FloatingActionButton(
      onPressed: () {
        print('onPress');
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
