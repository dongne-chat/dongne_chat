// ChatMessage와 User 정보를 결합하는 클래스
import 'package:dongne_chat/data/model/chat_message.dart';
import 'package:dongne_chat/data/model/user.dart';

class ChatMessageWithUser {
  final ChatMessage chatMessage;
  final User? user;

  ChatMessageWithUser({
    required this.chatMessage,
    this.user,
  });
}
