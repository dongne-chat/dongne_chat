import 'package:dongne_chat/core/geolocator_helper.dart';
import 'package:dongne_chat/ui/pages/create_chat/create_chat_view_model.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/category_list.dart';
import 'package:dongne_chat/ui/pages/dongne_list/widgets/dongne_list_item.dart';
import 'package:dongne_chat/ui/widgets/bottom_navigation.dart';
import 'package:dongne_chat/ui/widgets/create_chat_room_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DongneListPage extends StatefulWidget {
  @override
  State<DongneListPage> createState() => _DongneListPageState();
}

class _DongneListPageState extends State<DongneListPage> {
  String _location = "위치를 받아오는 중...";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    // 위치 권한 요청
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스가 활성화 되어있는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _location = "위치 서비스가 비활성화되어 있습니다.";
      });
      return;
    }

    // 위치 권한 요청
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _location = "위치 권한이 거부되었습니다.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _location = "위치 권한이 영구적으로 거부되었습니다.";
      });
      return;
    }

    // 위치 정보 가져오기
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = "위도: ${position.latitude}, 경도: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_location);

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
