import 'package:dongne_chat/ui/pages/dongne_list/widgets/category_list.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/dongne_list_item.dart';
import 'package:dongne_chat/ui/widgets/bottom_navigation.dart';
import 'package:dongne_chat/ui/widgets/create_chat_room_button.dart';
import 'package:flutter/material.dart';

class DongneListPage extends StatefulWidget {
  @override
  State<DongneListPage> createState() => _DongneListPageState();
}

class _DongneListPageState extends State<DongneListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          '용산동',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: GPS 갱신 기능 구현 필요
            },
            icon: Icon(Icons.gps_fixed),
            padding: EdgeInsets.only(bottom: 4),
          )
        ],
        forceMaterialTransparency: true, // 화면 스크롤시 앱바 색상 바뀌는 현상 방지
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.only(bottom: 12),
                child: CategoryList(),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 50,
                  itemBuilder: (context, index) => DongneListItem(),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                ),
              ),
            ],
          ),
        ),
      ),
      // TODO: 채팅이 없을 경우 처리
      // body: Center(child: Text('모임을 만들어볼까요?')),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: CreateChatRoomButton(),
    );
  }
}
