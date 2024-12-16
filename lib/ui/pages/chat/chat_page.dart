import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_message.dart';
import 'package:dongne_chat/data/model/chat_room.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/chat_bottom_sheet.dart';
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

  Widget createdMassage(content, createdAt) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: Text(
                DateFormat('HH:mm')
                    .format(DateTime.parse(createdAt.toString())),
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              constraints: BoxConstraints(
                maxWidth: 250, // Container의 최대 너비를 설정
              ),
              // height: 35,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text('$content',
                      softWrap: true, // 텍스트가 자동으로 줄바꿈되도록 설정
                      overflow: TextOverflow
                          .visible) // 텍스트가 컨테이너를 넘어가지 않고, 아래줄로 내려가도록 보장합니다.
                  ),
            )
          ],
        ),
      ],
    );
  }

  Widget senderMessage(senderId, content, createdAt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox.square(
            dimension: 50,
            child: Image.network(
              'https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_1280.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Text(
                  '$senderId',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    constraints: BoxConstraints(
                      maxWidth: 250, // Container의 최대 너비를 설정
                    ),
                    // height: 35,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: Text('$content',
                            softWrap: true, overflow: TextOverflow.visible)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      DateFormat('HH:mm')
                          .format(DateTime.parse(createdAt.toString())),
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
