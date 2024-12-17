import 'package:dongne_chat/data/model/chat_room.dart';
import 'package:dongne_chat/data/repository/dongne_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DongneListViewModel extends StateNotifier<List<ChatRoom>?> {
  DongneListViewModel() : super([]);

  Future<void> getAll({
    required String address,
    required String? category,
  }) async {
    final chatRooms = await DongneListRepository()
        .getAll(address: address, category: category);
    state = chatRooms;
  }
}

final dongneListViewProvider =
    StateNotifierProvider<DongneListViewModel, List<ChatRoom>?>(
        (ref) => DongneListViewModel());
