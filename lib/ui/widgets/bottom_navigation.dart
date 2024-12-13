import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  /// 바텀 네비게이션 바
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    // TODO: 페이지 전환 기능 구현 필요
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble_fill),
          label: 'CHAT',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'MYPAGE',
        ),
      ],
    );
  }
}
