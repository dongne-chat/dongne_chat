import 'package:dongne_chat/core/geolocator_helper.dart';
import 'package:dongne_chat/data/repository/location_repository.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/category_list.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/dongne_list_item.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/dongne_list_view_model.dart';
import 'package:dongne_chat/ui/pages/dongne_list/dongne_list_view_model.dart';
import 'package:dongne_chat/ui/widgets/create_chat_room_button.dart';
import 'package:dongne_chat/ui/widgets/user_global_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DongneListPage extends StatefulWidget {
  @override
  State<DongneListPage> createState() => _DongneListPageState();
}

class _DongneListPageState extends State<DongneListPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    getPosition();
  }

  Future<void> _loadUserId() async {
    final id = await loadUserId();
    setState(() {
      userId = id;
    });
  }

  String selectedCategory = '전체'; // 기본값 '전체'
  String myLocation = '';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void getPosition() async {
    final position = await GeolocatorHelper.getPosition();
    final name = await LocationRepository()
        .findByLatLng(position!.latitude, position.longitude);

    setState(() {
      myLocation = name!.split(' ').last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            myLocation,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: getPosition,
            icon: Icon(Icons.gps_fixed),
            padding: EdgeInsets.only(bottom: 4, right: 8),
          )
        ],
        forceMaterialTransparency: true, // 화면 스크롤시 앱바 색상 바뀌는 현상 방지
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final chatRooms = ref.watch(dongneListViewModel);

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
                  chatRooms == null || chatRooms.isEmpty
                      ? Expanded(child: Center(child: Text('모임을 만들어볼까요?')))
                      : Expanded(
                          child: ListView.separated(
                            itemCount: filteredChatRooms.length,
                            itemBuilder: (context, index) {
                              final chatRoom = filteredChatRooms[index];
                              return DongneListItem(
                                  roomId: chatRoom.roomId,
                                  title: chatRoom.title,
                                  info: chatRoom.info,
                                  category: chatRoom.category,
                                  createdAt: chatRoom.createdAt,
                                  userId: userId);
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
      ),
      floatingActionButton: CreateChatRoomButton(userId: userId),
    );
  }
}
