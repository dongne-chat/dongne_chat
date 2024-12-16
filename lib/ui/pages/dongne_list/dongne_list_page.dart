import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongne_chat/data/model/chat_room.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/category_list.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/dongne_list_item.dart';
import 'package:dongne_chat/ui/pages/tap/bottom_navigation.dart';
import 'package:dongne_chat/ui/widgets/create_chat_room_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// firebase로 chatRooms 컬렉션에서 모든 채팅방 데이터 실시간으로 불러오기
final allChatRoomsProvider = StreamProvider<List<ChatRoom>>((ref) {
  return FirebaseFirestore.instance
      .collection('chatRooms')
      .orderBy('createdAt', descending: true) // 내림차순 정렬
      .snapshots() // 실시간을  데터 가져오기
      .map((snapshot) {
    return snapshot.docs.map((doc) => ChatRoom.fromJson(doc)).toList();
  });
});

class DongneListPage extends StatefulWidget {
  @override
  State<DongneListPage> createState() => _DongneListPageState();
}

class _DongneListPageState extends State<DongneListPage> {
  String selectedCategory = '전체'; // 기본값 '전체'

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final chatRoomsAsyncValue = ref.watch(allChatRoomsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '용산동',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: GPS 갱신 기능 구현 필요
            },
            icon: Icon(Icons.gps_fixed),
            padding: EdgeInsets.only(bottom: 4, right: 8),
          )
        ],
        forceMaterialTransparency: true, // 화면 스크롤시 앱바 색상 바뀌는 현상 방지
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final chatRoomsAsyncValue = ref.watch(allChatRoomsProvider);

          return chatRoomsAsyncValue.when(
            data: (chatRooms) {
              // 채팅방 데이터가 없는 경우
              if (chatRooms.isEmpty) {
                return Center(
                  child: Text('모임을 만들어볼까요?'),
                );
              }

              // 선택된 카테고리에 맞는 채팅방 필터링
              final filteredChatRooms = selectedCategory == '전체'
                  ? chatRooms
                  : chatRooms
                      .where((room) => room.category == selectedCategory)
                      .toList();

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(bottom: 20),
                        child: CategoryList(onCategorySelected: updateCategory),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: filteredChatRooms.length,
                          itemBuilder: (context, index) {
                            final chatRoom = filteredChatRooms[index];
                            return DongneListItem(
                                roomId: chatRoom.roomId,
                                title: chatRoom.title,
                                info: chatRoom.info,
                                category: chatRoom.category,
                                createdAt: chatRoom.createdAt);
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('오류가 발생했습니다: $err')),
          );
        },
      ),
      floatingActionButton: CreateChatRoomButton(),
    );
  }
}
