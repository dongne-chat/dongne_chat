import 'package:dongne_chat/ui/pages/chat/chat_view_model.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/chat_bottom_sheet.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/created_message.dart';
import 'package:dongne_chat/ui/pages/chat/widgets/sender_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String roomId;
  final String title;
  final String userId;

  ChatPage({required this.roomId, required this.title, required this.userId});

  @override
  ConsumerState createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  String? nickname;
  String? profile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessagesWithUser = ref.watch(chatViewModel(widget.roomId));

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
              if (chatMessagesWithUser.isEmpty) {
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
                            itemCount: chatMessagesWithUser.length,
                            itemBuilder: (context, index) {
                              final chatMessageWithUser =
                                  chatMessagesWithUser[index];
                              final chatMessage =
                                  chatMessageWithUser.chatMessage;
                              final user = chatMessageWithUser.user;

                              return massageContainer(
                                  senderNickname:
                                      user?.nickname ?? '알 수 없는 사용자',
                                  senderProfileImgUrl: user?.profileImgUrl,
                                  senderId: chatMessage.senderId,
                                  content: chatMessage.content,
                                  createdAt: chatMessage.createdAt);
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

  Widget massageContainer(
      {senderNickname, senderProfileImgUrl, senderId, content, createdAt}) {
    return Column(
      children: [
        widget.userId != senderId
            ? senderMessage(
                senderNickname: senderNickname,
                senderProfileImgUrl: senderProfileImgUrl,
                senderId: senderId,
                content: content,
                createdAt: createdAt)
            : createdMassage(content: content, createdAt: createdAt),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
