import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatBottomSheet extends StatefulWidget {
  final roomId;
  const ChatBottomSheet({super.key, required this.roomId});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  final _firestore = FirebaseFirestore.instance;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// 메세지 저장
  void sendMessage() {
    String content = _controller.text;
    _controller.clear();

    _firestore
        .collection('chatRooms')
        .doc(widget.roomId)
        .collection('messages')
        .add({
      'content': content,
      'senderId': '1',
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFB8D3F5)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 150, // 최대 높이 제한
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 0,
                ),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.multiline, // 다중 줄 입력 지원
                    maxLines: null,
                    onSubmitted: (v) => sendMessage(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: sendMessage,
            child: SizedBox(
              width: 25,
              height: 50,
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
