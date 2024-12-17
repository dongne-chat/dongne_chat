import 'package:dongne_chat/data/model/chat_room.dart';
import 'package:dongne_chat/data/repository/dongne_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DongneListViewModel extends Notifier<List<ChatRoom>> {
  @override
  List<ChatRoom> build() {
    fetchData();
    return [];
  }

  final dongneListRepository = DongneListRepository();

  // 채팅름 목록 가져오기
  Future<void> fetchData() async {
    final stream = dongneListRepository.getAllChatRooms();
    final streamSubscription = stream.listen(
      (chatRoomList) {
        state = chatRoomList;
      },
    );
    ref.onDispose(
      () {
        streamSubscription.cancel();
      },
    );
  }

  // 채팅룸 생성
  Future<void> handleCreateChatRoom(
      title, info, category, userId, addressName) async {
    await dongneListRepository.createChatRoom(
        title, info, category, userId, addressName);
  }

  // 채팅방 입장 시 user_id 저장
  Future<void> handleInsertUserId(roomId, userId) async {
    await dongneListRepository.insertUserId(roomId, userId);
  }
}

final dongneListViewModel =
    NotifierProvider<DongneListViewModel, List<ChatRoom>>(
  () => DongneListViewModel(),
);
