import 'package:dongne_chat/data/model/chat_message_with_user.dart';
import 'package:dongne_chat/data/model/user.dart';
import 'package:dongne_chat/data/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatViewModel
    extends AutoDisposeFamilyNotifier<List<ChatMessageWithUser>, String> {
  final chatMessageRepository = ChatRepository();

  // users 데이터를 관리하기 위한 상태 추가
  Map<String, User>? users;

  @override
  List<ChatMessageWithUser> build(String arg) {
    fetchUsers(arg).then((_) {
      fetchData(arg);
    });
    return [];
  }

  // 채팅방 메세지 가져오기
  Future<void> fetchData(roomId) async {
    final stream = chatMessageRepository.getAllChatMessages(roomId);
    final streamSubscription = stream.listen(
      (chatMessageList) {
        // 유저 정보와 메시지를 결합
        final chatMessagesWithUserData = chatMessageList.map((chatMessage) {
          final user =
              users?[chatMessage.senderId]; // 메시지의 senderId로 유저 정보 가져오기
          if (user != null) {
            // 유저 정보가 있으면 메시지에 결합하여 리턴
            return ChatMessageWithUser(
              chatMessage: chatMessage,
              user: user,
            );
          } else {
            return ChatMessageWithUser(
              chatMessage: chatMessage,
              user: null,
            );
          }
        }).toList();

        state = chatMessagesWithUserData; // 상태 업데이트
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

  // 채팅방 참여 유저 데이터 가져오기
  Future<void> fetchUsers(String roomId) async {
    try {
      // 참여 유저 ID 가져오기
      final chatUsers = await chatMessageRepository.fetchUsersArray(roomId);
      if (chatUsers == null) return;

      // 참여 유저 정보 가져오기
      final usersData = await chatMessageRepository.fetchUsersData(chatUsers);

      if (usersData != null) {
        users = usersData; // users 상태 업데이트
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  // 채팅방 메시지와 유저 정보를 결합할 수 있는 새로운 클래스 생성
  List<ChatMessageWithUser> get chatMessagesWithUser => state;
}

final chatViewModel = NotifierProvider.autoDispose
    .family<ChatViewModel, List<ChatMessageWithUser>, String>(
  () => ChatViewModel(),
);
