import 'package:dongne_chat/data/model/chat_message.dart';
import 'package:dongne_chat/data/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatViewModel
    extends AutoDisposeFamilyNotifier<List<ChatMessage>, String> {
  final chatMessageRepository = ChatRepository();

  @override
  List<ChatMessage> build(String roomId) {
    fetchData(roomId);
    return [];
  }

  // 채팅방 메세지 가져오기
  Future<void> fetchData(roomId) async {
    final stream = chatMessageRepository.getAllChatMessages(roomId);
    final streamSubscription = stream.listen(
      (chatMessageList) {
        state = chatMessageList;
      },
    );
    ref.onDispose(
      () {
        streamSubscription.cancel();
      },
    );
  }

  // 채팅방 생성
  Future<void> handleCreateMessage(roomId, content, senderId) async {
    await chatMessageRepository.createMessage(roomId, content, senderId);
  }
}

final chatViewModel = NotifierProvider.autoDispose
    .family<ChatViewModel, List<ChatMessage>, String>(
  () => ChatViewModel(),
);
