import 'package:dongne_chat/ui/pages/chat/chat_view_model.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/chat_bottom_sheet.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/created_message.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/sender_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  final String title;
  final String userId;

  ChatPage({required this.roomId, required this.title, required this.userId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

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
            bottomSheet: ChatBottomSheet(
              roomId: widget.roomId,
              userId: widget.userId,
            ),
            body: Consumer(builder: (context, ref, child) {
              final chatMessages = ref.watch(chatViewModel(widget.roomId));

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
                              return massageContainer(chatMessage.senderId,
                                  chatMessage.content, chatMessage.createdAt);
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              );
            })),
      ),
    );
  }

  Widget massageContainer(senderId, content, createdAt) {
    return Column(
      children: [
        widget.userId != senderId
            ? senderMessage(senderId, content, createdAt)
            : createdMassage(content, createdAt),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
