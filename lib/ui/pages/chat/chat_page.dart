import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_message.dart';
import 'package:dongne_chat/data/model/chat_room.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/chat_bottom_sheet.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/created_message.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/sender_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  final String title;

  ChatPage({required this.roomId, required this.title});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final loginUserId = '1'; // 로그인한 사용자의 id 임의로 지정

  // roomId 기준으로 message 가져오기
  final chatMessagesProvider =
      StreamProvider.family<List<ChatMessage>, String>((ref, roomId) {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true) // 최신 메시지부터 가져오기
        .snapshots() // 실시간 데이터 스트리밍
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatMessage.fromJson(doc.id, doc.data()))
          .toList();
    });
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            bottomSheet: ChatBottomSheet(roomId: widget.roomId),
            body: Consumer(builder: (context, ref, child) {
              final chatMessageAsyncValue =
                  ref.watch(chatMessagesProvider(widget.roomId));

              return chatMessageAsyncValue.when(
                data: (chatMessages) {
                  if (chatMessages.isEmpty) {
                    return Center(
                      child: Text('메세지가 없습니다'),
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                itemCount: chatMessages.length,
                                itemBuilder: (context, index) {
                                  final chatMessage = chatMessages[index];
                                  return massageContainer(
                                      chatMessage.senderId,
                                      chatMessage.content,
                                      chatMessage.createdAt);
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('오류가 발생했습니다: $err')),
              );
            })),
      ),
    );
  }

  Widget massageContainer(senderId, content, createdAt) {
    return Column(
      children: [
        loginUserId != senderId
            ? senderMessage(senderId, content, createdAt)
            : createdMassage(content, createdAt),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
