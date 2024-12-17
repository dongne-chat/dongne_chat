import 'package:dongne_chat/ui/pages/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatBottomSheet extends ConsumerStatefulWidget {
  final roomId;
  final userId;

  const ChatBottomSheet(
      {super.key, required this.roomId, required this.userId});

  @override
  ConsumerState createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends ConsumerState<ChatBottomSheet> {
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessageVM = ref.read(chatViewModel(widget.roomId).notifier);

    void sendMessage() {
      String content = _contentController.text;
      _contentController.clear();

      chatMessageVM.handleCreateMessage(widget.roomId, content, widget.userId);
    }

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
                    controller: _contentController,
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
